import 'dart:io';
import 'dart:math';
import 'package:test/test.dart';
import 'package:date_utils/date_utils.dart';
class Action{
  String name;
  int id;
  String description;
  int daysCounter;
  DateTime startTime;
  DateTime nextTime ;
  Action(this.name,this.id,this.description,this.daysCounter,this.startTime){
    this.nextTime = startTime;
  }
  

}


class Actions{
  List <Action>acts;
  Actions():
      acts = [];

  void addAction(Action someAction) {
    acts.add(someAction);
    if (someAction.daysCounter > 0){
      for (int i = 1;i <= 1000;i++){
        var a = new Action(someAction.name,someAction.id,someAction.description,someAction.daysCounter,someAction.startTime);
        a.nextTime = a.nextTime.add(new Duration(days:i * a.daysCounter));
        acts.add(a);
      }
    }

  }

  int get numberOfActions => acts.length;

  getListActions(bool ask,num offset,num limit){
    List res = <Action>[];
    res.addAll(acts);
     res.sort((a, b) => a.startTime.compareTo(b.startTime));
    if (ask == true){
      return res.getRange(offset,offset + limit);
    } else {
      return res.reversed.toList().getRange(offset,offset + limit);
    }
  }
  getListFromNow(){
    DateTime current = DateTime.now();
    List res = <Action>[];
    res.addAll(acts);
    res.sort((a, b) => a.nextTime.compareTo(b.nextTime));
    return res.where((i) => i.nextTime.isAfter(current));
  }
  getListFromTo(bool ask,DateTime starttime,DateTime endtime){
    DateTime current = starttime;
    List res = <Action>[];
    res.addAll(acts);
    if (ask == true){
      res.sort((a, b) => a.nextTime.compareTo(b.nextTime));
      return res.where((i) => i.nextTime.isAfter(current) & i.nextTime.isBefore(endtime));
    } else {
      res.sort((a, b) => a.nextTime.compareTo(b.nextTime));
      return res.where((i) => i.nextTime.isAfter(endtime) & i.nextTime.isBefore(current));
    }

  }

  Action getActionById(int someId){
    return acts.firstWhere((i) => i.id == someId);
  }

  void delActionById(int someId){
    var actionIndex = acts.lastIndexWhere((i) => i.id == someId);
    acts.removeAt(actionIndex);
  }
  void show(){
    List res = [];
    for (var object in acts){
      res.add(object.nextTime);
      res.add(object.name);
    }
    print(res);
  }
}

void main(){
  var fue = Action('Festival ulichoi edi',122,'tasty',7,DateTime(2019,6,26));
  var festi = Actions();
  festi.addAction(fue);
  for (var object in festi.getListFromTo(true,DateTime(2019,6,25),DateTime(2019,7,08))){
    print(object.nextTime);
    print(object.name);
  }
  var date = new DateTime(2017, 3);
  var lastDay = Utils.lastDayOfMonth(date);
  print(lastDay.day);

  test("check add method",(){  
      // Arrange 
      var vdnx = Action('VDNX',121,'interesting',1,DateTime(2019,7,08));
      festi.addAction(vdnx);
      bool expected = true;
      var a = festi.acts.firstWhere((i) => i == vdnx,orElse:() => null); 
      if (a == null){
        expected = false;
      }
      // Act 
      var actual = true;
      // Asset 
      expect(actual,expected); 
   });

   test("check number of actions",(){
     var festi1 = Actions();
     var vinefestival = Action('Festival of wine',123,'alcoholic',0,DateTime(2019,5,25));
     festi1.addAction(vinefestival);
     bool expected = festi1.numberOfActions == festi1.acts.length;
     bool actual = true;
     expect(actual,expected);
   }); 

   test("check getListActions with 0 length",(){
     var testfesti = Actions();
     bool expected = testfesti.getListActions(true,0,0).length == 0;
     var actual = true;
     expect(actual,expected);
   });

  test("check equality startTime and nextTime",(){
     var raceOfNations = Action('Race Of Nations',124,'sport',1,DateTime(2019,5,30));
     var expected = raceOfNations.startTime;
     var actual = raceOfNations.nextTime;
     expect(actual,expected);
   });

   test("check getListFromTo method",(){
     var someEvents = Actions();
     var someEvent = Action('notInterestingEvent',125,'thing',0,DateTime(2019,6,27));
     someEvents.addAction(someEvent);
     var expected = Action('123',126,'1234',0,DateTime(2023,9,29));
     for (var i in someEvents.getListFromTo(true,DateTime(2019,6,26),DateTime(2019,6,28))){
       expected = i;
     }
     var actual = someEvent;
     expect(actual,expected);
   });


}
