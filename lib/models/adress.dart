

class Address {

  final int _id;
  final String _name;

  int get id => _id;
  String get name => _name;


  Address.fromJson(Map<String, dynamic> json) :
        _id = json["id"],
        _name = json["name"];

}