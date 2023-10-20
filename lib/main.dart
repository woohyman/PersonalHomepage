import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '工具'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

TextEditingController _multiCopy = TextEditingController();
TextEditingController _unameController = TextEditingController(text: "https://h5.m.taobao.com/cart/order.html?buyMlow=false&buyParam=");
TextEditingController _number = TextEditingController(text: "1");
TextEditingController _numberEachSegment = TextEditingController(text: "不分组");

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "";

  void _incrementCounter() {
    setState(() {
      final stringFragments = _multiCopy.text.split("https://");
      _counter = _unameController.text;
      for (int i = 0; i < stringFragments.length; i++) {
        final fragment = stringFragments[i];
        var index = fragment.indexOf("&id=");
        if (index < 0) index = fragment.indexOf("?id=");
        if (index < 0) continue;
        String id = "";
        String skuId = "";
        id = fragment.substring(index + 4, index + 16);
        final skuIdIndex = fragment.indexOf("skuId=");
        if (skuIdIndex > 0) skuId = "_" + fragment.substring(skuIdIndex + 6, skuIdIndex + 19);
        if (i > 1 && i <= stringFragments.length) {
          _counter += "," + id + "_" + _number.text+skuId;
        } else {
          _counter += id + "_" + _number.text+skuId;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: "网址前缀",
                  ),
                  controller: _unameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "黏贴数据",
                  ),
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  controller: _multiCopy,
                ),
                // TextField(
                //   decoration: const InputDecoration(
                //     labelText: "商品ID或者商品链接",
                //   ),
                //   controller: _url,
                // ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "购买数量",
                  ),
                  controller: _number,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "每一组多少个（默认不分）",
                  ),
                  controller: _numberEachSegment,
                ),
                const Text(
                  "生成链接：",
                  textAlign: TextAlign.left,
                ),
                SelectableText(
                  _counter, //字符串重复六次
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
