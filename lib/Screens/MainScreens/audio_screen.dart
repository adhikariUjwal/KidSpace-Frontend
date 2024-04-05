import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/audio.dart';
import 'package:kidspace/Widgets/Audio/audio_player.dart';
import 'package:kidspace/Widgets/Audio/audio_prewiew.dart';
import 'package:kidspace/Widgets/Audio/story_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path/path.dart' as path;

class AudioStory extends StatefulWidget {
  const AudioStory({Key? key}) : super(key: key);

  @override
  State<AudioStory> createState() => _AudioStoryState();
}

class _AudioStoryState extends State<AudioStory> {
  var fileUrl = "${Api().fileApi}audio-image/";
  var fileUrlAudio = "${Api().fileApi}audios/";

  bool dataLoaded = false;
  List<dynamic> books = [];

  Future<void> getBooks() async {
    var res = await AudioService().getAudioStory(); // Assuming fetchBooks() method exists in AudioService class

    if (res != null) {
      setState(() {
        books = res;
        dataLoaded = true;
        print(res);
      });
    }
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(163, 0, 72, 255),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Audio Story',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 200,
                child: dataLoaded
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: books.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              
                              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioPlayeer(id: books[index]['id'].toString(),audioUrl:fileUrlAudio+ path.basename(books[index]['audio'])),
                      ),
                    );
                            },
                            child: Preview(
                              title: books[index]['title'],
                              img: fileUrl + path.basename(books[index]['image']),
                              type: "Audio Story",
                              contentType: "audio",
                            ),
                          );
                        },
                      ) 
                    : const StoryShimmer(), // Placeholder while data is loading
              )
            ],
          ),
        ),
      ),
    );
  }
}






