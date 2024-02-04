import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_ui/cart_model.dart';
import 'package:firebase_ui/widget/colors.dart';
import 'package:firebase_ui/widget/produnt_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  //double total = 2065.14;
  //int quantity = 1;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    String jsonData = '''
    [
      {"price": "249.50", "title": "SONY Premium Headphones", "model": "Model: WH-1000XM4, Black", "imageUrl": "assets/images/Rectangle 28.png","quantity":0},
      {"price": "129.00", "title": "SONY Wireless Headphones", "model": "Model: WH-1000XM4, Beige", "imageUrl": "assets/images/Rectangle 30.png","quantity":0},
      {"price": "349.99", "title": "Lenovo Laptop", "model": "Model: LH-200MX5, Grey", "imageUrl": "assets/images/image 12.png","quantity":0},
      {"price": "1250.99", "title": "SONY TV", "model": "Model: WH-1000XM4, Beige", "imageUrl": "assets/images/image 9.png","quantity":0}
      
    ]
  ''';

    // Decode JSON data
    List<Map<String, dynamic>> jsonDataList =
        List<Map<String, dynamic>>.from(jsonDecode(jsonData));

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
                                      style: const TextStyle(
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
                                            builder: (context) =>
                                                const SignUp()));
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
                    Consumer<CartModel>(builder: (context, value, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 320,
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
                                  price: '\$${products[index].price!}',
                                  onPressed: () {
                                     // setState(() {
                                     //   int currentValue =
                                     //       int.parse(value.cartItems[index].quantity as String);
                                     //   value.cartItems[index].quantity =
                                     //      (currentValue + 1).toString() as int?;
                                     // });
                                    Provider.of<CartModel>(context,
                                            listen: false)
                                        .addItemsToCart(products[index]);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
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
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Consumer<CartModel>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, index) {
                            //int quantity = value.cartItems[index].quantity;
                            return Container(
                              height: 100,
                              child: Container(
                                child: ListTile(
                                  horizontalTitleGap: 0.0,
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    width: 100,
                                    child: Image.asset(
                                      value.cartItems[index].imageUrl
                                          .toString(),
                                      height:
                                          100, // Adjust the height as needed
                                      width:
                                          100, // Adjust the width as needed
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(
                                      '\$${value.cartItems[index].price}',
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.cartItems[index].title
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      Text(
                                        value.cartItems[index].model
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    width: 85,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          child: InkWell(
                                            child: const Icon(Icons.remove,
                                                size: 15),
                                            onTap: () {
                                              Provider.of<CartModel>(context, listen: false)
                                                  .decrementItem(index);
                                            },
                                          ),
                                        ),
                                        Text(
                                          value.cartItems[index].quantity
                                              .toString(),
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: InkWell(
                                            child: const Icon(Icons.add,
                                                size: 15),
                                            onTap: () {
                                              Provider.of<CartModel>(context, listen: false)
                                                  .incrementItem(index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 200),
                    Consumer<CartModel>(builder: (context, value, child) {
                      return Container(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total amount:"),
                            Text(
                              '\$${value.calculateTotal().toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ));
                    }),
                    const SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: const Text(
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
