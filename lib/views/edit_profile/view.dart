import 'package:ex/const.dart';
import 'package:ex/provider/user_data.dart';
import 'package:ex/views/edit_profile/edit_profile_controller.dart';
import 'package:ex/views/edit_profile/edit_profile_model.dart';
import 'package:ex/views/edit_profile/profile_photo.dart';
import 'package:ex/widget/custom_app_bar.dart';
import 'package:ex/widget/custom_sized_box.dart';
import 'package:ex/widget/register_button.dart';
import 'package:ex/widget/register_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String password, displayName, idToken, photoUrl, email, statue, statueDes;
  bool _loading = false;
  EditProfileModel editProfileModel = EditProfileModel();
  EditProfileController editProfileController = EditProfileController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController statueController = TextEditingController();

  getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      idToken = sharedPreferences.getString("idToken");
      print(idToken);
      displayName = sharedPreferences.getString("displayName");
      statue = sharedPreferences.getString("statue");
      email = sharedPreferences.getString("email");
      ProfilePhoto.name = displayName;
      statueController.text = statue;
    });
    print(idToken);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.black26,
        appBar: customAppBar(context, "Edit Profile"),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              ProfilePhoto(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    RegisterTextField(
                        onSaved: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        tittle: "email",
                        hintTittle: "example@example.com"),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
                    RegisterTextField(
                        onSaved: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        tittle: "password",
                        hintTittle: "***********"),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.03),
                    RegisterTextField(
                        controller: statueController,
                        onSaved: (val) {
                          setState(() {
                            statueDes = val;
                          });
                        },
                        tittle: "Statues",
                        hintTittle: "Busy, At school, Sleeping"),
                    CustomSizedBox(wedNum: 0.0, heiNum: 0.06),
                    RegisterButton(
                      function: () {
                        _editProfile(context);
                      },
                      border: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Done",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 20),
                          ),
                          _loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor),
                                  strokeWidth: 1,
                                )
                              : Icon(
                                  Icons.check,
                                  color: primaryColor,
                                )
                        ],
                      ),
                      fillColors: [accentColor, subAccentColor],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _editProfile(context) async {
    try {
      var userData = Provider.of<UserData>(context, listen: false);
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _loading = true;
        });
        editProfileModel = await editProfileController.editProfile(
            idToken,
            userData.userName,
            password,
            photoUrl,
            email,
            {kUserStatue: statueDes, kUserName: userData.userName},
            context,
            statueDes);

        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.black,
      ));
    }
    setState(() {
      _loading = false;
    });
  }
}
