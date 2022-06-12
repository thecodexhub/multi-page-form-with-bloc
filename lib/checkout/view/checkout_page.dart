import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_page_form_with_bloc/billing_address/billing_address.dart';
import 'package:multi_page_form_with_bloc/checkout/checkout.dart';
import 'package:multi_page_form_with_bloc/payment/payment.dart';
import 'package:multi_page_form_with_bloc/personal_info/personal_info.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  static Widget create() {
    return BlocProvider(
      create: (_) => CheckoutCubit(3),
      child: const CheckoutPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Form'),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Stepper(
            type: StepperType.horizontal,
            currentStep: state.activeStepperIndex,
            onStepTapped: context.read<CheckoutCubit>().stepTapped,
            controlsBuilder: (context, controlDetails) {
              return const SizedBox.shrink();
            },
            steps: [
              Step(
                title: const Text('Personal Info'),
                content: const PersonalInfoPage(),
                isActive: state.activeStepperIndex >= 0,
                state: state.activeStepperIndex >= 0
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text('Address'),
                content: const BillingAddressPage(),
                isActive: state.activeStepperIndex >= 1,
                state: state.activeStepperIndex >= 1
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text('Payment'),
                content: const PaymentPage(),
                isActive: state.activeStepperIndex >= 2,
                state: state.activeStepperIndex >= 2
                    ? StepState.complete
                    : StepState.disabled,
              ),
            ],
          );
        },
      ),
    );
  }
}
