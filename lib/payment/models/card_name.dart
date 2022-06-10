import 'package:formz/formz.dart';

enum CardNameValidationError {
  required('Name on the card can\'t be empty'),
  invalid('Name is invalid.');

  final String message;
  const CardNameValidationError(this.message);
}

class CardName extends FormzInput<String, CardNameValidationError> {
  const CardName.pure() : super.pure('');
  const CardName.dirty([String value = '']) : super.dirty(value);

  static final _cardNameRegex =
      RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  CardNameValidationError? validator(String value) {
    return value.isEmpty
        ? CardNameValidationError.required
        : _cardNameRegex.hasMatch(value)
            ? null
            : CardNameValidationError.invalid;
  }
}
