part of 'billing_address_bloc.dart';

abstract class BillingAddressEvent extends Equatable {
  const BillingAddressEvent();

  @override
  List<Object> get props => [];
}

class StreetChanged extends BillingAddressEvent {
  final String street;
  const StreetChanged(this.street);

  @override
  List<Object> get props => [street];
}

class ApartmentChanged extends BillingAddressEvent {
  final String apartment;
  const ApartmentChanged(this.apartment);

  @override
  List<Object> get props => [apartment];
}

class CityChanged extends BillingAddressEvent {
  final String city;
  const CityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class CountryChanged extends BillingAddressEvent {
  final String country;
  const CountryChanged(this.country);

  @override
  List<Object> get props => [country];
}

class PostcodeChanged extends BillingAddressEvent {
  final String postcode;
  const PostcodeChanged(this.postcode);

  @override
  List<Object> get props => [postcode];
}

class FormSubmitted extends BillingAddressEvent {}
