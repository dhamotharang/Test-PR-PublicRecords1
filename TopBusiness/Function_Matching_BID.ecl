import ut,MDR;

export Function_Matching_BID(
	dataset(Layout_Linking.Working) in_data) := function

	tempzipnoprimrange := in_data(zip != '' and prim_range = '' and prim_name[1..7] != 'PO BOX ');
	tempznprtable := dedup(tempzipnoprimrange,company_name,zip,prim_name,bid,all);

	tempfulladdr := in_data(zip != '' and prim_name != '' and (prim_range != '' or prim_name[1..7] = 'PO BOX '));
	tempfadedup := dedup(tempfulladdr,zip,company_name,bid,all);
	tempfatable := table(tempfadedup,{zip,company_name,unsigned cnt:=count(group)},zip,company_name);
	tempbacktable := join(tempfatable(cnt = 1),tempfadedup,left.zip = right.zip and left.company_name = right.company_name,transform(right));

	join_zip_name_match := join(tempznprtable,tempbacktable,
		left.zip = right.zip and
		left.company_name = right.company_name and
		left.bid != right.bid,
		transform(Layout_Linking.Match_BID,
			self.beid_low := left.beid,
			self.bid_low := left.bid,
			self.beid_high := right.beid,
			self.bid_high := right.bid,
			self.matchcode := Constants.MatchCodes.BID_ZIP_NAME));
	
	output(join_zip_name_match,,'~thor_data400::base::brm::joinzipnamematch::lheureux',overwrite);
	
	sfcn(string s) := stringlib.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	
	rec_addr_initss_0 :=
		dedup(table(distribute(
			// don't include property data, as it's too dirty to do this initial-substring matching with.
			in_data(not MDR.sourceTools.SourceIsProperty(source) and length(trim(sfcn(company_name))) >= 5 and zip != '' and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and (sec_range != '' or not highrise_ind)),
			hash64(zip,prim_name,prim_range,sfcn(company_name)[1..5])),{unsigned hv := hash64(zip,prim_name,prim_range,sfcn(company_name)[1..5]),sec_range,string filt_company_name := sfcn(company_name),bid,beid}),
			hv,sec_range,filt_company_name,bid,all,local);
	
	over_10000_rec_addr_initss := table(table(rec_addr_initss_0,{hv,unsigned cnt := count(group)},hv,local),{hv,unsigned cnt := sum(group,cnt)},hv)(cnt > 10000);
	
	rec_addr_initss := join(rec_addr_initss_0,over_10000_rec_addr_initss,left.hv = right.hv,transform(left),left only,lookup);

	same_addr_initss_recs := join(rec_addr_initss,rec_addr_initss,
		left.hv = right.hv and
		(left.sec_range = '' or right.sec_range = '' or left.sec_range = right.sec_range) and
		left.bid != right.bid and
		left.filt_company_name not in ['CORPORATION','NATIONAL'] and
		length(trim(left.filt_company_name)) < length(trim(right.filt_company_name)) and
		trim(left.filt_company_name) = right.filt_company_name[1..length(trim(left.filt_company_name))],
		transform(Layout_Linking.Match_BID,
			self.beid_low := right.beid,
			self.bid_low := right.bid,
			self.beid_high := left.beid,
			self.bid_high := left.bid,
			self.matchcode := TopBusiness.Constants.MatchCodes.ADDR_INITSS),
		local);
	
	// Create a table of record pairs that have the same fein and address and where one's company name is the initial substring of the other
	rec_fein_address_namesubstring :=
		dedup(table(distribute(
			in_data(length(trim(clean_company_name)) >= 5 and length(trim(fein)) = 9 and zip != '' and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and (sec_range != '' or not highrise_ind)),
			hash64(fein,zip,prim_name,prim_range,clean_company_name[1..5],sec_range)),{unsigned hv := hash64(fein,zip,prim_name,prim_range,clean_company_name[1..5],sec_range),clean_company_name,bid,beid}),
			hv,clean_company_name,bid,all,local);

	same_fein_address_namesubstring_recs := join(rec_fein_address_namesubstring,rec_fein_address_namesubstring,
		left.hv = right.hv and
		left.bid != right.bid and
		left.clean_company_name not in ['CORPORATION','NATIONAL'] and
		length(trim(left.clean_company_name)) < length(trim(right.clean_company_name)) and
		trim(left.clean_company_name) = right.clean_company_name[1..length(trim(left.clean_company_name))],
		transform(Layout_Linking.Match_BID,
			self.beid_low := right.beid,
			self.bid_low := right.bid,
			self.beid_high := left.beid,
			self.bid_high := left.bid,
			self.matchcode := TopBusiness.Constants.MatchCodes.FEIN_ADDR_NAMESUBSTR),
		local);
	
	// Create a table of record pairs that have the a similar RANGE, zip code, phone number and similar company name
	reduce_zip_phone_close_name_pr :=
		dedup(
			dedup(
				in_data(prim_range != '' and zip != '' and clean_company_name != '' and (telco_st = '' or state = '' or telco_st = state) and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),
				bid,prim_range,phone,zip[1..3],clean_company_name,all,local),
			prim_range,phone,zip[1..3],clean_company_name,all);
	dist_zip_phone_close_name_pr := distribute(
		reduce_zip_phone_close_name_pr,
		hash64(zip[1..3],phone));
	rec_zip_phone_close_name_pr := dedup(table(dist_zip_phone_close_name_pr,
		{prim_range,string3 zip3 := zip[1..3],phone,clean_company_name,beid,bid},local),record,all,local);
	same_zip_phone_close_name_pr_recs := join(
		rec_zip_phone_close_name_pr,
		rec_zip_phone_close_name_pr,
		left.zip3 = right.zip3 and
		left.phone = right.phone and
		abs((integer)left.prim_range - (integer)right.prim_range) < 100 and
		ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
		left.bid > right.bid,
		transform(Layout_Linking.Match_BID,
			self.beid_low := right.beid,
			self.bid_low := right.bid,
			self.beid_high := left.beid,
			self.bid_high := left.bid,
			self.matchcode := TopBusiness.Constants.MatchCodes.ZIP_PHONE_CLOSE_PR_NAME),
		local);

	all_records :=
		// join_zip_name_match +
		same_addr_initss_recs +
		same_fein_address_namesubstring_recs +
		same_zip_phone_close_name_pr_recs;
	
	rollupundist := rollup(sort(all_records,beid_low,beid_high,local),
		left.beid_low = right.beid_low and
		left.beid_high = right.beid_high,
		transform(Layout_Linking.Match_BID,
			self.matchcode := left.matchcode | right.matchcode,
			self := left),
		local);
	
	rollupall := rollup(sort(rollupundist,beid_low,beid_high),
		left.beid_low = right.beid_low and
		left.beid_high = right.beid_high,
		transform(Layout_Linking.Match_BID,
			self.matchcode := left.matchcode | right.matchcode,
			self := left));
	
	return rollupall;

end;
