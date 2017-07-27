import GlobalWatchLists, iesp, Patriot, ut, WorldCheckServices;

export BackwardsCompatibleSearch(grouped dataset(patriot.Layout_batch_in) in_data, 
																			real r_threshold_score, 
																			set of string WatchLists_V4,
																			integer2 dob_radius = -1,
																			boolean exclude_all_akas = false,
																			boolean exclude_weak_akas = false) := function

// determine the minimum name threshold
i_threshold_score := (integer)(r_threshold_score*100);

lcr := GlobalWatchLists_Services.Layout_CandidateRecords;

lcr RollupNameCandidates(lcr l, lcr r) := transform
	self.NameRecordID 		:= if(l.NameScore >= r.NameScore, l.NameRecordID, r.NameRecordID);
	self.NameScore 				:= if(l.NameScore >= r.NameScore, l.NameScore, r.NameScore);
	self 									:= if(l.NameScore >= r.NameScore,	l, r);
end;

lcr RollupCountryCandidates(lcr l, lcr r) := transform
	self.CountryRecordID 	:= if(l.CountryScore >= r.CountryScore,  l.CountryRecordID, r.CountryRecordID);
	self.CountryScore 		:= if(l.CountryScore >= r.CountryScore,  l.CountryScore, r.CountryScore);
	self.EntityScore 			:= self.CountryScore;
	self 									:= if(l.CountryScore >= r.CountryScore, l, r);
end;

lcr AnalyzeNameCandidates(string8 in_dob, lcr l) := transform
	in_dobs := if(length(in_dob)<8, dataset([{0, 0, 0}], iesp.share.t_Date), dataset([{in_dob[1..4], in_dob[5..6], in_dob[7..8]}], iesp.share.t_Date));
	
	dobs := project(GlobalWatchLists.key_GlobalWatchLists_AddlInfo_V4(keyed(EntityID=l.EntityID) and AddlInfoType='Date of Birth' and ParsedInfo<>''), 
								transform(GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutAdditionalInfo, self:=left));

	isDOBAFP := dob_radius > 0 and in_dobs[1].Year>0 and exists(dobs) and 
							~exists(dobs(WorldCheckServices.DateDifference(in_dob, (string)(ParsedInfo[1..4]+ParsedInfo[6..7]+ParsedInfo[9..10])) <= dob_radius * 365)); 

	self.NameScore :=	if(isDOBAFP, skip, l.NameScore);

	dob_match := BackwardsCompatible().DOBScore(in_dobs, dobs);
	self := dob_match[1];
	self.IsNameSingleWordMatch := false;

	add_score_dob := map( self.DOBScore <= 0 => 0,
												self.IsDOBPartial => 5,
												self.IsNameSingleWordMatch and self.NameScore < 75 => 10,
												0);

	best_score := if(add_score_dob = 0 and self.DOBScore > 0, self.DOBScore, 0); 
	add_score := if(self.NameScore<>0 and add_score_dob > (100 - self.NameScore)/2, (100 - self.NameScore)/2, add_score_dob);
	name_score := (unsigned1)((real)(100 - self.NameScore) * (real)(best_score)/100.0 + 0.1) + self.NameScore; 
	final_score := map( best_score >= 100 or self.NameScore + add_score >= 100 => 100,
													self.NameScore > 0 and best_score > 0 => name_score, 
													self.NameScore > 0 and add_score > 0 => self.NameScore + add_score,
													self.NameScore > 0 => self.NameScore,
													0);
	self.EntityScore := if(final_score < i_threshold_score, skip, final_score); 												
	self:=l;
end;

wl_match_layout := record
	patriot.Layout_batch_in;
	dataset(lcr) matches {MAXCOUNT(500)};
end;

wl_match_layout gwl_search(in_data l) := transform
	parsedlen := length(trim(l.name_first)) + length(trim(l.name_middle)) + length(trim(l.name_last)); 
	unparsedlen  := length(trim(l.name_unparsed));
	in_name := dataset([{u'',l.name_first,l.name_middle,l.name_last,u'',l.name_unparsed}], iesp.globalwatchlist_v4.t_Name);
	in_entity_type := map(
										l.search_type[1] = GlobalWatchLists.constants.individual_code => GlobalWatchLists.constants.EntityTypeIndividual,
										l.search_type[1] = GlobalWatchLists.constants.non_individual_code => GlobalWatchLists.constants.EntityTypeBusiness,
										parsedlen > unparsedlen => GlobalWatchLists.constants.EntityTypeIndividual,
										GlobalWatchLists.constants.EntityTypeUnknown);

	NameCandidates := GlobalWatchLists_Services.GetNameCandidates(in_entity_type, in_name, GlobalWatchLists.constants.ThresholdNameCandidate, WatchLists_V4, exclude_all_akas, exclude_weak_akas);
	RolledNameCandidates := rollup(sort(NameCandidates, EntityID), left.EntityID = right.EntityID, RollupNameCandidates(left, right));
	NameMatches := project(RolledNameCandidates, AnalyzeNameCandidates(l.dob, left));

	in_address := project(ut.ds_oneRecord, transform(iesp.globalwatchlist_v4.t_Address, self.Country := l.country; self := [];));
	
	CountryCandidates := GlobalWatchLists_Services.GetCountryCandidates(in_address, i_threshold_score, WatchLists_V4);
	CountryMatches  := rollup(sort(CountryCandidates, EntityID), left.EntityID = right.EntityID, RollupCountryCandidates(left, right));

	self.matches := choosen(sort(NameMatches + CountryMatches, -EntityScore, EntityID),500);
	self := l;
end;
gwl_matches := project(in_data, gwl_search(left));

//output(gwl_matches, named('gwl_matches'));
return gwl_matches;
end;