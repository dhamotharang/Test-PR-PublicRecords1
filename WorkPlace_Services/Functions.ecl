import Address,Autokey_batch,BatchServices,doxie,gong,mdr,POE,PSS,risk_indicators,ut,Yellowpages, PAW_Services, paw, spoke, zoom, corp2, POEsFromEmails, one_click_data, SalesChannel, thrive, Email_Data, std, DCA, doxie_cbrs, Prof_LicenseV2;

// NOTE: Within this module certain BatchServices.Workplace_* attributes are used.
//       This is because the BatchServices.WorkPlace_BatchService was created first, 
//       then after that the online Search & Report Services were created.
//       Some of the functions below are basically parts of coding from 
//       BatchServices.Workplace_Records that were changed into functions.
//       However due to time constraints and the need to get the search & report services
//       completed by December 2010, BatchServices.Workplace_Records was not modifed
//       to use the functions below; but could be in the future.

export Functions := module

	// This function gets did(s) based upon the input data (in standard batch input format)
	// and checks for more than 1 did per acctno/input, sorts/dedups on did, and finally
	// puts the data into a common POE did key lookup layout.
	export getSubjectDids(dataset(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in) :=
	       function

    // 1. Do a project with transform to convert any lower case input to upper case.
    ds_batch_in_caps := project(ds_batch_in,
		                            BatchServices.transforms.xfm_capitalize_input(left));

    // 2. Get the DID(s) associated with each input record by using an already existing 
		//    common BatchServices function to get the dids for the input data.
	  ds_acctnos_dids_appended := 
		        BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_caps);

    // Make sure each acctno's input criteria only resolved to 1 did.
    // If more than 1 did per acctno, don't return anything for that acctno.
	  //
    // 3. Table/count to count the number of dids for each acctno.
	  //    Only keep the acctno if the resulting did_count is less than or equal
	  //    the did_limit (currently 1); otherwise drop that acctno.
    layout_dids_count := RECORD
		  ds_acctnos_dids_appended.acctno;
      did_count := COUNT(GROUP);
    END;
	
	  ds_acctnos_dids_table := table(ds_acctnos_dids_appended,layout_dids_count,acctno,few);
		
		// Since this is a search service, there will only ever be 1 accno./record in this dataset.
		IF(ds_acctnos_dids_table[1].did_count > BatchServices.WorkPlace_Constants.Limits.DID_LIMIT,
		   FAIL(ut.constants_MessageCodes.SUBJECT_NOT_UNIQUE,
            'Your subject cannot be uniquely identified.  Please include more information ' +
						'such as Name and full address or SSN.  You were not charged for this search.'));
												 
    ds_acctnos_w1did      := ds_acctnos_dids_table(did_count<=
		                                               BatchServices.WorkPlace_Constants.Limits.DID_LIMIT);

    // 4. Join all acctnos with dids appended to those with just 1 did per acctno to 
	  //    remove any acctnos with more than 1 did or with no did.
	  ds_acctnos_dids_good := join(ds_acctnos_w1did,ds_acctnos_dids_appended,
	                                 left.acctno = right.acctno,
													       transform(right),
													       left outer, // keep all the recs from the left ds
													       atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 5. Sort/dedup on did in case same person input more than once and 
	  //    to reduce number of lookups against the POE did key file later.
    //    We will re-attach all acctnos back to the dids later.
    ds_dids_deduped := dedup(sort(ds_acctnos_dids_good,did),did);

	  // 6. Project the resulting deduped subject dids with a transform to put into a 
	  //    common poe did key lookup layout and set the correct spouse_indicator.
	  // NOTE: the spouse_indicator only indicates if the record is a spouse record, 
	  // not if a spouse was found for the subject/did.
    ds_subject_dids := project(ds_dids_deduped, 
	                             transform(BatchServices.WorkPlace_Layouts.POE_lookup,
															   self.acctno           := left.acctno,
															   self.lookupDid        := left.did,
															   self.subjectDid 	     := left.did,
															   self.spouseDid        := 0,
                                 self.spouse_indicator := 'N'));
	
	  // Uncomment lines below as needed for debugging
	  //OUTPUT(ds_batch_in_caps,         NAMED('ds_batch_in_caps'));
		//OUTPUT(ds_acctnos_dids_appended, NAMED('ds_acctnos_dids_appended'));
	
	  return ds_subject_dids;
		
	end; // end of getSubjectDids function


	// This function gets the did for the spouse based upon the input did and 
	// then puts the data into a common POE did key lookup layout.
	export getSpouseDids(dataset(BatchServices.WorkPlace_Layouts.POE_lookup) ds_subject_dids)
	       := function
    // 1. Project the subject acctnos/dids into the needed layout and 
    //    then call a function to attempt to get the spouse did for each subject did.
    ds_dids_spousein := project(ds_subject_dids,
	                              transform(BatchServices.WorkPlace_Layouts.subjectspouse,
															   self.acctno    := left.acctno,
															   self.did       := left.subjectDid,
															   self.spouseDid := 0));

	  ds_spouse_acctnos_dids := BatchServices.WorkPlace_Functions.getSpouseDidBatch(ds_dids_spousein);
  
    // 2. Sort/dedup all the spouse dids by did to reduce number of lookups against 
	  //    the POE did key file later.
    //    We will re-attach all acctnos back to the spouse dids later.
	  ds_spouse_dids_deduped := dedup(sort(ds_spouse_acctnos_dids(spousedid<>0), spousedid), 
	                                  spousedid);

    // 3. Project the resulting deduped spouse dids with a transform to put into a 
	  //    common poe key did lookup layout and set the correct spouse_indicator.
	  // NOTE: the spouse_indicator=Y indicates this record is a spouse record.
	  ds_spouse_dids := project(ds_spouse_dids_deduped, 
	                            transform(BatchServices.WorkPlace_Layouts.POE_lookup,
														    self.acctno           := left.acctno,
															  self.lookupDid        := left.spouseDid,
															  self.subjectDid 	    := left.did,
															  self.spouseDid        := left.spouseDid,
                                self.spouse_indicator := 'Y'));

	  return ds_spouse_dids;

  end; // end getSpouseDids function


  // This function combines subject and optional spouse dids, sorts & dedups them, 
	// then "looks" them up on the POE did key file.
	export getPoeRecs(dataset(BatchServices.WorkPlace_Layouts.POE_lookup) ds_subject_dids):= function
 
    // 1. Combine the subject dids and spouse dids into 1 dataset and then sort and 
	  //     dedup by lookup did in case 1 subject did is another subject's spouse did.
	  ds_dids_sorted := dedup(sort(ds_subject_dids,lookupdid),
	                                   lookupdid);

    // 2. Join the ds of unique combined dids with POE key did file, transforming the
	  //     full did key layout into a slimmmed format of just the fields needed for 
	  //     choosing a candidate record below.
    SSN_WIDTH         := 9;
		LEADING_ZERO_FILL := 1;
	  ds_poe_recs_slimmed := join(ds_dids_sorted,POE.Keys().did.qa,
															    keyed(left.lookupdid = right.did),
	                              transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															    // certain fields need special handling/name changes
																	SELF.source_order				:=	BatchServices.WorkPlace_Constants.DEFAULT_SOURCE_ORDER; // DEFAULT_SOURCE_ORDER= 255
                                  self.spouse_indicator   := left.spouse_indicator,
																  self.subject_first_name := right.subject_name.fname,
																  self.subject_last_name  := right.subject_name.lname,
																	self.name_title         := right.subject_name.title,
																	self.middle_name        := right.subject_name.mname,
																	self.name_suffix        := right.subject_name.name_suffix,
																  self.subject_ssn        := if(right.subject_ssn=0,
																	                              '', // store blank instead of zero
																																// otherwise convert integer ssn to string9 ssn
																																// use intformat in case leading digit of ssn is zero
																	                              intformat(right.subject_ssn,
																																          SSN_WIDTH,
																																					LEADING_ZERO_FILL)),
																	// Store both full and parts of street address 
																	// because both are used in different sections.
		                              self.company_address    := Address.Addr1FromComponents(
														                                 right.company_address.prim_range,
                                                             right.company_address.predir,
                                                             right.company_address.prim_name,
                                                             right.company_address.addr_suffix,
                                                             right.company_address.postdir,
                                                             right.company_address.unit_desig,
                                                             right.company_address.sec_range),
														      self.company_prim_range  := right.company_address.prim_range,
                                  self.company_predir      := right.company_address.predir,
                                  self.company_prim_name   := right.company_address.prim_name,
                                  self.company_addr_suffix := right.company_address.addr_suffix,
                                  self.company_postdir     := right.company_address.postdir,
                                  self.company_unit_desig  := right.company_address.unit_desig,
                                  self.company_sec_range   := right.company_address.sec_range,
														      self.company_city        := right.company_address.city_name,
                                  self.company_state       := right.company_address.st,
                                  self.company_zip         := right.company_address.zip + 
																															if(right.company_address.zip4<>'',
																																 '-' + right.company_address.zip4,''),
                                  self.company_zip5        := right.company_address.zip,
                                  self.company_zip4        := right.company_address.zip4,
																  self.company_phone1    	 := if(right.company_phone=0,
																                                '',(string) right.company_phone);
																  // rest of fields use the poe did key field names from right
                                  self := right,
																	SELF :=[]),
												        inner, // use all recs from right that match left
												        LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    return ds_poe_recs_slimmed;

  end; // end of getPoeRecs function

	// This function combines subject and optional spouse dids, sorts & dedups them, 
	// then "looks" them up on the PSS did key file.
	export	getPSSRecs(	dataset(BatchServices.WorkPlace_Layouts.POE_lookup) ds_subject_dids):=	function
		// 1. Combine the subject dids and spouse dids into 1 dataset and then sort and 
	  //     dedup by lookup did in case 1 subject did is another subject's spouse did.
	  ds_dids_sorted := dedup(sort(ds_subject_dids,lookupdid),lookupdid);
		
		// Get Current Date 
		STRING todays_date := (STRING)STD.Date.Today();
				
		// 2. Join the ds of unique combined dids with PSS Accutrac did file transforming the
		//     full did key layout into a slimmmed format of just the fields needed for 
		//     choosing a candidate record below.
		WorkPlace_Services.Layouts.PSS_DID_Plus	tPSS(ds_dids_sorted	le,PSS.Keys().DID.QA	ri)	:=
		transform
			// Clean company address. PSS data doesn't contain the clean company name
			// and hence,cleaning the company name to populate the necessary clean address fields for company
			vCityStateZip		:=	Address.Addr2FromComponents(ri.company_city,ri.company_state,ri.company_zip);
			modCleanAddress	:=	Address.GetCleanAddress(ri.company_address,vCityStateZip,Address.Components.Country.US).results;
			
			// certain fields need special handling/name changes
			self.acctno								:=	le.acctno;
			self.source								:=	MDR.sourceTools.src_PSS; // Defaulted to src_PSS as PSS data is verified POE data and
																														 // has PSS data has source order "0" which has the precedence over other sources
			SELF.source_order					:=	BatchServices.WorkPlace_Constants.DEFAULT_SOURCE_ORDER; // DEFAULT_SOURCE_ORDER= 255
			self.dt_last_seen					:=	(unsigned4)ri.date_last_seen;
			self.spouse_indicator			:=	le.spouse_indicator;
			self.subject_first_name		:=	ri.subject_first_name;
			self.subject_last_name		:=	ri.subject_last_name;
			self.subject_ssn					:=	if(	(integer)ri.response_ssn	=	0,
																				'', // store blank instead of zero otherwise convert integer ssn to string9 ssn use intformat in case leading digit of ssn is zero
																				ri.response_ssn
																			);
			self.company_phone1				:=	if(			ut.fnTrim2Upper(ri.response_phone_1_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS
																				and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																				ri.company_phone1,
																				''
																			);
			self.company_phone2				:=	if(			ut.fnTrim2Upper(ri.response_phone_2_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS
																				and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																				ri.company_phone2,
																				''
																			);
			// Clean company address fields
			self.company_address  		:=	ri.company_address;
			self.company_prim_range		:=	modCleanAddress.prim_range;
			self.company_predir				:=	modCleanAddress.predir;
			self.company_prim_name		:=	modCleanAddress.prim_name;
			self.company_addr_suffix	:=	modCleanAddress.suffix;
			self.company_postdir			:=	modCleanAddress.postdir;
			self.company_unit_desig		:=	modCleanAddress.unit_desig;
			self.company_sec_range		:=	modCleanAddress.sec_range;
			self.company_zip					:=	modCleanAddress.zip + IF(modCleanAddress.zip4<>'', '-'+modCleanAddress.zip4,'');
			self.company_zip5					:=	modCleanAddress.zip;
			self.company_zip4					:=	modCleanAddress.zip4;
			// rest of fields use the pss did key field names from right
			self											:=	ri;
			SELF											:= [];
		end;
		
		ds_PSS_Results	:=	join(	ds_dids_sorted,
															PSS.Keys().DID.QA,
															keyed(left.lookupdid	=	right.did)	and
															(	(ut.fnTrim2Upper(right.response_phone_1_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)right.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW)	or
																(ut.fnTrim2Upper(right.response_phone_2_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)right.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW)
															),
															tPSS(left,right),
															LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip)
														);
		
		// Dedup on did and keep the most recent record
		ds_PSS_Results_Dedup	:=	dedup(	sort(	ds_PSS_Results,
																						did,subject_first_name,subject_last_name,subject_ssn,-dt_vendor_last_reported
																					),
																			did,subject_first_name,subject_last_name,subject_ssn
																		);
		
		return	project(ds_PSS_Results_Dedup,WorkPlace_Services.Layouts.poe_didkey_plus);
	end;	//	end of getPSSRecs funtion

	EXPORT getPawRecs(DATASET(WorkPlace_Services.Layouts.poe_didkey_plus) ds_poe_recs):= FUNCTION
	      
			dids := PROJECT(ds_poe_recs, TRANSFORM(doxie.layout_references, SELF.did:= LEFT.did));
			contactIDs := PAW_Services.PAW_Raw.getContactIDs.byDIDs(dids);				
			
			WorkPlace_Services.Layouts.poe_didkey_plus	tPAW(contactIDs	le,paw.Key_contactID	ri)	:= TRANSFORM
							
				// certain fields need special handling/name changes
				SELF.source								:=	ri.source;
				SELF.dt_last_seen					:=	(UNSIGNED4)ri.dt_last_seen;
				SELF.dt_first_seen				:=	(UNSIGNED4)ri.dt_first_seen;
				SELF.name_title		        :=	ri.title;	
				SELF.subject_first_name		:=	ri.fname;
				SELF.middle_name					:=	ri.mname;
				SELF.subject_last_name		:=	ri.lname;
				SELF.name_suffix	      	:=	ri.name_suffix;
				SELF.subject_ssn					:=	IF((INTEGER)ri.ssn	=	0,
																					'', // store blank instead of zero otherwise convert integer ssn to string9 ssn use intformat in case leading digit of ssn is zero
																					ri.ssn);
				SELF.company_name					:=	ri.company_name;
				SELF.company_phone1     	:= IF((INTEGER)ri.company_phone	=	0,'',(STRING) ri.company_phone);
				SELF.company_fein     		:= (INTEGER) ri.company_fein;
				self.company_address    	:=	Address.Addr1FromComponents(ri.company_prim_range,
																																	ri.company_predir,
																																	ri.company_prim_name,
																																	ri.company_addr_suffix,
																																	ri.company_postdir,
																																	ri.company_unit_desig,
																																	ri.company_sec_range);
				SELF.company_prim_range		:=	ri.company_prim_range;
				SELF.company_predir				:=	ri.company_predir;
				SELF.company_prim_name		:=	ri.company_prim_name;
				SELF.company_addr_suffix	:=	ri.company_addr_suffix;
				SELF.company_postdir			:=	ri.company_postdir;
				SELF.company_unit_desig		:=	ri.company_unit_desig;
				SELF.company_sec_range		:=	ri.company_sec_range;
				SELF.company_zip					:=	ri.company_zip + 
																		  if(ri.company_zip4<>'',
																				 '-' + ri.company_zip4,''),
				SELF.company_zip5					:=	ri.company_zip;
				SELF.company_zip4					:=	ri.company_zip4;
				// rest of fields use the paw key field names from right
				SELF											:=	ri;
				SELF											:=	[];
			END;	
			
			ds_PAW_Results := JOIN(contactIDs,paw.Key_contactID,
														 KEYED(LEFT.contact_id=RIGHT.contact_id),
														 tPAW(LEFT, RIGHT),
														 LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));
														
			ds_PAW_Results_Dedup	:=	DEDUP(SORT(ds_PAW_Results,
																						did, company_name, -dt_last_seen),
																			 did, company_name);
																				 			
			ds_PAW_recs:= JOIN(ds_poe_recs, ds_PAW_Results_Dedup, 
												 LEFT.did =	RIGHT.did, 
												 TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
																		SELF.acctno								:=	LEFT.acctno,
																		SELF.source_order					:=	BatchServices.WorkPlace_Constants.DEFAULT_SOURCE_ORDER +1, // "DEFAULT_SOURCE_ORDER +1" is to ensure that paw records
																		SELF.spouse_indicator			:=	LEFT.spouse_indicator;
																		SELF.from_PAW							:= 	TRUE, // For differentiation from other Datasets().
																		SELF											:=	RIGHT,
																		SELF											:=	[]),
															 LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,SKIP));
		RETURN ds_PAW_recs;
	END;

	// This function trys to get any missing company name or address info from the 
  // EDA(gong) history key file by doing a 'reverse" lookup using the company_phone1 data.
	export getCompInfoFromGong(
	       dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_all_recs_in) := function

	  // 1. Filter to include only recs that have a phone1, but are missing the comp 
		//    name or some address parts.
		//    Then sort/dedup on non-blank company_phone1 to reduce the number of lookups
	  //    against the gong key history file.
    ds_all_phone1_deduped := dedup(sort(ds_all_recs_in(company_phone1<>'' and
	                                                     (company_name    = '' or
																										    company_address = '' or
																										    company_city    = '' or
																										    company_state   = '' or
																										    company_zip     = '')),
	                                      company_phone1),company_phone1);

    // 2. Join the unique non-blank phone1s with the gong history phone key file, 
	  //    to get the gong company name/address & bdid (if needed).
	  ds_all_phone1_gongcomp := join(ds_all_phone1_deduped, gong.Key_History_phone, 
				                             keyed(left.company_phone1[4..10] = right.p7 and 
					                                 left.company_phone1[1..3]  = right.p3) and 
																           right.current_flag and //we only want current data
							                             right.business_flag,   //we only want businesses
							                     transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																     // comp name/address/bdid from right gong history
                                     self.company_name    := right.listed_name,
																		// store both full and parts of street address,
																	  // both of which are used in different places.
		                                 self.company_address := Address.Addr1FromComponents(
														                                 right.prim_range,
                                                             right.predir,
                                                             right.prim_name,
                                                             right.suffix,
                                                             right.postdir,
                                                             right.unit_desig,
                                                             right.sec_range),
														         self.company_prim_range  := right.prim_range,
                                     self.company_predir      := right.predir,
                                     self.company_prim_name   := right.prim_name,
                                     self.company_addr_suffix := right.suffix,
                                     self.company_postdir     := right.postdir,
                                     self.company_unit_desig  := right.unit_desig,
                                     self.company_sec_range   := right.sec_range,
														         self.company_city        := right.p_city_name,
                                     self.company_state       := right.st,
                                     self.company_zip         :=  right.z5 + 
																																	 if(right.z4<>'',
																																			'-' + right.z4,''),
                                     self.company_zip5         := right.z5, 
                                     self.company_zip4        := right.z4,
                                     self.bdid            := if(left.bdid<>0,
																		                            left.bdid,right.bdid),
																	   self.from_gong       := true,
																	   //rest of fields from left
								                     self                 := left),
																   inner,
					                         keep(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
																   limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 3. Join the phone#s with comp info from gong history back to the input dataset
		//    to supply missing company name/address if needed.
    ds_all_recs_gongcomp := join(ds_all_recs_in, ds_all_phone1_gongcomp,
				                           left.company_phone1 = right.company_phone1,
                                 transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																   // store gong comp name/address/bdid from right
																	 self.company_name    := if(right.from_gong,right.company_name,
																	                                            left.company_name),
																   self.company_address := if(right.from_gong,right.company_address,
																	                                            left.company_address),
														       self.company_prim_range  := if(right.from_gong,right.company_prim_range,
																	                                                left.company_prim_range),
                                   self.company_predir      := if(right.from_gong,right.company_predir,
																	                                                left.company_predir),
                                   self.company_prim_name   := if(right.from_gong,right.company_prim_name,
																	                                                left.company_prim_name),
                                   self.company_addr_suffix := if(right.from_gong,right.company_addr_suffix,
																	                                                left.company_addr_suffix),
                                   self.company_postdir     := if(right.from_gong,right.company_postdir,
																	                                                left.company_postdir),
                                   self.company_unit_desig  := if(right.from_gong,right.company_unit_desig,
																	                                                left.company_unit_desig),
                                   self.company_sec_range   := if(right.from_gong,right.company_sec_range,
																	                                                left.company_sec_range),
																	 self.company_city    := if(right.from_gong,right.company_city,
																	                                            left.company_city),
                                   self.company_state   := if(right.from_gong,right.company_state,
																	                                            left.company_state),
                                   self.company_zip     := if(right.from_gong,right.company_zip, 
																	                                            left.company_zip),
																	 self.company_zip5     := if(right.from_gong,right.company_zip5, 
																	                                            left.company_zip5),
                                   self.company_zip4    := if(right.from_gong,right.company_zip4, 
																	                                            left.company_zip4),
																	 self.bdid            := if(right.from_gong and left.bdid=0,
																	                                            right.bdid,left.bdid),
                                   // rest of the fields, keep the ones from the left ds
                                   self := left),
											           left outer,  // keep all the recs from the left ds
												         atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));
	  
		return ds_all_recs_gongcomp;

  end; // end of getCompInfoFromGong function


	// This function gets the current phone# for the bdid from the EDA/gong history 
	// bdid key file.  Then stores it into company_phone2 if POE company_phone1 exists;   
	// otherwise stores it into company_phone1.
	export getPhoneFromGong(
	       dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_all_recs_in) := function

	  // 1. Sort/dedup on non-zero bdids to reduce the number of lookups against the gong key.
	  ds_all_bdids_deduped := dedup(sort(ds_all_recs_in(bdid<>0), bdid), bdid);

    // 2. Join the ds unique non-zero bdids with the gong history bdid key file 
	  //    to get the phone#.
	  ds_all_bdids_gongphone := join(ds_all_bdids_deduped, gong.Key_History_BDID,
				                             keyed(left.bdid=right.bdid)     and 
																		  //we only want current data
																     right.current_record_flag = BatchServices.WorkPlace_Constants.GONG_HIST_CURRENT and
																		 //we only want businesses
				                             right.listing_type_bus    = BatchServices.WorkPlace_Constants.GONG_HIST_BUSINESS and 
																	   // Also match on city name since some bdids have 
																	   // multiple current phone#s for different locations
																	   left.company_city = right.p_city_name,
																	 transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																	   self.company_phone2 := right.phone10,
																	   self                := left),
											             inner,
															     keep(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
																   limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 3. Join the bdids with a gong phone# back to the ds of poe key did records with 
	  //    gong company info added.
	  ds_all_recs_gongphone := join(ds_all_recs_in, ds_all_bdids_gongphone,
		  		                          left.bdid=right.bdid,
                                  transform(WorkPlace_Services.Layouts.poe_didkey_plus,
				  												  // store right gong phone into phone1 (if empty) or 
																		// in phone2 (if empty and not same as phone1)
									  							  self.company_phone1 := if(left.company_phone1 != '', 
										  							                          left.company_phone1,right.company_phone2),
																    self.company_phone2 := if(left.company_phone2!='', 
																                              left.company_phone2,
																                              if(left.company_phone1 !='' and
																			    										   left.company_phone1 != right.company_phone2,
																				    							       right.company_phone2,'')),
                                    // Rest of the fields, keep the ones from the left ds
                                    self := left),
											            left outer,  // keep all the recs from the left ds
												          atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

		return ds_all_recs_gongphone;

  end; // end of getPhoneFromGong function


	// This function gets the current phone# for the bdid from the Yellow Pages 
	// bdid key file.  Then stores it into company_phone1 if empty; 
	// otherwise stores it into company_phone2.
	export getPhoneFromYP(
	       dataset(WorkPlace_Services.Layouts.poe_didkey_plus) ds_all_recs_in) := function


    // 1. Sort/dedup on non-zero bdids and empty phone2 to reduce the number
	  //    of lookups against the yellow pages key bdid file.
    ds_all_bdids_nogong := dedup(sort(ds_all_recs_in(bdid!=0 and company_phone2=''), 
	                                    bdid), bdid);

    // 2. Join the ds of unique no-zero bdids with no phone2 with the YellowPages
	  //    bdid key file, to get the yellow pages phone#.
	  ds_all_bdids_ypphone := join(ds_all_bdids_nogong, YellowPages.Key_YellowPages_BDID,
				                           keyed(left.bdid=right.bdid),
                                 transform(WorkPlace_Services.Layouts.poe_didkey_plus,
																   self.company_phone2 := right.phone10,
																   self                := left),
											           inner,
															   keep(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
															   limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

    // 3. Join the bdids with yp phone# back to the ds of poe key did records with
	  //    gong phone# added.
    ds_all_recs_wphone  := join(ds_all_recs_in, ds_all_bdids_ypphone,
				                          left.bdid=right.bdid,
                                transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															    // store yp phone into phone1 (if empty) or 
																	// in phone2 (if empty and not same as phone1)
																  // phone1 may be from poe or gong, so keep it if not empty
																  self.company_phone1 := if(left.company_phone1!='', 
																	                          left.company_phone1,right.company_phone2),
                                  // phone2 may be from gong, so keep it if not empty
																  // otherwise if phone2 empty store yp phone into it if phone1 was not empty 
																  // and if phone2 is diff than phone1
																  self.company_phone2 := if(left.company_phone2!='', 
																                            left.company_phone2,
																                            if(left.company_phone1 !='' and
																			  										   left.company_phone1 != right.company_phone2,
																				  							       right.company_phone2,'')),
                                 // Rest of the fields, keep the ones from the left ds
                                  self := left),
											          left outer, // keep all the recs from the left ds
												        atmost(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

		return ds_all_recs_wphone;

  end; // end of getPhoneFromYP function

	// This function takes in the combined sources and populates only phone numbers which do not exist in PSS
	// or that match the criteria of phone status = A and is in the 30 day window
	export	SuppressPhones(dataset(WorkPlace_Services.Layouts.poe_didkey_plus)	ds_recs_in)	:=
	function
	
		// Get Date 	
		string todays_date := (string) STD.Date.Today ();
			
		// Check company phone1 to see if it fits the criteria for valid phone
		WorkPlace_Services.Layouts.poe_didkey_plus	tSuppressPhone(ds_recs_in	le,PSS.Keys().BDID_Phone.QA	ri)	:=
		transform
			self.company_phone1	:=	if(	le.company_phone1	=	ri.response_company_phone,
																	if(	ri.response_phone_status	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																			le.company_phone1,
																			''
																		),
																	le.company_phone1
																);
			self.company_phone2	:=	if(	le.company_phone2	=	ri.response_company_phone,
																	if(	ri.response_phone_status	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																			le.company_phone2,
																			''
																		),
																	le.company_phone2
																);
			self								:=	le;
		end;
		
		ds_suppress_badphone	:=	join(	ds_recs_in,
																		PSS.Keys().BDID_Phone.QA,
																		keyed(left.bdid	=	right.bdid),
																		tSuppressPhone(left,right),
																		left outer,
																		limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT)
																	);
		
		// Move phone2 to phone1 if phone1 is empty
		ds_suppress_badphones	:=	project(	ds_suppress_badphone,
																				transform(	WorkPlace_Services.Layouts.poe_didkey_plus,
																										self.company_phone1	:=	if(left.company_phone1	!=	'',left.company_phone1,left.company_phone2);
																										self.company_phone2	:=	if(left.company_phone1	=	'','',left.company_phone2);
																										self								:=	left;
																									)
																			);
		
		return	ds_suppress_badphones;
	end;	// end of SuppressPhones function 
	
	//
	EXPORT	checkNonPersonalEmail(STRING email_in):=	FUNCTION
		
			STRING cap_s1:= std.Str.ToUpperCase(email_in);
			email_domain := Std.Str.SplitWords(cap_s1,'@');
			BOOLEAN isNonPersonalEmail:= email_domain[2] NOT IN BatchServices.WorkPlace_Constants.PERSONAL_EMAIL_DOMAIN_DCT;
		
		RETURN  isNonPersonalEmail;
	END;	// end of checkNonPersonalEmail function 
	
	EXPORT	getDetailedWithEmail(DATASET(WorkPlace_Services.Layouts.poe_didkey_plus)	ds_recs_in)	:= FUNCTION
		
		ds_recs_spoke     	:= ds_recs_in(MDR.sourceTools.SourceIsSpoke(source));
		ds_recs_zoom    	  := ds_recs_in(MDR.sourceTools.SourceIsZoom(source));
		ds_recs_corp      	:= ds_recs_in(MDR.sourceTools.SourceIsCorpV2(source));
		ds_recs_poeemail 		:= ds_recs_in(MDR.sourceTools.SourceIsEmail(source));
		ds_recs_oneclick  	:= ds_recs_in(MDR.sourceTools.SourceIsOne_Click_Data(source));
		ds_recs_saleschannel:= ds_recs_in(MDR.sourceTools.SourceIsSalesChannel(source));
		ds_recs_thrive    	:= ds_recs_in(MDR.sourceTools.SourceIsThrive_LT(source) OR
																			MDR.sourceTools.SourceIsThrive_PD(source));
																						
		 // If it not one of the specific sources above, keep all those recs together.
		ds_recs_others := ds_recs_in(~MDR.sourceTools.SourceIsSpoke(source)  AND
																 ~MDR.sourceTools.SourceIsZoom(source)   AND
																 ~MDR.sourceTools.SourceIsCorpV2(source) AND
																 ~MDR.sourceTools.SourceIsEmail(source)  AND
																 ~MDR.sourceTools.SourceIsOne_Click_Data(source) AND
																 ~MDR.sourceTools.SourceIsSalesChannel(source) AND
																 ~MDR.sourceTools.SourceIsThrive_LT(source)    AND
																 ~MDR.sourceTools.SourceIsThrive_PD(source)
																);		
																					
																					
		ds_detail_spoke := JOIN(ds_recs_spoke,spoke.keys().did.qa,
                            KEYED(LEFT.did = RIGHT.did) AND 
														 MDR.sourceTools.SourceIsSpoke(LEFT.source) AND
													  // Match on additional field in case multiple recs for the did
													  LEFT.dt_last_seen = RIGHT.dt_last_seen,
	                        TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														// fields from right spoke did key file, see spoke.layouts.keybuild
														SELF.company_description := RIGHT.rawfields.Company_Business_Description,
											      // rest of the fields from the LEFT (POE payload) converting some
                            SELF                := LEFT), 
													LEFT OUTER,
													KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));
													
		// Get the detailed data from the Zoom key did file.
	ds_detail_zoom := JOIN(ds_recs_zoom,zoom.keys().did.qa,
                           KEYED(LEFT.did = RIGHT.did) AND 
												   // match on additional field in case multiple recs for the did
												   LEFT.dt_last_seen = RIGHT.dt_last_seen,
	                       TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														// fields from RIGHT zoom did key file, see zoom.layouts.keybuild
														isNonPersonalEmail:= checkNonPersonalEmail(RIGHT.rawfields.email_address);
														temp_email := IF(isNonPersonalEmail,RIGHT.rawfields.email_address,'');
														
                            SELF.email1         := temp_email,
														SELF.email_src1			:= IF(temp_email<>'',LEFT.SOURCE,''),
														// rest of the fields from the LEFT (POE payload) converting some							
                            SELF                := LEFT), 
													LEFT OUTER,
													KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


	// 				Get the detailed data from the Corp2 key cont corp_key file.
	//        First use bdid to look up the corp_key on the corp2::qa::cont::bdid key file.
	//        Then use the corp_key to look up POE related person & company info on 
	//        the corp2::qa::cont::corp_key.record_type key file.
	ds_recs_corpkey := JOIN(ds_recs_corp,corp2.keys().cont.bdid.qa,
													KEYED(LEFT.bdid = RIGHT.bdid),
													TRANSFORM(BatchServices.WorkPlace_Layouts.poe_didkey_slimmed,
													  SELF.corp_key := RIGHT.corp_key, //only KEEP corp_key from RIGHT 
														SELF          := LEFT),  // KEEP all poe slimmed fields
													LEFT OUTER,
													KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	ds_detail_corp := JOIN(ds_recs_corpkey,corp2.keys().cont.corpkey.qa,
												 KEYED(LEFT.corp_key = RIGHT.corp_key AND
															 RIGHT.record_type = 'C') AND // only want current info
												 // match on additional fields in case of multiple current
												 // records for the corp_key
															 LEFT.bdid         = RIGHT.bdid AND
															 LEFT.did          = RIGHT.did,
	                       TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
												   // fields from corp2 cont corp_key key file, see Corp2.Layout_Corporate_Direct_Cont_Base
													 													 
                           temp_email1               :=MAP(RIGHT.corp_email_address<>'' AND checkNonPersonalEmail(RIGHT.corp_email_address)=> RIGHT.corp_email_address,
																													 RIGHT.cont_email_address<>'' AND checkNonPersonalEmail(RIGHT.cont_email_address)=> RIGHT.cont_email_address,
																													 '');
													 SELF.email1 								   := temp_email1,
                           SELF.email_src1               := IF(temp_email1<>'', 
																															 LEFT.SOURCE,
																														   ''),
													 temp_email2               := MAP(RIGHT.corp_email_address<>'' AND checkNonPersonalEmail(RIGHT.corp_email_address) AND checkNonPersonalEmail(RIGHT.cont_email_address)=> RIGHT.cont_email_address,
																													  '');
													 SELF.email2									 :=		temp_email2,				 
											     SELF.email_src2               := IF(temp_email2<>'', 
																															 LEFT.SOURCE,
																														   ''),
																													 
											     // rest of the fields from the LEFT (POE did key) converting some
                           SELF                := LEFT), 
												 LEFT OUTER,
												 KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
												 LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


  // Get the detailed data from the poesfromemails did key file.
	ds_detail_poeemail := JOIN(ds_recs_poeemail,POEsFromEmails.keys().did.qa,
                               KEYED(LEFT.did = RIGHT.did) AND 
												       // match on additional field in case multiple recs for the did 
												       LEFT.dt_last_seen = RIGHT.date_last_seen,
	                           TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														   // fields from RIGHT POEsFromEmails did key file, see POEsFromEmails.layouts.keybuild
                               temp_email1 := IF(checkNonPersonalEmail(RIGHT.clean_email),RIGHT.clean_email,'');
                               SELF.email1 := temp_email1,
                               SELF.email_src1 := IF(temp_email1 <>'',RIGHT.email_src,''),
														   // rest of the fields from the LEFT (POE slimmed) converting some
                               SELF                := LEFT), 
												     LEFT OUTER,
													   KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													   LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	// Get the detailed data from the One_Click key did file.
	ds_detail_oneclick := JOIN(ds_recs_oneclick,one_click_data.keys().did.qa,
                               KEYED(LEFT.did = RIGHT.did) AND 
														   // match on additional field in case multiple recs for the did
															 LEFT.dt_last_seen = RIGHT.dt_last_seen,
	                           TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														   // fields from oneclick did key file, see oneclick_data.layouts.keybuild
															 
															 temp_email1 				 := IF(checkNonPersonalEmail(RIGHT.rawfields.EmailAddress),RIGHT.rawfields.EmailAddress,'');
                               SELF.email1 				 := temp_email1,
                               SELF.email_src1     := IF(temp_email1 <>'',LEFT.SOURCE,''),
											         // rest of the fields from the LEFT (POE did key) converting some
                               SELF                := LEFT), 
														 LEFT OUTER, // keep rec from LEFT IF no match to RIGHT
														 KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
														 LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	// Get the detailed data from the Sales Channel key did file.
	ds_detail_saleschannel := JOIN(ds_recs_saleschannel, SalesChannel.keys().did.qa, 
                               KEYED(LEFT.did = RIGHT.did) AND
																LEFT.dt_last_seen = RIGHT.date_last_seen AND
																LEFT.bdid = RIGHT.bdid,
	                           TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														   // fields from sales channel did key file
															 temp_email1 				 := IF(checkNonPersonalEmail(RIGHT.rawfields.email),RIGHT.rawfields.email,'');
                               SELF.email1 				 := temp_email1,
                               SELF.email_src1     := IF(temp_email1 <>'',LEFT.SOURCE,''),
                               SELF                := LEFT), 
														 LEFT OUTER, // keep rec from LEFT IF no match to RIGHT
														 KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
														 LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));	

	// Get the detailed data from the Thrive key did file.
	ds_detail_thrive := JOIN(ds_recs_thrive,thrive.keys().did.qa,
                           KEYED(LEFT.did = RIGHT.did) AND 
												   // match on additional field in case multiple recs for the did
												   LEFT.dt_last_seen = RIGHT.dt_last_seen,
	                       TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														// fields from RIGHT thrive did key file, see thrive.layouts.base
														
														temp_email1 				:= IF(checkNonPersonalEmail(RIGHT.Email),RIGHT.Email,'');
											 		  SELF.email1 				:= temp_email1,
													  SELF.email_src1     := IF(temp_email1 <>'',RIGHT.src,''),										
                            SELF                := LEFT), 
													LEFT OUTER,
													KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
													LIMIT(BatchServices.WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


  // Project all the others that don't need additional source specIFic data
	// to put all recs into the same layout AND convert 3 fields.
	ds_detail_others := PROJECT(ds_recs_others,
	                            TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
														    // fields from the LEFT (POE slimmed) converting some
                                SELF                := LEFT)
														 );

	// Combine all source detail recs into 1 dataset.
  ds_detail_all := ds_detail_spoke
	                 + ds_detail_zoom  
									 + ds_detail_corp 
									 + ds_detail_poeemail
									 + ds_detail_oneclick
									 + ds_detail_saleschannel
									 + ds_detail_thrive
									 + ds_detail_others;
	
  ds_email_data := JOIN(ds_detail_all,Email_Data.Key_Did,
                           KEYED(LEFT.did = RIGHT.did),
	                       TRANSFORM(BatchServices.WorkPlace_Layouts.email,
													 // first take did only from the LEFT to keep in string format
                           SELF.did := (STRING)LEFT.did, 
													 // take other fields from RIGHT email key did file
													 temp_email:= IF(RIGHT.clean_email <>'' AND checkNonPersonalEmail(RIGHT.clean_email), RIGHT.clean_email, '');
                           SELF.clean_email    := IF(temp_email<>'',temp_email, SKIP);
													 SELF.email_src 		 := IF(temp_email<>'', RIGHT.email_src, ''),
													 SELF.date_last_seen := IF(temp_email<>'',RIGHT.date_last_seen,'')),
												 inner, // only ones in LEFT & RIGHT
												 LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 		  First sort & dedup by did & email address to use only unique emails for each did.
	//      Then reseort by did & descending date-last-seen AND then
	//      dedup by did to keep the (up to) 3 most current recs.
  ds_email_deduped := DEDUP(SORT(DEDUP(SORT(ds_email_data,
	                                          did,clean_email,-date_last_seen,record),
	                                     did,clean_email),
	                               did,-date_last_seen,record),
														did,KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_EMAIL));

 	// 			Combine up to 3 email recs for each did into a single layout to assist
	//      in JOINing later.
  BatchServices.WorkPlace_Layouts.email_combined 
	        xform_roll_email(BatchServices.WorkPlace_Layouts.email L,
					                DATASET(BatchServices.WorkPlace_Layouts.email) RL) := TRANSFORM
   	SELF.did                   := L.did;
		SELF.email_address1        := L.clean_email;
		SELF.email_address2        := RL[2].clean_email;
		SELF.email_address3        := RL[3].clean_email;
		SELF.email_src1			   := L.email_src;
		SELF.email_src2			   := RL[2].email_src;
		SELF.email_src3			   := RL[3].email_src;
	end;
	
  ds_email_combined := ROLLUP(GROUP(ds_email_deduped,did),
														  GROUP,
														  xform_roll_email(LEFT,ROWS(LEFT)));

	// 			Finally JOIN the ds of detail recs to the deduped/combined email recs, 
	//      preferring any emails from the individual source detail files which are 
	//      in the LEFT DATASET.
	
	uc(string x) := StringLib.StringToUpperCase(x);
	
	ds_detail_wemail := JOIN(ds_detail_all, ds_email_combined,
                            LEFT.did = (UNSIGNED6)RIGHT.did,
	                          TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
															// take email field from RIGHT for any not already filled in.
															// first store into temp fields to be used later
															temp_email1 := IF (RIGHT.email_address1<>'',
																								 uc(RIGHT.email_address1),
															                   uc(LEFT.email1));
													    SELF.email1 := temp_email1,
															SELF.email_src1 := CASE(temp_email1, 
																											uc(RIGHT.email_address1)=> RIGHT.email_src1,
																											uc(LEFT.email1)=> LEFT.email_src1,
																											'');
                              temp_email2 := MAP(RIGHT.email_address2<>'' =>uc(RIGHT.email_address2),
																								 uc(LEFT.email1)<>uc(temp_email1)=> uc(LEFT.email1),
																								 uc(LEFT.email2)<>uc(temp_email1)=> uc(LEFT.email2),
																								 '');
														  SELF.email2 := temp_email2,														
															SELF.email_src2 := CASE(temp_email2, 
																										  uc(RIGHT.email_address1)=> RIGHT.email_src1,
																										  uc(RIGHT.email_address2)=> RIGHT.email_src2,
																										  uc(LEFT.email1)=> LEFT.email_src1,
																										  uc(LEFT.email2)=>LEFT.email_src2,
																										  '');
                              temp_email3 := MAP (RIGHT.email_address3<>''=> uc(RIGHT.email_address3),
																								  uc(LEFT.email1)<>uc(temp_email1) AND uc(LEFT.email1)<>uc(temp_email2)=> uc(LEFT.email1),
																									uc(LEFT.email2)<>uc(temp_email1) AND uc(LEFT.email2)<>uc(temp_email2)=> uc(LEFT.email2),
																									uc(LEFT.email3)<>uc(temp_email1) AND uc(LEFT.email3)<>uc(temp_email2)=> uc(LEFT.email3),
																									'');
															SELF.email3 := temp_email3,
															SELF.email_src3 := CASE(temp_email3,
																											uc(RIGHT.email_address1)=> RIGHT.email_src1,
																											uc(RIGHT.email_address2)=> RIGHT.email_src2,
																											uc(RIGHT.email_address3)=> RIGHT.email_src3,
																											uc(LEFT.email1)=> LEFT.email_src1,
																										  uc(LEFT.email2)=> LEFT.email_src2,
																										  uc(LEFT.email3)=> LEFT.email_src3,
																											'');
														  // keep the rest of the fields from the LEFT
                              SELF        := LEFT), 
												    LEFT OUTER,  // keep all the recs from the LEFT ds
													  ATMOST(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));


	  RETURN ds_detail_wemail;
  END; // end of getDetailedWithEmail function 
	
	EXPORT getParentCompany(DATASET(WorkPlace_Services.Layouts.poe_didkey_plus)	ds_recs_in, BOOLEAN IncludeCorp= FALSE) := FUNCTION
		
			// NOTE: In DCA, the root-sub expression is a compound value: 
			// the root (nine digits), followed by a dash, followed by the sub(sidiary) value
			// (four digits). e.g. 123456789-1234. 
			// The root denotes the top-level company at the head of a conglomerate or set of 
			// subsidiaries. e.g. LexisNexis RiskSolution's root is Reed-Elsevier. 
			// The sub is simply a surrogate identifier denoting a particular subsidiary in the 
			// root's tree. 
			// Therefore in the code below you'll see the expression:
			//     LEFT.parent_number[1..9]  = RIGHT.root AND
			//     LEFT.parent_number[11..14] = RIGHT.sub
			// Where [1..9] refers to the root portion of the parent_number AND [11..14] refers 
			// to the sub portion of the parent_number. We omit [10] of course, which is a dash.
			//
			//  SORT/dedup on bdid. 
			ds_detail_bdids_deduped := DEDUP(SORT(ds_recs_in,bdid),bdid);

			// First for the deduped bdids, get the level, root, sub & parent_number info
			// from the DCA bdid key file.
			ds_bdids_dca_added := JOIN(ds_detail_bdids_deduped,DCA.Key_DCA_BDID,
																	 KEYED(LEFT.bdid = RIGHT.bdid),
																 TRANSFORM(BatchServices.WorkPlace_Layouts.dca_info,
																	 // take certain DCA fields from RIGHT dca key bdid file
																	 SELF.bdid          := RIGHT.bdid, 
																	 SELF.level         := RIGHT.level,
																	 SELF.root          := RIGHT.root,
																	 SELF.sub           := RIGHT.sub,
																	 SELF.parent_number := RIGHT.parent_number),
																 inner,
																 KEEP(BatchServices.WorkPlace_Constants.Limits.KEEP_LIMIT),
																 LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

			// Next get parent company info for each bdid with a non-blank DCA root value.
			ds_parents1 := doxie_cbrs.get_DCA_records(PROJECT(ds_bdids_dca_added(root != ''),
																											 doxie_cbrs.layout_references), 
																							 BatchServices.WorkPlace_Constants.DCA_RETREIVE_PARENT);

			// 			  Sort/dedup by root&sub since doxie_cbrs.get_DCA_records can return > 1 record 
			//        with the same root&sub, but different parent_numbers.
			//        (Which happened on 02/15/12 in RQ bug 97312).
			ds_parents := DEDUP(SORT(ds_parents1,root,sub,record),root,sub);

			// 			 Next attach the parent company info to the bdids with DCA data.
			ds_bdids_wparent := JOIN(ds_bdids_dca_added, ds_parents,
																 LEFT.parent_number[1..9]  = RIGHT.root AND
																 // NOTE: position 10 = '-'; so it is skipped
																 LEFT.parent_number[11..14] = RIGHT.sub,
															 TRANSFORM(BatchServices.WorkPlace_Layouts.dca_info,
																 // Get parent company fields from RIGHT file
																 SELF.parent_company_bdid    := IF(RIGHT.bdid<>0,(string) RIGHT.bdid,'');
																 SELF.parent_company_name    := StringLib.StringToUpperCase(RIGHT.Name),
																 SELF.parent_company_address := Address.Addr1FromComponents(
																																RIGHT.prim_range,
																																RIGHT.predir,
																																RIGHT.prim_name,
																																RIGHT.addr_suffix,
																																RIGHT.postdir,
																																RIGHT.unit_desig,
																																RIGHT.sec_range),
																 SELF.parent_company_prim_range  := RIGHT.prim_range,
																 SELF.parent_company_predir      := RIGHT.predir,
																 SELF.parent_company_prim_name   := RIGHT.prim_name,
																 SELF.parent_company_addr_suffix := RIGHT.addr_suffix,
																 SELF.parent_company_postdir     := RIGHT.postdir,
																 SELF.parent_company_unit_desig  := RIGHT.unit_desig,
																 SELF.parent_company_sec_range   := RIGHT.sec_range,															
																 SELF.parent_company_city    := RIGHT.p_city_name,
																 SELF.parent_company_state   := RIGHT.st,
																 SELF.parent_company_zip     := RIGHT.z5 + 
																																IF(RIGHT.zip4<>'',
																																	 '-' + RIGHT.zip4,''),
																 SELF.parent_company_zip4        := RIGHT.zip4,
																 SELF.parent_company_phone   := RIGHT.phone,
																 // Keep rest of data from LEFT file
																 SELF                     := LEFT),
															 inner, 
															 LIMIT(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT,skip));		
															 
			// 		 JOIN the detail_all file with the file containing DCA parent company info
			//        matching on bdid. 
			ds_detail_wparent := JOIN(ds_recs_in, ds_bdids_wparent,
																LEFT.bdid = RIGHT.bdid,
																TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
																 // Copy parent comp info from bdids_with_parent ds
																	SELF.parent_company_bdid    := (string) RIGHT.parent_company_bdid,
																	SELF.parent_company_name    := RIGHT.parent_company_name,
																	SELF.parent_company_address := RIGHT.parent_company_address,
																	SELF.parent_company_prim_range  := RIGHT.parent_company_prim_range,
                                  SELF.parent_company_predir      := RIGHT.parent_company_predir,
                                  SELF.parent_company_prim_name   := RIGHT.parent_company_prim_name,
                                  SELF.parent_company_addr_suffix := RIGHT.parent_company_addr_suffix,
                                  SELF.parent_company_postdir     := RIGHT.parent_company_postdir,
                                  SELF.parent_company_unit_desig  := RIGHT.parent_company_unit_desig,
                                  SELF.parent_company_sec_range   := RIGHT.parent_company_sec_range,															 
                                  SELF.parent_company_city        := RIGHT.parent_company_city,
                                  SELF.parent_company_state       := RIGHT.parent_company_state,
																	SELF.parent_company_zip         := RIGHT.parent_company_zip + 
																																		 if(right.parent_company_zip4<>'',
																																				'-' + right.parent_company_zip4,''),
                                  SELF.parent_company_zip5        := RIGHT.parent_company_zip,
                                  SELF.parent_company_zip4        := RIGHT.parent_company_zip4,
																	SELF.parent_company_phone   := RIGHT.parent_company_phone,
																 // keep rest of info from LEFT
																 SELF                        := LEFT),
															 LEFT OUTER,  // keep all the recs from the LEFT ds
															 ATMOST(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));												 
				
			//  Get optional corp status info for the parent company.
			//
			//  If IncludeCorpInfo option was set on:
			//        1. sort/dedup on non-zero parent co bdids (to reduce the number of lookups),
			//        2. then project onto appropriate layout AND 
			//        3. call a function to get the status.
			ds_parent_bdids_corpstat := IF(IncludeCorp,
																		 BatchServices.WorkPlace_Functions.getCorpStatus(
																					DEDUP(SORT(PROJECT(ds_detail_wparent(parent_company_bdid<>''), 
																														 TRANSFORM(doxie_cbrs.layout_references,
																															 SELF.bdid :=(unsigned6) LEFT.parent_company_bdid)),
																										 bdid), bdid)),
																		 //else output an empty ds 
																		 DATASET([], BatchServices.WorkPlace_Layouts.bdids_corpstat));
			
			// 			  JOIN the parent co bdids with a corp status back to the ds of detail with
			//        parent co info to attach the corp status for the parent co.
			ds_detail_wpar_corpstat := JOIN(ds_detail_wparent, ds_parent_bdids_corpstat,
																				(unsigned6) LEFT.parent_company_bdid = RIGHT.bdid,
																			TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
																				// only take status from RIGHT
																				SELF.parent_company_status := RIGHT.corp_status_desc,
																				// Rest of the fields, keep the ones from the LEFT ds
																				SELF             := LEFT),
																			LEFT OUTER,  // keep all the recs from the LEFT ds
																			ATMOST(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

		RETURN ds_detail_wpar_corpstat;
	END;	// end of getParentCompany function
	
	EXPORT getProfLicInfo(DATASET(WorkPlace_Services.Layouts.poe_didkey_plus) ds_recs_in):= FUNCTION
		
	// First get all the prof lic recs (if any exist) for each did.
	ds_prolic_data := JOIN(ds_recs_in, Prof_LicenseV2.Key_Proflic_Did(),
                           KEYED(LEFT.did = RIGHT.did),
	                       TRANSFORM(BatchServices.WorkPlace_Layouts.prolic,
													 // first take did only from the LEFT to keep in string format
                           SELF.did  := (STRING)LEFT.did, 
                           // SELF.bdid := (UNSIGNED6)LEFT.bdid, 
													 // take other 3 fields from RIGHT ProfLic key did file
                           SELF     := RIGHT),
												 LEFT OUTER, // keep all the recs from the LEFT ds
												 ATMOST(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 		  Then sort by did AND descending dt_last_seen (puts most current first).
  //      Then dedup by the dt_last_seen to identify the most current record.
  ds_prolic_deduped := DEDUP(SORT(ds_prolic_data,did,-date_last_seen),did);

	// 		 Finally JOIN the ds of detail recs to the deduped pl data recs.
	ds_detail_wprolic := JOIN(ds_recs_in,ds_prolic_deduped ,
                            (STRING12)LEFT.did = RIGHT.did,
	                          TRANSFORM(WorkPlace_Services.Layouts.poe_didkey_plus,
															// take 2 prof lic fields in output layout from RIGHT
                              SELF.prof_license        := RIGHT.license_type,
                              SELF.prof_license_status := RIGHT.status,
														  // keep the rest of the fields from the LEFT
                              SELF                     := LEFT), 
												    LEFT OUTER,  // keep all the recs from the LEFT ds
													  ATMOST(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));
		RETURN ds_detail_wprolic;
	END;	// end of getProfLicInfo function
	
end; // end of Functions module
