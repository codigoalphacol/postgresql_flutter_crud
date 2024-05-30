import 'package:flutter/material.dart';
import 'package:mysql_flutter_crud/data/models/product_models.dart';

//Load initState in show modal product for edit product
void initializeProductForm({
  required bool isEditMode,
  Product? editedProduct,
  required TextEditingController codeController,
  required TextEditingController descriptionController,
  required TextEditingController priceController,
  required TextEditingController quantityController,
}) {
  if (isEditMode && editedProduct != null) {
    codeController.text = editedProduct.code.toString();
    descriptionController.text = editedProduct.description.toString();
    priceController.text = editedProduct.price.toString();
    quantityController.text = editedProduct.quantity.toString();
  }
}
