// ================================================================================
// ===== RETURNS Iowa Sales Tax Source Count Info and source docs
// ================================================================================
IMPORT BIPV2, iesp, govdata, ut, mdr;

EXPORT IASalesTaxSource_Records (
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for ia sales tax to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	SHARED in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := left,
																																		SELF := []));
																																		
	// *** Key fetch to get iowa sales tax data
  SHARED iatax_recs := govdata.Key_IA_SalesTax_LinkIDs.KeyFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                                TopBusiness_Services.Constants.SlimKeepLimit);
	
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	SHARED iatax_idValue := JOIN(iatax_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) and	                			
										('IA' + TRIM(left.permit_nbr) = right.IdValue or right.IdValue = ''),
										TRANSFORM(left));
										
										
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(iatax_idValue) L) := TRANSFORM
		SELF.Name.First  				:= L.owner_name_first;
	  SELF.Name.Middle 				:= L.owner_name_middle;
		SELF.Name.Last 					:= L.owner_name_last;  
		SELF.Name.Suffix 				:= L.owner_name_suffix;  	
		SELF.Name.Prefix 				:= L.owner_name_prefix;
		SELF.Title							:= 'Owner';
		SELF := [];
  END;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(iatax_idValue) L) := TRANSFORM
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_IA_Sales_Tax;
		SELF.IDValue								:= 'IA' + L.permit_nbr;
		SELF.CompanyName        		:= IF(TRIM(L.trade_name) <> '',TRIM(L.trade_name)
																															,IF(TRIM(L.company_name_1) <> '',TRIM(L.company_name_1),TRIM(L.company_name_2)));
		SELF.FilingDate							:= iesp.ECL2ESP.toDate((integer4) L.issue_date);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.location_prim_name,L.location_prim_range,L.location_predir,L.location_postdir,
															L.location_addr_suffix,L.location_unit_desig,L.location_sec_range,L.location_v_city_name,
															L.location_st,L.location_zip,L.location_zip4,'');
		// Waiting on Mailing Address to be added to iesp.
		SELF.Contacts := IF(L.owner_name_score <> '',PROJECT(L,xform_contacts(LEFT)),
																						ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		SELF := [];
	END;
 		
	SHARED TopBusiness_Services.SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(iatax_idValue) L) := TRANSFORM
			SELF.src			:= 'IASALESTAX';
			SELF.src_desc := 'Iowa Sales Tax';
			SELF.hasName 	:= (L.company_name_1<>'' or L.company_name_2<>'' or L.trade_name<>'');
			SELF.hasSSN  	:= false;
			SELF.hasDOB  	:= false;
		  SELF.hasFEIN 	:= false;		
			SELF.hasAddr 	:= (L.location_st<>'' or L.location_zip<>'' or
			                  L.mailing_st<>''  or L.mailing_zip<>'');
		  SELF.hasPhone := false;
			SELF.dt_first_seen := ut.NormDate((unsigned)L.issue_date);
			SELF.dt_last_seen  := ut.NormDate((unsigned)L.issue_date);
			SELF := [];
	END;
	
	EXPORT SourceDetailInfo 	 := PROJECT(iatax_recs,xform_Details(LEFT));
	SourceView_RecsIesp 			 := PROJECT(iatax_idValue, toOut(left));
	EXPORT SourceView_Recs 		 := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;