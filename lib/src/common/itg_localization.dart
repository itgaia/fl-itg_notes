import 'etc/itg_map.dart';
import 'helper.dart';

class ItgLocalization {
  static String language = 'en';
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'language': 'Language',
      'helloWorld': 'Hello World',
      'appWindowTitle': 'itg_notes',
      'appTitle': 'itg_notes',
      'welcomeMessage1': 'What a Wonderful World for All of Us...',
      'welcomeMessage2': '(Click the menu up-right for the available options)',
      'Customers': 'Customers',
      'Customer': 'Customer',
      'Products': 'Products',
      'Product': 'Product',
      'Resources': 'Resources',
      'Resource': 'Resource',
      'Suppliers': 'Suppliers',
      'Supplier': 'Supplier',
      'Tasks': 'Tasks',
      'Task': 'Task',
      'Dispatches': 'Dispatches',
      'Dispatch': 'Dispatch',
      'Dispatch Items': 'Dispatch Items',
      'DispatchItems': 'Dispatch Items',
      'DispatchItem': 'Dispatch Item',
      'Dispatch Templates': 'Dispatch Templates',
      'DispatchTemplates': 'Dispatch Templates',
      'DispatchTemplate': 'Dispatch Template',
      'Cultivations': 'Cultivations',
      'Cultivation': 'Cultivation',
      'Cultivation Chambers': 'Cultivation Chambers',
      'CultivationChambers': 'Cultivation Chambers',
      'CultivationChamber': 'Cultivation Chamber',
      'Cultivation Chamber': 'Cultivation Chamber',
      'Cultivation Fillings': 'Cultivation Fillings',
      'CultivationFillings': 'Cultivation Fillings',
      'CultivationFilling': 'Cultivation Filling',
      'Cultivation Filling': 'Cultivation Filling',
      'Cultivation Flushes': 'Cultivation Flushes',
      'CultivationFlushs': 'Cultivation Flushs',
      'CultivationFlush': 'Cultivation Flush',
      'Cultivation Flush': 'Cultivation Flush',
      'Cultivation Harvests': 'Cultivation Harvests',
      'CultivationHarvests': 'Cultivation Harvests',
      'CultivationHarvest': 'Cultivation Harvest',
      'Cultivation Harvest': 'Cultivation Harvest',
      'Cultivation Measurements': 'Cultivation Measurements',
      'CultivationMeasurements': 'Cultivation Measurements',
      'CultivationMeasurement': 'Cultivation Measurement',
      'Cultivation Measurement': 'Cultivation Measurement',
      'Cultivation Totals': 'Cultivation Totals',
      'CultivationTotals': 'Cultivation Totals',
      'CultivationTotal': 'Cultivation Total',
      'Cultivation Total': 'Cultivation Total',
      'Chamber': 'Chamber',
      'chamber': 'chamber',
      'Chambers': 'Chambers',
      'chambers': 'chambers',
      'cage': 'cage',
      'Cage': 'Cage',
      'cages': 'cages',
      'Cages': 'Cages',
      'spawn': 'spawn',
      'spawns': 'spawns',
      'Spawn': 'Spawn',
      'Spawns': 'Spawns',
      'kind': 'kind',
      'kinds': 'kinds',
      'Kind': 'Kind',
      'Kinds': 'Kinds',
      'Total Cages': 'Total Cages',
      'Per Block': 'Kg/Block',
      'Total Kg per Block': 'Total Kg/Block',
      'Temp Outdoor': 'Outside Temp',
      'Temp Chamber': 'Room Temp',
      'Temp Substrate': 'Substrate Temp',
    },
    'el': {
      'language': 'Γλώσσα',
      'helloWorld': 'Καλημέρα Κόσμε!',
      'appWindowTitle': 'Client',
      'appTitle': 'Client App',
      'welcomeMessage': 'Ένας Υπέροχος Κόσμος για Όλους μας...',
      'welcomeMessage2': '(Πατήστε το μενού πάνω δεξια για τις διαθέσιμες λειτουργίες)',
      'Cultivation Chambers': 'Θάλαμοι Καλλιέργειας',
      'CultivationChambers': 'Θάλαμοι Καλλιέργειας',
    }
  };

  static String tr(String text, {String lang = ''}) {
    if (lang == '') lang = language;
    String? translated = _localizedValues[lang]![text];
    // if (translated == null) translated = text;
    translated ??= text;
    // if (text == 'appTitle') {
    //   itgLogVerbose('[ItgLocalization.tr] _localizedValues[$lang]: ${_localizedValues[lang]}');
    // }
    itgLogVerbose('ItgLocalization.tr - text: $text, return: $translated');
    return translated;
  }

  static void custom(Map<String, Map<String, String>> values) {
    // itgLogVerbose('[ItgLocalization.custom] values: $values');
    _localizedValues = mergeMap([_localizedValues, values]) as Map<String, Map<String, String>>;
    // itgLogVerbose('[ItgLocalization.custom] after: $_localizedValues');
  }
}