/* TO BE DONE:
   1. Future enhancement to further assist when new sources are added: 
      a. Contact Vern about about adding all the source specific fields currently used 
         to the POE base data file, so they are then included on the did key file.
      b. Then revise steps 5 & 12 (and others?) to get the source specific fields from 
         the POE did key file.
*/

// NOTE: POE is short for PlaceOfEmployment which is the former name of this product/project.
// However the production POE keys were already built when it was decided to rename this 
// product to WorkPlace, so the keys were left named as POE.

IMPORT	Address, AutoStandardI, BatchShare, Corp2,
				DCA, doxie, doxie_cbrs, Email_Data, Gong, MDR, PSS,
				One_Click_Data, POE, POEsFromEmails, Prof_LicenseV2,
				SalesChannel, Spoke, Suppress, thrive, ut, WorkPlace_Services, YellowPages, Zoom, STD;

string todays_date := (string) STD.Date.Today ();

EXPORT WorkPlace_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION 

  // *** Stored soap input and temporary/internal constants
	application_type_value := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	glb_purpose 					 := AutoStandardI.InterfaceTranslator.glb_purpose.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_purpose.params));
	
	boolean IncludeSpouseAlways := false : STORED('IncludeSpouseAlways');
	boolean IncludeSpouseOnly   := false : STORED('IncludeSpouseOnlyIfNoDebtor');
	boolean IncludeEmail        := false : STORED('IncludeEmailInfo');
	boolean IncludeAddl         := false : STORED('IncludeAdditionalInfo');
	boolean IncludeCorp         := false : STORED('IncludeCorpInfo');
	boolean IncludeSelfRepCompanyName := false : STORED('IncludeSelfRepCompanyName');

 	string in_excluded_sources  := '' : stored('ExcludedSources'); 

  // ***************************************************************************
  // *** Main processing

	// 0.1 First edit the input ExcludedSources string as needed for processing below.
  in_excluded_sources_edited := TRIM(Stringlib.StringToUpperCase(in_excluded_sources),
	                                   LEFT,RIGHT,ALL);

  // 0.2 Next if not empty, parse the input "ExcludedSources" comma de-limited list
	//     string to create a dataset of any 2 character source codes to be excluded.
  layout_source := record
	  string2 source;
	end;
	
  ds_excluded_sources := 
	   if(in_excluded_sources_edited = '',
	      dataset([], layout_source),
			  dataset(Std.Str.SplitWords(in_excluded_sources_edited, ','), layout_source));


	// 1. Grab the input XML and throw into a dataset.	
	ds_batch_in := IF(NOT useCannedRecs, 
	                  BatchServices.file_inBatchMaster(), 
	                  BatchServices._Sample_inBatchMaster('WP'));
 
  // 2. Do a project with transform to convert any lower case input to upper case.
  BatchShare.MAC_CapitalizeInput(ds_batch_in, ds_batch_in_caps);
  // 3. Get the DID(s) associated with each input record.
	//
	// 3.1 Use common batch services function to get the dids for the input data.
	ds_acctnos_dids_appended := Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_caps);

  // 3.2 Make sure each acctno's input criteria only resolved to 1 did.
  //     If more than 1 did per acctno, don't return anything for that acctno.
	//
  // 3.2.1 Table/count to count the number of dids for each acctno.
	//       Only keep the acctno if the resulting did_count is less than or equal
	//       the did_limit (currently 1); otherwise drop that acctno.
  layout_dids_count := RECORD
		ds_acctnos_dids_appended.acctno;
    did_count := COUNT(GROUP);
  END;
	
	ds_acctnos_dids_table := table(ds_acctnos_dids_appended,layout_dids_count,acctno,few);
  ds_acctnos_w1did      := ds_acctnos_dids_table(did_count<=WorkPlace_Constants.Limits.DID_LIMIT);

  // 3.2.2 Join all acctnos with dids appended to those with just 1 did per acctno to 
	//       remove any acctnos with more than 1 did or with no did.
	ds_acctnos_dids_good := join(ds_acctnos_w1did,ds_acctnos_dids_appended,
	                               left.acctno = right.acctno,
													     transform(right),
													     left outer, // keep all the recs from the left ds
													     atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 3.3 Sort/dedup on did in case same person input more than once and 
	//    to reduce number of lookups against the POE did key file later.
  //    We will re-attach all acctnos back to the dids later.
  ds_dids_deduped := dedup(sort(ds_acctnos_dids_good,did),did);

	// 3.4 Project the resulting deduped subject dids with a transform to put into a 
	//     common poe did key lookup layout and set the correct spouse_indicator.
	// NOTE: the spouse_indicator only indicates if the record is a spouse record, 
	// not if a spouse was found for the subject/did.
  ds_subject_dids := project(ds_dids_deduped, 
	                           transform(WorkPlace_Layouts.POE_lookup,
															 self.acctno           := left.acctno,
															 self.lookupDid        := left.did,
															 self.subjectDid 	     := left.did,
															 self.spouseDid        := 0,
                               self.spouse_indicator := 'N'));

  // 4. Get optional spouse did for each input (subject) did.
	//
  // 4.1 Check if either IncludeSpouse option is on, project the subject acctnos/dids
  //     into the needed layout and then call a function to attempt to get the spouse
	//     did for each subject did.
  ds_dids_spousein := if(IncludeSpouseAlways or IncludeSpouseOnly,
                         project(ds_dids_deduped,WorkPlace_Layouts.subjectSpouse));
	ds_spouse_acctnos_dids := WorkPlace_Functions.getSpouseDidBatch(ds_dids_spousein);
  
  // 4.2 Sort/dedup all the spouse dids by did to reduce number of lookups against 
	//     the POE did key file later.
  //     We will re-attach all acctnos back to the spouse dids later.
	ds_spouse_dids_deduped := dedup(sort(ds_spouse_acctnos_dids(spousedid<>0), spousedid), 
	                                spousedid);

  // 4.3 Project the resulting deduped spouse dids with a transform to put into a 
	//     common poe key did lookup layout and set the correct spouse_indicator.
	ds_spouse_dids := project(ds_spouse_dids_deduped, 
	                          transform(WorkPlace_Layouts.POE_lookup,
														  self.acctno           := left.acctno,
															self.lookupDid        := left.spouseDid,
															self.subjectDid 	    := left.did,
															self.spouseDid        := left.spouseDid,
                              self.spouse_indicator := 'Y'));

  // 5. Look up dids in the POE key did file to get all the fields needed for 
	//    choosing a candidate record later.
	//
  // 5.1 Combine the unique subject dids and unique spouse dids into 1 dataset and 
	//     then sort and dedup by lookup did in case 1 subject did is another 
	//     subject's spouse did.
	ds_combined_dids_sorted := dedup(sort(ds_subject_dids + ds_spouse_dids,lookupdid),lookupdid);

  // 5.2 Join the ds of unique combined dids with POE key did file, transforming the
	//     full did key layout into a slimmmed format of just the fields needed for 
	//     choosing a candidate record below.
  SSN_WIDTH         := 9;
	LEADING_ZERO_FILL := 1;
	
	ds_poe_recs_slimmed := join(ds_combined_dids_sorted,POE.Keys().did.qa,
															keyed(left.lookupdid = right.did),
	                            transform(WorkPlace_Layouts.poe_didkey_slimmed,
															  // certain fields need special handling/name changes
                                self.spouse_indicator   := left.spouse_indicator,
																self.subject_first_name := right.subject_name.fname,
																self.subject_last_name  := right.subject_name.lname,
																self.subject_ssn        := if(right.subject_ssn=0,
																	                            '', // store blank instead of zero
																															// otherwise convert integer ssn to string9 ssn
																															// use intformat in case leading digit of ssn is zero
																	                             intformat(right.subject_ssn,
																															           SSN_WIDTH,
																																				 LEADING_ZERO_FILL)),
		                            self.company_address    := Address.Addr1FromComponents(
														                               right.company_address.prim_range,
                                                           right.company_address.predir,
                                                           right.company_address.prim_name,
                                                           right.company_address.addr_suffix,
                                                           right.company_address.postdir,
                                                           right.company_address.unit_desig,
                                                           right.company_address.sec_range),
														    self.company_city       := right.company_address.city_name,
                                self.company_state      := right.company_address.st,
                                self.company_zip        := right.company_address.zip + 
														                               if(right.company_address.zip4<>'',
																												      '-' + right.company_address.zip4,''),
																self.company_phone1     := if(right.company_phone=0,
																                              '',(string) right.company_phone);
																// rest of fields use the poe did key field names from right
                                self := right),
												      INNER,
												      LIMIT(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

	// 5.3 Join the ds of unique combined dids with PSS Accutrac did file transforming the
	//     full did key layout into a slimmmed format of just the fields needed for 
	//     choosing a candidate record below.
	BatchServices.WorkPlace_Layouts.PSS_DIDKey_Slimmed	tPSS(ds_combined_dids_sorted	le,PSS.Keys().DID.QA	ri)	:=
	transform
		// certain fields need special handling/name changes
		self.acctno							:=	le.acctno;
		self.source							:=	MDR.sourceTools.src_PSS;
		self.dt_last_seen				:=	(unsigned4)ri.date_last_seen;
		self.spouse_indicator		:=	le.spouse_indicator;
		self.subject_first_name	:=	ri.subject_first_name;
		self.subject_last_name	:=	ri.subject_last_name;
		self.subject_ssn				:=	if(	(integer)ri.response_ssn	=	0,
																		'', // store blank instead of zero otherwise convert integer ssn to string9 ssn use intformat in case leading digit of ssn is zero
																		ri.response_ssn
																	);
		// Check if the Accutrac phone status is "A" and is within 30 days for company phone1/phone2
		self.company_phone1			:=	if(			ut.CleanSpacesAndUpper(ri.response_phone_1_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS
																		and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																		ri.company_phone1,
																		''
																	);
		self.company_phone2			:=	if(			ut.CleanSpacesAndUpper(ri.response_phone_2_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS
																		and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																		ri.company_phone2,
																		''
																	);
		// rest of fields use the pss did key field names from right
		self										:=	ri;
	end;
	
	ds_PSS_Results	:=	join(	ds_combined_dids_sorted,
														PSS.Keys().DID.QA,	//Accutrac phone status service data
														keyed(left.lookupdid	=	right.did)	and
														(	(			ut.CleanSpacesAndUpper(right.response_phone_1_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	//Check if phone1 status is A
																and	ut.DaysApart(todays_date,(string8)right.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW	//Check if phone1
															)
															or
															(			ut.CleanSpacesAndUpper(right.response_phone_2_status)	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	//Check if phone2 status is A
																and	ut.DaysApart(todays_date,(string8)right.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW
															)
														),
														tPSS(left,right),
														LIMIT(WorkPlace_Constants.Limits.JOIN_LIMIT,skip)
													);
	
	// Dedup on did and keep the most recent record
	ds_PSS_Results_Dedup	:=	dedup(	sort(	ds_PSS_Results,
																					did,subject_first_name,subject_last_name,subject_ssn,-dt_vendor_last_reported
																				),
																		did,subject_first_name,subject_last_name,subject_ssn
																	);
	
	// Bring back to the slimmed POE layout
	ds_PSS_Results_Slim	:=	project(ds_PSS_Results_Dedup,BatchServices.WorkPlace_Layouts.POE_DIDKey_Slimmed);
	

  // 7.1 Combine POE & PSS slimmed recs into 1 dataset here and 
	//     join to POE source_hierarchy key file to assign the source_order.
	ds_combine_sources	:=	ds_poe_recs_slimmed	+	ds_PSS_Results_Slim;
	
	ds_all_recs_slimmed := join(ds_combine_sources,
	                            POE.Keys().source_hierarchy.qa,
															keyed(left.source = right.source),
	                            transform(WorkPlace_Layouts.poe_didkey_slimmed,
															  // get source_order from the right key file
												        self.source_order := right.source_order,
																// keep the rest of fields from left
                                self              := left),
												      LEFT OUTER); // keep left record in case no match to right key file

  // 7.2 Filter to only include records for sources that are not restricted;
	//     based upon the DataRestrictionMask positions associated with those sources.
  ds_all_recs_not_restricted := ds_all_recs_slimmed(
	     // First, include the record if the source is not restricted.
			 // NOTE1: As of 01/14/2011, Teletrack is the only source that might be 
			 //                          restricted via the DataRestrictionMask.
		   (MDR.sourceTools.SourceIsTeletrack(source) and ~doxie.DataRestriction.TT) OR
       // OR include the record if the source is not Teletrack.
			 ~MDR.sourceTools.SourceIsTeletrack(source));

	// 7.3 Applying GLB restrictions.
	ds_all_recs_glb_ok := ds_all_recs_not_restricted(ut.PermissionTools.glb.SrcOk(glb_purpose, source, dt_first_seen, 0));

  // 7.3 Next do a "left only" join to the excluded_sources dataset to pass through
  //     all sources that are not excluded.
  ds_all_recs_included := join(ds_all_recs_glb_ok, ds_excluded_sources,
	                               left.source = right.source,
															 transform(left),
	                             left only //only include left recs with no match in right ds
															);

	// 8. pull recs by ssn & did.
  Suppress.MAC_Suppress(ds_all_recs_included,ds_dids_pulled,application_type_value,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(ds_dids_pulled,ds_ssns_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,subject_ssn);
	doxie.MAC_PruneOldSSNs(ds_ssns_pulled, ds_all_recs_pulled, subject_ssn, did);

	// 9.0 Remove invalid phone1 & company_name info in both POE & gateway recs.
	//     Then add back in any missing info using the business-header best data for the bdid.
	//
  // 9.0.1 Project ds onto the layout expected by the clean/add functions.
  ds_all_recs_pulled_projtd := project(ds_all_recs_pulled,
	                                     WorkPlace_Services.Layouts.poe_didkey_plus);	

	// 9.0.2 Try to add any missing company info using the business-header best file.
  ds_all_recs_bhbest_added := WorkPlace_Functions.AddBestInfo(ds_all_recs_pulled_projtd);

	// 9.0.3 Remove invalid/disconnected/residential numbers in the company_phone1/2 fields.
	ds_all_recs_phones_cleaned := WorkPlace_Functions.CleanPhones(ds_all_recs_bhbest_added);

	// 9.0.4 Remove company_names with only invalid terms.
	ds_all_recs_cname_cleaned := WorkPlace_Functions.CleanCompName(ds_all_recs_phones_cleaned, IncludeSelfRepCompanyName);

  // 9.0.5 Project ds back onto slimmed layout expected below.
  ds_all_recs_cleaned_projtd := project(ds_all_recs_cname_cleaned,
	                                      BatchServices.WorkPlace_Layouts.poe_didkey_slimmed);	

  // 9.1 Get missing company name and/or address info from EDA/gong history key file. 
  //     If the company name or address is missing, use the company_phone1 (if non blank)
	//     to do a reverse phone# lookup in the EDA/gong file to get the listing company 
	//     name, address & bdid (if also missing on the poe did key file).
	//
	// 9.1 Sort/dedup on non-blank company_phone1 to reduce the number of lookups
	//     against the gong key history file.
	
  ds_all_phone1_deduped := dedup(sort(ds_all_recs_cleaned_projtd(
	                                                       company_phone1<>'' and
	                                                       (company_name    = '' or
																													company_address = '' or
																													company_city    = '' or
																													company_state   = '' or
																													company_zip     = '')),
	                                    company_phone1),company_phone1);
																		
  // 9.2 Join the unique non-blank phone1s with the gong history phone key file, 
	//     to get the gong company name/address & bdid(if needed).
	ds_all_phone1_gongcomp := join(ds_all_phone1_deduped, gong.Key_History_phone, 
				                           keyed(left.company_phone1[4..10] = right.p7 and 
					                               left.company_phone1[1..3]  = right.p3) and 
																         right.current_flag and //we only want current data
							                           right.business_flag,   //we only want businesses
							                   transform(WorkPlace_Layouts.poe_didkey_slimmed,
																   // comp name/address/bdid from right gong history
                                   self.company_name    := right.listed_name,
		                               self.company_address := Address.Addr1FromComponents(
														                               right.prim_range,
                                                           right.predir,
                                                           right.prim_name,
                                                           right.suffix,
                                                           right.postdir,
                                                           right.unit_desig,
                                                           right.sec_range),
														       self.company_city    := right.p_city_name,
                                   self.company_state   := right.st,
                                   self.company_zip     := right.z5 + 
														                                 if(right.z4<>'',
																												        '-' + right.z4,''),
                                   self.bdid         := if(left.bdid<>0,left.bdid,
																	                                      right.bdid),
																	 self.from_gong    := true,
																	 //rest of fields from left
								                   self              := left),
																 inner,
					                       keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																 limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 9.3 Join the phone#s with comp info from gong history back to the dataset of 
	//     all records that have been cleaned.
  ds_all_recs_gongcomp := join(ds_all_recs_cleaned_projtd, ds_all_phone1_gongcomp,
				                         left.company_phone1 = right.company_phone1,
                               transform(WorkPlace_Layouts.poe_didkey_slimmed,
																  // store gong comp name/address/bdid from right
																	self.company_name    := if(right.from_gong,right.company_name,
																	                                           left.company_name),
																  self.company_address := if(right.from_gong,right.company_address,
																	                                           left.company_address),
														      self.company_city    := if(right.from_gong,right.company_city,
																	                                           left.company_city),
                                  self.company_state   := if(right.from_gong,right.company_state,
																	                                           left.company_state),
                                  self.company_zip     := if(right.from_gong,right.company_zip, 
																	                                           left.company_zip),
																	self.bdid            := if(right.from_gong and left.bdid=0,
																	                                           right.bdid,left.bdid),
                                  // rest of the fields, keep the ones from the left ds
                                  self := left),
											         left outer,  // keep all the recs from the left ds
												       atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));

	// 10.  Get the current phone# for the bdid from the EDA/gong history bdid key file
	//      or if not found in the gong file, get it from the Yellow Pages bdid key file.
	//      Then store it into company_phone2 if POE company_phone1 exists;   
	//      otherwise store it into comp phone1. Keep phone numbers which do not exist in PSS or which satisfy the criteria
	//
	// 10.1 Sort/dedup on non-zero bdids to reduce the number of lookups against the gong key.
	ds_all_bdids_deduped := dedup(sort(ds_all_recs_gongcomp(bdid<>0), bdid), bdid);

  // 10.2 Join the ds unique non-zero bdids with the gong history bdid key file 
	//      to get the phone#.
	ds_all_bdids_gongphone := join(ds_all_bdids_deduped, gong.Key_History_BDID,
				                           keyed(left.bdid=right.bdid)     and 
																   //we only want current data
																   right.current_record_flag = BatchServices.WorkPlace_Constants.GONG_HIST_CURRENT and
																	 //we only want businesses
				                           right.listing_type_bus    = BatchServices.WorkPlace_Constants.GONG_HIST_BUSINESS and 
																	 // Also match on city name since some bdids have 
																	 // multiple current phone#s for different locations
																	 left.company_city = right.p_city_name,
                                 transform(WorkPlace_Layouts.poe_didkey_slimmed,
																	 self.company_phone2 := right.phone10,
																	 self                := left),
											           inner,
															   keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
																 limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 10.3 Join the bdids with a gong phone# back to the ds of poe key did records with 
	//      gong company info added.
	ds_all_recs_gongphone := join(ds_all_recs_gongcomp, ds_all_bdids_gongphone,
				                          left.bdid=right.bdid,
                                transform(WorkPlace_Layouts.poe_didkey_slimmed,
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
												        atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 10.4 If no gong phone found, try getting phone# from the yellow pages. 
	//      Sort/dedup on non-zero bdids and empty phone2 to reduce the number
	//      of lookups against the yellow pages key bdid file.
  ds_all_bdids_nogong := dedup(sort(ds_all_recs_gongphone(bdid!=0 and company_phone2=''), 
	                                  bdid), bdid);

  // 10.5 Join the ds of unique non-zero bdids with no phone2 with the YellowPages
	//     bdid key file, to get the yellow pages phone#.
	ds_all_bdids_ypphone := join(ds_all_bdids_nogong, YellowPages.Key_YellowPages_BDID,
				                         keyed(left.bdid=right.bdid),
                               transform(WorkPlace_Layouts.poe_didkey_slimmed,
																 self.company_phone2 := right.phone10,
																 self                := left),
											         inner,
															 keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
															 limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 10.6 Join the bdids with yp phone# back to the ds of poe key did records with
	//      gong phone# added.
  ds_all_recs_ypphone  := join(ds_all_recs_gongphone, ds_all_bdids_ypphone,
				                        left.bdid=right.bdid,
                              transform(WorkPlace_Layouts.poe_didkey_slimmed,
															  // store yp phone into phone1 (if empty) or in phone2 (if not same as phone1)
																// phone1 may be from poe or best or gong, so keep it if not empty
																self.company_phone1 := if(left.company_phone1!='', 
																	                        left.company_phone1,right.company_phone2),
                                // phone2 may be from best or gong, so keep it if not empty
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
												      atmost(WorkPlace_Constants.Limits.JOIN_LIMIT)
														 );


	// 10.7 Show only phone numbers which do not exist in PSS or that match the criteria of phone status = A and is in the 30 day window
	// Check company phone1 to see if it fits the criteria for valid phone
	BatchServices.WorkPlace_Layouts.poe_didkey_slimmed	tSuppressPhone1(ds_all_recs_ypphone	le,PSS.Keys().BDID_Phone.QA	ri)	:=
	transform
		self.company_phone1	:=	if(	le.bdid	=	ri.bdid	and	le.company_phone1	=	ri.response_company_phone,
																if(	ri.response_phone_status	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																		le.company_phone1,
																		''
																	),
																le.company_phone1
															);
		self								:=	le;
	end;
	
	dSuppressBadPhone1	:=	join(	ds_all_recs_ypphone,
																PSS.Keys().BDID_Phone.QA,
																keyed(left.bdid						=	right.bdid)	and
																keyed(left.company_phone1	=	right.response_company_phone),
																tSuppressPhone1(left,right),
																left outer,
																limit(WorkPlace_Constants.Limits.JOIN_LIMIT)
															);
	
	// Check company phone2 to see if it fits the criteria for valid phone
	BatchServices.WorkPlace_Layouts.poe_didkey_slimmed	tSuppressPhone2(dSuppressBadPhone1	le,PSS.Keys().BDID_Phone.QA	ri)	:=
	transform
		self.company_phone2	:=	if(	le.bdid	=	ri.bdid	and	le.company_phone2	=	ri.response_company_phone,
																if(	ri.response_phone_status	in	BatchServices.WorkPlace_Constants.PSS_PHONE_STATUS	and	ut.DaysApart(todays_date,(string8)ri.dt_vendor_last_reported)	<=	BatchServices.WorkPlace_Constants.PSS_DAYS_WINDOW,
																		le.company_phone2,
																		''
																	),
																le.company_phone2
															);
		self								:=	le;
	end;
	
	dSuppressBadPhone2	:=	join(	dSuppressBadPhone1,
																PSS.Keys().BDID_Phone.QA,
																keyed(left.bdid						=	right.bdid)	and
																keyed(left.company_phone2	=	right.response_company_phone),
																tSuppressPhone2(left,right),
																left outer,
																limit(WorkPlace_Constants.Limits.JOIN_LIMIT)
															);
	
	// Move phone2 to phone1 if phone1 is empty
	dSuppressBadPhones	:=	project(	dSuppressBadPhone2,
																		transform(	BatchServices.WorkPlace_Layouts.poe_didkey_slimmed,
																								self.company_phone1	:=	if(left.company_phone1	!=	'',left.company_phone1,left.company_phone2);
																								self.company_phone2	:=	if(left.company_phone1	=	'','',left.company_phone2);
																								self								:=	left;
																							)
																	);
	
  // 11. Identify the 1 most complete/best candidate record to use for each did and 
	//     optionally keep up to 2 additional/history recs.
  //
	// 11.1 First filter to only use "complete" info recs, which according to the product
	//      specs are those records with a non-blank company_name and at least 1 non-blank 
	//      company phone.
	//      Also use "corp" source recs if that option was selected and use all
	//      other non-corp sources regardless of the IncludeCorp option.
  ds_most_complete_all	:=	dSuppressBadPhones(	company_name	<>	''	and	// need a comp name
																								company_phone1<>	''	and	// need a phone
																								(IncludeCorp	OR	~MDR.sourceTools.SourceIsCorpV2(source))	// include corp
																							);  // if not include corp, include all other sources

	// 11.2 Sort all complete records by:
	//      did, descending dt_last_seen & source_code order to 
	//      identify the "most current" record in source order for each did.
	ds_most_complete_srtd := sort(ds_most_complete_all,
	                              did, -dt_last_seen, source_order,record);

  // 11.3 Then dedup by did to only keep the 1 most current record for each did.
  ds_most_current1 := dedup(ds_most_complete_srtd, did);

  // 11.4.1 Match all complete recs for a did to the most current one for a did to keep 
	//        any recs for a did that have the same bdid/company name & phone1 as the 
	//        most current one and are within 14 days of the most current dt_last_seen.
  ds_best_recs_for_did := join(ds_most_complete_srtd,ds_most_current1,
	                             left.did = right.did                            and 
	                             // check for bdids the same in case company names are slightly different
	                             ((left.bdid !=0 and left.bdid = right.bdid) or
													      left.company_name = right.company_name)        and
													     // phone1 values have to be the same
	                             left.company_phone1 = right.company_phone1      and
													     // dt_last_seen values have to be within 14 days
	                             ut.DaysApart((string8) left.dt_last_seen, (string8) right.dt_last_seen)
													        <= BatchServices.WorkPlace_Constants.DAYS_WINDOW,
													     transform(WorkPlace_Layouts.poe_didkey_slimmed,
															   self := left),
													     inner, // only keep recs from left that match right on join conditions
												       limit(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 11.4.2 Sort the best recs for a did in ascending source_order and then 
	//        dedup to only keep the 1 best candidate (lowest source_order) for the did.
	ds_best1_for_did := dedup(sort(ds_best_recs_for_did,
	                               did, source_order, -dt_last_seen, record), did);

  // 11.5 Get optional corp status info for the 1 best rec for each did.
	//
	// 11.5.1 If IncludeCorpInfo option was set on:
	//        1. sort/dedup on non-zero bdids (to reduce the number of lookups),
	//        2. then project onto appropriate layout and 
	//        3. call a function to get the status.
  ds_best1_for_did_bdids_cs := if(IncludeCorp,
	                                  WorkPlace_Functions.getCorpStatus(
																	    dedup(sort(project(ds_best1_for_did(bdid!=0), 
																			                   doxie_cbrs.layout_references), 
																								 bdid), bdid)),
																		//else output an empty ds 
																    dataset([], WorkPlace_Layouts.bdids_corpstat));
  
  // 11.5.2 Join the bdids with a corp status back to the ds of 1 bestfor did records 
	//        to attach the corp status to them.
	ds_best1_for_did_wcs := join(ds_best1_for_did, ds_best1_for_did_bdids_cs,
				                         left.bdid=right.bdid,
                               transform(WorkPlace_Layouts.poe_didkey_slimmed,
													       // only take corp/company status from right
													       self.company_status := right.corp_status_desc,
                                 // Rest of the fields, keep the ones from the left ds
                                 self             := left),
											         left outer,  // keep all the recs from the left ds
												       atmost(WorkPlace_Constants.Limits.JOIN_LIMIT)); 

  // 11.6 Get optional additional/history info
	//
  // 11.6.1 If optional include additional (history) was set on, filter out:
	//        1. recs for any royalty sources because they are not to be included.
  ds_most_complete_fltrd := if(IncludeAddl,
	                             ds_most_complete_srtd(source not in WorkPlace_Constants.WP_ROYALTY_SOURCE_SET),
															 // else output an empty ds											 
                               dataset([], WorkPlace_Layouts.poe_didkey_slimmed));

  // 11.6.2 Next sort/dedup the filtered recs to only keep the recs with a  
	//        unique company_name for each did
  ds_most_complete_unique := dedup(sort(ds_most_complete_fltrd,
		                                    did, company_name, -dt_last_seen, source_order, record),
	                                 did, company_name);

  // 11.6.3 Next do a left only join to remove the best rec for each did  
	//        from the ds with all the potential additional/history recs.
  ds_most_complete_addl := join(ds_most_complete_unique,ds_best1_for_did,
	                                  left.did              = right.did and 
															      left.dt_last_seen     = right.dt_last_seen and 
															      left.source_order     = right.source_order,  
															    transform(WorkPlace_Layouts.poe_didkey_slimmed,
															      self := left),
															    left only, // keep left recs with no match in right ds
															    atmost(WorkPlace_Constants.Limits.JOIN_LIMIT)
												         );

  // 11.6.4 Next sort/dedup the remaining recs to keep the 2 next most current recs 
	//        for each did.
  ds_addl_2recs := dedup(sort(ds_most_complete_addl,
		                          did, -dt_last_seen, source_order, record),
	                       did, dt_last_seen, source_order,
	                       KEEP(WorkPlace_Constants.Limits.KEEP_HIST));


  // 11.7 Get optional corp status info for the history recs.
	//
	// 11.7.1 If IncludeCorpInfo option was set on:
	//        1. sort/dedup on non-zero bdids (to reduce the number of lookups),
	//        2. then project onto appropriate layout and 
	//        3. call a function to get the status.
  ds_addl_2recs_bdids_corpstat := if(IncludeCorp,
	                                  WorkPlace_Functions.getCorpStatus(
																	    dedup(sort(project(ds_addl_2recs(bdid!=0), 
																			                   doxie_cbrs.layout_references), 
																								 bdid), bdid)),
																		//else output an empty ds 
																    dataset([], WorkPlace_Layouts.bdids_corpstat));

  // 11.7.2 Join the bdids with a corp status back to the ds of addl/hist records 
	//        to attach the corp status to them.
	ds_addl_2recs_wcorpstat := join(ds_addl_2recs, ds_addl_2recs_bdids_corpstat,
				                            left.bdid=right.bdid,
                                  transform(WorkPlace_Layouts.poe_didkey_slimmed,
													          // only take status from right
													          self.company_status := right.corp_status_desc,
                                    // Rest of the fields, keep the ones from the left ds
                                    self             := left),
											            left outer,  // keep all the recs from the left ds
												          atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));


 	// 11.7.3 Combine up to 2 addl/hist recs for each did into a single layout to assist
	//        in joining later.
  WorkPlace_Layouts.addl_info_slimmed 
	        xform_roll_addl(WorkPlace_Layouts.poe_didkey_slimmed L,
					                dataset(WorkPlace_Layouts.poe_didkey_slimmed) RL) := transform
		self.did                       := L.did;
	  self.addl_wpl_bdid_1           := (string) L.bdid; 
    self.addl_wpl_comp_name_1      := L.company_name;
		self.addl_wpl_comp_address1_1  := L.company_address;
    self.addl_wpl_comp_city_1      := L.company_city;
    self.addl_wpl_comp_state_1     := L.company_state;
    self.addl_wpl_comp_zip_1       := L.company_zip;
    self.addl_wpl_phone1_1         := L.company_phone1; 
    self.addl_wpl_phone2_1         := L.company_phone2; 
		self.addl_wpl_status_1         := L.company_status; 
    self.addl_wpl_last_seen_date_1 := (string) L.dt_last_seen;
	  self.addl_wpl_bdid_2           := (string) RL[2].bdid; 
    self.addl_wpl_comp_name_2      := RL[2].company_name;
		self.addl_wpl_comp_address1_2  := RL[2].company_address;
    self.addl_wpl_comp_city_2      := RL[2].company_city;
    self.addl_wpl_comp_state_2     := RL[2].company_state;
    self.addl_wpl_comp_zip_2       := RL[2].company_zip;
    self.addl_wpl_phone1_2         := RL[2].company_phone1; 
    self.addl_wpl_phone2_2         := RL[2].company_phone2;
    self.addl_wpl_status_2         := RL[2].company_status;
    self.addl_wpl_last_seen_date_2 := (string) RL[2].dt_last_seen;
	end;
	
  ds_addl_combined := rollup(group(sort(ds_addl_2recs_wcorpstat,
	                                      did,-dt_last_seen, source_order, record),
																	 did),
														 group,
														 xform_roll_addl(left,rows(left)));

  // 12. Get the detailed POE indivdual source data for each 1 best for did record.
  //
  // 12.1 Split the best candidate records that need some additional source specific
	//      data added, by first filtering on source.
  ds_recs_spoke     := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsSpoke(source));
  ds_recs_zoom      := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsZoom(source));
  ds_recs_corp      := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsCorpV2(source));
  ds_recs_poeemail  := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsEmail(source));
	ds_recs_oneclick  := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsOne_Click_Data(source));
	ds_recs_saleschannel   := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsSalesChannel(source));
	ds_recs_thrive    := ds_best1_for_did_wcs(MDR.sourceTools.SourceIsThrive_LT(source) or
	                                          MDR.sourceTools.SourceIsThrive_PD(source));


  // If it not one of the specific sources above, keep all those recs together.
  ds_recs_others := ds_best1_for_did_wcs(~MDR.sourceTools.SourceIsSpoke(source)  and
	                                       ~MDR.sourceTools.SourceIsZoom(source)   and
									  							       ~MDR.sourceTools.SourceIsCorpV2(source) and
																				 ~MDR.sourceTools.SourceIsEmail(source)  and
	                                       ~MDR.sourceTools.SourceIsOne_Click_Data(source) and
																				 ~MDR.sourceTools.SourceIsSalesChannel(source) and
																				 ~MDR.sourceTools.SourceIsThrive_LT(source)    and
	                                       ~MDR.sourceTools.SourceIsThrive_PD(source)
                                        );

  //NOTE: For the individual source did key file joins below (except corp), we can't
	//      additionally match on bdid because of the delay between the individual
	//      product update and business header update when assigning a new bdid.
	//
	// 12.2.1 Get the detailed data from the Spoke key did file.
	ds_detail_spoke := join(ds_recs_spoke,spoke.keys().did.qa,
                            keyed(left.did = right.did) and 
													  // Match on additional field in case multiple recs for the did
													  left.dt_last_seen = right.dt_last_seen,
	                        transform(WorkPlace_Layouts.final,
														// fields from right spoke did key file, see spoke.layouts.keybuild
														self.company_description := right.rawfields.Company_Business_Description,
											      // rest of the fields from the left (POE payload) converting some
														self.did            := (string) left.did,
														self.company_bdid   := (string) left.bdid,
                            self.date_last_seen := (string) left.dt_last_seen,
                            self                := left), 
													left outer,
													keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
													limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	// 12.2.2 Get the detailed data from the Zoom key did file.
	ds_detail_zoom := join(ds_recs_zoom,zoom.keys().did.qa,
                           keyed(left.did = right.did) and 
												   // match on additional field in case multiple recs for the did
												   left.dt_last_seen = right.dt_last_seen,
	                       transform(WorkPlace_Layouts.final,
														// fields from right zoom did key file, see zoom.layouts.keybuild
                            self.email1         := if(includeEmail,right.rawfields.email_address,''),
														SELF.email_src1			:= if(includeEmail AND RIGHT.rawfields.email_address <>'',LEFT.SOURCE,''),
														// rest of the fields from the left (POE payload) converting some
														self.did            := (string) left.did,
														self.company_bdid   := (string) left.bdid,
                            self.date_last_seen := (string) left.dt_last_seen,														
                            self                := left), 
													left outer,
													keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
													limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


	// 12.2.4 Get the detailed data from the Corp2 key cont corp_key file.
	//        First use bdid to look up the corp_key on the corp2::qa::cont::bdid key file.
	//        Then use the corp_key to look up POE related person & company info on 
	//        the corp2::qa::cont::corp_key.record_type key file.
	ds_recs_corpkey := join(ds_recs_corp,corp2.keys().cont.bdid.qa,
	                          keyed(left.bdid = right.bdid),
													transform(WorkPlace_Layouts.poe_didkey_slimmed,
													  self.corp_key := right.corp_key, //only keep corp_key from right 
														self          := left),  // keep all poe slimmed fields
													left outer,
													keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
													limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	ds_detail_corp := join(ds_recs_corpkey,corp2.keys().cont.corpkey.qa,
                           keyed(left.corp_key = right.corp_key and
													       right.record_type = 'C') and // only want current info
												 // match on additional fields in case of multiple current
												 // records for the corp_key
												 left.bdid         = right.bdid and
												 left.did          = right.did,
	                       transform(WorkPlace_Layouts.final,
												   // fields from corp2 cont corp_key key file, see Corp2.Layout_Corporate_Direct_Cont_Base
                           self.email1               := if(includeEmail, 
														                               if(right.corp_email_address<>'',
																													    right.corp_email_address,
																													    if(right.cont_email_address<>'',
																													       right.cont_email_address,
																																 '')),
																													 ''),
                           self.email_src1               := IF(includeEmail AND (RIGHT.corp_email_address<>'' OR RIGHT.cont_email_address<>''), 
																															 LEFT.SOURCE,
																														   ''),
                           self.email2               := if(includeEmail,
														                               if(right.corp_email_address<>'',
																													    right.cont_email_address,
																															''),
																													 ''),
											     self.email_src2               := IF(includeEmail AND RIGHT.corp_email_address<>'', 
																															 LEFT.SOURCE,
																														   ''),
																													 
											     // rest of the fields from the left (POE did key) converting some
													 self.did            := (string) left.did,
													 self.company_bdid   := (string) left.bdid,
                           self.date_last_seen := (string) left.dt_last_seen,
                           self                := left), 
												 left outer,
												 keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
												 limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


  // 12.2.5 Get the detailed data from the poesfromemails did key file.
	ds_detail_poeemail := join(ds_recs_poeemail,POEsFromEmails.keys().did.qa,
                               keyed(left.did = right.did) and 
												       // match on additional field in case multiple recs for the did 
												       left.dt_last_seen = right.date_last_seen,
	                           transform(WorkPlace_Layouts.final,
														   // fields from right POEsFromEmails did key file, see POEsFromEmails.layouts.keybuild
                               self.email1 := if(includeEmail,right.clean_email,''),
                               SELF.email_src1 := IF(includeEmail AND RIGHT.clean_email <>'',RIGHT.email_src,''),
														   // rest of the fields from the left (POE slimmed) converting some
														   self.did            := (string) left.did,
														   self.company_bdid   := (string) left.bdid,
                               self.date_last_seen := (string) left.dt_last_seen,
                               self                := left), 
												     left outer,
													   keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
													   limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	// 12.2.6 Get the detailed data from the One_Click key did file.
	ds_detail_oneclick := join(ds_recs_oneclick,one_click_data.keys().did.qa,
                               keyed(left.did = right.did) and 
														   // match on additional field in case multiple recs for the did
															 left.dt_last_seen = right.dt_last_seen,
	                           transform(WorkPlace_Layouts.final,
														   // fields from oneclick did key file, see oneclick_data.layouts.keybuild
                               self.email1         := if(includeEmail,right.rawfields.EmailAddress,''),
                               SELF.email_src1     := IF(includeEmail AND RIGHT.rawfields.EmailAddress <>'',LEFT.SOURCE,''),
											         // rest of the fields from the left (POE did key) converting some
														   self.did            := (string) left.did,
														   self.company_bdid   := (string) left.bdid,
                               self.date_last_seen := (string) left.dt_last_seen,
                               self                := left), 
														 left outer, // keep rec from left if no match to right
														 keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
														 limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));

	// 12.2.8 Get the detailed data from the Sales Channel key did file.
	ds_detail_saleschannel := join(ds_recs_saleschannel, SalesChannel.keys().did.qa, 
                               keyed(left.did = right.did) and
																left.dt_last_seen = right.date_last_seen and
																left.bdid = right.bdid,
	                           transform(WorkPlace_Layouts.final,
														   // fields from sales channel did key file
                               self.email1         := if(includeEmail,right.rawfields.email,''),
															 SELF.email_src1     := IF(includeEmail AND RIGHT.rawfields.email<>'',LEFT.SOURCE,''),
														   self.did            := (string) left.did,
														   self.company_bdid   := (string) left.bdid,
                               self.date_last_seen := (string) left.dt_last_seen,
                               self                := left), 
														 left outer, // keep rec from left if no match to right
														 keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
														 limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));	

	// 12.2.9 Get the detailed data from the Thrive key did file.
	ds_detail_thrive := join(ds_recs_thrive,thrive.keys().did.qa,
                           keyed(left.did = right.did) and 
												   // match on additional field in case multiple recs for the did
												   left.dt_last_seen = right.dt_last_seen,
	                       transform(WorkPlace_Layouts.final,
														// fields from right thrive did key file, see thrive.layouts.base
                            self.email1         := if(includeEmail,right.Email,''),
														SELF.email_src1 := IF(includeEmail AND RIGHT.Email <>'',RIGHT.src,''),
														// rest of the fields from the left (POE payload) converting some
														self.did            := (string) left.did,
														self.company_bdid   := (string) left.bdid,
                            self.date_last_seen := (string) left.dt_last_seen,														
                            self                := left), 
													left outer,
													keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
													limit(WorkPlace_Constants.Limits.KEYED_JOIN_UNLIMITED));


  // 12.2.10 Project all the others that don't need additional source specific data
	//         to put all recs into the same layout and convert 3 fields.
	ds_detail_others := project(ds_recs_others,
	                            transform(WorkPlace_Layouts.final,
														    // fields from the left (POE slimmed) converting some
														    self.did            := (string) left.did,
														    self.company_bdid   := (string) left.bdid,
                                self.date_last_seen := (string) left.dt_last_seen,
                                self                := left)
														 );

	// 12.3 Combine all source detail recs into 1 dataset.
  ds_detail_all := ds_detail_spoke
	                 + ds_detail_zoom  
									 + ds_detail_corp 
									 + ds_detail_poeemail
									 + ds_detail_oneclick
									 + ds_detail_saleschannel
									 + ds_detail_thrive
									 + ds_detail_others;

									 
  // 13. Get parent company info.

  // NOTE: In DCA, the root-sub expression is a compound value: 
	// the root (nine digits), followed by a dash, followed by the sub(sidiary) value
	// (four digits). e.g. 123456789-1234. 
	// The root denotes the top-level company at the head of a conglomerate or set of 
	// subsidiaries. e.g. LexisNexis RiskSolution's root is Reed-Elsevier. 
	// The sub is simply a surrogate identifier denoting a particular subsidiary in the 
	// root's tree. 
	// Therefore in the code below you'll see the expression:
  //     left.parent_number[1..9]  = right.root AND
  //     left.parent_number[11..14] = right.sub
  // Where [1..9] refers to the root portion of the parent_number and [11..14] refers 
	// to the sub portion of the parent_number. We omit [10] of course, which is a dash.
  //
  // 13.1 Sort/dedup on bdid. 
  ds_detail_bdids_deduped := dedup(sort(ds_detail_all,company_bdid),company_bdid);

  // 13.2 First for the deduped bdids, get the level, root, sub & parent_number info
	// from the DCA bdid key file.
	ds_bdids_dca_added := join(ds_detail_bdids_deduped,DCA.Key_DCA_BDID,
			                         keyed((unsigned6) left.company_bdid = right.bdid),
			                       transform(WorkPlace_Layouts.dca_info,
														   // take certain DCA fields from right dca key bdid file
                               self.bdid          := right.bdid, 
				                       self.level         := right.level,
												       self.root          := right.root,
												       self.sub           := right.sub,
												       self.parent_number := right.parent_number),
			                       inner,
														 keep(WorkPlace_Constants.Limits.KEEP_LIMIT),
														 limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 13.3.1 Next get parent company info for each bdid with a non-blank DCA root value.
  ds_parents1 := doxie_cbrs.get_DCA_records(project(ds_bdids_dca_added(root != ''),
	                                                 doxie_cbrs.layout_references), 
	                                         WorkPlace_Constants.DCA_RETREIVE_PARENT);

  // 13.3.2 Sort/dedup by root&sub since doxie_cbrs.get_DCA_records can return > 1 record 
	//        with the same root&sub, but different parent_numbers.
	//        (Which happened on 02/15/12 in RQ bug 97312).
	ds_parents := dedup(sort(ds_parents1,root,sub,record),root,sub);

  // 13.4 Next attach the parent company info to the bdids with DCA data.
	ds_bdids_wparent := join(ds_bdids_dca_added, ds_parents,
		                         left.parent_number[1..9]  = right.root AND
													   // NOTE: position 10 = '-'; so it is skipped
		                         left.parent_number[11..14] = right.sub,
													 transform(WorkPlace_Layouts.dca_info,
														 // Get parent company fields from right file
														 self.parent_company_bdid    := if(right.bdid<>0,(string) right.bdid,'');
		                         self.parent_company_name    := StringLib.StringToUpperCase(right.Name),
			                       self.parent_company_address := Address.Addr1FromComponents(
														                                right.prim_range,
                                                            right.predir,
                                                            right.prim_name,
                                                            right.addr_suffix,
                                                            right.postdir,
                                                            right.unit_desig,
                                                            right.sec_range),
														 self.parent_company_city    := right.p_city_name,
                             self.parent_company_state   := right.st,
                             self.parent_company_zip     := right.z5 + 
														                                if(right.zip4<>'',
																									             '-' + right.zip4,''),
			                       self.parent_company_phone   := right.phone,
													   // Keep rest of data from left file
			                       self                     := left),
													 inner, 
													 LIMIT(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 13.5 Join the detail_all file with the file containing DCA parent company info
	//        matching on bdid. 
	ds_detail_wparent := join(ds_detail_all,ds_bdids_wparent,
		                         (unsigned6) left.company_bdid = right.bdid,
													 transform(WorkPlace_Layouts.final,
													   // Copy parent comp info from bdids_with_parent ds
 														 self.parent_company_bdid    := (string) right.parent_company_bdid,
														 self.parent_company_name    := right.parent_company_name,
                             self.parent_company_address := right.parent_company_address,
                             self.parent_company_city    := right.parent_company_city,
                             self.parent_company_state   := right.parent_company_state,
                             self.parent_company_zip     := right.parent_company_zip,
                             self.parent_company_phone   := right.parent_company_phone,
	 			                     // keep rest of info from left
														 self                        := left),
													 left outer,  // keep all the recs from the left ds
													 atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));


  // 13.6 Get optional corp status info for the parent company.
	//
	// 13.6.1 If IncludeCorpInfo option was set on:
	//        1. sort/dedup on non-zero parent co bdids (to reduce the number of lookups),
	//        2. then project onto appropriate layout and 
	//        3. call a function to get the status.
  ds_parent_bdids_corpstat := if(IncludeCorp,
	                               WorkPlace_Functions.getCorpStatus(
																	    dedup(sort(project(ds_detail_wparent(parent_company_bdid<>''), 
																			                   transform(doxie_cbrs.layout_references,
																							             self.bdid :=(unsigned6) left.parent_company_bdid)),
																			           bdid), bdid)),
																 //else output an empty ds 
																 dataset([], WorkPlace_Layouts.bdids_corpstat));
  
  // 13.6.2 Join the parent co bdids with a corp status back to the ds of detail with
	//        parent co info to attach the corp status for the parent co.
	ds_detail_wpar_corpstat := join(ds_detail_wparent, ds_parent_bdids_corpstat,
				                            (unsigned6) left.parent_company_bdid = right.bdid,
                                  transform(WorkPlace_Layouts.final,
													          // only take status from right
 														        self.parent_company_status := right.corp_status_desc,
                                    // Rest of the fields, keep the ones from the left ds
                                    self             := left),
											            left outer,  // keep all the recs from the left ds
												          atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));


  // 15 Get any Professional License data.
	//
	// 15.1 First get all the prof lic recs (if any exist) for each did.
	ds_prolic_data := join(ds_detail_wpar_corpstat,Prof_LicenseV2.Key_Proflic_Did(),
                           keyed((unsigned6) left.did = right.did),
	                       transform(WorkPlace_Layouts.prolic,
													 // first take did only from the left to keep in string format
                           self.did := left.did, 
													 // take other 3 fields from right ProfLic key did file
                           self     := right),
												 left outer, // keep all the recs from the left ds
												 atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 15.2 Then sort by did and descending dt_last_seen (puts most current first).
  //      Then dedup by the dt_last_seen to identify the most current record.
  ds_prolic_deduped := dedup(sort(ds_prolic_data,did,-date_last_seen),did);

	// 15.3 Finally join the ds of detail recs to the deduped pl data recs.
	ds_detail_wprolic := join(ds_detail_wpar_corpstat,ds_prolic_deduped ,
                            left.did = right.did,
	                          transform(WorkPlace_Layouts.final,
															// take 2 prof lic fields in output layout from right
                              self.prof_license        := right.license_type,
                              self.prof_license_status := right.status,
														  // keep the rest of the fields from the left
                              self                     := left), 
												    left outer,  // keep all the recs from the left ds
													  atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));


  // 16. Get optional email info
  //
	// 16.1 Get all email records for each did from the email key did file.
  ds_email_data := if(IncludeEmail,
	                    join(ds_detail_wprolic,Email_Data.Key_Did,
                           keyed((unsigned6) left.did = right.did),
	                       transform(WorkPlace_Layouts.email,
													 // first take did only from the left to keep in string format
                           self.did := left.did, 
													 // take other fields from right email key did file
                           self     := right),
												 inner, // only ones in left & right
												 limit(WorkPlace_Constants.Limits.JOIN_LIMIT)),
											dataset([], WorkPlace_Layouts.email));

  // 16.2 First sort & dedup by did & email address to use only unique emails for each did.
	//      Then reseort by did & descending date-last-seen and then
	//      dedup by did to keep the (up to) 3 most current recs.
  ds_email_deduped := dedup(sort(dedup(sort(ds_email_data,
	                                          did,clean_email,-date_last_seen,record),
	                                     did,clean_email),
	                               did,-date_last_seen,record),
														did,KEEP(WorkPlace_Constants.Limits.KEEP_EMAIL));

 	// 16.3 Combine up to 3 email recs for each did into a single layout to assist
	//      in joining later.
  WorkPlace_Layouts.email_combined 
	        xform_roll_email(WorkPlace_Layouts.email L,
					                dataset(WorkPlace_Layouts.email) RL) := transform
   	self.did                   := L.did;
		self.email_address1        := L.clean_email;
		self.email_address2        := RL[2].clean_email;
		self.email_address3        := RL[3].clean_email;
		SELF.email_src1			   := L.email_src;
		SELF.email_src2			   := RL[2].email_src;
		SELF.email_src3			   := RL[3].email_src;
	end;
	
  ds_email_combined := rollup(group(ds_email_deduped,did),
														  group,
														  xform_roll_email(left,rows(left)));

	// 16.4 Finally join the ds of detail recs to the deduped/combined email recs, 
	//      preferring any emails from the individual source detail files which are 
	//      in the left dataset.
	
	uc(string x) := StringLib.StringToUpperCase(x);
	
	ds_detail_wemail := join(ds_detail_wprolic,ds_email_combined,
                            left.did = right.did,
	                          transform(WorkPlace_Layouts.final,
															// take email field from right for any not already filled in.
															// first store into temp fields to be used later
															temp_email1 := if (left.email1<>'',
															                   uc(left.email1),
																								 uc(right.email_address1));
													    self.email1 := temp_email1,
															SELF.email_src1 := IF(left.email1<>'', LEFT.email_src1, RIGHT.email_src1);
                              temp_email2 := if (left.email2<>'',
															                   uc(left.email2),
																								 if(uc(right.email_address1)<>uc(temp_email1),
																								    uc(right.email_address1),
																										if(uc(right.email_address2)<>uc(temp_email1),
																										   uc(right.email_address2),'')));
														  self.email2 := temp_email2,														
															SELF.email_src2 := IF(LEFT.email2<>'',
																										LEFT.email_src2,
																											CASE(temp_email2, 
																													 uc(RIGHT.email_address1)=> RIGHT.email_src1,
																													 uc(RIGHT.email_address2)=> RIGHT.email_src2,
																								  				 ''));
                              temp_email3 := if (left.email3<>'',
															                   uc(left.email3),
																								 if(uc(right.email_address1)<>uc(temp_email1) AND
																								    uc(right.email_address1)<>uc(temp_email2),
																								    uc(right.email_address1),
																									  if(uc(right.email_address2)<>uc(temp_email1) AND
																								       uc(right.email_address2)<>uc(temp_email2),
																								       uc(right.email_address2),
																									     if(uc(right.email_address3)<>uc(temp_email1) AND
																								          uc(right.email_address3)<>uc(temp_email2),
																											 uc(right.email_address3),''))));
															self.email3 := temp_email3,
															SELF.email_src3 := IF(LEFT.email3<>'',
																									 LEFT.email_src3,
																									 CASE(temp_email3,
																												uc(RIGHT.email_address1)=> RIGHT.email_src1,
																												uc(RIGHT.email_address2)=> RIGHT.email_src2,
																												uc(RIGHT.email_address3)=> RIGHT.email_src3,
																												''));
														  // keep the rest of the fields from the left
                              self        := left), 
												    left outer,  // keep all the recs from the left ds
													  atmost(WorkPlace_Constants.Limits.JOIN_LIMIT));


  // 17. Split detail records with extra info into separate subject and spouse datasets.
	//
	// 17.1 Join all the detail recs with parent co info, prof lic & email info added to 
	//      the subject dids to create subject only records.
	ds_detail_subject := join(ds_subject_dids,ds_detail_wemail,
	                            left.lookupdid = (unsigned6) right.did,
														transform(WorkPlace_Layouts.final,
														  self := right),
                            inner, // keep only recs that exist on both left & right
											      limit(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 17.2 If include additional (history) was choosen, join the saved additional/history 
	//      recs to the detail subject recs on did.
	//      Only subject recs will have additional info, not spouse recs.
	ds_detail_subj_waddl := if(IncludeAddl,
	                           join(ds_detail_subject,ds_addl_combined,
														        left.did = (string) right.did,
																	transform(WorkPlace_Layouts.final,
																		// assign hist fields from right
																		self.did := left.did,
																	  self := right,
																		// assign rest of fields from left
																		self := left),
																	left outer, // keep all recs from left whether they have hist or not
																	limit(WorkPlace_Constants.Limits.JOIN_LIMIT)
																	),
														 ds_detail_subject); // else just use det subject ds as it is.

 	// 17.3 Join all the detail recs with parent co info, prof lic & email info added to 
	//      the spouse dids to create spouse only records.
	ds_detail_spouse := join(ds_spouse_dids,ds_detail_wemail,
	                            left.lookupdid = (unsigned6) right.did,
														transform(WorkPlace_Layouts.final,
															self.did                    := (string) left.subjectDid,
															self.spouse_indicator       := 'Y',
			                        self.spouse_source          := right.source,
                              self.spouse_did             := right.did,
														  self.spouse_first_name      := right.subject_first_name,
                              self.spouse_last_name       := right.subject_last_name,
                              self.spouse_company_bdid    := right.company_bdid,
                              self.spouse_company_name    := right.company_name,
															self.spouse_company_address := right.company_address,
															self.spouse_company_city    := right.company_city,
                              self.spouse_company_state   := right.company_state,
                              self.spouse_company_zip     := right.company_zip,
                              self.spouse_company_phone1  := right.company_phone1,
	                            self.spouse_company_phone2  := right.company_phone2,
                              self.spouse_company_status  := right.company_status,
															self.spouse_parent_company_bdid    := right.parent_company_bdid,
                              self.spouse_parent_company_name    := right.parent_company_name,
                              self.spouse_parent_company_address := right.parent_company_address,
                              self.spouse_parent_company_city    := right.parent_company_city,
                              self.spouse_parent_company_state   := right.parent_company_state,
                              self.spouse_parent_company_zip     := right.parent_company_zip,
                              self.spouse_parent_company_phone   := right.parent_company_phone,
                              self.spouse_parent_company_status  := right.parent_company_status,
                              self.spouse_company_description    := right.company_description,
                              self.spouse_date_last_seen         := right.date_last_seen,
                              self.spouse_prof_license           := right.prof_license,
                              self.spouse_prof_license_status    := right.prof_license_status,
                              self.spouse_email1                 := right.email1,
                              self.spouse_email2                 := right.email2,
                              self.spouse_email3                 := right.email3,
															self.spouse_email_src1             := right.email_src1,
                              self.spouse_email_src2             := right.email_src2,
                              self.spouse_email_src3             := right.email_src3
															),
                            inner, // keep only recs that exist on both left & right
											      limit(WorkPlace_Constants.Limits.JOIN_LIMIT));
 
 
  // 18.1 Now join the detail subject recs back to the ds of all acctnos with one did to
	//      re-attach the acctnos to the dids and so that the same output results are returned
	//      if the same input criteria was entered more than once with different acctnos.
  ds_detail_subj_wacctno := join(ds_detail_subj_waddl,ds_acctnos_dids_good,
                                  left.did = (string) right.did,
	                               transform(WorkPlace_Layouts.final,
                                   // take orig acctno from right
                                   self.acctno := right.acctno,
																	 // take rest of the fields from the left
																	 self := left),
												         left outer,  // keep all form left
												         limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));

  // 18.2 Now join the detail spouse recs back to the ds of all acctnos with one did to
	//      re-attach the acctnos to the dids and so that the same output results are returned
	//      if the same input criteria was entered more than once with different acctnos.
  ds_detail_spos_wacctno := join(ds_detail_spouse,ds_acctnos_dids_good,
                                  left.did = (string) right.did,
	                               transform(WorkPlace_Layouts.final,
                                   // take orig acctno from right
                                   self.acctno := right.acctno,
																	 // take rest of the fields from the left
																	 self := left),
												         left outer,  // keep all form left
												         limit(WorkPlace_Constants.Limits.JOIN_LIMIT,skip));
 
  // 19.1 Sort detail subject with acctno in acctno order for joining below.
	//      Also dedup in case some prior join created more than 1 record for an  acctno.
	ds_detail_subj_wacctno_srtd := dedup(sort(ds_detail_subj_wacctno,acctno),acctno);
	
  // 19.2 Sort detail spouse with acctno in acctno order for joining below.
	//      Also dedup in case some prior join created more than 1 record for an acctno.
	ds_detail_spos_wacctno_srtd := dedup(sort(ds_detail_spos_wacctno,acctno),acctno);

  // 20. Next join the subject & spouse sorted datasets on acctno to combine  
	//     subject and optional spouse data for each acctno onto the same record.
	ds_detail_combined := join(ds_detail_subj_wacctno_srtd, ds_detail_spos_wacctno_srtd,
													     left.acctno = right.acctno,
	                           transform(WorkPlace_Layouts.final,
														     // Assign subject & spouse fields depending on the 
																 // input inlcude spouse options and existence of left
																 // (subject) or right (spouse) record for the acctno.
																 // Assign spouse fields first if the appropriate
																 // condition exists.
																 // NOTE: only assigning fields currently being used, 
																 // not any fields marked as "reserved for future use"
				                         boolean output_spouse := if(IncludeSpouseAlways or 
																                             (IncludeSpouseOnly and 
																														  left.did <> right.did),
																										         true,false);
			                           self.spouse_source          := if(output_spouse, right.spouse_source,''),
                                 self.spouse_did             := if(output_spouse, right.spouse_did,''),
														     self.spouse_first_name      := if(output_spouse, right.spouse_first_name,''),
                                 self.spouse_last_name       := if(output_spouse, right.spouse_last_name,''),
                                 self.spouse_company_bdid    := if(output_spouse, right.spouse_company_bdid,''),
                                 self.spouse_company_name    := if(output_spouse, right.spouse_company_name,''),
																 self.spouse_company_address := if(output_spouse, right.spouse_company_address,''),
																 self.spouse_company_city    := if(output_spouse, right.spouse_company_city,''),
                                 self.spouse_company_state   := if(output_spouse, right.spouse_company_state,''),
                                 self.spouse_company_zip     := if(output_spouse, right.spouse_company_zip,''),
                                 self.spouse_company_phone1  := if(output_spouse, right.spouse_company_phone1,''),
	                               self.spouse_company_phone2  := if(output_spouse, right.spouse_company_phone2,''),
                                 self.spouse_company_status  := if(output_spouse, right.spouse_company_status,''),
																 self.spouse_parent_company_bdid    := if(output_spouse, right.spouse_parent_company_bdid,''),
                                 self.spouse_parent_company_name    := if(output_spouse, right.spouse_parent_company_name,''),
                                 self.spouse_parent_company_address := if(output_spouse, right.spouse_parent_company_address,''),
                                 self.spouse_parent_company_city    := if(output_spouse, right.spouse_parent_company_city,''),
                                 self.spouse_parent_company_state   := if(output_spouse, right.spouse_parent_company_state,''),
                                 self.spouse_parent_company_zip     := if(output_spouse, right.spouse_parent_company_zip,''),
                                 self.spouse_parent_company_phone   := if(output_spouse, right.spouse_parent_company_phone,''),
                                 self.spouse_parent_company_status  := if(output_spouse, right.spouse_parent_company_status,''),
                                 self.spouse_company_description    := if(output_spouse, right.spouse_company_description,''),
                                 self.spouse_date_last_seen         := if(output_spouse, right.spouse_date_last_seen,''),
                                 self.spouse_prof_license           := if(output_spouse, right.spouse_prof_license,''),
                                 self.spouse_prof_license_status    := if(output_spouse, right.spouse_prof_license_status,''),
                                 self.spouse_email1                 := if(output_spouse, right.spouse_email1,''),
                                 self.spouse_email2                 := if(output_spouse, right.spouse_email2,''),
                                 self.spouse_email3                 := if(output_spouse, right.spouse_email3,''),
																 self.spouse_email_src1             := if(output_spouse, right.spouse_email_src1,''),
																 self.spouse_email_src2             := if(output_spouse, right.spouse_email_src2,''),
																 self.spouse_email_src3             := if(output_spouse, right.spouse_email_src3,''),
                                 // handle the case where there is only spouse (right) 
																 // and no subject (left) data.
			                           self.acctno := if(left.acctno<>'',left.acctno,right.acctno),
			                           self.did    := if(left.did<>'',left.did,right.did),
																 // assign subject fields from left
																 self        := left
													     ), 
												       full outer, // keep all the recs from the left & right ds
													     limit(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // 21. Finally, join the input ds to the sorted combined recs with all the output 
	//     data to put the input fields in the final output.
	ds_final_results       := join(ds_batch_in_caps, ds_detail_combined,
		                               left.acctno = right.acctno,
											           transform(WorkPlace_Layouts.final,
																	// Copy input fields to output layout
																	// input see doxie.layout_inBatchMaster
																	self.acctno      := left.acctno;
																	self.in_name_first  := left.name_first;
                                  self.in_name_middle := left.name_middle;
                                  self.in_name_last   := left.name_last;
                                  self.in_name_suffix := left.name_suffix;
                                  self.in_prim_range  := left.prim_range;
                                  self.in_predir      := left.predir;
                                  self.in_prim_name   := left.prim_name;
                                  self.in_addr_suffix := left.addr_suffix;
                                  self.in_postdir     := left.postdir;
                                  self.in_unit_desig  := left.unit_desig;
                                  self.in_sec_range   := left.sec_range;
                                  self.in_city_name   := left.p_city_name;
                                  self.in_st          := left.st;
                                  self.in_z5          := left.z5;
                                  self.in_zip4        := left.zip4;
                                  self.in_ssn         := left.ssn;
																	// rest of fields from right, converting some
			                            self.company_name         := stringlib.StringToUpperCase(right.company_name);
			                            self.parent_company_name  := stringlib.StringToUpperCase(right.parent_company_name);
                                  self.addl_wpl_comp_name_1 := stringlib.StringToUpperCase(right.addl_wpl_comp_name_1);
                                  self.addl_wpl_comp_name_2 := stringlib.StringToUpperCase(right.addl_wpl_comp_name_2);
																  self                := RIGHT),
														 inner, // only return input recs that had results
														 limit(WorkPlace_Constants.Limits.JOIN_LIMIT));

  // Uncomment lines below as needed for debugging
	//OUTPUT(IncludeSpouseAlways,      NAMED('ds_batch_ISA'));
	//OUTPUT(IncludeSpouseonly,        NAMED('ds_batch_ISO'));
	//OUTPUT(IncludeEmail,             NAMED('ds_batch_IE'));
	//OUTPUT(IncludeAddl,              NAMED('ds_batch_IA'));
	//OUTPUT(IncludeCorp,              NAMED('ds_batch_IC'));
 	//OUTPUT(in_excluded_sources,      NAMED('in_excluded_sources'));
 	//OUTPUT(in_excluded_sources_edited, NAMED('in_excluded_sources_edited'));
  //OUTPUT(ds_excluded_sources,      NAMED('ds_excluded_sources'));	
	//OUTPUT(ds_batch_in,              NAMED('ds_batch_in'));
	//OUTPUT(ds_batch_in_caps,         NAMED('ds_batch_in_caps'));
	//OUTPUT(ds_acctnos_dids_appended, NAMED('ds_acctnos_dids_appended'));
	//OUTPUT(ds_acctnos_dids_table,    NAMED('ds_acctnos_dids_table'));
  //OUTPUT(ds_acctnos_w1did,         NAMED('ds_acctnos_w1did'));
	//OUTPUT(ds_acctnos_dids_good,     NAMED('ds_acctnos_dids_good'));
	//OUTPUT(ds_dids_deduped,          NAMED('ds_dids_deduped'));
	//OUTPUT(ds_subject_dids,          NAMED('ds_subject_dids'));
  //OUTPUT(ds_dids_spousein,         NAMED('ds_dids_spousein'));
	//OUTPUT(ds_spouse_acctnos_dids,   NAMED('ds_spouse_acctnos_dids'));
	//OUTPUT(ds_spouse_dids_deduped,   NAMED('ds_spouse_dids_deduped'));
	//OUTPUT(ds_spouse_dids,           NAMED('ds_spouse_dids')); 
	//OUTPUT(ds_combined_dids_sorted,  NAMED('ds_combined_dids_sorted'));
  //OUTPUT(ds_poe_recs_slimmed,      NAMED('ds_poe_recs_slimmed'));
	//OUTPUT(dPSSResults,						 NAMED('dPSSResults'));
	//OUTPUT(dPSSResultsDedup,				 NAMED('dPSSResultsDedup'));
	
	//OUTPUT(ds_dids_for_best_in,      NAMED('ds_dids_for_best_in'));
	//OUTPUT(ds_best_outfile,          NAMED('ds_best_out'));
  //OUTPUT(ds_dids_ssns,             NAMED('ds_dids_ssns'));
  //OUTPUT(ds_dids_ssns_t,           NAMED('ds_dids_ssns_t'));

  //OUTPUT(ds_all_recs_slimmed,      NAMED('ds_all_recs_slimmed'));
  //OUTPUT(ds_all_recs_not_restricted, NAMED('ds_all_recs_not_restricted'));
	//OUTPUT(ds_all_recs_included,     NAMED('ds_all_recs_included'));
  //OUTPUT(ds_dids_pulled,           NAMED('ds_dids_pulled'));
  //OUTPUT(ds_ssns_pulled,           NAMED('ds_ssns_pulled'));
  //OUTPUT(ds_all_recs_pulled,       NAMED('ds_all_recs_pulled'));
  //OUTPUT(ds_all_recs_pulled_projtd,  NAMED('ds_all_recs_pulled_projtd'));
  //OUTPUT(ds_all_recs_bhbest_added,   NAMED('ds_all_recs_bhbest_added'));
	//OUTPUT(ds_all_recs_phones_cleaned, NAMED('ds_all_recs_phones_cleaned'));
  //OUTPUT(ds_all_recs_cname_cleaned,  NAMED('ds_all_recs_cname_cleaned'));
  //OUTPUT(ds_all_recs_cleaned_projtd, NAMED('ds_all_recs_cleaned_projtd'));
  //OUTPUT(ds_all_phone1_deduped,    NAMED('ds_all_phone1_deduped'));
	//OUTPUT(ds_all_phone1_gongcomp,   NAMED('ds_all_phone1_gongcomp'));
	//OUTPUT(ds_all_recs_gongcomp,     NAMED('ds_all_recs_gongcomp'));
  //OUTPUT(ds_all_bdids_deduped,     NAMED('ds_all_bdids_deduped'));
	//OUTPUT(ds_all_bdids_gongphone,   NAMED('ds_all_bdids_gongphone'));
	//OUTPUT(ds_all_recs_gongphone,    NAMED('ds_all_recs_gongphone'));
  //OUTPUT(ds_all_bdids_nogong,      NAMED('ds_all_bdids_nogong'));
	//OUTPUT(ds_all_bdids_ypphone,     NAMED('ds_all_bdids_ypphone'));
  //OUTPUT(ds_all_recs_ypphone,     NAMED('ds_all_recs_ypphone'));
	//OUTPUT(dSuppressBadPhone1,			 NAMED('dSuppressBadPhone1'));
	//OUTPUT(dSuppressBadPhone2,			 NAMED('dSuppressBadPhone2'));
	//OUTPUT(dSuppressBadPhones,			 NAMED('dSuppressBadPhones'));
	
  //OUTPUT(ds_most_complete_all,     NAMED('ds_most_complete_all'));
	//OUTPUT(ds_most_complete_srtd,    NAMED('ds_most_complete_srtd'));
	//OUTPUT(ds_most_current1,         NAMED('ds_most_current1'));
	//OUTPUT(ds_best_recs_for_did,     NAMED('ds_best_recs_for_did'));
	//OUTPUT(ds_best1_for_did,         NAMED('ds_best1_for_did'));
  //OUTPUT(ds_best1_for_did_bdids_cs, NAMED('ds_best1_for_did_bdids_cs'));
	//OUTPUT(ds_best1_for_did_wcs,     NAMED('ds_best1_for_did_wcs'));
  //OUTPUT(ds_most_complete_fltrd,   NAMED('ds_most_complete_filtrd'));
  //OUTPUT(ds_most_complete_unique,  NAMED('ds_most_complete_unqiue'));
  //OUTPUT(ds_most_complete_addl,    NAMED('ds_most_complete_addl'));
  //OUTPUT(ds_addl_2recs,            NAMED('ds_addl_2recs'));
  //OUTPUT(ds_addl_2recs_bdids_corpstat, NAMED('ds_addl_2recs_bdids_corpstat'));
	//OUTPUT(ds_addl_2recs_wcorpstat,  NAMED('ds_addl_2recs_wcorpstat'));
	//OUTPUT(ds_addl_combined,         NAMED('ds_addl_combined'));
 
  //OUTPUT(ds_recs_spoke,            NAMED('ds_recs_spoke'));
  //OUTPUT(ds_recs_zoom,             NAMED('ds_recs_zoom'));
  //OUTPUT(ds_recs_corp,             NAMED('ds_recs_corp'));
  //OUTPUT(ds_recs_poeemail,         NAMED('ds_recs_poeemail'));
  //OUTPUT(ds_recs_thrive,           NAMED('ds_recs_thrive'));
  //OUTPUT(ds_recs_oneclick,         NAMED('ds_recs_oneclick'));
  //OUTPUT(ds_recs_others,           NAMED('ds_recs_others'));
	//
  //OUTPUT(ds_detail_spoke,          NAMED('ds_detail_spoke'));
  //OUTPUT(ds_detail_zoom,           NAMED('ds_detail_zoom'));
  //OUTPUT(ds_detail_corp,           NAMED('ds_detail_corp'));
  //OUTPUT(ds_detail_poeemail,       NAMED('ds_detail_poeemail'));
  //OUTPUT(ds_detail_oneclick,       NAMED('ds_detail_oneclick'));
	//OUTPUT(ds_detail_saleschannel,	 NAMED('ds_detail_saleschannel'));
	//OUTPUT(ds_detail_thrive,	       NAMED('ds_detail_thrive'));
  //OUTPUT(ds_detail_others,         NAMED('ds_detail_others'));
  //OUTPUT(ds_detail_all,            NAMED('ds_detail_all'));

  //OUTPUT(ds_detail_bdids_deduped,  NAMED('ds_detail_bdids_deduped'));
  //OUTPUT(ds_bdids_dca_added,       NAMED('ds_bdids_dca_added'));
  //OUTPUT(ds_parents,               NAMED('ds_parents'));
  //OUTPUT(ds_bdids_wparent,         NAMED('ds_bdids_wparent'));
  //OUTPUT(ds_detail_wparent,        NAMED('ds_detail_wparent'));
  //OUTPUT(ds_parent_bdids_corpstat, NAMED('ds_parent_bdids_corpstat'));
	//OUTPUT(ds_detail_wpar_corpstat,  NAMED('ds_detail_wpar_corpstat'));
  //OUTPUT(ds_prolic_data,           NAMED('ds_prolic_data'));
  //OUTPUT(ds_prolic_deduped,        NAMED('ds_prolic_deduped'));
  //OUTPUT(ds_detail_wprolic,        NAMED('ds_detail_wself_prolic'));
  //OUTPUT(ds_email_data,            NAMED('ds_email_data'));
  //OUTPUT(ds_email_deduped,         NAMED('ds_email_deduped'));
  //OUTPUT(ds_email_combined,        NAMED('ds_email_combined'));
	//OUTPUT(ds_detail_wemail,         NAMED('ds_detail_wemail'));
	//OUTPUT(ds_detail_subject,        NAMED('ds_detail_subject'));
	//OUTPUT(ds_detail_subj_waddl,     NAMED('ds_detail_subj_waddl'));
	//OUTPUT(ds_detail_spouse,         NAMED('ds_detail_spouse'));
  //OUTPUT(ds_detail_subj_wacctno,   NAMED('ds_detail_subj_wacctno'));
  //OUTPUT(ds_detail_spos_wacctno,   NAMED('ds_detail_spos_wacctno'));
	//OUTPUT(ds_detail_subj_wacctno_srtd, NAMED('ds_detail_subj_wacctno_srtd'));
	//OUTPUT(ds_detail_spos_wacctno_srtd, NAMED('ds_detail_spos_wacctno_srtd'));
  //OUTPUT(ds_detail_combined,       NAMED('ds_detail_combined'));
  //OUTPUT(ds_final_results,         NAMED('ds_final_results'));

  //return ds_excluded_sources;
  //return ds_poe_recs_slimmed;
  //return ds_all_recs_slimmed;
	//return ds_all_recs_included;
  //return ds_most_current;
	//return ds_detail_all;
	//return ds_detail_wparent;
	
  RETURN ds_final_results;

END;
