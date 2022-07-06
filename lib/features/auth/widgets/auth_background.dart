import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _RedBox(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: Icon(Icons.person_pin, color: Colors.grey[200], size: 100),
      ),
    );
  }
}

class _RedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.45,
      decoration: _redBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble()),
          Positioned(child: _Bubble(), top: 100, left: 100),
          Positioned(child: _Bubble(), top: 150, left: 300),
          Positioned(child: _Bubble(), top: 30, left: 220),
          Positioned(child: _Bubble(), top: 200),
        ],
      ),
    );
  }

  BoxDecoration _redBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(139, 0, 0, 1),
          Color.fromRGBO(128, 0, 0, 1),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 0, 0, 0.20),
      ),
    );
  }
}
