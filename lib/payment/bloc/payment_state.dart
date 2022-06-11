part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.cardName = const CardName.pure(),
    this.cardNumber = const CardNumber.pure(),
    this.expiryDate = const ExpiryDate.pure(),
    this.cvvNumber = const CvvNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final CardName cardName;
  final CardNumber cardNumber;
  final ExpiryDate expiryDate;
  final CvvNumber cvvNumber;
  final FormzStatus status;

  PaymentState copyWith({
    CardName? cardName,
    CardNumber? cardNumber,
    ExpiryDate? expiryDate,
    CvvNumber? cvvNumber,
    FormzStatus? status,
  }) {
    return PaymentState(
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvNumber: cvvNumber ?? this.cvvNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [cardName, cardNumber, expiryDate, cvvNumber, status];
}
