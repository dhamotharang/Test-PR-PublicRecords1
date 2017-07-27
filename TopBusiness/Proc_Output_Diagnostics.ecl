export Proc_Output_Diagnostics(
	dataset(Layout_Linking.Linked) records
) := function

	//
	// Create a dataset showing the zip codes with the most records, not exceeding some limit - this gives us a chance to view
	// linking progress in a small zip code, but to see the entire zip code at once.
	//
	output_small_zip_codes(
		dataset(Layout_Linking.Linked) records
	) := function

		records_filtered_by_zip := records(zip != '');
		table_by_zip := table(table(records_filtered_by_zip,{zip,unsigned cnt := count(group)},zip,local),{zip,unsigned cnt := sum(group,cnt)},zip);
		selected_by_count := table_by_zip(cnt <= 5000);
		
		return output(sort(selected_by_count,-cnt),named('SmallZipCodes'));

	end;
	
	//
	// Create a dataset showing the BIDs with the most records, and display the number of unique names, addresses, etc.,
	// that are present in that BID
	//
	output_largest_bids(
		dataset(Layout_Linking.Linked) records
	) := function

		bidtable := table(table(records,{bid,unsigned cnt := count(group)},bid,local),{bid,unsigned cnt := sum(group,cnt)},bid);

		bidnamefreqs := table(table(records,{bid,company_name,unsigned cnt := count(group)},bid,company_name,local),{bid,company_name,unsigned cnt := sum(group,cnt)},bid,company_name);
		bidnametable := table(table(bidnamefreqs,{bid,unsigned cnt := count(group)},bid,local),{bid,unsigned cnt := sum(group,cnt)},bid);
		bidnamemaxes := dedup(sort(dedup(sort(bidnamefreqs,bid,-cnt,local),bid,local),bid,-cnt),bid);

		bidaddrfreqs := table(table(records,{bid,zip,prim_name,prim_range,unsigned cnt := count(group)},bid,zip,prim_name,prim_range,local),{bid,zip,prim_name,prim_range,unsigned cnt := sum(group,cnt)},bid,zip,prim_name,prim_range);
		bidaddrtable := table(table(bidaddrfreqs,{bid,unsigned cnt := count(group)},bid,local),{bid,unsigned cnt := sum(group,cnt)},bid);
		bidaddrmaxes := dedup(sort(dedup(sort(bidaddrfreqs,bid,-cnt,local),bid,local),bid,-cnt),bid);
		
		joinnamecnt := join(bidtable,bidnametable,
			left.bid = right.bid,
			transform({unsigned6 bid;unsigned rec_cnt;unsigned name_cnt;},
				self.bid := left.bid,
				self.rec_cnt := left.cnt,
				self.name_cnt := right.cnt),
			left outer);
		joinnamemax := join(joinnamecnt,bidnamemaxes,
			left.bid = right.bid,
			transform({recordof(joinnamecnt);bidnamemaxes.company_name;},
				self := right,
				self := left),
			left outer);

		joinaddrcnt := join(joinnamemax,bidaddrtable,
			left.bid = right.bid,
			transform({recordof(joinnamemax);unsigned addr_cnt;},
				self.addr_cnt := right.cnt,
				self := left),
			left outer);
		joinaddrmax := join(joinaddrcnt,bidaddrmaxes,
			left.bid = right.bid,
			transform({recordof(joinaddrcnt);bidaddrmaxes.zip;bidaddrmaxes.prim_name;bidaddrmaxes.prim_range;},
				self := right,
				self := left),
			left outer);
		
		return output(choosen(sort(joinaddrmax,-rec_cnt),200),named('LargestBIDs'));

	end;
	
	//
	// Create a dataset that shows the source documents with the largest number of extract records associated with them.
	// This can be because of a large number of parties on the source doc, or it can be a bad assumption as to how unique
	// the source-docid value is.
	//
	output_common_source_docids(
		dataset(Layout_Linking.Linked) records
	) := function
	
		result_table := table(table(records,
			{source,source_docid,unsigned cnt := count(group)},source,source_docid,local),
			{source,source_docid,unsigned cnt := sum(group,cnt)},source,source_docid);
		
		return output(sort(result_table,-cnt),named('CommonSourceDocids'));

	end;
	
	//
	// Create a dataset that shows a selected ZIP code sorted by street address.
	//
	output_selected_zip(
		dataset(Layout_Linking.Linked) records,
		string5 inzip
	) := function
	
		selected_records := records(zip = inzip);
		sorted_records := sort(selected_records,prim_name,prim_range,bid,company_name,record);
		
		return output(choosen(sorted_records,8000),named('SelectedZip'));
	
	end;

	return parallel(
		output_small_zip_codes(records),
		output_largest_bids(records),
		output_common_source_docids(records),
		output_selected_zip(records,'45449')
	);

end;
