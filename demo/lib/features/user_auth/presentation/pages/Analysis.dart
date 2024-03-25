import 'package:flutter/material.dart';
import 'home_page.dart';

class Analysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Disaster Analysis'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDisaster(
              year: '2004',
              title: 'Tamil Nadu’s 2004 Tsunami',
              image: 'assets/2004_1.jpg',
              content: [
                'The 2004 Tsunami was triggered by a 9.0 magnitude earthquake off the coast of Sumatra on December 26, 2004.',
                'It caused destruction and loss of lives in Indonesia, Thailand, Sri Lanka, India, and Somalia.',
                'Around 8000 people died and 470000 people were displaced in Tamil Nadu, the worst-hit state in India.',
                'The damages included destruction of houses, businesses, fishing equipment, agricultural land, and transportation infrastructure.'
              ],
            ),
            _buildDisaster(
              year: '2015',
              title: 'Chennai floods, December 2015',
              image: 'assets/2015_2.jpg',
              content: [
                'Heavy rainfall pounded Chennai on December 1, 2015, flooding and submerging the city.',
                'The highest observed daily rainfall was 494 mm, an extreme occurrence that overwhelmed flood prevention measures.',
                'More than three million people were affected, roads and bridges collapsed, and air and train travel were halted.',
                'No effect of human-induced climate change was detected in the extreme one-day rainfall event.'
              ],
            ),
            _buildDisaster(
              year: '2023',
              title: 'Michaung Cyclone',
              image: 'assets/2023_1.jpg',
              content: [
                'Michaung was the fourth tropical cyclone of the year over the Bay of Bengal.',
                'It developed over the west central Bay of Bengal on December 3 and made landfall near Bapatla on December 5.',
                'The cyclone had a maximum sustained wind speed of 90-100 kmph and caused heavy rainfall warnings in coastal Andhra Pradesh, Telangana, Odisha, Chhattisgarh, and north coastal Tamil Nadu.',
                'Gale wind speeds reaching 90-100 kmph were observed, along with exceptionally heavy rainfall likely over coastal Andhra Pradesh and central districts of coastal Andhra Pradesh.'
              ],
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

  Widget _buildDisaster({
    required String year,
    required String title,
    required String image,
    required List<String> content,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            year,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content
                .map(
                  (line) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('- $line'),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
