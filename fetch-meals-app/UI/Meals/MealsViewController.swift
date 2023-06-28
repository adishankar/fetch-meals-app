//
//  MealsViewController.swift
//  fetch-meals-app
//
//  Created by Adi Shankar on 6/23/23.
//

import UIKit
import SwiftUI

class MealsViewController: UIViewController {
    
    var loaderView: UIView = {
        let hostingVC = UIHostingController(rootView: LoadingView())
        return hostingVC.view
    }()

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
    
    private let mealService = MealService()
    
    var meals = [MealViewModel]() {
        didSet {
            update(sectionData: meals)
        }
    }
    var mealImages = [String:UIImage]()
    
    var selectedMeal: MealDetailViewModel? {
        didSet {
            selectMeal()
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
    
    override func viewWillAppear(_ animated: Bool) {
        loaderView.isHidden = true
        selectedMeal = nil // reset this value on returning to this page
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (meals.isEmpty) {
            retrieveMeals("dessert")
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        NSLayoutConstraint.activate([
            loaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            headerLabel.topAnchor.constraint(equalTo: loaderView.bottomAnchor, constant: 5),
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
    
    private func selectMeal() {
        guard let selectedMeal else {
            return
        }
//        let mealDetailVC = MealDetailViewController()
//        mealDetailVC.mealDetailViewModel = selectedMeal
//        navigationController?.pushViewController(mealDetailVC, animated: true)
        let mealDetailView = MealDetailView(mealDetailViewModel: selectedMeal)
        let hostingVC = UIHostingController(rootView: mealDetailView)
        navigationController?.pushViewController(hostingVC, animated: true)
    }
}

extension MealsViewController: UITableViewDelegate {
    
    enum Section: CaseIterable {
        case Meals
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealViewModel = meals[indexPath.row]
        retrieveMealDetails(mealViewModel.mealId)
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, MealViewModel> {
        let reuseIdentifier = cellReuseIdentifier
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, mealViewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MealTableViewCell else {
                    return nil
                }
                cell.setup(mealViewModel, self.mealImages[mealViewModel.mealId])
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
        loaderView.isHidden = false
        Task {
            let mealsResponse = await mealService.retrieveMeals(type)
            switch mealsResponse {
            case .success(let mealsResponse):
                let mealViewModels = toViewModel(mealsResponse)
                do {
                    mealImages = try await loadImages(mealViewModels) // after getting all meals load images
                } catch(let error) {
                    debugPrint(error)
                }
                
                meals = mealViewModels
            case .failure(let error):
                debugPrint(error)
            }
            loaderView.isHidden = true
        }
    }
    
    func toViewModel(_ mealsResponse: MealsResponse) -> [MealViewModel] {
        guard let meals = mealsResponse.meals else {
            return []
        }
        return meals
            .map { toViewModel($0) }
            .sorted { $0.mealName < $1.mealName }
    }
    
    func toViewModel(_ meal: Meal) -> MealViewModel {
        return MealViewModel(mealId: meal.idMeal, mealName: meal.strMeal, thumbnailUrl: meal.strMealThumb)
    }
    
    func retrieveMealDetails(_ mealId: String) {
        Task {
            let mealDetailResponse = await mealService.retrieveMealDetail(mealId)
            switch mealDetailResponse {
            case .success(let mealDetailResponse):
                let mealDetailViewModel = toViewModel(mealDetailResponse)
                selectedMeal = mealDetailViewModel
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func toViewModel(_ mealDetailResponse: MealDetailResponse) -> MealDetailViewModel? {
        guard let meals = mealDetailResponse.meals, let mealDetail = meals.first else {
            return nil
        }
        
        // split tag field on ',' to list tags
        let tags: [String] = mealDetail.strTags?.components(separatedBy: ",") ?? []
        
        // split instruction field on '\r\n' characters to list instructions
        let instructions: [String] = mealDetail.strInstructions
            .components(separatedBy: "\r\n")
            .filter { !$0.isEmpty }
        
        // using corresponding strIngredientN and strMeasureN to build ingredient and measurement pairing
        var ingredients: [MealIngredientViewModel] = []
        var ingredientNames = Set<String>() // check for duplicate ingredients
        
        let mealDetailObject: AnyObject = mealDetail as NSObject
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measurementKey = "strMeasure\(i)"

            if let ingredientValue = mealDetailObject.value(forKey: ingredientKey) as? String, !ingredientValue.isEmpty, !ingredientNames.contains(ingredientValue) {
                let measurementString = mealDetailObject.value(forKey: measurementKey) as? String
                ingredientNames.insert(ingredientValue)
                ingredients.append(
                    MealIngredientViewModel(ingredientName: ingredientValue, ingredientMeasurement: measurementString)
                )
            }
        }
        
        return MealDetailViewModel(
            mealId: mealDetail.idMeal,
            mealName: mealDetail.strMeal,
            imageUrl: mealDetail.strImageSource ?? mealDetail.strMealThumb,
            videoUrl: mealDetail.strYoutube,
            sourceUrl: mealDetail.strSource,
            area: mealDetail.strArea,
            tags: tags,
            ingredients: ingredients,
            instructions: instructions)
    }
    
    func loadImage(_ urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        }
        catch (let error) {
            debugPrint(error)
            return nil
        }
    }
    
    func loadImages(_ meals: [MealViewModel]) async throws -> [String: UIImage] {
        try await withThrowingTaskGroup(of: (MealViewModel, UIImage?).self) { group in
            for meal in meals {
                group.addTask {
                    let image = await self.loadImage(meal.thumbnailUrl)
                    return (meal, image)
                }
            }
            var mealIdImageDictionary = [String : UIImage]()
            for try await (meal, image) in group {
                if let image = image {
                    mealIdImageDictionary[meal.mealId] = image
                }
            }
            return mealIdImageDictionary
        }
    }
    
}
