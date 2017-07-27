import business_header, doxie_cbrs;

export fn_RSS_attachPOSInfo(dataset(business_header.layout_biz_search.final) indata, boolean LNBranded, unsigned1 DPPA_Purpose, boolean RETURN_BDLS) := function

	// As long as there are fewer than 300 total results, select the top 10.
	temp_top10_records := choosen(indata,10)(count(indata) <= 300);
	
	// Get the group IDs for the top 10, to prepare to get their supergroup sets.
	temp_top10_group_ids := dedup(sort(project(temp_top10_records,transform(doxie_cbrs.layout_supergroup,
		self.bdid := left.group_id,
		self.level := 0,
		self.group_id := 0)),bdid),bdid);
		
	// Get the supergroup sets for the top 10 group IDs.
	temp_top10_group_ids_associated_bdids := doxie_cbrs.fn_getSupergroup(temp_top10_group_ids);

	// Join the bdids back to their group IDs.
	temp_top10_group_ids_and_bdids := join(temp_top10_group_ids_associated_bdids,business_header.Key_BH_SuperGroup_BDID,
		keyed(left.bdid = right.bdid),
		transform(doxie_cbrs.layout_supergroup,
			self.group_id := right.group_id,
			self := left),
		keep (1), limit (0));
	
	// Normalize the "narrow" set of BDIDs for the top 10.
	temp_top10_multi_bdids := normalize(temp_top10_records,count(left.bdidrecs),transform(doxie_cbrs.layout_supergroup,
		self.bdid := left.bdidrecs[counter].bdid,
		self.group_id := 0));
	
	// Get POS (We Also Found) info for all the appropriate BDIDs
	temp_pos_info := business_header.fn_business_pos(temp_top10_group_ids_and_bdids + temp_top10_multi_bdids,LNBranded,DPPA_Purpose);
			
	// Roll up the POS information for group IDs.
	temp_pos_info_for_group_id := rollup(
		sort(temp_pos_info(group_id != 0),group_id),
		left.group_id = right.group_id,
		transform(recordof(temp_pos_info),
			self.has_sos  := left.has_sos  or right.has_sos,
			self.has_ucc  := left.has_ucc  or right.has_ucc,
			self.has_ucc_v2 := left.has_ucc_v2 or right.has_ucc_v2,
			self.has_mvr  := left.has_mvr  or right.has_mvr,
			self.has_prop := left.has_prop or right.has_prop,
			self.has_cont := left.has_cont or right.has_cont,
			self.bdid := 0,
			self := left));
	
	// Attach the POS (We Also Found) information for the group IDs.
	temp_top10_records_plus_pos_info_for_group_id := join(indata,temp_pos_info_for_group_id,
		left.group_id = right.group_id,
		transform(business_header.layout_biz_search.final,
			self.group_id_pos_sos := right.has_sos,
			self.group_id_pos_ucc := right.has_ucc,
			self.group_id_pos_ucc_v2 := right.has_ucc_v2,
			self.group_id_pos_prop := right.has_prop,
			self.group_id_pos_mvr := right.has_mvr,
			self.group_id_pos_cont := right.has_cont,
			self.pos_sos := if(left.multi_bdid_flag,left.pos_sos,right.has_sos),
			self.pos_ucc := if(left.multi_bdid_flag,left.pos_ucc,right.has_ucc),
			self.pos_ucc_v2 := if(left.multi_bdid_flag,left.pos_ucc_v2,right.has_ucc_v2),
			self.pos_prop := if(left.multi_bdid_flag,left.pos_prop,right.has_prop),
			self.pos_mvr := if(left.multi_bdid_flag,left.pos_mvr,right.has_mvr),
			self.pos_cont := if(left.multi_bdid_flag,left.pos_cont,right.has_cont),
			self := left),left outer);
	
	// Add Group ID and BDL
	temp_pos_plus_group_for_multi := join(
		temp_pos_info(group_id = 0),
		business_header.Key_BH_SuperGroup_BDID,
		keyed(left.bdid = right.bdid),transform(recordof(temp_pos_info),
			self.group_id := right.group_id,
			self := left));
	temp_pos_plus_bdl_for_multi := if(RETURN_BDLS,
		join(
			temp_pos_plus_group_for_multi,
			business_header.Key_BDL2_BDID,
			keyed(left.bdid = right.bdid),transform({recordof(temp_pos_info);unsigned6 bdl;},
				self.bdl := right.bdl,
				self := left)),
		project(temp_pos_plus_group_for_multi,transform({recordof(temp_pos_info);unsigned6 bdl;},
			self.bdl := 0,
			self := left)));
	
	// Attach the POS (We Also Found) information for the narrow set of BDIDs.
	temp_pos_info_for_multi_bdid := rollup(sort(temp_pos_plus_bdl_for_multi,group_id,bdl),
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(recordof(temp_pos_plus_bdl_for_multi),
			self.has_sos  := left.has_sos  or right.has_sos,
			self.has_ucc  := left.has_ucc  or right.has_ucc,
			self.has_ucc_v2 := left.has_ucc_v2 or right.has_ucc_v2,
			self.has_mvr  := left.has_mvr  or right.has_mvr,
			self.has_prop := left.has_prop or right.has_prop,
			self.has_cont := left.has_cont or right.has_cont,
			self.bdid := 0,
			self := left));
	
	// Join together the full dataset.
	temp_top10_records_plus_pos_info_for_multi_bdid := join(
		temp_top10_records_plus_pos_info_for_group_id,temp_pos_info_for_multi_bdid,
		left.group_id = right.group_id and
		left.bdl = right.bdl,
		transform(business_header.layout_biz_search.final,
			self.pos_sos := if(not left.multi_bdid_flag,left.pos_sos,right.has_sos),
			self.pos_ucc := if(not left.multi_bdid_flag,left.pos_ucc,right.has_ucc),
			self.pos_ucc_v2 := if(not left.multi_bdid_flag,left.pos_ucc_v2,right.has_ucc_v2),
			self.pos_prop := if(not left.multi_bdid_flag,left.pos_prop,right.has_prop),
			self.pos_mvr := if(not left.multi_bdid_flag,left.pos_mvr,right.has_mvr),
			self.pos_cont := if(not left.multi_bdid_flag,left.pos_cont,right.has_cont),
			self := left),left outer);
	
	// Sort by score and select the top 1000 results.
	temp_top10_records_plus_pos_info_top_1000 := topn(temp_top10_records_plus_pos_info_for_multi_bdid,1000,
		-score,-if(exists(contactrecs),contact_score,0),-best_flags);

  // Uncomment lines below as needed for debugging
  //output(indata,                  named('apos_indata'));                  // DEBUG	
  //output(temp_top10_records_plus_pos_info_for_multi_bdid, named('apos_temp12')); // DEBUG	
  //output(temp_top10_records_plus_pos_info_top_1000, named('apos_returned')); // DEBUG	

	return temp_top10_records_plus_pos_info_top_1000;
	
end;
