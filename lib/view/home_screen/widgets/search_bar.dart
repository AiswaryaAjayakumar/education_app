import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Search",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Icon(Icons.tune, size: 22, color: Colors.grey.shade700),
        ],
      ),
    );
  }
}
