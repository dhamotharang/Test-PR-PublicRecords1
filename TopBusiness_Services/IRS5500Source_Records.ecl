// ================================================================================
// ===== RETURNS IRS5500 Source Count Info, currently no source docs are returned
// ================================================================================
IMPORT BIPV2, IRS5500, ut, iesp, MDR;

EXPORT IRS5500Source_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for irs5500 to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get irs5500 data
  irs5500_recs := IRS5500.Key_LinkIDs.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                   TopBusiness_Services.Constants.SlimKeepLimit);
	
 	
	// Match on idvalue, if none is passed then match only on linkids..
	SHARED irs5500_idValue := JOIN(irs5500_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										(left.document_locator_number = right.IdValue OR right.IdValue = ''),
										TRANSFORM(LEFT));
	
	iesp.topbusinessOtherSources.t_OtherContact xform_admin(recordof(irs5500_idValue) L) := TRANSFORM
		self.Name.Full  				:= L.admin_signed_name;
		self._Type							:= 'Administrator';
		//Address parts waiting on iesp
		self.Phone							:= L.admin_phone_num;
		self := [];
  end;
	
	iesp.topbusinessOtherSources.t_OtherContact xform_preparer(recordof(irs5500_idValue) L) := TRANSFORM
		self.Name.Full  				:= L.preparer_name;
		self._Type							:= 'Preparer';
		//Address parts waiting on iesp
		self.Phone							:= L.preparer_phone_num;
		self := [];
  end;
	
	iesp.topbusinessOtherSources.t_OtherContact xform_sponsor(recordof(irs5500_idValue) L) := TRANSFORM
		self.Name.Full  				:= L.spons_signed_name;
		self._Type							:= 'Sponsor';
		//Address parts waiting on iesp
		self.Phone							:= L.spon_dfe_phone_num;
		self := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(irs5500_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_IRS_5500;
		SELF.IDValue								:= L.document_locator_number;
		SELF.CompanyName        		:= L.sponsor_dfe_name;
		//Waiting on DBA Name iesp change
		// SELF.DBAName								:= L.spons_dfe_dba_name;
		SELF.Fein										:= L.ein;
		SELF.Phone									:= L.spon_dfe_phone_num;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.spons_prim_name,L.spons_prim_range,L.spons_predir,L.spons_postdir,
															L.spons_addr_suffix,L.spons_unit_desig,L.spons_sec_range,L.spons_v_city_name,
															L.spons_st,L.spons_zip5,L.spons_zip4,'');
		
		sponsor := IF(L.spons_signed_name != '',PROJECT(L,xform_sponsor(LEFT)),ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		admin := IF(L.admin_signed_name != '',PROJECT(L,xform_admin(LEFT)),ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		preparer := IF(L.preparer_name != '',PROJECT(L,xform_preparer(LEFT)),ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		
		SELF.Contacts := sponsor + admin + preparer;
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(irs5500_idValue) L) := TRANSFORM
			self.src			:= 'IRS5500';
			self.src_desc := 'IRS Form 5500';
			self.hasName 	:= (L.sponsor_dfe_name<>''   or
			                  L.spons_dfe_dba_name<>'' or
												L.admin_name<>''         or
			                  L.preparer_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= (L.ein<>'' or L.admin_ein<>'' or L.preparer_ein<>'' );		
			self.hasAddr 	:= (L.spons_dfe_state<>'' or L.spons_dfe_zip_code<>'' or
			                  L.admin_state<>''     or L.admin_zip_code<>''     or
												L.preparer_state<>''  or L.preparer_zip_code<>'');
		  self.hasPhone := (L.spon_dfe_phone_num<>'' or L.admin_phone_num<>'' or 
			                  L.preparer_phone_num<>'');
		  pe_dt	        := ut.NormDate((unsigned)L.plan_eff_date);
			as_dt 		    := ut.NormDate((unsigned)L.admin_signed_date);
			self.dt_first_seen := pe_dt;
			self.dt_last_seen := IF(as_dt<>0,as_dt,pe_dt);
			self := [];
	END;
		
	EXPORT SourceDetailInfo := PROJECT(irs5500_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(irs5500_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);


END;
