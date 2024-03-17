import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:get/get.dart';

import 'main_service.dart';

class BackupController {
  String text = "";
  RxInt val = 0.obs;

  // VALIDATOR FUNCTION
  Future<void> import() async {

    // RECEIVE PORT FOR RESULTS
    ReceivePort receivePort = ReceivePort();

    // COMPLETER
    var isDone = Completer();

    // LISTENER
    receivePort.listen(
      (message) async {
        print('print from controller ==> $message');
        val.value = message;
      },
      onDone: () {
        isDone.complete();
      },
    );

    // BATCH OBJECTS FOR IMPORTING
    await Isolate.spawn(
      isolatedImportFunction,
      [receivePort.sendPort, text],
    );
    await isDone.future;
    return;
  }
}
