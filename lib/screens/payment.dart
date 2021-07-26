import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class paymentmethod extends StatefulWidget {
  int total;
  paymentmethod({Key? key,required this.total}) : super(key: key);

  @override
  _paymentmethodState createState() =>
      _paymentmethodState();
}

class _paymentmethodState extends State<paymentmethod> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        _handlePaymentSuccess);
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_0KAu6tcQjk9hqf',
      'amount': widget.total*100,
      'name': 'The Bag.inc',
      'description': 'Payment',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
      
    };

    try {
      
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error opening razorpay");
    }
  }

  void _handlePaymentSuccess(
      PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(
      PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ", timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(
      ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ", timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    openCheckout();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: Colors.white,
      body: Center(child: Text(
        'Press Back to Go Back to Home Page'
      ),),
    );
  }
}
