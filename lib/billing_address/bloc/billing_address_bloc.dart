import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_page_form_with_bloc/billing_address/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'billing_address_event.dart';
part 'billing_address_state.dart';

class BillingAddressBloc
    extends Bloc<BillingAddressEvent, BillingAddressState> {
  final UserRepository userRepository;
  BillingAddressBloc({required this.userRepository})
      : super(const BillingAddressState()) {
    on<StreetChanged>(_onStreetChanged);
    on<ApartmentChanged>(_onApartmentChanged);
    on<CityChanged>(_onCityChanged);
    on<CountryChanged>(_onCountryChanged);
    on<PostcodeChanged>(_onPostcodeChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onStreetChanged(
    StreetChanged event,
    Emitter<BillingAddressState> emit,
  ) {
    final street = Street.dirty(event.street);
    emit(state.copyWith(
      street: street,
      status: Formz.validate(
          [street, state.apartment, state.city, state.country, state.postcode]),
    ));
  }

  void _onApartmentChanged(
    ApartmentChanged event,
    Emitter<BillingAddressState> emit,
  ) {
    final apartment = Apartment.dirty(event.apartment);
    emit(state.copyWith(
      apartment: apartment,
      status: Formz.validate(
          [state.street, apartment, state.city, state.country, state.postcode]),
    ));
  }

  void _onCityChanged(
    CityChanged event,
    Emitter<BillingAddressState> emit,
  ) {
    final city = City.dirty(event.city);
    emit(state.copyWith(
      city: city,
      status: Formz.validate(
          [state.street, state.apartment, city, state.country, state.postcode]),
    ));
  }

  void _onCountryChanged(
    CountryChanged event,
    Emitter<BillingAddressState> emit,
  ) {
    final country = Country.dirty(event.country);
    emit(state.copyWith(
      country: country,
      status: Formz.validate(
          [state.street, state.apartment, state.city, country, state.postcode]),
    ));
  }

  void _onPostcodeChanged(
    PostcodeChanged event,
    Emitter<BillingAddressState> emit,
  ) {
    final postcode = Postcode.dirty(event.postcode);
    emit(state.copyWith(
      postcode: postcode,
      status: Formz.validate(
          [state.street, state.apartment, state.city, state.country, postcode]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<BillingAddressState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updateBillingAddress(
          street: state.street.value,
          apartment: state.apartment.value,
          city: state.city.value,
          country: state.country.value,
          postcode: state.postcode.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
