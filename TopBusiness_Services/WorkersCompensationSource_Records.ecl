// ================================================================================
// ===== RETURNS Workers Compensation Source Docs and Count Info 
// ================================================================================
IMPORT BIPV2, Workers_Compensation, iesp, mdr;

EXPORT WorkersCompensationSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
  wk_recs := Workers_Compensation.Key_LinkIds.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	              TopBusiness_Services.Constants.SlimKeepLimit);
 	
	SHARED wk_idValue := JOIN(wk_recs,in_docids,
																				BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
																				(left.Master_UID = right.IdValue OR	right.IdValue = ''),
																				TRANSFORM(LEFT));
	
	iesp.insurance_certification.t_insureCertPolicyInfo xform_policy(recordof(wk_idValue) L) := transform
		SELF.PolicyNumber		:= L.PolicySelf;
		SELF.CarrierName 		:= L.NAICCarrierName;
		SELF.CarrierNumber 	:= L.NAICCarrierNumber;
		SELF.GroupName 			:= L.NAICGroupName;
		SELF.GroupNumber 		:= L.NAICGroupNumber;
		SELF.Status					:= CASE(L.Insured_Status,
																			'E' => 'Exempt',
																			'B' => 'Bare',
																			L.Insured_status);
		SELF.Coverage.StartDate		:= iesp.ECL2ESP.toDate ((integer4) L.Effective_Date);
	  SELF := [];
  end;
	
	SHARED iesp.insurance_certification.t_InsuranceCertificationRecord toOut(recordof(wk_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_Workers_Compensation;
		SELF.IDValue								:= L.Master_UID;
		SELF.BusinessName        		:= L.Description;
		SELF.FEIN										:= L.FEIN;
		SELF.Classification					:= L.classcode;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.m_prim_name,L.m_prim_range,L.m_predir,L.m_postdir,
															L.m_addr_suffix,L.m_unit_desig,L.m_sec_range,L.m_v_city_name,
															L.m_st,L.m_zip,L.m_zip4,'');
    
		SELF.Policies := PROJECT(L,xform_policy(LEFT));
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(wk_idValue) L) := TRANSFORM
			self.src			:= 'WK';
			self.src_desc := 'Workers_Compensation';
			self.hasName 	:= false; 
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= (L.FEIN <> '');
			self.hasAddr 	:= (L.address<>'' or 
												L.state<>'' or L.zip<>'');
		  self.hasPhone := false;
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(wk_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(wk_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT IDValue,businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;	