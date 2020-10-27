import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex/models/about_app.dart';
import 'package:ex/widget/containerIcon.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../../widget/custom_app_bar.dart';

class AboutAppView extends StatelessWidget {
  AboutAppView({@required this.doc});
  int doc;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        appBar: customAppBar(context, "About ex"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 35,
              right: 35,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ContainerIcon(),
                CustomSizedBox(wedNum: 0.0, heiNum: 0.02),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('about app')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AboutApp> aboutApp = [];
                        for (var doc in snapshot.data.docs) {
                          var data = doc.data();
                          aboutApp.add(AboutApp(text: data['text']));
                        }
                        return SelectableText(doc == 0
                            ? "${aboutApp[0].text}"
                            : doc == 1
                                ? "${aboutApp[1].text}"
                                : "${aboutApp[2].text}");
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
