import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_page_form_with_bloc/checkout/checkout.dart';
import 'package:multi_page_form_with_bloc/checkout/view/view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Form'),
      ),
      body: BlocProvider<CheckoutCubit>(
        create: (_) => CheckoutCubit(3),
        child: const CheckoutStepper(),
      ),
    );
  }
}
