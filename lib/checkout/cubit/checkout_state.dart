part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.activeStepperIndex = 0,
  });

  final int activeStepperIndex;

  CheckoutState copyWith({int? activeStepperIndex}) {
    return CheckoutState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex];
}
