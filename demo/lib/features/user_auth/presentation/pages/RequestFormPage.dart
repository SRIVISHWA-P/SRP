import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class RequestFormPage extends StatefulWidget {
  @override
  _RequestFormPageState createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  String? _selectedHelp;
  int? _quantity;
  String? _name;
  String? _mobileNumber;
  String? _address;
  String? _foodType;
  String? _medicineType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Form'),
        backgroundColor: Colors.lightGreenAccent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
                onChanged: (value) {
                  _mobileNumber = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (value) {
                  _address = value;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedHelp,
                hint: Text('Select Help Needed'),
                items: [
                  'Food',
                  'Medicines',
                  'Clothes',
                  'Sanitary Products',
                  'Baby Products',
                  'Boat and Rescue',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedHelp = newValue;
                  });
                  if (newValue != null &&
                      (newValue == 'Food' || newValue == 'Medicines')) {
                    _showTypeDialog(newValue);
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate and submit form
                  _validateAndSubmit();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: 'Danger',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation bar item tap
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }

  void _showTypeDialog(String selectedHelp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedHelp == 'Food' ? 'Food Type' : 'Medicine Type'),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Enter Type',
            ),
            onChanged: (value) {
              setState(() {
                if (selectedHelp == 'Food') {
                  _foodType = value;
                } else {
                  _medicineType = value;
                }
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showQuantityDialog(selectedHelp);
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _showQuantityDialog(String selectedHelp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quantity Required'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter Quantity',
            ),
            onChanged: (value) {
              _quantity = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_quantity != null && _quantity! > 0) {
                  _storeRequest(selectedHelp);
                  Navigator.of(context).pop();
                } else {
                  // Show error message if quantity is not valid
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a valid quantity.'),
                  ));
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _storeRequest(String selectedHelp) async {
    try {
      // Generate document ID using the mobile number
      String documentId = _mobileNumber ?? '';

      // Store request in Firestore with the generated document ID
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(documentId)
          .set({
        'help_needed': selectedHelp,
        'quantity_required': _quantity,
        'name': _name,
        'mobile_number': _mobileNumber,
        'address': _address,
        if (selectedHelp == 'Food') 'food_type': _foodType,
        if (selectedHelp == 'Medicines') 'medicine_type': _medicineType,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Request submitted successfully.'),
      ));

      // Clear all the fields after submitting
      setState(() {
        _selectedHelp = null;
        _quantity = null;
        _name = null;
        _mobileNumber = null;
        _address = null;
        _foodType = null;
        _medicineType = null;
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
    }
  }

  void _validateAndSubmit() {
    // Validate form fields
    if (_selectedHelp == null ||
        _quantity == null ||
        _name == null ||
        _name!.isEmpty ||
        _mobileNumber == null ||
        _mobileNumber!.isEmpty ||
        _address == null ||
        _address!.isEmpty) {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields.'),
      ));
    } else {
      // Submit form
      if (_selectedHelp != 'Food' && _selectedHelp != 'Medicines') {
        _storeRequest(_selectedHelp!);
      } else {
        if ((_selectedHelp == 'Food' &&
                _foodType != null &&
                _foodType!.isNotEmpty) ||
            (_selectedHelp == 'Medicines' &&
                _medicineType != null &&
                _medicineType!.isNotEmpty)) {
          _storeRequest(_selectedHelp!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Please specify the type of ${_selectedHelp == 'Food' ? 'food' : 'medicine'}.'),
          ));
        }
      }
    }
  }
}
