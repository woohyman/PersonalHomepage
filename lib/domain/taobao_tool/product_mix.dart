import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_image_generator/qr_image_generator.dart';

import 'model/url_combination.dart';

List<Widget> getUrlWidgets(InputSource inputSource) {
  final List<Widget> counter = List.empty(growable: true);
  var stringFragments = inputSource.multiCopy.split("https://");
  int segmentCount = int.tryParse(inputSource.numberEachSegment) ?? (stringFragments.length - 1);
  stringFragments = stringFragments.sublist(1, stringFragments.length);
  var groups = 0;
  if (stringFragments.length % segmentCount > 0) {
    groups = stringFragments.length ~/ segmentCount + 1;
  } else {
    groups = stringFragments.length ~/ segmentCount;
  }

  for (int j = 0; j < groups; j++) {
    List segment = List.empty();
    if (j == groups - 1) {
      segment = stringFragments.sublist(j * segmentCount, stringFragments.length);
    } else {
      segment = stringFragments.sublist(j * segmentCount, (j + 1) * segmentCount);
    }
    var url = inputSource.unameController;
    String pngName = "";
    for (int i = 0; i < segment.length; i++) {
      final fragment = segment[i];
      var index = fragment.indexOf("&id=");
      if (index < 0) index = fragment.indexOf("?id=");
      if (index < 0) continue;
      String id = "";
      String skuId = "";

      id = fragment.substring(index + 4, index + 16);

      final skuIdIndex = fragment.indexOf("skuId=");
      if (skuIdIndex > 0) skuId = "_${fragment.substring(skuIdIndex + 6, skuIdIndex + 19)}";
      if (i > 0 && i < segment.length) {
        pngName += ",${id}_${inputSource.number}$skuId";
        url += ",${id}_${inputSource.number}$skuId";
      } else {
        pngName += "${id}_${inputSource.number}$skuId";
        url += "${id}_${inputSource.number}$skuId";
      }
    }

    if (pngName.isEmpty) {
      continue;
    }

    getExternalStorageDirectory()
        .then((value) => {
              QRGenerator().generate(
                data: url,
                filePath: '${value?.path}/$pngName.png',
              ),
            })
        .onError((error, stackTrace) => {});

    counter.add(Column(
      children: [
        SelectableText(url),
        QrImageView(
          data: url,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ],
    ));
  }
  return counter;
}
