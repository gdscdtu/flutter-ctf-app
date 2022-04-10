import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
  });

  factory Constants.of() {
    return Constants._prd();
  }
  factory Constants._prd() {
    return const Constants._(
      endpoint: 'https://gdscdtu-flutter-ctf-mchz8.ondigitalocean.app',
    );
  }

  static late final Constants instance = Constants.of();

  final String endpoint;
}
