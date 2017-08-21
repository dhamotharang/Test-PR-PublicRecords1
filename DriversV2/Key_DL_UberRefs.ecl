import AutoKey;
tab:=DriversV2.File_uber_in;   
 word_tab := DriversV2.File_uber_word_in;
 //INVERSION TABLE
   AutoKey.Layout_uber.ref_rec add_id(tab le,word_tab ri) := transform
       self.word_id := ri.id;
       self := le;
     end;
   
   inv_tab := JOIN(tab,word_tab,LEFT.word =RIGHT.word,add_id(LEFt,RIGHT),local);
 
export Key_DL_UberRefs :=INDEX(inv_tab, {inv_tab},{}, DriversV2.Constants.autokey_qa_Keyname+'UberRefs',SORTED);