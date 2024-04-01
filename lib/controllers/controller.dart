import '../fetch/fetcher.dart';
import '../models/order.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OrderController extends ControllerMVC {
  final FetchOrders res = FetchOrders();
  OrderController();
  OrderResult currentState = OrderResultLoading();

  void init() async {
    try {
      final orderList = await res.fetchOrders();
      setState(() => currentState = OrderResultSuccess(orderList));
    } catch (error) {
      setState(() => currentState = OrderResultFailure("$error"));
    }
  }
}