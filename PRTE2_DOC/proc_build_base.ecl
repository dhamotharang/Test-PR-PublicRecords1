IMPORT  PRTE2_DOC,PromoteSupers, prte2,ut, std, address, aid;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
		
		prte2.CleanFields(Files.corrections_offenses_IN, DOC_Offenses_Clean);

		prte2.CleanFields(Files.corrections_CourtOffenses_IN,DOC_CourtOffenses_Clean);

		prte2.CleanFields(Files.corrections_offenders_IN,DOC_Offenders_Clean);

		prte2.CleanFields(Files.corrections_punishment_IN,DOC_Punishment_Clean);

		prte2.CleanFields(Files.corrections_activity_IN,DOC_Activity_Clean);
		
		df_offenses := PROJECT(	DOC_Offenses_Clean, 
														transform( Layouts.layout_offenses_base_plus, 
																			 self.offense_category := 0, 
																			 self := left));
		
		df_CourtOffenses := PROJECT(DOC_CourtOffenses_Clean, layouts.layout_court_offenses_base_plus);

		// New offenders records need address and name cleaning and linking.
		in_offenders_new := DOC_Offenders_Clean(cust_name != '');

		in_offenders_new_clean_address := PRTE2.AddressCleaner(		in_offenders_new, 					// Record set with addresses to be cleaned
																															['street_address_1'],  			// Set of fields containing address line 1
																															['street_address_2'],  			// Set of fields containing address line 2
																															[],										 			// Set of fields containing city
																															[],										 			// Set of fields containing state
																															[],										 			// Set of fields containing zip
																															['clean_address'],		 			// Target fields for Address.Layout_Clean182_fips	
																															['admin_rawaid']) ;	   			// Target fields for rawaids
																							
		Layouts.layout_offender_plus xform_offenders(in_offenders_new_clean_address l) := Transform 
			clean_name := Address.CleanPersonFML73(STD.Str.CleanSpaces(trim(l.pty_nm)));
			self.fname := Address.CleanNameFields(clean_name).fname;
			self.mname := Address.CleanNameFields(clean_name).mname;
			self.lname := Address.CleanNameFields(clean_name).lname;
			self.name_suffix := Address.CleanNameFields(clean_name).name_suffix;
			SELF.DOB := INTFORMAT(l.DOB,8,1); 
			self.did := (string12)prte2.fn_AppendFakeID.did(self.fname, self.lname, l.link_ssn, l.link_dob, l.cust_name);
			SELF.ZIP5 := l.ZIP5;
			self.ssn_appended := l.ssn;
			self.ace_fips_st := l.clean_address.fips_state;
			self.ace_fips_county := l.clean_address.fips_county;
			self := l.clean_address;
			self := l;
		end;
		df_offenders_new := PROJECT(	in_offenders_new_clean_address, xform_offenders(left));
									
		df_offenders_old := PROJECT(	DOC_Offenders_Clean(cust_name = ''), 
																	Transform(Layouts.layout_offender_plus, 
																			SELF.DOB := INTFORMAT(left.DOB,8,1), 
																			SELF.Did := (string12)Left.did,
																			SELF.ZIP5 := INTFORMAT((INTEGER)LEFT.ZIP5,5,1),
																			self := left));
									
		df_offenders := df_offenders_old + df_offenders_new;

		df_punishment := PROJECT(DOC_Punishment_Clean, layouts.layout_punishment_plus);
									 
		file_punishment_keybuilding := dedup(sort(df_punishment(sent_length <> ''   or sent_length_desc<> '' or 				
											 cur_stat_inm <> ''  or cur_stat_inm_desc <> '' or 				
											cur_loc_inm_cd <> '' or cur_loc_inm <> '' or 				
											inm_com_cty_cd <> '' or inm_com_cty <> '' or 				
											cur_sec_class_dt <> '' or cur_loc_sec <> '' or 				
											gain_time <> '' or 	gain_time_eff_dt <> '' or 				
											latest_adm_dt <> '' or sch_rel_dt <> '' or 				
											act_rel_dt <> '' or ctl_rel_dt <> '' or 				
											presump_par_rel_dt <> '' or mutl_part_pgm_dt <> '' or 				
											par_cur_stat <> '' or par_cur_stat_desc <> '' or 				
											par_st_dt <> ''    or par_sch_end_dt <> '' or 				
											par_act_end_dt <> '' or par_cty_cd <> '' or 				
											par_cty <> '' or 			supv_officer <> '' or office_phone <> '' or 
											tdcjid_unit_type <> '' or tdcjid_unit_assigned <> '' or 
											tdcjid_admit_date <> '' or prison_status <> '' or 
											recv_dept_code <> '' or recv_dept_date <> '' or 
											parole_active_flag <> '' or casepull_date <> '' ) ,record), except punishment_persistent_id);

		df_activity := PROJECT(DOC_Activity_Clean, layouts.layout_activity_base_plus);

		PromoteSupers.MAC_SF_BuildProcess(df_offenses,'~PRTE::BASE::corrections::offenses', writefile_offenses,,,,filedate);

		PromoteSupers.MAC_SF_BuildProcess(df_CourtOffenses,'~PRTE::BASE::corrections::court_offenses', writefile_court_offenses,,,,filedate);

		PromoteSupers.MAC_SF_BuildProcess(df_offenders,'~PRTE::BASE::corrections::offenders', writefile_offenders,,,,filedate);

		PromoteSupers.MAC_SF_BuildProcess(file_punishment_keybuilding,'~PRTE::BASE::corrections::punishment', writefile_punishment,,,,filedate);

		PromoteSupers.MAC_SF_BuildProcess(df_activity,'~PRTE::BASE::corrections::activity', writefile_activity,,,,filedate);

		return sequential(writefile_court_offenses,writefile_offenses,writefile_offenders,writefile_punishment,writefile_activity);
		
END;