import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whos_the_imposter/core/configs/assets/app_vectors.dart';
import 'package:whos_the_imposter/wrapper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.black),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.black, end: Colors.red),
          weight: 1.0,
        ),
      ],
    ).animate(_controller);
    redirect();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return SvgPicture.asset(
              AppVectors.clearImposter,
              colorFilter: ColorFilter.mode(
                _colorAnimation.value ?? Colors.red,
                BlendMode.srcIn,
              ),
              width: 200,
              height: 200,
            );
          },
        ),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Wrapper(),
        ));
  }
}
