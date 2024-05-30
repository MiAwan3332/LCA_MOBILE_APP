import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lca_app/services/student_services.dart';
import '../../services/seminar_services.dart';
import 'package:image_picker/image_picker.dart';

class StudentInfoFormScreen extends StatefulWidget {
  const StudentInfoFormScreen({Key? key}) : super(key: key);
  @override
  _StudentInfoFormScreenState createState() => _StudentInfoFormScreenState();
}

class _StudentInfoFormScreenState extends State<StudentInfoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherPhoneController = TextEditingController();
  final TextEditingController _latestDegreeController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _completionYearController = TextEditingController();
  final TextEditingController _marksCgpaController = TextEditingController();
  final Student _student = Student();

  File? _image;
  File? _cnicImage;
  File? _cnicBack;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _pickCnicImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _cnicImage = File(image.path);
      });
    }
  }

  Future<void> _pickCnicBackImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _cnicBack = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Seminar Registration Form',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color(0xFFBA8E4F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _cnicController,
                  decoration: InputDecoration(
                    labelText: 'CNIC',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CNIC';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Date of Birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _fatherNameController,
                  decoration: InputDecoration(
                    labelText: 'Father Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your father name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _fatherPhoneController,
                  decoration: InputDecoration(
                    labelText: 'Father Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your father phone';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _latestDegreeController,
                  decoration: InputDecoration(
                    labelText: 'Latest Degree',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your latest degree';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _universityController,
                  decoration: InputDecoration(
                    labelText: 'University ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your university';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _completionYearController,
                  decoration: InputDecoration(
                    labelText: 'Completion Year',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your completion year';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _marksCgpaController,
                  decoration: InputDecoration(
                    labelText: 'Marks/ CGPA',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your marks/cgpa';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _image == null
                    ? Text("No image selected.")
                    : Image.file(_image!, height: 250,width: MediaQuery.of(context).size.width,),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text("Select Image"),
                ),
                SizedBox(height: 20),
                _cnicImage == null
                    ? Text("No image selected.")
                    : Image.file(_cnicImage!, height: 250,width: MediaQuery.of(context).size.width,),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickCnicImage,
                  child: Text("Select CNIC Front"),
                ),
                SizedBox(height: 20),
                _cnicBack == null
                    ? Text("No image selected.")
                    : Image.file(_cnicBack!, height: 250,width: MediaQuery.of(context).size.width,),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickCnicBackImage,
                  child: Text("Select CNIC Back"),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // print(widget.seminarId);
                        _student.submitStudentInfo(_cnicController.text, _cityController.text, _dateOfBirthController.text, _fatherNameController.text, _fatherPhoneController.text, _latestDegreeController.text, _universityController.text, _completionYearController.text, _marksCgpaController.text, _image!, _cnicImage!, _cnicBack!, context);
                        // if (_formKey.currentState?.validate() ?? false) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text('Form submitted successfully')),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFBA8E4F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
