import 'dart:io';
import 'package:airpay_package/airpay_package.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  final bool isSandbox;
  Home({this.isSandbox});

  @override
  _HomeState createState() => _HomeState(isSandbox: isSandbox);
}

class _HomeState extends State<Home> {
  final bool isSandbox;
  _HomeState({this.isSandbox});

  bool isSuccess = false;
  bool isVisible = false;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController orderId = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController fullAddress = TextEditingController();

  void _showAddress() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    fname.text = "Pankaj";
    lname.text = "Kumar";
    email.text = "yagnesh.londhe@wwindia.com";
    phone.text = "9870884171";
    fullAddress.text = "Mumbai";
    pincode.text = "600011";
    orderId.text = "543766587";
    amount.text = "200.00";
    city.text = "testCity";
    state.text = "Maharastra";
    country.text = "India";
  }

  onComplete(status, response) {
    var resp = response.toJson();
    var txtStsMsg = resp['STATUSMSG'];
    var txtSts = resp['TRANSACTIONSTATUS'];
    Navigator.pop(context);
    AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            headerAnimationLoop: true,
            animType: AnimType.BOTTOMSLIDE,
            title: "KMMRCE Pay",
            desc: 'Transaction Status: ' + txtSts + '\nTransaction Status Message: ' + txtStsMsg)//'${response.toJson()}')
        .show();
  }

  void _sendDatas() {
    var msg = '';
    if (fname.text.length < 2) {
      msg = 'Enter enter a valid first name';
    }
    else if (lname.text.isEmpty) {
    msg = 'Enter enter a last name';
    }
    else if (email.text.isEmpty) {
    msg = 'Enter enter a email ID';
    }
    else if (EmailValidator.validate(email.text) == false) {
      msg = "Please enter a valid email";
    }
    else if (phone.text.isEmpty) {
    msg = 'Enter enter a phone number';
    }
    else if (phone.text.length < 10) {
    msg = 'Enter enter a valid phone number';
    }
     else if (orderId.text.isEmpty) {
    msg = 'Enter enter a orderId';
    }
     else if (amount.text.isEmpty) {
    msg = 'Enter enter a amount to proceed';
    }

if (msg.isNotEmpty) {

 AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            headerAnimationLoop: true,
            animType: AnimType.BOTTOMSLIDE,
            title: "KMMRCE Pay",
                        btnOkOnPress: () {},
                        btnOkColor: Colors.red,
             desc: msg)
        .show();
  return;
}
    String domainPath = 'https://apple.nowpay.co.in/kmmrcetest/success.php';

    String kAirPaySecretKey = 'hgrTsTTUrH7xvRN9';

    String kAirPayUserName = '5326492';

    String kAirPayPassword = 'c3Tpjp7A';

    String merchantID = '247033';

    String successURL = 'https://apple.nowpay.co.in/kmmrcetest/success.php"'; //'https://www.mosaics.amelio.in/';

    UserRequest user = UserRequest(
        username: kAirPayUserName,
        password: kAirPayPassword,
        secret: kAirPaySecretKey,
        merchantId: merchantID,
        protoDomain: domainPath,
        fname: fname.text,
        lname: lname.text,
        email: email.text,
        phone: phone.text,
        fulladdress: fullAddress.text,
        pincode: pincode.text,
        orderid: orderId.text,
        amount: amount.text,
        city: city.text,
        state: state.text,
        country: country.text,
        currency: "784",
        isCurrency: "AED",
        chMode: "",
        customVar: "test",
        txnSubtype: "",
        wallet: "0",
        isStaging: false, //True for the Staging
        successUrl: successURL,
        failedUrl: 'https://demo.nascorptechnologies.com/fasilure/');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new AirPay(
            user: user,
            closure: (status, response) => {onComplete(status, response)}),
      ),
    );
  }

  Future<void> _showAlert(BuildContext context, message) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "KMMRCE Pay";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(8.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  )
                ],
              )
            : AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    headerAnimationLoop: true,
                    animType: AnimType.BOTTOMSLIDE,
                    title: title,
                    desc: message1)
                .show();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/airpays.png',
            height: 40,
            color: Colors.white,
            width: 200,
          ),
          backgroundColor: Colors.blue[900],
        ),
        backgroundColor: Colors.grey[400],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'First Name *',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blue[900]),
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                'Last Name *',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                                   inputFormatters: [
   new LengthLimitingTextInputFormatter(18), 
],
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                //   contentPadding: EdgeInsets.all(2.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                              controller: fname,
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                inputFormatters: [
   new LengthLimitingTextInputFormatter(18), 
],
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  // contentPadding: EdgeInsets.all(2.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.0),
                                ),
                                controller: lname,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          child: TextFormField(
                            validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email Id',
                              // contentPadding: EdgeInsets.all(2.0),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15.0),
                            ),
                            controller: email,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                                 new LengthLimitingTextInputFormatter(10),// for mobile 
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              // contentPadding: EdgeInsets.all(2.0),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15.0),
                            ),
                            controller: phone,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                
                                                    Visibility(
                            visible: false,
                            child:Card(
                  margin: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                  color: Colors.white,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 8, 8.0, 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showAddress();
                                },
                                icon: isVisible
                                    ? Icon(Icons.arrow_drop_up)
                                    : Icon(Icons.arrow_drop_down),
                                color: Colors.black,
                              )
                            ],
                          ),
                          Visibility(
                            visible: isVisible,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Full Address',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: fullAddress,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'City Name',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: city,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'State Name',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue[900]),
                                    )),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Country Name',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blue[900]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: 'State',
                                        //   contentPadding: EdgeInsets.all(2.0),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 15.0),
                                      ),
                                      controller: state,
                                    )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Country ',
                                          // contentPadding: EdgeInsets.all(2.0),
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                        ),
                                        controller: country,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'PinCode',
                                      // contentPadding: EdgeInsets.all(2.0),
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 15.0),
                                    ),
                                    controller: pincode,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )),
                Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Transaction Information',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Order Id *',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.blue[900]),
                            )),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                'Amount *',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.blue[900]),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                                   inputFormatters: [
   new LengthLimitingTextInputFormatter(8), 
],
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'Order Id',
                                //   contentPadding: EdgeInsets.all(2.0),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                              controller: orderId,
                            )),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                 inputFormatters: [
   FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]{0,7}(?:\.[0-9]{0,7})?)')),
],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                  // contentPadding: EdgeInsets.all(2.0),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.0),
                                ),
                                controller: amount,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    // padding: EdgeInsets.fromLTRB(2.0, 11.0, 2.0, 11.0),
                    onPressed: () {
                      _sendDatas();
                    },
                    // color: Colors.blue[900],
                    child: Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    // padding: EdgeInsets.fromLTRB(2.0, 11.0, 2.0, 11.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    // color: Colors.blue[900],
                    child: Text(
                      'BACK',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
