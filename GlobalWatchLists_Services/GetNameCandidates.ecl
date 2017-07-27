import GlobalWatchLists, iesp, RiskWise;

// expecting V4 entity types
// expecting one name in in_name dataset
export GetNameCandidates( string1 entitytype, dataset(iesp.globalwatchlist_v4.t_Name) in_name, 
													integer min_threshold_score, set of string WatchLists_V4,
													boolean exclude_all_akas = false,	boolean exclude_weak_akas = false) := function

	in_entitytype := GlobalWatchLists.constants.GetEntityType(entitytype);
	in_parsed := if(in_entitytype=2 and (in_name[1].First<>'' or in_name[1].Middle<>'' or in_name[1].Last<>''), true, false);
	in_first := if(in_parsed, in_name[1].Prefix + ' ' + in_name[1].First, '');
	in_middle := if(in_parsed, in_name[1].Middle, '');
	in_last := if(in_parsed, in_name[1].Last + ' ' + in_name[1].Suffix, in_name[1].Full);

	file_tokens := GlobalWatchLists.File_Tokens_Name_V4;
	LayoutPrep_V4 := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutNameTokenPrep;
	name_prep := dataset([{in_last + ' ' + in_first + ' ' + in_middle, entitytype, 1}], LayoutPrep_V4);
	name_tokens := globalwatchlists.fn_NameTokens_V4(name_prep, true);

	// token file matches
	matching_tokens := IF(EXISTS(name_tokens),
												CHOOSEN(file_tokens(EXISTS(name_tokens(file_tokens.tkn[0] = name_tokens.tkn[0] and EntityScoreLib.NameIndexWordCompare(file_tokens.tkn, name_tokens.tkn) >= GlobalWatchLists.constants.ThresholdNameCandidate))), 25000));

	{unsigned6 key} norm_keys(matching_tokens l, INTEGER i) := TRANSFORM
		SELF.key := l.keys[i].key;
	END;
	name_keys := DEDUP(NORMALIZE(matching_tokens, COUNT(LEFT.keys), norm_keys(LEFT, COUNTER)), key, all);

	name_temp := join(name_keys, GlobalWatchLists.key_GlobalWatchLists_NameIndex_V4, 
								keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 
								transform(recordof(GlobalWatchLists.key_GlobalWatchLists_NameIndex_V4), self := right),
								ATMOST(keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 20000)); 
								
	GlobalWatchLists_Services.Layout_CandidateRecords getCandidatesName(name_temp l, GlobalWatchLists.key_GlobalWatchLists_Names_V4 r) := transform

		self.EntityID := if((exclude_all_akas and r.AkaType <> u'PRIMARY') or (exclude_weak_akas and UnicodeLib.UnicodeToUpperCase(r.Category) = u'WEAK'), skip, r.EntityID);

		wl_entitytype := GlobalWatchLists.constants.GetEntityType(r.EntityType);
		wl_parsed := if((r.FirstName<>'' or r.MiddleName<>'') and r.LastName<>'', true, false);
		wl_first := if(wl_parsed, r.FirstName, '');
		wl_middle := if(wl_parsed, r.MiddleName, '');
		wl_last := if(wl_parsed, r.LastName + ' ' + r.Generation, r.FullName);
		name_score := EntityScoreLib.NameCompare( in_entitytype, in_last, in_first, in_middle, 
																							wl_entitytype, wl_last, wl_first, wl_middle, false);

		self.NameScore := if(name_score >= min_threshold_score, name_score, SKIP);
		self.MatchingFirstName := r.FirstName;
		self.MatchingMiddleName := r.MiddleName;
		self.MatchingLastName := r.LastName;
		self.MatchingFullName := r.FullName;
		self.EntityType := r.EntityType;
		self.NameRecordID := r.RecordID;
		self := [];
	end;

	names := join(name_temp, GlobalWatchLists.key_GlobalWatchLists_Names_V4, 
								keyed(left.EntityID=right.EntityID) and keyed(left.RecordID=right.RecordID), 
								getCandidatesName(left, right),
								ATMOST(keyed(left.EntityID=right.EntityID) and keyed(left.RecordID=right.RecordID), 20000));

//output(name_temp, named('name_temp'));
//output(names, named('names'));
return names;

end;