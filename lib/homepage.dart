import 'package:practice_2/welcomeScreen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:practice_2/Report.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static List<String> mediList=[];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _speechToText = stts.SpeechToText();

  bool islistening = false;
  String text = "";


  void listen() async{
    if (!islistening){
      bool available = await  _speechToText.initialize(
          onStatus: (status) => print("$status"),
          onError: (errorNotification) => ("$errorNotification")
      );
      if (available){
        setState(() {
          islistening= true;
        });
        _speechToText.listen(
          onResult: (result) => setState(() {
            text = result.recognizedWords;
          }),
        );
      }
    }
    else{
      setState(() {

        islistening = false;
        if(!text.isEmpty){
          HomePage.mediList.add(text);
        }                                                                                                                                                                                                                                                                  

            text = "";


        //
        // if(text.isEmpty){
        //   listen();
        // }
        // else if (HomePage.mediList.length == 0)
        //   {
        //     HomePage.mediList.add(text);
        //   }

        // else if (text == HomePage.mediList[HomePage.mediList.length - 1]) {
        //   text = "";
        //   islistening = false;
        //   listen();
        // }
        // else{
        //   HomePage.mediList.add(text);
        //   text="";
        // }


      });
      _speechToText.stop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speechToText = stts.SpeechToText();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
            )),

        child: Scaffold(
          backgroundColor: Colors.transparent,


          body: Stack(
            children : [
              Column(
                children: [

                  SizedBox(height: 60),

                  RichText(

                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Press ",


                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,


                            )

                        ),
                        WidgetSpan(
                          child: Icon(Icons.mic, size: 28, color: Colors.white),
                        ),
                        TextSpan(
                            text: " to get started",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              //       fontFamily: 'Montserrat'
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //           text: text,
                  //           style: TextStyle(
                  //               fontSize: 30,
                  //               fontFamily: 'Montserrat',
                  //               fontWeight: FontWeight.w500
                  //
                  //           )
                  //
                  //       ),
                  //
                  //
                  //
                  //       // TextSpan(
                  //       //     text: ".... ",
                  //       //     style: TextStyle(
                  //       //       fontSize: 28,
                  //       //       //       fontFamily: 'Montserrat'
                  //       //     )
                  //       // ),
                  //     ],
                  //   ),
                  // ),

            SizedBox(
              height: 100,
              child: Visibility(
                visible: islistening,
                child: text.isEmpty ?
                OverflowBox(
                  minHeight: 100,
                  minWidth: 100,
                  child: Lottie.asset("assets/animations/soundo.json"),
                ):
                Text(text, style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),)
              ),
            ),

                  SizedBox(
                    height: 2,
                  ),
                  Expanded( child:  ListView.builder(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: HomePage.mediList.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 4),
                          child: MaterialButton(
                            onPressed: () {

                            },
                            color: Colors.white,
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              HomePage.mediList[index],
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        );
                      }))
                ],
              ),


            ],
          ),
          /* floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AvatarGlow(

        animate: islistening,
        repeat: true,
        endRadius: 20,
        duration: Duration(milliseconds: 2000),
        glowColor: Colors.grey,
        child: FloatingActionButton(
          onPressed: (){
            listen();
          },
          child: Icon(islistening ? Icons.mic : Icons.mic_none),
        ),
      ),*/
          floatingActionButton: Wrap( //will break to another line on overflow
            direction: Axis.vertical, //use vertical to show  on vertical axis
            children: <Widget>[

              AvatarGlow(
                animate: islistening,
                repeat: true,
                endRadius: 40,
                duration: Duration(milliseconds: 2000),
                glowColor: Colors.orangeAccent,
                child: FloatingActionButton(
                  onPressed: (){
                    listen();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(islistening ? Icons.mic : Icons.mic_none, color: Colors.blue.shade900, size: 30,),
                ),
              ), // button second

              Container(
                margin:EdgeInsets.all(10),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),

                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        context: context,
                        builder: (context){
                          return Container(
                            height: 200,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListTile(
                                    leading: Icon(Icons.delete,
                                      color: Colors.blue.shade900,),
                                    title: Text("Delete Last Entry",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue.shade900,
                                      ),),
                                    onTap: (){

                                      setState(() {
                                        HomePage.mediList.removeLast();
                                      });

                                    } ,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListTile(
                                    leading: Icon(Icons.clear_all,
                                      color: Colors.blue.shade900,),
                                    title: Text("Clear Screen",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue.shade900,
                                      ),),
                                    onTap: (){
                                      setState(() {
                                        HomePage.mediList = [];
                                      });

                                    } ,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ListTile(
                                    leading: Icon(Icons.print,
                                      color: Colors.blue.shade900,),
                                    title: Text("Generate Report",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue.shade900,
                                      ),),
                                    onTap: () => Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (context) => Report())),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                    );
                  },

                  backgroundColor: Colors.deepOrangeAccent,
                  child: Icon(Icons.check),


                ),

              ), // button third

              // Add more buttons here
            ],
          ),



        ));

  }
}
