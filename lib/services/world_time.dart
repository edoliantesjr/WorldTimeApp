import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? time ;
  String? location;
  String? url;
  String? flag;
  bool? isDayTime;

  WorldTime({this.time,this.location,this.flag,this.url,this.isDayTime});
  
  Future <void> getTime() async{
    try{
      Uri? api= Uri.tryParse('https://worldtimeapi.org/api/timezone/$url');
      Response response= await get(api!);
      Map data= jsonDecode(response.body);
      //print(data);
      //get data properties
      String? datetime=data['datetime'];
      String? offset=data['utc_offset'].substring(1,3);
      int? numOffset=int.tryParse(offset!);
      DateTime? now = DateTime.tryParse(datetime!);

      //update time, add offset value to gain timezone time accuracy
      now= now!.add(Duration(hours: numOffset!));

      //condition to know if it is daytime or not
      isDayTime=now.hour>=6 && now.hour<=17 ? true: false;

      time= DateFormat('hh:mm:ss a').format(now);
    }catch(e){
      print(e);
      time='no data has been passed';
    }
  }
  
}

