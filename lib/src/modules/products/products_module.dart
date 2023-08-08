import 'package:flutter_modular/flutter_modular.dart';

import 'detail/product_dectail_controller.dart';
import 'detail/product_dectail_page.dart';
import 'home/products_controller.dart';
import 'home/products_page.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => ProductsController(i()),
        ),
        Bind.lazySingleton(
          (i) => ProductDectailController(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProductsPage()),
        ChildRoute(
          '/detail',
          child: (context, args) => ProductDectailPage(
            productId: int.tryParse(args.queryParams["id"] ?? "não informado"),
          ),
        ),
      ];
}
