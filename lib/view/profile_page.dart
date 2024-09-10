import 'package:cosplayrentapp/model/services/mock_api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/loading_widget.dart';
import '../model/data/profile_class.dart';

class ProfilePage extends StatefulWidget {
  final String? profileID;
  final bool isSelf;
  const ProfilePage({super.key, this.profileID, this.isSelf = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String authUID = "3453kjh3k4534dfg983245";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.isSelf ? MockApiService().getProfileById(authUID) : MockApiService().getProfileById(widget.profileID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return InkWell(
              onTap: () {
                setState(() {});
              },
              child: Center(
                  child: Text("${snapshot.error}")
              ),
            );
          }

          if (snapshot.hasData) {
            return RenterProfileBody(
              data: snapshot.data!
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class RenterProfileBody extends StatelessWidget {
  final Profile data;

  const RenterProfileBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 2/7,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.bannerId),
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
            Positioned(
              top: MediaQuery.of(context).size.height * 2/7,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(100))
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

