import 'package:flutter/material.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Widgets/Rhyme/video_screen.dart';
import 'package:kidspace/Widgets/shimmer_container.dart';
import 'package:path/path.dart' as path;

class AllRhymesContainer extends StatefulWidget {
  final int? id;
  final dynamic rhymes;
  const AllRhymesContainer({super.key, this.id, required this.rhymes});

  @override
  State<AllRhymesContainer> createState() => _AllRhymesContainerState();
}

class _AllRhymesContainerState extends State<AllRhymesContainer> {

  var fileUrl = "${Api().fileApi}videos/";
  var fileUrlImage = "${Api().fileApi}video-image/";

  bool isPlaying = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  String formatDuration(int durationInSeconds) {
    int minutes = durationInSeconds ~/ 60;
    int seconds = durationInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.rhymes.length,
      itemBuilder: (BuildContext context, int index) {
        // if (rhymes[index]['id'] != widget.id)
        return InkWell(
            onTap: () {},
            child: Container(
              width: 338,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  print(fileUrl + path.basename(widget.rhymes[index]['rhyme']));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RhymesVideoScreen(
                        videoId: widget.rhymes[index]['id'],
                        selectedVideoUrl:
                            fileUrl + path.basename(widget.rhymes[index]['rhyme']),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Card(
                        child: SizedBox(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  fileUrlImage + path.basename(widget.rhymes[index]['image']),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'No any image',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ); // Display fallback image on error.
                                  },
                                ),
                              ),
                              Center(
                                child: Container(
                                  width:
                                      40, // Set the width and height to control the size of the circle
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .white, // Set the background color to white to create a white circle
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 35, // Set the size of the play icon
                                      color: Colors
                                          .black, // Set the color of the play icon to black
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 14,
                                  right: 8,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: Color.fromARGB(137, 0, 0, 0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          widget.rhymes[index]['length']
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                        child:
                        Text("Rhyme Level: "+
                          widget.rhymes[index]['rhyme_level']['name'],
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      child: Text(
                        widget.rhymes[index]['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(color: Colors.white,)
                  ],
                ),
              ),
            ));
      },
    );
  }
}


class FilteredRhymes extends StatefulWidget {
  final List filteredRhymes;
  const FilteredRhymes({super.key, required this.filteredRhymes});

  @override
  State<FilteredRhymes> createState() => _FilteredRhymesState();
}

class _FilteredRhymesState extends State<FilteredRhymes> {
  bool dataLoaded = true;
  var fileUrl = "${Api().fileApi}video/";
  var fileUrlImage = "${Api().fileApi}video-image/";

  @override
  Widget build(BuildContext context) {
    return dataLoaded
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 9,
                crossAxisCount: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30),
            scrollDirection: Axis.vertical,
            itemCount: widget.filteredRhymes.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RhymesVideoScreen(
                      //       videoId: widget.filteredRhymes[index]['id'],
                      //       selectedvideoUrl: fileUrl +
                      //           widget.filteredRhymes[index]['rhyme'],
                      //     ),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Card(
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      fileUrlImage +
                                          path.basename(widget.filteredRhymes[index]['image']),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 10),
                                          child: Text(
                                            'No any image',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ); // Display fallback image on error.
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width:
                                          40, // Set the width and height to control the size of the circle
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .white, // Set the background color to white to create a white circle
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.play_arrow,
                                          size:
                                              35, // Set the size of the play icon
                                          color: Colors
                                              .black, // Set the color of the play icon to black
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 14,
                                      right: 8,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color:
                                                  Color.fromARGB(137, 0, 0, 0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              widget.filteredRhymes[index]
                                                      ['length']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          )))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8),
                          child: Text(
                            widget.filteredRhymes[index]['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 9,
                crossAxisCount: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 8),
            scrollDirection: Axis.vertical,
            itemCount: widget.filteredRhymes.length,
            itemBuilder: (context, index) {
              return const ShimmerContainer(
                width: 180,
                height: 250,
              );
            },
          );
  }
}
