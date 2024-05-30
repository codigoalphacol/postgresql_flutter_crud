import 'package:flutter/material.dart';

//Button actions in show modal product
class ActionButtons extends StatelessWidget {
  final VoidCallback onAdd;
  final bool isEditMode;

  const ActionButtons({
    super.key,
    required this.onAdd,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onAdd,
          child: Text(isEditMode ? 'Editar' : 'Agregar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
