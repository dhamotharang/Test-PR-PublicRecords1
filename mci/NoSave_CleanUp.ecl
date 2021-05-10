import lib_fileservices, tools, Std, ut, wk_ut, MCI, HealthcareNoMatchHeader_Ingest;

EXPORT NoSave_CleanUp := MODULE

	export str_crk_unique 			:= 'USGV::MCI';
	export str_nosave 					:= '_NOSAVE';
	export str_from_batch				:= 'FROM_BATCH';					
	export str_processed_input	:= 'PROCESSED_INPUT';	
	export str_asheader					:= 'ASHEADER';							
	export str_temp_header			:= 'TEMP_HEADER';					
	export str_base							:= 'BASE';											
	export str_to_batch					:= 'TO_BATCH';							
	export str_to_batch_metrics	:= 'TO_BATCH_METRICS';	
	export str_slim_history			:= 'SLIM_HISTORY';
	export str_delim 						:= '::';
	export str_delim_secondary	:= '_';
	export grace_period_days 		:= 5;
	export days_till_delete_NA	:= 9999;
	export email_to 						:= 'sesha.nookala@lexisnexisrisk.com';
	export send_email 					:= FALSE;						//SHOULD BE TRUE WHEN WE GO LIVE!!
	export write_log 						:= FALSE; 						//SHOULD BE TRUE WHEN WE GO LIVE!!
	export execute_deletes 			:= FALSE;	//SHOULD BE TRUE WHEN WE GO LIVE!!
	export URL_details 					:= 'http://' + wk_ut._constants.LocalEsp + ':8010/?Wuid=' + Workunit + '&Sequence=0&Widget=ResultsWidget';
	
	
	export get_part(string lfn, integer2 starting_delim, integer2 known_length = 0) := FUNCTION

		lnf_up 										:= std.str.touppercase(lfn);
		str_crk_unique_up 				:= std.str.touppercase(str_crk_unique);
		str_delim_up							:= std.str.touppercase(str_delim);
	
		// rm_noise := std.str.FindReplace(lnf_up, 'HEALTHCARENOMATCHHEADER::','');			//could add other stuff here
		rm_noise := std.str.FindReplace(lnf_up, '','');			//could add other stuff here

		rm_prefix := rm_noise[std.str.find(rm_noise, str_crk_unique_up, 1) + length(str_crk_unique) + 1..];
		first_pos := std.str.find(rm_prefix, str_delim_up, starting_delim) + length(str_delim);
		last_pos 	:= 
			if(
				known_length = 0,
				std.str.find(rm_prefix[first_pos..], str_delim_up, 1) + first_pos -2,
				first_pos + known_length - 1);
	
		return rm_prefix[first_pos..last_pos];
	END;
	
	export get_part_from_super(string lfn, integer2 starting_delim, integer2 known_length = 0) := FUNCTION

		lnf_up 										:= std.str.touppercase(lfn);
		str_crk_unique_up 				:= std.str.touppercase(str_crk_unique);
		str_delim_up							:= std.str.touppercase(str_delim);
		str_delim_sec_up					:= std.str.touppercase(str_delim_secondary);
	
		rm_noise := std.str.FindReplace(lnf_up, '','');			//could add other stuff here

		rm_prefix := rm_noise[std.str.find(rm_noise, str_crk_unique_up, 1) + length(str_crk_unique) + 1..];
		first_pos := std.str.find(rm_prefix, str_delim_up, starting_delim) + length(str_delim);
		last_pos 	:= 
			if(
				known_length = 0,
				std.str.find(rm_prefix[first_pos..], str_delim_sec_up, 1) + first_pos -2,
				first_pos + known_length - 1);
	
		return rm_prefix[first_pos..last_pos];
	END;
	
	export get_gcid(string lfn) 									:= get_part(lfn, 1);
	export get_type(string lfn) 									:= get_part(lfn, 0);
	export get_version(string lfn) 								:= get_part(lfn, 2, 8);
	export get_version_from_batch(string lfn) 		:= get_part(lfn, 3, 8);
	export get_gcid_from_batch_super(string lfn) 	:= get_part_from_super(lfn, 1);
	
	export allcrk1 := STD.File.LogicalFileList('*'+str_crk_unique+'*',,includesuper := TRUE);
	export logcrk1 := STD.File.LogicalFileList('*'+str_crk_unique+'*',,includesuper := FALSE);
	
	export search_files(string asOfDate, string searchType) := FUNCTION
	
		allcrk2 := project(allcrk1, transform(
								{recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip(get_type(left.name) <> searchType)
								,self.type := get_type(left.name)			
								,self.gcid := get_gcid(left.name)
								,self.version 	:= map(
														left.superfile						=>  std.Date.ConvertDateFormat(left.modified[1..10]), 
														get_type(left.name)	= 'FROM_BATCH'	=> get_version_from_batch(left.name),
														get_version(left.name))
								,self.days_old := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)asOfDate, (unsigned4)self.version)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));

		allcrk3 := join(allcrk2, dedup(allcrk2(name_says_nosave), gcid, version, all),
								left.gcid = right.gcid and
								left.version = right.version,
								transform({recordof(allcrk2), boolean gcid_version_has_nosave},
									self.gcid_version_has_nosave := right.gcid <> '',
									self := left), left outer);
	
		allcrk4 := join(allcrk3, dedup(allcrk2(name_says_nosave), gcid, all),
								left.gcid = right.gcid,
								transform({recordof(allcrk3), boolean gcid_has_nosave, boolean will_delete, integer days_till_delete, string8 report_date, string sf_owner1, string sf_owner2},
									self.gcid_has_nosave 	:= right.gcid <> '',
									self.will_delete 			:= left.gcid_version_has_nosave and not left.superfile;
									self.days_till_delete := if(self.will_delete, grace_period_days - left.days_old, days_till_delete_NA);
									self.report_date 			:= asOfDate;
									sfo1 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[1].name, '');
									sfo2 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[2].name, '');
									self.sf_owner1				:= if(sfo1 <> '', '~'+ sfo1, '');
									self.sf_owner2				:= if(sfo2 <> '', '~'+ sfo2, '');
									self := left), left outer);	

		return allcrk4;//done with joins
	END;//search_files
	
	export search_files_super_only(string asOfDate, string searchType) := FUNCTION
	
		allcrk2 := project(allcrk1, transform(
								{recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip((get_type(left.name) <> searchType) or (not left.superfile))
								,self.type := get_type(left.name)			
								,self.gcid := get_gcid(left.name)
								,self.version 	:= map(
														left.superfile						=>  '', 
														get_type(left.name)	= 'FROM_BATCH'	=> get_version_from_batch(left.name),
														get_version(left.name))
								,self.days_old := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)asOfDate, (unsigned4)self.version)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));

		allcrk3 := join(allcrk2, dedup(allcrk2(name_says_nosave), gcid, version, all),
								left.gcid = right.gcid and
								left.version = right.version,
								transform({recordof(allcrk2), boolean gcid_version_has_nosave},
									self.gcid_version_has_nosave := right.gcid <> '',
									self := left), left outer);
	
		allcrk4 := join(allcrk3, dedup(allcrk2(name_says_nosave), gcid, all),
								left.gcid = right.gcid,
								transform({recordof(allcrk3), boolean gcid_has_nosave, boolean will_delete, integer days_till_delete, string8 report_date, string sf_owner1, string sf_owner2},
									self.gcid_has_nosave 	:= right.gcid <> '',
									self.will_delete 			:= left.gcid_version_has_nosave;// and not left.superfile;
									self.days_till_delete := if(self.will_delete, grace_period_days - left.days_old, days_till_delete_NA);
									self.report_date 			:= asOfDate;
									sfo1 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[1].name, '');
									sfo2 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[2].name, '');
									self.sf_owner1				:= if(sfo1 <> '', '~'+ sfo1, '');
									self.sf_owner2				:= if(sfo2 <> '', '~'+ sfo2, '');
									self := left), left outer);	

		return allcrk4;//done with joins
	END;//search_files_super_only
	
	export search_files_super_nosave(string asOfDate, string searchType) := FUNCTION
	
		allcrk2 := project(allcrk1, transform(
								{recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip((get_type(left.name) <> searchType) or (not left.superfile))
								,self.type := get_type(left.name)			
								,self.gcid := get_gcid(left.name)
								,self.version 	:= map(
														left.superfile						=>  '', 
														get_type(left.name)	= 'FROM_BATCH'	=> get_version_from_batch(left.name),
														get_version(left.name))
								,self.days_old := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)asOfDate, (unsigned4)self.version)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));

		allcrk3 := join(allcrk2(name_says_nosave = true), dedup(allcrk2(name_says_nosave = true), gcid, version, all),
								left.gcid = right.gcid and
								left.version = right.version,
								transform({recordof(allcrk2), boolean gcid_version_has_nosave},
									self.gcid_version_has_nosave := right.gcid <> '',
									self := left), left outer);
	
		allcrk4 := join(allcrk3, dedup(allcrk2(name_says_nosave = true), gcid, all),
								left.gcid = right.gcid,
								transform({recordof(allcrk3), boolean gcid_has_nosave, boolean will_delete, integer days_till_delete, string8 report_date, string sf_owner1, string sf_owner2},
									self.gcid_has_nosave 	:= right.gcid <> '',
									self.will_delete 			:= left.gcid_version_has_nosave;// and not left.superfile;
									self.days_till_delete := if(self.will_delete, grace_period_days - left.days_old, days_till_delete_NA);
									self.report_date 			:= asOfDate;
									sfo1 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[1].name, '');
									sfo2 									:= if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[2].name, '');
									self.sf_owner1				:= if(sfo1 <> '', '~'+ sfo1, '');
									self.sf_owner2				:= if(sfo2 <> '', '~'+ sfo2, '');
									self := left), left outer);	

		return allcrk4;//done with joins
	END;//search_files_super_only
	
	export search_super_from_batch_nosave(string asOfDate, string searchType = 'FROM_BATCH', boolean name_says_nosave = true) := FUNCTION
	
		allcrk2 := project(allcrk1, transform(
								{recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip((get_type(left.name) <> searchType) or (not left.superfile))
								,self.type := get_type(left.name)			
								,self.gcid := if(get_gcid(left.name) = '', get_gcid_from_batch_super(left.name), get_gcid(left.name))
								,self.version 	:= map(
														left.superfile						=>  '', 
														get_type(left.name)	= 'FROM_BATCH'	=> get_version_from_batch(left.name),
														get_version(left.name))
								,self.days_old := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)asOfDate, (unsigned4)self.version)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));

		return dedup(allcrk2(name_says_nosave),all);
	END;

	export search_logical_files(string asOfDate, string searchType) := FUNCTION

		allcrk2 := project(logcrk1, transform({recordof(logcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip(get_type(left.name) <> searchType)
								,self.type 			:= get_type(left.name)			
								,self.gcid 			:= get_gcid(left.name)
								,self.version 	:= map(left.superfile => '', 
																			 get_type(left.name) = 'FROM_BATCH' => get_version_from_batch(left.name),
																			 get_version(left.name))
								,self.days_old 				 := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)self.version, (unsigned4)asOfDate)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name 						 := '~'+left.name
								,self									 := left));
		//join back to list of nosave gcid versions to find more and to look for conflicts
		allcrk3 := join(allcrk2, dedup(allcrk2(name_says_nosave), gcid, version, all),
								left.gcid = right.gcid and
								left.version = right.version,
										transform({recordof(allcrk2), boolean gcid_version_has_nosave},
											self.gcid_version_has_nosave := right.gcid <> '',
											self := left), left outer);
		//now same but just by gcid
		allcrk4 := join(allcrk3, dedup(allcrk2(name_says_nosave), gcid, all),
								left.gcid = right.gcid,
									transform({recordof(allcrk3), boolean gcid_has_nosave, boolean will_delete, integer days_till_delete, string8 report_date, string sf_owner1, string sf_owner2},
											self.gcid_has_nosave := right.gcid <> '',
											self.will_delete := left.gcid_version_has_nosave and not left.superfile;
											self.days_till_delete := if(self.will_delete, grace_period_days - left.days_old, days_till_delete_NA);
											self.report_date := asOfDate;
											sfo1 := if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[1].name, '');
											sfo2 := if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[2].name, '');
											self.sf_owner1:= if(sfo1 <> '', '~'+ sfo1, '');
											self.sf_owner2:= if(sfo2 <> '', '~'+ sfo2, '');
											self := left), left outer);	

		return allcrk4(gcid_has_nosave = true);//done with joins
	END;//search_logical_files
	
	export search_logical_files_from_batch(string asOfDate, string searchType = 'FROM_BATCH') := FUNCTION

		allcrk2 := project(allcrk1, transform({recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip(get_type(left.name) <> searchType)
								,self.type 			:= get_type(left.name)			
								,self.gcid 			:= get_gcid(left.name)
								,self.version 	:= map(left.superfile => '', 
																			 get_type(left.name) = 'FROM_BATCH' => get_version_from_batch(left.name),
																			 get_version(left.name))
								,self.days_old 				 := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)self.version, (unsigned4)asOfDate)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name 						 := '~'+left.name
								,self									 := left));
		//join back to list of nosave gcid versions to find more and to look for conflicts
		allcrk3 := join(allcrk2, dedup(allcrk2(name_says_nosave), gcid, version, all),
								left.gcid = right.gcid and
								left.version = right.version,
										transform({recordof(allcrk2), boolean gcid_version_has_nosave},
											self.gcid_version_has_nosave := right.gcid <> '',
											self := left), left outer);
		//now same but just by gcid
		allcrk4 := join(allcrk3, dedup(allcrk2(name_says_nosave), gcid, all),
								left.gcid = right.gcid,
									transform({recordof(allcrk3), boolean gcid_has_nosave, boolean will_delete, integer days_till_delete, string8 report_date, string sf_owner1, string sf_owner2},
											self.gcid_has_nosave := right.gcid <> '',
											// self.will_delete := left.gcid_version_has_nosave and not left.superfile;
											self.will_delete := self.gcid_has_nosave and not left.superfile;
											self.days_till_delete := if(self.will_delete, grace_period_days - left.days_old, days_till_delete_NA);
											self.report_date := asOfDate;
											sfo1 := if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[1].name, '');
											sfo2 := if(not left.superfile, std.file.LogicalFileSuperOwners(left.name)[2].name, '');
											self.sf_owner1:= if(sfo1 <> '', '~'+ sfo1, '');
											self.sf_owner2:= if(sfo2 <> '', '~'+ sfo2, '');
											self := left), left outer);	

		return allcrk4(gcid_has_nosave = true and not superfile);//done with joins
	END;//search_logical_files_from_batch
			
	EXPORT get_list_of_gcids(string asOfDate, string searchType) := FUNCTION

		allcrk2 := project(logcrk1, transform({recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip(get_type(left.name) <> searchType)
								,self.type := get_type(left.name)			
								,self.gcid := get_gcid(left.name)
								,self.version 	:= if(left.superfile, '', get_version(left.name))
								,self.days_old 	:= if(left.superfile, 0, std.Date.DaysBetween((unsigned4)self.version, (unsigned4)asOfDate)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));
		//join back to list of nosave gcid versions to find more and to look for conflicts
		allcrk_nosave := allcrk2(name_says_nosave = true);
		allcrk3 := dedup(project(allcrk_nosave, {string gcid}), all);
		return allcrk3;//allcrk4;//done with joins
	END;//get_list_of_gcids
	
	EXPORT get_list_of_versions(string asOfDate, string searchType) := FUNCTION

		allcrk2 := project(logcrk1, transform({recordof(allcrk1), string gcid, string version, string type, integer days_old, boolean name_says_nosave}, skip(get_type(left.name) <> searchType)
								,self.type := get_type(left.name)			
								,self.gcid := get_gcid(left.name)
								,self.version 	:= if(left.superfile, '', get_version(left.name))
								,self.days_old := if(left.superfile, 0, std.Date.DaysBetween((unsigned4)asOfDate, (unsigned4)self.version)); 
								,self.name_says_nosave := std.str.find(std.str.touppercase(left.name), std.str.touppercase(str_nosave), 1) > 0			
								,self.name := '~'+left.name
								,self := left));
		//join back to list of nosave gcid versions to find more and to look for conflicts
		allcrk_nosave := allcrk2(name_says_nosave = true);
		allcrk3 := dedup(project(allcrk_nosave, {string version}), all);
		return allcrk3;//allcrk4;//done with joins
	END;//get_list_of_versions

	EXPORT search_and_destroy_non_input(string asOfDate, string searchType) := FUNCTION

			proc_input_ds						:= search_logical_files(asOfDate, 'PROCESSED_INPUT');
			as_header_ds						:= search_logical_files(asOfDate, 'ASHEADER');
			temp_head_ds						:= search_logical_files(asOfDate, 'TEMP_HEADER');
			to_batch_ds							:= search_logical_files(asOfDate, 'TO_BATCH');
			to_batch_met_ds					:= search_logical_files(asOfDate, 'TO_BATCH_METRICS');

			ds 											:= proc_input_ds + as_header_ds + temp_head_ds + to_batch_ds + to_batch_met_ds;

			//check for deletes needed
			delete_overdue	 	:= ds(days_till_delete < 0);
			delete_today 			:= ds(days_till_delete = 0);
			deleting					:= delete_overdue + delete_today;
			delete_soon				:= ds(days_till_delete <= grace_period_days);

			remove_supers1 		:= nothor(apply(global(deleting(sf_owner1 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner1,execute_deletes)));
			remove_supers2		:= nothor(apply(global(deleting(sf_owner2 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner2,execute_deletes)));
			delete_logical 		:= nothor(apply(global(deleting,few), tools.mod_Utilities.deletelogical	(name)));

			delete_action := ordered(
					remove_supers1,
					remove_supers2,
					delete_logical);
					
			//potential issues
			gcids_versions_conflicted := ds(gcid_version_has_nosave and not name_says_nosave);
			gcids_conflicted 					:= ds(gcid_has_nosave and not gcid_version_has_nosave);

			//send an email
			email_Subject := 'CRK NoSave File Deletion Report';
			email_body := 
						'\n'
						+'Deletes Executed: ' 									+ if(execute_deletes, 'YES', 'NO(execute_deletes is set to false) ') + '\n'
						+'\n'
						+'Deleting Now: ' 													+ count(deleting) + '\n'
						+'    Deletes Overdue: ' 						+ count(delete_overdue) + '\n'
						+'    Deletes Due Today: ' 				+ count(delete_today) + '\n'
						+'Deletes Soon: ' 													+ count(delete_soon) + '\n'
						+'\n'
						+'GCID version conflicts: ' 			+ if(exists(gcids_versions_conflicted), 'YES, ENTIRE GCID VERSION DELETED!!', 'NO') + '\n'
						+'GCID conflicts: ' 											+ if(exists(gcids_conflicted), 'YES, ONLY NOSAVE VERSIONS DELETED!!', 'NO') + '\n'
						+'\n'
						+'Details: ' + URL_details;

		return
		parallel(
				output(email_body, named('email_body'))
				,output(ds, named('details_before_delete'))
				,output(deleting, named('for_delete'))
				,output(execute_deletes, named('executing_deletes'))
				,output(dedup(table(ds(gcid in set(gcids_versions_conflicted, gcid) and version in set(gcids_versions_conflicted, version)), {gcid, version, gcid_version_has_nosave, name_says_nosave}), all), named('gcid_versions_conflicted'))
				,output(dedup(table(ds(gcid in set(gcids_conflicted, gcid)), {gcid, version, gcid_version_has_nosave, gcid_has_nosave}), all), named('gcids_conflicted'))
				,if(write_log, output(ds,,'~log::CRK::NoSaveReport' + workunit))		 
				,if(execute_deletes, ordered(delete_action, output(search_logical_files(asOfDate,searchType), named('details_after_delete'))))
		 // ,if(send_Email, fileservices.sendemail(email_to, email_Subject, email_body, lib_system.smtpserver,lib_system.smtpport,lib_system.emailAddress))
			);
		
	END; 
	
	EXPORT search_and_destroy_from_batch(string asOfDate, string searchType = 'FROM_BATCH') := FUNCTION

			ds 											:= search_logical_files_from_batch(asOfDate,'FROM_BATCH');

			//check for deletes needed
			delete_overdue	 	:= ds(days_till_delete < 0);
			delete_today 			:= ds(days_till_delete = 0);
			deleting					:= delete_overdue + delete_today;
			delete_soon				:= ds(days_till_delete <= grace_period_days);

			remove_supers1 		:= nothor(apply(global(deleting(sf_owner1 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner1,execute_deletes)));
			remove_supers2 		:= nothor(apply(global(deleting(sf_owner2 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner2,execute_deletes)));
			delete_logical 		:= nothor(apply(global(deleting,few), tools.mod_Utilities.deletelogical	(name)));
			
			delete_action := ordered(
					remove_supers1, 
					remove_supers2, 
					delete_logical);

			//potential issues
			gcids_versions_conflicted := ds(gcid_version_has_nosave and not name_says_nosave);
			gcids_conflicted 					:= ds(gcid_has_nosave and not gcid_version_has_nosave);

			//send an email
			email_Subject := 'CRK NoSave File Deletion Report';
			email_body := 
						'\n'
						+'Deletes Executed: ' 									+ if(execute_deletes, 'YES', 'NO(execute_deletes is set to false) ') + '\n'
						+'\n'
						+'Deleting Now: ' 													+ count(deleting) + '\n'
						+'    Deletes Overdue: ' 						+ count(delete_overdue) + '\n'
						+'    Deletes Due Today: ' 				+ count(delete_today) + '\n'
						+'Deletes Soon: ' 													+ count(delete_soon) + '\n'
						+'\n'
						+'GCID version conflicts: ' 			+ if(exists(gcids_versions_conflicted), 'YES, ENTIRE GCID VERSION DELETED!!', 'NO') + '\n'
						+'GCID conflicts: ' 											+ if(exists(gcids_conflicted), 'YES, ONLY NOSAVE VERSIONS DELETED!!', 'NO') + '\n'
						+'\n'
						+'Details: ' + URL_details;

		return
		parallel(
				output(email_body, named('email_body_from_batch'))
				,output(ds, named('details_before_delete_from_batch'))
				,output(deleting, named('for_delete_from_batch'))
				,output(execute_deletes, named('executing_deletes_from_batch'))
				,output(dedup(table(ds(gcid in set(gcids_versions_conflicted, gcid) and version in set(gcids_versions_conflicted, version)), {gcid, version, gcid_version_has_nosave, name_says_nosave}), all), named('gcid_versions_conflicted_from_batch'))
				// ,output(dedup(table(ds(gcid in set(gcids_conflicted, gcid)), {gcid, version, gcid_version_has_nosave, gcid_has_nosave}), all), named('gcids_conflicted_from_batch'))
				,if(write_log, output(ds,,'~log::CRK::NoSaveReport_from_batch' + workunit))		 
				,if(execute_deletes, ordered(delete_action, output(search_logical_files_from_batch(asOfDate,searchType), named('details_after_delete_from_batch'))))
		 // ,if(send_Email, fileservices.sendemail(email_to, email_Subject, email_body, std.system.smtpserver,std.system.smtpport,std.system.emailAddress))
			);

	END; 
	
	EXPORT search_and_destroy_all(string asOfDate) := FUNCTION

			ds_from							:= search_logical_files_from_batch(asOfDate,'FROM_BATCH');
			ds_process					:= search_logical_files(asOfDate,'PROCESSED_INPUT');
			ds_asheader					:= search_logical_files(asOfDate,'ASHEADER');
			ds_temp_header			:= search_logical_files(asOfDate,'TEMP_HEADER');
			ds_base							:= search_logical_files(asOfDate,'BASE');
			ds_to_batch					:= search_logical_files(asOfDate,'TO_BATCH');
			ds_to_batch_metrics	:= search_logical_files(asOfDate,'TO_BATCH_METRICS');
			ds_slim_history			:= search_logical_files(asOfDate,'SLIM_HISTORY');
			
			ds_from_super				:= search_files_super_nosave(asOfDate,'FROM_BATCH');
			ds_process_super		:= search_files_super_nosave(asOfDate,'PROCESSED_INPUT');
			ds_asheader_super		:= search_files_super_nosave(asOfDate,'ASHEADER');
			ds_temp_super				:= search_files_super_nosave(asOfDate,'TEMP_HEADER');
			ds_base_super				:= search_files_super_nosave(asOfDate,'BASE');
			ds_to_batch_super		:= search_files_super_nosave(asOfDate,'TO_BATCH');
			ds_metrics_super		:= search_files_super_nosave(asOfDate,'TO_BATCH_METRICS');
			ds_slim_super				:= search_files_super_nosave(asOfDate,'SLIM_HISTORY');
			
			ds_logical := ds_from + ds_process + ds_asheader + ds_temp_header + ds_base + ds_to_batch + ds_to_batch_metrics + ds_slim_history;
			ds_super	 := ds_from_super + ds_process_super + ds_asheader_super + ds_temp_super + ds_base_super + ds_to_batch_super + ds_metrics_super + ds_slim_super;
			
			//check for deletes needed - logicals
			delete_overdue	 	:= ds_logical(days_till_delete < 0);
			delete_today 			:= ds_logical(days_till_delete = 0);
			deleting					:= delete_overdue + delete_today;
			delete_soon				:= ds_logical(days_till_delete <= grace_period_days);
			
			//check for supers to be deleted - if they are empty, not based on age
			deleting_supers		:= ds_super(rowcount = 0);

			remove_supers1 		:= nothor(apply(global(deleting(sf_owner1 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner1,execute_deletes)));
			remove_supers2 		:= nothor(apply(global(deleting(sf_owner2 <> ''),few), tools.mod_Utilities.removesuper	(sf_owner2,execute_deletes)));
			delete_logical 		:= nothor(apply(global(deleting,few), tools.mod_Utilities.deletelogical	(name)));
			delete_supers			:= nothor(apply(global(deleting_supers,few), tools.mod_Utilities.removesuper (name, false)));
			
			delete_action := ordered(
					remove_supers1, 
					remove_supers2,
					delete_logical,
					delete_supers);

			//potential issues
			gcids_versions_conflicted := ds_logical(gcid_version_has_nosave and not name_says_nosave);
			gcids_conflicted 					:= ds_logical(gcid_has_nosave and not gcid_version_has_nosave);

			//send an email
			email_Subject := 'CRK NoSave File Deletion Report';
			email_body := 
						'\n'
						+'Deletes Executed: ' 									+ if(execute_deletes, 'YES', 'NO(execute_deletes is set to false) ') + '\n'
						+'\n'
						+'Deleting Now: ' 													+ count(deleting) + '\n'
						+'    Deletes Overdue: ' 						+ count(delete_overdue) + '\n'
						+'    Deletes Due Today: ' 				+ count(delete_today) + '\n'
						+'Deletes Soon: ' 													+ count(delete_soon) + '\n'
						+'\n'
						+'GCID version conflicts: ' 			+ if(exists(gcids_versions_conflicted), 'YES, ENTIRE GCID VERSION DELETED!!', 'NO') + '\n'
						+'GCID conflicts: ' 											+ if(exists(gcids_conflicted), 'YES, ONLY NOSAVE VERSIONS DELETED!!', 'NO') + '\n'
						+'\n'
						+'Details: ' + URL_details;

		return 
		parallel(
				// output(email_body, named('email_body'))
				output(ds_logical, named('logical_files_before_delete'))
				,output(ds_super, named('super_files_before_delete'))
				,output(deleting, named('logical_files_for_delete'))
				,output(deleting_supers, named('super_files_for_delete'))
				,output(execute_deletes, named('executing_deletes'))
				,output(dedup(table(ds_logical(gcid in set(gcids_versions_conflicted, gcid) and version in set(gcids_versions_conflicted, version)), {gcid, version, gcid_version_has_nosave, name_says_nosave}), all), named('gcid_versions_conflicted'))
				// ,output(dedup(table(ds(gcid in set(gcids_conflicted, gcid)), {gcid, version, gcid_version_has_nosave, gcid_has_nosave}), all), named('gcids_conflicted_from_batch'))
				,if(write_log, output(deleting + deleting_supers,,'~log::CRK::NoSaveReport' + workunit))		 
				,if(execute_deletes, delete_action)
		 // ,if(send_Email, fileservices.sendemail(email_to, email_Subject, email_body, std.system.smtpserver,std.system.smtpport,std.system.emailAddress))
			); 

	END; 
		
END;	
