import ut,lib_stringlib;

export fnMapCommon_SBA := module

export ready_file := function

SBA_daily_in := inquiry_acclogs.File_SBA_Logs.input
           (regexfind(
					            'SMLLBUSANALYTICS|SMBUSAN_|RELIDENTSEARCH|CP_RELIDENTRPT|VERIFICATION|AUTHENTICATION'
					            ,stringlib.stringtouppercase(function_name)
											)
						);
//clean fields
inquiry_acclogs.fncleanfunctions.cleanfields(SBA_daily_in, cleaned_fields);

SBA_data_dist := distribute(cleaned_fields, hash(transaction_id));

SBA_data_dedup := dedup(sort(SBA_data_dist,record, local), record,local);

///////////// PROJECT INTO SLIM LAYOUT ///////////////////////////////////////////////////////////////////////////////////////////////////////
			
SBA_project := project(SBA_data_dedup, transform(inquiry_acclogs.Layout_SBA_Logs.common, 
self.pii2_clean_first_name := left.pii2_first_name;        
self.pii2_clean_middle_name := left.pii2_middle_name;      
self.pii2_clean_last_name := left.pii2_last_name;        
self.pii2_clean_suffix_name := left.pii2_suffix_name; 
self.pii3_clean_first_name := left.pii3_first_name;        
self.pii3_clean_middle_name := left.pii3_middle_name;      
self.pii3_clean_last_name := left.pii3_last_name;        
self.pii3_clean_suffix_name := left.pii3_suffix_name; 
self.pii4_clean_first_name := left.pii4_first_name;        
self.pii4_clean_middle_name := left.pii4_middle_name;      
self.pii4_clean_last_name := left.pii4_last_name;        
self.pii4_clean_suffix_name := left.pii4_suffix_name; 
self.pii5_clean_first_name := left.pii5_first_name;        
self.pii5_clean_middle_name := left.pii5_middle_name;      
self.pii5_clean_last_name := left.pii5_last_name;        
self.pii5_clean_suffix_name := left.pii5_suffix_name; 
self.pii6_clean_first_name := left.pii6_first_name;        
self.pii6_clean_middle_name := left.pii6_middle_name;      
self.pii6_clean_last_name := left.pii6_last_name;        
self.pii6_clean_suffix_name := left.pii6_suffix_name; 
self.pii7_clean_first_name := left.pii7_first_name;        
self.pii7_clean_middle_name := left.pii7_middle_name;      
self.pii7_clean_last_name := left.pii7_last_name;        
self.pii7_clean_suffix_name := left.pii7_suffix_name; 
self.pii8_clean_first_name := left.pii8_first_name;        
self.pii8_clean_middle_name := left.pii8_middle_name;      
self.pii8_clean_last_name := left.pii8_last_name;        
self.pii8_clean_suffix_name := left.pii8_suffix_name; 
fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.date_added);
fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
self.DateTime := 	fixTime;
self := left));

return SBA_project;
end;
end;