import 'dart:core';

import 'package:intl/intl.dart';

final formatter = new DateFormat.yMMMEd('mk');
final formatterShort = new DateFormat.yMd('mk');
final formatterWithTime = new DateFormat('EEE, d MMM yyyy, HH:mm', 'mk');
final formatterTimeOnly = new DateFormat.Hm('mk');
final jsonFormatter = new DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');

final DateTime today = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

