import Autokey_batch,AutoStandardI,BatchServices,doxie,iesp,MDR,POE,PSS,risk_indicators,suppress,ut,CriminalRecords_Services;

export Search_Records := module
	export params := interface(
		 AutoStandardI.InterfaceTranslator.fname_value.params
		,AutoStandardI.InterfaceTranslator.mname_value.params
		,AutoStandardI.InterfaceTranslator.lname_value.params
		,AutoStandardI.InterfaceTranslator.prange_value.params
		,AutoStandardI.InterfaceTranslator.predir_value.params
		,AutoStandardI.InterfaceTranslator.pname_value.params
		,AutoStandardI.InterfaceTranslator.addr_suffix_value.params
		,AutoStandardI.InterfaceTranslator.postdir_value.params
		,AutoStandardI.InterfaceTranslator.sec_range_value.params
		,AutoStandardI.InterfaceTranslator.city_value.params
		,AutoStandardI.InterfaceTranslator.state_value.params
		,AutoStandardI.InterfaceTranslator.zip_value_cleaned.params
		,AutoStandardI.InterfaceTranslator.ssn_value.params
		,AutoStandardI.InterfaceTranslator.phone_value.params
		,AutoStandardI.InterfaceTranslator.did_value.params
		,AutoStandardI.InterfaceTranslator.glb_purpose.params
		,AutoStandardI.InterfaceTranslator.dppa_purpose.params
		,AutoStandardI.InterfaceTranslator.ssn_mask_value.params
		,AutoStandardI.InterfaceTranslator.application_type_val.params
		)
	  // Fields passed in from SearchServices via in_mod and used throughout this attribute.
		export boolean include_spouse	            := false;  // default to false per specs
    export string  excluded_sources           := '';     // default to null (no excluded sources)
		export boolean includeCriminalIndicators  := false;
		export boolean hasTooManyDidsButAvoidFail := false;
	end;

	export get_single_record_batch(params in_mod) := function
	  // 1. Store passed in fields & options.
		// Store input soap/xml fields into internal shortened attribute names to be used later
		in_fname	     := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);
		in_mname	     := AutoStandardI.InterfaceTranslator.mname_value.val(in_mod);
		in_lname	     := AutoStandardI.InterfaceTranslator.lname_value.val(in_mod);
		in_prim_range	 := AutoStandardI.InterfaceTranslator.prange_value.val(in_mod);
		in_predir      := AutoStandardI.InterfaceTranslator.predir_value.val(in_mod);
		in_prim_name	 := AutoStandardI.InterfaceTranslator.pname_value.val(in_mod);
		in_addr_suffix := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(in_mod);
		in_postdir     :=	AutoStandardI.InterfaceTranslator.postdir_value.val(in_mod);
		in_sec_range   :=	AutoStandardI.InterfaceTranslator.sec_range_value.val(in_mod);
		in_city	       := AutoStandardI.InterfaceTranslator.city_value.val(in_mod);
		in_state	     := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
		in_zip         := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);
		in_ssn         := AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod);
		in_phone10     := AutoStandardI.InterfaceTranslator.phone_value.val(in_mod);
		in_did         := AutoStandardI.InterfaceTranslator.did_value.val(in_mod);

    // 2. Use input soap/xml fields to create batch (dataset) of 1 record in the 
	  //    standard batch input format (Autokey_batch.Layouts.rec_inBatchMaster) fields:
	  //                       seq(unsigned),acctno,fname,mname,lname,nmesfx,
	  //                       primrng,predir,primnme,addrsfx,
	  //                       postdir,unitdesg,secrng,
	  //                       city,st,z5,z4,ssn,dob,hmphn,wkphn,
	  //                       dl#,dlst,vin,plate,platest,srchtype,maxres,did(us),score(us),
	  //                       matchcode,date,fein,compname,sic,file#,apn,fips,bdid(us),bdidscore(us)
    Autokey_batch.Layouts.rec_inBatchMaster xfm_make_single_record_batch() := 
			transform, skip( in_mod.hasTooManyDidsButAvoidFail )
				self.seq         := 0;
				self.acctno      := 'acctno1';
				self.name_last   := in_lname;
				self.name_middle := in_mname;
				self.name_first  := in_fname;
				self.prim_range  := in_prim_range;
				self.predir      := in_predir;
				self.prim_name   := in_prim_name;
				self.addr_suffix := in_addr_suffix;
				self.postdir     := in_postdir;
				self.sec_range   := in_sec_range;
				self.p_city_name := in_city;
				self.st          := in_state;
				self.z5          := in_zip;
				self.ssn         := in_ssn;
				self.homephone   := in_phone10;
				self.did         := (unsigned6) in_did; 
				self             := [];
			end;

		// bug #75560 - The user no longer HAS to supply an SSN or name and address
    ds_batch_in := dataset([xfm_make_single_record_batch()]);
		
		return ds_batch_in;
	end;
	
	export val(params in_mod) := function

    // ***** Main processing
		in_appType     := AutoStandardI.InterfaceTranslator.application_type_val.val(in_mod);
		glb_purpose		 := AutoStandardI.InterfaceTranslator.glb_purpose.val(in_mod);
		in_ssn         := AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod);
		
    IncludeSpouse       := in_mod.include_spouse;
    in_excluded_sources := in_mod.excluded_sources;

		//  1.  Edit the input ExcludedSources string as needed for processing below.
    in_excluded_sources_edited := TRIM(Stringlib.StringToUpperCase(in_excluded_sources),
	                                     LEFT,RIGHT,ALL);

    //  2.  Next if not empty, parse the input "ExcludedSources" comma de-limited list
	  // string to create a dataset of any 2 character source codes to be excluded.
    layout_source := {string2 source};
	
    ds_excluded_sources := 
	     if(in_excluded_sources_edited = '',
	        dataset([], layout_source),
			    dataset(ut.Stringsplit(in_excluded_sources_edited, ','), layout_source));
					
					
		//  3. Convert input soap/xml fields into a single record batch and get the did for 
		// the input data (subject).
		ds_batch_in       := get_single_record_batch(in_mod);
    ds_subject_dids   := WorkPlace_Services.Functions.getSubjectDids(ds_batch_in);
    saved_subject_did := ds_subject_dids[1].lookupdid;

    //  4. Optionally get the spouse did
    ds_spouse_dids := if(IncludeSpouse,
	                       WorkPlace_Services.Functions.getSpouseDids(ds_subject_dids));
    saved_spouse_did := ds_spouse_dids[1].lookupdid;
		
		ds_combined_dids_sorted := dedup(sort(ds_subject_dids + ds_spouse_dids,lookupdid),lookupdid);
		
	  //  5. Get all the POE and PSS recs for the subject & spouse dids
    ds_poe_recs_slimmed := WorkPlace_Services.Functions.getPoeRecs(ds_combined_dids_sorted);

		ds_pss_recs_slimmed	:=	WorkPlace_Services.Functions.getPSSRecs(ds_combined_dids_sorted);

    // 7.1 Combine POE & PSS slimmed recs into 1 dataset here and 
	  //     join to POE source_hierarchy key file to assign the source_order.
	  ds_all_recs_slimmed := join(ds_poe_recs_slimmed	+ ds_pss_recs_slimmed,
	                              POE.Keys().source_hierarchy.qa,
			  												keyed(left.source = right.source),
	                              transform(WorkPlace_Services.Layouts.poe_didkey_plus,
					  										  // get source_order from the right key file
						  						        self.source_order := right.source_order,
							  									// keep the rest of fields from left
                                  self              := left),
									  			      LEFT OUTER); // keep left record in case no match to right key file

    // 7.2 Filter to only include records for sources that are not restricted;
	  //     based upon the DataRestrictionMask positions associated with those sources.		
    ds_all_recs_not_restricted := ds_all_recs_slimmed(
	       // Include the record if the source is not restricted.
			   // NOTE1: As of 01/14/2011, Teletrack is the only source that might be 
			   //                          restricted via the DataRestrictionMask.
		     (MDR.sourceTools.SourceIsTeletrack(source) and ~doxie.DataRestriction.TT) OR
         // OR include the record if the source is not Teletrack.
			   ~MDR.sourceTools.SourceIsTeletrack(source));

		// 7.2.1 Applying GLB restrictions to utility records.
		ds_all_recs_glb_ok := ds_all_recs_not_restricted(ut.PermissionTools.glb.SrcOk(in_mod.GLBPurpose, source, dt_first_seen, 0));

    // 7.3 Next do a "left only" join to the excluded_sources dataset to pass through         ??? 
    //     all sources that are not excluded.
    ds_all_recs_included := join(ds_all_recs_glb_ok, ds_excluded_sources,
	                                 left.source = right.source,
															   transform(left),
	                               left only //only include left recs with no match in right ds ???
															  );

    // 8. pull recs by ssn & did and then mask ssns if needed.
		Suppress.MAC_Suppress(ds_all_recs_included,ds_dids_pulled,in_appType,Suppress.Constants.LinkTypes.DID,did);
		Suppress.MAC_Suppress(ds_dids_pulled,ds_ssns_pulled,in_appType,Suppress.Constants.LinkTypes.SSN,subject_ssn);
	  doxie.MAC_PruneOldSSNs(ds_ssns_pulled, ds_all_recs_pulled, subject_ssn, did);

		// set the ssn_mask_value that is used in Suppress.MAC_Mask
		string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(
		                            in_mod,
                                AutoStandardI.InterfaceTranslator.ssn_mask_value.params));

		suppress.MAC_Mask(ds_all_recs_pulled, ds_all_recs_masked, subject_ssn, blank, true, false);

    // 9.  Get "best" company name/address/phone if missing and then clean the data.
		//
	  // 9.1 First try to add any missing company info using the business-header best file. 
	  ds_all_recs_bhbest_added := 
		   BatchServices.WorkPlace_Functions.AddBestInfo(ds_all_recs_masked);
		
	  // 9.2 Remove invalid/disconnected/residential numbers in the company_phone1/2 fields.
	  ds_all_recs_phones_cleaned := 
		   BatchServices.WorkPlace_Functions.CleanPhones(ds_all_recs_bhbest_added);

	  // 9.3 Remove company_names with only invalid terms.
	  ds_all_recs_cname_cleaned := 
		   BatchServices.WorkPlace_Functions.CleanCompName(ds_all_recs_phones_cleaned);

    // 10.  Try to fill in phone1/2 and any company info still missing.
		//
    // 10.1 Get any missing company name/address info from gong history phone# key.
    ds_all_recs_gongcomp := 
     	 WorkPlace_Services.Functions.getCompInfoFromGong(ds_all_recs_cname_cleaned);
					
	  // 10.2 Get phone1/2 for bdid from the gong history bdid key.
    ds_all_recs_gongphone := 
     	 WorkPlace_Services.Functions.getPhoneFromGong(ds_all_recs_gongcomp);

    // 10.3 Get phone1/2 for the bdid from the yellow pages bdid key.
    ds_all_recs_ypphone :=	 
	     WorkPlace_Services.Functions.getPhoneFromYP(ds_all_recs_gongphone);

		// 10.4 Show only phone numbers which do not exist in PSS or that match the criteria of phone status = A and is in the 30 day window
		ds_suppress_badphones	:=	Workplace_Services.Functions.SuppressPhones(ds_all_recs_ypphone);
		
	  // 11. Identify the 1 most complete/"best candidate" subject or optional spouse record
	  //
	  // 11.1 First filter to only use "complete" info recs, which according to the 
	  //     product specs are those records with a non-blank company_name and a 
	  //     non-blank company phone1.
    ds_most_complete_all := ds_suppress_badphones(	company_name<>'' and  // need a comp name
																										company_phone1<>'');  // need a phone

	  // 11.2 Sort subject & optional spouse most complete recs by: 
	  //      1. did (puts all recs for subject and optional spouse together)
	  //      2. descending dt_last_seen (puts most recent first) and 
	  //      3. source_code order (in case multiple recs have the same most recent date)
	  //      to identify the "most current" record for each did (subject and optional the spouse).
	  ds_most_complete_srtd := sort(ds_most_complete_all,
	                                did, -dt_last_seen, source_order, record); 

    // 11.3 Then dedup by did to only keep the 1 most current record for each did.
    ds_most_current1 := dedup(ds_most_complete_srtd, did);

    // 11.4 Match all complete recs for a did to the most current one for a did to keep 
	  //      any recs for a did that have the same bdid/company name & phone1 as the 
	  //      most current one and are within 14 days of the most current dt_last_seen.
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
													       transform(WorkPlace_Services.Layouts.poe_didkey_plus,
															     self := left),
													       inner, // only keep recs from left that match right on join conditions
												         limit(BatchServices.WorkPlace_Constants.Limits.JOIN_LIMIT));

    // 11.5 Sort the best recs for a did in order by:
		//      1. ascending spouse_indicator (puts "N" subject recs before "Y" spouse recs), 
		//      2. ascending source_order 
		//      3. descending dt_last_seen
		//      Then dedup to only keep the 1 "best candidate" (lowest source_order) record 
		//      for each spouse_indicator.
	  ds_best1_for_spind := dedup(sort(ds_best_recs_for_did,
	                                   spouse_indicator, source_order, -dt_last_seen, record),
														    spouse_indicator); 

	  // 11.6 Dedup the sorted recs by acctno to only keep 1 record, either the subject 
	  //      (if it was found) or the spouse (if requested and no subject found).
	  ds_best_candidate := dedup(ds_best1_for_spind, acctno);

    // add crim indicators
    recsIn := PROJECT(ds_best_candidate,TRANSFORM({Layouts.poe_crim_ind,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT));
    CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
    ds_best_crim_ind := PROJECT(IF(in_mod.IncludeCriminalIndicators,recsOut,recsIn),Layouts.poe_crim_ind);

	  // 12. Project interim poe_didkey_slimmed layout onto the SearchService output layout.
    string1 SPOUSE_BEING_RETURNED := 'Y';
	  ds_ss_final := project(ds_best_crim_ind,
	                         transform(iesp.workplace.t_WPSearchRecord,
													   // only return ssn if one was input.
														 self.SSN             := if(in_ssn<>'',left.subject_ssn,''),
														 self.SubjectUniqueId := (string) saved_subject_did,
														 // only return spouse did if includepsouse option was selected
														 // and the info being returned is for the spouse.
														 self.SpouseUniqueId  := if(IncludeSpouse and 
														                            left.spouse_indicator=SPOUSE_BEING_RETURNED,
														                            (string) saved_spouse_did,''),
														 self.SourceCode      := left.source,
														 self.IsSpouse        := left.spouse_indicator,
		                         self.Name.Prefix     := left.name_title,
														 self.Name.First      := left.subject_first_name,
		                         self.Name.Middle     := left.middle_name, 
														 self.Name.Last       := left.subject_last_name,
		                         self.Name.Suffix     := left.name_suffix,
														 self.CompanyData.CompanyName          := stringlib.StringToUpperCase(left.company_name),
													   self.CompanyData.Address.StreetName   := left.company_prim_name,
													   self.CompanyData.Address.StreetNumber := left.company_prim_range,
													   self.CompanyData.Address.StreetPreDirection  := left.company_predir,
													   self.CompanyData.Address.StreetPostDirection := left.company_postdir,
													   self.CompanyData.Address.StreetSuffix        := left.company_addr_suffix,
													   self.CompanyData.Address.UnitDesignation := left.company_unit_desig,
													   self.CompanyData.Address.UnitNumber      := left.company_sec_range,
													   self.CompanyData.Address.City  := left.company_city,
														 self.CompanyData.Address.State := left.company_state,
														 self.CompanyData.Address.Zip5  := left.company_zip, 
														 self.CompanyData.Address.Zip4  := left.company_zip4,
														 self.CompanyData.Phone10       := left.company_phone1,
														 self.BusinessId                := (string12)left.bdid;
														 self.DateLastSeen              := iesp.ECL2ESP.toDate (left.dt_last_seen),
                             self.HasCriminalConviction := left.hasCriminalConviction,
                             self.IsSexualOffender := left.isSexualOffender,
														 self := [] // set all other fields not assigned above to null
                           ));
		
	  // Uncomment lines below as needed for debugging
	  //OUTPUT(IncludeSpouse,           NAMED('IncludeSpouse'));
 	  //OUTPUT(in_excluded_sources,        NAMED('in_excluded_sources'));
 	  //OUTPUT(in_excluded_sources_edited, NAMED('in_excluded_sources_edited'));
    //OUTPUT(ds_excluded_sources,     NAMED('ds_excluded_sources'));
	  //OUTPUT(ds_batch_in,             NAMED('ds_batch_in'));
	  //OUTPUT(ds_subject_dids,         NAMED('ds_subject_dids'));
	  //OUTPUT(saved_subject_did,       NAMED('saved_subject_did'));
	  //OUTPUT(ds_spouse_dids,          NAMED('ds_spouse_dids')); 
	  //OUTPUT(saved_spouse_did,        NAMED('saved_spouse_did'));
    //OUTPUT(ds_poe_recs_slimmed,     NAMED('ds_poe_recs_slimmed'));
    //OUTPUT(ds_all_recs_slimmed,     NAMED('ds_all_recs_slimmed'));
    // OUTPUT(ds_all_recs_not_restricted, NAMED('ds_all_recs_not_restricted'));
    // OUTPUT(ds_all_recs_glb_ok, NAMED('ds_all_recs_glb_ok'));
    // OUTPUT(ds_all_recs_included,    NAMED('ds_all_recs_included'));
    //OUTPUT(ds_dids_pulled,          NAMED('ds_dids_pulled'));
    //OUTPUT(ds_ssns_pulled,          NAMED('ds_ssns_pulled'));
    //OUTPUT(ds_all_recs_pulled,      NAMED('ds_all_recs_pulled'));
    //OUTPUT(ds_all_recs_masked,      NAMED('ds_all_recs_masked'));
    //OUTPUT(ds_all_recs_bhbest_added,   NAMED('ds_all_recs_bhbest_added'));
	  //OUTPUT(ds_all_recs_phones_cleaned, NAMED('ds_all_recs_phones_cleaned'));
    //OUTPUT(ds_all_recs_cname_cleaned,  NAMED('ds_all_recs_cname_cleaned'));
	  //OUTPUT(ds_all_recs_gongcomp,    NAMED('ds_all_recs_gongcomp'));
	  //OUTPUT(ds_all_recs_gongphone,   NAMED('ds_all_recs_gongphone'));
    //OUTPUT(ds_all_recs_ypphone,     NAMED('ds_all_recs_ypphone'));
	  //OUTPUT(ds_most_complete_all,    NAMED('ds_most_complete_all'));
	  //OUTPUT(ds_most_complete_srtd,   NAMED('ds_most_complete_srtd'));
	  //OUTPUT(ds_most_current1,        NAMED('ds_most_current1'));
	  //OUTPUT(ds_best_recs_for_did,    NAMED('ds_best_recs_for_did'));
	  //OUTPUT(ds_best1_for_spind,      NAMED('ds_best1_for_spind'));
	  //OUTPUT(ds_best_candidate,       NAMED('ds_best_candidate'));
	  //OUTPUT(ds_ss_final,             NAMED('ds_ss_final'));

    //return ds_all_recs_included;
    return ds_ss_final;
		
  end;  // end of val function

end; // end of Search_records module
