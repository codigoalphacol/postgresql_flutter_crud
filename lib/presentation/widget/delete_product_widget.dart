import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql_flutter_crud/core/providers/product_provider.dart';
import 'package:mysql_flutter_crud/data/models/product_models.dart';

//Call button delete in showmodal product
class DeleteProductButton extends ConsumerWidget {
  final Product product;

  const DeleteProductButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Image.asset('assets/images/trash.png'),
      iconSize: 24.0, // Ajusta el tamaño del ícono si es necesario
      onPressed: () async {
        // Muestra un diálogo de confirmación antes de eliminar
        bool confirmDelete = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eliminar Producto'),
              content: const Text(
                  '¿Estás seguro de que deseas eliminar este producto?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);

                    try {
                      final productController =
                          ref.read(productControllerProvider.notifier);
                      await productController.deleteProduct(product.id);
                      await productController.reloadProducts();
                    } catch (error) {
                      if (error is Exception) {
                        // print('Error al eliminar producto: $error');
                      } else {
                        // print('Error desconocido al eliminar producto: $error');
                      }
                    }
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
