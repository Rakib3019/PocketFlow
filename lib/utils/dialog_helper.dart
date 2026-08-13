import 'package:flutter/material.dart';

Future<void> showMessageDialog(
    BuildContext context, {
      required String title,
      required String message,
      required Color color,
      required IconData icon,
    }) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}