class Product {
  final String title;
  final String description;
  final List< String> image;
  final double price;
  final String category;
  int quantity;
  Product(
      {
        required this.title,
        required this.description,
        required this.image,
        required this.price,
        required this.category,
        this.quantity = 1,
      });
}

final List<Product> hot = [
  Product(
    title: "Rựa mận",
    description:
    "1 trong những siêu phẩm cầy tơ 7 món ",
    image:[
      "images/hot/ruaman.jpg",
      "images/hot/ruaman1.jpg",
      "images/hot/ruaman2.jpg",

    ],

    price: 250000,
    category: "nổi bật",
  ),
  Product(
    title: "Thịt chó hấp",
    description:
    "Món thứ 2 trong combo cầy tơ 7 món, cực hấp dẫn",
    price: 500000,
    image:[
      "images/hot/thitluoc.jpg"
    ],
    category: "nổi bật",
  ),
  Product(
    title: "Dồi nướng",
    description:
    "Siêu phẩm thứ 3 trong dàn cầy tơ 7 món",
    price: 250000,
    image:[
      "images/hot/doinuong.jpg"
    ],
    category: "nổi bật",
  ),
  Product(
    title: "Thịt chó nướng",
    description:
    "Siêu phẩm thứ 4 trong dàn cầy tơ 7 món",
    price: 500000,
    image:[
      "images/hot/thitnuong.jpg"
    ],
    category: "nổi bật",
  ),
  Product(
    title: "Lòng hấp",
    description:
    "Siêu phẩm thứ 5 trong dàn cầy tơ 7 món",
    image:[
      "images/hot/longhap.jpg"
    ],
    price: 100000,
    category: "nổi bật",
  ),
  Product(
    title: "Xáo măng",
    description:
    "Siêu phẩm thứ 6 trong dàn cầy tơ 7 món",
    image:[
      "images/hot/xaomang.jpg"
    ],
    price: 350000,
    category: "nổi bật",
  ),
  Product(
    title: "Lẩu chó",
    description:"1 trong những biến thể của xáo măng",
    image:[
      "images/hot/laucho.jpg"
    ],
    price: 350000,
    category: "nổi bật",
  ),
];
final List<Product> pick = [
  Product(
    title: "Combo 79k",
    description:
    "Mì + Cà phê chỉ 79k",
    image:[
      "images/cb/cb1.jpg",
    ],
    price: 79000,
    category: "cb",
  ),
  Product(
    title: "Combo Pepsi",
    description:
    "Giảm ngay 50% khi mua 2 lon pepsi",
    image:[
      "images/cb/cb2.jpg",
    ],
    price: 100000,
    category: "cb",
  ),Product(
    title: "Combo 99k",
    description:
    "Chỉ với 99k có ngay combo siêu hời",
    image:[
      "images/cb/cb3.jpg",
    ],
    price: 99000,
    category: "cb",
  ),
  Product(
    title: "Combo CoCaCola",
    description:
    "Giảm ngay 50% khi mua 2 lon CoCaCola",
    image:[
      "images/cb/cb4.jpg",
    ],
    price: 100000,
    category: "cb",
  ),
];
final List<Product> reg = [
  Product(
    title: "Thịt bò úc",
    description:
    "Siêu ngon và bổ dưỡng, thích hợp cho các bữa tiệc",
    image:[
      "images/sale/sale1.jpg",
    ],
    price: 50000,
    category: "sale",
  ),
  Product(
    title: "Thịt gà ta",
    description:
    "Gà ăn thóc 100%, nói không với gà công nghiệp",
    image:[
      "images/sale/sale2.jpg",
    ],
    price: 70000,
    category: "sale",
  ),
  Product(
    title: "Chim câu",
    description:
    "Chim câu cực con, chuẩn chim câu hoang dã",
    image:[
      "images/sale/sale3.jpg",
    ],
    price: 80000,
    category: "sale",
  ),
  Product(
    title: "Cá hồi nhật bản",
    description:
    "Nhập khẩu từ nhật bản, giá đắt xắt ra miếng",
    image:[
      "images/sale/sale4.jpg",
    ],
    price: 200000,
    category: "sale",
  ),
];
final List<Product> random1 = [

  Product(
    title: "Hamberger",
    description:
    "Hamberger siêu phẩm đến từ MC Donal" ,
    image:[
      "images/fastfodd/ff1.jpg",
    ],
    price: 40000,
    category: "ff1",
  ),
  Product(
    title: "Gà rán KFC",
    description:
    "Chuẩn 100% KFC siêu ngon thượng hạng" ,
    image:[
      "images/fastfodd/ff2.jpg",
    ],
    price: 130000,
    category: "ff",
  ),


];
final List<Product> random2 = [
  Product(
    title: "Trà sữa chân trâu",
    description:
    "Úi, ngon cực",
    image:[
      "images/drink/drink1.jpg",
    ],
    price: 25000,
    category: "drink",
  ),
  Product(
    title: "Trà chanh",
    description:
    "Những lát chanh tươi ngon , mát lạnh",
    image:[
      "images/drink/drink2.jpg",
    ],
    price: 10000,
    category: "drink",
  ),
  Product(
    title: "CoCa CoLa",
    description:
    "Chuẩn nhà coca cho ai fan Mpape",
    image:[
      "images/drink/drink3.jpg",
    ],
    price: 15000,
    category: "drink",
  ),
  Product(
    title: "Pepsi",
    description:
    "One champion pepsi, hội người ghét coca",
    image:[
      "images/drink/drink4.jpg",
    ],
    price: 15000,
    category: "drink",
  ),
];
