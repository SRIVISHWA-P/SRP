import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class MissingPersonPage extends StatefulWidget {
  @override
  _MissingPersonPageState createState() => _MissingPersonPageState();
}

class _MissingPersonPageState extends State<MissingPersonPage> {
  String? _name;
  int? _age;
  String? _gender;
  String? _lastContact;
  String? _relationship;
  String? _address;
  String? _complaintContact;
  String? _reportedBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Missing Person'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _age = int.tryParse(value);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Gender'),
              onChanged: (value) {
                _gender = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Contact'),
              onChanged: (value) {
                _lastContact = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Relationship with the Person'),
              onChanged: (value) {
                _relationship = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                _address = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Complaint Contact'),
              onChanged: (value) {
                _complaintContact = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Reported By'),
              onChanged: (value) {
                _reportedBy = value;
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

  void _validateAndSubmit() {
    // Validate form fields
    if (_name == null ||
        _name!.isEmpty ||
        _age == null ||
        _age! <= 0 ||
        _gender == null ||
        _gender!.isEmpty ||
        _lastContact == null ||
        _lastContact!.isEmpty ||
        _relationship == null ||
        _relationship!.isEmpty ||
        _address == null ||
        _address!.isEmpty ||
        _complaintContact == null ||
        _complaintContact!.isEmpty ||
        _reportedBy == null ||
        _reportedBy!.isEmpty) {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields.'),
      ));
    } else {
      // Submit form
      _storeReport();
    }
  }

  void _storeReport() async {
    try {
      // Store report in Firestore with the complaint contact as document ID
      await FirebaseFirestore.instance
          .collection('missing_persons')
          .doc(_complaintContact)
          .set({
        'name': _name,
        'age': _age,
        'gender': _gender,
        'last_contact': _lastContact,
        'relationship': _relationship,
        'address': _address,
        'complaint_contact': _complaintContact,
        'reported_by': _reportedBy,
        'reported_at': DateTime
            .now(), // Optionally, store the timestamp when the report was made
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Missing person report submitted successfully.'),
      ));

      // Clear all the fields after submitting
      setState(() {
        _name = '';
        _age = null;
        _gender = '';
        _lastContact = '';
        _relationship = '';
        _address = '';
        _complaintContact = '';
        _reportedBy = '';
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
    }
  }
}
