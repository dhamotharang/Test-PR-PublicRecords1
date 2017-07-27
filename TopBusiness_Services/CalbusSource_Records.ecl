// ================================================================================
// ======   RETURNS Calbus DATA IN ESP-COMPLIANT WAY  =====
// ================================================================================
IMPORT Calbus_Services, Calbus, Codes, iesp, BIPV2, MDR, ut;

EXPORT CalbusSource_Records( 
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false) 
 := MODULE
	
	SHARED calbus_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		Calbus_Services.layouts.SourceOutput;
	END;
	
	// Retrieve in_docids records from linkid file
	in_docs := PROJECT(in_docids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																			SELF := LEFT,
																			SELF := []));

	// *** Key fetch to get account numbers from linkids
	ds_calbuskeys := Calbus.Key_Calbus_Linkids.kFetch(in_docs,inoptions.fetch_level,,
	                            TopBusiness_Services.Constants.CalBusKfetchMaxLimit);
	
	ds_calbuskeys_link_ids_only := JOIN(in_docids(IdValue = ''), ds_calbuskeys,
																				BIPV2.IDmacros.mac_JoinTop3Linkids(),
																				TRANSFORM(Layouts.rec_input_ids_wSrc,
																														SELF.IdValue := RIGHT.account_number,
																														SELF := LEFT, 
																														SELF := []));
										
	//For records with an id value assigned and an Id type of vl_id
	in_docs_Parse := in_docids(IdValue != '' and Idtype = TopBusiness_Services.Constants.busvlid);
	
  ds_ParseCalbus_keys_filt := JOIN(ds_calbuskeys, in_docs_Parse,
																		LEFT.account_number = RIGHT.IdValue[3..LENGTH(TRIM(RIGHT.IdValue))],
																				TRANSFORM(Layouts.rec_input_ids_wSrc, 
																														SELF.IdValue := LEFT.account_number,
																														SELF := LEFT, 
																														SELF := []));

	// For records with an id value assigned and an Id type of source_rec_id
	in_docs_SourceRec := in_docids(IdValue != '' and Idtype = TopBusiness_Services.Constants.sourcerecid);
																						
	// *** Join to get account number from linkids
	ds_SrcRecCalbuskeys_filt := JOIN(ds_calbuskeys, in_docs_SourceRec,
																	LEFT.source_rec_id = (INTEGER)RIGHT.IdValue,
																	TRANSFORM(Layouts.rec_input_ids_wSrc, 
																														SELF.IdValue := LEFT.account_number,
																														SELF := LEFT, 
																														SELF := []));
																
	calbus_keys_comb := ds_calbuskeys_link_ids_only + ds_ParseCalbus_keys_filt + ds_SrcRecCalbuskeys_filt;

	calbus_keys := PROJECT(calbus_keys_comb,TRANSFORM(Calbus_Services.layouts.id,SELF.account_number := LEFT.IdValue, SELF := []));

	calbus_keys_dedup := DEDUP(calbus_keys,ALL);
	
  // Get the raw data from the appropriate view
	calbus_sourceview := Calbus_Services.raw.SOURCE_VIEW.by_id(Calbus_keys_dedup);

	SHARED calbus_sourceview_wLinkIds := JOIN(calbus_sourceview,calbus_keys_comb,
																					LEFT.account_number = RIGHT.IdValue,
																					TRANSFORM(calbus_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(calbus_layout_wLinkIds) L) := TRANSFORM
		self.Name.First  				:= L.name.fname;
	  self.Name.Middle 				:= L.name.mname;
		self.Name.Last 					:= L.name.lname;  
		self.Name.Suffix 				:= L.name.name_suffix;  	
		self.Name.Prefix 				:= L.name.title;
		self.Title							:= 'Owner';
		self := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(calbus_layout_wLinkIds) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_Calbus;
		SELF.IDValue								:= 'CA' + L.account_number;
		SELF.CompanyName        		:= TRIM(L.firm_name) + IF(L.ownership_code != 'P' AND TRIM(L.owner_name) != TRIM(L.firm_name),
																			', ' + TRIM(L.owner_name),'');
		SELF.IncorpDate							:= iesp.ECL2ESP.toDate((integer4) L.start_date);
		SELF.IndustryDescription 		:= L.industry_code_desc;
		SELF.CompanyOrgStructure		:= L.ownership_code_desc;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.business.prim_name,L.business.prim_range,L.business.predir,L.business.postdir,
															L.business.addr_suffix,L.business.unit_desig,L.business.sec_range,
															L.business.v_city_name,L.business.st,L.business.zip5,L.business.zip4,'');
		// Waiting on Mailing Address to be added to iesp.
		SELF.Contacts := IF(L.ownership_code = 'P',PROJECT(L,xform_contacts(LEFT)),
																						ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		
		SELF.NaicsCodes 					:= dataset([{L.naics_code, Codes.Key_NAICS(keyed(naics_code = L.naics_code))[1].naics_description}], iesp.topbusinessothersources.t_OtherNAICSCodes);
	
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(calbus_layout_wLinkIds) L) := TRANSFORM
			self.src			:= 'CALBUS';
			self.src_desc := 'California Business';
			self.hasName 	:= (L.firm_name<>'' or L.owner_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.business.st<>'' or L.business.zip5<>'' or
			                  L.mailing.st<>''  or L.mailing.zip5<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.start_date);
			self.dt_last_seen := ut.NormDate((unsigned)L.start_date);
			self := [];
	END;
			
	EXPORT SourceDetailInfo := PROJECT(calbus_sourceview_wLinkIds,xform_Details(LEFT));
		
	SourceView_RecsIesp := PROJECT(calbus_sourceview_wLinkIds, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
END;
