
import 'package:flutter/material.dart';

class StartGameButton extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "INIZIA GIOCO",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}
