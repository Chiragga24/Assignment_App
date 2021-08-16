import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'movies.dart';

class MovieDialog extends StatefulWidget {
  final Movies? movie;
  final Function(String title, String director, String imagePath) onClickedDone;

  const MovieDialog({
    Key? key,
    this.movie,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _MovieDialogState createState() => _MovieDialogState();
}

class _MovieDialogState extends State<MovieDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final directorController = TextEditingController();

  File? image;
  String? path;
  Future getImage() async{
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if(image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.path = image.path;
      this.image = imageTemporary;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      final movie = widget.movie!;

      titleController.text = movie.title;
      directorController.text = movie.director;
      path = movie.imagePath;
      image = File(path!);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    directorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.movie != null;
    final title = isEditing ? 'Edit Movie' : 'Add Movie';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDirector(),
              SizedBox(height: 8),
              buildImage()
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }
  Widget buildImage() => SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height/100 * 20,
    child: image != null?
    GestureDetector(
        onTap: () => getImage(),
        child: Image.file(image!)):
    OutlinedButton(
        onPressed: () => getImage(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined),
            Text(
              ' Add a Photo',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.height/100 * 2.5),
            ),
          ],
        )),
  );
  Widget buildName() => TextFormField(
    controller: titleController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Movie Title',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter Movie Title' : null,
  );

  Widget buildDirector() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Movie Director',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter Movie Director' : null,
    controller: directorController,
  );


  Widget buildCancelButton(BuildContext context) => TextButton(
    child: Text('Cancel'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = titleController.text;
          final director = directorController.text;
          var imagePath = "";
          if(image != null){
            imagePath = path!;
          }


          widget.onClickedDone(name, director, imagePath);

          Navigator.of(context).pop();
        }
      },
    );
  }
}