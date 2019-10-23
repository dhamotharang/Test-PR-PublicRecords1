import ut;

EXPORT fnMap_SBA(boolean fcra = false, unsigned logType = 0) := function
	
	n := INQL_v2.test_count; /* n - to test a sample set, 0 to run all */
    
  SBA_daily_in := choosen(INQL_v2.Standardize_input(fcra, logType).SBA, IF(n > 0, n, choosen:ALL));
	filter_input := SBA_daily_in(regexfind(
					            'SMLLBUSANALYTICS|SMBUSAN_|RELIDENTSEARCH|CP_RELIDENTRPT|VERIFICATION|AUTHENTICATION|BUSINSID'
					            ,stringlib.stringtouppercase(function_name)
											)); 											

	//-------------Clean UP-------------//
	INQL_v2.fncleanfunctions.cleanfields(filter_input, cleaned_fields);

	SBA_data_dist  := distribute(cleaned_fields, hash(transaction_id));
  SBA_data_dedup := dedup(sort(SBA_data_dist,record, local), record,local);
	
  //-------------PROJECT INTO SLIM LAYOUT-------------//    
  cleanInput := project(SBA_data_dedup, transform(INQL_v2.Layouts.rSBA_Base, 
           self.cmp_fax_number         := left.cmp_fax_phone;
           self.cmp_alt_name           := left.cmp_alt_name;
           self.clean_first_name       := left.first_name;
           self.clean_middle_name      := left.middle_name;
           self.clean_last_name        := left.last_name;
           self.clean_suffix_name      := left.suffix_name;
           self.pii2_clean_first_name  := left.pii2_first_name;
           self.pii2_clean_middle_name := left.pii2_middle_name;
           self.pii2_clean_last_name   := left.pii2_last_name;
           self.pii2_clean_suffix_name := left.pii2_suffix_name;
           self.pii3_clean_first_name  := left.pii3_first_name;
           self.pii3_clean_middle_name := left.pii3_middle_name;
           self.pii3_clean_last_name   := left.pii3_last_name;
           self.pii3_clean_suffix_name := left.pii3_suffix_name;
           self.pii4_clean_first_name  := left.pii4_first_name;
           self.pii4_clean_middle_name := left.pii4_middle_name;
           self.pii4_clean_last_name   := left.pii4_last_name;
           self.pii4_clean_suffix_name := left.pii4_suffix_name;
           self.pii5_clean_first_name  := left.pii5_first_name;
           self.pii5_clean_middle_name := left.pii5_middle_name;
           self.pii5_clean_last_name   := left.pii5_last_name;
           self.pii5_clean_suffix_name := left.pii5_suffix_name;
           self.pii6_clean_first_name  := left.pii6_first_name;
           self.pii6_clean_middle_name := left.pii6_middle_name;
           self.pii6_clean_last_name   := left.pii6_last_name;
           self.pii6_clean_suffix_name := left.pii6_suffix_name;
           self.pii7_clean_first_name  := left.pii7_first_name;
           self.pii7_clean_middle_name := left.pii7_middle_name;
           self.pii7_clean_last_name   := left.pii7_last_name;
           self.pii7_clean_suffix_name := left.pii7_suffix_name;
           self.pii8_clean_first_name  := left.pii8_first_name;
           self.pii8_clean_middle_name := left.pii8_middle_name;
           self.pii8_clean_last_name   := left.pii8_last_name;
           self.pii8_clean_suffix_name := left.pii8_suffix_name;
           fixDate := INQL_v2.fncleanfunctions.tDateAdded(left.date_added);
           fixTime := INQL_v2.fncleanfunctions.tTimeAdded(fixDate);
           self.DateTime := fixTime;
           self := left;
           self :=[]));																													

	return if(logType = 9, cleanInput, dataset([], INQL_v2.Layouts.rSBA_Base));
	
END;