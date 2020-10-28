import 'dart:ui';
import 'dart:io';
import 'package:ex/services/store.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:ex/const.dart';
import 'package:ex/provider/user_data.dart';
import 'package:ex/widget/register_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePhoto extends StatefulWidget {
  static String name;

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  String photo, localId;
  File _image;
  bool _loading = false;
  String _uploadedFileURL;
  TextEditingController controller =
      TextEditingController(text: ProfilePhoto.name);

  Future chooseAndUploadFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        _loading = true;
      });
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$localId/userProfiles/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async {
      setState(() {
        _uploadedFileURL = fileURL;
      });
      Store().editProfile(localId, {kUserPhoto: fileURL});
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('photo', _uploadedFileURL);
      setState(() {
        _loading = false;
      });
    });
  }

  getUserPhoto() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      photo = sharedPreferences.getString('photo');
      localId = sharedPreferences.getString('localId');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            width: customWidth(context, 1),
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Loading, your profile photo is uploading")
              ],
            ),
          )
        : Stack(
            children: [
              Container(
                width: customWidth(context, 1),
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(_uploadedFileURL == null
                      ? "$photo"
                      : "$_uploadedFileURL"),
                  fit: BoxFit.cover,
                )),
              ),
              BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: customWidth(context, 1),
                  height: 220,
                  color: Colors.transparent,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(_uploadedFileURL == null
                                  ? "$photo"
                                  : "$_uploadedFileURL"),
                              fit: BoxFit.cover)),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primaryColor),
                          child: IconButton(
                            icon: Icon(Icons.photo_camera_outlined),
                            onPressed: () {
                              chooseAndUploadFile();
                            },
                            iconSize: 16,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                    RegisterTextField(
                        controller: controller,
                        onSaved: (val) {
                          Provider.of<UserData>(context, listen: false)
                              .changeUserName(val);
                        },
                        tittle: "name",
                        hintTittle: "example: Mohamed Nasr")
                  ],
                ),
              )
            ],
          );
  }
}
