import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String getItems = """
  query GetItems() {
    getItems() {
      id,
      text
    }
  }
""";

Future<void> hc() async {
  final res = await Dio().get('${dotenv.env['API_URL']}/hc');
  debugPrint(res.toString());
}
