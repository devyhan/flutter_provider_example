import 'package:flutter/material.dart';
import 'package:provider_overview_15/pages/proxy_prov_create_update.dart';
import 'package:provider_overview_15/pages/proxy_prov_proxy_prov.dart';

import 'pages/chgnotiprov_chgnotiproxyprov.dart';
import 'pages/chgnotiprov_proxyprov.dart';
import 'pages/prox_prov_update.dart';
import 'pages/why_proxy_prov.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WhyProxyProv(),
                  ),
                ),
                child: const Text(
                  'WhyProxyProvider',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProvUpdate(),
                  ),
                ),
                child: const Text(
                  'ProxyProvUpdate',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProvCreateUpdate(),
                  ),
                ),
                child: const Text(
                  'ProxyProvCreateUpdate',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProxyProvProxyProv(),
                  ),
                ),
                child: const Text(
                  'ProxyProvProxyProv',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChgNotiProvChgNotiProxyProv(),
                  ),
                ),
                child: const Text(
                  'ChgNotiProvChgNotiProxyProv',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChgNotiProvProxyProv(),
                  ),
                ),
                child: const Text(
                  'ChgNotiProvProxyProv',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
