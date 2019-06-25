import 'dart:math';

import 'package:test/test.dart';
class Action{
  String name;
  int id;
  String description;
  DateTime startTime;
  DateTime nextTime;
  Action(this.name,this.id,this.description,this.startTime);

}


class Actions{
  List <Action>acts;
  Actions():
      acts = [];

  void addAction(Action someAction) {
    acts.add(someAction);
  }

  int get numberOfActions => acts.length;

  getListActions(bool ask,num offset,num limit){
    var res = <Action>[];
    res.addAll(acts);
    if (ask == true){
      res.sort((a, b) => a.startTime.compareTo(b.startTime));
      return res.getRange(offset,offset + limit);
    } else {
      res.sort((a, b) => b.startTime.compareTo(a.startTime));
      return res.getRange(offset,offset + limit);
    }
  }

  Action getActionById(int someId){
    return acts.firstWhere((i) => i.id == someId);
  }

  void delActionById(int someId){
    var actionIndex = acts.lastIndexWhere((i) => i.id == someId);
    acts.removeAt(actionIndex);
  }
}

void main(){
  var vdnx = Action('VDNX',121,'interesting',DateTime(2019,6,21));
  var fue = Action('Festival ulichoi edi',122,'tasty',DateTime(2019,6,10));
  var vinefestival = Action('Festival of wine',123,'alcoholic',DateTime(2019,5,25));
  var raceOfNations = Action('Race Of Nations',124,'sport',DateTime(2019,5,30));
  var festi = Actions();
  test("check add method",(){  
      // Arrange 
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
     bool expected = festi.numberOfActions == festi.acts.length;
     bool actual = true;
     expect(actual,expected);

   }); 
   test("check getListActions with 0 length",(){
     var testfesti = Actions();
     bool expected = testfesti.getListActions(true,0,0).length == 0;
     var actual = true;
     expect(actual,expected);

   });


}
