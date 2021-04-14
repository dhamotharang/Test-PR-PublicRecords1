IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_agency_id','invalid_source_id','invalid_agency_state_abbr','invalid_agency_ori','invalid_allow_open_search','invalid_append_overwrite_flag','invalid_drivers_exchange_flag','invalid_date','invalid_date_time','invalid_resale_allowed','invalid_auto_renew','invalid_Allow_Sale_Of_Component_Data','invalid_Allow_Extract_Of_Vehicle_Data');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'invalid_agency_id' => 1,'invalid_source_id' => 2,'invalid_agency_state_abbr' => 3,'invalid_agency_ori' => 4,'invalid_allow_open_search' => 5,'invalid_append_overwrite_flag' => 6,'invalid_drivers_exchange_flag' => 7,'invalid_date' => 8,'invalid_date_time' => 9,'invalid_resale_allowed' => 10,'invalid_auto_renew' => 11,'invalid_Allow_Sale_Of_Component_Data' => 12,'invalid_Allow_Extract_Of_Vehicle_Data' => 13,0);
EXPORT MakeFT_invalid_agency_id(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_agency_id(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7));
EXPORT InValidMessageFT_invalid_agency_id(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.NotLength('7'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_source_id(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_source_id(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_source_id(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'),SALT37.HygieneErrors.NotLength('0,1,2,3'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_agency_state_abbr(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agency_state_abbr(SALT37.StrType s) := WHICH(~Scrubs.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_agency_state_abbr(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.CustomFail('Scrubs.fn_Valid_StateAbbrev'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_agency_ori(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_agency_ori(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'))));
EXPORT InValidMessageFT_invalid_agency_ori(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \\N'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_allow_open_search(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_allow_open_search(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_allow_open_search(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01'),SALT37.HygieneErrors.NotLength('1'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_append_overwrite_flag(SALT37.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_overwrite_flag(SALT37.StrType s) := WHICH(((SALT37.StrType) s) NOT IN ['AP','OW'],~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_append_overwrite_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInEnum('AP|OW'),SALT37.HygieneErrors.NotLength('2'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_drivers_exchange_flag(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_drivers_exchange_flag(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_drivers_exchange_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01'),SALT37.HygieneErrors.NotLength('1'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789-/: \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789-/: \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789-/: \\N'),SALT37.HygieneErrors.NotLength('0,10'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_date_time(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789-/: \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_time(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789-/: \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 20));
EXPORT InValidMessageFT_invalid_date_time(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789-/: \\N'),SALT37.HygieneErrors.NotLength('0,20'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_resale_allowed(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01 \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_resale_allowed(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01 \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_resale_allowed(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01 \\N'),SALT37.HygieneErrors.NotLength('0,1'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_auto_renew(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01 \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_auto_renew(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01 \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_auto_renew(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01 \\N'),SALT37.HygieneErrors.NotLength('0,1'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_Allow_Sale_Of_Component_Data(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01 \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Allow_Sale_Of_Component_Data(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01 \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_Allow_Sale_Of_Component_Data(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01 \\N'),SALT37.HygieneErrors.NotLength('0,1'),SALT37.HygieneErrors.Good);
EXPORT MakeFT_invalid_Allow_Extract_Of_Vehicle_Data(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'01 \\N'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Allow_Extract_Of_Vehicle_Data(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'01 \\N'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_Allow_Extract_Of_Vehicle_Data(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('01 \\N'),SALT37.HygieneErrors.NotLength('0,1'),SALT37.HygieneErrors.Good);
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'agency_id','agency_name','source_id','agency_state_abbr','agency_ori','allow_open_search','append_overwrite_flag','drivers_exchange_flag','source_start_date','source_end_date','source_termination_date','source_resale_allowed','source_auto_renew','source_allow_sale_of_component_data','source_allow_extract_of_vehicle_data');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'agency_id' => 0,'agency_name' => 1,'source_id' => 2,'agency_state_abbr' => 3,'agency_ori' => 4,'allow_open_search' => 5,'append_overwrite_flag' => 6,'drivers_exchange_flag' => 7,'source_start_date' => 8,'source_end_date' => 9,'source_termination_date' => 10,'source_resale_allowed' => 11,'source_auto_renew' => 12,'source_allow_sale_of_component_data' => 13,'source_allow_extract_of_vehicle_data' => 14,0);
//Individual field level validation
EXPORT Make_agency_id(SALT37.StrType s0) := MakeFT_invalid_agency_id(s0);
EXPORT InValid_agency_id(SALT37.StrType s) := InValidFT_invalid_agency_id(s);
EXPORT InValidMessage_agency_id(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_id(wh);
EXPORT Make_agency_name(SALT37.StrType s0) := s0;
EXPORT InValid_agency_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_agency_name(UNSIGNED1 wh) := '';
EXPORT Make_source_id(SALT37.StrType s0) := MakeFT_invalid_source_id(s0);
EXPORT InValid_source_id(SALT37.StrType s) := InValidFT_invalid_source_id(s);
EXPORT InValidMessage_source_id(UNSIGNED1 wh) := InValidMessageFT_invalid_source_id(wh);
EXPORT Make_agency_state_abbr(SALT37.StrType s0) := MakeFT_invalid_agency_state_abbr(s0);
EXPORT InValid_agency_state_abbr(SALT37.StrType s) := InValidFT_invalid_agency_state_abbr(s);
EXPORT InValidMessage_agency_state_abbr(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_state_abbr(wh);
EXPORT Make_agency_ori(SALT37.StrType s0) := MakeFT_invalid_agency_ori(s0);
EXPORT InValid_agency_ori(SALT37.StrType s) := InValidFT_invalid_agency_ori(s);
EXPORT InValidMessage_agency_ori(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_ori(wh);
EXPORT Make_allow_open_search(SALT37.StrType s0) := MakeFT_invalid_allow_open_search(s0);
EXPORT InValid_allow_open_search(SALT37.StrType s) := InValidFT_invalid_allow_open_search(s);
EXPORT InValidMessage_allow_open_search(UNSIGNED1 wh) := InValidMessageFT_invalid_allow_open_search(wh);
EXPORT Make_append_overwrite_flag(SALT37.StrType s0) := MakeFT_invalid_append_overwrite_flag(s0);
EXPORT InValid_append_overwrite_flag(SALT37.StrType s) := InValidFT_invalid_append_overwrite_flag(s);
EXPORT InValidMessage_append_overwrite_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_append_overwrite_flag(wh);
EXPORT Make_drivers_exchange_flag(SALT37.StrType s0) := MakeFT_invalid_drivers_exchange_flag(s0);
EXPORT InValid_drivers_exchange_flag(SALT37.StrType s) := InValidFT_invalid_drivers_exchange_flag(s);
EXPORT InValidMessage_drivers_exchange_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_drivers_exchange_flag(wh);
EXPORT Make_source_start_date(SALT37.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_source_start_date(SALT37.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_source_start_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_source_end_date(SALT37.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_source_end_date(SALT37.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_source_end_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_source_termination_date(SALT37.StrType s0) := MakeFT_invalid_date_time(s0);
EXPORT InValid_source_termination_date(SALT37.StrType s) := InValidFT_invalid_date_time(s);
EXPORT InValidMessage_source_termination_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_time(wh);
EXPORT Make_source_resale_allowed(SALT37.StrType s0) := MakeFT_invalid_resale_allowed(s0);
EXPORT InValid_source_resale_allowed(SALT37.StrType s) := InValidFT_invalid_resale_allowed(s);
EXPORT InValidMessage_source_resale_allowed(UNSIGNED1 wh) := InValidMessageFT_invalid_resale_allowed(wh);
EXPORT Make_source_auto_renew(SALT37.StrType s0) := MakeFT_invalid_auto_renew(s0);
EXPORT InValid_source_auto_renew(SALT37.StrType s) := InValidFT_invalid_auto_renew(s);
EXPORT InValidMessage_source_auto_renew(UNSIGNED1 wh) := InValidMessageFT_invalid_auto_renew(wh);
EXPORT Make_source_allow_sale_of_component_data(SALT37.StrType s0) := MakeFT_invalid_Allow_Sale_Of_Component_Data(s0);
EXPORT InValid_source_allow_sale_of_component_data(SALT37.StrType s) := InValidFT_invalid_Allow_Sale_Of_Component_Data(s);
EXPORT InValidMessage_source_allow_sale_of_component_data(UNSIGNED1 wh) := InValidMessageFT_invalid_Allow_Sale_Of_Component_Data(wh);
EXPORT Make_source_allow_extract_of_vehicle_data(SALT37.StrType s0) := MakeFT_invalid_Allow_Extract_Of_Vehicle_Data(s0);
EXPORT InValid_source_allow_extract_of_vehicle_data(SALT37.StrType s) := InValidFT_invalid_Allow_Extract_Of_Vehicle_Data(s);
EXPORT InValidMessage_source_allow_extract_of_vehicle_data(UNSIGNED1 wh) := InValidMessageFT_invalid_Allow_Extract_Of_Vehicle_Data(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Scrubs_eCrash_MBSAgency;
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
    BOOLEAN Diff_agency_id;
    BOOLEAN Diff_agency_name;
    BOOLEAN Diff_source_id;
    BOOLEAN Diff_agency_state_abbr;
    BOOLEAN Diff_agency_ori;
    BOOLEAN Diff_allow_open_search;
    BOOLEAN Diff_append_overwrite_flag;
    BOOLEAN Diff_drivers_exchange_flag;
    BOOLEAN Diff_source_start_date;
    BOOLEAN Diff_source_end_date;
    BOOLEAN Diff_source_termination_date;
    BOOLEAN Diff_source_resale_allowed;
    BOOLEAN Diff_source_auto_renew;
    BOOLEAN Diff_source_allow_sale_of_component_data;
    BOOLEAN Diff_source_allow_extract_of_vehicle_data;
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_agency_id := le.agency_id <> ri.agency_id;
    SELF.Diff_agency_name := le.agency_name <> ri.agency_name;
    SELF.Diff_source_id := le.source_id <> ri.source_id;
    SELF.Diff_agency_state_abbr := le.agency_state_abbr <> ri.agency_state_abbr;
    SELF.Diff_agency_ori := le.agency_ori <> ri.agency_ori;
    SELF.Diff_allow_open_search := le.allow_open_search <> ri.allow_open_search;
    SELF.Diff_append_overwrite_flag := le.append_overwrite_flag <> ri.append_overwrite_flag;
    SELF.Diff_drivers_exchange_flag := le.drivers_exchange_flag <> ri.drivers_exchange_flag;
    SELF.Diff_source_start_date := le.source_start_date <> ri.source_start_date;
    SELF.Diff_source_end_date := le.source_end_date <> ri.source_end_date;
    SELF.Diff_source_termination_date := le.source_termination_date <> ri.source_termination_date;
    SELF.Diff_source_resale_allowed := le.source_resale_allowed <> ri.source_resale_allowed;
    SELF.Diff_source_auto_renew := le.source_auto_renew <> ri.source_auto_renew;
    SELF.Diff_source_allow_sale_of_component_data := le.source_allow_sale_of_component_data <> ri.source_allow_sale_of_component_data;
    SELF.Diff_source_allow_extract_of_vehicle_data := le.source_allow_extract_of_vehicle_data <> ri.source_allow_extract_of_vehicle_data;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_agency_id,1,0)+ IF( SELF.Diff_agency_name,1,0)+ IF( SELF.Diff_source_id,1,0)+ IF( SELF.Diff_agency_state_abbr,1,0)+ IF( SELF.Diff_agency_ori,1,0)+ IF( SELF.Diff_allow_open_search,1,0)+ IF( SELF.Diff_append_overwrite_flag,1,0)+ IF( SELF.Diff_drivers_exchange_flag,1,0)+ IF( SELF.Diff_source_start_date,1,0)+ IF( SELF.Diff_source_end_date,1,0)+ IF( SELF.Diff_source_termination_date,1,0)+ IF( SELF.Diff_source_resale_allowed,1,0)+ IF( SELF.Diff_source_auto_renew,1,0)+ IF( SELF.Diff_source_allow_sale_of_component_data,1,0)+ IF( SELF.Diff_source_allow_extract_of_vehicle_data,1,0);
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
    Count_Diff_agency_id := COUNT(GROUP,%Closest%.Diff_agency_id);
    Count_Diff_agency_name := COUNT(GROUP,%Closest%.Diff_agency_name);
    Count_Diff_source_id := COUNT(GROUP,%Closest%.Diff_source_id);
    Count_Diff_agency_state_abbr := COUNT(GROUP,%Closest%.Diff_agency_state_abbr);
    Count_Diff_agency_ori := COUNT(GROUP,%Closest%.Diff_agency_ori);
    Count_Diff_allow_open_search := COUNT(GROUP,%Closest%.Diff_allow_open_search);
    Count_Diff_append_overwrite_flag := COUNT(GROUP,%Closest%.Diff_append_overwrite_flag);
    Count_Diff_drivers_exchange_flag := COUNT(GROUP,%Closest%.Diff_drivers_exchange_flag);
    Count_Diff_source_start_date := COUNT(GROUP,%Closest%.Diff_source_start_date);
    Count_Diff_source_end_date := COUNT(GROUP,%Closest%.Diff_source_end_date);
    Count_Diff_source_termination_date := COUNT(GROUP,%Closest%.Diff_source_termination_date);
    Count_Diff_source_resale_allowed := COUNT(GROUP,%Closest%.Diff_source_resale_allowed);
    Count_Diff_source_auto_renew := COUNT(GROUP,%Closest%.Diff_source_auto_renew);
    Count_Diff_source_allow_sale_of_component_data := COUNT(GROUP,%Closest%.Diff_source_allow_sale_of_component_data);
    Count_Diff_source_allow_extract_of_vehicle_data := COUNT(GROUP,%Closest%.Diff_source_allow_extract_of_vehicle_data);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
