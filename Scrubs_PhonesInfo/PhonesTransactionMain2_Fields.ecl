IMPORT SALT311;
EXPORT PhonesTransactionMain2_Fields := MODULE
 
EXPORT NumFields := 24;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_AlphaNum','Invalid_Char','Invalid_CountryCode','Invalid_CountryAbbr','Invalid_DialTypeCode','Invalid_Num','Invalid_Src','Invalid_TransCode');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_AlphaNum' => 1,'Invalid_Char' => 2,'Invalid_CountryCode' => 3,'Invalid_CountryAbbr' => 4,'Invalid_DialTypeCode' => 5,'Invalid_Num' => 6,'Invalid_Src' => 7,'Invalid_TransCode' => 8,0);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/\' '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CountryCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CountryCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1',' ']);
EXPORT InValidMessageFT_Invalid_CountryCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_CountryAbbr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_CountryAbbr(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['GU','MP','PR','US','VI',' ']);
EXPORT InValidMessageFT_Invalid_CountryAbbr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('GU|MP|PR|US|VI| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DialTypeCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DialTypeCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['T',' ']);
EXPORT InValidMessageFT_Invalid_DialTypeCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('T| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Src(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Src(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['OT','P!','PG','PK','PX']);
EXPORT InValidMessageFT_Invalid_Src(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('OT|P!|PG|PK|PX'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TransCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_TransCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AS','DE','RE','PA','PD','SA','SD','SU']);
EXPORT InValidMessageFT_Invalid_TransCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AS|DE|RE|PA|PD|SA|SD|SU'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'phone','source','transaction_code','transaction_start_dt','transaction_start_time','transaction_end_dt','transaction_end_time','transaction_count','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','country_code','country_abbr','routing_code','dial_type','spid','carrier_name','phone_swap','ocn','alt_spid','lalt_spid','global_sid','record_sid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'phone','source','transaction_code','transaction_start_dt','transaction_start_time','transaction_end_dt','transaction_end_time','transaction_count','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','country_code','country_abbr','routing_code','dial_type','spid','carrier_name','phone_swap','ocn','alt_spid','lalt_spid','global_sid','record_sid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'phone' => 0,'source' => 1,'transaction_code' => 2,'transaction_start_dt' => 3,'transaction_start_time' => 4,'transaction_end_dt' => 5,'transaction_end_time' => 6,'transaction_count' => 7,'vendor_first_reported_dt' => 8,'vendor_first_reported_time' => 9,'vendor_last_reported_dt' => 10,'vendor_last_reported_time' => 11,'country_code' => 12,'country_abbr' => 13,'routing_code' => 14,'dial_type' => 15,'spid' => 16,'carrier_name' => 17,'phone_swap' => 18,'ocn' => 19,'alt_spid' => 20,'lalt_spid' => 21,'global_sid' => 22,'record_sid' => 23,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ENUM'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_Invalid_Src(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_Invalid_Src(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_Src(wh);
 
EXPORT Make_transaction_code(SALT311.StrType s0) := MakeFT_Invalid_TransCode(s0);
EXPORT InValid_transaction_code(SALT311.StrType s) := InValidFT_Invalid_TransCode(s);
EXPORT InValidMessage_transaction_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_TransCode(wh);
 
EXPORT Make_transaction_start_dt(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_transaction_start_dt(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_transaction_start_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_transaction_start_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_transaction_start_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_transaction_start_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_transaction_end_dt(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_transaction_end_dt(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_transaction_end_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_transaction_end_time(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_transaction_end_time(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_transaction_end_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_transaction_count(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_transaction_count(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_transaction_count(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
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
 
EXPORT Make_country_code(SALT311.StrType s0) := MakeFT_Invalid_CountryCode(s0);
EXPORT InValid_country_code(SALT311.StrType s) := InValidFT_Invalid_CountryCode(s);
EXPORT InValidMessage_country_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_CountryCode(wh);
 
EXPORT Make_country_abbr(SALT311.StrType s0) := MakeFT_Invalid_CountryAbbr(s0);
EXPORT InValid_country_abbr(SALT311.StrType s) := InValidFT_Invalid_CountryAbbr(s);
EXPORT InValidMessage_country_abbr(UNSIGNED1 wh) := InValidMessageFT_Invalid_CountryAbbr(wh);
 
EXPORT Make_routing_code(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_routing_code(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_routing_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_dial_type(SALT311.StrType s0) := MakeFT_Invalid_DialTypeCode(s0);
EXPORT InValid_dial_type(SALT311.StrType s) := InValidFT_Invalid_DialTypeCode(s);
EXPORT InValidMessage_dial_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_DialTypeCode(wh);
 
EXPORT Make_spid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_spid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_carrier_name(SALT311.StrType s0) := s0;
EXPORT InValid_carrier_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrier_name(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_swap(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_phone_swap(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_phone_swap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ocn(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_ocn(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_ocn(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_alt_spid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_alt_spid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_alt_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_lalt_spid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_lalt_spid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_lalt_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
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
    BOOLEAN Diff_transaction_code;
    BOOLEAN Diff_transaction_start_dt;
    BOOLEAN Diff_transaction_start_time;
    BOOLEAN Diff_transaction_end_dt;
    BOOLEAN Diff_transaction_end_time;
    BOOLEAN Diff_transaction_count;
    BOOLEAN Diff_vendor_first_reported_dt;
    BOOLEAN Diff_vendor_first_reported_time;
    BOOLEAN Diff_vendor_last_reported_dt;
    BOOLEAN Diff_vendor_last_reported_time;
    BOOLEAN Diff_country_code;
    BOOLEAN Diff_country_abbr;
    BOOLEAN Diff_routing_code;
    BOOLEAN Diff_dial_type;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_carrier_name;
    BOOLEAN Diff_phone_swap;
    BOOLEAN Diff_ocn;
    BOOLEAN Diff_alt_spid;
    BOOLEAN Diff_lalt_spid;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_transaction_code := le.transaction_code <> ri.transaction_code;
    SELF.Diff_transaction_start_dt := le.transaction_start_dt <> ri.transaction_start_dt;
    SELF.Diff_transaction_start_time := le.transaction_start_time <> ri.transaction_start_time;
    SELF.Diff_transaction_end_dt := le.transaction_end_dt <> ri.transaction_end_dt;
    SELF.Diff_transaction_end_time := le.transaction_end_time <> ri.transaction_end_time;
    SELF.Diff_transaction_count := le.transaction_count <> ri.transaction_count;
    SELF.Diff_vendor_first_reported_dt := le.vendor_first_reported_dt <> ri.vendor_first_reported_dt;
    SELF.Diff_vendor_first_reported_time := le.vendor_first_reported_time <> ri.vendor_first_reported_time;
    SELF.Diff_vendor_last_reported_dt := le.vendor_last_reported_dt <> ri.vendor_last_reported_dt;
    SELF.Diff_vendor_last_reported_time := le.vendor_last_reported_time <> ri.vendor_last_reported_time;
    SELF.Diff_country_code := le.country_code <> ri.country_code;
    SELF.Diff_country_abbr := le.country_abbr <> ri.country_abbr;
    SELF.Diff_routing_code := le.routing_code <> ri.routing_code;
    SELF.Diff_dial_type := le.dial_type <> ri.dial_type;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_carrier_name := le.carrier_name <> ri.carrier_name;
    SELF.Diff_phone_swap := le.phone_swap <> ri.phone_swap;
    SELF.Diff_ocn := le.ocn <> ri.ocn;
    SELF.Diff_alt_spid := le.alt_spid <> ri.alt_spid;
    SELF.Diff_lalt_spid := le.lalt_spid <> ri.lalt_spid;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_transaction_code,1,0)+ IF( SELF.Diff_transaction_start_dt,1,0)+ IF( SELF.Diff_transaction_start_time,1,0)+ IF( SELF.Diff_transaction_end_dt,1,0)+ IF( SELF.Diff_transaction_end_time,1,0)+ IF( SELF.Diff_transaction_count,1,0)+ IF( SELF.Diff_vendor_first_reported_dt,1,0)+ IF( SELF.Diff_vendor_first_reported_time,1,0)+ IF( SELF.Diff_vendor_last_reported_dt,1,0)+ IF( SELF.Diff_vendor_last_reported_time,1,0)+ IF( SELF.Diff_country_code,1,0)+ IF( SELF.Diff_country_abbr,1,0)+ IF( SELF.Diff_routing_code,1,0)+ IF( SELF.Diff_dial_type,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_carrier_name,1,0)+ IF( SELF.Diff_phone_swap,1,0)+ IF( SELF.Diff_ocn,1,0)+ IF( SELF.Diff_alt_spid,1,0)+ IF( SELF.Diff_lalt_spid,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0);
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
    Count_Diff_transaction_code := COUNT(GROUP,%Closest%.Diff_transaction_code);
    Count_Diff_transaction_start_dt := COUNT(GROUP,%Closest%.Diff_transaction_start_dt);
    Count_Diff_transaction_start_time := COUNT(GROUP,%Closest%.Diff_transaction_start_time);
    Count_Diff_transaction_end_dt := COUNT(GROUP,%Closest%.Diff_transaction_end_dt);
    Count_Diff_transaction_end_time := COUNT(GROUP,%Closest%.Diff_transaction_end_time);
    Count_Diff_transaction_count := COUNT(GROUP,%Closest%.Diff_transaction_count);
    Count_Diff_vendor_first_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_dt);
    Count_Diff_vendor_first_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_first_reported_time);
    Count_Diff_vendor_last_reported_dt := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_dt);
    Count_Diff_vendor_last_reported_time := COUNT(GROUP,%Closest%.Diff_vendor_last_reported_time);
    Count_Diff_country_code := COUNT(GROUP,%Closest%.Diff_country_code);
    Count_Diff_country_abbr := COUNT(GROUP,%Closest%.Diff_country_abbr);
    Count_Diff_routing_code := COUNT(GROUP,%Closest%.Diff_routing_code);
    Count_Diff_dial_type := COUNT(GROUP,%Closest%.Diff_dial_type);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_carrier_name := COUNT(GROUP,%Closest%.Diff_carrier_name);
    Count_Diff_phone_swap := COUNT(GROUP,%Closest%.Diff_phone_swap);
    Count_Diff_ocn := COUNT(GROUP,%Closest%.Diff_ocn);
    Count_Diff_alt_spid := COUNT(GROUP,%Closest%.Diff_alt_spid);
    Count_Diff_lalt_spid := COUNT(GROUP,%Closest%.Diff_lalt_spid);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
