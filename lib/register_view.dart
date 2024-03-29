import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 30,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title:Padding(
        //   padding: EdgeInsets.only(top: 30),
        //   child: Center(
        //     child: Text("Sign Up",style: TextStyle(
        //       fontSize: 25,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.blue,
        //   ),
        //   ),
        //   ),
        // ) ,
      ),
      body: BodyWidget(),
    );
  }
}
class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Let's Create Your Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(143, 148, 251, 1)),),
                SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                expands: false,
                                decoration:InputDecoration(
                                    labelText: "First Name",
                                    prefixIcon: Icon(Icons.person,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                ) ,
                              )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                                expands: false,
                                decoration:InputDecoration(
                                    labelText: "Last Name",
                                    prefixIcon: Icon(Icons.person,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                ) ,
                              )
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        expands: false,
                        decoration:InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person_2_outlined,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ) ,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        expands: false,
                        decoration:InputDecoration(
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.email,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ) ,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        expands: false,
                        decoration:InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ) ,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        expands: false,
                        decoration:InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.password,size: 30,color: Color.fromRGBO(143, 148, 251, 1),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ) ,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ]
                            )
                        ),
                        child: const Center(
                          child: Text("Create Account",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),

                ),

              ],
            )
            
        ),
      ),
    );
  }
}
