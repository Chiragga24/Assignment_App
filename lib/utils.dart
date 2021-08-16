import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static File? _image;
  static imgFromGallery() async {
    PickedFile? image = await ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    _image = File(image!.path);
  }
  static void triggerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      context: context,
      isScrollControlled: true,
      builder: (context) => Wrap(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 100 * 5,
                top: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height / 100 * 3
                    : MediaQuery.of(context).size.height / 100 * 8,
                right: MediaQuery.of(context).size.width / 100 * 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add New Movie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 100 * 3.5,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 3,
                  ),
                  // if(_image == Null)
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: OutlinedButton(
                          onPressed: () => imgFromGallery(),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add_a_photo_outlined),
                                Text(
                                  '  Add Image',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              2.5),
                                ),
                              ],
                            ),
                          )),
                    ),
                  // if(_image != Null)
                  //   SizedBox(
                  //     width: double.infinity,
                  //     height: MediaQuery.of(context).size.height * 0.2,
                  //     child: Image.file(
                  //       _image!,
                  //       width: 100,
                  //       height: 100,
                  //       fit: BoxFit.fitHeight,
                  //     ),
                  //   ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(hintText: "Add Movie Title"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100 * 5,
                        ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: "Add Movie Director"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height / 100 * 1.7),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white70,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 100 * 20,
                              vertical:
                                  MediaQuery.of(context).size.height / 100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void triggerEditBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      context: context,
      isScrollControlled: true,
      builder: (context) => Wrap(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 100 * 5,
                top: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).size.height / 100 * 3
                    : MediaQuery.of(context).size.height / 100 * 8,
                right: MediaQuery.of(context).size.width / 100 * 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add New Movie",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 100 * 3.5,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 3,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_a_photo_outlined),
                              Text(
                                '  Add Image',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            100 *
                                            2.5),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(hintText: "Add Movie Title"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100 * 5,
                        ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: "Add Movie Director"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100 * 5,
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height / 100 * 1.7),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white70,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 100 * 20,
                              vertical:
                                  MediaQuery.of(context).size.height / 100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
