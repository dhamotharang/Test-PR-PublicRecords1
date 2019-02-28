IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 22;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'fipscode','statefips','countyfips','courtid','consolidatedcourtid','masterid','stateofservice','countyofservice','courtname','phone','address1','address2','city','state','zipcode','zip4','mailaddress1','mailaddress2','mailcity','mailctate','mailzipcode','mailzip4');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'fipscode' => 0,'statefips' => 1,'countyfips' => 2,'courtid' => 3,'consolidatedcourtid' => 4,'masterid' => 5,'stateofservice' => 6,'countyofservice' => 7,'courtname' => 8,'phone' => 9,'address1' => 10,'address2' => 11,'city' => 12,'state' => 13,'zipcode' => 14,'zip4' => 15,'mailaddress1' => 16,'mailaddress2' => 17,'mailcity' => 18,'mailctate' => 19,'mailzipcode' => 20,'mailzip4' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_fipscode(SALT311.StrType s0) := s0;
EXPORT InValid_fipscode(SALT311.StrType s) := 0;
EXPORT InValidMessage_fipscode(UNSIGNED1 wh) := '';
 
EXPORT Make_statefips(SALT311.StrType s0) := s0;
EXPORT InValid_statefips(SALT311.StrType s) := 0;
EXPORT InValidMessage_statefips(UNSIGNED1 wh) := '';
 
EXPORT Make_countyfips(SALT311.StrType s0) := s0;
EXPORT InValid_countyfips(SALT311.StrType s) := 0;
EXPORT InValidMessage_countyfips(UNSIGNED1 wh) := '';
 
EXPORT Make_courtid(SALT311.StrType s0) := s0;
EXPORT InValid_courtid(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtid(UNSIGNED1 wh) := '';
 
EXPORT Make_consolidatedcourtid(SALT311.StrType s0) := s0;
EXPORT InValid_consolidatedcourtid(SALT311.StrType s) := 0;
EXPORT InValidMessage_consolidatedcourtid(UNSIGNED1 wh) := '';
 
EXPORT Make_masterid(SALT311.StrType s0) := s0;
EXPORT InValid_masterid(SALT311.StrType s) := 0;
EXPORT InValidMessage_masterid(UNSIGNED1 wh) := '';
 
EXPORT Make_stateofservice(SALT311.StrType s0) := s0;
EXPORT InValid_stateofservice(SALT311.StrType s) := 0;
EXPORT InValidMessage_stateofservice(UNSIGNED1 wh) := '';
 
EXPORT Make_countyofservice(SALT311.StrType s0) := s0;
EXPORT InValid_countyofservice(SALT311.StrType s) := 0;
EXPORT InValidMessage_countyofservice(UNSIGNED1 wh) := '';
 
EXPORT Make_courtname(SALT311.StrType s0) := s0;
EXPORT InValid_courtname(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtname(UNSIGNED1 wh) := '';
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_address1(SALT311.StrType s0) := s0;
EXPORT InValid_address1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address1(UNSIGNED1 wh) := '';
 
EXPORT Make_address2(SALT311.StrType s0) := s0;
EXPORT InValid_address2(SALT311.StrType s) := 0;
EXPORT InValidMessage_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zipcode(SALT311.StrType s0) := s0;
EXPORT InValid_zipcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_mailaddress1(SALT311.StrType s0) := s0;
EXPORT InValid_mailaddress1(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailaddress1(UNSIGNED1 wh) := '';
 
EXPORT Make_mailaddress2(SALT311.StrType s0) := s0;
EXPORT InValid_mailaddress2(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailaddress2(UNSIGNED1 wh) := '';
 
EXPORT Make_mailcity(SALT311.StrType s0) := s0;
EXPORT InValid_mailcity(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailcity(UNSIGNED1 wh) := '';
 
EXPORT Make_mailctate(SALT311.StrType s0) := s0;
EXPORT InValid_mailctate(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailctate(UNSIGNED1 wh) := '';
 
EXPORT Make_mailzipcode(SALT311.StrType s0) := s0;
EXPORT InValid_mailzipcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailzipcode(UNSIGNED1 wh) := '';
 
EXPORT Make_mailzip4(SALT311.StrType s0) := s0;
EXPORT InValid_mailzip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_mailzip4(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_CourtLocations;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_fipscode;
    BOOLEAN Diff_statefips;
    BOOLEAN Diff_countyfips;
    BOOLEAN Diff_courtid;
    BOOLEAN Diff_consolidatedcourtid;
    BOOLEAN Diff_masterid;
    BOOLEAN Diff_stateofservice;
    BOOLEAN Diff_countyofservice;
    BOOLEAN Diff_courtname;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_mailaddress1;
    BOOLEAN Diff_mailaddress2;
    BOOLEAN Diff_mailcity;
    BOOLEAN Diff_mailctate;
    BOOLEAN Diff_mailzipcode;
    BOOLEAN Diff_mailzip4;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fipscode := le.fipscode <> ri.fipscode;
    SELF.Diff_statefips := le.statefips <> ri.statefips;
    SELF.Diff_countyfips := le.countyfips <> ri.countyfips;
    SELF.Diff_courtid := le.courtid <> ri.courtid;
    SELF.Diff_consolidatedcourtid := le.consolidatedcourtid <> ri.consolidatedcourtid;
    SELF.Diff_masterid := le.masterid <> ri.masterid;
    SELF.Diff_stateofservice := le.stateofservice <> ri.stateofservice;
    SELF.Diff_countyofservice := le.countyofservice <> ri.countyofservice;
    SELF.Diff_courtname := le.courtname <> ri.courtname;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_mailaddress1 := le.mailaddress1 <> ri.mailaddress1;
    SELF.Diff_mailaddress2 := le.mailaddress2 <> ri.mailaddress2;
    SELF.Diff_mailcity := le.mailcity <> ri.mailcity;
    SELF.Diff_mailctate := le.mailctate <> ri.mailctate;
    SELF.Diff_mailzipcode := le.mailzipcode <> ri.mailzipcode;
    SELF.Diff_mailzip4 := le.mailzip4 <> ri.mailzip4;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fipscode,1,0)+ IF( SELF.Diff_statefips,1,0)+ IF( SELF.Diff_countyfips,1,0)+ IF( SELF.Diff_courtid,1,0)+ IF( SELF.Diff_consolidatedcourtid,1,0)+ IF( SELF.Diff_masterid,1,0)+ IF( SELF.Diff_stateofservice,1,0)+ IF( SELF.Diff_countyofservice,1,0)+ IF( SELF.Diff_courtname,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_mailaddress1,1,0)+ IF( SELF.Diff_mailaddress2,1,0)+ IF( SELF.Diff_mailcity,1,0)+ IF( SELF.Diff_mailctate,1,0)+ IF( SELF.Diff_mailzipcode,1,0)+ IF( SELF.Diff_mailzip4,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_fipscode := COUNT(GROUP,%Closest%.Diff_fipscode);
    Count_Diff_statefips := COUNT(GROUP,%Closest%.Diff_statefips);
    Count_Diff_countyfips := COUNT(GROUP,%Closest%.Diff_countyfips);
    Count_Diff_courtid := COUNT(GROUP,%Closest%.Diff_courtid);
    Count_Diff_consolidatedcourtid := COUNT(GROUP,%Closest%.Diff_consolidatedcourtid);
    Count_Diff_masterid := COUNT(GROUP,%Closest%.Diff_masterid);
    Count_Diff_stateofservice := COUNT(GROUP,%Closest%.Diff_stateofservice);
    Count_Diff_countyofservice := COUNT(GROUP,%Closest%.Diff_countyofservice);
    Count_Diff_courtname := COUNT(GROUP,%Closest%.Diff_courtname);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_mailaddress1 := COUNT(GROUP,%Closest%.Diff_mailaddress1);
    Count_Diff_mailaddress2 := COUNT(GROUP,%Closest%.Diff_mailaddress2);
    Count_Diff_mailcity := COUNT(GROUP,%Closest%.Diff_mailcity);
    Count_Diff_mailctate := COUNT(GROUP,%Closest%.Diff_mailctate);
    Count_Diff_mailzipcode := COUNT(GROUP,%Closest%.Diff_mailzipcode);
    Count_Diff_mailzip4 := COUNT(GROUP,%Closest%.Diff_mailzip4);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
