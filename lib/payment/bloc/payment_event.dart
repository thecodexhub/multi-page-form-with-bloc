part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CardNameChanged extends PaymentEvent {
  final String cardName;
  const CardNameChanged(this.cardName);

  @override
  List<Object> get props => [cardName];
}

class CardNumberChanged extends PaymentEvent {
  final String cardNumber;
  const CardNumberChanged(this.cardNumber);

  @override
  List<Object> get props => [cardNumber];
}

class ExpiryDateChanged extends PaymentEvent {
  final String expiryDate;
  const ExpiryDateChanged(this.expiryDate);

  @override
  List<Object> get props => [expiryDate];
}

class CvvNumberChanged extends PaymentEvent {
  final String cvvNumber;
  const CvvNumberChanged(this.cvvNumber);

  @override
  List<Object> get props => [cvvNumber];
}

class FormSubmitted extends PaymentEvent {}
