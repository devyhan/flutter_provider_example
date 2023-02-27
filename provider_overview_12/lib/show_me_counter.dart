import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';

class ShowMeCounter extends StatelessWidget {
  const ShowMeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text(
          context.watch<Counter>().counter.toString(),
          style: const TextStyle(fontSize: 52.0),
        ),
      ),
    );
  }
}
