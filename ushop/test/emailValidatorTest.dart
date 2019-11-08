import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:ushop/main.dart';
import 'package:ushop/screens/unitClass/emailValidator.dart';

void main(){
  test('title', () {
    
    //setup

    //run

    //verify
  });

  test('Correo vacio regresa un error string',(){
    var result = EmailFieldValidator.validate('');
    expect(result, 'Formato de email invalido');
  });

  test('Correo con formato correcto', (){
    var result = EmailFieldValidator.validate('jairo@hotmail.com');
    expect(result, null);
  });

  test('Correo sin @',(){
    var result = EmailFieldValidator.validate('jairohotmail.com');
    expect(result, 'Formato de email invalido');
  });

  test('Correo sin \.',(){
    var result = EmailFieldValidator.validate('jairo@hotmailcom');
    expect(result, 'Formato de email invalido');
  });
}