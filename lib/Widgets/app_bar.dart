import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Define a fixed size
}

class _CustomAppBarState extends State<CustomAppBar> {
  String userName = "Guest";
  String accountImg = "";
  @override
  void initState() {
    super.initState();
    // _loadUserInfo();
  }

  // _loadUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? fullName = prefs.getString('accountName');

  //   if (fullName != null) {
  //     List<String> nameParts = fullName.split(' ');
  //     setState(() {
  //       if (nameParts.isNotEmpty) {
  //         setState(() {
  //           userName = nameParts[0];
  //           accountImg = prefs.getString('accountImg')!;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      leading: Row(
        // Wrap leading with a Row
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => const Account()));
              // },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  // backgroundImage: NetworkImage(Api().fileApi + accountImg),
                  radius: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
