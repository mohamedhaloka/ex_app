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

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  String password, displayName, idToken, photoUrl, email, statue, statueDes;
  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;
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
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Container(
      decoration: bgDecoration,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Scaffold(
                backgroundColor: Colors.black26,
                appBar: customAppBar(context, "Edit Profile"),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Transform(
                          transform: Matrix4.translationValues(
                              0, animation.value * customWidth(context, 1), 0),
                          child: ProfilePhoto()),
                      Transform(
                        transform: Matrix4.translationValues(
                            0,
                            delayedAnimation.value * customWidth(context, 1),
                            0),
                        child: Padding(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
                        ),
                      )
                    ],
                  ),
                ),
              )),
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
