class SignUpModel {
  String name;
  String email;
  String phone;
  String password;

  SignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  //Converting object to json. "f_name" is referred to the fields in the db table
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["f_name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["password"] = this.password;
    return data;
  }
}
