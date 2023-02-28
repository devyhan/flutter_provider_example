// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class Translations with ChangeNotifier {
  late int _value;

  void update(Counter counter) {
    _value = counter.counter;
    notifyListeners();
  }

  String get title => 'You clicked $_value times';
}

class ChgNotiProvChgNotiProxyProv extends StatefulWidget {
  const ChgNotiProvChgNotiProxyProv({super.key});

  @override
  State<ChgNotiProvChgNotiProxyProv> createState() =>
      _ChgNotiProvChgNotiProxyProvState();
}

class _ChgNotiProvChgNotiProxyProvState
    extends State<ChgNotiProvChgNotiProxyProv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why Proxy Provider'),
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<Counter>(
              create: (_) => Counter(),
            ),
            ChangeNotifierProxyProvider<Counter, Translations>(
              create: (_) => Translations(),
              update: (
                BuildContext _,
                Counter counter,
                Translations? translations,
              ) {
                translations!.update(counter);
                return translations;
              },
            ),
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ShowTranslations(),
              SizedBox(height: 20.0),
              IncreaseButton(),
            ],
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
  const IncreaseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<Counter>().increment(),
      child: const Text(
        'INCREASE',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
