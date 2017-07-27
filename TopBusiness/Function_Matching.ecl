import ut,MDR;

export Function_Matching(
	dataset(Layout_Linking.Working) in_data) := function

	// Match where two beids are both UCC or Lien Creditors with a name from a select list, with a blank address.
	join_ucc_lien_select_name_no_address := join(
		in_data((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and source_party[1] != 'D' and company_name != '' and prim_name = '' and zip = ''),
		TopBusiness.Constants.SelectLienCreditorNames,
		left.clean_company_name = right.clean_company_name,
		transform(left),
		lookup);
	rec_ucc_lien_select_name_no_address := table(
		distribute(join_ucc_lien_select_name_no_address,hash64(clean_company_name)),
		{clean_company_name,unsigned beid := min(group,beid)},
		clean_company_name,local);
	same_ucc_lien_select_name_no_address_recs := join(
		distribute(join_ucc_lien_select_name_no_address,hash64(clean_company_name)),
		rec_ucc_lien_select_name_no_address,
		left.clean_company_name = right.clean_company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.UCCLIEN_CREDITOR_SELECTNAME_NOADDR),
		local);
	
	// Match where two beids are both Lien Creditors of the same Lien Debtor beid, and have the same company name.
	join_lien_creditors := join(
		distribute(in_data(MDR.sourceTools.SourceIsLiens(source) and source_party[1] = 'D'),hash64(source,source_docid)),
		distribute(in_data(MDR.sourceTools.SourceIsLiens(source) and source_party[1] = 'C'),hash64(source,source_docid)),
		left.source = right.source and
		left.source_docid = right.source_docid,
		transform(
			{
				unsigned debtor_hash;
				unsigned6 creditor_beid;
				string120 creditor_clean_company_name;
			},
			self.debtor_hash := hash64(left.company_name,left.zip,left.prim_name,left.prim_range),
			self.creditor_beid := right.beid,
			self.creditor_clean_company_name := right.clean_company_name),
		local);
	rec_lien_creditor := table(
		distribute(join_lien_creditors(debtor_hash != 0 and creditor_beid != 0 and creditor_clean_company_name != ''),
			hash64(debtor_hash,creditor_clean_company_name)),
		{debtor_hash,creditor_clean_company_name,unsigned creditor_beid := min(group,creditor_beid)},
		debtor_hash,creditor_clean_company_name,local);
	same_lien_creditor_recs := join(
		distribute(join_lien_creditors(debtor_hash != 0 and creditor_beid != 0 and creditor_clean_company_name != ''),hash64(debtor_hash,creditor_clean_company_name)),
		rec_lien_creditor,
		left.debtor_hash = right.debtor_hash and
		left.creditor_clean_company_name = right.creditor_clean_company_name and
		left.creditor_beid != right.creditor_beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.creditor_beid,
			self.beid_high := left.creditor_beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.LIEN_CREDITOR),
		local);
	
	// Create a table of beid pairs that have the same DUNS and Company Name
	rec_duns_name := table(
		distribute(in_data(duns != '' and clean_company_name != ''),
			hash64(duns,clean_company_name)),
		{duns,clean_company_name,unsigned6 beid := min(group,beid)},
		duns,clean_company_name,local);
	same_duns_name_recs := join(
		distribute(in_data(duns != '' and clean_company_name != ''),hash64(duns,clean_company_name)),
		rec_duns_name,
		left.duns = right.duns and
		left.clean_company_name = right.clean_company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.DUNS_NAME),
		local);
	
	// Create a table of beid pairs that have the same ZOOM-ID and Company Name
	rec_zoom_name := table(
		distribute(in_data(zoom != '' and clean_company_name != ''),
			hash64(zoom,clean_company_name)),
		{zoom,clean_company_name,unsigned6 beid := min(group,beid)},
		zoom,clean_company_name,local);
	same_zoom_name_recs := join(
		distribute(in_data(zoom != '' and clean_company_name != ''),hash64(zoom,clean_company_name)),
		rec_zoom_name,
		left.zoom = right.zoom and
		left.clean_company_name = right.clean_company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.ZOOM_NAME),
		local);
	
	// Create a table of record pairs that have the same residential address and close name
	rec_residential_address_close_name :=
		table(dedup(
			distribute(in_data(clean_company_name != '' and zip != '' and prim_name != '' and residential_or_business_ind = 'A'),
				hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir)),
			zip,prim_range,prim_name,addr_suffix,predir,postdir,clean_company_name,all,local),
			{clean_company_name,beid,unsigned hv := hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir)},local);

	same_residential_address_close_name_recs := join(
		rec_residential_address_close_name,
		rec_residential_address_close_name,
		left.hv = right.hv and
		left.clean_company_name != right.clean_company_name and
		ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.REZADDR_CLOSENAME),
		local);
	
	// Create a table of record pairs that have the same phone-7, same address and close name
	// Need to have sec_range match if a highrise indicator
	rec_phone7_address_close_name :=
		table(dedup(
			distribute(in_data(clean_company_name != '' and zip != '' and prim_name != '' and Validators.IsValidPhone(phone) and (sec_range != '' or not highrise_ind)),
				hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range,(unsigned)phone % 10000000)),
			zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range,(unsigned)phone % 10000000,clean_company_name,all,local),
			{clean_company_name,beid,unsigned hv := hash64(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range,(unsigned)phone % 10000000)},local);

	same_phone7_address_close_name_recs := join(
		rec_phone7_address_close_name,
		rec_phone7_address_close_name,
		left.hv = right.hv and
		ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.PHONE7_ADDR_CLOSENAME),
		local);
	
	// Create a table of record pairs that have the same name and address
	rec_name_address :=
		table(
			distribute(
				table(
					in_data(clean_company_name != '' and zip != '' and prim_name != ''),
					{clean_company_name,zip,prim_name,prim_range,/*addr_suffix,predir,postdir,*/unsigned6 beid := min(group,beid)},
					clean_company_name,zip,prim_name,prim_range,/*addr_suffix,predir,postdir,*/local),
				hash64(clean_company_name,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/)),
			{clean_company_name,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,unsigned6 beid := min(group,beid)},
			clean_company_name,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,local);
	same_name_address_recs := join(
		distribute(in_data(clean_company_name != '' and zip != '' and prim_name != ''),hash64(clean_company_name,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/)),
		rec_name_address,
		left.clean_company_name = right.clean_company_name and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
/*		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir and
		left.postdir = right.postdir and */
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_ADDR),
		local);
	
	// Create a table of record pairs that have the same name and phone
	rec_name_phone := table(
		distribute(in_data((telco_st = '' or state = '' or telco_st = state) and clean_company_name != '' and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),
			hash64(clean_company_name,phone)),
		{clean_company_name,phone,unsigned6 beid := min(group,beid)},
		clean_company_name,phone,local);
	same_name_phone_recs := join(
		distribute(in_data((telco_st = '' or state = '' or telco_st = state) and clean_company_name != '' and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),hash64(clean_company_name,phone)),
		rec_name_phone,
		left.clean_company_name = right.clean_company_name and
		left.phone = right.phone and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_PHONE),
		local);
	
	// Create a table of record pairs that have the same address and phone and are at residential addresses
	rec_residential_address_phone := table(
		distribute(in_data((telco_st = '' or state = '' or telco_st = state) and zip != '' and prim_name != '' and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and residential_or_business_ind = 'A'),
			hash64(zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone)),
		{zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone,unsigned6 beid := min(group,beid)},
		zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone,local);
	same_residential_address_phone_recs := join(
		distribute(in_data((telco_st = '' or state = '' or telco_st = state) and zip != '' and prim_name != '' and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and residential_or_business_ind = 'A'),hash64(zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone)),
		rec_residential_address_phone,
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
/*		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir and
		left.postdir = right.postdir and */
		left.phone = right.phone and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.REZADDR_PHONE),
		local);
	
	// Create a table of record pairs that have the same name and fein
	rec_name_fein :=
		table(dedup(
			distribute(in_data(clean_company_name != '' and length(trim(fein)) = 9),hash64(clean_company_name,fein)),
			clean_company_name,fein,duns,beid,all,local),
			{clean_company_name,fein,duns,beid},local);
	same_name_fein_recs := join(
		rec_name_fein,
		rec_name_fein,
		left.clean_company_name = right.clean_company_name and
		left.fein = right.fein and
		(left.duns = '' or right.duns = '' or left.duns = right.duns) and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_FEIN),
		local);
	
	// Create a table of record pairs that have the same incorp data and match on name or address
	rec_incorp :=
		table(dedup(
			distribute(in_data(incorp_state != '' and incorp_number != ''),hash64(incorp_state,incorp_number)),
			incorp_state,incorp_number,clean_company_name,zip,prim_name,prim_range,beid,all,local),
			{incorp_state,incorp_number,clean_company_name,zip,prim_name,prim_range,beid});
	same_incorp_recs := join(
		rec_incorp,
		rec_incorp,
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
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.INCORP),
		local);
	
	// Create a table of record pairs that have the same name and url
	rec_name_url_nozoom_bottom := table(
		distribute(in_data(clean_company_name != '' and url != '' and not MDR.sourceTools.SourceIsZoom(source)),hash64(clean_company_name,url)),
		{clean_company_name,url,unsigned6 beid := min(group,beid)},
		clean_company_name,url,local);
	same_name_url_nozoom_bottom_recs := join(
		distribute(in_data(clean_company_name != '' and url != ''),hash64(clean_company_name,url)),
		rec_name_url_nozoom_bottom,
		left.clean_company_name = right.clean_company_name and
		left.url = right.url and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_URL),
		local);
	rec_name_url_zoom_bottom := table(
		distribute(in_data(clean_company_name != '' and url != '' and MDR.sourceTools.SourceIsZoom(source)),hash64(clean_company_name,url)),
		{clean_company_name,url,unsigned6 beid := min(group,beid)},
		clean_company_name,url,local);
	same_name_url_zoom_bottom_recs := join(
		distribute(in_data(clean_company_name != '' and url != '' and not MDR.sourceTools.SourceIsZoom(source)),hash64(clean_company_name,url)),
		rec_name_url_zoom_bottom,
		left.clean_company_name = right.clean_company_name and
		left.url = right.url and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_URL),
		local);
	same_name_url_recs := same_name_url_nozoom_bottom_recs + same_name_url_zoom_bottom_recs;
	
	// Create a table of record pairs that have the same fein and address and DUNS
	dist_fein_address_duns := distribute(in_data(length(trim(fein)) = 9 and zip != '' and prim_name != '' and length(trim(duns)) = 9),hash64(fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,duns));
	rec_fein_address_duns := table(
		dist_fein_address_duns,
		{fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,duns,unsigned6 beid := min(group,beid)},
		fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,duns,local);
	same_fein_address_duns_recs := join(
		dist_fein_address_duns,
		rec_fein_address_duns,
		left.fein = right.fein and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
/*		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir and
		left.postdir = right.postdir and */
		left.duns = right.duns and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.FEIN_ADDR_DUNS),
		local);
	
	// Create a table of record pairs that have the same fein and address and phone
	dist_fein_address_phone := distribute(in_data(length(trim(fein)) = 9 and zip != '' and prim_name != '' and (telco_st = '' or state = '' or telco_st = state) and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),hash64(fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone));
	rec_fein_address_phone := table(
		dist_fein_address_phone,
		{fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone,unsigned6 beid := min(group,beid)},
		fein,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,phone,local);
	same_fein_address_phone_recs := join(
		dist_fein_address_phone,
		rec_fein_address_phone,
		left.fein = right.fein and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
/*		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir and
		left.postdir = right.postdir and */
		left.phone = right.phone and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.FEIN_ADDR_PHONE),
		local);
	
	// Create a table of record pairs that have the same EBR file number and address
	dist_experian_address := distribute(in_data(experian != '' and zip != '' and prim_name != ''),hash64(experian,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/));
	rec_experian_address := table(
		dist_experian_address,
		{experian,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,unsigned6 beid := min(group,beid)},
		experian,zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,local);
	same_experian_address_recs := join(
		dist_experian_address,
		rec_experian_address,
		left.experian = right.experian and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.EXPERIAN_ADDR),
		local);
	
	// Create a table of record pairs that have the same EBR file number and close name
	rec_experian_close_name :=
		table(dedup(
			distribute(in_data(experian != '' and clean_company_name != ''),
				hash64(experian)),
			experian,clean_company_name,beid,local),
			{clean_company_name,beid,unsigned hv := hash64(experian)});
	same_experian_close_name_recs := join(
		rec_experian_close_name,
		rec_experian_close_name,
		left.hv = right.hv and
		ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.EXPERIAN_CLOSENAME),
		local);

	// Create a table of record pairs that have the same UCC or lien and address
	dist_ucc_lien_address := distribute(in_data((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and zip != '' and prim_name != ''),hash64(source,source_docid,source_party[1],zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/));
	rec_ucc_lien_address := table(
		dist_ucc_lien_address,
		{source,source_docid,string1 source_party1 := source_party[1],zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,unsigned6 beid := min(group,beid)},
		source,source_docid,source_party[1],zip,prim_name,prim_range/*,addr_suffix,predir,postdir*/,local);
	same_ucc_lien_address_recs := join(
		dist_ucc_lien_address,
		rec_ucc_lien_address,
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party[1] = right.source_party1 and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
/*		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir and
		left.postdir = right.postdir and */
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.UCCLIEN_ADDR),
		local);
	
	// Create a table of record pairs that have the same UCC or lien and name
	dist_ucc_lien_name := distribute(in_data((MDR.sourceTools.SourceIsLiens(source) or MDR.sourceTools.SourceIsUCCs(source)) and clean_company_name != ''),hash64(source,source_docid,source_party[1],clean_company_name));
	rec_ucc_lien_name := table(
		dist_ucc_lien_name,
		{source,source_docid,string1 source_party1 := source_party[1],clean_company_name,unsigned6 beid := min(group,beid)},
		source,source_docid,source_party[1],clean_company_name,local);
	same_ucc_lien_name_recs := join(
		dist_ucc_lien_name,
		rec_ucc_lien_name,
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party[1] = right.source_party1 and
		left.clean_company_name = right.clean_company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.UCCLIEN_NAME),
		local);
	
	// Create a table of record pairs that have blank addresses and the same toll-free phone and name and ZIP (including blank ZIP)
	dist_tfphone_name_zip := distribute(in_data(Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and company_name != ''),hash64(phone,company_name,zip));
	rec_tfphone_name_zip := table(
		dist_tfphone_name_zip,
		{phone,company_name,zip,unsigned6 beid := min(group,beid)},
		phone,company_name,zip,local);
	same_tfphone_name_zip_recs := join(
		dist_tfphone_name_zip,
		rec_tfphone_name_zip,
		left.phone = right.phone and
		left.company_name = right.company_name and
		left.zip = right.zip and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.TFPHONE_NAME_ZIP),
		local);
	
	// Create a table of record pairs that have blank addresses and the same toll-free phone and name and city and state
	dist_tfphone_name_city_state := distribute(in_data(Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] in ['800','888','877','866','855'] and prim_name = '' and city_name != '' and state != '' and company_name != ''),hash64(phone,company_name,zip));
	rec_tfphone_name_city_state := table(
		dist_tfphone_name_city_state,
		{phone,company_name,city_name,state,unsigned6 beid := min(group,beid)},
		phone,company_name,city_name,state,local);
	same_tfphone_name_city_state_recs := join(
		dist_tfphone_name_city_state,
		rec_tfphone_name_city_state,
		left.phone = right.phone and
		left.company_name = right.company_name and
		left.city_name = right.city_name and
		left.state = right.state and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.TFPHONE_NAME_CITY_STATE),
		local);
	
	// Create a table of record pairs that have blank street name, and same company name and NPANXX
	dist_name_zip_npanxx := distribute(in_data(company_name != '' and prim_name = '' and (telco_st = '' or state = '' or telco_st = state) and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),hash64((unsigned)zip,phone[1..6],company_name));
	rec_name_zip_npanxx := table(dist_name_zip_npanxx,
		{company_name,unsigned zip := (unsigned)zip,string6 npanxx := phone[1..6],unsigned beid := min(group,beid)},
		company_name,(unsigned)zip,phone[1..6],local);
	same_name_zip_npanxx_recs := join(
		dist_name_zip_npanxx,
		rec_name_zip_npanxx,
		(unsigned)left.zip = right.zip and
		left.phone[1..6] = right.npanxx and
		left.company_name = right.company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.NAME_ZIP_NPANXX),
		local);

	// Create a table of record pairs that have the same prim RANGE, zip code, and company name
	dist_pr_zip_name := distribute(in_data(prim_range != '' and zip != '' and clean_company_name != ''),hash64(prim_range,zip,clean_company_name));
	rec_pr_zip_name := table(dist_pr_zip_name,
		{prim_range,zip,clean_company_name,unsigned beid := min(group,beid)},
		prim_range,zip,clean_company_name,local);
	same_pr_zip_name_recs := join(
		dist_pr_zip_name,
		rec_pr_zip_name,
		left.prim_range = right.prim_range and
		left.zip = right.zip and
		left.clean_company_name = right.clean_company_name and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.PRIMRANGE_ZIP_NAME),
		local);

	// Create a table of record pairs that have the same company name, zip, and phone but no address
	dist_name_zip_phone_blank_pn := distribute(
		in_data(zip != '' and (telco_st = '' or state = '' or telco_st = state) and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855'] and clean_company_name != '' and prim_name = ''),
		hash64(zip,phone,clean_company_name));
	rec_name_zip_phone_blank_pn := dedup(table(dist_name_zip_phone_blank_pn,
		{zip,phone,clean_company_name,unsigned6 min_beid := min(group,beid)},zip,phone,clean_company_name,local),zip,phone,clean_company_name,all,local);
	same_name_zip_phone_blank_pn_recs := join(
		dist_name_zip_phone_blank_pn,
		rec_name_zip_phone_blank_pn,
		left.zip = right.zip and
		left.phone = right.phone and
		left.clean_company_name = right.clean_company_name and
		left.beid != right.min_beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.min_beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.ZIP_PHONE_NAME_BLANK_CN),
		local);

	// Create a table of record pairs that have the same source-docid and source-party
	dist_sourceparty := distribute(in_data,hash64(source,source_docid,source_party));
	rec_sourceparty := table(dist_sourceparty,
		{source,source_docid,source_party,unsigned beid := min(group,beid)},
		source,source_docid,source_party,local);
	same_sourceparty_recs := join(
		dist_sourceparty,
		rec_sourceparty,
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party = right.source_party and
		left.beid != right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := right.beid,
			self.beid_high := left.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.SOURCEPARTY),
		local);

	// Create a table of record pairs that have the same source docid and close name
	rec_source_docid_close_name :=
		table(dedup(
			distribute(in_data((
				MDR.sourceTools.SourceIsJigsaw(source) OR
				MDR.sourceTools.SourceIsDunn_Bradstreet(source) OR
				MDR.sourceTools.SourceIsGong_Business(source)) and source_docid != '' and clean_company_name != ''),
				hash64(source,source_docid)),
			source,source_docid,clean_company_name,local),
			{clean_company_name,beid,unsigned hv := hash64(source,source_docid)});
	same_source_docid_close_name_recs := join(
		rec_source_docid_close_name,
		rec_source_docid_close_name,
		left.hv = right.hv and
		ut.StringSimilar100(left.clean_company_name,right.clean_company_name) < 30 and
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.SOURCEDOCID_CLOSENAME),
		local);

	// Create a table of record pairs that have the same source docid and address and phone number
	rec_source_docid_address :=
		table(dedup(
			distribute(in_data((
				MDR.sourceTools.SourceIsJigsaw(source) OR
				MDR.sourceTools.SourceIsDunn_Bradstreet(source) OR
				MDR.sourceTools.SourceIsGong_Business(source)) and source_docid != '' and zip != '' and prim_name != '' and Validators.IsValidPhone(phone) and length(trim(phone)) = 10 and phone[1..3] not in ['800','888','877','866','855']),
				hash64(source,source_docid,zip,prim_name,prim_range,phone)),
			source,source_docid,zip,prim_name,prim_range,phone,local),
			{zip,prim_name,prim_range,phone,beid,unsigned hv := hash64(source,source_docid)});
	same_source_docid_address_recs := join(
		rec_source_docid_address,
		rec_source_docid_address,
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
		left.phone = right.phone and
		left.hv = right.hv and
		left.beid < right.beid,
		transform(Layout_Linking.Match,
			self.beid_low := left.beid,
			self.beid_high := right.beid,
			self.matchcode := TopBusiness.Constants.MatchCodes.SOURCEDOCID_ADDRESS),
		local);

	all_records :=
		same_ucc_lien_select_name_no_address_recs +
		same_lien_creditor_recs +
		// same_residential_address_close_name_recs +
		same_name_address_recs +
		same_name_phone_recs +
		// same_residential_address_phone_recs +
		same_phone7_address_close_name_recs +
		same_name_fein_recs +
		same_incorp_recs +
		same_name_url_recs +
		same_fein_address_duns_recs +
		same_fein_address_phone_recs +
		same_experian_close_name_recs +
		// same_experian_address_recs +
		// same_ucc_lien_address_recs +
		same_ucc_lien_name_recs +
		same_duns_name_recs +
		same_zoom_name_recs +
		same_tfphone_name_zip_recs +
		same_tfphone_name_city_state_recs +
		same_name_zip_npanxx_recs +
		same_pr_zip_name_recs +
		same_name_zip_phone_blank_pn_recs +
		same_sourceparty_recs +
		same_source_docid_close_name_recs;
		// same_source_docid_address_recs;
	
	rollupall := rollup(sort(distribute(all_records,hash64(beid_low,beid_high)),beid_low,beid_high,local),
		left.beid_low = right.beid_low and
		left.beid_high = right.beid_high,
		transform(Layout_Linking.Match,
			self.matchcode := left.matchcode | right.matchcode,
			self := left),
		local);
	
	// rollupall := rollup(sort(rollupundist,beid_low,beid_high),
		// left.beid_low = right.beid_low and
		// left.beid_high = right.beid_high,
		// transform(Layout_Linking.Match,
			// self.matchcode := left.matchcode | right.matchcode,
			// self := left));
	
	return rollupall;

end;
