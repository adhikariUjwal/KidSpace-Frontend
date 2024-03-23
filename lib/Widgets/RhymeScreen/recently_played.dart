// import 'package:KidSpace/pages/rhymes_page/rhymes_video_screen.dart';
// import 'package:KidSpace/widgets/shimmer_container.dart';
// import 'package:KidSpace/services/api.dart';
// import 'package:KidSpace/services/recently_played.dart';
import 'package:flutter/material.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/rhymes.dart';
import 'package:kidspace/Widgets/shimmer_container.dart';

class RecetlyPlayed extends StatefulWidget {
  const RecetlyPlayed({super.key});

  @override
  State<RecetlyPlayed> createState() => _RecetlyPlayedState();
}

class _RecetlyPlayedState extends State<RecetlyPlayed> {
  bool dataLoaded = false;
  var fileUrl = Api().fileApi;

  bool isPlaying = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void initState() {
    getRecentRhymesData();

    super.initState();
  }

  // Getting All Rhymes Data
  var recentRhymes = [];
  getRecentRhymesData() async {
    var recentRes = await RhymesServices().getRecentPlayed();
    print("recentRes: $recentRes");
    if (mounted) {
      setState(() {
        recentRhymes = recentRes;
        dataLoaded = true;
      });
    }
  }

  getIndicator(id) async {
    await RhymesServices().getPoint(id);
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: dataLoaded
            ? recentRhymes.isEmpty
                ? const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "Your previously watched rhymes will appear here!"),
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentRhymes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            width: 338,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            //
                            child: InkWell(
                              onTap: () async {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => RhymesVideoScreen(
                                //       videoId: recentRhymes[index]['id'],
                                //       selectedvideoUrl: fileUrl +
                                //           recentRhymes[index]['rhyme'],
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                fileUrl +
                                                    recentRhymes[index]
                                                        ['image'],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20, top: 10),
                                                    child: Text(
                                                      'No any image',
                                                      style: TextStyle(
                                                          color: Colors.red),
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
                                            const Positioned(
                                              bottom:
                                                  0, // Adjust this value to position the indicator bar at the front bottom
                                              left:
                                                  0, // Align the indicator bar to the left
                                              right:
                                                  0, // Align the indicator bar to the right
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: LinearProgressIndicator(
                                                  value: 0.5,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 14,
                                                right: 8,
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            4)),
                                                            color:
                                                                Color.fromARGB(
                                                                    137,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(2.0),
                                                      child: Text(
                                                        '18:00',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          recentRhymes[index]['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(
                    width: MediaQuery.of(context).size.width,
                    height: 202,
                  ),
                  const SizedBox(height: 5),
                  const ShimmerContainer(
                    width: 100,
                    height: 20,
                  ),
                ],
              ));
  }
}
