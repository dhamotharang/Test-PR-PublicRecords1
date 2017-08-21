EXPORT mac_matchCodes(aRes) := MACRO
		self.xlink_matches := 
					IF (aRes.sname_match_code = 99, '-',  (STRING)aRes.sname_match_code) + '/' + 
					IF (aRes.fname_match_code = 99, '-',  (STRING)aRes.fname_match_code) + '/' + 
					IF (aRes.mname_match_code = 99, '-',  (STRING)aRes.mname_match_code) + '/' + 
					IF (aRes.lname_match_code = 99, '-',  (STRING)aRes.lname_match_code) + '/' + 
					IF (aRes.derived_gender_match_code = 99, '-',  (STRING)aRes.derived_gender_match_code) + '/' + 
					IF (aRes.prim_range_match_code = 99, '-',  (STRING)aRes.prim_range_match_code) + '/' + 
					IF (aRes.prim_name_match_code = 99, '-',  (STRING)aRes.prim_name_match_code) + '/' + 
					IF (aRes.sec_range_match_code = 99, '-',  (STRING)aRes.sec_range_match_code) + '/' + 
					IF (aRes.city_match_code = 99, '-',  (STRING)aRes.city_match_code) + '/' + 
					IF (aRes.st_match_code = 99, '-',  (STRING)aRes.st_match_code) + '/' + 
					IF (aRes.zip_match_code = 99, '-',  (STRING)aRes.zip_match_code) + '/' + 
					IF (aRes.ssn5_match_code = 99, '-',  (STRING)aRes.ssn5_match_code) + '/' + 
					IF (aRes.ssn4_match_code = 99, '-',  (STRING)aRes.ssn4_match_code) + '/' + 
					IF (aRes.dob_year_match_code = 99, '-',  (STRING)aRes.dob_year_match_code) + '/' + 
					IF (aRes.dob_month_match_code = 99, '-',  (STRING)aRes.dob_month_match_code) + '/' + 
					IF (aRes.dob_day_match_code = 99, '-',  (STRING)aRes.dob_day_match_code) + '/' + 					
					IF (aRes.phone_match_code = 99, '-',  (STRING)aRes.phone_match_code) + '/' + 
					IF (aRes.dl_state_match_code = 99, '-',  (STRING)aRes.dl_state_match_code) + '/' + 
					IF (aRes.dl_nbr_match_code = 99, '-',  (STRING)aRes.dl_nbr_match_code) + '/' + 
					IF (aRes.src_match_code = 99, '-',  (STRING)aRes.src_match_code) + '/' + 
					IF (aRes.source_rid_match_code = 99, '-',  (STRING)aRes.source_rid_match_code) + '/' + 
					// IF (aRes.rid_match_code = 99, '-',  (STRING)aRes.rid_match_code) + '/' + 
					'/' + 
					IF (aRes.mainname_match_code = 99, '-',  (STRING)aRes.mainname_match_code) ;		
					
ENDMACRO;