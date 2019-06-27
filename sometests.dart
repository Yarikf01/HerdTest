import 'suwnost`.dart';
import 'package:test/test.dart';
void main() {
  test("check add method",(){  
      // Arrange 
      var festi = Actions();
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
   group("check getListFromTo method",(){
      var fue = Action('Festival ulichoi edi',122,'tasty',1,DateTime(2019,7,05));
      var buhta = Action('BoohtaFoodStation',991,'supertasty',0,DateTime(2019,6,30));
      var dr = Action('my dr',992,'cool',7,DateTime(2019,6,20));
      var bodich = Action('Bodich',993,'super cool',2,DateTime(2019,6,25));

      var festi = Actions();
      festi.addAction(bodich);
      festi.addAction(buhta);
      festi.addAction(dr);
      festi.addAction(fue);
      var res = festi.getListFromTo(true,DateTime(2019,6,25),DateTime(2019,7,08));
      test("numbers of elements",(){
        expect(13,res.length);
      });
      test("strange Datetimes",(){
        var res = festi.getListFromTo(true,DateTime(2077,6,25),DateTime(2077,7,08));
        expect(20, res.length);

      });
      test("objects in the middle of limits",(){
         var dr = Action('my dr',992,'cool',7,DateTime(2019,6,20));
         var bodich = Action('Bodich',993,'super cool',2,DateTime(2019,6,25));
         var actions = Actions();
         actions.addAction(dr);
         actions.addAction(bodich);
         res = actions.getListFromTo(true,DateTime(2019,6,15),DateTime(2019,6,30));
         expect(5,res.length);
      });

      



   });
}