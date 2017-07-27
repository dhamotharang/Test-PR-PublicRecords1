import doxie_cbrs,ut;

export fn_RSS_attachParentInfo(dataset(business_header.layout_biz_search.final) indata, boolean USE_GID, boolean ONLY_SHOW_PARENTS_FROM_DCA) := function
	
	// Get all results from the first 100 that have a "narrow" set of BDIDs.
	temp_group_ids_with_multi_bdid_flag := dedup(sort(project(choosen(indata,100)(multi_bdid_flag),transform(doxie_cbrs.layout_references,
		self.bdid := left.group_id)),bdid),bdid);
	
	// Get the "best" information for every group ID associate with the above "narrow" sets of BDIDs.
	temp_group_ids_with_best_information := doxie_cbrs.fn_best_information(temp_group_ids_with_multi_bdid_flag,true)(
		fromdca OR NOT ONLY_SHOW_PARENTS_FROM_DCA);
	
	// Create the timezone field on the data.
	temp_group_ids_plus_tz_field := project(temp_group_ids_with_best_information,
		transform({recordof(temp_group_ids_with_best_information);string4 timezone},
			self.timezone := '',
			self := left));
	
	// Populate the timezone field
	ut.getTimeZone(temp_group_ids_plus_tz_field,phone,timezone,temp_group_ids_plus_timezone);
	
	// Join the parent data to the larger dataset.
	temp_best_records_with_parent_info := join(indata,temp_group_ids_plus_timezone,
		(string)left.group_id = right.bdid,
		transform(business_header.layout_biz_search.final,
			self.group_id_fromdca := right.fromdca,
			self.group_id_company_name := right.company_name,
			self.group_id_prim_range := right.prim_range,
			self.group_id_predir := right.predir,
			self.group_id_prim_name := right.prim_name,
			self.group_id_addr_suffix := right.addr_suffix,
			self.group_id_postdir := right.postdir,
			self.group_id_unit_desig := right.unit_desig,
			self.group_id_sec_range := right.sec_range,
			self.group_id_city := right.city,
			self.group_id_state := right.state,
			self.group_id_zip := (unsigned3)right.zip,
			self.group_id_zip4 := (unsigned2)right.zip4,
			self.group_id_phone := if((unsigned6)right.phone % 10000000 != 0,(unsigned6)right.phone,0),
			self.group_id_timezone := right.timezone,
			self.group_id_fein := (unsigned4)right.fein,
			self.bdid_list := if(right.fromdca OR NOT ONLY_SHOW_PARENTS_FROM_DCA,left.bdid_list,(string)left.group_id),
			self := left),left outer);
	
	// If we are using GID instead of the BDID, get the parent info... otherwise, just keep the data set as is.
	temp_best_records_with_or_without_parent_info := if(USE_GID,temp_best_records_with_parent_info,indata);
	
	// Sort by score and choose the top 1000 results.
	temp_best_records_top_1000 := topn(temp_best_records_with_or_without_parent_info,1000,
		-score,-best_flags,-if(exists(contactrecs),1,0),-contact_score,-if(group_id_company_name != '',1,0));
	
	return temp_best_records_top_1000;

end;
