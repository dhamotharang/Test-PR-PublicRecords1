import marriage_divorce_v2,fcra,suppress, ut, FFD;

export MDRaw := module

	// ------------------------------------------
	// layout abbreviations
	// ------------------------------------------
	shared l_id			:= marriage_divorce_v2_Services.layouts.expanded_id;//layouts.l_id;
	shared l_wide		:= marriage_divorce_v2_Services.layouts.result.wide_tmp;
	

	// ------------------------------------------
	// Key conversions
	// ------------------------------------------

  // On FCRA-side we need to know which ids were fetched for each input DID, so the output contains did+record_id;
  // non-fcra caller may need to dedup by record_id
	export get_id_from_did(dataset (marriage_divorce_v2_Services.layouts.l_did) in_dids,boolean isFCRA = false) := function
		raw := join(dedup(sort(in_dids,did),did),
						marriage_divorce_v2.key_mar_div_did(isFCRA),
		            keyed(left.did = right.did),
								transform(l_id, self.search_did := left.did, self := right),
								limit(ut.limits.MARRIAGEDIVORCE_PER_DID));
		return dedup(sort(raw, search_did, record_id), search_did, record_id);
	end;
	
	export get_id_from_fnum(dataset(marriage_divorce_v2_Services.layouts.l_fnum) in_fnums) := function
		raw := join(dedup(sort(in_fnums,filing_number),filing_number), marriage_divorce_v2_Services.keys.fnum,
		            keyed(left.filing_number = right.filing_number)
									and (left.state_origin='' or left.state_origin = right.state_origin)
									and (left.county='' or left.county = right.county),
								transform(l_id, self := right),
								limit(ut.limits.MARRIAGEDIVORCE_PER_LNUM, skip)); // this limit is quite high
		return dedup(sort(raw,record_id),record_id);
	end;
	
	
	// ------------------------------------------
  // Return M&D data in the wide report format
	// ------------------------------------------
  export wide_view := module
	
	  // ...using seq as the lookup mechanism
		export dataset(l_wide) by_id(
					dataset(l_id) in_ids, 
					integer1 NSS_val=suppress.constants.NonSubjectSuppression.doNothing, 
					boolean isFCRA = false, 
					dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
					dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
					integer8 inFFDOptionsMask = 0
		) := function
		  raw := marriage_divorce_v2_Services.fn_getMD_report(in_ids,NSS_val,isFCRA,flagfile,slim_pc_recs,inFFDOptionsMask);
		  return raw;
		end;
		
	end; // wide_view
	

  // TODO: find out why we don't return all values defined in layouts/marriage_divorce2_1
	export batch_view := MODULE
	
		RS := FFD.Constants.RecordType.RS;
		DR := FFD.Constants.RecordType.DR;
		MD := FFD.Constants.DataGroups.MARRIAGE;
		MD_SEARCH := FFD.Constants.DataGroups.MARRIAGE_SEARCH;
		
		 marriage_divorce_v2_Services.layouts.batch_out_search toBatch(l_wide L) := transform
      self.record_id := (string12)L.record_id;
      
			self.vendor											:= L.vendor;
			self.source_file 								:= L.source_file;
			self.process_date								:= L.process_date;
			self.state_origin								:= L.state_origin;
			// self.source_location_cd				:= 
			self.source_county							:= case(L.filing_type,'3'=>L.marriage_county,'7'=>L.divorce_county,'');
			// self.source_city								:= 
			self.filing_number							:= L.filing_number;
			self.filing_type								:= L.filing_type;
			self.filing_dt									:= L.filing_dt;
      
			self.party1_did                 := L.party1.did;
			self.party1_type								:= L.party1.party_type_name;
			self.party1_orig_name						:= L.party1.name;
			self.party1_orig_name_alias			:= L.party1.alias;
			self.party1_name_fmt 						:= L.party1.nameasis_name_format;
			self.party1_dob									:= L.party1.dob;
			// self.party1_ssn									:= 
			self.party1_age									:= L.party1.age;
			// self.party1_residence_cds				:= 
			self.party1_residence_state			:= L.party1.st;
			self.party1_residence_city			:= L.party1.v_city_name;
			self.party1_orig_zip						:= L.party1.zip;
			self.party1_residence_county		:= L.party1.county_name;
			self.party1_residence_address1	:= L.party1.addr1;
			// self.party1_status_cd						:= 
			// self.party1_status 							:= 
			self.party1_times_married				:= L.party1.times_married;
			// self.party1_race_cd							:= 
			self.party1_race 								:= L.party1.race;
			
			self.party2_did  								:= L.party2.did;  //TODO: exclude?
			self.party2_type								:= L.party2.party_type_name;
			self.party2_orig_name						:= L.party2.name;
			self.party2_orig_name_alias			:= L.party2.alias;
			self.party2_name_fmt 						:= L.party2.nameasis_name_format;
			self.party2_dob									:= L.party2.dob;
			// self.party2_ssn									:= 
			self.party2_age									:= L.party2.age;
			// self.party2_residence_cds				:= 
			self.party2_residence_state			:= L.party2.st;
			self.party2_residence_city			:= L.party2.v_city_name;
			self.party2_orig_zip						:= L.party2.zip;
			self.party2_residence_county		:= L.party2.county_name;
			self.party2_residence_address1	:= L.party2.addr1;
			// self.party2_status_cd						:= 
			// self.party2_status 							:= 
			self.party2_times_married				:= L.party2.times_married;
			// self.party2_race_cd							:= 
			self.party2_race 								:= L.party2.race;
			
			self.number_children						:= L.number_of_children;
			self.marriage_dt								:= L.marriage_dt;
			self.divorce_dt									:= L.divorce_dt;
			self.marriage_months_duration		:= L.marriage_duration;
			// self.divorce_granted_to_cd				:= 
			// self.divorce_granted_to					:= 
			// self.divorce_grounds_cd					:= 
			self.divorce_grounds							:= L.grounds_for_divorce;
			
			self.p1_title										:= L.party1.title;
			self.p1_fname										:= L.party1.fname;
			self.p1_mname										:= L.party1.mname;
			self.p1_lname										:= L.party1.lname;
			self.p1_name_suffix							:= L.party1.name_suffix;
			// self.p1_score_in									:= 
			// self.p1a_title										:= 
			// self.p1a_fname										:= 
			// self.p1a_mname										:= 
			// self.p1a_lname										:= 
			// self.p1a_name_suffix							:= 
			// self.p1a_score_in								:= 
			
			self.p2_title										:= L.party2.title;
			self.p2_fname										:= L.party2.fname;
			self.p2_mname										:= L.party2.mname;
			self.p2_lname										:= L.party2.lname;
			self.p2_name_suffix							:= L.party2.name_suffix;
			// self.p2_score_in									:= 
			// self.p2a_title										:= 
			// self.p2a_fname										:= 
			// self.p2a_mname										:= 
			// self.p2a_lname										:= 
			// self.p2a_name_suffix							:= 
			// self.p2a_score_in								:= 
			
			self.prim_range_1								:= L.party1.prim_range;
			self.predir_1										:= L.party1.predir;
			self.prim_name_1								:= L.party1.prim_name;
			self.addr_suffix_1							:= L.party1.suffix;
			self.postdir_1									:= L.party1.postdir;
			self.unit_desig_1								:= L.party1.unit_desig;
			self.sec_range_1								:= L.party1.sec_range;
			self.p_city_name_1							:= L.party1.p_city_name;
			self.v_city_name_1							:= L.party1.v_city_name;
			self.st_1												:= L.party1.st;
			self.zip_1											:= L.party1.zip;
			self.zip4_1											:= L.party1.zip4;
			
			self.prim_range_2								:= L.party2.prim_range;
			self.predir_2										:= L.party2.predir;
			self.prim_name_2								:= L.party2.prim_name;
			self.addr_suffix_2							:= L.party2.suffix;
			self.postdir_2									:= L.party2.postdir;
			self.unit_desig_2								:= L.party2.unit_desig;
			self.sec_range_2								:= L.party2.sec_range;
			self.p_city_name_2							:= L.party2.p_city_name;
			self.v_city_name_2							:= L.party2.v_city_name;
			self.st_2												:= L.party2.st;
			self.zip_2											:= L.party2.zip;
			self.zip4_2											:= L.party2.zip4;
			self.search_did := L.search_did; // save DID this record was obtained by, if needed by a caller
			
			//FFD 
			party1_Statements := PROJECT (L.party1.StatementIds,FFD.InitializeConsumerStatementBatch(left, RS, 'party1',MD_SEARCH,0,'',L.search_did));
			party2_Statements := PROJECT (L.party2.StatementIds,FFD.InitializeConsumerStatementBatch(left, RS, 'party2',MD_SEARCH,0,'',L.search_did));
			main_Statements 	:= PROJECT (L.StatementIds,FFD.InitializeConsumerStatementBatch(left, RS, 'main',MD,0,'',L.search_did));
			
			party1_Dispute  := if(L.party1.isDisputed,
													row(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid,DR,'party1',MD_SEARCH,0,'',L.search_did)));
			party2_Dispute  := if(L.party2.isDisputed,
													row(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid,DR,'party2',MD_SEARCH,0,'',L.search_did)));
			main_Dispute   	:= if(L.isDisputed,
													row(FFD.InitializeConsumerStatementBatch(FFD.Constants.BlankStatementid,DR,'main',MD,0,'',L.search_did)));
			self.Statements := 	party1_Statements + party2_Statements + main_Statements + 
													party1_Dispute			+ party2_Dispute      +	main_Dispute;					
			self := [];
		end;	 

	  // ...using seq as the lookup mechanism
		export dataset(marriage_divorce_v2_Services.layouts.batch_out_search) by_id(
			dataset(l_id) in_ids,
			integer1 NSS_val=suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
			dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0
			) := function
		  recs				:= wide_view.by_id(in_ids,nss_val,isFCRA,flagfile,slim_pc_recs,inFFDOptionsMask);
		  moxie_recs	:= project(recs, tobatch(left));
			sort_recs		:= sort(moxie_recs, -marriage_dt, record);
		  results			:= dedup(sort_recs, record);
		  return results;
		end;
	
	END;

end;