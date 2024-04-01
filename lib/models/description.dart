

class Description {

  final int _id;
  final String _text;
  final bool _state;


  int get id => _id;
  String get name => _text;
  bool get state => _state;

  Description.fromJson(Map<String, dynamic> json) :
        _id = json["id"],
        _text = json["text"],
        _state = json["state"];
}