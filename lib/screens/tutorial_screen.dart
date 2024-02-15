import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants/gaps.dart';
import 'package:flutter_tiktok_clone/constants/sizes.dart';
import 'package:flutter_tiktok_clone/screens/main_screen.dart';

enum Direction { right, left }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int _pageIndex = 0;
  Direction _direction = Direction.right;
  final List<Widget> _pages = [
    const TutorialPage(
      key: ValueKey(0),
      title: "Watch cool videos!",
      description: "Videos are personalized for you based on what you watch, like, and share.",
    ),
    const TutorialPage(
      key: ValueKey(1),
      title: "Follow the rules",
      description: "Videos are personalized for you based on what you watch, like, and share.",
    ),
    const TutorialPage(
      key: ValueKey(2),
      title: "Create your own videos",
      description: "Share your videos with friends and followers.",
    ),
  ];

  void _onPanUpdate(DragUpdateDetails details) {
    _direction = details.delta.dx > 0 ? Direction.right : Direction.left;
    setState(() {});
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left && _pageIndex < _pages.length - 1) {
      _pageIndex++;
      setState(() {});
    } else if (_direction == Direction.right && _pageIndex > 0) {
      _pageIndex--;
      setState(() {});
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_pageIndex],
            ),
          ),
        ),
        bottomNavigationBar: _pageIndex == _pages.length - 1
            ? BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size24,
                    horizontal: Sizes.size24,
                  ),
                  child: CupertinoButton(
                    onPressed: _onEnterAppTap,
                    color: Theme.of(context).primaryColor,
                    child: const Text('Enter the app!'),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  const TutorialPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v16,
        Text(
          description,
          style: const TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
