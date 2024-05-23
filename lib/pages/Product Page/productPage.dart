import 'dart:convert';

import 'package:cosplayrentapp/MockData/Catalogue.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parallax_sensors_bg/parallax_sensors_bg.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ProductPage extends StatefulWidget {
  final MockDatabase data;
  final String? productID;
  const ProductPage({super.key, this.productID, required this.data});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  CatalogueData data= CatalogueData.none();
  bool postLiked = false;


  @override
  void initState() {
    CatalogueData? x = widget.data.queryByID(widget.productID ?? "");
    if (x == null) {
      context.pop();
    } else {
      data = x;
    }

    super.initState();
  }

  void likePost() {
    setState(() {
      postLiked = !postLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent
                  ),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent
                  ),
                  child: Center(
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 3/7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imgUrl),
                    fit: BoxFit.cover
                  )
                ),

              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(0xffD9D9D9).withOpacity(0.3)
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xffEAEAEA),
                  ),
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${data.itemName}",
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Posted on Nov XX, YYYY",
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w300
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              likePost();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: postLiked ? Colors.redAccent : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${NumberFormat.compact().format(data.itemLikes)}"
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      ProfilePicture(
                          name: "Achmed Fidel",
                          radius: 15,
                          fontsize: 7
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Achmed Fidel Ghibran",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: "Price\n",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 15,
                                  color: Color(0xff989898)
                              ),
                              children: [
                                TextSpan(
                                  text: "${data.itemPrice}",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                      color: Colors.black87
                                  ),
                                ),
                                TextSpan(
                                  text: " IDR",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xff989898)
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: "Rating\n",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 15,
                                  color: Color(0xff989898)
                              ),
                              children: [
                                TextSpan(
                                  text: "${data.itemRating}",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24,
                                      color: Colors.black87
                                  ),
                                ),
                                TextSpan(
                                  text: "/5",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xff989898)
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
