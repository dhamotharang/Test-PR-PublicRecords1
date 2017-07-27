// ================================================================================
// ===== RETURNS LaborActions_WHD member Source Doc and Source Count Info
// ================================================================================
IMPORT BIPV2, LaborActions_WHD, ut, iesp, MDR, Codes;

EXPORT LaborActionsWHDSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
	
	// There isn't any unique id key file to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get labor_actions_whd data
  LaborActionsWHD_recs := LaborActions_WHD.Key_LinkIds.kfetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	        TopBusiness_Services.Constants.defaultJoinLimit);
 	
  SHARED LaborActionsWHD_recs_deduped := DEDUP(SORT(LaborActionsWHD_recs,caseid, dateupdated),caseid); 
	
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	SHARED LaborActionsWHD_idValue := JOIN(LaborActionsWHD_recs_deduped,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										(left.caseid = right.IdValue OR
										right.IdValue = ''),
										TRANSFORM(LEFT));
		
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(LaborActionsWHD_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue								:= L.caseid;
		SELF.Source 								:= MDR.sourceTools.src_LaborActions_WHD;
		SELF.CompanyName        		:= L.employername;
		SELF.FilingDate							:= iesp.ECL2ESP.toDate((integer4) L.dateadded);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.m_prim_name,L.m_prim_range,L.m_predir,L.m_postdir,
															L.m_addr_suffix,L.m_unit_desig,L.m_sec_range,L.m_v_city_name,
															L.m_st,L.m_zip,L.m_zip4,'');
		SELF.NAICSCodes := DATASET([{L.naicscode,Codes.Key_NAICS(keyed(naics_code = L.naicscode))[1].naics_description}],iesp.topbusinessOtherSources.t_otherNAICSCodes);
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(LaborActionsWHD_idValue) L) := TRANSFORM
			self.src			:= MDR.sourceTools.src_LaborActions_WHD;
			self.src_desc := 'LaborActionsWHD';
			self.hasName 	:= (L.employername<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.m_prim_name<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.date_firstseen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_lastseen);
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(LaborActionsWHD_idValue, xform_Details(LEFT));
	EXPORT SourceView_Recs := PROJECT(LaborActionsWHD_idValue, toOUT(LEFT));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;