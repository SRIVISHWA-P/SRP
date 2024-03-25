import 'package:flutter/material.dart';
import 'home_page.dart';

class GuidelinesPage extends StatefulWidget {
  @override
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guidelines'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return ListView(
            padding: EdgeInsets.all(12.0),
            children: [
              Image.asset(
                'assets/guidelines_image.jpg',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'During Floods:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'Do:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildListItem(
                  'Follow government orders and move to safer locations.'),
              _buildListItem('Seek accurate information and avoid rumors.'),
              _buildListItem(
                  'Switch off electrical supply and avoid open wires.'),
              _buildListItem('Turn off electrical and gas appliances.'),
              _buildListItem(
                  'Carry an emergency kit and inform family of your whereabouts.'),
              _buildListItem(
                  'Avoid contact with floodwater and use a pole when walking in water.'),
              _buildListItem(
                  'Stay away from power lines and report downed lines.'),
              _buildListItem('Watch out for debris and slippery surfaces.'),
              _buildListItem('Listen to updates via radio or TV.'),
              SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'Don\'t:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildListItem('Don\'t walk or swim through flowing water.'),
              _buildListItem('Don\'t drive through flooded areas.'),
              _buildListItem('Don\'t consume food exposed to floodwater.'),
              _buildListItem(
                  'Don\'t reconnect power without professional inspection.'),
              _buildListItem(
                  'Avoid using electrical equipment on wet surfaces.'),
              _buildListItem('Don\'t attempt rapid removal of basement water.'),
              SizedBox(height: 20),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'During Earthquake:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'Do:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildListItem('- Drop, Cover, and Hold On.'),
              _buildListItem(
                  '- If indoors, stay there; if outdoors, find a clear spot away from buildings, trees, streetlights, and power lines.'),
              _buildListItem(
                  '- Know your safe spots, such as under a sturdy piece of furniture or against an interior wall.'),
              _buildListItem('- Have an earthquake emergency kit ready.'),
              _buildListItem(
                  '- Listen to updates via radio or TV for emergency information.'),
              _buildListItem(
                  '- Ensure your home is securely anchored to its foundation.'),
              _buildListItem(
                  '- Secure heavy furniture, appliances, and objects that might fall.'),
              _buildListItem(
                  '- Plan and practice your evacuation routes with your family.'),
              _buildListItem(
                  '- Know the location of utility shut-off valves and switches.'),
              _buildListItem(
                  '- Conduct drills with your family members for earthquake preparedness.'),
              SizedBox(height: 10),
              FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'Don\'t:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildListItem("- Don't use elevators."),
              _buildListItem("- Don't run outside."),
            ],
          );
        },
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

  Widget _buildListItem(String text) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(text),
      ),
    );
  }
}
