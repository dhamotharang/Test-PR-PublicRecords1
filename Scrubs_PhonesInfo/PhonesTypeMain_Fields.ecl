IMPORT SALT311;
EXPORT PhonesTypeMain_Fields := MODULE
 
EXPORT NumFields := 22;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_AlphaNum','Invalid_CharCat','Invalid_Indic','Invalid_Num','Invalid_Src','Invalid_Type');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_AlphaNum' => 1,'Invalid_CharCat' => 2,'Invalid_Indic' => 3,'Invalid_Num' => 4,'Invalid_Src' => 5,'Invalid_Type' => 6,0);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CharCat(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CharCat(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['CAP','CLEC','GENERAL','IC','ILEC','INTL','IPES','L RESELLER','PCS','RBOC','ULEC','W RESELLER','WIRELESS',' ']);
EXPORT InValidMessageFT_Invalid_CharCat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('CAP|CLEC|GENERAL|IC|ILEC|INTL|IPES|L RESELLER|PCS|RBOC|ULEC|W RESELLER|WIRELESS| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Indic(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1| '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Indic(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1| '))));
EXPORT InValidMessageFT_Invalid_Indic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('1| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Src(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Src(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['L6','P!','PB','PK']);
EXPORT InValidMessageFT_Invalid_Src(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('L6|P!|PB|PK'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123 '))));
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123 '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','source','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','reference_id','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','high_risk_indicator','prepaid','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','source','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','reference_id','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','high_risk_indicator','prepaid','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'phone' => 0,'source' => 1,'vendor_first_reported_dt' => 2,'vendor_first_reported_time' => 3,'vendor_last_reported_dt' => 4,'vendor_last_reported_time' => 5,'reference_id' => 6,'reply_code' => 7,'local_routing_number' => 8,'account_owner' => 9,'carrier_name' => 10,'carrier_category' => 11,'local_area_transport_area' => 12,'point_code' => 13,'serv' => 14,'line' => 15,'spid' => 16,'operator_fullname' => 17,'high_risk_indicator' => 18,'prepaid' => 19,'global_sid' => 20,'record_sid' => 21,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_Src(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_Src(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Src(wh);
 
EXPORT Make_vendor_first_reported_dt(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_first_reported_dt(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_first_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_vendor_first_reported_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_first_reported_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_first_reported_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_vendor_last_reported_dt(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_last_reported_dt(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_last_reported_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_vendor_last_reported_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor_last_reported_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor_last_reported_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_reference_id(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_reference_id(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_reply_code(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_reply_code(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_reply_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_local_routing_number(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_routing_number(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_routing_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_account_owner(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_account_owner(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_account_owner(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_carrier_name(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := '';
 
EXPORT Make_carrier_category(SALT311.StrType s0) := MakeFT_Invalid_CharCat(s0);
EXPORT InValid_carrier_category(SALT311.StrType s) := InValidFT_Invalid_CharCat(s);
EXPORT InValidMessage_carrier_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_CharCat(wh);
 
EXPORT Make_local_area_transport_area(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_local_area_transport_area(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_local_area_transport_area(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_point_code(SALT311.StrType s0) := s0;
EXPORT InValid_point_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_point_code(UNSIGNED1 wh) := '';
 
EXPORT Make_serv(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_serv(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_serv(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_line(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_line(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_line(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
EXPORT Make_spid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_spid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_operator_fullname(SALT311.StrType s0) := s0;
EXPORT InValid_operator_fullname(SALT311.StrType s) := 0;
EXPORT InValidMessage_operator_fullname(UNSIGNED1 wh) := '';
 
EXPORT Make_high_risk_indicator(SALT311.StrType s0) := MakeFT_Invalid_Indic(s0);
EXPORT InValid_high_risk_indicator(SALT311.StrType s) := InValidFT_Invalid_Indic(s);
EXPORT InValidMessage_high_risk_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Indic(wh);
 
EXPORT Make_prepaid(SALT311.StrType s0) := MakeFT_Invalid_Indic(s0);
EXPORT InValid_prepaid(SALT311.StrType s) := InValidFT_Invalid_Indic(s);
EXPORT InValidMessage_prepaid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Indic(wh);
 
EXPORT Make_global_sid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_global_sid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_record_sid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_record_sid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_phone;
    BOOLEAN Diff_source;
    BOOLEAN Diff_vendor_first_reported_dt;
    BOOLEAN Diff_vendor_first_reported_time;
    BOOLEAN Diff_vendor_last_reported_dt;
    BOOLEAN Diff_vendor_last_reported_time;
    BOOLEAN Diff_reference_id;
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
    BOOLEAN Diff_high_risk_indicator;
    BOOLEAN Diff_prepaid;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_vendor_first_reported_dt := le.vendor_first_reported_dt <> ri.vendor_first_reported_dt;
    SELF.Diff_vendor_first_reported_time := le.vendor_first_reported_time <> ri.vendor_first_reported_time;
    SELF.Diff_vendor_last_reported_dt := le.vendor_last_reported_dt <> ri.vendor_last_reported_dt;
    SELF.Diff_vendor_last_reported_time := le.vendor_last_reported_time <> ri.vendor_last_reported_time;
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
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
    SELF.Diff_high_risk_indicator := le.high_risk_indicator <> ri.high_risk_indicator;
    SELF.Diff_prepaid := le.prepaid <> ri.prepaid;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_vendor_first_reported_dt,1,0)+ IF( SELF.Diff_vendor_first_reported_time,1,0)+ IF( SELF.Diff_vendor_last_reported_dt,1,0)+ IF( SELF.Diff_vendor_last_reported_time,1,0)+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_reply_code,1,0)+ IF( SELF.Diff_local_routing_number,1,0)+ IF( SELF.Diff_account_owner,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_carrier_category,1,0)+ IF( SELF.Diff_local_area_transport_area,1,0)+ IF( SELF.Diff_point_code,1,0)+ IF( SELF.Diff_serv,1,0)+ IF( SELF.Diff_line,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_operator_fullname,1,0)+ IF( SELF.Diff_high_risk_indicator,1,0)+ IF( SELF.Diff_prepaid,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_vendor_first_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_dt);
    Count_Diff_vendor_first_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_time);
    Count_Diff_vendor_last_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_dt);
    Count_Diff_vendor_last_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_time);
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
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
    Count_Diff_high_risk_indicator := COUNT(GROUP,%Closest%.Diff_high_risk_indicator);
    Count_Diff_prepaid := COUNT(GROUP,%Closest%.Diff_prepaid);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
