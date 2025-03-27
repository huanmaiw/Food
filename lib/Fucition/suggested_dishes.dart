import 'package:flutter/material.dart';

class SuggestedDishes extends StatefulWidget {
  const SuggestedDishes({super.key});

  @override
  State<SuggestedDishes> createState() => _SuggestedDishesState();
}

class _SuggestedDishesState extends State<SuggestedDishes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Gợi ý món ăn",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),

          // Lưới món ăn
          GridView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        "images/Suggest/dish${index + 1}.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Món ăn ${index + 1}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "Giá: ${(index + 1) * 10}k",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
