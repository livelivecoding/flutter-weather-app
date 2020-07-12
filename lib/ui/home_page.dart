import 'package:flutter/material.dart';
import 'package:weatherflut/ui/cities/cities_page.dart';
import 'package:weatherflut/ui/ui_constants.dart';

class HomePage extends StatelessWidget {
  void handleNavigatePress(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CitiesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome.jpg',
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: maxPageWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 55,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Hola,\nBienvenido',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Qué te parece si agregamos\nuna nueva ciudad?',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RaisedButton(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: Text('Agregar ciudad'),
                      onPressed: () => handleNavigatePress(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
