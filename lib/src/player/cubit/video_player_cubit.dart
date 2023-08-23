import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  late VideoPlayerController controller;

  VideoPlayerCubit() : super(VideoPlayerInitial()) {
    if (state is VideoPlayerInitial) {
      emit(VideoPlayerLoading());
    }
  }

  loadController(String videoId) {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoId))
      ..initialize().then((value) {
        if (controller.value.isInitialized) {
          controller.play();
          emit(VideoPlayerControllerLoaded(controller));
        } else {
          emit(const VideoPlayerControllerError());
        }
      });
  }

  @override
  Future<void> close() async {
    await controller.dispose();
    return super.close();
  }
}
