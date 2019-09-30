IMPORT AutoStandardI, Business_Header, Census_data, DCA, doxie, doxie_cbrs, ut, Suppress, STD;

EXPORT CompaniesForPerson_BatchService_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION 

  // *** Temporary/internal constants and record layouts
	integer RETR_PARENT := 1; // For retrieving parent records in doxie_cbrs.get_DCA_Records
	
  rec_temp_fp := RECORD
    unsigned6 did;
		unsigned8 fp;
  END;

  rec_final_output := BatchServices.layout_CompaniesForPerson_batch_out;

  rec_temp_dca := RECORD
    string2  Level;
    string9  Root;
    string4  Sub;
    string15 Parent_Number;
	  rec_final_output;
	END;
	
  // Common routine used to get the name of a county
  get_county_name(string2 st_in, string3 county_in) := 
	          Census_data.Key_Fips2County(keyed(st_in = state_code AND
                                              county_in = county_fips))[1].county_name;

  // ***************************************************************************
  // *** Main processing

	unsigned4 max_results_per_acct := 100   : STORED('max_results_per_acct');
	unsigned4 max_results          := 10000 : STORED('MaxResults');
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	
	// 1a. Grab the input XML and throw into a dataset.	
	ds_batch_in_raw := IF(NOT useCannedRecs, 
	                      BatchServices.file_inBatchMaster(), 
	                      BatchServices._Sample_inBatchMaster('COMPSFORPER'));
 
  // 1b. Do project with  transform to convert any lower case input to upper case.
  ds_batch_in := project(ds_batch_in_raw,BatchServices.transforms.xfm_capitalize_input(LEFT));

  // 2. Get the DID (just one) for each input record.  
	ds_acctnos_and_dids := BatchServices.Functions.fn_find_dids_and_append_to_acctno(
                                 ds_batch_in, BatchServices.Constants.CFP_DID_LIMIT);

  // 3. Sort/dedup on did in case same person input more than once.
  ds_dids_deduped := dedup(sort(ds_acctnos_and_dids,did),did);

	// 4. Join deduped dids to Business Contact did key file to get the 
	//    fp (file position) values for each did.
  ds_fps_for_dids := JOIN(ds_dids_deduped, 
													Business_Header.Key_Business_Contacts_DID,
		                        keyed(LEFT.did = RIGHT.did),
													TRANSFORM(rec_temp_fp,
														SELF             := RIGHT),
													LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT));


	// 5. Sort/dedup by fp.
  ds_fps_deduped := dedup(sort(ds_fps_for_dids,fp),fp);
	
  // 6. Join the deduped fp recs to the Business_Contacts key "fp" file matching on fp,
	//    to get the majority of the company/person info to be output and 
	//    transforming into the final output layout.
  
  rec_f_suppress := record
    rec_final_output;
    unsigned4 	global_sid := 0;
    unsigned8 	record_sid := 0;
  end;
  
  ds_bcinfo_for_fps_pre := JOIN(ds_fps_deduped, 
													  Business_Header.Key_Business_Contacts_FP,
		                          keyed(LEFT.fp = RIGHT.fp) and
															right.from_hdr = 'N', // We don't want 'Y' which means the BC recs were created from matching person & bus hdrs
													  TRANSFORM(rec_f_suppress,
															// For phones, fein & ssn, convert integer value to string
															SELF.company_phone := IF(RIGHT.company_phone<>0,(string) RIGHT.company_phone,'');
															SELF.company_fein  := IF(RIGHT.company_fein<>0,(string) RIGHT.company_fein,'');
															SELF.phone         := IF(RIGHT.phone<>0,(string) RIGHT.phone,'');
															SELF.ssn           := IF(RIGHT.ssn<>0,(string) RIGHT.ssn,'');
															// Convert 3 digit county fips code to a name
															SELF.county        := if(RIGHT.state<>'' and RIGHT.county<>'',
			                                                 get_county_name(RIGHT.state,RIGHT.county),
																											 '');
															SELF := RIGHT),
													  LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT));

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  ds_bcinfo_for_fps := Suppress.MAC_SuppressSource(ds_bcinfo_for_fps_pre, mod_access);

  // 7. Join recs with bus contact info back to the acctno/did file (out of step 2) 
	//    matching on the did to attach acctnos back to the temp recs only for those 
	//    acctnos/dids where  recs exist on the Business_Contacts did/fp key files.
  ds_bcinfo_with_acctno := JOIN(ds_acctnos_and_dids, 
													      ds_bcinfo_for_fps,
		                              LEFT.did = RIGHT.did,
													      TRANSFORM(rec_final_output,
                                  SELF.acctno         := LEFT.acctno,
														      SELF        := RIGHT), 
																INNER,
													      LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT));

	// 8. Join bcinfo with acctnos recs from step 7 above back to the input file 
	//    (out of step 1b) matching on acctno, to attach input fields to the temp 
	//    recs only for those acctnos/dids where recs exist on the 
	//    Business_Contacts did/fp key files.
	ds_bcinfo_with_input := JOIN(ds_batch_in, ds_bcinfo_with_acctno,
		                             LEFT.acctno = RIGHT.acctno,
															 TRANSFORM(rec_final_output,
																	// Copy input fields to output layout
																	// input see doxie.layout_inBatchMaster
																	SELF.in_name_first  := LEFT.name_first;
                                  SELF.in_name_middle := LEFT.name_middle;
                                  SELF.in_name_last   := LEFT.name_last;
                                  SELF.in_name_suffix := LEFT.name_suffix;
                                  SELF.in_prim_range  := LEFT.prim_range;
                                  SELF.in_predir      := LEFT.predir;
                                  SELF.in_prim_name   := LEFT.prim_name;
                                  SELF.in_addr_suffix := LEFT.addr_suffix;
                                  SELF.in_postdir     := LEFT.postdir;
                                  SELF.in_unit_desig  := LEFT.unit_desig;
                                  SELF.in_sec_range   := LEFT.sec_range;
                                  SELF.in_city_name   := LEFT.p_city_name;
                                  SELF.in_st          := LEFT.st;
                                  SELF.in_z5          := LEFT.z5;
                                  SELF.in_zip4        := LEFT.zip4;
                                  SELF.in_ssn         := LEFT.ssn;
                                  SELF.in_dob         := LEFT.dob;
																  SELF                := RIGHT), // rest of fields from right
															 INNER,
														   LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT));

  // 9. Sort/dedup on bdid. 
  ds_bdids_deduped := dedup(sort(ds_bcinfo_with_input,bdid),bdid);

  // 10. Get parent company information.
  // NOTE: In DCA, the root-sub expression is a compound value: 
	// the root (nine digits), followed by a dash, followed by the sub(sidiary) value
	// (four digits). e.g. 123456789-1234. 
	// The root denotes the top-level company at the head of a conglomerate or set of 
	// subsidiaries. e.g. lexisnexis RiskSolution's root is Reed-Elsevier. 
	// The sub is simply a surrogate identifier denoting a particular subsidiary in the 
	// root's tree. 
	// Therefore in the code below you'll see the expression:
  //     LEFT.parent_number[1..9]  = RIGHT.root AND
  //     LEFT.parent_number[11..14] = RIGHT.sub
  // Where [1..9] refers to the root portion of the parent_number and [11..14] refers 
	// to the sub portion of the parent_number. We omit [10] of course, which is a dash.

  // 10a. First for the deduped bdids, get the level, root, sub & parent_number info
	// from the DCA bdid key file.
	ds_bdids_dca_added := JOIN(ds_bdids_deduped,DCA.Key_DCA_BDID,
			                         keyed(LEFT.bdid = RIGHT.bdid),
			                       TRANSFORM(rec_temp_dca,
				                       SELF.level         := RIGHT.level,
												       SELF.root          := RIGHT.root,
												       SELF.sub           := RIGHT.sub,
												       SELF.parent_number := RIGHT.parent_number,
				                       SELF := LEFT),
			                       KEEP(1), LIMIT (ut.limits.MAX_DCA_PER_BDID), LEFT OUTER);

  // 10b. Next get parent company info for each bdid with a non-blank DCA root value.
  ds_parents := doxie_cbrs.get_DCA_records(project(ds_bdids_dca_added(root != ''),doxie_cbrs.layout_references), RETR_PARENT);

  // 10c. Next attach the parent company info to the bdids with DCA data.
	ds_bdids_with_parent := JOIN(ds_bdids_dca_added, ds_parents,
		                             LEFT.parent_number[1..9]  = RIGHT.root AND
																 // NOTE: position 10 = '-'; so it is skipped
		                             LEFT.parent_number[11..14] = RIGHT.sub,
															 TRANSFORM(rec_final_output,
															   // Get parent company fields from right file
		                             SELF.parent_company_name := STD.Str.ToUpperCase(RIGHT.Name),
			                           SELF.parent_street       := STD.Str.ToUpperCase(RIGHT.Street),
			                           SELF.parent_city         := STD.Str.ToUpperCase(RIGHT.City),
			                           SELF.parent_state        := STD.Str.ToUpperCase(RIGHT.State),
			                           SELF.parent_zip          := RIGHT.Zip,
			                           SELF.parent_phone        := RIGHT.Phone,
																 // Keep rest of data from left file
			                           SELF                     := LEFT),
															 LEFT OUTER, LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT,SKIP));

  // 11. Join the file out of step 8 with the file containing parent co info 
	// out of step 10c matching on bdid. 
	ds_recs_all_info := JOIN(ds_bcinfo_with_input, 
													 ds_bdids_with_parent,
		                         LEFT.bdid = RIGHT.bdid,
													 TRANSFORM(rec_final_output,
													   // Copy parent comp info from bdids_with_parent ds
														 SELF.parent_company_name := RIGHT.parent_company_name;
                             SELF.parent_street       := RIGHT.parent_street;
                             SELF.parent_city         := RIGHT.parent_city;
                             SELF.parent_state        := RIGHT.parent_state;
                             SELF.parent_zip          := RIGHT.parent_zip;
                             SELF.parent_phone        := RIGHT.parent_phone;
														 // keep rest of info from bcinfo with input fields ds
														 SELF                     := LEFT),
													 LEFT OUTER,
													 LIMIT(BatchServices.Constants.CFP_JOIN_LIMIT));

	// 12. DID & SSN pulling
	Suppress.MAC_Suppress(ds_recs_all_info,ds_recs_dids_pulled,appType,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(ds_recs_dids_pulled,ds_recs_ssns_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn);
	doxie.MAC_PruneOldSSNs(ds_recs_ssns_pulled, ds_recs_all_pulled, ssn, did);

  // 13. Sort/roll recs with same: acctno, company_name, company address parts, 
	// person address parts, descending company_title (will put ones that are 
	// non-blank before the ones with a blank comp title) and descending dt_last_seen
	// into 1 record.
	ds_recs_all_sorted := sort(ds_recs_all_pulled,acctno, company_name, 
	                                              company_zip, company_state, 
																							  company_prim_name, company_prim_range, 
																							  company_addr_suffix, company_predir,
																							  company_postdir, company_sec_range,
	                                              zip, state, prim_name, prim_range,
                                                addr_suffix, predir, postdir, sec_range,
																							  -company_title, -dt_last_seen);

	rec_final_output rollup_xform(rec_final_output le, rec_final_output ri) := transform
    // For most fields below, take left if it is not blank/null, otherwise take right;
		// unless otherwise noted.
    self.company_name        := if(le.company_name <> '', le.company_name, ri.company_name);
    self.company_prim_range  := if(le.company_prim_range <> '', le.company_prim_range, ri.company_prim_range);
    self.company_predir      := if(le.company_predir <> '', le.company_predir, ri.company_predir);
    self.company_prim_name   := if(le.company_prim_name <> '', le.company_prim_name, ri.company_prim_name);
    self.company_addr_suffix := if(le.company_addr_suffix <> '', le.company_addr_suffix, ri.company_addr_suffix);
    self.company_postdir     := if(le.company_postdir <> '', le.company_postdir, ri.company_postdir);
    self.company_unit_desig  := if(le.company_unit_desig <> '', le.company_unit_desig, ri.company_unit_desig);
    self.company_sec_range   := if(le.company_sec_range <> '', le.company_sec_range, ri.company_sec_range);
    self.company_city        := if(le.company_city <> '', le.company_city, ri.company_city);
    self.company_state       := if(le.company_state <> '', le.company_state, ri.company_state);
    self.company_zip         := if(le.company_zip  <> 0, le.company_zip, ri.company_zip);
    self.company_zip4        := if(le.company_zip4 <> 0, le.company_zip4, ri.company_zip4);
    self.company_phone       := if(le.company_phone <> '', le.company_phone, ri.company_phone);
    self.company_fein        := if(le.company_fein <> '', le.company_fein, ri.company_fein);
    self.parent_company_name := if(le.parent_company_name <> '', le.parent_company_name, ri.parent_company_name);
    self.parent_street       := if(le.parent_street <> '', le.parent_street, ri.parent_street);
    self.parent_city         := if(le.parent_city <> '', le.parent_city, ri.parent_city);
    self.parent_state        := if(le.parent_state <> '', le.parent_state, ri.parent_state);
    self.parent_zip          := if(le.parent_zip <> '', le.parent_zip, ri.parent_zip);
    self.parent_phone        := if(le.parent_phone <> '', le.parent_phone, ri.parent_phone);

    self.bdid          := if(le.bdid <>0, le.bdid, ri.bdid);
    self.did           := if(le.did <>0, le.did, ri.did);
		// Keep the lowest non-zero dt_first_seen of all recs being rolled together.
		self.dt_first_seen := MAP(ri.dt_first_seen = 0  => le.dt_first_seen,
            			            le.dt_first_seen = 0  => ri.dt_first_seen, 
                              if(le.dt_first_seen < ri.dt_first_seen, 
					                       le.dt_first_seen, ri.dt_first_seen));
	  // Keep the highest non-zero dt_first_seen of all recs being rolled together.
    self.dt_last_seen  := if(le.dt_last_seen > ri.dt_last_seen,
													   le.dt_last_seen,ri.dt_last_seen);
 		self.company_title := if(le.company_title <>'',le.company_title, ri.company_title);
		self.company_department := if(le.company_department <>'',le.company_department,ri.company_department);
		self.title         := if(le.title <>'',le.title,ri.title);
		self.fname         := if(le.fname <>'',le.fname,ri.fname);
		// any non-blank mname with more than just an initial is preferred
		self.mname         := if(ri.mname ='',le.mname,   //if right blank, take left
			                       if(le.mname='',ri.mname, //if left blank, take right
											       //else if both not blank, take left if length > 1
											          if(length(trim(STD.Str.ToUpperCase(le.mname),left,right))>1,
												           le.mname,ri.mname)));
		self.lname         := if(le.lname <>'',le.lname,ri.lname);
		self.name_suffix   := if(le.name_suffix <>'',le.name_suffix,ri.name_suffix);
    self.prim_range    := if(le.prim_range <>'',le.prim_range, ri.prim_range);
    self.predir        := if(le.predir <>'',le.predir, ri.predir);
    self.prim_name     := if(le.prim_name <>'',le.prim_name, ri.prim_name);
    self.addr_suffix   := if(le.addr_suffix <>'',le.addr_suffix, ri.addr_suffix);
    self.postdir       := if(le.postdir <>'',le.postdir, ri.postdir);
    self.unit_desig    := if(le.unit_desig <>'',le.unit_desig, ri.unit_desig);
    self.sec_range     := if(le.sec_range <>'',le.sec_range, ri.sec_range);
    self.city          := if(le.city <>'',le.city, ri.city);
    self.state         := if(le.state <>'',le.state, ri.state);
    self.zip           := if(le.zip <>0, le.zip, ri.zip);
    self.zip4          := if(le.zip4 <>0, le.zip4, ri.zip4);
    self.county        := if(le.county <>'', le.county, ri.county);
    self.phone         := if(le.phone <>'', le.phone, ri.phone);
    self.email_address := if(le.email_address <>'',le.email_address, ri.email_address);
    self.ssn           := if(le.ssn <>'', le.ssn, ri.ssn);
	  // For all other fields (the input fields), use left.
		self := le;
	end;
	
	// Roll by the fields below:
	ds_recs_all_rolled := rollup(ds_recs_all_sorted, rollup_xform(LEFT,RIGHT),
												       (LEFT.acctno = RIGHT.acctno),
													     (LEFT.company_name = RIGHT.company_name),
															 // company address parts
			              		       ut.nneq_int((string)LEFT.company_zip, (string)RIGHT.company_zip),
															 ut.nneq(LEFT.company_state, RIGHT.company_state),
					                     // don't use city name due to potential inconsistent values
															 // i.e. North Yarmouth vs N Yarmouth
					                     ut.nneq(LEFT.company_prim_name, RIGHT.company_prim_name), 
															 ut.nneq(LEFT.company_prim_range, RIGHT.company_prim_range),
					                     ut.nneq(LEFT.company_addr_suffix, RIGHT.company_addr_suffix),
					                     ut.nneq(LEFT.company_predir, RIGHT.company_predir),
					                     ut.nneq(LEFT.company_postdir, RIGHT.company_postdir),
					                     ut.nneq(LEFT.company_sec_range, RIGHT.company_sec_range),
															 // person address parts
			              		       ut.nneq_int((string)LEFT.zip, (string)RIGHT.zip),
															 ut.nneq(LEFT.state, RIGHT.state),
					                     // don't use city name due to inconsistent values
					                     ut.nneq(LEFT.prim_name, RIGHT.prim_name), 
															 ut.nneq(LEFT.prim_range, RIGHT.prim_range),
					                     ut.nneq(LEFT.addr_suffix, RIGHT.addr_suffix),
					                     ut.nneq(LEFT.predir, RIGHT.predir),
					                     ut.nneq(LEFT.postdir, RIGHT.postdir),
					                     ut.nneq(LEFT.sec_range, RIGHT.sec_range),
															 // Roll blank comp title with non-blank comp title
															 ut.nneq(LEFT.company_title, RIGHT.company_title)
													     );

  // Sort recs by acctno & descending dt_last_seen, then group by acctno.
	ds_recs_grouped := group(sort(ds_recs_all_rolled, acctno, -dt_last_seen, record), acctno);
  // Only take the first (top) n recs (max_results_per_acct) for each acctno.
  ds_recs_grouped_topn := topn(ds_recs_grouped, max_results_per_acct, acctno);
  // Ungroup the recs.
	ds_recs_ungrouped := ungroup(ds_recs_grouped_topn);

  // 14. Sort final results by: acctno, dt_last_seen(descending), company name, 
	//     person's title/role
  ds_final_results := topn(ds_recs_all_rolled, max_results, acctno, -dt_last_seen, 
	                                                          company_name, company_title);

  // Uncomment lines below as needed for debugging
	//OUTPUT(ds_batch_in_raw,       NAMED('ds_batch_in_raw'));
	//OUTPUT(ds_batch_in,           NAMED('ds_batch_in'));
	//OUTPUT(ds_acctnos_and_dids,   NAMED('ds_acctnos_and_dids'));
  //OUTPUT(ds_dids_deduped,       NAMED('ds_dids_deduped'));
  //OUTPUT(ds_fps_for_dids,       NAMED('ds_fps_for_dids'));
  //OUTPUT(ds_fps_deduped,        NAMED('ds_fps_deduped'));
  //OUTPUT(ds_bcinfo_for_fps,     NAMED('ds_bcinfo_for_fps'));
  //OUTPUT(ds_bcinfo_with_acctno, NAMED('ds_bcinfo_with_acctno'));
	//OUTPUT(ds_bcinfo_with_input,  NAMED('ds_bcinfo_with_input'));
  //OUTPUT(ds_bdids_deduped,      NAMED('ds_bdids_deduped'));
	//OUTPUT(ds_bdids_dca_added,    NAMED('ds_bdids_dcs_added'));
	//OUTPUT(ds_parents,            NAMED('ds_parents'));
  //OUTPUT(ds_bdids_with_parent,  NAMED('ds_bdids_with_parent'));
  //OUTPUT(ds_recs_all_info,      NAMED('ds_recs_all_info'));
	//OUTPUT(ds_recs_all_sorted,    NAMED('ds_recs_all_sorted'));
	//OUTPUT(ds_recs_all_rolled,    NAMED('ds_recs_all_rolled'));
	//OUTPUT(ds_recs_grouped,       NAMED('ds_recs_grouped'));
  //OUTPUT(ds_recs_grouped_topn,  NAMED('ds_recs_grouped_topn'));
	//OUTPUT(ds_recs_ungrouped,     NAMED('ds_recs_ungrouped'));
  //OUTPUT(ds_final_results,      NAMED('ds_final_results'));

  RETURN ds_final_results;

END;
