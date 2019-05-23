// ================================================================================
// ===== RETURNS Spoke member Source Doc and Source Count Info
// ================================================================================
IMPORT BIPV2, Spoke, ut, iesp, MDR, doxie, AutoStandardI, Suppress;

EXPORT SpokeSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	doxie.IDataAccess mod_access,
	boolean IsFCRA = false) 
 := MODULE
	
	// There isn't any unique id key file for spoke to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	// *** Key fetch to get bspoke data
  spoke_recs_all := Spoke.Key_Spoke_Linkids.kfetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	TopBusiness_Services.Constants.SpokeKfetchMaxLimit);
	
	ds_spoke_recs_suppressed := Suppress.MAC_SuppressSource(spoke_recs_all, mod_access);
	
	// Spoke does not have a vl_id or source_rec_id to filter on.	
	SHARED spoke_idValue := JOIN(ds_spoke_recs_suppressed,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level),
										TRANSFORM(LEFT));
										
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(spoke_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_Spoke;
		SELF.CompanyName        		:= L.rawfields.company_name;
		SELF.BusinessDescription		:= L.rawfields.company_business_description;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.clean_company_address.prim_name,L.clean_company_address.prim_range,
															L.clean_company_address.predir,L.clean_company_address.postdir,
															L.clean_company_address.addr_suffix,L.clean_company_address.unit_desig,
															L.clean_company_address.sec_range,L.clean_company_address.v_city_name,
															L.clean_company_address.st,L.clean_company_address.zip,
															L.clean_company_address.zip4,'');
		SELF.Phone									:= L.clean_phones.company_phone_number;
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(spoke_idValue) L) := TRANSFORM
			self.src			:= 'SP';
			self.src_desc := 'Spoke';
			self.hasName 	:= (L.rawfields.company_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.rawfields.company_street_address<>'');
		  self.hasPhone := (L.clean_phones.company_phone_number<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.dt_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.dt_last_seen);
			self := [];
	END;
doxie.compliance.logSoldToSources(spoke_idValue, mod_access);
EXPORT SourceDetailInfo := PROJECT(spoke_idValue,xform_Details(LEFT));
SourceView_RecsIesp := PROJECT(spoke_idValue, toOut(left));
doxie.compliance.logSoldToSources(spoke_idValue, mod_access);								
EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
                                              businessIds.dotid,businessIds.empid,businessIds.powid);
EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;