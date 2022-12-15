import 'package:flutter/material.dart';

import 'homepage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,

        body : Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/1.png'),
              fit: BoxFit.cover,
            ),
          ),


          child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height / 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        fontFamily: 'Montserrat',

                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'Doctor',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Start your new experience\nby tapping below',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Positioned(
              bottom: MediaQuery.of(context).size.height / 12,
              child: Padding(
                padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width / 6),
                child: SizedBox(
                  height:64, //height of button
                  width:220,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),

                    ),
                    backgroundColor: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Get Started", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                3,
                                0,
                                0,
                                0,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size:43,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                  ),
                ),
              ),

            ),

          ],

      ),
    ));



  }
}
