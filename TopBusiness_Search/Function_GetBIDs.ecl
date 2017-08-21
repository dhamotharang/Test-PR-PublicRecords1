import ut;

export dataset(OutputLayout) Function_GetBIDs(
	dataset(InputLayout) in_data_unparsed,
	OptionsLayout in_options) := function
	
	SEARCHLIMIT := 25000;
	
	pattern p_word := pattern('[^ ]+');
	pattern p_ws := pattern('[ ]+');
	pattern p_phrase := p_word (p_ws p_word)*;
	pattern p_find := (p_phrase after (first or p_ws)) before (p_ws or last);

	without_zip_set := parse(
		in_data_unparsed(clean_company_name != ''),
		clean_company_name,
		p_find,
		transform(InputLayout,
			self.ph_phrase := metaphonelib.dmetaphone2(matchtext(p_phrase)),
			self.phrase := matchtext(p_phrase),
			self := left),
		scan all) + in_data_unparsed(clean_company_name = '') : independent;
	
	zip_set_record := record, maxlength(16384)
		recordof(without_zip_set) - [zip];
		set of string5 zip_set;
	end;
	
	in_data := rollup(group(sort(without_zip_set,acctno,record,except zip),record,except zip),group,
		transform(zip_set_record,
			self.zip_set := set(rows(left)(zip != ''),zip),
			self := left));
	
	company_name_rec := record, maxlength(16384)
		in_data.acctno;
		in_data.ph_phrase;
		in_data.phrase;
		in_data.state;
		in_data.zip_set;
		in_data.company_name;
	end;
	
	// Get BIDs by Company Name (and optionally CSZ)
	company_name_bids :=
		join(
			dedup(
				table(in_data(phrase != ''),company_name_rec),
				acctno,ph_phrase,phrase,state,zip_set,company_name,all),
			Keys().CompanyName.QA,
			keyed(left.ph_phrase = right.ph_phrase) and
			keyed(in_options.phoneticcompany or left.phrase = right.phrase) and
			wild(right.core) and
			keyed(left.state = '' or left.state = right.state) and
			keyed(left.zip_set = [] or right.zip in left.zip_set) and
			keyed(left.company_name = right.company_name or not in_options.strict),
			transform({in_data.phrase;OutputLayout},
				self.phrase := left.phrase,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform({in_data.phrase;OutputLayout},
					self.phrase := left.phrase,
					self.lafn := true,
					self := left,
					self := [])));
	
	company_name_lafn_phrases := join(company_name_bids,company_name_bids(lafn),left.acctno = right.acctno and left.phrase = right.phrase,transform(left),left only) + company_name_bids(lafn);
	company_name_bids_counted := table(dedup(company_name_lafn_phrases,acctno,phrase,bid,all),{acctno,phrase,unsigned cnt := count(group)},acctno,phrase);
	company_name_bids_filtered := join(company_name_lafn_phrases,company_name_bids_counted(cnt > SEARCHLIMIT),left.acctno = right.acctno and left.phrase = right.phrase,transform(OutputLayout,self := left),left only);
	
	address_rec := record, maxlength(16384)
		in_data.acctno;
		in_data.state;
		in_data.zip_set;
		in_data.prim_name;
		in_data.prim_range;
		in_data.sec_range;
	end;
	
	// Get BIDs by Address
	address_bids := 
		join(
			dedup(
				table(in_data(state != '' and zip_set != [] and prim_name != ''),address_rec),
				acctno,state,zip_set,prim_name,prim_range,sec_range,all),
			Keys().Address.QA,
			keyed(left.state = right.state) and
			keyed(right.zip in left.zip_set) and
			keyed(left.prim_name = right.prim_name) and
			wild(right.core) and
			keyed(left.prim_range = '' or left.prim_range = right.prim_range) and
			keyed(left.sec_range = '' or left.sec_range = right.sec_range),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Get BIDs by FEIN
	fein_bids := 
		join(
			dedup(
				table(in_data(fein != ''),
					{acctno,fein}),
				acctno,fein,all),
			Keys().FEIN.QA,
			keyed(left.fein = right.fein),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Get BIDs by LLID9
	llid9_bids := 
		join(
			dedup(
				table(in_data(llid9 != 0),
					{acctno,llid9}),
				acctno,llid9,all),
			Keys().LLID9.QA,
			keyed(left.llid9 = right.llid9),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Get BIDs by LLID12
	llid12_bids := 
		join(
			dedup(
				table(in_data(llid12 != 0),
					{acctno,llid12}),
				acctno,llid12,all),
			Keys().LLID12.QA,
			keyed(left.llid12 = right.llid12),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Get BIDs by Phone Number
	phone_number_bids := 
		join(
			dedup(
				table(in_data(phone_number != ''),
					{acctno,phone_number}),
				acctno,phone_number,all),
			Keys().PhoneNumber.QA,
			keyed(left.phone_number = right.phone),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Get BIDs by URL
	url_bids := 
		join(
			dedup(
				table(in_data(cleanurl != ''),
					{acctno,cleanurl}),
				acctno,cleanurl,all),
			Keys().URL.QA,
			keyed(left.cleanurl = right.cleanurl),
			transform(OutputLayout,
				self := right,
				self := left,
				self := []),
			limit(SEARCHLIMIT),
			onfail(
				transform(OutputLayout,
					self.lafn := true,
					self := left,
					self := [])));
	
	// Combine all BIDs to provide a full "leftmost" dataset for stepped join
	complete_bids :=
		company_name_bids_filtered +
		address_bids +
		fein_bids +
		llid9_bids +
		llid12_bids +
		phone_number_bids +
		url_bids;
	
	all_bids_nonexclusionary := 
		if(exists(complete_bids(bid != 0 and not lafn)),
			dedup(complete_bids(bid != 0 and not lafn and (in_options.include_noncore or core)),acctno,bid,all),
			dedup(complete_bids(in_options.include_noncore or core),acctno,bid,all));
	
	expected_hits := rollup(group(sort(in_data,acctno),acctno),group,
		transform({in_data.acctno;unsigned1 hits;},
			self.hits :=
				if(left.phrase != '',1,0) +
				if(left.state != '' and left.zip_set != [] and left.prim_name != '',1,0) +
				if(left.fein != '',1,0) +
				if(left.llid9 != 0,1,0) +
				if(left.llid12 != 0,1,0) +
				if(left.phone_number != '',1,0) +
				if(left.cleanurl != '',1,0),
			self := left));
	
	all_bids_exclusionary_cnt :=
		table(
			(dedup(company_name_bids_filtered,acctno,bid,all) +
			dedup(address_bids,acctno,bid,all) +
			dedup(fein_bids,acctno,bid,all) +
			dedup(llid9_bids,acctno,bid,all) +
			dedup(llid12_bids,acctno,bid,all) +
			dedup(phone_number_bids,acctno,bid,all) +
			dedup(url_bids,acctno,bid,all))(in_options.include_noncore or core),
			{acctno,bid,unsigned cnt := count(group)},
			acctno,bid);
	
	all_bids_exclusionary_select := join(all_bids_exclusionary_cnt,expected_hits,
		left.acctno = right.acctno and
		left.cnt = right.hits,
		transform(left));
	
	all_bids_exclusionary := join(all_bids_nonexclusionary,all_bids_exclusionary_select,
		left.acctno = right.acctno and
		left.bid = right.bid,
		transform(left));
	
	return if(in_options.strict,all_bids_exclusionary,all_bids_nonexclusionary);
	
end;
