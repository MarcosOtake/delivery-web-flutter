import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);

  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put(
        "/orders/$id",
        data: {
          "status": status.acronym,
        },
      );
    } on DioException catch (e, s) {
      log(
        "Erro ao alterar status do pedido para ${status.acronym}",
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: "Erro ao alterar status do pedido para ${status.acronym}",
      );
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(DateTime date,[OrderStatus? status]) async {
    try {
      final orderResponse = await _dio.auth().get(
        "/orders",
        queryParameters: {
          "date": date.toIso8601String(),
          if (status != null) "status": status.acronym
        },
      );
  debugPrint(orderResponse.data.toString());
    // List<OrderModel> order = await orderResponse.data!.map<OrderModel>((o) =>OrderModel.fromMap(o.toMap())).toList();
    //   return order;
      //print(order.first.orderProducts);
      //return order;
      final order = await  orderResponse.data
          .map<OrderModel>((o) => OrderModel.fromMap(o))
          .toList();
      return order;
    } on DioException catch (e, s) {
      log(
        "Erro ao buscar pedidos",
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: "Erro ao buscar pedidos",
      );
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
    try {
      final orderResponse = await _dio.auth().get(
            "/orders/$id",
          );
      return OrderModel.fromMap(orderResponse.data);
    } on DioException catch (e, s) {
      log(
        "Erro ao  buscar pedido",
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: "Erro ao buscar pedido",
      );
    }
  }
}

// {
//           "id":1,
//           "date":"2023-04-25T00:00:00.000",
//           "status":"F",
//           "products":[
//              {
//                 "id":1,
//                 "amount":2,
//                 "total_price":38.0
//              },
//              {'
//                 "id":2,
//                 "amount":1,
//                 "total_price":19.0
//              }
//           ],
//           "user_id":2,
//           "address":"Av Paulista, 51 São Paulo",
//           "CPF":1234156464,
//           "payment_method_id":1
//        },