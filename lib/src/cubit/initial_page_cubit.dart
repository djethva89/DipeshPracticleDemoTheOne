import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theone_dipeshpracticle/features/controller/api_controller.dart';

import '../../models/video_list_response.dart';

part 'initial_page_state.dart';

class InitialPageCubit extends Cubit<InitialPageState> {
  InitialPageCubit() : super(InitialPageInitial()) {
    if (state is InitialPageInitial) {
      emit(InitialPageShowLoading());
      getVideoListData();
    }
  }

  getVideoListData() async {
    var response =
        await ApiController().getVideoList('1FEOTw_ioZ4SR4Iq5UxqsqcEgKAg3bNtX');
    if (kDebugMode) {
      print('InitialPageCubit called :: $response');
    }
    if (response.toString().isNotEmpty && response.toString() != 'Error') {
      VideoListResponse videoListResponse =
          VideoListResponse.fromJson(jsonDecode(response));

      emit(InitialPageSuccessWithHideLoading(
          (videoListResponse.categories ?? []).first.videos ?? []));
    }
  }
}
