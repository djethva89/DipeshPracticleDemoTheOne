import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theone_dipeshpracticle/locator/locator.dart';
import 'package:video_player/video_player.dart';

import 'cubit/video_player_cubit.dart';

class VideoPlayerPage extends StatelessWidget {
  final Map<String, String> arguments;

  const VideoPlayerPage(this.arguments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text('Video Player'),
          centerTitle: true,
        ),
      ),
      body: arguments.isEmpty
          ? const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : BlocProvider(
              create: (context) => locator.get<VideoPlayerCubit>(),
              child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                  builder: (context, state) {
                if (kDebugMode) {
                  print('VideoPlayerPage  ${state.toString()} : $arguments');
                }
                if (state is VideoPlayerLoading) {
                  final String videoID = arguments['video_id'] ?? '';
                  context.read<VideoPlayerCubit>().loadController(videoID);
                }
                if (state is VideoPlayerControllerLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio:
                            state.videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(state.videoPlayerController),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('${arguments['title']}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('${arguments['subtitle']}',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('${arguments['description']}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  );
                }

                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
            ),
    );
  }
}
