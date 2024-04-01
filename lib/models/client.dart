
class Client {

  final String _name;
  final String _addr;
  final String _tel;
  final String _message;

  String get name => _name;
  String get addr => _addr;
  String get tel => _tel;
  String get message => _message;

  Client.fromJson(Map<String, dynamic> json) :
        _name = json["name"],
        _addr = json["addr"],
        _tel = json["tel"],
        _message = json["message"];
}