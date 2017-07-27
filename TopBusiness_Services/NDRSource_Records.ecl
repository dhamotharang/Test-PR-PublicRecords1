// =========================================================================================================
// ===== RETURNS Natural Disaster Readiness Source Doc records and source count in an ESP-COMPLIANT WAY ====
// =========================================================================================================
IMPORT iesp, BIPV2, NaturalDisaster_Readiness, MDR, ut;

EXPORT NDRSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get NDR data
  SHARED ndr_recs := NaturalDisaster_Readiness.key_LinkIDs.KFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	 TopBusiness_Services.Constants.SlimKeepLimit);
 
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids.
  SHARED ndr_idValue := JOIN(ndr_recs,in_docids,
															 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND
															 (trim(left.business_acronym) + trim(left.business_address1)= RIGHT.IdValue OR	
															 RIGHT.IdValue = ''), TRANSFORM(LEFT), KEEP(1)); 																																		 
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(ndr_idValue) L) := TRANSFORM
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue								:= '';
		SELF.Source 								:= MDR.sourceTools.src_NaturalDisaster_Readiness;
		SELF.CompanyName        		:= L.business_name;
		SELF.Address := iesp.ECL2ESP.setAddress(L.m_prim_name,L.m_prim_range,L.m_predir,L.m_postdir,
																		L.m_addr_suffix,L.m_unit_desig,L.m_sec_range,L.m_v_city_name,
																		L.m_st,L.m_zip,L.m_zip4,'',
																		If(L.m_prim_name = '',L.business_address1,''),
																		If(L.m_prim_name = '',L.business_address2,''),'');
		SELF.Phone									:= L.business_clean_phone_no;
		SELF.Email									:= L.business_email_id;
		SELF.URL										:= L.business_website;
		SELF := [];
	END;
	
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(ndr_idValue) L) := TRANSFORM
			self.src			:= 'NR';
			self.src_desc := 'Natural Disaster Readiness';
			self.hasName 	:= (L.business_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.m_prim_name<>'' or L.business_address1<>'');
		  self.hasPhone := (L.business_clean_phone_no<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_firstseen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_lastseen);
			self := [];
	END;

	EXPORT SourceDetailInfo 		:= PROJECT(ndr_idValue, xform_Details(LEFT));
	SourceView_RecsIesp 				:= PROJECT(ndr_idValue, toOut(left));
	EXPORT SourceView_Recs 			:= DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount 	:= COUNT(SourceView_Recs);

END;