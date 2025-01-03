import 'package:flutter/material.dart';

import 'package:zihin_gunlugu/widgets/bottom_nav_bar.dart';

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isSaving = false;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Uygulama kullanımı ile ilgili ipuçları burada gösterilecek.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0, isSaving : _isSaving,),
    );
  }
}
