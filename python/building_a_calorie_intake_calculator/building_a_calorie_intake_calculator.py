"""
 Column        | Description                                             |
|---------------|---------------------------------------------------------|
| `food` | The name of the food.                                   |
| `calories`  | The amount of energy provided by the food, measured in kilocalories (kcal) per 100 grams. |
| `total_fat` | The total fat content in grams per 100 grams.                         |
| `protein`   | The protein content in grams per 100 grams.                           |
| `carbohydrate` | The total carbohydrate content in grams per 100 grams.             |
| `sugars`    | The amount of sugars in grams per 100 grams.                          |

Enhance the Diet Coach app by creating the nutritional_summary() function to calculate and return the total nutritional values from the nutrition_dict dataset.

Function Output:
-If all the foods are present in the dataset, the function returns a dictionary with keys: "calories", "total_fat", "protein", "carbohydrate", "sugars".
-If any food is missing from the dataset, the function returns the name of the first missing item.

Input Format:
-Dictionary: For example, calling nutritional_summary({"Croissants, cheese": 150, "Orange juice, raw": 250}) should output {'calories': 733.5, 'total_fat': 32.0, 'protein': 15.55, 'carbohydrate': 96.5, 'sugars': 38.025} Here, 150 and 250 represent the grams of each food.
-Handling non-existent keys: For example, calling nutritional_summary({"Croissant": 150, "Orange juice": 250}) should output "Croissant".


Requirements:





"""

import json  # Import the json module to work with JSON files
# Open the nutrition.json file in read mode and load its content into a dictionary

with open('nutrition.json', 'r') as json_file:
    nutrition_dict = json.load(json_file)  # Load the JSON content into a dictionary
    
# Display the first 3 items of the nutrition dictionary
print(list(nutrition_dict.items())[:3])
