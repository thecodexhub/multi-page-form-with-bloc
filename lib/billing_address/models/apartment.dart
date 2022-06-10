import 'package:formz/formz.dart';

class Apartment extends FormzInput<String, void> {
  const Apartment.pure() : super.pure('');
  const Apartment.dirty([String value = '']) : super.dirty(value);

  @override
  void validator(String value) {}
}
