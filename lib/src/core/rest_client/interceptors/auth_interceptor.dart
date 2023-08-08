
import 'package:dio/dio.dart';

import '../../global/constants.dart';
import '../../global/global_context.dart';
import '../../storage/storage.dart';

class AuthInterceptor extends Interceptor {
  final Storage storage;

  AuthInterceptor(this.storage);


  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler){
    final acessToken = storage.getData(SessionStorageKeys.acessToken.key);
    options.headers["Authorization"]= "Bearer $acessToken";
    handler.next(options);
    
  }
  @override
  // ignore: deprecated_member_use
  void onError(DioError err,ErrorInterceptorHandler handler){
    if(err.response?.statusCode == 401){
   GlobalContext.instance.loginExpire();
    }else{
      handler.next(err);
    }
   
  }
}