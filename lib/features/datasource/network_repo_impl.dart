import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:theone_dipeshpracticle/features/repo/network_repo.dart';
import 'package:theone_dipeshpracticle/utils/constants.dart';

class NetworkRepoImpl extends NetworkRepo {
  final InterceptedClient client;

  NetworkRepoImpl({required this.client});

  @override
  Future<String> getVideoList(String id) {
    return _getVideoList(id);
  }

  Future<String> _getVideoList(String id) async {
    final response = await client.get(Uri.parse('${Constants.baseUrl}?id=$id'));

    if (kDebugMode) {
      print('Get Video List Response : ${response.body}');
    }
    if (response.statusCode == 200) {
      return response.body;
    }

    return Future.value('Error');
  }
}
