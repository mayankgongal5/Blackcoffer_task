import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:blackcoffer/Screens/record.dart';
import 'package:flutter/foundation.dart';

class MainScreen extends StatefulWidget {
   MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  int pageInx = 0;
  // late List<CameraDescription> cameras;
  // late CameraController cameraController;

  // @override
  // void initState() {
  //   startCamera();
  //   super.initState();
  // }
  //
  // void startCamera() async {
  //   cameras = await availableCameras();
  //   cameraController = CameraController(
  //     cameras[0],
  //     ResolutionPreset.high,
  //     enableAudio: true,
  //   );
  //   await cameraController.initialize().then((value) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   cameraController.dispose();
  //   super.dispose();
  // }

//   @override
//   Widget build(BuildContext context) {
//     try {
//       return Scaffold(
//         body: Stack(
//           children: [
//             CameraPreview(cameraController),
//           ],
//         ),
//       );
//     } catch (e) {
//       return  SizedBox();
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           SizedBox(
//
//           )
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations:  <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: OutlinedButton(
                onPressed: null,
                child: Icon(Icons.home_outlined)),
            label: 'Home',
          ),
          NavigationDestination(
            icon:
            OutlinedButton(
                onPressed: () async{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Record(
                          )));
                },
                child: Icon(Icons.add_a_photo)),
            label: 'Create',
          ),
          NavigationDestination(
            icon: OutlinedButton(
                onPressed: null,
                child: Icon(Icons.person)),
            label: 'Profile',
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Center(
            child: Text('Your page content here'),
          ),
        ),
      ),
    );
  }
}
