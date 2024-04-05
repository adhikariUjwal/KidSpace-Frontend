import 'package:flutter/material.dart';
import 'package:kidspace/Services/rhymes.dart';
import 'package:kidspace/Widgets/Rhyme/all_rhymes.dart';
import 'package:kidspace/Widgets/Rhyme/video_player.dart';

class RhymesVideoScreen extends StatefulWidget {
  final String selectedVideoUrl;
  final int videoId;
  const RhymesVideoScreen(
      {super.key, required this.videoId, required this.selectedVideoUrl});

  @override
  State<RhymesVideoScreen> createState() => _RhymesVideoScreenState();
}

class _RhymesVideoScreenState extends State<RhymesVideoScreen> {
  bool isLoading = true;

  //Getting All Rhymes Data
  var rhymes = [];
  getRhymesData() async {
    var res = await RhymesServices().getRhymes();
    if (mounted && res != false) {
      setState(() {
        rhymes = res;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getRhymesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(163, 0, 72, 255),
      body: SafeArea(
        child: ListView(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayerWidget(
                    selectedVideoUrl: widget.selectedVideoUrl,
                    videoId: widget.videoId)),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'All Rhymes',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            isLoading
                ? Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : AllRhymesContainer(
                    rhymes: rhymes,
                  )
          ],
        ),
      ),
    );
  }
}
