
import 'package:test_project/models/adress.dart';
import 'package:test_project/models/client.dart';
import 'package:test_project/models/description.dart';

class Order {

  final int _id;
  final String _name;
  final bool _state;
  final List<Address> _adresses;
  final String _date;
  final String _price;
  final List<Description> _descriptions;
  final String _code;
  final String _order_num;
  final String _product_number;
  final bool _payment;
  final Client _client;


  int get id => _id;
  String get name => _name;
  bool get state => _state;
  List<Address> get adresses => _adresses;
  String get date => _date;
  String get price => _price;
  List<Description> get descriptions => _descriptions;
  String get code => _code;
  String get order_num => _order_num;
  String get product_number => _product_number;
  bool get payment => _payment;
  Client get client => _client;

  Order.fromJson(Map<String, dynamic> json) :
        _id = json["id"],
        _name = json["name"],
        _state = json["state"],
        _adresses = (json["adresses"] as List?)?.map((addr) => Address.fromJson(addr)).toList() ?? [],
        _date = json["date"],
        _price = json["price"],
        _descriptions = (json["descriptions"] as List?)?.map((desc) => Description.fromJson(desc)).toList() ?? [],
        _code = json["code"],
        _order_num = json["order_num"],
        _product_number = json["product_number"],
        _payment = json["payment"],
        _client = Client.fromJson(json["client"]);
}

// OrderList являются оберткой для массива постов
class OrderList {
  final List<Order> orders = [];
  OrderList.fromJson(List<dynamic>? jsonItems) {
    for (var jsonItem in jsonItems ?? []) {
      print(Order.fromJson(jsonItem).adresses[0].name);
      orders.add(Order.fromJson(jsonItem));
    }
  }


}

abstract class OrderResult {}

class OrderResultSuccess extends OrderResult {
  final OrderList orderList;
  OrderResultSuccess(this.orderList);
}

class OrderResultFailure extends OrderResult {
  final String error;
  OrderResultFailure(this.error);
}

class OrderResultLoading extends OrderResult {
  OrderResultLoading();
}