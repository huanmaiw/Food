class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categoriesList = [
  Category(
    title: "Nổi bật",
    image: "images/category/icon1.jpg",
  ),
  Category(
    title: "Combo",
    image: "images/category/icon2.jpg",
  ),
  Category(
    title: "Sale off",
    image: "images/category/icon3.jpg",
  ),
  Category(
    title: "Ăn nhanh",
    image: "images/category/icon4.jpg",
  ),
  Category(
    title: "Đồ uống",
    image: "images/category/icon5.jpg",
  ),
];