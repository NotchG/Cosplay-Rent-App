import 'dart:convert';

import 'package:cosplayrentapp/MockData/Catalogue.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/CatalogueCard.dart';

class HomePage extends StatefulWidget {
  final MockDatabase data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CatalogueData> catalogues = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      catalogues = widget.data.mockCatalogues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xff242424),
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfilePicture(
                        name: "Achmed Fidel",
                        radius: 25,
                        fontsize: 15
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: "Curated ",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w200
                    ),
                    children: [
                      TextSpan(
                        text: "Characters",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ]
                  ),
                  ),
                RichText(
                  text: TextSpan(
                      text: "Rented ",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                      ),
                      children: [
                        TextSpan(
                          text: "Experiences",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w200
                          ),
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffC2C2C2)),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Balance\n",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w200,
                            fontSize: 12,
                            color: Color(0xff989898)
                          ),
                          children: [
                            TextSpan(
                            text: "25.000,00",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.black87
                            ),
                            ),
                            TextSpan(
                              text: " CP",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff989898)
                              ),
                            )
                          ]
                        ),
                      ),
                      TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Top Up",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: Color(0xff989898)
                            ),
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Our Catalogue",
                  style: GoogleFonts.inter(
                    fontSize: 20
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 265,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: catalogues.map((e) {
                      return Row(
                        children: [
                          CatalogueCard(
                            data: e,
                          ),
                          SizedBox(width: 20,)
                        ],
                      );
                    }).toList().cast(),
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

