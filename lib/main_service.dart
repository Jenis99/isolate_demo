import 'dart:isolate';

void isolatedImportFunction(List<dynamic> sendPort) async {
  SendPort sendPort1 = sendPort[0];
  sendPort1.send('oparation started');

  print('text value ===>${sendPort[1]}');
  for (int i = 0; i < 100000; i++) {
    sendPort1.send(i);
    print('i value==> $i');
  }
}
