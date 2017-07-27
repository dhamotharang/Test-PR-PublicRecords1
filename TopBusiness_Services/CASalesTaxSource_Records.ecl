// ================================================================================
// ===== RETURNS Ca Sales Tax Source Count Info and source docs
// ================================================================================
IMPORT BIPV2, iesp, govdata, ut, mdr;

EXPORT CASalesTaxSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for ca sales tax to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	shared in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
									
	// *** Key fetch to get ca sales tax data
  SHARED catax_recs := govdata.key_ca_sales_tax_linkids.kFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                                                          TopBusiness_Services.Constants.SlimKeepLimit);
 	
	// Match on idvalue and idtype if one is passed, if none is passed then match only on linkids..
	shared catax_idValue := JOIN(catax_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										('CA' + TRIM(left.account_number) = right.IdValue OR right.IdValue = ''),
										TRANSFORM(LEFT));
	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(catax_idValue) L) := TRANSFORM
		self.Name.First  				:= L.name_first;
	  self.Name.Middle 				:= L.name_middle;
		self.Name.Last 					:= L.name_last;  
		self.Name.Suffix 				:= L.name_suffix;  	
		self.Name.Prefix 				:= L.name_prefix;
		self.Title							:= 'Owner';
		self := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(catax_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_CA_Sales_Tax;
		SELF.IDValue								:= 'CA' + L.account_number;
		SELF.CompanyName        		:= TRIM(L.firm_name) + IF(L.ownership_code != 'P' AND TRIM(L.owner_name) != TRIM(L.firm_name),
																			', ' + TRIM(L.owner_name),'');
		SELF.IncorpDate							:= iesp.ECL2ESP.toDate((integer4) L.start_date);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		// Waiting on Mailing Address to be added to iesp.
		SELF.Contacts := IF(L.ownership_code = 'P',PROJECT(L,xform_contacts(LEFT)),
																						ROW([],iesp.topbusinessOtherSources.t_OtherContact));
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(catax_idValue) L) := TRANSFORM
			self.src			:= 'CASALESTAX';
			self.src_desc := 'California Sales Tax';
			self.hasName 	:= (L.firm_name<>'' or L.owner_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.location_state<>'' or L.location_zip<>'' or
			                  L.mailing_state<>''  or L.mailing_zip<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.start_date);
			self.dt_last_seen := ut.NormDate((unsigned)L.start_date);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := PROJECT(catax_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(catax_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;