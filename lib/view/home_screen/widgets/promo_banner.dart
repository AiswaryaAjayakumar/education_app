import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFA066FF),
            Color(0xFF6C46FF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
  
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // FIX OVERFLOW
              children: [
                const SizedBox(height: 6),
              ],
            ),
          ),


          Image.asset(
            "asset/edu.avif",
            height: 120,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
