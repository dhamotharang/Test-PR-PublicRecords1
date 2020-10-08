import business_header_ss, MDR, Doxie;

export fn_RSS_rollupBestRecords(grouped dataset(business_header.layout_biz_search.result_dateRange ) display_set, doxie.IDataAccess mod_access, unsigned1 ROLLUP_LIMIT) := function
	
	// Get just the group IDs for all records
	temp_group_ids_only := project(dedup(display_set,group_id,bdl),transform(business_header.layout_biz_search.no_group_info,
		self.group_id := left.group_id,
		self.bdl := left.bdl,
		self := []));

	// Pull together the set of names for each group ID.
	temp_names_by_group_id := dedup(sort(project(
		dedup(sort(display_set,company_name,-best_flags,-score),company_name),
		transform(business_header.layout_biz_search.name_rec_ext,	
			self.n := left,
			self := left)),-n.best_flags,-n.score),true,keep ROLLUP_LIMIT);
	
	// Attach the names to group IDs.
	temp_group_ids_plus_names := denormalize(temp_group_ids_only,temp_names_by_group_id,
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(business_header.layout_biz_search.no_group_info,
			self.nameRecs := topn(left.nameRecs + right.n,200,-best_flags,-score),
			self := left));
	
	// Pull together the set of addresses for each group ID.
	temp_addresses_by_group_id_tmp := dedup(sort(rollup(project(
		sort(display_set,prim_range,prim_name,city,state,zip,zip4,addr_suffix,best_flags,score),
		transform(business_header.layout_biz_search.address_rec_ext,
			self.a.zip := if(left.zip > 0,intformat(left.zip,5,1),''),
			self.a.zip4 := if(left.zip4 > 0,intformat(left.zip4,4,1),''),
			self.a.phoneRecs := if(left.phone % 10000000 != 0,dataset([{left.phone,left.timezone,false}],business_header.layout_biz_search.phone_rec),dataset([],business_header.layout_biz_search.phone_rec)),
      self.a.firstSeenDate := left.firstSeenDate,
			self.a.lastSeenDate := left.lastSeenDate,
			self.a := left,
			self := left)),
		transform(
			business_header.layout_biz_search.address_rec_ext,
			self.a.phoneRecs := choosen(dedup(sort(left.a.phoneRecs + right.a.phoneRecs,record),record),50),
			self.a.dt_last_seen := if(left.a.dt_last_seen > right.a.dt_last_seen,left.a.dt_last_seen,right.a.dt_last_seen),
			self.a := right.a,
			self := right),
		a.prim_range + a.prim_name + a.city + a.state + a.zip + a.zip4 + a.addr_suffix),-a.best_flags,-a.score),true,keep ROLLUP_LIMIT);

 boolean phoneCheck(dataset (business_header.layout_biz_search.phone_rec) r) := function	   
	   phoneThere := r[1].phone != 0;
		 return phoneThere;
	end;
	
 	temp_addresses_by_group_tmp_phone := project(ungroup(temp_Addresses_by_group_id_tmp),
	                                              transform(business_header.layout_biz_search.address_rec_extPhone,
																								self.phoneExists := phoneCheck(left.a.phonerecs);
																								self := left));																							
  // contains recs that have no prim name and no phone																								
	temp_addresses_by_group_id_nostreetNme2 := project(temp_addresses_by_group_tmp_phone(a.prim_name = '' and ~phoneExists),
                                               transform(business_header.layout_biz_search.address_rec_ext,
																									   self := left));
  // dedup sort this set
	temp_addresses_by_group_id_nostreetNme := dedup(sort(temp_addresses_by_group_id_nostreetNme2, 
	                                                group_id, bdl, -a.best_flags,-a.score), 
	                                                group_id, bdl);
  // now get the set of recs that does have a primname Or a phone																									
  temp_addresses_by_group_id_streetNme	:= project(temp_addresses_by_group_tmp_phone(a.prim_name != '' OR phoneExists),
	                                           transform(business_header.layout_biz_search.address_rec_ext,
																									   self := left));																																															
	
	                                           
	// this join take care of keeping sets of recs with unique group_id/bdl but that don't have the same group_id/bdl                                           	 
	// in set of recs that does have either prim_name or phone number.  
	temp_addresses := join( temp_addresses_by_group_id_nostreetNme, temp_addresses_by_group_id_streetNme,
	                       left.group_id = right.group_id AND
												 left.bdl = right.bdl,
	                       transform(recordof(left),
												 self := left), left only);			
  
	// needed to do this join order to account for the roxie option 'exclude blank addresses' 
	// because to maintain currently functionality had to ensure that within a group_id grouping 
	// at least 1 rec has a city on it in order to keep entire group_id row(s).
	// otherwise the group_id row(s) were being excluded downstream in the process if the 'exclude blank addresses' was turned on
  temp_addresses_city := join(temp_addresses_by_group_id_nostreetNme, // contains rec I want
	                            temp_addresses_by_group_id_streetNme(a.city = ''), // any recs that don't have city
															                                                   // that are already being kept
															left.group_id = right.group_id AND
															left.bdl = right.bdl,
															transform(recordof(left),
															self := left));
  // now figure out if temp_addresses_city does need to be kept
	// so develop a set of recs which will help in logic to tell if temp_address_city really need to be put back into mix	
	// or whether there are other recs within that group_id that have a city in them so that way no need to
	// add back in temp_addresses_city because there are additional recs within that group_id that have city
	// so that group_id row(s) will not get excluded by the roxie option 'exclude blank addresses'
  temp_addresses_withCity := join(temp_addresses_city,
	                            temp_addresses_by_group_id_streetNme(a.city != ''),
															left.group_id = right.group_id AND
															left.bdl = right.bdl,
															transform(recordof(left),
															self := left));
  //   find set of recs with same group_id/bdl as temp_addresses_city already in the set of recs with either street name or phone #
	//   The existence of temp_addresses_city_2 is used below to know whether or not to add temp_addresses_city back into entire set.
  temp_addresses_city_2 := join(temp_addresses_city, temp_addresses_by_group_id_streetNme,
	                           left.group_id = right.group_id AND
														 left.bdl = right.bdl,
														 transform(recordof(left),
															 self := left), left only);
															 
	temp_addresses_by_group_id := group(temp_addresses_by_group_id_streetNme +  
	                               if ((count(temp_addresses_city_2) = 0 and count(temp_addresses_withCity) = 0),
																     temp_addresses_city,
																		 temp_addresses_city_2) +																      
	                                    temp_addresses, 
																			group_id, bdl);
	// Attach the addresses to group IDs.
	temp_group_ids_plus_addresses := denormalize(temp_group_ids_plus_names,temp_addresses_by_group_id,
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(business_header.layout_biz_search.no_group_info,
			self.addressRecs := topn(left.addressRecs + right.a,200,-best_flags,-score),
			self := left));

	// Pull together the set of FEINs for each group ID.
	temp_feins_by_group_id := dedup(project(
		dedup(sort(display_set,fein),fein),
		transform(business_header.layout_biz_search.fein_rec_ext,
			self.f := left,
			self := left)),true,keep ROLLUP_LIMIT);

	// Attach the FEINs to group IDs.
	temp_group_ids_plus_feins := denormalize(temp_group_ids_plus_addresses,temp_feins_by_group_id,
		left.group_id = right.group_id and
		left.bdl = right.bdl and
		right.f.fein != 0,
		transform(business_header.layout_biz_search.no_group_info,
			self.FEINRecs := choosen(left.FEINRecs + right.f,50),
			self := left));

	// Pull together the set of contacts for each group ID.
	temp_contacts_by_group_id := rollup(project(
		sort(display_set,lname + fname + mname + name_suffix,ssn,company_title),
		transform(business_header.layout_biz_search.contact_rec_ext,
			self.c.company_titles := if(left.company_title <> '',dataset([{left.company_title}],business_header.layout_biz_search.title_rec),dataset([],business_header.layout_biz_search.title_rec)),
			self.c := left,
			self := left)),
		transform(business_header.layout_biz_search.contact_rec_ext,
			self.c.company_titles := choosen(dedup(sort(left.c.company_titles + right.c.company_titles,record),record),25),
			self.c := right.c,
			self.contact_score := if(left.contact_score > right.contact_score,left.contact_score,right.contact_score),
			self := right),
		c.lname + c.fname + c.mname + c.name_suffix, c.ssn);
		
	// Attach the contacts to group IDs.
	temp_group_ids_plus_contacts := denormalize(temp_group_ids_plus_feins,temp_contacts_by_group_id,
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(business_header.layout_biz_search.no_group_info,
			self.contactRecs := choosen(left.contactRecs + right.c,100),
			self.contact_score := if(left.contact_score > right.contact_score,left.contact_score,right.contact_score),
			self := left));
	
	// Pull together the set of BDIDs for each group ID.
	temp_bdids_by_group_id := project(sort(dedup(sort(display_set,bdid,-best_flags,-score),bdid),-best_flags,score,bdid),
		transform(business_header.layout_biz_search.bdid_rec_ext,
			self.b := left,
			self := left));
	
	// Attach the BDIDs to group IDs.
	temp_group_ids_plus_bdids := denormalize(temp_group_ids_plus_contacts,temp_bdids_by_group_id,
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(business_header.layout_biz_search.no_group_info,
			tempLimitList := length(left.bdid_list) > 1200;
			self.BDIDRecs := choosen(if(tempLimitList,left.bdidrecs(false),left.bdidrecs + right.b),2000),
			self.group_id := if(tempLimitList,0,left.group_id),
			self.bdid_list := if(tempLimitList,(string)left.group_id,if(left.group_id != 0,left.bdid_list + right.b.bdid + ',',(string)left.bdid_list)),
			self.score := if(left.score > right.score,left.score,right.score),
			self.best_flags := if(left.best_flags > right.best_flags,left.best_flags,right.best_flags),
			self := left));
	
	// Set some flags and finish formatting the BDID list.
	temp_group_ids_plus_bdids_cleaned := project(temp_group_ids_plus_bdids,transform(business_header.layout_biz_search.final,
		self.bdid_list := if(left.group_id != 0,'{' + left.bdid_list[1..length(left.bdid_list) - 1] + '}',left.bdid_list),
		self.multi_bdid_flag := if(left.group_id != 0,true,false),
		self.group_id := if(left.group_id != 0,left.group_id,(unsigned6)left.bdid_list),
		self := left));
	
	// Get each group_id that's multi-bdid and reset those with < 250 records
	temp_multi_group_ids_with_small_counts := function
		// Create the list of group IDs
		temp1st := join(
			dedup(sort(project(temp_group_ids_plus_bdids_cleaned(multi_bdid_flag),transform({unsigned6 list_group_id},
				self.list_group_id := left.group_id)),list_group_id),list_group_id),
			business_header.Key_BH_SuperGroup_BDID,
			keyed (left.list_group_id = right.bdid), keep (1), limit (0));
		// Get all the associated BDIDs
		temp2nd := join(temp1st,business_header.Key_BH_SuperGroup_GroupID,
			left.group_id = right.group_id,transform(recordof(temp1st),
				self.bdid := right.bdid,
				self := left),limit(100,skip));
		// Gather all the associated records
		temp3rd := join(temp2nd,business_header_ss.Key_BH_BDID_pl,left.bdid = right.bdid and
      doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.source) AND
      doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			transform(left),limit(10000,skip));
		// Sort and table by Group ID to count how many records are associated
		temp4th := sort(temp3rd,list_group_id);
		temp5th := table(temp4th,{list_group_id,unsigned cnt := count(group)},list_group_id);
		// Filter out group IDs with less than 250... only those with more will stay as multi-BDID.
		temp6th := temp5th(cnt < 250);
		return temp6th;
	end;
	
	// Join against the list of small groups to reset their multi-bdid-ness.
	temp_group_ids_slimmed_for_multi_bdid := join(temp_group_ids_plus_bdids_cleaned,temp_multi_group_ids_with_small_counts,
		left.group_id = right.list_group_id,
		transform(recordof(temp_group_ids_plus_bdids_cleaned),
			self.bdid_list := if(right.list_group_id = 0,left.bdid_list,(string)left.group_id),
			self.multi_bdid_flag := if(right.list_group_id = 0,left.multi_bdid_flag,false),
			self := left),left outer);
	
	// Sort by score and select the best 1000 results.
	temp_group_ids_plus_bdids_cleaned_top_1000 := topn(temp_group_ids_slimmed_for_multi_bdid,1000,
		-score,-best_flags,-if(exists(contactrecs),1,0),-contact_score);
	/////
	   // output(temp_addresses_by_group_tmp_phone, named('temp_addresses_by_group_tmp_phone'));
	   // output(temp_addresses_by_group_id_nostreetNme, named('temp_addresses_by_group_id_nostreetNme'));
	// output(temp_addresses_by_group_id_tmp, named('temp_addresses_by_group_id_tmp'));	
	   // output(temp_addresses_by_group_id_nostreetNme2, named('temp_addresses_by_group_id_nostreetNme2'));
	
	// output(temp_addresses_by_group_id_streetNme, named('temp_addresses_by_group_id_streetNme'));
	// output(temp_addresses_city , named('temp_addresses_city'));
	// output(temp_addresses_withCity, named('temp_addresses_withCity'));
	// output(temp_addresses_city_2, named('temp_addresses_city_2'));
	   // output(temp_addresses, named('temp_addresses'));
	// output(temp_addresses_by_group_id, named('temp_addresses_by_group_id'));
	////
	//output(temp_addresses_by_group_id_nostreetNme, named('temp_addresses_by_group_id_nostreetNme'));
	// output(temp_group_ids_plus_names, named('temp_group_ids_plus_names'));
	
	// output(temp_group_ids_plus_addresses , named('temp_group_ids_plus_addresses'));
	// output(temp_group_ids_slimmed_for_multi_bdid, named('temp_group_ids_slimmed_for_multi_bdid'));
	
	return temp_group_ids_plus_bdids_cleaned_top_1000;
end;
