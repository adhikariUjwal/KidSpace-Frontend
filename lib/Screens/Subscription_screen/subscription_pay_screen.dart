// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// class SubscriptionPayScreen extends StatefulWidget {
//   const SubscriptionPayScreen({Key? key}) : super(key: key);

//   @override
//   State<SubscriptionPayScreen> createState() => _SubscriptionPayScreenState();
// }

// class _SubscriptionPayScreenState extends State<SubscriptionPayScreen> {
//   Map<String, dynamic>? paymentIntent;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("Stripe Payment"),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 payment();
//               },
//               child: const Text("Pay Now"),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> payment() async {
//     try {
//       // Step 1: Create a payment intent on the server
//       final Map<String, dynamic> body = {'amount': 999, 'currency': "USD"};

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer sk_test_Y17KokhC3SRYCQTLYiU5ZCD2',
//           'Content-type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       paymentIntent = json.decode(response.body);
//       print("The is payment intent $paymentIntent");

//      // Step 3: Display the payment sheet
//       await Stripe.instance.presentPaymentSheet();

//     } catch (error) {
//       print(error);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $error')),
//       );
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidspace/Screens/AccountsScreen/account.dart';
import 'dart:math';

import 'package:kidspace/Services/subscription_service.dart';

class SubcriptionPayTypeScreen extends StatefulWidget {
  final double payingPrice;
  final Map<String, dynamic> planDetails;
  const SubcriptionPayTypeScreen(
      {super.key, required this.payingPrice, required this.planDetails});

  @override
  State<SubcriptionPayTypeScreen> createState() =>
      _SubcriptionPayTypeScreenState();
}

class _SubcriptionPayTypeScreenState extends State<SubcriptionPayTypeScreen> {
  Map<String, dynamic>? paymentIntent;

  _navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const Account()));
  }

  //Stripe Payment
  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      var paymentData = {
        "plan_id": widget.planDetails['id'],
        "payment_type": "Stripe"
      };

      var res = await SubscriptionService().paymentSuccess(paymentData);

      if (res != false) {
        Fluttertoast.showToast(
            msg: "Payment successfull",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        _navigate();
      }
    } catch (_) {
      print(_);
      Fluttertoast.showToast(
          msg: "Your payment is failed. Please try again $_",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void makePayment(price) async {
    double number = double.parse(price);
    int roundedUpPrice = number.ceil().toInt();
    try {
      paymentIntent = await createPaymentIntent(roundedUpPrice);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: "KidSpace",
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.dark,
      ));
      displayPaymentSheet();
    } catch (_) {
      print(_.toString());
    }
  }

  createPaymentIntent(price) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] =
        "Bearer sk_test_51NRuECBsgLtJ8Uu87RIAlZe7759D8SeDtbWgnao86IQQIoLsKYRaVzAy7sGRbB4CnttsbeFHkHppWRm7vzCznras00ZOg7mftD";
    dio.options.contentType = "application/x-www-form-urlencoded";
    try {
      Map<String, dynamic> body = {"amount": "$price", "currency": "USD"};
      var res = await dio.post("https://api.stripe.com/v1/payment_intents",
          data: body);
      return res.data;
    } on StripeException catch (e) {
      print(" create payment: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 121, 100, 171),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Choose payment type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: ElevatedButton(
                onPressed: () {
                  makePayment((widget.payingPrice * 100).toString());
                },
                child: const Text('Stripe')),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
