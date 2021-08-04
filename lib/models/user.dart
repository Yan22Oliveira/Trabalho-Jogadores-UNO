class User {

  DateTime expiresIn = DateTime(0);
  String email       = '';
  String idToken     = '';
  String localId     = '';

  User({
    required this.expiresIn,
    required this.email,
    required this.idToken,
    required this.localId,
  });

  User.fromJson(Map<String, dynamic> json) {
    expiresIn = DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));
    email     = json['email']??"";
    idToken   = json['idToken']??"";
    localId   = json['localId']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiresIn'] = this.expiresIn;
    data['email']     = this.email;
    data['idToken']   = this.idToken;
    data['localId']   = this.localId;
    return data;
  }

  User.clear(){
    expiresIn = DateTime(0);
    email     = "";
    idToken   = "";
    localId   = "";
  }

}