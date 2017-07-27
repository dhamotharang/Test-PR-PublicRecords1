// ================================================================================
// ===== RETURNS Amidir Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, AMIDIR, MDR, ut;

EXPORT AmidirSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// Use the linkid payload to build source doc
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get gong data
  SHARED amidir_recs := AMIDIR.key_AMIDIR_LinkIDs.KeyFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level);
 
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
   SHARED amidir_idValue := JOIN(amidir_recs,in_docids,
															 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
															 (((string) left.source_rec_id = right.IdValue AND 
													     right.IdType = Constants.sourcerecid) OR 
															 (right.IdValue = left.Key AND
															 right.IdType = Constants.busvlid) OR
                               right.IdValue = ''),
                               TRANSFORM(LEFT));

	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(amidir_idValue) L, INTEGER C) := TRANSFORM
		SELF.Name.First  				:= CHOOSE(C, L.physician_name_clean_fname, L.office_manager_name_clean_fname);
	  SELF.Name.Middle 				:= CHOOSE(C,L.physician_name_clean_mname, L.office_manager_name_clean_mname);
		SELF.Name.Last 					:= CHOOSE(C,L.physician_name_clean_lname, L.office_manager_name_clean_lname); 
		SELF.Name.Suffix 				:= CHOOSE(C,L.physician_name_clean_name_suffix, ''); 	
		SELF.Name.Prefix 				:= CHOOSE(C,L.physician_name_clean_title, '');
		SELF.Title							:= CHOOSE(C,L.physician_prof_suffix, 'Office Manager');
		SELF.DOB 								:= IF (C = 1,iesp.ECL2ESP.toDate((unsigned4)L.physician_dob_yyyymmdd));
		SELF := [];
	END;
	
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(amidir_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue								:= L.key;
		SELF.Source 								:= MDR.sourceTools.src_AMIDIR;
		SELF.CompanyName        		:= L.business_name;
		SELF.BusinessDescription		:= L.business_type;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.business_address_clean_prim_name,L.business_address_clean_prim_range,
															L.business_address_clean_predir,L.business_address_clean_postdir,
															L.business_address_clean_addr_suffix,L.business_address_clean_unit_desig,
															L.business_address_clean_sec_range,L.business_address_clean_v_city_name,
															L.business_address_clean_st,L.business_address_clean_zip,
															L.business_address_clean_zip4,'');
		SELF.Phone									:= L.business_phone;
		
		SELF.Contacts								:= NORMALIZE(dataset(L), 2,
																			xform_contacts(left, counter));
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(amidir_idValue) L) := TRANSFORM
			self.src			:= 'ML';
			self.src_desc := 'AMIDIR';
			self.hasName 	:= (L.business_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= L.physician_dob_yyyymmdd<>'';
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.business_address_clean_prim_name<>'');
		  self.hasPhone := (L.business_phone<>'');
			self.dt_first_seen := ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.date_last_seen);
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(amidir_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(amidir_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;