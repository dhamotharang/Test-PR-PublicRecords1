import GlobalWatchLists, iesp, RiskWise, ut;

// find city and country matches in country watch lists
export GetCountryCandidates(dataset(iesp.globalwatchlist_v4.t_Address) in_address, 
														integer threshold_score, set of string WatchLists_V4) := function

	clen := length(trim(in_address[1].country));
	in_country := if(clen=2 AND ut.Country_ISO2_To_Name((string)in_address[1].Country)<>'',ut.Country_ISO2_To_Name((string)in_address[1].Country),
									if(clen=3 AND ut.Country_ISO3_To_Name((string)in_address[1].Country)<>'',ut.Country_ISO3_To_Name((string)in_address[1].Country),
									trim(in_address[1].Country)));
	
	file_tokens := GlobalWatchLists.File_Tokens_Country_V4;
	LayoutPrep_V4 := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryTokenPrep;
	LayoutTokens := GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutTokens;
	country_prep := dataset([{in_country, 1}], LayoutPrep_V4);
	country_tokens := globalwatchlists.fn_CountryTokens_V4(country_prep, true);

	// token file matches
	matching_country_tokens := IF(EXISTS(country_tokens),
												CHOOSEN(file_tokens(EXISTS(country_tokens(file_tokens.tkn[0] = country_tokens.tkn[0] and EntityScoreLib.CountryIndexWordCompare(file_tokens.tkn, country_tokens.tkn) >= GlobalWatchLists.constants.ThresholdNameCandidate))), 25000));

	{unsigned6 key} norm_keys(LayoutTokens l, INTEGER i) :=
	TRANSFORM
		SELF.key := l.keys[i].key;
	END;
	country_keys := DEDUP(NORMALIZE(matching_country_tokens, COUNT(LEFT.keys), norm_keys(LEFT, COUNTER)), key, all);

	country_temp := join(country_keys, GlobalWatchLists.key_GlobalWatchLists_CountryIndex_V4, 
								keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 
								transform(recordof(GlobalWatchLists.key_GlobalWatchLists_CountryIndex_V4), self := right),
								ATMOST(keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 100));
								
	GlobalWatchLists_Services.Layout_CandidateRecords getCandidatesCountry(country_temp l, GlobalWatchLists.key_GlobalWatchLists_CountryAKAs_V4 r) := transform

		wl_country := r.Name;
		country_score := EntityScoreLib.CountryCompare(in_country, wl_country);

		self.CountryScore := if(country_score < threshold_score, skip, country_score);
		self.EntityScore := self.CountryScore;
		self.EntityID := r.CountryID;
		self.CountryRecordID := r.RecordID;
		self.MatchingCountry := r.Name;
		self := [];
	end;

	countries := join(country_temp, GlobalWatchLists.key_GlobalWatchLists_CountryAKAs_V4, 
								keyed(left.CountryID=right.CountryID) and keyed(left.RecordID=right.RecordID) and (right.NameType='' or right.NameType='AKA'), 
								getCandidatesCountry(left,right),
								ATMOST(keyed(left.CountryID=right.CountryID) and keyed(left.RecordID=right.RecordID), 100));


	in_city := trim(in_address[1].City);
	city_prep := dataset([{in_city, 1}], LayoutPrep_V4);
	city_tokens := globalwatchlists.fn_CountryTokens_V4(city_prep, true);

	// token file matches
	matching_city_tokens := IF(EXISTS(city_tokens),
												CHOOSEN(file_tokens(EXISTS(city_tokens(EntityScoreLib.CountryIndexWordCompare(file_tokens.tkn, city_tokens.tkn) >= GlobalWatchLists.constants.ThresholdNameCandidate))), 25000));

	city_keys := DEDUP(NORMALIZE(matching_city_tokens, COUNT(LEFT.keys), norm_keys(LEFT, COUNTER)), key, all);

	city_temp := join(city_keys, GlobalWatchLists.key_GlobalWatchLists_CountryIndex_V4, 
								keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 
								transform(recordof(GlobalWatchLists.key_GlobalWatchLists_CountryIndex_V4), self := right),
								ATMOST(keyed(left.key=right.key) and keyed(right.ListID in WatchLists_V4), 100));
								
	GlobalWatchLists_Services.Layout_CandidateRecords getCandidatesCity(city_temp l, GlobalWatchLists.key_GlobalWatchLists_CountryAKAs_V4 r) := transform

		wl_city := r.Name;
		city_score := EntityScoreLib.CountryCompare(in_city, wl_city);

		self.CountryScore := if(city_score < threshold_score, skip, city_score);
		self.EntityScore := self.CountryScore;
		self.EntityID := r.CountryID;
		self.CountryRecordID := r.RecordID;
		self.MatchingCountry := r.Name;
		self := [];
	end;

	cities := join(city_temp, GlobalWatchLists.key_GlobalWatchLists_CountryAKAs_V4, 
								keyed(left.CountryID=right.CountryID) and keyed(left.RecordID=right.RecordID) and (right.NameType='City' or right.NameType='Port'), 
								getCandidatesCity(left,right),
								ATMOST(keyed(left.CountryID=right.CountryID) and keyed(left.RecordID=right.RecordID), 100));

return if(in_country<>'', countries, if(in_city<>'', cities));
end;