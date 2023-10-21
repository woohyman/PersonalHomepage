import 'package:flutter/material.dart';
import 'package:taobaotools/pages/taobao_tool/app.dart';

import 'domain/taobao_tool/product_mix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '应用百宝箱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '淘宝工具'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(
                  'https://img.51miz.com/Element/00/36/66/64/cfe49d21_E366664_78d08733.png',
                  width: 100,
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: TaobaoToolWidget(),
        )
      ],
    );
  }
}
