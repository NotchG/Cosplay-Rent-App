import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../MockData/Catalogue.dart';

class CatalogueCard extends StatefulWidget {
  final CatalogueData data;
  const CatalogueCard({super.key, required this.data});

  @override
  State<CatalogueCard> createState() => _CatalogueCardState();
}

class _CatalogueCardState extends State<CatalogueCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/product/${widget.data.uid}");
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC2C2C2)),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.data.imgUrl),
                  fit: BoxFit.cover
                ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
            Padding(
                padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Price\n",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w200,
                            fontSize: 10,
                            color: Color(0xff989898)
                        ),
                        children: [
                          TextSpan(
                            text: "${widget.data.itemPrice}",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black87
                            ),
                          ),
                          TextSpan(
                            text: " IDR",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Color(0xff989898)
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Rating\n",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w200,
                            fontSize: 10,
                            color: Color(0xff989898)
                        ),
                        children: [
                          TextSpan(
                            text: "${widget.data.itemRating}",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.black87
                            ),
                          ),
                          TextSpan(
                            text: "/5",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Color(0xff989898)
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
