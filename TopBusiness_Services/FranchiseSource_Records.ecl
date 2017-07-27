// ================================================================================
// ===== RETURNS Franchise Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, TopBusiness_Services;

EXPORT FranchiseSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for frandx to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	
	shared in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get franchise data
  SHARED frandx_recs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                     inoptions.fetch_level
																							).ds_frandx_linkidskey_recs;

	// For each owner of a franchise a franchisee record is created, sometimes duplicates exist, dedup on franchisee_id and
	// name and group on franchisee_id which will be used to roll up the results.
	SHARED frandx_recs_grp := GROUP(DEDUP(SORT(frandx_recs,franchisee_id,exec_full_name),franchisee_id,exec_full_name),franchisee_id);
	
	franchise_layout := recordof(frandx_recs);

	iesp.share.t_Name xform_execs(franchise_layout L) := TRANSFORM
		SELF.Full 		:= L.exec_full_name;
		SELF.First  	:= L.fname;
		SELF.Middle  	:= L.mname; 
		SELF.Last 		:= L.lname;
		SELF.Prefix 	:= L.title;
		SELF.Suffix 	:= L.name_suffix;
		SELF := [];
  end;
	
	iesp.franchise.t_FranchiseRecord toOut(franchise_layout L, DATASET(franchise_layout) allRows) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.FranchiseeId      	:= L.franchisee_id;
		SELF.Franchise					:= L.brand_name;
		SELF.CompanyName        := L.company_name;
		SELF.Phone							:= L.clean_phone;
		SELF.SecondaryPhone			:= L.clean_secondary_phone;
		SELF.Email     					:= L.email;
		SELF.URL								:= L.website_url;
		SELF.UnitExplanation		:= L.Unit_Flag_Exp;
		SELF._Relationship			:= L.Relationship_Code_Exp;
		SELF.NumberFranchises		:= (INTEGER) L.f_units;
		SELF.Industry 					:= IF(L.industry = 'QSR', 'QUICK SERVICE RESTAURANT', L.industry);
		SELF.IndustryType      	:= L.industry_type;
		SELF.Sector							:= L.sector;
		SELF.SicCode						:= L.sic_code;
		SELF.FranchiseStartDate	:= iesp.ECL2ESP.toDate((INTEGER)L.frn_start_date);
		SELF.LastUpdate 				:= iesp.ECL2ESP.toDate((INTEGER)L.dt_vendor_last_reported);
		
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,L.unit_desig,
															L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,'','',L.address1,L.address2);
		
		
		// Assign executives.
		SELF.Executives := PROJECT(allRows,xform_execs(LEFT));
		SELF := [];
	END;

 EXPORT SourceView_Recs := ROLLUP(frandx_recs_grp,GROUP,toOUT(LEFT,ROWS(LEFT)));
 //Return dedup count on franchise id, since output is being rolled up on franchisee id.
 EXPORT SourceView_RecCount := COUNT(DEDUP(frandx_recs_grp,franchisee_id));
 
 export temp := '';
END;
