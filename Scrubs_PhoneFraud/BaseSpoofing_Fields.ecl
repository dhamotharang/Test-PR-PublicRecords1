IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseSpoofing_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Phone_Origin','Invalid_Date','Invalid_Phone','Invalid_ID');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Phone_Origin' => 2,'Invalid_Date' => 3,'Invalid_Phone' => 4,'Invalid_ID' => 5,0);
 
EXPORT MakeFT_Invalid_Num(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone_Origin(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'DSC'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone_Origin(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'DSC'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_Invalid_Phone_Origin(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('DSC'),SALT36.HygieneErrors.NotLength('1'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT36.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.NotLength('10'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('1..'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'date_file_loaded','phone','phone_origin','id_value','reference_id','mode_type','account_name','event_date','event_time','ip_address','neustar_lower_bound','neustar_upper_bound','vendor','date_added','time_added');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'date_file_loaded' => 0,'phone' => 1,'phone_origin' => 2,'id_value' => 3,'reference_id' => 4,'mode_type' => 5,'account_name' => 6,'event_date' => 7,'event_time' => 8,'ip_address' => 9,'neustar_lower_bound' => 10,'neustar_upper_bound' => 11,'vendor' => 12,'date_added' => 13,'time_added' => 14,0);
 
//Individual field level validation
 
EXPORT Make_date_file_loaded(SALT36.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_file_loaded(SALT36.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_file_loaded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_phone(SALT36.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone(SALT36.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_phone_origin(SALT36.StrType s0) := MakeFT_Invalid_Phone_Origin(s0);
EXPORT InValid_phone_origin(SALT36.StrType s) := InValidFT_Invalid_Phone_Origin(s);
EXPORT InValidMessage_phone_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Origin(wh);
 
EXPORT Make_id_value(SALT36.StrType s0) := MakeFT_Invalid_ID(s0);
EXPORT InValid_id_value(SALT36.StrType s) := InValidFT_Invalid_ID(s);
EXPORT InValidMessage_id_value(UNSIGNED1 wh) := InValidMessageFT_Invalid_ID(wh);
 
EXPORT Make_reference_id(SALT36.StrType s0) := s0;
EXPORT InValid_reference_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_reference_id(UNSIGNED1 wh) := '';
 
EXPORT Make_mode_type(SALT36.StrType s0) := s0;
EXPORT InValid_mode_type(SALT36.StrType s) := 0;
EXPORT InValidMessage_mode_type(UNSIGNED1 wh) := '';
 
EXPORT Make_account_name(SALT36.StrType s0) := s0;
EXPORT InValid_account_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_account_name(UNSIGNED1 wh) := '';
 
EXPORT Make_event_date(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_event_date(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_event_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_event_time(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_event_time(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_event_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_ip_address(SALT36.StrType s0) := s0;
EXPORT InValid_ip_address(SALT36.StrType s) := 0;
EXPORT InValidMessage_ip_address(UNSIGNED1 wh) := '';
 
EXPORT Make_neustar_lower_bound(SALT36.StrType s0) := s0;
EXPORT InValid_neustar_lower_bound(SALT36.StrType s) := 0;
EXPORT InValidMessage_neustar_lower_bound(UNSIGNED1 wh) := '';
 
EXPORT Make_neustar_upper_bound(SALT36.StrType s0) := s0;
EXPORT InValid_neustar_upper_bound(SALT36.StrType s) := 0;
EXPORT InValidMessage_neustar_upper_bound(UNSIGNED1 wh) := '';
 
EXPORT Make_vendor(SALT36.StrType s0) := s0;
EXPORT InValid_vendor(SALT36.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
EXPORT Make_date_added(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_date_added(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_time_added(SALT36.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_time_added(SALT36.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_time_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_PhoneFraud;
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
    BOOLEAN Diff_date_file_loaded;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_origin;
    BOOLEAN Diff_id_value;
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_mode_type;
    BOOLEAN Diff_account_name;
    BOOLEAN Diff_event_date;
    BOOLEAN Diff_event_time;
    BOOLEAN Diff_ip_address;
    BOOLEAN Diff_neustar_lower_bound;
    BOOLEAN Diff_neustar_upper_bound;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_time_added;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_date_file_loaded := le.date_file_loaded <> ri.date_file_loaded;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_origin := le.phone_origin <> ri.phone_origin;
    SELF.Diff_id_value := le.id_value <> ri.id_value;
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_mode_type := le.mode_type <> ri.mode_type;
    SELF.Diff_account_name := le.account_name <> ri.account_name;
    SELF.Diff_event_date := le.event_date <> ri.event_date;
    SELF.Diff_event_time := le.event_time <> ri.event_time;
    SELF.Diff_ip_address := le.ip_address <> ri.ip_address;
    SELF.Diff_neustar_lower_bound := le.neustar_lower_bound <> ri.neustar_lower_bound;
    SELF.Diff_neustar_upper_bound := le.neustar_upper_bound <> ri.neustar_upper_bound;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_time_added := le.time_added <> ri.time_added;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_date_file_loaded,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_origin,1,0)+ IF( SELF.Diff_id_value,1,0)+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_mode_type,1,0)+ IF( SELF.Diff_account_name,1,0)+ IF( SELF.Diff_event_date,1,0)+ IF( SELF.Diff_event_time,1,0)+ IF( SELF.Diff_ip_address,1,0)+ IF( SELF.Diff_neustar_lower_bound,1,0)+ IF( SELF.Diff_neustar_upper_bound,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_time_added,1,0);
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
    Count_Diff_date_file_loaded := COUNT(GROUP,%Closest%.Diff_date_file_loaded);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_origin := COUNT(GROUP,%Closest%.Diff_phone_origin);
    Count_Diff_id_value := COUNT(GROUP,%Closest%.Diff_id_value);
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_mode_type := COUNT(GROUP,%Closest%.Diff_mode_type);
    Count_Diff_account_name := COUNT(GROUP,%Closest%.Diff_account_name);
    Count_Diff_event_date := COUNT(GROUP,%Closest%.Diff_event_date);
    Count_Diff_event_time := COUNT(GROUP,%Closest%.Diff_event_time);
    Count_Diff_ip_address := COUNT(GROUP,%Closest%.Diff_ip_address);
    Count_Diff_neustar_lower_bound := COUNT(GROUP,%Closest%.Diff_neustar_lower_bound);
    Count_Diff_neustar_upper_bound := COUNT(GROUP,%Closest%.Diff_neustar_upper_bound);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_time_added := COUNT(GROUP,%Closest%.Diff_time_added);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
