import MDR,ut;

export Function_Cleaving(dataset(Layout_Linking.Working) in_data) := module
	
	// Record to track grouping metadata
	temprec := record
		Layout_Linking.Working;
		unsigned6 temp_bid;
		boolean has_dca;
		boolean has_dnb;
		boolean has_ebr;
	end;
	
	// BID and Source Party (Use EXPERIAN for EBR and force company name for EBR)
	bid_source_party_dist := distribute(
		in_data,
		hash64(bid,source,if(MDR.SourceTools.SourceIsEBR(source),experian,source_docid),if(MDR.SourceTools.SourceIsEBR(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsDCA(source),'',source_party)));
	bid_source_party_recs := table(
		bid_source_party_dist,
		{bid,source,temp_source_docid := if(MDR.SourceTools.SourceIsEBR(source),experian,source_docid),temp_source_party := if(MDR.SourceTools.SourceIsEBR(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsDCA(source),'',source_party),temp_company_name := if(MDR.SourceTools.SourceIsEBR(source),clean_company_name,''),unsigned6 min_beid := min(group,beid)},
		bid,source,if(MDR.SourceTools.SourceIsEBR(source),experian,source_docid),if(MDR.SourceTools.SourceIsEBR(source) or MDR.SourceTools.SourceIsDunn_Bradstreet(source) or MDR.SourceTools.SourceIsDCA(source),'',source_party),if(MDR.SourceTools.SourceIsEBR(source),clean_company_name,''),local);
	bid_source_party_match := join(
		bid_source_party_dist,
		bid_source_party_recs,
		left.bid = right.bid and
		left.source = right.source and
		if(MDR.SourceTools.SourceIsEBR(left.source),left.experian,left.source_docid) = right.temp_source_docid and
		if(MDR.SourceTools.SourceIsEBR(left.source) or MDR.SourceTools.SourceIsDunn_Bradstreet(left.source) or MDR.SourceTools.SourceIsDCA(left.source),'',left.source_party) = right.temp_source_party and
		if(MDR.SourceTools.SourceIsEBR(left.source),left.clean_company_name,'') = right.temp_company_name,
		transform(temprec,
			self.has_dca := MDR.SourceTools.SourceIsDCA(left.source),
			self.has_dnb := MDR.SourceTools.SourceIsDunn_Bradstreet(left.source),
			self.has_ebr := MDR.SourceTools.SourceIsEBR(left.source),
			self.temp_bid := right.min_beid,
			self := left),
		local);
	
	// Join DCA to D&B data... allow each D&B to link to AT MOST ONE entity of DCA data
	// First get the comparison scores for every D&B vs every DCA in the BID
	dca_to_dnb_join := join(
		distribute(bid_source_party_match(has_dca),hash64(bid,zip,prim_name,prim_range)),
		distribute(bid_source_party_match(has_dnb),hash64(bid,zip,prim_name,prim_range)),
		left.bid = right.bid and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range,
		transform({unsigned6 temp_bid1;unsigned6 temp_bid2;unsigned1 score;},
			self.temp_bid1 := left.temp_bid,
			self.temp_bid2 := right.temp_bid,
			self.score := ut.StringSimilar100(left.company_name,right.company_name)),
		local);
	
	// Calculate the average edit distance between the temp BIDs
	average_dca_dnb_score :=
		table(
			distribute(dca_to_dnb_join,hash64(temp_bid2)),
			{temp_bid2,temp_bid1,unsigned1 score := ave(group,score)},
			temp_bid2,temp_bid1,local);
	
	// Each DNB (temp_bid2) can join only to one DCA, so get the lowest average score
	best_dcas_for_dnbs := dedup(sort(average_dca_dnb_score(score < 30),temp_bid2,score,record,local),temp_bid2,local);
	
	// Now, join the DNBs to the DCAs
	dnb_dca_match := join(
		distribute(bid_source_party_match,hash64(temp_bid)),
		distribute(best_dcas_for_dnbs,hash64(temp_bid2)),
		left.temp_bid = right.temp_bid2,
		transform(temprec,
			self.temp_bid := if(right.temp_bid2 = 0,left.temp_bid,right.temp_bid1),
			self := left),
		left outer,
		local);
	
	// Now add the DNB indicator to the data
	add_dnb_indicator := join(
		distribute(dnb_dca_match,hash64(temp_bid)),
		dedup(distribute(best_dcas_for_dnbs,hash64(temp_bid1)),temp_bid1,all,local),
		left.temp_bid = right.temp_bid1,
		transform(temprec,
			self.has_dnb := if(right.temp_bid1 = 0,left.has_dnb,true),
			self := left),
		left outer,
		local);
	
	// Join EBR to DCA and D&B data... allow each EBR to link to AT MOST ONE entity of DCA and/or DNB data
	// First get the comparison scores for every EBR vs every DCA/DNB in the BID
	ebr_to_dcadnb_join := join(
		distribute(add_dnb_indicator(has_dca or has_dnb),hash64(bid,zip,prim_name,prim_range)),
		distribute(add_dnb_indicator(has_ebr),hash64(bid,zip,prim_name,prim_range)),
		left.bid = right.bid and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range,
		transform({unsigned6 temp_bid1;unsigned6 temp_bid2;unsigned1 score;},
			self.temp_bid1 := left.temp_bid,
			self.temp_bid2 := right.temp_bid,
			self.score := ut.StringSimilar100(left.company_name,right.company_name)),
		local);
	
	// Calculate the average edit distance between the temp BIDs
	average_ebr_dcadnb_score :=
		table(
			distribute(ebr_to_dcadnb_join,hash64(temp_bid2)),
			{temp_bid2,temp_bid1,unsigned1 score := ave(group,score)},
			temp_bid2,temp_bid1,local);
	
	// Each EBR (temp_bid2) can join only to one DCA/DNB, so get the lowest average score
	best_ebrs_for_dcadnbs := dedup(sort(average_ebr_dcadnb_score(score < 30),temp_bid2,score,record,local),temp_bid2,local);
	
	// Now, join the EBRs to the DNBs/DCAs
	ebr_match := join(
		distribute(add_dnb_indicator,hash64(temp_bid)),
		distribute(best_ebrs_for_dcadnbs,hash64(temp_bid2)),
		left.temp_bid = right.temp_bid2,
		transform(temprec,
			self.temp_bid := if(right.temp_bid2 = 0,left.temp_bid,right.temp_bid1),
			self := left),
		left outer,
		local);
	
	// Now add the EBR indicator to the data
	add_ebr_indicator := join(
		distribute(ebr_match,hash64(temp_bid)),
		dedup(distribute(best_ebrs_for_dcadnbs,hash64(temp_bid1)),temp_bid1,all,local),
		left.temp_bid = right.temp_bid1,
		transform(temprec,
			self.has_ebr := if(right.temp_bid1 = 0,left.has_ebr,true),
			self := left),
		left outer,
		local);
	
	// Join Other Data to DCA/DNB/EBR data... allow each subentity to link to AT MOST ONE entity of EBR, DCA and/or DNB data
	// First get the comparison scores for every subentity vs every EBR/DCA/DNB in the BID
	others_to_ebrdcadnb_join := join(
		distribute(add_ebr_indicator(not(has_ebr or has_dca or has_dnb) and zip != '' and prim_name != ''),hash64(bid,zip,prim_name,prim_range,company_name[1])),
		distribute(add_ebr_indicator((has_ebr or has_dca or has_dnb) and zip != '' and prim_name != ''),hash64(bid,zip,prim_name,prim_range,company_name[1])),
		left.bid = right.bid and
		left.zip = right.zip and
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
		left.company_name[1] = right.company_name[1],
		transform({unsigned6 temp_bid1;unsigned6 temp_bid2;unsigned1 score;},
			self.temp_bid1 := right.temp_bid,
			self.temp_bid2 := left.temp_bid,
			self.score := ut.StringSimilar100(left.company_name,right.company_name)),
		local);
	
	// Calculate the average edit distance between the temp BIDs
	average_other_ebrdcadnb_score :=
		table(
			distribute(others_to_ebrdcadnb_join,hash64(temp_bid2)),
			{temp_bid2,temp_bid1,unsigned1 score := ave(group,score)},
			temp_bid2,temp_bid1,local);
	
	// Each other entity (temp_bid2) can join only to one EBR/DCA/DNB, so get the lowest average score
	best_others_for_ebrdcadnbs := dedup(sort(average_other_ebrdcadnb_score(score < 30),temp_bid2,score,record,local),temp_bid2,local);
	
	// Now, join the others to the DNBs/DCAs/EBRs
	other_match := join(
		distribute(add_ebr_indicator,hash64(temp_bid)),
		distribute(best_others_for_ebrdcadnbs,hash64(temp_bid2)),
		left.temp_bid = right.temp_bid2,
		transform(temprec,
			self.temp_bid := if(right.temp_bid2 = 0,left.temp_bid,right.temp_bid1),
			self := left),
		left outer,
		local);
	
	// Now add a dummy indicator to the data to keep it from being joined with other stuff.
	shared add_other_indicator := join(
		distribute(other_match,hash64(temp_bid)),
		dedup(distribute(best_others_for_ebrdcadnbs,hash64(temp_bid1)),temp_bid1,all,local),
		left.temp_bid = right.temp_bid1,
		transform(temprec,
			self.has_ebr := if(right.temp_bid1 = 0,left.has_ebr,true),
			self := left),
		left outer,
		local) : persist('persist::brm::linking::add_other_indicator');

	// Combine everything
	export core_records :=
		project(add_other_indicator(has_dnb or has_dca or has_ebr),
			transform(Layout_Linking.Match,
				self.beid_low := left.temp_bid,
				self.beid_high := left.beid,
				self.matchcode := 0));
	
	export remaining_records :=
		project(add_other_indicator(not(has_dnb or has_dca or has_ebr)),
			transform(Layout_Linking.Working,
				self := left));
	
end;
