import 'package:flutter/material.dart';
import 'package:lca_app/services/generic_services.dart';
import '../../services/seminar_services.dart';

class SeminarFormScreen extends StatefulWidget {
  final String seminarId;
  const SeminarFormScreen({Key? key, required this.seminarId})
      : super(key: key);
  @override
  _SeminarFormScreenState createState() => _SeminarFormScreenState();
}

class _SeminarFormScreenState extends State<SeminarFormScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final Seminar _seminar = Seminar();
  GenericServices _genericServices = GenericServices();

  bool _cssSeminar = false;
  bool _pmsSeminar = false;
  bool _trialClasses = false;
  bool _allOfAbove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seminar Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFormField(
                //   controller: _emailController,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                //     border: OutlineInputBorder(),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your email';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact No',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _qualificationController,
                  decoration: InputDecoration(
                    labelText: 'Qualification',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your qualification';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'You Will Attend',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                CheckboxListTile(
                  title: Text('CSS Seminar'),
                  value: _cssSeminar,
                  onChanged: (bool? value) {
                    setState(() {
                      _cssSeminar = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('PMS Seminar'),
                  value: _pmsSeminar,
                  onChanged: (bool? value) {
                    setState(() {
                      _pmsSeminar = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Trial Classes'),
                  value: _trialClasses,
                  onChanged: (bool? value) {
                    setState(() {
                      _trialClasses = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('All of Above'),
                  value: _allOfAbove,
                  onChanged: (bool? value) {
                    setState(() {
                      _allOfAbove = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isEmpty) {
                          _genericServices.showCustomToast(
                              'Name should not be empty', Colors.red);
                          return;
                        } else if (_contactController.text.isEmpty) {
                          _genericServices.showCustomToast(
                              'Contact no. should not be empty', Colors.red);
                        } else {
                          List<String> selectedSeminars = [];
                          if (_allOfAbove) {
                            selectedSeminars.addAll([
                              'CSS Seminar',
                              'PMS Seminar',
                              'Trial Classes'
                            ]);
                          } else {
                            if (_cssSeminar)
                              selectedSeminars.add('CSS Seminar');
                            if (_pmsSeminar)
                              selectedSeminars.add('PMS Seminar');
                            if (_trialClasses)
                              selectedSeminars.add('Trial Classes');
                          }
                          _seminar.addUserToSeminar(
                              _nameController.text,
                              _contactController.text,
                              _cityController.text,
                              widget.seminarId,
                              _qualificationController.text,
                              context,
                              selectedSeminars);
                          _nameController.clear();
                          _contactController.clear();
                          _cityController.clear();
                          _qualificationController.clear();
                          setState(() {
                            _cssSeminar = false;
                            _pmsSeminar = false;
                            _trialClasses = false;
                            _allOfAbove = false;
                          });
                        }

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
