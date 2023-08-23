import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:theone_dipeshpracticle/features/controller/api_controller.dart';
import 'package:theone_dipeshpracticle/src/cubit/initial_page_cubit.dart';

import '../features/datasource/network_repo_impl.dart';
import '../features/repo/network_repo.dart';
import '../src/player/cubit/video_player_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  setUpCubit();

  locator.registerLazySingleton<NetworkRepo>(
      () => NetworkRepoImpl(client: locator()));
  locator.registerLazySingleton<ApiController>(() => ApiController());

  externalInjection();
}

setUpCubit() {
  locator.registerFactory(() => InitialPageCubit());
  locator.registerFactory(() => VideoPlayerCubit());
}

externalInjection() {
  final client = InterceptedClient.build(
    interceptors: [],
  );

  locator.registerLazySingleton(() => client);
}
