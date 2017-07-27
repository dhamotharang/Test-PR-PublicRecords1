// ================================================================================
// ===== RETURNS Mississippi Workers Comp Source Count Info and source docs
// ================================================================================
IMPORT BIPV2, govdata, ut,iesp, MDR, TopBusiness_Services;

EXPORT MSWorkSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	BOOLEAN IsFCRA = FALSE) 
 := MODULE
 	
	// There isn't any unique id key file for MSWORK to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get ms workers comp data
  SHARED mswork_recs := govdata.key_ms_workers_comp_LinkIDS.kFetch(DEDUP(in_docs_linkonly,ALL),
																																		inoptions.fetch_level,,
																																		TopBusiness_Services.Constants.SlimKeepLimit);
	
	SHARED mswork_recs_deduped := DEDUP(SORT(mswork_recs, carrier_claim_no, -date_last_seen),carrier_claim_no);
	SHARED mswork_idValue := JOIN(mswork_recs_deduped,in_docids,
																				BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) 
																				AND	(LEFT.carrier_claim_no = RIGHT.IdValue OR	RIGHT.IdValue = ''),
																				TRANSFORM(LEFT), KEEP(1)); 
																				
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(mswork_idValue) L, INTEGER C) := TRANSFORM
		SELF.Name.First  				:= CHOOSE(C, L.atty_name_first,L.claim_name_first);
	  SELF.Name.Middle 				:= CHOOSE(C, L.atty_name_middle,L.claim_name_middle);
		SELF.Name.Last 					:= CHOOSE(C, L.atty_name_last,L.claim_name_last);
		SELF.Name.Suffix 				:= CHOOSE(C, L.atty_name_suffix,L.claim_name_suffix); 	
		SELF.Name.Prefix 				:= CHOOSE(C, L.atty_name_prefix,L.claim_name_prefix);
		SELF.Title							:= CHOOSE(C, 'Attorney','Claimant');
		SELF := [];
  END;	
	
	SHARED iesp.topbusinessothersources.t_OtherSourceRecord toOut(RECORDOF(mswork_idValue) L) := TRANSFORM
		TopBusiness_Services.IDmacros.mac_IespTransferLinkids(UseIdValue:=FALSE)
		SELF.Source 		 := MDR.sourceTools.src_MS_Worker_Comp;
		SELF.IDValue		 := L.Carrier_Claim_No;
		SELF.CompanyName := L.Employer_Name;
		SELF.FEIN				 := L.Employer_FEIN;
		SELF.Address 		 := iesp.ECL2ESP.setAddress(
																		L.emp_prim_name,L.emp_prim_range,L.emp_predir,L.emp_postdir,
																		L.emp_addr_suffix,L.emp_unit_desig,L.emp_sec_range,L.emp_v_city_name,
																		L.emp_st,L.emp_zip5,L.emp_zip4,l.emp_fipscounty,'');	
																		
		SELF.Contacts := NORMALIZE(DATASET(L), 2, xform_contacts(LEFT,COUNTER));																
		SELF := [];
	END;
	
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(mswork_recs) L) := TRANSFORM
			SELF.src			:= 'MSWORK';
			SELF.src_desc := 'Mississippi Worker\'s Compensation';
			SELF.hasName 	:= (L.claimant_name<>'');
			SELF.hasSSN  	:= (L.claimant_ssn<>'');
			SELF.hasDOB  	:= ((INTEGER) L.claimant_dob[1..4] > 0);
		  SELF.hasFEIN 	:= FALSE;		
			SELF.hasAddr 	:= (L.claimant_state<>'' OR L.claimant_zip<>'');
		  SELF.hasPhone := FALSE;
			SELF.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			SELF.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			SELF := [];
	END;
	
	EXPORT SourceDetailInfo := PROJECT(mswork_recs,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(mswork_idValue, toOut(LEFT));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT IDValue,businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;