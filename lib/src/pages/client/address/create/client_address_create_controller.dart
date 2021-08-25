import 'package:flutter/material.dart';
import 'package:delivey/src/pages/client/address/maps/client_address_map_page.dart';

class ClientAdrresCreateController{
  BuildContext context;
  Function refresh;


  TextEditingController referenController = new TextEditingController();
  Map<String , dynamic> pointRef;
  Future init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
  }


  void openmap() async {
        pointRef = await  showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) => ClientAddrressMaptePage()
    );

        if(pointRef != null){
          referenController.text = pointRef['address'];
        }
  }

}