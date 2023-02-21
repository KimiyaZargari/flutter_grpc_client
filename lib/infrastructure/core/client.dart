import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final clientProvider = ChangeNotifierProvider((ref) => ClientService());

class ClientService extends ChangeNotifier {

  final channel = ClientChannel('192.168.1.109',
      port: 50000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));
  late final EshopServiceClient stub;

  ClientService() {
    stub = EshopServiceClient(channel,
        options: CallOptions(timeout: const Duration(seconds: 30)));
  }

  @override
  void dispose() async {
    await channel.shutdown();
    super.dispose();
  }
}
