import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.stepperLength) : super(const CheckoutState());
  final int stepperLength;

  void stepTapped(int tappedIndex) =>
      emit(CheckoutState(activeStepperIndex: tappedIndex));

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(CheckoutState(activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      emit(CheckoutState(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(CheckoutState(activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(CheckoutState(activeStepperIndex: state.activeStepperIndex));
    }
  }
}
