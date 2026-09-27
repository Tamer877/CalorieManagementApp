# 🥗 Calorie Management App

A Flutter mobile application that helps users track their daily calorie and macro nutrient intake based on their personal fitness goals.

---

## 📱 Features

- **User Authentication** – Register and login with email/password via Firebase Auth
- **Password Reset** – Forgot password email flow
- **User Profile** – Enter personal info (name, age, height, weight, gender, goal) to calculate Basal Metabolic Rate (BMR)
- **Home Screen** – Displays daily calorie and macro targets based on the user's goal
- **Nutrition Search** – Search any food item and get calorie/macro info via CalorieNinjas API
- **Daily History** – Track daily food consumption, view pie charts per food item, and get color-coded feedback on whether targets are met
- **Help Screen** – Explanation of how BMR and macros are calculated with examples

---

## 🧮 How Targets Are Calculated

The app uses the **Mifflin-St Jeor Equation** to calculate BMR:

- **Male:** `BMR = 88.362 + (13.397 × weight) + (4.799 × height) − (5.677 × age)`
- **Female:** `BMR = 447.593 + (9.247 × weight) + (3.098 × height) − (4.330 × age)`

### Gain Weight
| Macro | Target |
|-------|--------|
| Calories | BMR + 500 kcal |
| Protein | Weight (kg) × 2 g |
| Fat | Max 20% of calories |
| Carbs | Remaining calories |

### Lose Weight
| Macro | Target |
|-------|--------|
| Calories | BMR kcal |
| Protein | Weight (kg) × 2 g |
| Fat | Max 10% of calories |
| Carbs | Remaining calories |

---

## 🛠️ Tech Stack

- **Flutter** – UI framework
- **Firebase Auth** – User authentication
- **Cloud Firestore** – User data and history storage
- **CalorieNinjas API** – Nutrition data
- **fl_chart** – Pie chart visualizations
- **icons_plus** – Icon pack

---

## 📂 Project Structure

```
lib/
├── Models/
│   └── Nutrition.dart         # Nutrition data model
├── Screens/
│   ├── WelcomeScreen.dart
│   ├── LoginScreen.dart
│   ├── SignUpScreen.dart
│   ├── ForgotPasswordScreen.dart
│   ├── UserInformationScreen.dart
│   ├── HomeScreen.dart
│   ├── ProfileScreen.dart
│   ├── NutritionSearchScreen.dart
│   ├── HistoryScreen.dart
│   └── HelpScreen.dart
├── Widgets/
│   ├── CustomScaffold.dart
│   ├── CustomScaffold2.dart
│   ├── CustomContainer.dart
│   ├── Drawer.dart
│   ├── PieChart.dart
│   └── WelcomeButton.dart
└── main.dart
```

---

## ⚠️ Notes

- `firebase_options.dart` is excluded from version control. You must generate it yourself using `flutterfire configure`.
- The CalorieNinjas API key is embedded in the source code — consider moving it to an environment variable for production use.
