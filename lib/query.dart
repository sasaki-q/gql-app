import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String getItemsWithPagination = """
  query GetItemsWithPagination(\$nfrom: Int!) {
    getItemWithPagination(from: \$nfrom) {
      items {
        id
        text
        price
      }
      pageInfo {
        startCursor
        endCursor
      }
    }
  }
""";

Future<void> hc() async {
  final res = await Dio().get('${dotenv.env['API_URL']}/hc');
  debugPrint(res.toString());
}
