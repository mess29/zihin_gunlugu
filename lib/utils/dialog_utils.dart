import 'package:flutter/material.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool> (
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Çıkmak istediğinizden emin misiniz?'),
            content: const Text(
                'Kaydetme işlemi devam ediyor. Çıkarsanız yaptığınız değişiklikler kaydedilmeyecek.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Hayır'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Evet'),
              ),
            ],
          );
        },
      ) ??
      false; // Eğer null dönerse false dön
}
