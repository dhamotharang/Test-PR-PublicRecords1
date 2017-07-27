import MDR, Risk_Indicators, census_data, TopBusiness_Metadata;

export Function_Linking(
	dataset(Layout_Linking.Unlinked) new_base,
	dataset(Layout_Linking.Linked) old_base = dataset([],Layout_Linking.Linked)) := module(Interface_AsMasters.Linkage.Base)

	import Advo,ut;
	
 	Macro_Isolation(new_base,company_name,base0);
   	
	base := base0;
	
	// Get the maximum BEID heretofore established
	max_beid := max(old_base,beid);
	
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
	combined_extracts := rollup(sort(new_extracts + old_extracts,record,except bid,brid,blid,beid,date_first_seen,date_last_seen),
		transform(TopBusiness.Layout_Linking.Linked,
			self.bid := max(left.bid,right.bid),
			self.brid := max(left.brid,right.brid),
			self.blid := max(left.blid,right.blid),
			self.beid := max(left.beid,right.beid),
			self.date_first_seen := map(
				left.date_first_seen = 0 => right.date_first_seen,
				right.date_first_seen = 0 => left.date_first_seen,
				min(left.date_first_seen,right.date_first_seen)),
			self.date_last_seen := map(
				left.date_last_seen = 0 => right.date_last_seen,
				right.date_last_seen = 0 => left.date_last_seen,
				max(left.date_last_seen,right.date_last_seen)),
			self := left),
		record,except bid,brid,blid,beid,date_first_seen,date_last_seen);
	
	// Take all 0-BEID records and apply new BEIDs to them
	new_ids := project(combined_extracts(beid = 0),
		transform(TopBusiness.Layout_Linking.Linked,
			self.beid := if(left.beid = 0,counter + max_beid,left.beid),
			self.blid := if(left.beid = 0,counter + max_beid,left.blid),
			self.brid := if(left.beid = 0,counter + max_beid,left.brid),
			self.bid  := if(left.beid = 0,counter + max_beid,left.bid),
			self := left)) + combined_extracts(beid != 0);
	
	add_telco_st :=
		join(
			new_ids,
			Risk_Indicators.Key_Telcordia_NPA_St,
			length(trim(left.phone)) = 10 and left.phone[1..3] = right.npa,
			transform(Layout_Linking.Working,
				self.phone := if(not Validators.IsValidPhone(left.phone),'',left.phone),
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
			transform(Layout_Linking.Working,
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
			transform(Layout_Linking.Working,
				self.cbsa_number := if(right.csa_number != '',right.csa_number,right.msa_number),
				self := left),
			left outer,
			lookup);
	
	add_advo :=
		join(
			add_cbsa_number(zip != '' and prim_name != ''),
			Advo.Files(,true).File_Cleaned_Base(active_flag = 'Y' and residential_or_business_ind = 'A'),
			left.zip != '' and left.zip = right.zip and
			left.prim_range != '' and left.prim_range = right.prim_range and
			left.prim_name != '' and left.prim_name = right.prim_name and
			left.addr_suffix = right.addr_suffix and
			left.predir = right.predir and
			left.postdir = right.postdir and
			left.sec_range = right.sec_range,
			transform(Layout_Linking.Working,
				self.residential_or_business_ind := right.residential_or_business_ind,
				self.highrise_ind := right.rec_type = 'H',
				self.clean_company_name := left.company_name,
				self := left),
			keep(1),
			left outer) +
		project(
			add_cbsa_number(zip = '' or prim_name = ''),
			transform(Layout_Linking.Working,
			self.residential_or_business_ind := '',
			self.clean_company_name := left.company_name,
			self := left));
	
	no_name_recs := add_advo(clean_company_name = '');
	with_name_recs := add_advo(clean_company_name != '');

	// Standardize the Company Name
	Macro_CleanCompanyName(with_name_recs,clean_company_name,clean_company_name,corrected_names);
	
	shared join_add_ids := no_name_recs + corrected_names : persist('persist::brm::linking::join_add_ids');
	
	shared all_initial_matches := Function_Matching(join_add_ids) : persist('persist::brm::linking::all_initial_matches');
	
	reduced_initial_matches := Function_Closure(all_initial_matches,13) : persist('persist::brm::linking::reduced_initial_matches');
	
	// Done with BID linking
	shared initial_bid_linking := join(
		distribute(join_add_ids,hash64(beid)),
		distribute(reduced_initial_matches,hash64(beid_high)),
		left.beid = right.beid_high,
		transform(Layout_Linking.Working,
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self := left),
		left outer,
		local);
	
	shared all_bid_matches_0 := Function_Matching_BID(initial_bid_linking) : persist('persist::brm::linking::all_bid_matches');

	all_bid_matches := project(all_bid_matches_0,Layout_Linking.Match);
	
	export dataset(Layout_Linking.Match) As_Match_Master := all_initial_matches + all_bid_matches;
	
	reduced_bid_matches := Function_Closure(project(all_bid_matches_0,transform(Layout_Linking.Match,self.beid_low := left.bid_low,self.beid_high := left.bid_high,self := left)),9);
	
	// Find BIDs that are seriously overlinked and remove from regular processing
	bid_counts := table(table(initial_bid_linking,{bid,unsigned cnt := count(group)},bid,local),{bid,unsigned cnt := sum(group,cnt)},bid);
	overlimit_bids := bid_counts(cnt >= (count(initial_bid_linking) / 100));
	
	limited_bids := join(initial_bid_linking,overlimit_bids,
		left.bid = right.bid,
		transform(left),
		left only,
		lookup);
	
	overlimited_bids := join(initial_bid_linking,overlimit_bids,
		left.bid = right.bid,
		transform(left),
		lookup);
	
	overlimited_matches := join(reduced_bid_matches,overlimit_bids,
		left.beid_high = right.bid,
		transform(left),
		lookup);
	
	// Done with BID linking
	shared final_bid_linking_before_cleave :=
		join(
			distribute(dedup(limited_bids,beid,all),hash64(bid)),
			distribute(reduced_bid_matches,hash64(beid_high)),
			left.bid = right.beid_high,
			transform(Layout_Linking.Working,
				self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
				self := left),
			left outer,
			local) +
		join(
			dedup(overlimited_bids,beid,all),
			overlimited_matches,
			left.bid = right.beid_high,
			transform(Layout_Linking.Working,
				self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
				self := left),
			left outer,
			lookup) : persist('persist::brm::linking::final_linking_before_cleave');
			
	// Find BIDs that are seriously overlinked and send to cleave processing
	cleave_bid_counts :=
		table(
			table(
				final_bid_linking_before_cleave,
				{bid,boolean has_trusted := sum(group,if(MDR.SourceTools.SourceIsDCA(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsEBR(source),1,0)) > 0},
				bid,local),
			{bid,boolean has_trusted := sum(group,if(has_trusted,1,0)) > 0},
			bid);

	cleave_overlimit_bids := cleave_bid_counts(has_trusted);
	
	records_to_send_to_cleave := join(
		distribute(final_bid_linking_before_cleave,hash64(bid)),
		distribute(cleave_overlimit_bids,hash64(bid)),
		left.bid = right.bid,
		transform(left),
		local);
		
	all_cleave_matches := Function_Cleaving(records_to_send_to_cleave);
	
	join_add_ids_for_remaining := join(
		distribute(join_add_ids,hash64(beid)),
		distribute(all_cleave_matches.remaining_records,hash64(beid)),
		left.beid = right.beid,
		transform(left),
		local);
		
	all_leftover_matches := Function_Matching(join_add_ids_for_remaining) : persist('persist::brm::linking::all_leftover_matches');

	reduced_cleave_matches := Function_Closure(all_leftover_matches + all_cleave_matches.core_records,15);

	cleave_reset := join(
		distribute(final_bid_linking_before_cleave,hash64(bid)),
		distribute(cleave_overlimit_bids,hash64(bid)),
		left.bid = right.bid,
		transform(Layout_Linking.Working,
			self.bid := if(right.bid != 0,left.beid,left.bid),
			self := left),
		left outer,
		local);

	cleave_linking := join(
		distribute(dedup(cleave_reset,beid,all),hash64(beid)),
		distribute(reduced_cleave_matches,hash64(beid_high)),
		left.beid = right.beid_high,
		transform(Layout_Linking.Working,
			self.bid := if(right.beid_low = 0,left.bid,right.beid_low),
			self := left),
		left outer,
		local);
	
	final_bid_linking := cleave_linking;
		
	// Now, create BRIDs by matching on state
	final_blid_linking := iterate(
		project(sort(distribute(final_bid_linking,hash64(bid,cbsa_number)),bid,cbsa_number,zip,prim_name,prim_range,brid,blid,local),Layout_Linking.Linked),
		transform(Layout_Linking.Linked,
			self.brid := map(
				right.cbsa_number = '' => 0,
				left.bid = right.bid and left.cbsa_number = right.cbsa_number => left.brid,
				right.brid),
			self.blid := map(
				right.cbsa_number = '' or right.zip = '' or right.prim_name = '' => 0,
				left.bid = right.bid and left.cbsa_number = right.cbsa_number and left.zip = right.zip and left.prim_name = right.prim_name and left.prim_range = right.prim_range => left.blid,
				right.blid),
			self := right),
		local) : persist('persist::brm::linking::final_blid_linking');
			
	// We now want to mark the BIDs, BRIDs, and BLIDs into their respective segments
	export dataset(Layout_Linking.Linked) As_Linking_Master := Function_Apply_Segmentation(final_blid_linking);

end;
