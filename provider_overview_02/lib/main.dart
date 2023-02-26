import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Dog(
        name: 'Sun',
        breed: 'Bulldog',
        age: 3,
      ),
      child: MaterialApp(
        title: 'Provider 02',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 02'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${Provider.of<Dog>(context).name} name',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed: ${Provider.of<Dog>(context).breed} breed',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${Provider.of<Dog>(context).age} age',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => Provider.of<Dog>(context, listen: false).grow(),
          child: const Text(
            'Grow',
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
