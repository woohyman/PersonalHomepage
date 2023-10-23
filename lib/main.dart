import 'package:flutter/material.dart';
import 'package:taobaotools/pages/app_download/app.dart';
import 'package:taobaotools/pages/fc_game/app.dart';
import 'package:taobaotools/pages/taobao_tool/app.dart';
import 'package:taobaotools/pages/tv/app.dart';

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
  Widget fragmentWidget = const TaobaoToolWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(
                'https://img.51miz.com/Element/00/36/66/64/cfe49d21_E366664_78d08733.png',
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "工具",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == TaobaoToolWidget ? Colors.white : Colors.white60;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == TaobaoToolWidget ? Colors.blue : Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      fragmentWidget = const TaobaoToolWidget();
                    });
                  },
                  child: const Text(
                    "淘宝拼接下单",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              const Text(
                "娱乐",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == TvWidget ? Colors.white : Colors.white60;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == TvWidget ? Colors.blue : Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      fragmentWidget = const TvWidget();
                    });
                  },
                  child: const Text("电视"),
                ),
              ),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == FcGameWidget ? Colors.white : Colors.white60;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == FcGameWidget ? Colors.blue : Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      fragmentWidget = const FcGameWidget();
                    });
                  },
                  child: const Text("红白机游戏"),
                ),
              ),
              const Text(
                "下载",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                child: TextButton(
                  style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(RoundedRectangleBorder()),
                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == AppDownload ? Colors.white : Colors.white60;
                    }),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      return fragmentWidget.runtimeType == AppDownload ? Colors.blue : Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      fragmentWidget = const AppDownload();
                    });
                  },
                  child: const Text("安装包下载"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: fragmentWidget,
        )
      ],
    );
  }
}
