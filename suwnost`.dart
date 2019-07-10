import 'dart:io';
import 'dart:math';
import 'package:date_utils/date_utils.dart';
class Action{
  var name;
  int id;
  String description;
  int daysCounter;
  DateTime startTime;
  Action(this.name,this.id,this.description,this.daysCounter,this.startTime);
}


class Actions{
  List <Action>acts;
  Actions():
      acts = [];
      List everyDayActs = <Action> [];
      List singleActs = <Action>[];
      List notEveryDayActs = <Action>[];
      
  void addAction(Action someAction) {
    acts.add(someAction);
    if (someAction.daysCounter > 1){
      notEveryDayActs.add(someAction);
    } else if (someAction.daysCounter == 1) {
      everyDayActs.add(someAction);

    }
    else {
      singleActs.add(someAction);
    }
  }

  int get numberOfActions => acts.length;
  sortir(List someList){
    someList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return someList;
  }

  getListActions(bool ask,num offset,num limit){
    List res = sortir(acts);
    if (ask == true){
      return res.getRange(offset,offset + limit);
    } else {
      return res.reversed.toList().getRange(offset,offset + limit);
    }
  }

  getListFromTo(bool ask,DateTime starttime,DateTime endtime){
      DateTime current = starttime;
    
      List res = [];

      for (var i in singleActs.where((i) => i.startTime.isAfter(current) & i.startTime.isBefore(endtime))){
        res.add(i);
      };
      for (var object in everyDayActs){

        if (object.startTime.isBefore(current)){
          int k = 0;

          while(k < everyDayActs.length){
            DateTime i = current;
            while(i.isBefore(endtime)){
              var a = Action(everyDayActs[k].name,everyDayActs[k].id,everyDayActs[k].description,everyDayActs[k].daysCounter,i);
              res.add(a);
              i = i.add(new Duration(days:1));
 
            }

            k += 1;
          }

        }else if (object.startTime.isAfter(current) & object.startTime.isBefore(endtime)){
          int k = 0;
          

          while(k < everyDayActs.length){
            DateTime i = everyDayActs[k].startTime;
            while(i.isBefore(endtime)){
              var a = Action(everyDayActs[k].name,everyDayActs[k].id,everyDayActs[k].description,everyDayActs[k].daysCounter,i);
              res.add(a);
              i = i.add(new Duration(days:1));
            }

            k += 1;
          }
        }
      }
      int k = 0;
      for (var object in notEveryDayActs){
        if (object.startTime.isBefore(current)){
          while(k < notEveryDayActs.length){
            DateTime i = current;
            while(i.isBefore(endtime)){
              var diff = i.difference(notEveryDayActs[k].startTime);

              if (diff.inDays % notEveryDayActs[k].daysCounter == 0){
                var a = Action(notEveryDayActs[k].name,notEveryDayActs[k].id,notEveryDayActs[k].description,notEveryDayActs[k].daysCounter,i);
                res.add(a);
              }

              i = i.add(new Duration(days:1));
            }

            k += 1;
          }
        }else if (object.startTime.isAfter(current) & object.startTime.isBefore(endtime)){
          
      
          while(k < notEveryDayActs.length){
            DateTime i = notEveryDayActs[k].startTime;
            while(i.isBefore(endtime)){
              var diff = i.difference(notEveryDayActs[k].startTime);
              if (diff.inDays % notEveryDayActs[k].daysCounter == 0){
                var a = Action(notEveryDayActs[k].name,notEveryDayActs[k].id,notEveryDayActs[k].description,notEveryDayActs[k].daysCounter,i);
                res.add(a);
              }
              i = i.add(new Duration(days:1));
            }
            k += 1;
          }
        }
      res = sortir(res);
      if (ask == true){
      return res;
      }else{
        return res.reversed.toList();
      }
  }

  Action getActionById(int someId){
    return acts.firstWhere((i) => i.id == someId);
  }

  void delActionById(int someId){
    var actionIndex = acts.lastIndexWhere((i) => i.id == someId);
    acts.removeAt(actionIndex);
  }

  show(someacts){
    List res = [];
    for (var object in someacts){
      res.add(object.startTime);
      res.add(object.name);
    }
    print(res);
  }
}}


void main(){
  var buhta = Action('BoohtaFoodStation',991,'supertasty',0,DateTime(2019,6,30));
  var dr = Action('my dr',992,'cool',7,DateTime(2019,6,20));
  var bodich = Action('Bodich',993,'super cool',2,DateTime(2019,6,25));


  var festi = Actions();
  festi.addAction(bodich);
  festi.addAction(buhta);
  festi.addAction(dr);
  var lst = [];
    for (var i in festi.getListFromTo(true, DateTime(2019,6,19),DateTime(2019,6,31))){
        lst.add(i.name);}

}

