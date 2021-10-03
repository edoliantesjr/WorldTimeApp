import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    //print('$data');

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Color(0xFF1288C8) : Color(0xFF282761);
    String? time = data['time'];

    // void updateTime() async{
    //   WorldTime instance=WorldTime(location: '${data['location']}',url: '${data['url']}',flag: '${data['ph.png']}');
    //   await instance.getTime();
    //   time=instance.time;
    //   print(time);
    //   //print('${instance.location},${instance.url}');
    //   }

    void updateTime1() {
      DateTime? now = DateFormat('hh:mm:ss aa').parse(time!);
      time = DateFormat('hh:mm:ss a').format(now.add(Duration(seconds: 1)));
      print(now);
      print(time);
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 160, 10, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                    await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'url': result['url'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    size: 25,
                    color: Colors.grey[200],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                  updateTime1();

                  return Text(
                    '$time',
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  );
                }),

                // Text(
                //
                //     "$time",
                //   style: TextStyle(
                //     fontSize: 48,
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
