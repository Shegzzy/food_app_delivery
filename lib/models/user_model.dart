class UserModel{
  String name;
  String email;
  String phone;
  int id;
  int orderCount;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
    required this.orderCount,
});
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        name: json['f_name'],
        email: json['email'],
        phone: json['phone'],
        id: json['id'],
        orderCount: json['order_count']);
  }
}