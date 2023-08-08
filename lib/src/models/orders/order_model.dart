
import 'dart:convert';

import 'order_product_model.dart';
import 'order_status.dart';

class OrderModel {
  final int id;
final DateTime date;
final OrderStatus status;
final List<OrderProductModel>orderProducts;
final int userId;
final String address;
final String cpf;
final int paymentTypeId;
  OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProducts,
    required this.userId,
    required this.address,
    required this.cpf,
    required this.paymentTypeId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'date': date.toIso8601String()});
    result.addAll({'status': status.acronym});
    result.addAll({"products":orderProducts.map((x) => x.toMap()).toList(),});
    result.addAll({'user_id': userId}); //
    result.addAll({'address': address});
    result.addAll({'CPF': cpf});
    result.addAll({"payment_method_id": paymentTypeId}); //
  
    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: (map['id']?? 0) as int,
      date: DateTime.parse((map['date'])),
      status: OrderStatus.parse(map['status']),
      orderProducts: List<OrderProductModel>.from(
       (map["products"]).map<OrderProductModel>(
       (x) => OrderProductModel.fromMap(x as Map<String,dynamic>),),),
      userId: (map['user_id'] ?? 0)as int,
      address: (map['address'] ?? '')as String,
      cpf:( map['CPF'] ?? '') as String,
      paymentTypeId:( map['payment_method_id'] ?? 0)as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
// {
//         "id": 1,
//         "date": "2023-04-25T00:00:00.000",
//         "status": "F",
//         "products": [
//             {
//                 "id": 1,
//                 "amount": 2,
//                 "total_price": 38.0
//             },
//             {
//                 "id": 2,
//                 "amount": 1,
//                 "total_price": 19.0
//             }
//         ],
//         "user_id": 2,
//         "address": "Av Paulista, 51 São Paulo",
//         "CPF": 1234156464,
//         "payment_method_id": 1
//     },