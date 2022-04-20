import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  //action altera o observable que é o estado inicial
  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;
  
  @observable
  bool loading = false;


  @observable
  bool loggedIn = false;
  
  @action
  Future<void> login() async {
    loading = true;
    
    //processar os dados
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    loggedIn = true;

    email = '';
    password = '';
  }

  @action
  void logout(){
    loggedIn = false;
  }


  //combina observables para fazer validações
  //computed sempre tem que ser um get
  @computed
  bool get isEmailValid => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  VoidCallback? get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;

}