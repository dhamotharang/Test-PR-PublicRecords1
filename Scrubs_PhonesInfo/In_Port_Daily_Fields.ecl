IMPORT SALT39;
EXPORT In_Port_Daily_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Action_Code','Invalid_Num','Invalid_Num_Blank','Invalid_DCT','Invalid_TOS','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Action_Code' => 1,'Invalid_Num' => 2,'Invalid_Num_Blank' => 3,'Invalid_DCT' => 4,'Invalid_TOS' => 5,'Invalid_Port_Date' => 6,'Invalid_ISO2' => 7,'Invalid_Filename' => 8,0);
 
EXPORT MakeFT_Invalid_Action_Code(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'AUD#cE'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Action_Code(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'AUD#cE'))));
EXPORT InValidMessageFT_Invalid_Action_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('AUD#cE'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num_Blank(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Blank(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DCT(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ECTBN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_DCT(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ECTBN'))));
EXPORT InValidMessageFT_Invalid_DCT(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ECTBN'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TOS(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'MGOU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_TOS(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'MGOU'))));
EXPORT InValidMessageFT_Invalid_TOS(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('MGOU'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Port_Date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 /:-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Port_Date(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 /:-'))));
EXPORT InValidMessageFT_Invalid_Port_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 /:-'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ISO2(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ISO2(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_ISO2(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Filename(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Filename(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'))));
EXPORT InValidMessageFT_Invalid_Filename(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'action_code' => 0,'country_code' => 1,'phone' => 2,'dial_type' => 3,'spid' => 4,'service_type' => 5,'routing_code' => 6,'porting_dt' => 7,'country_abbr' => 8,'filename' => 9,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_action_code(SALT39.StrType s0) := MakeFT_Invalid_Action_Code(s0);
EXPORT InValid_action_code(SALT39.StrType s) := InValidFT_Invalid_Action_Code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Action_Code(wh);
 
EXPORT Make_country_code(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_country_code(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_country_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dial_type(SALT39.StrType s0) := MakeFT_Invalid_DCT(s0);
EXPORT InValid_dial_type(SALT39.StrType s) := InValidFT_Invalid_DCT(s);
EXPORT InValidMessage_dial_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_DCT(wh);
 
EXPORT Make_spid(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_spid(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_service_type(SALT39.StrType s0) := MakeFT_Invalid_TOS(s0);
EXPORT InValid_service_type(SALT39.StrType s) := InValidFT_Invalid_TOS(s);
EXPORT InValidMessage_service_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_TOS(wh);
 
EXPORT Make_routing_code(SALT39.StrType s0) := MakeFT_Invalid_Num_Blank(s0);
EXPORT InValid_routing_code(SALT39.StrType s) := InValidFT_Invalid_Num_Blank(s);
EXPORT InValidMessage_routing_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Blank(wh);
 
EXPORT Make_porting_dt(SALT39.StrType s0) := MakeFT_Invalid_Port_Date(s0);
EXPORT InValid_porting_dt(SALT39.StrType s) := InValidFT_Invalid_Port_Date(s);
EXPORT InValidMessage_porting_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Port_Date(wh);
 
EXPORT Make_country_abbr(SALT39.StrType s0) := MakeFT_Invalid_ISO2(s0);
EXPORT InValid_country_abbr(SALT39.StrType s) := InValidFT_Invalid_ISO2(s);
EXPORT InValidMessage_country_abbr(UNSIGNED1 wh) := InValidMessageFT_Invalid_ISO2(wh);
 
EXPORT Make_filename(SALT39.StrType s0) := MakeFT_Invalid_Filename(s0);
EXPORT InValid_filename(SALT39.StrType s) := InValidFT_Invalid_Filename(s);
EXPORT InValidMessage_filename(UNSIGNED1 wh) := InValidMessageFT_Invalid_Filename(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_country_code;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_dial_type;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_service_type;
    BOOLEAN Diff_routing_code;
    BOOLEAN Diff_porting_dt;
    BOOLEAN Diff_country_abbr;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_country_code := le.country_code <> ri.country_code;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_dial_type := le.dial_type <> ri.dial_type;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_service_type := le.service_type <> ri.service_type;
    SELF.Diff_routing_code := le.routing_code <> ri.routing_code;
    SELF.Diff_porting_dt := le.porting_dt <> ri.porting_dt;
    SELF.Diff_country_abbr := le.country_abbr <> ri.country_abbr;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_country_code,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_dial_type,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_service_type,1,0)+ IF( SELF.Diff_routing_code,1,0)+ IF( SELF.Diff_porting_dt,1,0)+ IF( SELF.Diff_country_abbr,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_country_code := COUNT(GROUP,%Closest%.Diff_country_code);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_dial_type := COUNT(GROUP,%Closest%.Diff_dial_type);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_service_type := COUNT(GROUP,%Closest%.Diff_service_type);
    Count_Diff_routing_code := COUNT(GROUP,%Closest%.Diff_routing_code);
    Count_Diff_porting_dt := COUNT(GROUP,%Closest%.Diff_porting_dt);
    Count_Diff_country_abbr := COUNT(GROUP,%Closest%.Diff_country_abbr);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
