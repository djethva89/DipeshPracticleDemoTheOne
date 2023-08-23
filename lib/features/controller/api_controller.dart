import '../../locator/locator.dart';
import '../repo/network_repo.dart';

class ApiController {
  getVideoList(String id) async {
    return locator.get<NetworkRepo>().getVideoList(id);
  }
}
