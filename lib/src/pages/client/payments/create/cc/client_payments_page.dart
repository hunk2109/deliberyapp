

import 'package:delibery/src/pages/client/payments/create/cc/client_payments_controller.dart';
import 'package:delibery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';


class ClientPaymentsCreatePage extends StatefulWidget {
  const ClientPaymentsCreatePage({Key key}) : super(key: key);

  @override
  _ClientPaymentsCreatePageState createState() => _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {
  ClientPaymentsController _con = new ClientPaymentsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos',
        ),
      ),
      body: ListView(
        children: [
        CreditCardWidget(
        cardNumber: _con.cardNumber,
        expiryDate: _con.expireDate,
        cardHolderName: _con.cardHolderName,
        cvvCode: _con.cvvCode,
        showBackView: _con.isCvvFocused,
        cardBgColor: MyColors.prymaryColor,
        obscureCardNumber: true,
        obscureCardCvv: true,
        animationDuration: Duration(milliseconds: 1000),
        labelCardHolder: 'Nombre y Apellido',
      ),
      CreditCardForm(
        formKey: _con.keyForm, // Required
        onCreditCardModelChange: _con.onCreditCardModelChanged, // Required
        themeColor: Colors.red,
        obscureCvv: true,
        obscureNumber: true,
        cardNumberDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Numero',
          hintText: 'XXXX XXXX XXXX XXXX',
        ),
        expiryDateDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Fecha de Expiracion ',
          hintText: 'XX/XX',
        ),
        cvvCodeDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
          hintText: 'XXX',
        ),
        cardHolderDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nombre del Titular',
        ),
      ),
          _BottonConfirm()
        ],
      ),
    );
  }

  Widget creditCarForm(){

  }


  Widget _BottonConfirm(){
    return Container(
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed:(){},
          style: ElevatedButton.styleFrom(
              primary: MyColors.prymaryColor,
              padding: EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )


          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 50,top: 7),
                  height: 30,
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30),
                ),
              ),



            ],
          ),
        )
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
