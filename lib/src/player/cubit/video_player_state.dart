part of 'video_player_cubit.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();
}

class VideoPlayerInitial extends VideoPlayerState {
  @override
  List<Object> get props => [];
}

class VideoPlayerLoading extends VideoPlayerState {
  @override
  List<Object> get props => [];
}

class VideoPlayerControllerLoaded extends VideoPlayerState {
  final VideoPlayerController videoPlayerController;

  const VideoPlayerControllerLoaded(this.videoPlayerController);

  @override
  List<Object> get props => [videoPlayerController];
}

class VideoPlayerControllerError extends VideoPlayerState {
  const VideoPlayerControllerError();

  @override
  List<Object> get props => [];
}
