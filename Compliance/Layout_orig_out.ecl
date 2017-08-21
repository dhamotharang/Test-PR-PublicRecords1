
EXPORT Layout_orig_out := 
				RECORD
					Compliance.Layout_In;
					
					string	ACTION_DMF_Value := '';	//June 2016
					string	ACTION_FuncName := '';	//June 2016
					
					string		srch_criteria := '';
					string20	srch_fname := '';
					string20	srch_mname := '';
					string20	srch_lname := '';
					string		srch_fullname := '';		//new
					string		srch_busname := '';			//new
					string64	srch_address := '';
					string8		srch_address_sec_range := '';			//April 2015
					string28	srch_city := '';
					string2		srch_state := '';
					string5		srch_zip := '';
					string10	srch_ssn := '';
					integer4	srch_dob := 0;
					string10	srch_phone := '';
					unsigned6	srch_uid := 0;
					string		srch_tag := '';		//new
					string		srch_vin := '';		//new
					
					string		name_clnr_string := '';	//April 2014
					string		addr_clnr_string := '';	//April 2014
					
					integer4	age_lower := 0;		//December 2014; for "Age Range(nn to nn)"
					integer4	age_upper := 0;		//December 2014; for "Age Range(nn to nn)"
					
					string10	srch_class := '';			//input criteria combination
					
					string srch_dataset := '';
					string source_value := '';
					
			END;
