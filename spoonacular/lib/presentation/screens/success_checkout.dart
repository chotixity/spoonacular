import 'package:flutter/material.dart';

class SuccessCheckout extends StatefulWidget {
  const SuccessCheckout({super.key});

  @override
  State<SuccessCheckout> createState() => _SuccessCheckoutState();
}

class _SuccessCheckoutState extends State<SuccessCheckout>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Thank you for Shopping with Us',
              style: TextStyle(fontSize: 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: const Icon(
                Icons.check_circle_outlined,
                size: 120,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
