import 'dart:developer';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';

import '../../../models/product_model.dart';
import '../../../repositories/products/product_repository.dart';
part 'product_dectail_controller.g.dart';

enum ProductDectailStateStatus{
initial,
loading,
loaded,
error,
errorLoadProduct,
deleted,
uploaded,
saved,


}



class ProductDectailController = ProductDectailControllerBase with _$ProductDectailController;

abstract class ProductDectailControllerBase with Store {
  final ProductRepository _productRepository;

  @readonly
var _status = ProductDectailStateStatus.initial;

@readonly
String? _errorMessage;

@readonly
String? _imagePath;

@readonly
ProductModel? _productModel;

ProductDectailControllerBase(this._productRepository);
@action
Future<void>uploadImageProduct(Uint8List file,String fileName)async {
_status = ProductDectailStateStatus.loading;
_imagePath = await _productRepository.uploadImageProduct(file, fileName);
_status = ProductDectailStateStatus.uploaded;

}
@action
Future<void>save(String name,double price,String description) async {
  try {
  _status = ProductDectailStateStatus.loading;
  final productModel= ProductModel(
    id: _productModel?.id,
    name: name, 
    description: description,
     price: price, 
     image: _imagePath!, 
     enabled: _productModel?.enabled ?? true,
     );
     await _productRepository.save(productModel);
     _status = ProductDectailStateStatus.saved;
}   catch (e,s) {
  log("Erro ao salvar o produto",error: e,stackTrace: s) ;
  _status = ProductDectailStateStatus.error;
  _errorMessage= "Erro ao salvar o produto";
}

}
@action
Future<void>loadProduct(int? id)async{
try {
  _status = ProductDectailStateStatus.loading;
  _productModel = null;
  _imagePath = null;
  if(id != null){
    _productModel = await _productRepository.getProduct(id);
    _imagePath = _productModel!.image;
  }
  _status = ProductDectailStateStatus.loaded;
}  catch (e,s) {
 log("Erro ao carregar produto",error: e,stackTrace: s);
 _status = ProductDectailStateStatus.errorLoadProduct;
}

}
@action
Future<void>deleteProduct()async{
  try {
  _status = ProductDectailStateStatus.loading;
  if(_productModel != null && _productModel!.id != null){
  await _productRepository.deleteProduct(_productModel!.id!);
  _status = ProductDectailStateStatus.deleted;
  }
  await Future.delayed(Duration.zero);
  _status = ProductDectailStateStatus.error;
  _errorMessage = "Produto não cadastrado,não é permitido deletar o produto";
}  catch (e,s) {
 log("Erro ao deletar produto",error: e, stackTrace: s);
 _status = ProductDectailStateStatus.error;
 _errorMessage = "Erro ao deletar produto";
}

}

}