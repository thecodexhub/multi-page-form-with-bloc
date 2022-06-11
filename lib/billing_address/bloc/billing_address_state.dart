part of 'billing_address_bloc.dart';

class BillingAddressState extends Equatable {
  const BillingAddressState({
    this.street = const Street.pure(),
    this.apartment = const Apartment.pure(),
    this.city = const City.pure(),
    this.country = const Country.pure(),
    this.postcode = const Postcode.pure(),
    this.status = FormzStatus.pure,
  });

  final Street street;
  final Apartment apartment;
  final City city;
  final Country country;
  final Postcode postcode;
  final FormzStatus status;

  BillingAddressState copyWith({
    Street? street,
    Apartment? apartment,
    City? city,
    Country? country,
    Postcode? postcode,
    FormzStatus? status,
  }) {
    return BillingAddressState(
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [street, apartment, city, country, postcode, status];
}
