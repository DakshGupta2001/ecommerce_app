class ProductsModel {
  static const BRAND = "Brand";
  static const COLOUR = "Colour";
  static const DESCRIPTION = "Description";
  static const ID = "Id";
  static const NAME = "Name";
  static const PRICE = "Price";
  static const URL = "Url";

  // ignore: non_constant_identifier_names
  late String Brand;
  late String Colour;
  late String Description;
  late String Id;
  late String Name;
  late String Price;
  late String Url;

  
  ProductsModel({
    required this.Brand,
    required this.Colour,
    required this.Description,
    required this.Name,
    required this.Price,
    required this.Url,
  });
  
  ProductsModel.fromMap(Map<String, dynamic> data) {
    Name = data[NAME];
    Brand = data[BRAND];
    Url = data[URL];
    Colour = data[COLOUR];
    Description = data[DESCRIPTION];
    Id = data[ID];
    Price = data[PRICE];
  }
}
