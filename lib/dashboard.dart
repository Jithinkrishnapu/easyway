import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  Dashboard({this.app});
  final FirebaseApp app;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _referenceData = FirebaseDatabase.instance;
  DateTime _date;
  Query dataRef;
  int count;
  @override
  void initState() {
    // final FirebaseDatabase database =FirebaseDatabase(app: widget.app);
    dataRef=FirebaseDatabase.instance.reference().child('orders').orderByChild('isDelivered').equalTo(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildorder({Map orders}){
      return Center(child: Text(orders['isDelivered'].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),));
    }
    final ref = _referenceData.reference();
    var _height=MediaQuery.of(context).size.height;
    var _width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard",style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(29.0),
            child: GestureDetector(
              onTap: (){
                showDatePicker(context: context, initialDate: _date == null?DateTime.now():_date, firstDate: DateTime(2018), lastDate: DateTime(2022)
                ).then((value){
                  setState((){
                    _date=value;
                  });
                });

              },
              child: Container(
                height: _height*.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: Offset(4.0,4.0),
                    )
                  ]
                ),
                padding: EdgeInsets.all(10),

                child: FittedBox(
                  child: Text(_date == null ?DateFormat.yMMMMEEEEd().format(DateTime.now()).toString():DateFormat. yMMMMEEEEd().format(_date).toString(),
                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29,right: 14),
            child: Text("Production Efficiency & Order Taken",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 23,fontFamily: 'Lato'
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: _height*.3,
                width: _width*.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(4.0,4.0),
                      )
                    ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Hours",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.lightBlue,fontFamily: 'Lato'),
                    ),
                        SizedBox(height: 20,),
                        Text("25",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Divider(
                          color: Colors.white,
                          indent: _height/13,
                          endIndent: _width/8,
                          thickness: 4,
                        ),
                        Text("30",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)

                  ],
                ),
              ),
              SizedBox(width: 25,),
              Container(
                height: _height*.3,
                width: _width*.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(4.0,4.0),
                      )
                    ]
                ),
              ),
            ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29,right: 29,top: 20,bottom: 29),
            child: Container(
              height: _height*.23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: Offset(4.0,4.0),
                    )
                  ]
              ),
              child: FirebaseAnimatedList(
                query: dataRef,itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index){
                  // count=snapshot.value;
                Map orders=snapshot.value;

                  return buildorder(orders:orders.length as Map );
              },
              )
            ),
          )
        ],
      ),
    );
  }
}

