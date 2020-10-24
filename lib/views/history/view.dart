import 'package:ex/const.dart';
import 'package:ex/widget/custom_app_bar.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black12,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.delete),
          tooltip: "Delete All",
        ),
        appBar: customAppBar(context, "history"),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 10),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2, color: subAccentColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("You Like Mohamed Salah Post"),),
                  CustomSizedBox(wedNum: 0.02, heiNum: 0.0),
                  Image.network(
                    "https://miro.medium.com/max/900/0*y9cQ_dWewYp5hhuw.png",
                    width: 100,
                  )
                ],
              ),
            );
          },
          itemCount: 8,
        ),
      ),
    );
  }
}
