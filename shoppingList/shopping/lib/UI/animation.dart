import 'package:flutter/material.dart';

class AnimatedSnackbar extends StatefulWidget {
  @override
  _AnimatedSnackbarState createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();

    // Auto-dismiss Snackbar after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 2), () {
          _animationController.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FadeTransition(
          opacity: _animation,
          child: Text('Animated Snackbar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Snackbar Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showSnackbar,
          child: Text('Show Snackbar'),
        ),
      ),
    );
  }
}
