import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql_flutter_crud/data/models/product_models.dart';
import 'package:mysql_flutter_crud/presentation/widget/show_modal_product.dart';
import 'package:mysql_flutter_crud/presentation/widget/delete_product_widget.dart';
import 'package:mysql_flutter_crud/core/providers/product_provider.dart';

//Call list products and buttons actions from producto_ui
class ProductTile extends ConsumerWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          title: Text(product.description),
          subtitle: Text('Precio: ${product.price.toString()}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('assets/images/pen.png'),
                iconSize: 24.0, // Ajusta el tamaño del ícono si es necesario
                onPressed: () async {
                  // Mostrar el modal de edición
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ShowModalProduct(
                        onAdd: (code, description, price, quantity) async {
                          final updatedProduct = Product(
                            id: product.id,
                            code: code,
                            description: description,
                            price: price,
                            quantity: quantity,
                          );
                          await ref
                              .read(productControllerProvider.notifier)
                              .editProduct(product.id, updatedProduct);
                        },
                        isEditMode: true,
                        editedProduct: product,
                      );
                    },
                  );
                },
              ),
              DeleteProductButton(product: product),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
