import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_page_form_with_bloc/payment/bloc/payment_bloc.dart';
import 'package:multi_page_form_with_bloc/payment/view/view.dart';
import 'package:user_repository/user_repository.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PaymentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => PaymentBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: const PaymentForm(),
      ),
    );
  }
}
