import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_page_form_with_bloc/payment/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final UserRepository userRepository;
  PaymentBloc({required this.userRepository}) : super(const PaymentState()) {
    on<CardNameChanged>(_onCardNameChanged);
    on<CardNumberChanged>(_onCardNumberChanged);
    on<ExpiryDateChanged>(_onExpiryDateChanged);
    on<CvvNumberChanged>(_onCvvNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onCardNameChanged(
    CardNameChanged event,
    Emitter<PaymentState> emit,
  ) {
    final cardName = CardName.dirty(event.cardName);
    emit(state.copyWith(
      cardName: cardName,
      status: Formz.validate(
          [cardName, state.cardNumber, state.expiryDate, state.cvvNumber]),
    ));
  }

  void _onCardNumberChanged(
    CardNumberChanged event,
    Emitter<PaymentState> emit,
  ) {
    final cardNumber = CardNumber.dirty(event.cardNumber);
    emit(state.copyWith(
      cardNumber: cardNumber,
      status: Formz.validate(
          [state.cardName, cardNumber, state.expiryDate, state.cvvNumber]),
    ));
  }

  void _onExpiryDateChanged(
    ExpiryDateChanged event,
    Emitter<PaymentState> emit,
  ) {
    final expiryDate = ExpiryDate.dirty(event.expiryDate);
    emit(state.copyWith(
      expiryDate: expiryDate,
      status: Formz.validate(
          [state.cardName, state.cardNumber, expiryDate, state.cvvNumber]),
    ));
  }

  void _onCvvNumberChanged(
    CvvNumberChanged event,
    Emitter<PaymentState> emit,
  ) {
    final cvvNumber = CvvNumber.dirty(event.cvvNumber);
    emit(state.copyWith(
      cvvNumber: cvvNumber,
      status: Formz.validate(
          [state.cardName, state.cardNumber, state.expiryDate, cvvNumber]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<PaymentState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updatePayment(
          cardName: state.cardName.value,
          cardNumber: state.cardNumber.value,
          expiryDate: state.expiryDate.value,
          cvvNumber: state.cvvNumber.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
