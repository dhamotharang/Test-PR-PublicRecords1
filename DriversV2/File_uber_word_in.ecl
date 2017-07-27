import ut,AutoKey;

tab:=DriversV2.File_uber_in;
word_values := UNGROUP(TABLE(GROUP(SORT(
   TABLE(GROUP(sort(tab,word,local),word),{word,unsigned8 cnt1:=COUNT(GROUP)},local)
   ,word),word),{word,unsigned8 cnt:=SUM(GROUP,cnt1),id:=0})); 
   
   words := PROJECT(word_values
                          ,TRANSFORM(AutoKey.Layout_uber.word_rec
   											 ,SELF := LEFT,SELF := []));
   
   typeof(words) tra(words lef,words ref) := transform
     self.id := if(lef.id=0,thorlib.node()+1,lef.id+thorlib.nodes());
     self := ref;
     end;

 export File_uber_word_in :=iterate(words,tra(left,right),local):PERSIST('~thor400_88_staging::dl::uber::uni_nominals');