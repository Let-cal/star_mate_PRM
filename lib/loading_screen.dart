import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool isLoading;

  const LoadingScreen({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    return const Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
