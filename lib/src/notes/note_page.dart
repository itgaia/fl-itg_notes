import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  static const routeName = '/note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
