---

# 🛒 Grocery Budgeting App

An iOS app designed to help users create grocery lists, select items, and generate budgeting plans based on their chosen price range. Users can manage multiple lists, view saved plans, and see detailed item breakdowns to help with grocery planning.

## 📱 Screens

1. **Home Screen**: Provides options to create a new list, view saved plans, and access previously created lists.
2. **Category Selection**: Allows users to select from various grocery categories such as Fruits, Vegetables, and Snacks.
3. **Item Selection**: Displays items within a selected category for users to add to their list.
4. **Basket View**: Shows all items selected by the user, allowing them to finalize and save the list.
5. **Budget Plan Generator**: Generates three plans based on a user's specified budget range and displays potential savings for each plan.
6. **Saved Plans**: Lists all previously saved budgeting plans with the ability to view details of each plan.

## 🚀 Features

- **Multi-Category Item Selection**: Users can browse through various categories and select items to add to their grocery list.
- **Budget Range Selection**: Users can specify a minimum and maximum budget range, and the app will generate plans within that range.
- **Plan Saving and Viewing**: Save generated budget plans for future reference, with an option to view item details within each plan.
- **List Management**: Easily create, view, and manage multiple grocery lists.
- **Dynamic Filtering**: Provides search functionality to quickly find items or categories.

## 🛠️ Installation

To run this project locally:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/grocery-budgeting-app.git
   cd grocery-budgeting-app
   ```

2. **Open with Xcode**:
   - Open `GroceryApp.xcodeproj` or `GroceryApp.xcworkspace` in Xcode.

3. **Build and Run**:
   - Select your target device or simulator and click **Run**.

## ⚙️ Usage

1. **Start the App**: Begin on the Home Screen, where you can either create a new list, view saved plans, or see previously created lists.
2. **Create a New List**: Select "New List" to choose a name and proceed to category selection.
3. **Select Items**: Browse items in different categories, and add your preferred items to your basket.
4. **View Basket**: Review all selected items in the basket. Finalize the list by selecting "Create."
5. **Set a Budget**: After creating a list, set a minimum and maximum budget range to generate budgeting plans.
6. **Choose and Save a Plan**: View generated plans within the specified range, select a plan, and save it for future reference.
7. **View Saved Plans**: Access saved plans from the Home Screen and view item details in each saved plan.

## 📂 Project Structure

```
├── ContentView.swift                 # Launch screen with app entry
├── Models
│   ├── FruitItem.swift               # Data model for grocery items
│   └── Plan.swift                    # Data model for budgeting plans
├── ViewModels
│   ├── BasketManager.swift           # Manages items in the user's basket and list creation
│   └── PlanManager.swift             # Handles plan generation and saving logic
├── Views
│   ├── HomeView.swift                # Main menu screen with navigation options
│   ├── ItemSelectionView.swift       # Category and item selection screen
│   ├── BasketSheetView.swift         # Basket review and finalization view
│   ├── Plans.swift                   # Budget plan generation screen
│   ├── SavedPlansView.swift          # List of saved budget plans
│   ├── PlanDetailView.swift          # Detail view for individual saved plans
│   └── BudgetEntrySheet.swift        # Modal for entering budget range
```

## 🧩 Requirements

- **iOS 14** or later
- **Xcode 12** or later
- **SwiftUI**

## 🔍 Troubleshooting

If you encounter any issues:
1. Ensure all assets, such as item images, are included in the Xcode asset catalog.
2. Check the console for any missing items or assets during runtime.
3. Verify navigation flows are working as expected; each screen should transition smoothly.

## 🤝 Contributing

Feel free to fork this project, submit issues, or create pull requests with improvements!

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

--- 
