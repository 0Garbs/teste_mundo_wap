import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/core/config/env/env.dart';
import 'app/core/database/db_todowap.dart';
import 'app/todowap_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.i.load();
  
  await MyDbTodoWap().initializeDB();

  await initializeDateFormatting('pt_BR', '');

  runApp(const TodoWapApp());
}
