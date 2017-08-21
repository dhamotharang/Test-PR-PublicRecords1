IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT RawSpoofing_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Date','Invalid_Event_Time','Invalid_Phone_Number','Invalid_Date_Added','Invalid_ID');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Date' => 2,'Invalid_Event_Time' => 3,'Invalid_Phone_Number' => 4,'Invalid_Date_Added' => 5,'Invalid_ID' => 6,0);
 
EXPORT MakeFT_Invalid_Num(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT36.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Event_Time(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789:/- '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Event_Time(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789:/- '))));
EXPORT InValidMessageFT_Invalid_Event_Time(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789:/- '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone_Number(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 \\\\N\\()null'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Phone_Number(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 \\\\N\\()null'))));
EXPORT InValidMessageFT_Invalid_Phone_Number(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789 \\\\N\\()null'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date_Added(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789-: '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Date_Added(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789-: '))));
EXPORT InValidMessageFT_Invalid_Date_Added(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789-: '),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ID(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ID(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789 '),SALT36.HygieneErrors.NotLength('1..'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'id_value','reference_id','mode_type','account_name','event_time','spoofed_phone_number','destination_number','source_phone_number','ip_address','neustar_lower_bound','neustar_upper_bound','vendor','date_added','user_added');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'id_value' => 0,'reference_id' => 1,'mode_type' => 2,'account_name' => 3,'event_time' => 4,'spoofed_phone_number' => 5,'destination_number' => 6,'source_phone_number' => 7,'ip_address' => 8,'neustar_lower_bound' => 9,'neustar_upper_bound' => 10,'vendor' => 11,'date_added' => 12,'user_added' => 13,0);
 
//Individual field level validation
 
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
 
EXPORT Make_event_time(SALT36.StrType s0) := MakeFT_Invalid_Event_Time(s0);
EXPORT InValid_event_time(SALT36.StrType s) := InValidFT_Invalid_Event_Time(s);
EXPORT InValidMessage_event_time(UNSIGNED1 wh) := InValidMessageFT_Invalid_Event_Time(wh);
 
EXPORT Make_spoofed_phone_number(SALT36.StrType s0) := MakeFT_Invalid_Phone_Number(s0);
EXPORT InValid_spoofed_phone_number(SALT36.StrType s) := InValidFT_Invalid_Phone_Number(s);
EXPORT InValidMessage_spoofed_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Number(wh);
 
EXPORT Make_destination_number(SALT36.StrType s0) := MakeFT_Invalid_Phone_Number(s0);
EXPORT InValid_destination_number(SALT36.StrType s) := InValidFT_Invalid_Phone_Number(s);
EXPORT InValidMessage_destination_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Number(wh);
 
EXPORT Make_source_phone_number(SALT36.StrType s0) := MakeFT_Invalid_Phone_Number(s0);
EXPORT InValid_source_phone_number(SALT36.StrType s) := InValidFT_Invalid_Phone_Number(s);
EXPORT InValidMessage_source_phone_number(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone_Number(wh);
 
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
 
EXPORT Make_date_added(SALT36.StrType s0) := MakeFT_Invalid_Date_Added(s0);
EXPORT InValid_date_added(SALT36.StrType s) := InValidFT_Invalid_Date_Added(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date_Added(wh);
 
EXPORT Make_user_added(SALT36.StrType s0) := s0;
EXPORT InValid_user_added(SALT36.StrType s) := 0;
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := '';
 
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
    BOOLEAN Diff_id_value;
    BOOLEAN Diff_reference_id;
    BOOLEAN Diff_mode_type;
    BOOLEAN Diff_account_name;
    BOOLEAN Diff_event_time;
    BOOLEAN Diff_spoofed_phone_number;
    BOOLEAN Diff_destination_number;
    BOOLEAN Diff_source_phone_number;
    BOOLEAN Diff_ip_address;
    BOOLEAN Diff_neustar_lower_bound;
    BOOLEAN Diff_neustar_upper_bound;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user_added;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_id_value := le.id_value <> ri.id_value;
    SELF.Diff_reference_id := le.reference_id <> ri.reference_id;
    SELF.Diff_mode_type := le.mode_type <> ri.mode_type;
    SELF.Diff_account_name := le.account_name <> ri.account_name;
    SELF.Diff_event_time := le.event_time <> ri.event_time;
    SELF.Diff_spoofed_phone_number := le.spoofed_phone_number <> ri.spoofed_phone_number;
    SELF.Diff_destination_number := le.destination_number <> ri.destination_number;
    SELF.Diff_source_phone_number := le.source_phone_number <> ri.source_phone_number;
    SELF.Diff_ip_address := le.ip_address <> ri.ip_address;
    SELF.Diff_neustar_lower_bound := le.neustar_lower_bound <> ri.neustar_lower_bound;
    SELF.Diff_neustar_upper_bound := le.neustar_upper_bound <> ri.neustar_upper_bound;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_id_value,1,0)+ IF( SELF.Diff_reference_id,1,0)+ IF( SELF.Diff_mode_type,1,0)+ IF( SELF.Diff_account_name,1,0)+ IF( SELF.Diff_event_time,1,0)+ IF( SELF.Diff_spoofed_phone_number,1,0)+ IF( SELF.Diff_destination_number,1,0)+ IF( SELF.Diff_source_phone_number,1,0)+ IF( SELF.Diff_ip_address,1,0)+ IF( SELF.Diff_neustar_lower_bound,1,0)+ IF( SELF.Diff_neustar_upper_bound,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user_added,1,0);
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
    Count_Diff_id_value := COUNT(GROUP,%Closest%.Diff_id_value);
    Count_Diff_reference_id := COUNT(GROUP,%Closest%.Diff_reference_id);
    Count_Diff_mode_type := COUNT(GROUP,%Closest%.Diff_mode_type);
    Count_Diff_account_name := COUNT(GROUP,%Closest%.Diff_account_name);
    Count_Diff_event_time := COUNT(GROUP,%Closest%.Diff_event_time);
    Count_Diff_spoofed_phone_number := COUNT(GROUP,%Closest%.Diff_spoofed_phone_number);
    Count_Diff_destination_number := COUNT(GROUP,%Closest%.Diff_destination_number);
    Count_Diff_source_phone_number := COUNT(GROUP,%Closest%.Diff_source_phone_number);
    Count_Diff_ip_address := COUNT(GROUP,%Closest%.Diff_ip_address);
    Count_Diff_neustar_lower_bound := COUNT(GROUP,%Closest%.Diff_neustar_lower_bound);
    Count_Diff_neustar_upper_bound := COUNT(GROUP,%Closest%.Diff_neustar_upper_bound);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
