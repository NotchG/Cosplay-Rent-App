import 'package:cosplayrentapp/components/loading_widget.dart';
import 'package:cosplayrentapp/model/data/catalogue_class.dart';
import 'package:cosplayrentapp/model/services/mock_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productID;
  const ProductDetailsPage({super.key, required this.productID});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

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
      body: FutureBuilder(
        future: MockApiService().getCatalogueByID(widget.productID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (snapshot.hasData) {
            return ProductDetailsBody(data: snapshot.data!);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class ProductDetailsBody extends StatefulWidget {
  final Catalogue data;
  const ProductDetailsBody({super.key, required this.data});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> with SingleTickerProviderStateMixin {

  late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  bool postLiked = false;

  void likePost() {
    setState(() {
      postLiked = !postLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 3/7,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data.imgUrl),
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.data.itemName}",
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
                      Row(
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
                                      "${NumberFormat.compact().format(widget.data.itemLikes)}"
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      context.push("/profile/${widget.data.sellerID}");
                    },
                    child: Container(
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
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Achmed Fidel Ghibran",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
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
                                    text: "${widget.data.itemPrice}",
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
                                    text: "${widget.data.itemRating}",
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        indicatorPadding: EdgeInsets.only(left: 0, right: 8),
                        tabAlignment: TabAlignment.start,
                        controller: tabController,
                        tabs: const [
                          Tab(text: "Description",),
                          Tab(text: "Measurements",),
                          Tab(text: "Location",)
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras quis tortor elementum, lobortis sapien ut, varius lectus. Pellentesque sodales porttitor erat sit amet dapibus. Suspendisse enim leo, congue sed blandit quis, viverra at dui. Sed suscipit, dui eu blandit semper, magna neque vehicula tellus, id semper ipsum nulla vel enim. Sed non interdum dui. Curabitur auctor eros massa, sit amet placerat mauris scelerisque vel. Duis id tincidunt metus. Pellentesque in efficitur urna. Phasellus id leo et ipsum convallis porttitor eget eget nibh. Quisque eget rhoncus enim. Proin enim nisi, tempus vitae lectus et, porta rutrum mauris. Nulla viverra ut mauris et porttitor. "),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bust: ${widget.data.measurements.bust}"),
                                  Text("Waist: ${widget.data.measurements.waist}"),
                                  Text("Hips: ${widget.data.measurements.hips}")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Location Body"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

