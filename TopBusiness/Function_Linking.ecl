import MDR, Risk_Indicators, census_data, TopBusiness_Metadata,ut;

export Function_Linking(
	dataset(TopBusiness.Layout_Linking.Unlinked) new_base,
	dataset(TopBusiness.Layout_Linking.Linked) old_base = dataset([],TopBusiness.Layout_Linking.Linked),
	boolean in_purge_build = false) := module(Interface_AsMasters.Linkage.Base)
	
	import Advo,ut;
	
 	TopBusiness.Macro_Isolation(new_base,company_name,base0);
   	
	base := base0 : independent;
	
	// Get the maximum BEID heretofore established
	max_beid := max(old_base,beid) : independent;
	
	// Project current extracts into linked layout, with 0 (zero) for the IDs
	new_extracts := project(base,
		transform(TopBusiness.Layout_Linking.Linked,
			self.beid := 0,
			self.blid := 0,
			self.brid := 0,
			self.bid := 0,
			self.segment_bid := 0,
			self.county_name := '',
			self.cbsa_number := '',
			self := left));
	
	// Project old extracts to zero out the additional linked fields
	old_extracts := project(old_base,
		transform(TopBusiness.Layout_Linking.Linked,
			self.segment_bid := 0,
			self.county_name := '',
			self.cbsa_number := '',
			self := left));
	
	// Combine the old and new and rollup to get new dates
	combined_extracts_traditional := rollup(sort(new_extracts + old_extracts,record,except bid,brid,blid,beid,date_first_seen,date_last_seen),
		transform(TopBusiness.Layout_Linking.Linked,
			stdize_dt(unsigned dt) := map(
				dt >= 10000000 => dt,
				dt >= 100000   => dt * 100,
				dt >= 1000     => dt * 10000,
				/* otherwise=> */ 0);
			self.bid := max(left.bid,right.bid),
			self.brid := max(left.brid,right.brid),
			self.blid := max(left.blid,right.blid),
			self.beid := max(left.beid,right.beid),
			self.date_first_seen := map(
				stdize_dt(left.date_first_seen) = 0 => stdize_dt(right.date_first_seen),
				stdize_dt(right.date_first_seen) = 0 => stdize_dt(left.date_first_seen),
				min(stdize_dt(left.date_first_seen),stdize_dt(right.date_first_seen))),
			self.date_last_seen := map(
				stdize_dt(left.date_last_seen) = 0 => stdize_dt(right.date_last_seen),
				stdize_dt(right.date_last_seen) = 0 => stdize_dt(left.date_last_seen),
				max(stdize_dt(left.date_last_seen),stdize_dt(right.date_last_seen))),
			self := left),
		record,except bid,brid,blid,beid,date_first_seen,date_last_seen);
	
	// Combine the old and new and rollup to get the BIDs if they exist - but only keep "new" data
	combined_extracts_purge := project(rollup(sort(
		project(new_extracts + old_extracts,
			transform({TopBusiness.Layout_Linking.Linked;boolean has_new;},
				self.has_new := left.beid = 0,
				self := left)),record,except bid,brid,blid,beid,date_first_seen,date_last_seen),
		transform(recordof(left),
			stdize_dt(unsigned dt) := map(
				dt >= 10000000 => dt,
				dt >= 100000   => dt * 100,
				dt >= 1000     => dt * 10000,
				/* otherwise=> */ 0);
			self.has_new := left.has_new or right.has_new,
			self.bid := max(left.bid,right.bid),
			self.brid := max(left.brid,right.brid),
			self.blid := max(left.blid,right.blid),
			self.beid := max(left.beid,right.beid),
			temp_left_date_first_seen := stdize_dt(if(left.has_new,left.date_first_seen,0));
			temp_left_date_last_seen := stdize_dt(if(left.has_new,left.date_last_seen,0));
			temp_right_date_first_seen := stdize_dt(if(right.has_new,right.date_first_seen,0));
			temp_right_date_last_seen := stdize_dt(if(right.has_new,right.date_last_seen,0));
			self.date_first_seen := map(
				temp_left_date_first_seen = 0 => temp_right_date_first_seen,
				temp_right_date_first_seen = 0 => temp_left_date_first_seen,
				min(temp_left_date_first_seen,temp_right_date_first_seen)),
			self.date_last_seen := map(
				temp_left_date_last_seen = 0 => temp_right_date_last_seen,
				temp_right_date_last_seen = 0 => temp_left_date_last_seen,
				max(temp_left_date_last_seen,temp_right_date_last_seen)),
			self := left),
		record,except bid,brid,blid,beid,date_first_seen,date_last_seen,has_new)(has_new),TopBusiness.Layout_Linking.Linked);
	
	// Choose based on "purge build" status
	combined_extracts := if(in_purge_build,combined_extracts_purge,combined_extracts_traditional);
	
	// Take all 0-BEID records and apply new BEIDs to them
	new_ids :=
		project(combined_extracts(beid = 0),
			transform(TopBusiness.Layout_Linking.Linked,
				self.beid := counter + max_beid,
				self.blid := counter + max_beid,
				self.brid := counter + max_beid,
				self.bid  := counter + max_beid,
				self      := left)) +
		project(combined_extracts(beid != 0),
			transform(TopBusiness.Layout_Linking.Linked,
				self.beid := left.beid,
				self.blid := left.beid,
				self.brid := left.beid,
				self.bid  := left.beid,
				self      := left));
	
	// First join up by source party
	sourceparty_dist := distribute(new_ids,hash64(source,source_docid,source_party));
	sourceparty_recs := table(sourceparty_dist,{source,source_docid,source_party,unsigned6 bid := min(group,bid)},source,source_docid,source_party,local);
	shared sourceparty_updt := join(sourceparty_dist,sourceparty_recs,
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party = right.source_party,
		transform(recordof(left),
			self.bid := right.bid,
			self := left),
		local) : persist('~thor40_241_7::persist::brm::sourceparty_updt');
	shared sourceparty_matches := project(sourceparty_updt,
		transform(TopBusiness.Layout_Linking.Match,
			self.beid_high := left.beid,
			self.beid_low := left.bid,
			self.matchcode := TopBusiness.Constants.MatchCodes.SOURCEPARTY)) : persist('~thor40_241_7::persist::brm::sourceparty_match');
	
	add_telco_st :=
		join(
			sourceparty_updt,
			Risk_Indicators.Key_Telcordia_NPA_St,
			length(trim(left.phone)) = 10 and left.phone[1..3] = right.npa,
			transform(TopBusiness.Layout_Linking.Working,
				self.phone := if(not TopBusiness.Validators.IsValidPhone(left.phone),'',left.phone),
				self.telco_st := right.st,
				self := left,
				self := []),
			left outer,
			lookup);
	
	add_county_name :=
		join(
			add_telco_st,
			census_data.file_fips2county,
			left.county_fips = right.county_fips and
			left.state = right.state_code,
			transform(TopBusiness.Layout_Linking.Working,
				self.county_name := right.county_name,
				self := left),
			left outer,
			lookup);
	
	add_cbsa_number :=
		join(
			add_county_name,
			TopBusiness_Metadata.CensusCBSAs.ByCountyFIPS,
			left.county_fips = right.fips_county and
			left.state = right.state,
			transform(TopBusiness.Layout_Linking.Working,
				self.cbsa_number := if(right.csa_number != '',right.csa_number,right.msa_number),
				self := left),
			left outer,
			lookup);
	
	add_advo :=
		join(
			distribute(add_cbsa_number(zip != '' and prim_name != ''),hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range)),
			distribute(
				Advo.Files(,Advo._Dataset().IsDataland).File_Cleaned_Base(active_flag = 'Y' and residential_or_business_ind = 'A'),
				hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range)),
			left.zip != '' and left.zip = right.zip and
			left.prim_range != '' and left.prim_range = right.prim_range and
			left.prim_name != '' and left.prim_name = right.prim_name and
			left.addr_suffix = right.addr_suffix and
			left.predir = right.predir and
			left.postdir = right.postdir and
			left.sec_range = right.sec_range,
			transform(TopBusiness.Layout_Linking.Working,
				self.residential_or_business_ind := right.residential_or_business_ind,
				self.highrise_ind := right.rec_type = 'H',
				self.clean_company_name := left.company_name,
				self := left),
			keep(1),
			left outer,
			local) +
		project(
			add_cbsa_number(zip = '' or prim_name = ''),
			transform(TopBusiness.Layout_Linking.Working,
			self.residential_or_business_ind := '',
			self.clean_company_name := left.company_name,
			self := left));
	
	shared join_add_ids_0 := add_advo : persist('~thor40_241_7::persist::brm::join_add_ids');
	narrow_names := dedup(dedup(table(join_add_ids_0,{company_name,clean_company_name}),record,all,local),record,all);
	TopBusiness.Macro_CleanCompanyName(narrow_names,company_name,clean_company_name,cleaned_names_0);
	shared cleaned_names := cleaned_names_0 : persist('~thor40_241_7::persist::brm::cleaned_names');

	shared CleanNames(dataset(TopBusiness.Layout_Linking.Working) in_data) := function
		return join(
			distribute(in_data,hash64(company_name)),
			distribute(cleaned_names,hash64(company_name)),
			left.company_name = right.company_name,
			transform(Layout_Linking.Working,
				self.clean_company_name := right.clean_company_name,
				self := left),
			left outer,
			local);
	end;
	
	shared Function_Inside_Matching(
		dataset(TopBusiness.Layout_Linking.Working) in_left_data_0,
		dataset(TopBusiness.Layout_Linking.Working) in_right_data_0,
		boolean is_self_join) := function
		
		in_left_data := CleanNames(in_left_data_0);
		in_right_data := CleanNames(in_right_data_0);
		
		// Match where two beids are both UCC or Lien Creditors with a name from a select list, with a blank address.
		join_left_select_name_no_address := join(
			in_left_data((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and source_party[1] != 'D' and company_name != '' and prim_name = '' and zip = ''),
			TopBusiness_Metadata.UccLienSelectNames,
			left.clean_company_name = right.clean_company_name,
			transform(left),
			lookup);
		join_right_select_name_no_address := join(
			in_right_data((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and source_party[1] != 'D' and company_name != '' and prim_name = '' and zip = ''),
			TopBusiness_Metadata.UccLienSelectNames,
			left.clean_company_name = right.clean_company_name,
			transform(left),
			lookup);
		same_ucc_lien_select_name_no_address_recs := join(
			dedup(distribute((join_left_select_name_no_address),hash64(clean_company_name)),clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((join_right_select_name_no_address),hash64(clean_company_name)),clean_company_name,bid,local),clean_company_name,local),
				dedup(distribute((join_right_select_name_no_address),hash64(clean_company_name)),clean_company_name,bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.UCCLIEN_CREDITOR_SELECTNAME_NOADDR),
			local);
		
		// Match where two beids are both Motor Vehicle records with a name from a select list.
		join_left_select_mvr_name := join(
			in_left_data(MDR.sourceTools.SourceIsVehicle(source) and company_name != ''),
			TopBusiness_Metadata.SelectVehicleNames,
			left.clean_company_name = right.clean_company_name,
			transform(left),
			lookup);
		join_right_select_mvr_name := join(
			in_right_data(MDR.sourceTools.SourceIsVehicle(source) and company_name != ''),
			TopBusiness_Metadata.SelectVehicleNames,
			left.clean_company_name = right.clean_company_name,
			transform(left),
			lookup);
		same_mvr_select_name_recs := join(
			dedup(distribute((join_left_select_mvr_name),hash64(clean_company_name)),clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((join_right_select_mvr_name),hash64(clean_company_name)),clean_company_name,bid,local),clean_company_name,local),
				dedup(distribute((join_right_select_mvr_name),hash64(clean_company_name)),clean_company_name,bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.MVR_SELECTNAME),
			local);
		
		// Create a table of beid pairs that have the same DUNS and Company Name
		same_duns_name_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(duns != '' and clean_company_name != ''),duns,clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(duns != '' and clean_company_name != ''),duns,clean_company_name,bid,local),duns,clean_company_name,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(duns != '' and clean_company_name != ''),duns,clean_company_name,bid,all,local)),
			left.duns = right.duns and
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.DUNS_NAME),
			local);
		
		// Create a table of beid pairs that have the same ZOOM-ID and Company Name
		same_zoom_name_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(zoom != '' and clean_company_name != ''),zoom,clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(zoom != '' and clean_company_name != ''),zoom,clean_company_name,bid,local),zoom,clean_company_name,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(zoom != '' and clean_company_name != ''),zoom,clean_company_name,bid,all,local)),
			left.zoom = right.zoom and
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.ZOOM_NAME),
			local);
		
		// Create a table of record pairs that have the same phone-7, same address and close name
		// Need to have sec_range match if a highrise indicator
		// same_phone7_address_close_name_recs := join(
			// dedup(distribute((in_left_data(clean_company_name != '' and zip != '' and prim_name != '' and TopBusiness.Validators.IsValidPhone(phone) and (sec_range != '' or not highrise_ind))),hash64(zip,prim_range,prim_name,sec_range,predir,postdir,addr_suffix,(unsigned)phone % 10000000)),zip,prim_range,prim_name,sec_range,predir,postdir,addr_suffix,(unsigned)phone % 10000000,bid,all,local),
			// dedup(distribute((in_right_data(clean_company_name != '' and zip != '' and prim_name != '' and TopBusiness.Validators.IsValidPhone(phone) and (sec_range != '' or not highrise_ind))),hash64(zip,prim_range,prim_name,sec_range,predir,postdir,addr_suffix,(unsigned)phone % 10000000)),zip,prim_range,prim_name,sec_range,predir,postdir,addr_suffix,(unsigned)phone % 10000000,bid,all,local),
			// left.zip = right.zip and
			// left.prim_range = right.prim_range and
			// left.prim_name = right.prim_name and
			// left.sec_range = right.sec_range and
			// left.predir = right.predir and
			// left.postdir = right.postdir and
			// left.addr_suffix = right.addr_suffix and
			// (unsigned)left.phone % 10000000 = (unsigned)right.phone % 10000000 and
			// ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
			// left.bid != right.bid,
			// transform(TopBusiness.Layout_Linking.Match_BID,
				// self.bid_low := right.bid,
				// self.beid_low := right.beid,
				// self.bid_high := left.bid,
				// self.beid_high := left.beid,
				// self.matchcode := TopBusiness.Constants.MatchCodes.PHONE7_ADDR_CLOSENAME),
			// local);
		
		// Create a table of record pairs that have the same name and address
		same_name_address_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(clean_company_name != '' and zip != '' and prim_name != ''),clean_company_name,zip,prim_name,prim_range,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and zip != '' and prim_name != ''),clean_company_name,zip,prim_name,prim_range,bid,local),clean_company_name,zip,prim_name,prim_range,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and zip != '' and prim_name != ''),clean_company_name,zip,prim_name,prim_range,bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.NAME_ADDR),
			local);
		
		// Create a table of record pairs that have the same address and initial name
		same_address_init_name_recs := join(
			dedup(distribute((in_left_data_0),hash64(zip,prim_name,prim_range,company_name[1..5]))(company_name != '' and zip != '' and prim_name != '' and (prim_range != '' or prim_name[1..7] = 'PO BOX ')),company_name,zip,prim_name,prim_range,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data_0),hash64(zip,prim_name,prim_range,company_name[1..5]))(company_name != '' and zip != '' and prim_name != '' and (prim_range != '' or prim_name[1..7] = 'PO BOX ')),company_name,zip,prim_name,prim_range,bid,local),company_name,zip,prim_name,prim_range,local),
				dedup(distribute((in_right_data_0),hash64(zip,prim_name,prim_range,company_name[1..5]))(company_name != '' and zip != '' and prim_name != '' and (prim_range != '' or prim_name[1..7] = 'PO BOX ')),company_name,zip,prim_name,prim_range,bid,all,local)),
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.company_name[1..5] = right.company_name[1..5] and
			left.company_name != right.company_name and
			(
				left.company_name = right.company_name[1..length(trim(left.company_name))] or
				right.company_name = left.company_name[1..length(trim(right.company_name))]
			) and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.ADDR_INITSS),
			atmost(
				left.zip = right.zip and
				left.prim_name = right.prim_name and
				left.prim_range = right.prim_range,
				50),
			local);
		
		// Create a table of record pairs that have the same name and phone
		same_name_phone_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))((telco_st = '' or state = '' or telco_st = state) and clean_company_name != '' and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),clean_company_name,phone,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))((telco_st = '' or state = '' or telco_st = state) and clean_company_name != '' and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),clean_company_name,phone,bid,local),clean_company_name,phone,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))((telco_st = '' or state = '' or telco_st = state) and clean_company_name != '' and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),clean_company_name,phone,bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.phone = right.phone and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.NAME_PHONE),
			local);
		
		// Create a table of record pairs that have the same name and fein
		same_name_fein_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(clean_company_name != '' and length(trim(fein)) = 9),clean_company_name,fein,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and length(trim(fein)) = 9),clean_company_name,fein,bid,local),clean_company_name,fein,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and length(trim(fein)) = 9),clean_company_name,fein,bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.fein = right.fein and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.NAME_FEIN),
			local);
		
		// Create a table of record pairs that have the same incorp data and match on name or address
		same_incorp_recs := join(
			dedup(distribute((in_left_data(incorp_state != '' and incorp_number != '')),hash64(incorp_state,incorp_number)),incorp_state,incorp_number,clean_company_name,zip,prim_name,prim_range,bid,all,local),
			dedup(distribute((in_right_data(incorp_state != '' and incorp_number != '')),hash64(incorp_state,incorp_number)),incorp_state,incorp_number,clean_company_name,zip,prim_name,prim_range,bid,all,local),
			left.incorp_state = right.incorp_state and
			left.incorp_number = right.incorp_number and
			(
				ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 or
				(
					left.zip = right.zip and
					left.prim_name = right.prim_name and
					left.prim_range = right.prim_range
				)
			) and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.INCORP),
			local);
		
		// Create a table of record pairs that have the same name and url
		same_name_url_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(clean_company_name != '' and url != ''),clean_company_name,url,MDR.SourceTools.SourceIsZoom(source),bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and url != ''),clean_company_name,url,MDR.SourceTools.SourceIsZoom(source),bid,local),clean_company_name,url,MDR.SourceTools.SourceIsZoom(source),local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(clean_company_name != '' and url != ''),clean_company_name,url,MDR.SourceTools.SourceIsZoom(source),bid,all,local)),
			left.clean_company_name = right.clean_company_name and
			left.url = right.url and
			(not MDR.SourceTools.SourceIsZoom(left.source) or not MDR.SourceTools.SourceIsZoom(right.source)) and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.NAME_URL),
			local);
		
		// Create a table of record pairs that have the same fein and address and DUNS
		same_fein_address_duns_recs := join(
			dedup(distribute(in_left_data_0(length(trim(fein)) = 9 and zip != '' and prim_name != '' and length(trim(duns)) = 9),hash64(fein,zip,prim_name,prim_range,duns)),fein,zip,prim_name,prim_range,duns,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0(length(trim(fein)) = 9 and zip != '' and prim_name != '' and length(trim(duns)) = 9),hash64(fein,zip,prim_name,prim_range,duns)),fein,zip,prim_name,prim_range,duns,bid,local),fein,zip,prim_name,prim_range,duns,local),
				dedup(distribute(in_right_data_0(length(trim(fein)) = 9 and zip != '' and prim_name != '' and length(trim(duns)) = 9),hash64(fein,zip,prim_name,prim_range,duns)),fein,zip,prim_name,prim_range,duns,bid,all,local)),
			left.fein = right.fein and
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.duns = right.duns and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.FEIN_ADDR_DUNS),
			local);
		
		// Create a table of record pairs that have the same fein and address and phone
		same_fein_address_phone_recs := join(
			dedup(distribute(in_left_data_0,hash64(fein,zip,prim_name,prim_range,phone))(length(trim(fein)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),fein,zip,prim_name,prim_range,phone,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(fein,zip,prim_name,prim_range,phone))(length(trim(fein)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),fein,zip,prim_name,prim_range,phone,bid,local),fein,zip,prim_name,prim_range,phone,local),
				dedup(distribute(in_right_data_0,hash64(fein,zip,prim_name,prim_range,phone))(length(trim(fein)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),fein,zip,prim_name,prim_range,phone,bid,all,local)),
			left.fein = right.fein and
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.phone = right.phone and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.FEIN_ADDR_PHONE),
			local);
		
		// Create a table of record pairs that have the same duns and address and phone
		same_duns_address_phone_recs := join(
			dedup(distribute(in_left_data_0,hash64(duns,zip,prim_name,prim_range,phone))(length(trim(duns)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),duns,zip,prim_name,prim_range,phone,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(duns,zip,prim_name,prim_range,phone))(length(trim(duns)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),duns,zip,prim_name,prim_range,phone,bid,local),duns,zip,prim_name,prim_range,phone,local),
				dedup(distribute(in_right_data_0,hash64(duns,zip,prim_name,prim_range,phone))(length(trim(duns)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),duns,zip,prim_name,prim_range,phone,bid,all,local)),
			left.duns = right.duns and
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.phone = right.phone and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.DUNS_ADDR_PHONE),
			local);
		
		// Create a table of record pairs that have the same experian and address and phone
		same_experian_address_phone_recs := join(
			dedup(distribute(in_left_data_0,hash64(experian,zip,prim_name,prim_range,phone))(length(trim(experian)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),experian,zip,prim_name,prim_range,phone,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(experian,zip,prim_name,prim_range,phone))(length(trim(experian)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),experian,zip,prim_name,prim_range,phone,bid,local),experian,zip,prim_name,prim_range,phone,local),
				dedup(distribute(in_right_data_0,hash64(experian,zip,prim_name,prim_range,phone))(length(trim(experian)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),experian,zip,prim_name,prim_range,phone,bid,all,local)),
			left.experian = right.experian and
			left.zip = right.zip and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.phone = right.phone and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.EXPERIAN_ADDR_PHONE),
			local);
		
		// Create a table of record pairs that have the same EBR file number and close name
		same_experian_close_name_recs := join(
			dedup(distribute((in_left_data(experian != '' and clean_company_name != '')),hash64(experian)),experian,clean_company_name,bid,all,local),
			dedup(distribute((in_right_data(experian != '' and clean_company_name != '')),hash64(experian)),experian,clean_company_name,bid,all,local),
			left.experian = right.experian and
			ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.EXPERIAN_CLOSENAME),
			local);

		// Create a table of record pairs that have the same UCC or lien and name
		same_ucc_lien_name_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and clean_company_name != ''),source,source_docid,source_party[1],clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and clean_company_name != ''),source,source_docid,source_party[1],clean_company_name,bid,local),source,source_docid,source_party[1],clean_company_name,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and clean_company_name != ''),source,source_docid,source_party[1],clean_company_name,bid,all,local)),
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party[1] = right.source_party[1] and
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.UCCLIEN_NAME),
			local);
		
		// Create a table of record pairs that have blank addresses and the same toll-free phone and name and ZIP (including blank ZIP)
		same_tfphone_name_zip_recs := join(
			dedup(distribute(in_left_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and company_name != ''),phone,company_name,zip,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and company_name != ''),phone,company_name,zip,bid,local),phone,company_name,zip,local),
				dedup(distribute(in_right_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and company_name != ''),phone,company_name,zip,bid,all,local)),
			left.phone = right.phone and
			left.company_name = right.company_name and
			left.zip = right.zip and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.TFPHONE_NAME_ZIP),
			local);
		
		// Create a table of record pairs that have blank addresses and the same toll-free phone and name and city and state
		same_tfphone_name_city_state_recs := join(
			dedup(distribute(in_left_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and city_name != '' and state != '' and company_name != ''),phone,company_name,city_name,state,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and city_name != '' and state != '' and company_name != ''),phone,company_name,city_name,state,bid,local),phone,company_name,city_name,state,local),
				dedup(distribute(in_right_data_0,hash64(company_name))(TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and city_name != '' and state != '' and company_name != ''),phone,company_name,city_name,state,bid,all,local)),
			left.phone = right.phone and
			left.company_name = right.company_name and
			left.city_name = right.city_name and
			left.state = right.state and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.TFPHONE_NAME_CITY_STATE),
			local);
		
		// Create a table of record pairs that have blank street name, and same company name and NPANXX
		same_name_zip_npanxx_recs := join(
			dedup(distribute(in_left_data_0,hash64(company_name))(company_name != '' and prim_name = '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),(unsigned)zip,phone[1..6],company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute(in_right_data_0,hash64(company_name))(company_name != '' and prim_name = '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),(unsigned)zip,phone[1..6],company_name,bid,local),(unsigned)zip,phone[1..6],company_name,local),
				dedup(distribute(in_right_data_0,hash64(company_name))(company_name != '' and prim_name = '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),(unsigned)zip,phone[1..6],company_name,bid,all,local)),
			(unsigned)left.zip = (unsigned)right.zip and
			left.phone[1..6] = right.phone[1..6] and
			left.company_name = right.company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.NAME_ZIP_NPANXX),
			local);

		// Create a table of record pairs that have the same prim RANGE, zip code, and company name
		same_pr_zip_name_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(prim_range != '' and zip != '' and clean_company_name != ''),prim_range,zip,clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(prim_range != '' and zip != '' and clean_company_name != ''),prim_range,zip,clean_company_name,bid,local),prim_range,zip,clean_company_name,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(prim_range != '' and zip != '' and clean_company_name != ''),prim_range,zip,clean_company_name,bid,all,local)),
			left.prim_range = right.prim_range and
			left.zip = right.zip and
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.PRIMRANGE_ZIP_NAME),
			local);

		// Create a table of record pairs that have the same company name, zip, and phone but no address
		same_name_zip_phone_blank_pn_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name = ''),zip,phone,clean_company_name,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name = ''),zip,phone,clean_company_name,bid,local),zip,phone,clean_company_name,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name = ''),zip,phone,clean_company_name,bid,all,local)),
			left.zip = right.zip and
			left.phone = right.phone and
			left.clean_company_name = right.clean_company_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.ZIP_PHONE_NAME_BLANK_CN),
			local);

		// Create a table of record pairs that have the same zip3 and phone and prim name and a similar company name and prim range
		same_zip3_phone_pn_close_name_pr_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name != '' and prim_range != ''),zip[1..3],phone,prim_name,clean_company_name,prim_range,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name != '' and prim_range != ''),zip[1..3],phone,prim_name,clean_company_name,prim_range,bid,local),zip[1..3],phone,prim_name,clean_company_name,prim_range,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(zip != '' and (telco_st = '' or state = '' or telco_st = state) and TopBusiness.Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name != '' and prim_range != ''),zip[1..3],phone,prim_name,clean_company_name,prim_range,bid,all,local)),
			left.zip[1..3] = right.zip[1..3] and
			left.phone = right.phone and
			left.prim_name = right.prim_name and
			left.clean_company_name = right.clean_company_name and
			abs((integer)left.prim_range - (integer)right.prim_range) < 100 and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.ZIP_PHONE_CLOSE_PR_NAME),
			local);

		// Create a table of record pairs that have the same company name, prim range, prim_name and state
		same_name_pr_pn_st_recs := join(
			dedup(distribute((in_left_data),hash64(clean_company_name))(state != '' and clean_company_name != '' and prim_name != '' and prim_range != ''),state,clean_company_name,prim_name,prim_range,bid,all,local),
			if(is_self_join,
				dedup(sort(distribute((in_right_data),hash64(clean_company_name))(state != '' and clean_company_name != '' and prim_name != '' and prim_range != ''),state,clean_company_name,prim_name,prim_range,bid,local),state,clean_company_name,prim_name,prim_range,local),
				dedup(distribute((in_right_data),hash64(clean_company_name))(state != '' and clean_company_name != '' and prim_name != '' and prim_range != ''),state,clean_company_name,prim_name,prim_range,bid,all,local)),
			left.state = right.state and
			left.clean_company_name = right.clean_company_name and
			left.prim_range = right.prim_range and
			left.prim_name = right.prim_name and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.STATE_NAME_PR_PN),
			local);

		// Create a table of record pairs that have the same source docid and close name
		same_source_docid_close_name_recs := join(
			dedup(distribute((in_left_data((MDR.SourceTools.SourceIsJigsaw(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsGong_Business(source)) and source_docid != '' and clean_company_name != '')),hash64(source,source_docid)),source,source_docid,clean_company_name,bid,all,local),
			dedup(distribute((in_right_data((MDR.SourceTools.SourceIsJigsaw(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsGong_Business(source)) and source_docid != '' and clean_company_name != '')),hash64(source,source_docid)),source,source_docid,clean_company_name,bid,all,local),
			left.source = right.source and
			left.source_docid = right.source_docid and
			ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
			left.bid != right.bid,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.bid_low := right.bid,
				self.beid_low := right.beid,
				self.bid_high := left.bid,
				self.beid_high := left.beid,
				self.matchcode := TopBusiness.Constants.MatchCodes.SOURCEDOCID_CLOSENAME),
			local);
		
		clean_company_name_records :=
			same_duns_name_recs +
			same_zoom_name_recs +
			same_name_address_recs +
			same_name_phone_recs +
			same_name_fein_recs +
			same_name_url_recs +
			same_ucc_lien_name_recs +
			same_pr_zip_name_recs +
			same_name_zip_phone_blank_pn_recs +
			same_name_pr_pn_st_recs;
		
		company_name_records :=
			same_tfphone_name_zip_recs +
			same_tfphone_name_city_state_recs +
			same_name_zip_npanxx_recs;

			
		all_records :=
			clean_company_name_records +
			company_name_records +
			same_ucc_lien_select_name_no_address_recs +
			same_mvr_select_name_recs +
			// same_phone7_address_close_name_recs +
			same_incorp_recs +
			same_fein_address_duns_recs +
			same_fein_address_phone_recs +
			same_duns_address_phone_recs +
			same_experian_address_phone_recs +
			same_experian_close_name_recs +
			same_zip3_phone_pn_close_name_pr_recs +
			same_address_init_name_recs +
			same_source_docid_close_name_recs;
		
		rollupall := rollup(sort(distribute(all_records,hash64(bid_low,bid_high)),bid_low,bid_high,local),
			left.bid_low = right.bid_low and
			left.bid_high = right.bid_high,
			transform(TopBusiness.Layout_Linking.Match_BID,
				self.beid_low := 0,
				self.beid_high := 0,
				self.matchcode := left.matchcode | right.matchcode,
				self := left),
			local);
		
		return project(rollupall,
			transform(TopBusiness.Layout_Linking.Match,
				self.beid_low := left.bid_low,
				self.beid_high := left.bid_high,
				self.matchcode := left.matchcode));

	end;

	shared join_add_ids := join_add_ids_0;
	
	// Now, join the D&B stuff together
	shared dnb_matches := Function_Inside_Matching(
		(join_add_ids(MDR.SourceTools.SourceIsDunn_Bradstreet(source))),
		(join_add_ids(MDR.SourceTools.SourceIsDunn_Bradstreet(source))),
		true) : persist('~thor40_241_7::persist::brm::dnb_match');
	dnb_closure := TopBusiness.Function_Closure(dnb_matches,10);
	shared dnb_updt := join(
		join_add_ids,
		dnb_closure,
		left.bid = right.beid_high,
		transform(recordof(left),
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self := left),
		left outer,
		lookup);
	
	// Now, join the EBR stuff together
	shared ebr_matches := Function_Inside_Matching(
		(dnb_updt(MDR.SourceTools.SourceIsEBR(source))),
		(dnb_updt(MDR.SourceTools.SourceIsEBR(source))),
		true) : persist('~thor40_241_7::persist::brm::ebr_match');
	ebr_closure := TopBusiness.Function_Closure(ebr_matches,10);
	ebr_updt := join(
		dnb_updt,
		ebr_closure,
		left.bid = right.beid_high,
		transform(recordof(left),
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self := left),
		left outer,
		lookup);
	
	// Start with DCA as your basis.  Use BRID as the temp BID field
	shared tree_dca := project(ebr_updt,
		transform(recordof(left),
			self.brid := if(MDR.SourceTools.SourceIsDCA(left.source),left.bid,0),
			self := left)) : independent;
	
	// Now join the DNB data to the DCA stuff.
	dca_dnb_matches := Function_Inside_Matching(
		(tree_dca(brid = 0 and MDR.SourceTools.SourceIsDunn_Bradstreet(source))),
		(tree_dca(brid != 0)),
		false) : independent;
	dca_dnb_table := dedup(sort(table(distribute(tree_dca,hash64(bid)),{bid,company_name,unsigned cnt := count(group)},bid,company_name,local),bid,-cnt,record,local),bid,keep 10,local);;
	dca_dnb_join1 := join(
		distribute(dca_dnb_matches,hash64(beid_high)),
		dca_dnb_table,
		left.beid_high = right.bid,
		left outer,
		local);
	dca_dnb_join2 := join(
		distribute(dca_dnb_join1,hash64(beid_low)),
		dca_dnb_table,
		left.beid_low = right.bid,
		transform({TopBusiness.Layout_Linking.Match;unsigned points;unsigned divisor;},
			self.divisor := left.cnt * right.cnt,
			self.points := self.divisor * ut.StringSimilar100(left.company_name,right.company_name),
			self := left),
		left outer,
		local);
	dca_dnb_rollup := table(distribute(dca_dnb_join2,hash64(beid_high)),{beid_high,beid_low,unsigned4 matchcode := max(group,matchcode),real ratio := (real)sum(group,points) / (real)sum(group,divisor)},beid_high,beid_low,local);
	shared dca_dnb_select := project(dedup(sort(dca_dnb_rollup,beid_high,ratio,beid_low),beid_high),Layout_Linking.Match) : persist('~thor40_241_7::persist::brm::dca_dba_match');
	shared tree_dca_dnb := join(
		tree_dca,
		dca_dnb_select,
		left.bid = right.beid_high,
		transform(recordof(left),
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self.brid := map(
				left.brid != 0 => left.brid,
				right.beid_low != 0 => right.beid_low,
				MDR.SourceTools.SourceIsDunn_Bradstreet(left.source) => left.bid,
				0),
			self := left),
		left outer,
		lookup) : independent;
	
	// Now join the EBR data to the tree.
	tree_ebr_matches := Function_Inside_Matching(
		(tree_dca_dnb(brid = 0 and MDR.SourceTools.SourceIsEBR(source))),
		(tree_dca_dnb(brid != 0)),
		false) : independent;
	tree_ebr_table := dedup(sort(table(distribute(tree_dca_dnb,hash64(bid)),{bid,company_name,unsigned cnt := count(group)},bid,company_name,local),bid,-cnt,record,local),bid,keep 10,local);
	tree_ebr_join1 := join(
		distribute(tree_ebr_matches,hash64(beid_high)),
		tree_ebr_table,
		left.beid_high = right.bid,
		left outer,
		local);
	tree_ebr_join2 := join(
		distribute(tree_ebr_join1,hash64(beid_low)),
		tree_ebr_table,
		left.beid_low = right.bid,
		transform({TopBusiness.Layout_Linking.Match;unsigned points;unsigned divisor;},
			self.divisor := left.cnt * right.cnt,
			self.points := self.divisor * ut.StringSimilar100(left.company_name,right.company_name),
			self := left),
		left outer,
		local);
	tree_ebr_rollup := table(distribute(tree_ebr_join2,hash64(beid_high)),{beid_high,beid_low,unsigned4 matchcode := max(group,matchcode),real ratio := (real)sum(group,points) / (real)sum(group,divisor)},beid_high,beid_low,local);
	shared tree_ebr_select := project(dedup(sort(tree_ebr_rollup,beid_high,ratio,beid_low),beid_high),Layout_Linking.Match) : persist('~thor40_241_7::persist::brm::dca_dnb_ebr_match');
	shared tree_dca_dnb_ebr := join(
		tree_dca_dnb,
		tree_ebr_select,
		left.bid = right.beid_high,
		transform(recordof(left),
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self.brid := map(
				left.brid != 0 => left.brid,
				right.beid_low != 0 => right.beid_low,
				MDR.SourceTools.SourceIsEBR(left.source) => left.bid,
				0),
			self := left),
		left outer,
		lookup) : persist('~thor40_241_7::persist::brm::tree_dca_dnb_ebr');
	
	shared Function_Inner_Matching(
		dataset(TopBusiness.Layout_Linking.Working) ininnerdata,
		dataset(TopBusiness.Layout_Linking.Match) ininnermatch) := function
		tree_other_table_1 :=
			dedup(sort(
			distribute(
			table(table(ininnerdata,
				{bid,company_name,unsigned cnt := count(group)},bid,company_name,local),
				{bid,company_name,unsigned cnt := sum(group,cnt)},bid,company_name),
			hash64(bid)),
			bid,-cnt,record,local),bid,keep 10,local);
		tree_other_join1_1 := join(
			distribute(ininnermatch,hash64(beid_high)),
			tree_other_table_1,
			left.beid_high = right.bid,
			left outer,
			local);
		tree_other_join2_1 := join(
			distribute(tree_other_join1_1,hash64(beid_low)),
			tree_other_table_1,
			left.beid_low = right.bid,
			transform({TopBusiness.Layout_Linking.Match;unsigned points;unsigned divisor;},
				self.divisor := left.cnt * right.cnt,
				self.points := self.divisor * ut.StringSimilar100(left.company_name,right.company_name),
				self := left),
			left outer,
			local);
		tree_other_rollup_1 :=
			table(
				table(
					tree_other_join2_1,
					{beid_high,beid_low,unsigned4 matchcode := max(group,matchcode),unsigned points := sum(group,points),unsigned divisor := sum(group,divisor)},
					beid_high,beid_low,local),
				{beid_high,beid_low,unsigned4 matchcode := max(group,matchcode),real ratio := (real)sum(group,points) / (real)sum(group,divisor)},
				beid_high,beid_low);
		return project(dedup(sort(dedup(sort(tree_other_rollup_1,beid_high,ratio,beid_low,local),beid_high,local),beid_high,ratio,beid_low),beid_high),Layout_Linking.Match);
	end;
	
	shared Function_Inner_Relinking(
		dataset(TopBusiness.Layout_Linking.Working) ininnerdata,
		dataset(TopBusiness.Layout_Linking.Match) ininnermatch) := function
		
		return join(
			distributed(ininnerdata,hash64(bid)),
			distribute(ininnermatch,hash64(beid_high)),
			left.bid = right.beid_high,
			transform(recordof(left),
				self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
				self.brid := map(
					left.brid != 0 => left.brid,
					right.beid_low != 0 => right.beid_low,
					0),
				self := left),
			left outer,
			local);
	end;
	
	shared tree_other_match_1 := Function_Inside_Matching(tree_dca_dnb_ebr(brid = 0),tree_dca_dnb_ebr(brid != 0),false) : independent;
	shared tree_other_1 := Function_Inner_Matching(tree_dca_dnb_ebr,tree_other_match_1) : persist('~thor40_241_7::persist::brm::other1');
	shared tree_other_relink_1 := Function_Inner_Relinking(distribute(tree_dca_dnb_ebr,hash64(bid)),tree_other_1) : independent;

	shared tree_other_match_2 := Function_Inside_Matching(tree_other_relink_1(brid = 0),tree_other_relink_1(brid != 0),false);
	shared tree_other_2 := Function_Inner_Matching(tree_other_relink_1,tree_other_match_2) : persist('~thor40_241_7::persist::brm::other2');
	shared tree_other_relink_2 := Function_Inner_Relinking(tree_other_relink_1,tree_other_2) : independent;

	shared tree_other_match_3 := Function_Inside_Matching(tree_other_relink_2(brid = 0),tree_other_relink_2(brid != 0),false);
	shared tree_other_3 := Function_Inner_Matching(tree_other_relink_2,tree_other_match_3) : persist('~thor40_241_7::persist::brm::other3');
	shared tree_other_relink_3 := Function_Inner_Relinking(tree_other_relink_2,tree_other_3) : independent;

	shared tree_other_match_4 := Function_Inside_Matching(tree_other_relink_3(brid = 0),tree_other_relink_3(brid != 0),false);
	shared tree_other_4 := Function_Inner_Matching(tree_other_relink_3,tree_other_match_4) : persist('~thor40_241_7::persist::brm::other4');
	shared tree_other_relink_4 := Function_Inner_Relinking(tree_other_relink_3,tree_other_4) : independent;

	shared tree_other_match_5 := Function_Inside_Matching(tree_other_relink_4(brid = 0),tree_other_relink_4(brid != 0),false);
	shared tree_other_5 := Function_Inner_Matching(tree_other_relink_4,tree_other_match_5) : persist('~thor40_241_7::persist::brm::other5');
	shared tree_other_relink_5 := Function_Inner_Relinking(tree_other_relink_4,tree_other_5) : persist('~thor40_241_7::persist::brm::relink5');
	
	// Finally, join the remaining data within itself.
	shared tree_remaining_matches := Function_Inside_Matching(
		(tree_other_relink_5(brid = 0)),
		(tree_other_relink_5(brid = 0)),
		true) : persist('~thor40_241_7::persist::brm::treeremaining');
	tree_remaining_closure := TopBusiness.Function_Closure(tree_remaining_matches,12);
	tree_remaining_updt := join(
		distributed(tree_other_relink_5,hash64(bid)),
		distribute(tree_remaining_closure,hash64(beid_high)),
		left.bid = right.beid_high,
		transform(recordof(left),
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self.brid := map(
				left.brid != 0 => left.brid,
				right.beid_low != 0 => right.beid_low,
				left.bid),
			self := left),
		left outer,
		local);
		
	final_bid_linking := tree_remaining_updt;
		
	// Now, create BRIDs by matching on state
	final_blid_linking := dedup(dedup(iterate(
		project(sort(distribute(final_bid_linking,hash64(bid,cbsa_number)),bid,cbsa_number,zip,prim_name,prim_range,beid,local),Layout_Linking.Linked),
		transform(Layout_Linking.Linked,
			self.brid := map(
				right.cbsa_number = '' => 0,
				left.bid = right.bid and left.cbsa_number = right.cbsa_number => left.brid,
				right.beid),
			self.blid := map(
				right.cbsa_number = '' or right.zip = '' or right.prim_name = '' => 0,
				left.bid = right.bid and left.cbsa_number = right.cbsa_number and left.zip = right.zip and left.prim_name = right.prim_name and left.prim_range = right.prim_range => left.blid,
				right.beid),
			self := right),
		local),record,all,local),record,all) : persist('~thor40_241_7::persist::brm::linking::final_blid_linking');
			
	// We now want to mark the BIDs, BRIDs, and BLIDs into their respective segments
	export dataset(Layout_Linking.Linked) As_Linking_Master := Function_Apply_Segmentation(final_blid_linking) : independent;
	export dataset(Layout_Linking.Match) As_Match_Master :=
		sourceparty_matches +
		dnb_matches +
		ebr_matches +
		dca_dnb_select +
		tree_ebr_select +
		tree_other_1 +
		tree_other_2 +
		tree_other_3 +
		tree_other_4 +
		tree_other_5 +
		tree_remaining_matches;

end;
