import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../todowap_app.dart';
import '../../database/db_todowap.dart';
import '../../ui/base_state/base_state_singleton.dart';
import 'env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.i.load();

  BaseStateSingleton(baseUrl: Env.i['base_url_dev']!, flavor: Flavors.dev);

  await MyDbTodoWap().initializeDB();

  await initializeDateFormatting('pt_BR', '');

  runApp(const TodoWapApp());
}
