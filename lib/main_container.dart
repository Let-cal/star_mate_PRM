import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import './pages/FriendPage/friend_page.dart';
import './pages/HomePage/footer_home.dart';
import './pages/HomePage/home_page.dart';
import './pages/ProfilePage/profile_page.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _activeIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const FriendPage(),
    const ProfilePageWidget(),
  ];

  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _activeIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: _pages[_activeIndex],
      ),
      bottomNavigationBar: Footer(
        activeIndex: _activeIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
