// Contains the helper code (objects, functions, constants, variables)
// used for all the projects

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../app/constants.dart';

// class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}


void itgLogVerbose(String msg) {
  if (appDebugMode) {
    if (kDebugMode) {
      print(msg);
    }
  }
}

String textMessageToDisplayNoData({required String dataModelName}) => 'There are no $dataModelName';
String textMessageToDisplayError({required String dataModelName, required String errorMessage}) =>
    'failed to fetch $dataModelName ($errorMessage})';

// TODO: until I find a better way I will compare the toString from them
bool compareColors(colorA, colorB) {
  String a = colorA.toString();
  String b = colorB.toString();
  if (colorA is MaterialColor) a = a.replaceAll('MaterialColor(primary value: ', '').replaceAll('))', ')');
  if (colorB is MaterialColor) b = b.replaceAll('MaterialColor(primary value: ', '').replaceAll('))', ')');
  return a == b ;
}

Text widgetText(BuildContext context, String text, {required Key key}) {
  return Text(
    text,
    style: TextStyle(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.green.shade900
          : Colors.green,
      fontWeight: FontWeight.w600,
      fontSize: 35.0,
    ),
    textAlign: TextAlign.center,
    key: key
  );
}

// extract the id from the passing value
// in rails the mongoid is a json map: {$oid: 60d9dd274558eb83d09ba052}
String getId(dynamic id) {
  itgLogVerbose('[getId] id: $id (${id.runtimeType})');
  // if (id is _JsonMap) {
  const String prefix = r'{$oid: ';
  const String suffix = r'}';
  if (id.toString().substring(0, 7) == prefix) {          // {$oid: 60bc95f4fe748d3ffc6936ad}
    return id.toString().replaceAll(prefix, '').replaceAll(suffix, '');
  } else if (id is String && id.length == 24) {
    return id;
  } else {
    throw '[getId] id "$id" (${id.runtimeType}, ${id.subtype}, ${id.toString().length}) is not handled';
  }
}

// Convert json value to string
String jsonValueAsString(dynamic value, {String valueType = 'string'}) {
  itgLogVerbose('jsonValueDoubleAsString - value: $value (${value.runtimeType}), valueType: $valueType');
  if (value == null) {
    if (['double','int'].contains(valueType)) {
      return '';
    } else {
      return '';
    }
  }
  else {
    if (valueType == 'date') {
      return value.toString().substring(0, 10).split('-').reversed.join('/');
    } else if (valueType == 'decimal') {
      return value.toString().replaceAll('.', ',');
    } else {
      return value.toString();
    }
  }
}

// Convert value back to json readable form string
String jsonStringAsStringValue(String? value, {String valueType = 'string'}) {
  // itgLogVerbose('jsonStringAsStringValue - value: $value, valueType: $valueType');
  if (value == null || value == '') {
    return valueType == 'decimal' ? '0' : '';
  } else if (valueType == 'date') {
    List<String> parts = value.split('/').reversed.toList();
    if (parts.first.length == 2) parts.first = '20${parts.first}';
    return parts.join('-');
  }
  else if (valueType == 'decimal') {
    return value.toString().replaceAll(',', '.');
  }
  else {
    return value;
  }
}

