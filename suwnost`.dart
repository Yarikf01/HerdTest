class Action{
  int id;
  String description;
  DateTime start_time;
  Action(this.id,this.description,this.start_time);

}

class Actions{
  List acts;
  Actions():
      acts = [];

  void addAction(some_action) {
    acts.add(some_action);
  }
  int get number_of_actions => acts.length;
  get_list_actions(){
    var res = [];
    res.addAll(acts);
    res.sort((a, b) => a.start_time.compareTo(b.start_time));
    return res;
  }
  get_action_by_id(some_id){
    //var action = acts.where((p) => p.id == some_id);
    for (var act in acts){
      if ((act.id) == some_id){
        var action = act;
        return action;
        break;
    }
    }
  }
  void del_action_by_id(some_id){
    for (var act in acts){
      if ((act.id) == some_id){
        acts.remove(act);
        break;
      }
    }
  }
}
void main(){
  var vdnx = Action(123,'interesting',DateTime(2019,21,6));
  var fue = Action(121,'tasty',DateTime(2019,10,6));
  var festi = Actions();
  festi.add_action(vdnx);
  festi.add_action(fue);
  for (var act in festi.get_list_actions()){
    print(act.id);
  }
  print(festi.number_of_actions);
  var a = festi.get_action_by_id(123);
  print(a.description);
  festi.del_action_by_id(123);
  for (var act in festi.get_list_actions()){
    print(act.id);
  }

}
