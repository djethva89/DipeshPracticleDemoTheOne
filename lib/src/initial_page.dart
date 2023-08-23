import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theone_dipeshpracticle/locator/locator.dart';
import 'package:theone_dipeshpracticle/models/video_list_response.dart';
import 'package:theone_dipeshpracticle/utils/constants.dart';

import 'cubit/initial_page_cubit.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<InitialPageCubit>(),
      child: BlocBuilder<InitialPageCubit, InitialPageState>(
          builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(title: const Text('Videos'), centerTitle: true,)),
          body: handelState(state),
        );
      }),
    );
  }
}

Widget handelState(InitialPageState state) {
  if (state is InitialPageSuccessWithHideLoading) {
    return bodyContent(state.videos);
  } else {
    return showLoading();
  }
}

Widget showLoading() {
  return const SizedBox(
    child: Center(child: CircularProgressIndicator()),
  );
}

Widget bodyContent(List<Videos> videos) {
  return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 200,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "${Constants.baseImageUrl}${videos[index].thumb}",
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress))),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 6.0),
                      child: Text('${videos[index].title}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                        onTap: () {
                          final videoId = (videos[index].sources ?? []).first;
                          if (videoId.isNotEmpty) {
                            Map<String, String> arguments = {
                              'video_id':videoId,
                              'title': videos[index].title??'',
                              'subtitle': videos[index].subtitle??'',
                              'description': videos[index].description??'',

                            };
                            Navigator.of(context)
                                .pushNamed('/player', arguments: arguments);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Video Not Found!')));
                          }
                        },
                        child: const Icon(
                          Icons.play_circle,
                          size: 60.0,
                        ))),
              ],
            ),
          ),
        );
      });
}
