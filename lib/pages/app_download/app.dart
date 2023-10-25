import 'package:universal_html/html.dart' as html;

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
              "https://taobaotool-1319006418.cos.ap-nanjing.myqcloud.com/setupfile/window/%E6%B7%98%E5%AE%9D%E5%B7%A5%E5%85%B7.zip";
          html.AnchorElement anchorElement = html.AnchorElement(href: url);
          anchorElement.download = url;
          anchorElement.click();
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
