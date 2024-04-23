import SwiftUI

struct SearchView: View {
    @AppStorage("isDarkMode") private var darkMode = false
    
    @State private var selectedFilter: String = ""
    @State private var isSheetPresented = false
    @State private var searchQuery: String = ""
    @State private var searchedMeals: [Meal] = []
    
    @ObservedObject private var viewModel = ViewModel()

    
    var body: some View 
    {
        NavigationStack
        {
            HStack
            {
                Picker("Filter", selection: $selectedFilter)
                {
                    Image(systemName: "globe").tag("Area")
                    Image(systemName: "rectangle.3.group.bubble").tag("Category")
                    Image(systemName: "carrot.fill").tag("Ingredients")
                    Image(systemName: "magnifyingglass").tag("Search")
                }
                .pickerStyle(.segmented)
                .padding()
                /*
                .onChange(of: selectedFilter)
                {
                    isSheetPresented.toggle()
                }
                 */
                
                Button
                {
                    isSheetPresented.toggle()
                }
                label:
                {
                  Image(systemName: "magnifyingglass")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.leading, .trailing])
            
            VStack
            {
                
                if !searchedMeals.isEmpty 
                {
                    SearchViewRow(searchQuery: $searchQuery, searchedMeals: $searchedMeals, mealDb: MealDb(title: ""))
                } else 
                {
                    Text("Ingen resultater funnet for \(searchQuery)")
                }
                                    
                Spacer()
                
                .sheet(isPresented: $isSheetPresented) 
                {
                    switch selectedFilter 
                    {
                    case "Area":
                        SearchArea(meals: $searchedMeals)
                    case "Category":
                        SearchCategory(meals: $searchedMeals)
                        /*
                        SearchCategory(categories: $searchedMeals, searchQuery: $searchQuery)
                            .onDisappear
                            {
                                Task
                                {
                                    searchedMeals = await viewModel.getCategories(searchQuery: searchQuery)
                                }
                            }
                         */
                    case "Ingredients":
                        SearchIngredient(meals: $searchedMeals)
                    case "Search":
                        SearchMealView(searchQuery: $searchQuery, meals: $searchedMeals)
                    default:
                        EmptyView()
                    }
                }
                .onTapGesture 
                {
                       isSheetPresented = false
                }
            }
            .navigationTitle("Søk")
        }
    }
}
#Preview {
    SearchView()
}
