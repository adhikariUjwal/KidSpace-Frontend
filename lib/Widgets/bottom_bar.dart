import 'package:flutter/material.dart';
import 'package:kidspace/Screens/MainScreens/audio_screen.dart';
import 'package:kidspace/Screens/MainScreens/home_screen.dart';
import 'package:kidspace/Screens/MainScreens/story_screen.dart';
import 'package:kidspace/Screens/MainScreens/video_screen.dart';

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({super.key});

  @override
  State<CustomButtomBar> createState() => _CustomButtomBarState();
}

class _CustomButtomBarState extends State<CustomButtomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buttomNavigationBar(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const Rhymes();
      case 2:
        return const AudioPage();
      case 3:
        return const StoryPage();
      default:
        return Container();
    }
  }

  Widget _buttomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.video_file), label: 'Video'),
        BottomNavigationBarItem(icon: Icon(Icons.audio_file), label: 'Audio'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Story'),
      ],
    );
  }
}
