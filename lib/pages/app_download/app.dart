import 'dart:html' as html;

import 'package:flutter/material.dart';

class AppDownload extends StatelessWidget {
  const AppDownload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '点击右下角，下载最新的电脑端可执行文件.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const String url =
              "https://taobaotool-1319006418.cos.ap-nanjing.myqcloud.com/setupfile/window/%E5%BA%94%E7%94%A8%E7%99%BE%E5%AE%9D%E7%AE%B1.zip";
          html.AnchorElement anchorElement = html.AnchorElement(href: url);
          anchorElement.download = url;
          anchorElement.click();
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
