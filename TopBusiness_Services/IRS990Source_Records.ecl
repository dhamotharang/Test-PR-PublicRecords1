// ================================================================================
// ===== RETURNS IRS990 NonProfit Source Doc and Source Count Info
// ================================================================================
IMPORT BIPV2, govdata, ut, iesp, mdr;

EXPORT IRS990Source_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for irs9900 to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get irs990 data
  irs990_recs := govdata.key_IRS_NonProfit_linkIDs.KeyFetch(DEDUP(in_docs_linkonly,ALL),inoptions.fetch_level,,
	                                                          TopBusiness_Services.Constants.SlimKeepLimit);
 	
	// Match on idvalue, if none is passed then match only on linkids..
	SHARED irs990_idValue := JOIN(irs990_recs,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										(TRIM(left.employer_id_number) + TRIM(left.group_exemption_number) = right.IdValue OR right.IdValue = ''),
										TRANSFORM(LEFT));
	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(recordof(irs990_idValue) L) := TRANSFORM
		self.Name.First  				:= L.fname;
	  self.Name.Middle 				:= L.mname;
		self.Name.Last 					:= L.lname;  
		self.Name.Suffix 				:= L.name_suffix;  	
		self.Title 							:= L.title;
		self := [];
  end;
	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(irs990_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_IRS_Non_Profit;
		SELF.IDValue								:= TRIM(L.employer_id_number) + TRIM(L.group_exemption_number);
		SELF.CompanyName        		:= L.primary_name_of_organization;
		SELF.Fein										:= L.employer_id_number;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,
															L.addr_suffix,L.unit_desig,L.sec_range,L.v_city_name,
															L.st,L.zip,L.zip4,'');
		
		SELF.Contacts := PROJECT(L,xform_contacts(LEFT));
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(recordof(irs990_idValue) L) := TRANSFORM
			self.src			:= 'IRSNP';
			self.src_desc := 'IRS Form 990';
			self.hasName 	:= (L.primary_name_of_organization<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= (L.employer_id_number<>'');		
			self.hasAddr 	:= (L.state<>'' or L.zip_code<>'' or
												L.st<>''    or L.zip<>'');
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.process_date);
			self.dt_last_seen := ut.NormDate((unsigned)L.process_date);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(irs990_idValue,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(irs990_idValue, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;