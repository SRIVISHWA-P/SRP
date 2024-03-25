import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Guidelines.dart';
import 'Missing_person.dart';
import 'RequestFormPage.dart'; // Import RequestFormPage
import 'HelplinePage.dart';
import 'Analysis.dart';
// Import HelplinePage

class HomePage extends StatefulWidget {
  final String? username;
  final String? contact;

  const HomePage({Key? key, this.username, this.contact}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _username = ''; // Initialize with default value
  late String _contact = ''; // Initialize with default value

  @override
  void initState() {
    super.initState();
    _getUserData(); // Fetch user data when the page initializes
  }

  Future<void> _getUserData() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      // Retrieve user data from Firestore
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .get();

      // Update state with retrieved values
      setState(() {
        _username = userData['name'];
        _contact = userData['mobile'];
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Change app bar color to green
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _username ??
                        'Loading...', // Display 'Loading...' until data is fetched
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _contact ??
                        'Loading...', // Display 'Loading...' until data is fetched
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Navigate to about page
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
                Fluttertoast.showToast(msg: 'Logged out successfully');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            buildGridItem(Icons.accessibility, 'Request'),
            buildGridItem(Icons.volunteer_activism, 'Donate'),
            buildGridItem(Icons.safety_divider, 'Safety Camps'),
            buildGridItem(Icons.phone, 'Helpline Numbers'),
            buildGridItem(Icons.checklist, 'Do and Don\'ts'),
            buildGridItem(Icons.assessment, 'Past Disaster Analysis'),
            buildGridItem(Icons.cloud, 'Live Weather Forecast'),
            buildGridItem(Icons.person_search, 'Missing Persons'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
      ),
    );
  }

  Widget buildGridItem(IconData icon, String label) {
    return Card(
      child: InkWell(
        onTap: () {
          // Handle grid item tap
          if (label == 'Request') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RequestFormPage()),
            );
          } else if (label == 'Helpline Numbers') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelplinePage()),
            );
          } else if (label == 'Do and Don\'ts') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuidelinesPage()),
            );
          } else if (label == 'Past Disaster Analysis') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Analysis()),
            );
          } else if (label == 'Missing Persons') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MissingPersonPage()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
