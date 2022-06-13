import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page - User Details'),
      ),
      body: FutureBuilder<User?>(
        future: context.read<UserRepository>().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final User user = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CustomHeader('Personal Information'),
                _CustomText('Name', user.personalInfo.name),
                _CustomText('Email', user.personalInfo.email),
                _CustomText('Phone Number', user.personalInfo.phoneNumber),
                const SizedBox(height: 12.0),
                const _CustomHeader('Billing Address'),
                _CustomText('Street', user.billingAddress.street),
                _CustomText('Apartment', user.billingAddress.apartment),
                _CustomText('City', user.billingAddress.city),
                _CustomText('Country', user.billingAddress.country),
                _CustomText('ZIP / postcode', user.billingAddress.postcode),
                const SizedBox(height: 12.0),
                const _CustomHeader('Payment Details'),
                _CustomText('Card Name', user.payment.cardName),
                _CustomText('Card Number', user.payment.cardNumber),
                _CustomText('Expiry Date', user.payment.expiryDate),
                _CustomText('CVV', user.payment.cvvNumber),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader(this.header);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
