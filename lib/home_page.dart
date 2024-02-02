import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/cart.dart';
import 'package:firebase_ui/widget/colors.dart';
import 'package:firebase_ui/widget/produnt_card.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? userName;
  final _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!; //
  List<ItemModel> products = [];
  double total = 2065.14;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    // Hardcoded JSON data with image URLs
    String jsonData = '''
    [
      {"price": "249.50", "title": "SONY Premium Headphones", "model": "Model: WH-1000XM4, Black", "imageUrl": "assets/images/Rectangle 28.png"},
      {"price": "129.00", "title": "SONY Wireless Headphones", "model": "Model: WH-1000XM4, Beige", "imageUrl": "assets/images/Rectangle 30.png"},
      {"price": "349.99", "title": "Lenovo Laptop", "model": "Model: LH-200MX5, Grey", "imageUrl": "assets/images/image 12.png"},
      {"price": "1250.99", "title": "SONY TV", "model": "Model: WH-1000XM4, Beige", "imageUrl": "assets/images/image 9.png"}
      
    ]
  ''';

    // Decode JSON data
    List<Map<String, dynamic>> jsonDataList = List<Map<String, dynamic>>.from(jsonDecode(jsonData));

    // Map the JSON data to ItemModel instances
    products = jsonDataList.map((data) => ItemModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: _currentIndex == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(currentUser.email)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final userData = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    return Text(
                                      'Hello ' + userData['username'],
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error${snapshot.error}'),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                            Container(
                              height: 25,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await _auth.signOut();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    // Background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const SizedBox(
                                      width: 40,
                                      child: Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                          'Log out',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0),
                                        ),
                                      )))),
                            ),
                          ],
                        ),
                      ),
                    ),
                     GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 325,
                         // childAspectRatio: (10.0),
                          mainAxisSpacing: 0.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Expanded(
                                child: ProductCard(
                                  imagePath: products[index].imageUrl!,
                                  title: products[index].title!,
                                  description: products[index].model!,
                                  price: '\$'+products[index].price!,
                                  onPressed: () {
                                    // Add to cart logic
                                    print('${products[index].title} added to cart');
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "My Cart",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: products.map((product) {
                        return MyCard(
                          imagePath: product.imageUrl!,
                          price: '\$'+product.price!,
                          title: product.title!,
                          description: product.model!,
                          onUpdateTotal: (newTotal) {
                            setState(() {
                              total = newTotal;
                            });
                          },
                          onPressed: () {},
                        );
                      }).toList(),
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [Text("Total amount:"),

                             Text(
                               '\$${total.toStringAsFixed(2)}',
                               style: TextStyle(fontSize: 16.0),
                             ),
                           ],
                         ),
                        )),
                    const SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: Text(
                              'CHECK OUT',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),

                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
