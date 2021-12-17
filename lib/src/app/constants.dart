import 'package:flutter/material.dart';

import 'app_private_config.dart';

const defaultSearchDebounce = 500;

const appDebugMode = true;
const appDebugPaintSizeEnabled = false;
const appDebugShowCheckedModeBanner = false;

Future<bool> networkInfoIsConnected = Future.value(true);  // Temporary...

const appTitleFull = 'Your Mushroom Manager App';
const appTitleCultivationChambersPage = 'Cultivation Rooms';
const textHomePageWelcomeMessage1 = 'What a Wonderful World for All of Us...';
const textHomePageWelcomeMessage2 = '(Click the menu up-right for the available options)';
const textSampleException = 'Some exception occurred';
const textSampleFailure = 'Some failure occurred';

const keyAppBarPage = Key('app-bar-page');
const keyCultivationChambersPage = Key('page-cultivation-chambers');
const keyCultivationChambersListWidget = Key('widget-cultivation-chambers-list');
const keyTextPageTitle = Key('text-page-title');
const keyTextHomePageWelcomeMessage1 = Key('text-home-page-welcome-message-1');
const keyTextHomePageWelcomeMessage2 = Key('text-home-page-welcome-message-2');
const keyButtonCultivationChambersPage = Key('button-cultivation-chambers-page');
const keyButtonCultivationChambersSearchPage = Key('button-cultivation-chambers-search-page');
const keyTextFieldSearchBar = Key('text-field-search-bar');
const keyTextError = Key('text-error');
const keyListWidgetItemsData = Key('list-page-items-data');
const keyButtonSearchPageAdd = Key('button-search-page-add');
const keyProgressIndicatorMain = Key('progress-indicator-main');

const urlCultivationChambers = '$serverUrl/cultivation_chambers';
