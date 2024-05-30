import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_models.dart';

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  ProductController(this.ref) : super(const AsyncValue.loading());

  final StateNotifierProviderRef<ProductController, AsyncValue<List<Product>>>
      ref;

  void notifyConsumers(List<Product> updatedProducts) {
    state = AsyncValue.data(updatedProducts);
  }

  //Function for add new product
  Future<void> addProduct(Product newProduct) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.9:3001/api/products'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newProduct.toJson()),
      );

      if (response.statusCode == 200) {
        await reloadProducts();
      } else {
        throw Exception('Error add new product');
      }
    } catch (error) {
      throw Exception('Error addProduct: $error');
    }
  }

  //Funtion for load list products
  Future<void> loadProductsFromServer() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.9:3001/api/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Product> productList = data
            .map((item) => Product(
                id: item['id'],
                code: item['code'],
                description: item['description'],
                price: (item['price'] as num).toDouble(),
                quantity: item['quantity']))
            .toList();

        state = AsyncValue.data(productList);
      } else {
        throw Exception('Error load products');
      }
    } catch (error) {
      print(error);
      // state = AsyncValue.error(error.toString(), StackTrace.current);
      // throw Exception('Error loadProduct: $error');
    }
  }

  Future<void> reloadProducts() async {
    await loadProductsFromServer();
  }

  //Function for delete product
  Future<void> deleteProduct(int? productId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.9:3001/api/product/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        await reloadProducts();
      } else {
        throw Exception('Error CONTROLLER');
      }
    } catch (error) {
      throw Exception('Error deleteProduct: $error');
    }
  }

  Future<void> editProduct(int? productId, Product updatedProduct) async {
    try {
      final response = await http.patch(
        Uri.parse('http://192.168.1.9:3001/api/product/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedProduct.toJson()),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        await reloadProducts();
      } else {
        throw Exception('Error update');
      }
    } catch (error) {
      throw Exception('Error editProduct: $error');
    }
  }
}
