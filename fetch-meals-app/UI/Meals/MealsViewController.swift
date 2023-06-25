//
//  MealsViewController.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/23/23.
//

import UIKit

class MealsViewController: UIViewController {
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 36)
        label.text = "Fetch Desserts"
        
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let cellReuseIdentifier = "cell"
    private lazy var dataSource = makeDataSource()
    
    var meals = [MealViewModel]() {
        didSet {
            update(sectionData: meals)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveMeals("dessert")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MealsViewController: UITableViewDelegate {
    
    enum Section: CaseIterable {
        case Meals
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealViewModel = meals[indexPath.row]
        let mealDetailVC = MealDetailViewController()
        mealDetailVC.mealViewModel = mealViewModel
        navigationController?.pushViewController(mealDetailVC, animated: true)
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MealViewModel> {
        let reuseIdentifier = cellReuseIdentifier
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, mealViewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MealTableViewCell else {
                    return nil
                }
                cell.setup(mealViewModel)
                return cell
            })
    }
    
    func update(sectionData: [MealViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MealViewModel>()
        snapshot.appendSections([.Meals])
        snapshot.appendItems(sectionData, toSection: .Meals)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension MealsViewController {
    
    func retrieveMeals(_ type: String) {
        Task {
            let mealsResponse = await MealService.retrieveMeals(type)
            switch mealsResponse {
            case .success(let mealsResponse):
                let mealViewModels = toViewModel(mealsResponse)
                meals = mealViewModels
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    private func toViewModel(_ mealsResponse: MealsResponse) -> [MealViewModel] {
        return mealsResponse.meals.map { toViewModel($0) }
    }
    
    private func toViewModel(_ meal: Meal) -> MealViewModel {
        return MealViewModel(mealId: meal.idMeal, mealName: meal.strMeal, thumbnailUrl: meal.strMealThumb)
    }
    
}
