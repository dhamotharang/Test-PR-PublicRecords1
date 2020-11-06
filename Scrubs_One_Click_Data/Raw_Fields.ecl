IMPORT SALT311;
IMPORT Scrubs_One_Click_Data,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_SSN','Invalid_fName','Invalid_Dob','Invalid_mandatory_Alpha','Invalid_Alpha','Invalid_Zip','Invalid_State','Invalid_Phone','Invalid_pastDate');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_SSN' => 1,'Invalid_fName' => 2,'Invalid_Dob' => 3,'Invalid_mandatory_Alpha' => 4,'Invalid_Alpha' => 5,'Invalid_Zip' => 6,'Invalid_State' => 7,'Invalid_Phone' => 8,'Invalid_pastDate' => 9,0);
 
EXPORT MakeFT_Invalid_SSN(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_SSN(SALT311.StrType s) := WHICH(~Scrubs_One_Click_Data.functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_One_Click_Data.functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_fName(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_fName(SALT311.StrType s,SALT311.StrType lastname) := WHICH(~Scrubs.functions.fn_populated_strings(s,lastname)>0);
EXPORT InValidMessageFT_Invalid_fName(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Dob(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Dob(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_dob(s)>0);
EXPORT InValidMessageFT_Invalid_Dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_dob'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_mandatory_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_mandatory_Alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_mandatory_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_Zip(s)>0);
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_Zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_pastDate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_pastDate(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_Invalid_pastDate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ssn','firstname','lastname','dob','homeaddress','homecity','homestate','homezip','homephone','mobilephone','emailaddress','workname','workaddress','workcity','workstate','workzip','workphone','ref1firstname','ref1lastname','ref1phone','lastinquirydate','ip');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ssn','firstname','lastname','dob','homeaddress','homecity','homestate','homezip','homephone','mobilephone','emailaddress','workname','workaddress','workcity','workstate','workzip','workphone','ref1firstname','ref1lastname','ref1phone','lastinquirydate','ip');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ssn' => 0,'firstname' => 1,'lastname' => 2,'dob' => 3,'homeaddress' => 4,'homecity' => 5,'homestate' => 6,'homezip' => 7,'homephone' => 8,'mobilephone' => 9,'emailaddress' => 10,'workname' => 11,'workaddress' => 12,'workcity' => 13,'workstate' => 14,'workzip' => 15,'workphone' => 16,'ref1firstname' => 17,'ref1lastname' => 18,'ref1phone' => 19,'lastinquirydate' => 20,'ip' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM','LENGTHS'],[],[],[],[],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_firstname(SALT311.StrType s0) := MakeFT_Invalid_fName(s0);
EXPORT InValid_firstname(SALT311.StrType s,SALT311.StrType lastname) := InValidFT_Invalid_fName(s,lastname);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_Invalid_fName(wh);
 
EXPORT Make_lastname(SALT311.StrType s0) := s0;
EXPORT InValid_lastname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_Invalid_Dob(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_Invalid_Dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Dob(wh);
 
EXPORT Make_homeaddress(SALT311.StrType s0) := MakeFT_Invalid_mandatory_Alpha(s0);
EXPORT InValid_homeaddress(SALT311.StrType s) := InValidFT_Invalid_mandatory_Alpha(s);
EXPORT InValidMessage_homeaddress(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_Alpha(wh);
 
EXPORT Make_homecity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_homecity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_homecity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_homestate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_homestate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_homestate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_homezip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_homezip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_homezip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_homephone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_homephone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_homephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_mobilephone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_mobilephone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_mobilephone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_emailaddress(SALT311.StrType s0) := s0;
EXPORT InValid_emailaddress(SALT311.StrType s) := 0;
EXPORT InValidMessage_emailaddress(UNSIGNED1 wh) := '';
 
EXPORT Make_workname(SALT311.StrType s0) := MakeFT_Invalid_mandatory_Alpha(s0);
EXPORT InValid_workname(SALT311.StrType s) := InValidFT_Invalid_mandatory_Alpha(s);
EXPORT InValidMessage_workname(UNSIGNED1 wh) := InValidMessageFT_Invalid_mandatory_Alpha(wh);
 
EXPORT Make_workaddress(SALT311.StrType s0) := s0;
EXPORT InValid_workaddress(SALT311.StrType s) := 0;
EXPORT InValidMessage_workaddress(UNSIGNED1 wh) := '';
 
EXPORT Make_workcity(SALT311.StrType s0) := s0;
EXPORT InValid_workcity(SALT311.StrType s) := 0;
EXPORT InValidMessage_workcity(UNSIGNED1 wh) := '';
 
EXPORT Make_workstate(SALT311.StrType s0) := s0;
EXPORT InValid_workstate(SALT311.StrType s) := 0;
EXPORT InValidMessage_workstate(UNSIGNED1 wh) := '';
 
EXPORT Make_workzip(SALT311.StrType s0) := s0;
EXPORT InValid_workzip(SALT311.StrType s) := 0;
EXPORT InValidMessage_workzip(UNSIGNED1 wh) := '';
 
EXPORT Make_workphone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_workphone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_workphone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_ref1firstname(SALT311.StrType s0) := s0;
EXPORT InValid_ref1firstname(SALT311.StrType s) := 0;
EXPORT InValidMessage_ref1firstname(UNSIGNED1 wh) := '';
 
EXPORT Make_ref1lastname(SALT311.StrType s0) := s0;
EXPORT InValid_ref1lastname(SALT311.StrType s) := 0;
EXPORT InValidMessage_ref1lastname(UNSIGNED1 wh) := '';
 
EXPORT Make_ref1phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_ref1phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_ref1phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_lastinquirydate(SALT311.StrType s0) := MakeFT_Invalid_pastDate(s0);
EXPORT InValid_lastinquirydate(SALT311.StrType s) := InValidFT_Invalid_pastDate(s);
EXPORT InValidMessage_lastinquirydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_pastDate(wh);
 
EXPORT Make_ip(SALT311.StrType s0) := s0;
EXPORT InValid_ip(SALT311.StrType s) := 0;
EXPORT InValidMessage_ip(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_One_Click_Data;
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
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_homeaddress;
    BOOLEAN Diff_homecity;
    BOOLEAN Diff_homestate;
    BOOLEAN Diff_homezip;
    BOOLEAN Diff_homephone;
    BOOLEAN Diff_mobilephone;
    BOOLEAN Diff_emailaddress;
    BOOLEAN Diff_workname;
    BOOLEAN Diff_workaddress;
    BOOLEAN Diff_workcity;
    BOOLEAN Diff_workstate;
    BOOLEAN Diff_workzip;
    BOOLEAN Diff_workphone;
    BOOLEAN Diff_ref1firstname;
    BOOLEAN Diff_ref1lastname;
    BOOLEAN Diff_ref1phone;
    BOOLEAN Diff_lastinquirydate;
    BOOLEAN Diff_ip;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_homeaddress := le.homeaddress <> ri.homeaddress;
    SELF.Diff_homecity := le.homecity <> ri.homecity;
    SELF.Diff_homestate := le.homestate <> ri.homestate;
    SELF.Diff_homezip := le.homezip <> ri.homezip;
    SELF.Diff_homephone := le.homephone <> ri.homephone;
    SELF.Diff_mobilephone := le.mobilephone <> ri.mobilephone;
    SELF.Diff_emailaddress := le.emailaddress <> ri.emailaddress;
    SELF.Diff_workname := le.workname <> ri.workname;
    SELF.Diff_workaddress := le.workaddress <> ri.workaddress;
    SELF.Diff_workcity := le.workcity <> ri.workcity;
    SELF.Diff_workstate := le.workstate <> ri.workstate;
    SELF.Diff_workzip := le.workzip <> ri.workzip;
    SELF.Diff_workphone := le.workphone <> ri.workphone;
    SELF.Diff_ref1firstname := le.ref1firstname <> ri.ref1firstname;
    SELF.Diff_ref1lastname := le.ref1lastname <> ri.ref1lastname;
    SELF.Diff_ref1phone := le.ref1phone <> ri.ref1phone;
    SELF.Diff_lastinquirydate := le.lastinquirydate <> ri.lastinquirydate;
    SELF.Diff_ip := le.ip <> ri.ip;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_homeaddress,1,0)+ IF( SELF.Diff_homecity,1,0)+ IF( SELF.Diff_homestate,1,0)+ IF( SELF.Diff_homezip,1,0)+ IF( SELF.Diff_homephone,1,0)+ IF( SELF.Diff_mobilephone,1,0)+ IF( SELF.Diff_emailaddress,1,0)+ IF( SELF.Diff_workname,1,0)+ IF( SELF.Diff_workaddress,1,0)+ IF( SELF.Diff_workcity,1,0)+ IF( SELF.Diff_workstate,1,0)+ IF( SELF.Diff_workzip,1,0)+ IF( SELF.Diff_workphone,1,0)+ IF( SELF.Diff_ref1firstname,1,0)+ IF( SELF.Diff_ref1lastname,1,0)+ IF( SELF.Diff_ref1phone,1,0)+ IF( SELF.Diff_lastinquirydate,1,0)+ IF( SELF.Diff_ip,1,0);
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
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_homeaddress := COUNT(GROUP,%Closest%.Diff_homeaddress);
    Count_Diff_homecity := COUNT(GROUP,%Closest%.Diff_homecity);
    Count_Diff_homestate := COUNT(GROUP,%Closest%.Diff_homestate);
    Count_Diff_homezip := COUNT(GROUP,%Closest%.Diff_homezip);
    Count_Diff_homephone := COUNT(GROUP,%Closest%.Diff_homephone);
    Count_Diff_mobilephone := COUNT(GROUP,%Closest%.Diff_mobilephone);
    Count_Diff_emailaddress := COUNT(GROUP,%Closest%.Diff_emailaddress);
    Count_Diff_workname := COUNT(GROUP,%Closest%.Diff_workname);
    Count_Diff_workaddress := COUNT(GROUP,%Closest%.Diff_workaddress);
    Count_Diff_workcity := COUNT(GROUP,%Closest%.Diff_workcity);
    Count_Diff_workstate := COUNT(GROUP,%Closest%.Diff_workstate);
    Count_Diff_workzip := COUNT(GROUP,%Closest%.Diff_workzip);
    Count_Diff_workphone := COUNT(GROUP,%Closest%.Diff_workphone);
    Count_Diff_ref1firstname := COUNT(GROUP,%Closest%.Diff_ref1firstname);
    Count_Diff_ref1lastname := COUNT(GROUP,%Closest%.Diff_ref1lastname);
    Count_Diff_ref1phone := COUNT(GROUP,%Closest%.Diff_ref1phone);
    Count_Diff_lastinquirydate := COUNT(GROUP,%Closest%.Diff_lastinquirydate);
    Count_Diff_ip := COUNT(GROUP,%Closest%.Diff_ip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
