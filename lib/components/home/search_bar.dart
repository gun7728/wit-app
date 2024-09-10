import 'package:flutter/material.dart';

class MainSearchBar extends StatelessWidget {
  const MainSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Find things to do',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ),
    );
  }
}
