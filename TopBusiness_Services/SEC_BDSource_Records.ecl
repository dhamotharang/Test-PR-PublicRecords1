// ================================================================================================
// ===== RETURNS SEC Broker/Dealer Source Doc records and source count in an ESP-COMPLIANT WAY ====
// ================================================================================================
IMPORT iesp, BIPV2, govdata, MDR, ut;

EXPORT SEC_BDSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get Sec Broker Dealer data
  SHARED secbd_recs := govdata.key_sec_broker_dealer_linkids.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level
	                                                                     ,,TopBusiness_Services.Constants.SlimKeepLimit);
 
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids.
  SHARED secbd_idValue := JOIN(secbd_recs,in_docids,
															 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
															 (TRIM(left.cik_number) = right.IdValue OR right.IdValue = ''),
															 TRANSFORM(LEFT));
															 
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(secbd_idValue) L) := TRANSFORM
		SELF.Name.First  				:= L.fname;
	  SELF.Name.Middle 				:= L.mname;
		SELF.Name.Last 					:= L.lname;  
		SELF.Name.Suffix 				:= L.name_suffix;  	
		SELF.Name.Prefix				:= L.title;
		SELF := [];
  END;														 
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(secbd_idValue) L) := TRANSFORM
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue								:= L.cik_number;
		SELF.Source 								:= MDR.sourceTools.src_SEC_Broker_Dealer;
		SELF.CompanyName        		:= L.company_name;
		SELF.Fein										:= L.irs_taxpayer_id;
		SELF.Address := iesp.ECL2ESP.setAddress(L.prim_name,L.prim_range,L.predir,L.postdir,
																		L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
																		L.st,L.zip,L.zip4,'',
																		If(L.prim_name = '',L.address1,''),
																		If(L.prim_name = '',L.address2,''),'');
		SELF.Contacts := IF(L.name_score <> '',PROJECT(L,xform_contacts(LEFT)),
																						ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		SELF := [];
	END;
	
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(secbd_idValue) L) := TRANSFORM
			self.src			:= 'SB';
			self.src_desc := 'SEC Broker/Dealer';
			self.hasName 	:= (L.company_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.prim_name<>'' or L.address1<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.dt_first_reported);
			self.dt_last_seen := ut.NormDate((unsigned)L.dt_last_reported);
			self := [];
	END;

	EXPORT SourceDetailInfo 		:= PROJECT(secbd_idValue, xform_Details(LEFT));
	SourceView_RecsIesp 				:= PROJECT(secbd_idValue, toOut(left));
	EXPORT SourceView_Recs 			:= DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount 	:= COUNT(SourceView_Recs);

END;