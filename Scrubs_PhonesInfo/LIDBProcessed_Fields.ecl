IMPORT SALT39;
EXPORT LIDBProcessed_Fields := MODULE
 
EXPORT NumFields := 19;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_AccOwn','Invalid_RefID','Invalid_Char','Invalid_Binary','Invalid_Num_In_Service','Invalid_Line_Serv');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_AccOwn' => 2,'Invalid_RefID' => 3,'Invalid_Char' => 4,'Invalid_Binary' => 5,'Invalid_Num_In_Service' => 6,'Invalid_Line_Serv' => 7,0);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AccOwn(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABHGCDFE0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AccOwn(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABHGCDFE0123456789 '))));
EXPORT InValidMessageFT_Invalid_AccOwn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABHGCDFE0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RefID(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'MGP0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_RefID(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'MGP0123456789 '))));
EXPORT InValidMessageFT_Invalid_RefID(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('MGP0123456789 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\'!*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\'!*'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ()&-.,/-#@\'!*'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Binary(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'1 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Binary(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'1 '))));
EXPORT InValidMessageFT_Invalid_Binary(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('1 '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num_In_Service(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Num_In_Service(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['1A','2A','3A','4A','7A','10A','12A','1I','2I','3I','4I','7I','10I','12I','U',' ']);
EXPORT InValidMessageFT_Invalid_Num_In_Service(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('1A|2A|3A|4A|7A|10A|12A|1I|2I|3I|4I|7I|10I|12I|U| '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Line_Serv(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Line_Serv(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123 '))));
EXPORT InValidMessageFT_Invalid_Line_Serv(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123 '),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'reference_id','dt_first_reported','dt_last_reported','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','activation_dt','number_in_service','high_risk_indicator','prepaid');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'reference_id','dt_first_reported','dt_last_reported','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','activation_dt','number_in_service','high_risk_indicator','prepaid');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'reference_id' => 0,'dt_first_reported' => 1,'dt_last_reported' => 2,'phone' => 3,'reply_code' => 4,'local_routing_number' => 5,'account_owner' => 6,'carrier_name' => 7,'carrier_category' => 8,'local_area_transport_area' => 9,'point_code' => 10,'serv' => 11,'line' => 12,'spid' => 13,'operator_fullname' => 14,'activation_dt' => 15,'number_in_service' => 16,'high_risk_indicator' => 17,'prepaid' => 18,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_reference_id(SALT39.StrType s0) := MakeFT_Invalid_RefID(s0);
EXPORT InValid_reference_id(SALT39.StrType s) := InValidFT_Invalid_RefID(s);
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_RefID(wh);
 
EXPORT Make_dt_first_reported(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_first_reported(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dt_last_reported(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_dt_last_reported(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_dt_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_phone(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_reply_code(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_reply_code(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_reply_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_local_routing_number(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_routing_number(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_routing_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_account_owner(SALT39.StrType s0) := MakeFT_Invalid_AccOwn(s0);
EXPORT InValid_account_owner(SALT39.StrType s) := InValidFT_Invalid_AccOwn(s);
EXPORT InValidMessage_account_owner(UNSIGNED1 wh) := InValidMessageFT_Invalid_AccOwn(wh);
 
EXPORT Make_carrier_name(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_name(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_carrier_category(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_carrier_category(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_carrier_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_local_area_transport_area(SALT39.StrType s0) := s0;
EXPORT InValid_local_area_transport_area(SALT39.StrType s) := 0;
EXPORT InValidMessage_local_area_transport_area(UNSIGNED1 wh) := '';
 
EXPORT Make_point_code(SALT39.StrType s0) := s0;
EXPORT InValid_point_code(SALT39.StrType s) := 0;
EXPORT InValidMessage_point_code(UNSIGNED1 wh) := '';
 
EXPORT Make_serv(SALT39.StrType s0) := MakeFT_Invalid_Line_Serv(s0);
EXPORT InValid_serv(SALT39.StrType s) := InValidFT_Invalid_Line_Serv(s);
EXPORT InValidMessage_serv(UNSIGNED1 wh) := InValidMessageFT_Invalid_Line_Serv(wh);
 
EXPORT Make_line(SALT39.StrType s0) := MakeFT_Invalid_Line_Serv(s0);
EXPORT InValid_line(SALT39.StrType s) := InValidFT_Invalid_Line_Serv(s);
EXPORT InValidMessage_line(UNSIGNED1 wh) := InValidMessageFT_Invalid_Line_Serv(wh);
 
EXPORT Make_spid(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_spid(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_operator_fullname(SALT39.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_operator_fullname(SALT39.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_operator_fullname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_activation_dt(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_activation_dt(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_activation_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_number_in_service(SALT39.StrType s0) := MakeFT_Invalid_Num_In_Service(s0);
EXPORT InValid_number_in_service(SALT39.StrType s) := InValidFT_Invalid_Num_In_Service(s);
EXPORT InValidMessage_number_in_service(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_In_Service(wh);
 
EXPORT Make_high_risk_indicator(SALT39.StrType s0) := MakeFT_Invalid_Binary(s0);
EXPORT InValid_high_risk_indicator(SALT39.StrType s) := InValidFT_Invalid_Binary(s);
EXPORT InValidMessage_high_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Binary(wh);
 
EXPORT Make_prepaid(SALT39.StrType s0) := MakeFT_Invalid_Binary(s0);
EXPORT InValid_prepaid(SALT39.StrType s) := InValidFT_Invalid_Binary(s);
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Binary(wh);
 
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
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_dt_first_reported;
    BOOLEAN Diff_dt_last_reported;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_reply_code;
    BOOLEAN Diff_local_routing_number;
    BOOLEAN Diff_account_owner;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_carrier_category;
    BOOLEAN Diff_local_area_transport_area;
    BOOLEAN Diff_point_code;
    BOOLEAN Diff_serv;
    BOOLEAN Diff_line;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_operator_fullname;
    BOOLEAN Diff_activation_dt;
    BOOLEAN Diff_number_in_service;
    BOOLEAN Diff_high_risk_indicator;
    BOOLEAN Diff_prepaid;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_dt_first_reported := le.dt_first_reported <> ri.dt_first_reported;
    SELF.Diff_dt_last_reported := le.dt_last_reported <> ri.dt_last_reported;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_reply_code := le.reply_code <> ri.reply_code;
    SELF.Diff_local_routing_number := le.local_routing_number <> ri.local_routing_number;
    SELF.Diff_account_owner := le.account_owner <> ri.account_owner;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_carrier_category := le.carrier_category <> ri.carrier_category;
    SELF.Diff_local_area_transport_area := le.local_area_transport_area <> ri.local_area_transport_area;
    SELF.Diff_point_code := le.point_code <> ri.point_code;
    SELF.Diff_serv := le.serv <> ri.serv;
    SELF.Diff_line := le.line <> ri.line;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_operator_fullname := le.operator_fullname <> ri.operator_fullname;
    SELF.Diff_activation_dt := le.activation_dt <> ri.activation_dt;
    SELF.Diff_number_in_service := le.number_in_service <> ri.number_in_service;
    SELF.Diff_high_risk_indicator := le.high_risk_indicator <> ri.high_risk_indicator;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_dt_first_reported,1,0)+ IF( SELF.Diff_dt_last_reported,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_reply_code,1,0)+ IF( SELF.Diff_local_routing_number,1,0)+ IF( SELF.Diff_account_owner,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_carrier_category,1,0)+ IF( SELF.Diff_local_area_transport_area,1,0)+ IF( SELF.Diff_point_code,1,0)+ IF( SELF.Diff_serv,1,0)+ IF( SELF.Diff_line,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_operator_fullname,1,0)+ IF( SELF.Diff_activation_dt,1,0)+ IF( SELF.Diff_number_in_service,1,0)+ IF( SELF.Diff_high_risk_indicator,1,0)+ IF( SELF.Diff_prepaid,1,0);
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
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_dt_first_reported := COUNT(GROUP,%Closest%.Diff_dt_first_reported);
    Count_Diff_dt_last_reported := COUNT(GROUP,%Closest%.Diff_dt_last_reported);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_reply_code := COUNT(GROUP,%Closest%.Diff_reply_code);
    Count_Diff_local_routing_number := COUNT(GROUP,%Closest%.Diff_local_routing_number);
    Count_Diff_account_owner := COUNT(GROUP,%Closest%.Diff_account_owner);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_carrier_category := COUNT(GROUP,%Closest%.Diff_carrier_category);
    Count_Diff_local_area_transport_area := COUNT(GROUP,%Closest%.Diff_local_area_transport_area);
    Count_Diff_point_code := COUNT(GROUP,%Closest%.Diff_point_code);
    Count_Diff_serv := COUNT(GROUP,%Closest%.Diff_serv);
    Count_Diff_line := COUNT(GROUP,%Closest%.Diff_line);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_operator_fullname := COUNT(GROUP,%Closest%.Diff_operator_fullname);
    Count_Diff_activation_dt := COUNT(GROUP,%Closest%.Diff_activation_dt);
    Count_Diff_number_in_service := COUNT(GROUP,%Closest%.Diff_number_in_service);
    Count_Diff_high_risk_indicator := COUNT(GROUP,%Closest%.Diff_high_risk_indicator);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
