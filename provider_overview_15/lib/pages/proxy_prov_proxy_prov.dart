// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Translations {
  const Translations(this._value);
  final int _value;

  String get title => 'You clicked $_value times';
}

class ProxyProvProxyProv extends StatefulWidget {
  const ProxyProvProxyProv({super.key});

  @override
  State<ProxyProvProxyProv> createState() => _ProxyProvProxyProv();
}

class _ProxyProvProxyProv extends State<ProxyProvProxyProv> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
      print('counter: $counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why Proxy Provider'),
      ),
      body: Center(
        child: Provider<Translations>(
          create: (_) => Translations(counter),
          child: MultiProvider(
            providers: [
              ProxyProvider0<int>(
                update: (_, __) => counter,
              ),
              ProxyProvider<int, Translations>(
                update: (_, value, __) => Translations(value),
              ),
            ],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ShowTranslations(),
                const SizedBox(height: 20.0),
                IncreaseButton(increment: increment),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowTranslations extends StatelessWidget {
  const ShowTranslations({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Provider.of<Translations>(context).title;

    return Text(
      title,
      style: const TextStyle(fontSize: 28.0),
    );
  }
}

class IncreaseButton extends StatelessWidget {
  final VoidCallback increment;

  const IncreaseButton({
    Key? key,
    required this.increment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: increment,
      child: const Text(
        'INCREASE',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
