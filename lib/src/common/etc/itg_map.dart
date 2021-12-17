// based-on: https://gist.github.com/shevchenkobn/0894a60699089f4a58b7f35cb7753500

_copyValues(Map from, Map to, bool recursive, bool acceptNull) {
  // itgLogVerbose('[ItgMap._copyValues] recursive: $recursive, acceptNull: $acceptNull\nfrom: $from\nto: $to');
  for (var key in from.keys) {
    // itgLogVerbose('[ItgMap._copyValues] from[$key]: ${from[key]}, to[$key]: ${to[key]}');
    // itgLogVerbose('[ItgMap._copyValues] from[key]: ${from[key]}\nfrom[key] is Map: ${from[key] is Map}\nfrom[key] is Map: ${from[key] is Map}\nfrom[key] is Map && recursive: ${from[key] is Map && recursive}');
    if (from[key] is Map && recursive) {
      if (to[key] is! Map) {
        // itgLogVerbose('[ItgMap._copyValues] to[$key]: ${to[key]}');
        to[key] = <String, String>{};
        // itgLogVerbose('[ItgMap._copyValues] after assign to[$key]....');
      }
      // itgLogVerbose('[ItgMap._copyValues] before recursive call...');
      _copyValues(from[key] as Map, to[key] as Map, recursive, acceptNull);
    } else {
      // itgLogVerbose('[ItgMap._copyValues] replace value in to[$key]: ${to[key]} with from[key]: ${from[key]}');
      if (from[key] != null || acceptNull) to[key] = from[key];
    }
  }
}

/// Merges the values of the given maps together.
///
/// `recursive` is set to `true` by default. If set to `true`,
/// then nested maps will also be merged. Otherwise, nested maps
/// will overwrite others.
///
/// `acceptNull` is set to `false` by default. If set to `false`,
/// then if the value on a map is `null`, it will be ignored, and
/// that `null` will not be copied.
// TODO: mergeMap seems that is not working! returns the last one and not merge them
//       the problem seems to exists in the passing classes
Map mergeMap(Iterable<Map> maps, {bool recursive = true, bool acceptNull = false}) {
  Map<String, Map<String, String>> result = {};
  // itgLogVerbose('[ItgMap.mergeMap] before merge...');
  // maps.forEach((Map map) {
  for (var map in maps) {
    // if (map != null) _copyValues(map, result, recursive, acceptNull);
    _copyValues(map, result, recursive, acceptNull);
  }
  // itgLogVerbose('[ItgMap.mergeMap] after merge - result: $result');
  return result;
}

// _copyValues<K, V>(Map<K, V> from, Map<K, V> to, bool recursive, bool acceptNull) {
//   itgLogVerbose('[ItgMap._copyValues] recursive: $recursive, acceptNull: $acceptNull\nfrom: $from\nto: $to');
//   for (var key in from.keys) {
//     itgLogVerbose('[ItgMap._copyValues] from[key]: ${from[key]}\nfrom[key] is Map: ${from[key] is Map}\nfrom[key] is Map: ${from[key] is Map<K, V>}\nfrom[key] is Map<K, V> && recursive: ${from[key] is Map<K, V> && recursive}');
//     if (from[key] is Map<K, V> && recursive) {
//       if (!(to[key] is Map<K, V>)) {
//         itgLogVerbose('[ItgMap._copyValues] to[$key]: ${to[key]}');
//         to[key] = <K, V>{} as V;
//       }
//       _copyValues(from[key] as Map, to[key] as Map, recursive, acceptNull);
//     } else {
//       itgLogVerbose('[ItgMap._copyValues] replace value in to[$key]: ${to[key]} with from[key]: ${from[key]}');
//       if (from[key] != null || acceptNull) to[key] = from[key];
//     }
//   }
// }
//
// Map<K, V> mergeMap<K, V>(Iterable<Map<K, V>> maps,
//     {bool recursive: true, bool acceptNull: false}) {
//   Map<K, V> result = <K, V>{};
//   maps.forEach((Map<K, V> map) {
//     if (map != null) _copyValues(map, result, recursive, acceptNull);
//   });
//   return result;
// }
