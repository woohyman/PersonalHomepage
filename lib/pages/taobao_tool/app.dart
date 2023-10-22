import 'package:flutter/material.dart';

import '../../domain/taobao_tool/model/url_combination.dart';
import '../../domain/taobao_tool/product_mix.dart';

TextEditingController _multiCopy = TextEditingController();
TextEditingController _unameController = TextEditingController(text: "https://h5.m.taobao.com/cart/order.html?buyMlow=false&buyParam=");
TextEditingController _number = TextEditingController(text: "1");
TextEditingController _numberEachSegment = TextEditingController(text: "100000");

class TaobaoToolWidget extends StatefulWidget {
  const TaobaoToolWidget({super.key});

  @override
  State<TaobaoToolWidget> createState() => _TaobaoToolWidgetState();
}

class _TaobaoToolWidgetState extends State<TaobaoToolWidget> {
  List<Widget> _counter = List.empty(growable: true);

  void _incrementCounter() {
    final inputSource = InputSource(
      number: _number.text,
      multiCopy: _multiCopy.text,
      numberEachSegment: _numberEachSegment.text,
      unameController: _unameController.text,
    );
    setState(() {
      _counter = getUrlWidgets(inputSource);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black45,
      //   title: const Text(
      //     "淘宝工具",
      //     style.dart: TextStyle(
      //       color: Colors.white70,
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "下单网址前缀",
                      ),
                      controller: _unameController,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "购买数量",
                      ),
                      controller: _number,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "每一组多少个",
                      ),
                      controller: _numberEachSegment,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 27,
                        controller: _multiCopy,
                        decoration: const InputDecoration(
                            hintText: "黏贴数据（把商品链接放进来,可以多个一起）",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 1,
                              color: Colors.redAccent,
                            ))),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 678,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 1,
                        ), // border
                        borderRadius: BorderRadius.circular((4)), // 圆角
                      ),
                      margin: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "生成链接：",
                              textAlign: TextAlign.left,
                            ),
                            ..._counter
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Text("生成"),
      ),
    );
  }
}
