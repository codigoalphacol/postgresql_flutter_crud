import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql_flutter_crud/core/providers/product_provider.dart';
import 'package:mysql_flutter_crud/data/models/product_models.dart';
import 'package:mysql_flutter_crud/presentation/widget/show_modal_product.dart';
import '../widget/product_list_tile.dart';

class ProductUi extends ConsumerStatefulWidget {
  const ProductUi({super.key});

  @override
  ProductUiState createState() => ProductUiState();
}

class ProductUiState extends ConsumerState<ProductUi> {
  
  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).reloadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          ElevatedButton(
            onPressed: () {
              //Call widget functions for add new product or edit
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ShowModalProduct(
                    onAdd: (code, description, price, quantity) async {
                      final newProduct = Product(
                        code: code,
                        description: description,
                        price: price,
                        quantity: quantity,
                      );
                      await ref
                          .read(productControllerProvider.notifier)
                          .addProduct(newProduct);
                    },
                  );
                },
              );
            },
            child: const Text('Agregar Producto'),
          ),
        ],
      ),
      body: products.when(
        loading: () {
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) => Text('Error: $error'),
        data: (productList) {
          // Load list products in a ListView
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ProductTile(product: product);
            },
          );
        },
      ),
    );
  }
}
