import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_project/models/order.dart';


const String SERVER = "https://wonderful-dolphin-53.app.smartmock.io/api/v2/order";


class FetchOrders {
  Future<OrderList> fetchOrders() async {
    final url = Uri.parse(SERVER);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return OrderList.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("failed request");
    }
  }
}