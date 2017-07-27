// ================================================================================
// ===== RETURNS Oregon Workers Comp Source Count and Source Doc Info
// ================================================================================
IMPORT BIPV2, govdata, ut, iesp, MDR, TopBusiness_Services;

EXPORT ORWorkSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for ORWORK to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get or workers comp data
  SHARED orwork_recs := govdata.Key_OR_Workers_Comp_LinkIds.kFetch(DEDUP(in_docs_linkonly,ALL),
	                                                                 inoptions.fetch_level,,
																																	 TopBusiness_Services.Constants.SlimKeepLimit);
	
	orwork_recs_deduped := dedup(sort(orwork_recs, employer_number, -date_last_seen),employer_number);
	SHARED orwork_idValue := JOIN(orwork_recs_deduped,in_docids,
																				BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
																				(left.Employer_Number = right.IdValue OR	right.IdValue = ''),
																				TRANSFORM(LEFT), KEEP(1)); 	
  
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(orwork_idValue) L) := TRANSFORM
		TopBusiness_Services.IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 		 := MDR.sourceTools.src_OR_Worker_Comp;
		SELF.IDValue		 := L.Employer_Number;
		SELF.CompanyName := L.Employer_Legal_Name;
		SELF.BusinessDescription := L.Business_Description;
    SELF.Phone 			 := L.PPB_Phone_Number;
		SELF.Address 		 := if(L.ppb_state<>'' and L.ppb_state<>'XX',
													iesp.ECL2ESP.setAddress( //PPB (Principal Place of Business) address
														L.ppb_prim_name,L.ppb_prim_range,L.ppb_predir,L.ppb_postdir,
														L.ppb_addr_suffix,L.ppb_unit_desig,L.ppb_sec_range,L.ppb_v_city_name,
														L.ppb_state,L.ppb_zip5,L.ppb_zip4,L.ppb_county,''),
													iesp.ECL2ESP.setAddress( //Company mailing address
														L.mailing_prim_name,L.mailing_prim_range,L.mailing_predir,L.mailing_postdir,
														L.mailing_addr_suffix,L.mailing_unit_desig,L.mailing_sec_range,L.mailing_v_city_name,
														L.mailing_state,L.mailing_zip5,L.mailing_zip4,Functions_Source.get_county_name(L.mailing_state,L.mailing_fipscounty),''));
		SELF := [];
	END;
	
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(orwork_recs) L) := TRANSFORM
			self.src			:= 'ORWORK';
			self.src_desc := 'Oregon Worker\'s Compensation';
			self.hasName 	:= (L.employer_legal_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= ((L.ppb_state<>'' and L.ppb_state<>'XX')or (L.ppb_zip_code<>'' and L.ppb_zip_code<>'99999') or
			                  (L.mailing_state<>'' and L.mailing_state<>'XX')or (L.mailing_zip_code<>'' and L.mailing_zip_code<>'99999'));
		  self.hasPhone := (l.PPB_Phone_Number <> '');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(orwork_recs,xform_Details(LEFT));
	
	SourceView_RecsIesp := PROJECT(orwork_idValue, toOut(left));
												 
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																	 businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;