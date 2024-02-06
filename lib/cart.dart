// // import 'package:flutter/material.dart';
// // import 'widget/colors.dart';



// // class MyCard extends StatefulWidget {
// //   final String imagePath;
// //   final String title;
// //   final String description;
// //   final String price;
// //   final VoidCallback onPressed;
// //   final Function(double) onUpdateTotal;

// //   const MyCard({
// //     required this.imagePath,
// //     required this.title,
// //     required this.description,
// //     required this.price,
// //     required this.onPressed,
// //     required this.onUpdateTotal,

// //   });


// //   @override
// //   _MyCardState createState() => _MyCardState();
// // }


// // class _MyCardState extends State<MyCard> {
// //   int quantity = 1;


// //   @override
// //   Widget build(BuildContext context) {

// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Container(
// //         height: 120, // Adjust the height as needed
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               height: 100,
// //               width: 100,
// //               child: Card(
// //                 elevation: 0,
// //                 color: Color(0xFFF5F5F5),
// //                 child: Container(
// //                   child: Image.asset(
// //                     widget.imagePath,
// //                     height: 100, // Adjust the height as needed
// //                     width: 100, // Adjust the width as needed
// //                     fit: BoxFit.scaleDown,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(width: 10), // Add spacing between image and details
// //             Expanded(
// //               child: Container(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       widget.price,
// //                       style: TextStyle(
// //                         fontSize: 17.0,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     Text(
// //                       widget.title,
// //                       style: TextStyle(
// //                         fontSize: 14.0,
// //                       ),
// //                     ),
// //                     Text(
// //                       widget.description,
// //                       style: TextStyle(fontSize: 11.0, color: Colors.grey),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             Container(
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Container(
// //                       decoration: BoxDecoration(
// //                         color: AppColors.whiteColor,
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       height: 25,
// //                       width: 25,
// //                       child: IconButton(
// //                         onPressed: () {
// //                           setState(() {
// //                             if (quantity > 1) {
// //                               quantity--;
// //                             }
// //                           });
// //                         },
// //                         icon: Icon(
// //                           Icons.remove,
// //                           size: 10.0,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 5),
// //                     Text(
// //                       quantity.toString(),
// //                       style: TextStyle(fontSize: 12.0),
// //                     ),
// //                     const SizedBox(width: 5),
// //                     Container(
// //                       decoration: BoxDecoration(
// //                         color: AppColors.primaryColor,
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                       height: 25,
// //                       width: 25,
// //                       child: IconButton(
// //                         onPressed: () {
// //                           setState(() {
// //                             quantity++;
// //                           });
// //                         },
// //                         icon: Icon(
// //                           Icons.add,
// //                           color: Colors.white,
// //                           size: 10.0,
// //                         ),
// //                       ),
// //                     ),

// //                   ],
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// IconButton(
//                                 onPressed: () {
//                                   Drawer(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         InkWell(
//                                           onTap: (){
//                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails()));
//                                           },
//                                           child: ListTile(
//                                             title: Text("User Details"),
//                                             leading: Icon(Icons.person_rounded),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 icon: Icon(Icons.dehaze_rounded)),