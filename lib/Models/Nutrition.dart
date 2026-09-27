class Nutrition {
  final String name;
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrates;

  Nutrition(this.name,this.calories,this.protein,this.fat,this.carbohydrates);

  factory Nutrition.fromJson(Map<String,dynamic> json){
    return Nutrition(json['name'],json['calories'],json['protein_g'],json['fat_total_g'],json['carbohydrates_total_g']);
  }
}
