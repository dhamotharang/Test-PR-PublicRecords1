/* 
	 ============================================================================================================
   ===== RETURNS  NCPDP (National Council for prescription Drug Program) Source Doc and Source Count Info =====
   ============================================================================================================
*/
IMPORT BIPV2, NCPDP, ut, iesp, MDR;

EXPORT NcpdpSource_Records (dataset(Layouts.rec_input_ids_wSrc) in_docids, 
														SourceService_Layouts.OptionsLayout inoptions, 
														boolean IsFCRA = false) := MODULE
	
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids, 
																									SELF := LEFT, 
																									SELF := []));
	// Key fetch to get ncpdp data
  ncpdp_recs := NCPDP.key_LINKIDS.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level);
	ncpdp_recs_deduped := dedup(sort(ncpdp_recs, ncpdp_provider_id),ncpdp_provider_id);			
	
  SHARED ncpdp_idValue := JOIN(ncpdp_recs_deduped,in_docids,
																BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND 
																(TRIM(LEFT.Phys_state) + '-' + HASH(TRIM(LEFT.legal_business_name) + TRIM(LEFT.Phys_prim_name)) = right.IdValue OR right.IdValue = ''),
																TRANSFORM(LEFT));														

	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(ncpdp_idValue) L) := TRANSFORM
		self.Name.First  				:= L.fname;
	  self.Name.Middle 				:= L.mname;
		self.Name.Last 					:= L.lname;  
		self.Name.Suffix 				:= L.suffix;  	
		self.Title							:= L.contact_title;
		SELF.Phone			  			:= L.contact_phone;
		SELF.Email						  := L.contact_email;
		self := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(ncpdp_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IDValue							:= TRIM(L.Phys_state) + '-' + HASH(TRIM(L.legal_business_name) + TRIM(L.Phys_prim_name));
		SELF.Source								:= MDR.sourceTools.src_NCPDP;
		SELF.CompanyName					:= L.legal_business_name;
		SELF.BusinessDescription	:= TRIM(L.primarydispensingtypedesc) + '; ' + TRIM(L.secondarydispensingtypedesc);
		SELF.Fein									:= L.federal_tax_id;
		SELF.Phone			  				:= L.phys_loc_phone;
		SELF.Address 							:= iesp.ECL2ESP.setAddress(
																	 L.Phys_prim_name, L.Phys_prim_range, L.Phys_predir, L.Phys_postdir, L.Phys_addr_suffix, L.Phys_unit_desig,
																	 L.Phys_sec_range, L.Phys_p_city_name, L.Phys_state, L.Phys_zip5, L.Phys_zip4,'');
		SELF.Contacts 						:= PROJECT(L,xform_contacts(LEFT));
		SELF 											:= [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(ncpdp_idValue) L) := TRANSFORM
			self.src					:= 'J2';
			self.src_desc 		:= 'NCPDP';
			self.hasName 			:= (L.legal_business_name<>'');
			self.hasSSN  			:= false;
			self.hasDOB  			:= false;
		  self.hasFEIN 			:= (L.federal_tax_id<>'');;		
			self.hasAddr 			:= (L.Phys_p_city_name <>'' or L.Phys_state<>'' or L.Phys_zip5<>'');
		  self.hasPhone 		:= (L.phys_loc_phone<>'');
			self.dt_first_seen:= ut.NormDate((unsigned)L.Dt_First_Seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.Dt_Last_Seen);
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(ncpdp_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(ncpdp_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;