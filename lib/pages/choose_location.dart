import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Manila',location: 'Manila',flag: 'ph.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
  ];

  void updateTime(index) async{
    WorldTime? instance;
    try{
      instance= locations[index];
      await instance.getTime();
      //navigate to home screen
      Navigator.pop(context, {
        'location': instance.location,
        'time': instance.time,
        'flag': instance.flag,
        'url': instance.url,
        'isDayTime':instance.isDayTime,
      });
    }
    catch(e){
      instance!.time='Err. No Connection';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose A Location'),
        elevation: 0,
      ),
      body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: ( context,index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: (){
                      try {
                        updateTime(index);
                      }catch(e){}
                    },
                    title: Text(
                        '${locations[index].location}',
                    ),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey[300],
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/${locations[index].flag}'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              );
            },
        )
    );
  }
}
