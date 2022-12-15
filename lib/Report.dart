import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:practice_2/homepage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);

  final controller = ScreenshotController();

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.','-').replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }


  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: controller,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF161654),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('Prescription',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),),
            ),
            centerTitle: true,
          ),



          body : SafeArea(
            child: Column(
              children: [


                Container(
                  height: 80,

                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 40.0,
                        child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 200.0,
                              width: 100.0,
                              fit: BoxFit.fill,
                            ))),
                  ),
                ),
                SizedBox(height: 2.0),

                Container(
                  //    height: 200,
                  //                 padding: EdgeInsets.only(
                  //                   top: MediaQuery.of(context).size.height * 0.2),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50, bottom: 20),
                            child: Container(
                              height: 380,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  shrinkWrap: true,
                                  itemCount: HomePage.mediList.length,
                                  itemBuilder: (context, index){
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      child: Text(
                                      HomePage.mediList[index],
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue.shade900,
                                              ),
                                            ),




                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 2.0),

                           SizedBox(
                             height: 50 ,
                             width: 200 ,
                             child: FloatingActionButton(
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(40.0))
                               ),
                               backgroundColor: const Color(0xFF161654),

                                    onPressed: () async {
                                      final image =  await controller.capture();
                                      if (image == null) return;
                                      await saveImage(image);
                                    },
                                    child:  Text("Capture Screen", style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ), ),

                                  ),
                           ),


                        ]
                    )
                )




              ],
            ),


          ),
        )
    );



  }
}




