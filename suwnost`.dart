class Action{
  int id;
  String description;
  DateTime startTime;
  Action(this.id,this.description,this.startTime);

}


class Actions{
  List <Action>acts;
  Actions():
      acts = [];

  void addAction(Action someAction) {
    acts.add(someAction);
  }

  int get numberOfActions => acts.length;

  getListActions(){
    var res = <Action>[];
    res.addAll(acts);
    res.sort((a, b) => a.startTime.compareTo(b.startTime));
    return res;
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
  var vdnx = Action(123,'interesting',DateTime(2019,6,21));
  var fue = Action(121,'tasty',DateTime(2019,6,10));
  var festi = Actions();
  festi.addAction(vdnx);
  festi.addAction(fue);
  print(festi);

  for (var act in festi.getListActions()){
    print(act.id);
  }
  
  print(festi.numberOfActions);
  var a = festi.getActionById(123);
  print(a.description);
  festi.delActionById(123);

  for (var act in festi.getListActions()){
    print(act.id);
  }

}
