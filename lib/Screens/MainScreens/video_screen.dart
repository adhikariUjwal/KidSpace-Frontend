import 'package:flutter/material.dart';
import 'package:kidspace/Services/api.dart';
import 'package:kidspace/Services/rhymes.dart';
import 'package:kidspace/Widgets/RhymeScreen/all_rhymes.dart';
import 'package:kidspace/Widgets/search_bar.dart';

class Rhymes extends StatefulWidget {
  const Rhymes({super.key});

  @override
  State<Rhymes> createState() => _RhymesState();
}

class _RhymesState extends State<Rhymes> with TickerProviderStateMixin {
  var fileUrl = Api().fileApi;

  bool isPlaying = false;
  bool isLoading = true;
  bool isSearching = false;
  var filteredRhymes = [];

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

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

  void _onSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredRhymes = rhymes;
      } else {
        filteredRhymes = rhymes
            .where((rhyme) =>
                rhyme['title'].toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
      isSearching = searchText.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(57, 165, 208, 0.647),
          // appBar: const Appbar(),
          // endDrawer: const CustomDrawer(),
          floatingActionButton: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/icons/chatButton.png',
                width: 25,
                height: 25,
              )),
          body: SingleChildScrollView(
            child:
                //Main Container
                Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
              child: isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : rhymes.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                child: Image.asset(
                                  "assets/defaults/no.jpg",
                                  colorBlendMode: BlendMode.multiply,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'No rhymes to show',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            //1st Container
                            CustomSearchBar(
                              onSearch: _onSearch,
                            ),
                            const SizedBox(height: 15),
                            //Filtered Rhymes
                            if (isSearching)
                              FilteredRhymes(filteredRhymes: filteredRhymes),
      
                            if (!isSearching)
                              //Recently Played + All Rhymes
                              SizedBox(
                                child: Column(
                                  children: [
                                    //Recently Played
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Recently Played',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 10),
                                            // Horizontal scrollable items
                                            // RecetlyPlayed(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    //All Rhymes
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'All Rhymes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // Horizontal scrollable items
                                            AllRhymesContainer(
                                              rhymes: rhymes,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
            ),
          )),
    );
  }
}
