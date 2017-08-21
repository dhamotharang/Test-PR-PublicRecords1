IMPORT AccountMonitoring,doxie_files,ut,NID;

EXPORT DATASET(layouts.history) fn_cgm_criminal(
			DATASET(layouts.portfolio.base) in_portfolio,
			DATASET(layouts.documents.criminal.base) in_documents = DATASET([],layouts.documents.criminal.base),
			AccountMonitoring.i_Job_Config job_config
		) := 
	FUNCTION
      
		// Get key files
		search_file         := AccountMonitoring.product_files.criminal.offenders_file_slim;
		offender_file       := AccountMonitoring.product_files.criminal.offenders_file_slim;
		offenses_file       := AccountMonitoring.product_files.criminal.offenses_file_slim;
		punishments_file    := AccountMonitoring.product_files.criminal.punishments_file_slim;
		
		// Local functions
		redacted_ssns_are_the_same(STRING pf_ssn_untrimmed, STRING bk_ssn_untrimmed) := 
			FUNCTION
				pf_ssn := TRIM(pf_ssn_untrimmed,LEFT,RIGHT);
				bk_ssn := TRIM(bk_ssn_untrimmed,LEFT,RIGHT);
				
				is_redacted := LENGTH(bk_ssn) = 4 OR
											(LENGTH(bk_ssn) = 8 AND bk_ssn[1..4] = '0000') OR
											(LENGTH(bk_ssn) = 9 AND bk_ssn[1..5] = '00000');
											
				the_same := pf_ssn[ (LENGTH(pf_ssn) - 3)..LENGTH(pf_ssn) ] = bk_ssn[ (LENGTH(bk_ssn) - 3)..LENGTH(bk_ssn) ];
				
				RETURN is_redacted AND the_same;
			END;
	
		// Temporary Join Layout
		temp_layout := record
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			in_documents.offender_key;
			typeof(in_portfolio.did) save_did;
			typeof(in_portfolio.bdid) save_bdid;
		end;
		
		// Pivot on SSN
		temp_port_dist_1 := distribute(in_portfolio(ssn != ''),hash64(ssn));
		temp_base_dist_1 := distribute(search_file(ssn_appended != ''),hash64(ssn_appended));
		temp_join_1 := join(temp_port_dist_1,temp_base_dist_1,
			left.ssn = right.ssn_appended,
			transform(temp_layout,
				self.pid := left.pid,
				self.rid := left.rid,
				self.hid := 0,
				self.save_did := left.did,
				self.save_bdid := left.bdid,
				self := right),
			local);

		
		// Pivot on Last Name and Preferred First
		temp_port_dist_2 := distribute(in_portfolio(name_last != ''),hash64(name_last,NID.PreferredFirstNew(name_first)));
		temp_base_dist_2 := distribute(search_file(lname != ''),hash64(lname,NID.PreferredFirstNew(fname)));
		
		// Plus SSN
		temp_join_2a := join(temp_port_dist_2(ssn != ''),temp_base_dist_2(ssn_appended != ''),
			left.name_last = right.lname and
			NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname) and
			(
				(right.ssn_appended != '' and ut.WithinEditN(left.ssn,right.ssn_appended,1)) or
				(right.ssn_appended != '' and redacted_ssns_are_the_same(left.ssn,right.ssn_appended))  
			),
			transform(temp_layout,
				self.pid := left.pid,
				self.rid := left.rid,
				self.hid := 0,
				self.save_did := left.did,
				self.save_bdid := left.bdid,
				self := right),
			local);

		// Plus DOB
		temp_join_2b := join(temp_port_dist_2(dob != ''),temp_base_dist_2(dob != ''),
			left.name_last = right.lname and
			NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname) and
			right.ssn_appended != '' and left.dob = right.dob,
			transform(temp_layout,
				self.pid := left.pid,
				self.rid := left.rid,
				self.hid := 0,
				self.save_did := left.did,
				self.save_bdid := left.bdid,
				self := right),
			local);

		// Pivot on DID
		temp_port_dist_3 := distribute(in_portfolio((unsigned)did != 0),hash64((unsigned)did));
		temp_base_dist_3 := distribute(search_file((unsigned)did != 0),hash64((unsigned)did));
		temp_join_3 := join(temp_port_dist_3,temp_base_dist_3,
			(unsigned)left.did = (unsigned)right.did,
			transform(temp_layout,
				self.pid := left.pid,
				self.rid := left.rid,
				self.hid := 0,
				self.save_did := left.did,
				self.save_bdid := left.bdid,
				self := right),
			local);

		// Add monitorable Documents
		temp_project_documents := project(in_documents,transform(temp_layout,
			self.save_did := 0,
			self.save_bdid := 0,
			self := left));
		
		// Combine the possibilities from the various pivots
		temp_all_joins :=
			temp_join_1 +
			temp_join_2a +
			temp_join_2b +
			temp_join_3 +
			temp_project_documents;
		
		// Dedup by offender_key so not to double-count
		temp_joins_deduped := 
			dedup(
				sort(
					distribute(
						temp_all_joins,
						hash64(pid,rid,hid)
					),
					pid,rid,hid,offender_key,local
				),
				pid,rid,hid,offender_key,local
			);
			
		temp_joins_dist := distribute(temp_joins_deduped,hash64(offender_key));
		
		// Data layout
		temp_data_layout := record
			temp_layout;
			offender_file.lname;
			offender_file.fname;
			offender_file.mname;
			offender_file.name_suffix;
			offenses_file.off_date;
			offenses_file.case_num;
			offenses_file.inc_adm_dt;
			punishments_file.event_dt;
			punishments_file.sent_date;
			punishments_file.sent_length;
			punishments_file.cur_stat_inm_desc;
			punishments_file.sch_rel_dt;
			punishments_file.act_rel_dt;
			punishments_file.pro_status;
			punishments_file.pro_st_dt;
			punishments_file.pro_end_dt;
		end;	

		// Go get the data to check out
		temp_get_offenders := 
			join(
				temp_joins_dist,
				distributed(offender_file,hash64(offender_key)),
				left.offender_key = right.offender_key,
				transform(temp_data_layout,
					self.pid          := left.pid,
					self.rid          := left.rid,
					self.hid          := left.hid,
					self.save_did     := left.save_did,
					self.save_bdid    := left.save_bdid,
					self.offender_key := left.offender_key,
					self.lname        := right.lname;
					self.fname        := right.fname;
					self.mname        := right.mname;
					self.name_suffix  := right.name_suffix;				
					self := []),
				left outer,
				local);
			
		temp_get_offenses := 
			join(
				temp_get_offenders,
				distributed(offenses_file,hash64(offender_key)),
				left.offender_key = right.offender_key,
				transform(temp_data_layout,
					self.off_date   := right.off_date;
					self.case_num   := right.case_num;
					self.inc_adm_dt := right.inc_adm_dt;				
					self := left),
				left outer,
				local);
				
		temp_get_punishments := 
			join(
				temp_get_offenses,
				distributed(punishments_file,hash64(offender_key)),
				left.offender_key = right.offender_key,
				transform(temp_data_layout,
					self.event_dt     := right.event_dt;
					self.sent_date    := right.sent_date;
					self.sent_length  := right.sent_length;
					self.cur_stat_inm_desc := right.cur_stat_inm_desc;
					self.sch_rel_dt   := right.sch_rel_dt;
					self.act_rel_dt   := right.act_rel_dt;
					self.pro_status 	:= right.pro_status;
					self.pro_st_dt  	:= right.pro_st_dt;
					self.pro_end_dt 	:= right.pro_end_dt;
					self := left),
				left outer,
				local);
				
		// Now, create a hash value from only those fields we're interested in (these 
		// are the ones in the temporary layout).
		temp_unrolled_hashes := 
			project(temp_get_punishments,
				transform(layouts.history,
					self.pid := left.pid,
					self.rid := left.rid,
					self.hid := left.hid,
					self.did := left.save_did,
					self.bdid := left.save_bdid,
					self.timestamp := '',
					self.product_mask := AccountMonitoring.Constants.pm_criminal,
					self.hash_value := 
						hash64(
							left.lname,        // NAME
							left.fname,        // NAME
							left.mname,        // NAME
							left.name_suffix,  // NAME
							left.off_date,     // EVENTS
							left.case_num,     // DOCKET NUMBER
							left.inc_adm_dt,   // NEW INCARCERATIONS
							left.event_dt,     // EVENTS
							left.sent_date,    // NEW INCARCERATIONS
							left.sent_length,  // NEW INCARCERATIONS
							left.cur_stat_inm_desc, // STATUS; PREVIOUSLY REPORTED AS INCARCERATED, NOW RELEASED
							left.sch_rel_dt,   // CHANGE IN RELEASE DATE
							left.act_rel_dt,    // CHANGE IN RELEASE DATE
							left.pro_status, // STATUS; PREVIOUSLY REPORTED AS INCARCERATED, NOW ON PROBATION
							left.pro_st_dt,   // CHANGE IN PROBATION DATE
							left.pro_end_dt    // CHANGE IN PROBATION DATE
						)
					));
		
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := 
			rollup(
				sort(
					distribute(temp_unrolled_hashes,hash64(pid,rid,hid)),
					pid,rid,hid,record,local
				),
				transform(layouts.history,
					self.hash_value := left.hash_value + right.hash_value,
					self := left
				),
				pid,rid,hid,local
			);
		
		return temp_rolled_hashes;
		
	end;