import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class ClientPaymentsController{

  BuildContext context;
  Function refresh;
  GlobalKey<FormState> keyForm = new GlobalKey();

  String cardNumber = '';
  String expireDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;





  Future init(BuildContext context,Function refresh){
    this.context = context;
    this.refresh = refresh;
  }

  void onCreditCardModelChanged(CreditCardModel creditCardModel){
    cardNumber = creditCardModel.cardNumber;
    expireDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    refresh();
  }
}