import Text_Search, bair_boolean, ut, BairRx_Common, iesp;

EXPORT BooleanFilterSearch(BairRx_Common.IParam.SearchParam inMod, 
													 unsigned1 inEntityType,									
													 DATASET(BairRx_Common.Layouts.FilterExpression) inFilters,
													 DATASET(BairRx_Common.Layouts.LayoutGeoSearchGrid) geoGrid,
													 DATASET(iesp.share.t_StringArrayItem) inEIDs = DATASET ([],iesp.share.t_StringArrayItem),
													 boolean runBoolean = false,
													 boolean returnAll = false
													 ) := FUNCTION
	
	MC := inMod.ModeContext(mID=BairRx_Common.EID.TypeToString(inEntityType))[1];
	DR := MC.data_relation;
	SearchType := BairRx_Common.Constants.SearchType;
	
	filter_layout := BairRx_Common.Layouts.FilterExpression;
	MaxDocs := BairRx_Common.Constants.Filter.MaxResults;
	BairConsts := bair_boolean.Constants('');
	
	// Set primary only flag if view is primary and the mode is events or CFS or Crash
	PrimaryOnly := BairRx_Common.DataRelation.IsPrimaryView(DR) AND
									(inEntityType = SearchType.Event OR 
									 inEntityType = SearchType.CFS OR 
									 inEntityType = SearchType.Crash);

	EID_Keys := PROJECT(inEIDs,TRANSFORM(Text_Search.Layout_ExternalKey,SELF.ExternalKey := LEFT.value));
	
	geoSrch := ~EXISTS(EID_Keys);
	
	filter_layout XFORM_ConcatExpression(filter_layout L, filter_layout R, STRING Connector) := TRANSFORM
			SELF.Expression := L.Expression + IF(R.Expression != '',' ' + Connector + ' ' + R.Expression,'');
			SELF := l;
	END;
	
	// Convert Event class code set to boolean expression layout record set.
	eveClass := PROJECT(DATASET([MC.clean_codes[1].codes],{string classCode}),
																TRANSFORM(filter_layout,
																					SELF.Expression := LEFT.classCode,
																					SELF.ori_filter := false));
	
	eveClassExp := ROLLUP(eveClass,TRUE,XFORM_ConcatExpression(LEFT,RIGHT,'OR'))[1].Expression;
	// Only build Event class code boolean search if less then 4 codes passed in.
	classExp := IF(inEntityType = SearchType.Event AND COUNT(MC.clean_codes[1].codes) <=3,' class_code(' + eveClassExp + ')','');
	
	// Get Geo Hash values and convert to boolean search.	
	geoGridLen := LENGTH(geoGrid[1].box);	
	// We will pick the most appropriate geo hash filter (gh4, gh5 or gh6) based on the geohash lenght.
	geoGridExpLen := IF(geoGridLen>=6,6,IF(geoGridLen=5,5,4)); 
	geoExp := PROJECT(geoGrid,TRANSFORM(BairRx_Common.Layouts.FilterExpression,		
		SELF.Expression := IF(runBoolean, LEFT.Box[1..geoGridExpLen], SKIP), 
		SELF := []));
	geoExpDedup := DEDUP(SORT(geoExp,expression),expression);	
	geoSegment := IF(geoGridExpLen=6, 'gh6', IF(geoGridExpLen=5, 'gh5', 'gh4')); 
	geoHashComb := geoSegment + '(' +
		ROLLUP(geoExpDedup,TRUE,XFORM_ConcatExpression(LEFT,RIGHT,'OR'))[1].Expression
		+ ')';
	
	// Build date range search for all entities except offender
	dateRange := IF(inEntityType != SearchType.Offender,
										(' and DATE BTW '+ ut.ConvertDate(inMod.startDate,'%Y%m%d','%Y/%m/%d') 
										+ ' and ' + ut.ConvertDate(inMod.endDate,'%Y%m%d','%Y/%m/%d')),
									'');
	
	// Check for if udf (user defined field) filter is passed in
	IsUDFFilter := EXISTS(inFilters(REGEXFIND('(^| )(PERSON|MO)UDF\\d{1}\\(', expression,NOCASE)));
	
	//If agency only set or if udf filter is passed, add agency filter condition
	agencyExp := IF(inMod.agencyDataOnly OR IsUDFFilter,' and DATA_PROVIDER_ORI("' + inMod.agencyOri + '")','');
		 
	//If agency only set, remove any agency or data provider ori filters, since the agency only filter will override
	IsAgencyOriFilter(STRING XP) := REGEXFIND('(^| )(DATA_PROVIDER_ORI|AGENCY)\\(', XP,NOCASE);	
	agFilters := IF(inMod.agencyDataOnly,
											PROJECT(inFilters,TRANSFORM(BairRx_Common.Layouts.FilterExpression,
																					SELF.expression := IF(NOT(IsAgencyOriFilter(LEFT.expression)),LEFT.expression,SKIP),
																					SELF := LEFT)),
											inFilters);
									
	// Add date to search and class code (will only contain expression for event mode)
	geoHashSrch := geoHashComb + dateRange + classExp + agencyExp;
																						
	// Sort Filters so that NOT expressions come last.
	sFilters := SORT(agFilters,expression[1..3]='NOT');
	
	// Add primary logic to search string(s)
	Filters := IF(PrimaryOnly,PROJECT(sFilters,TRANSFORM(filter_layout,SELF.Expression := LEFT.Expression + ' predoc/32000 primaryRec("PTRU")',
																																			 SELF := [])),
																		sFilters);
																		
	Keyword := IF(PrimaryOnly AND inMod.KeyWord != '',inMod.KeyWord + ' predoc/32000 primaryRec("PTRU")',inMod.KeyWord);

	// Concat filter conditions into one expression
	filterSrch := ROLLUP(Filters,TRUE,XFORM_ConcatExpression(LEFT,RIGHT,'AND'))[1].Expression;
	
	// Combine keyword search with filter search.
	finalFilterSrch := MAP (filterSrch != '' and KeyWord != '' => Keyword + ' AND ' + filterSrch,
													filterSrch != '' 		 							 => filterSrch,
													KeyWord);	
	
	// Convert any Like expression with mimimal search arg length to a non Like search
	finalLikeFilterSrch := BairRx_Common.Functions.ValidateLikeExp(finalFilterSrch);
	
	// Combine filter search with geohash search.
	finalFilterGeoSrch := MAP (finalLikeFilterSrch != '' and geoHashSrch != '' => geoHashSrch + ' AND ' + finalLikeFilterSrch,
														 finalLikeFilterSrch != '' 		 								   => finalLikeFilterSrch,
														 geoHashSrch);
	
	// Add etype to search in case user only supplies "NOT" search, "NOT" must be preceded by a "Match" search term
	leadingNot := sFilters[1].expression[1..3] = 'NOT';
	etypeStr := IF(leadingNot,'etype('+(STRING) inEntityType + ') AND ','');

	finalFilterNonGeoSrch := etypeStr + finalLikeFilterSrch;
																
	focusStringTemp := IF(geoSrch,finalFilterGeoSrch,finalFilterNonGeoSrch);

	// Hack below to avoid boolean executing unnecessarily, when 
	// this attribute is called when it shouldn't due to the IF issue where both sides of 
	// the if condition are executed.
	focusString := IF(focusStringTemp != '' and runBoolean,focusStringTemp,'');
	
	STRING stem       := BairConsts.fileinfo.stem;
	STRING srcType		:= BairConsts.fileinfo.srcType;
	STRING qual       := BairConsts.fileinfo.qual;
	info := Text_Search.FileName_Info_Instance(stem, srcType, qual);
	
	SearchSources := IF(MC.mID=BairRx_Common.Constants.Mode.EVE,[inEntityType],
																				(SET OF Text_Search.Types.SourceID) MC.clean_codes[1].codes);	
												
	stdSearchArg := MODULE(Text_Search.StandardSearchArgs)
			EXPORT srchString := focusString;
			// Set answer limit based on if all of the recs are to be returned or only a subset
			EXPORT ansLimit := IF(returnAll,BairRx_Common.Constants.Filter.MaxResults,
																			BairRx_Common.Constants.Filter.MaxResultsSub);
			EXPORT valueLAFN := BairRx_Common.Constants.Filter.MaxResults;
			EXPORT showHits := FALSE;
			EXPORT runboolean := TRUE; 
			EXPORT NoLafn := TRUE;
			EXPORT DATASET(Text_Search.Layout_ExternalKey) focusList := EID_Keys;
			EXPORT SourceList := SearchSources;
	END;

	focusSearch := Text_Search.Text_Search_V4(info, stdSearchArg);

	ans := focusSearch.ExtKeyAnswers;
	rpn := focusSearch.rpn_srch;
	errCode := focusSearch.error_code;
	errMsg := focusSearch.error_msg;

	noErr := errCode = 0;

	IF(~noErr, ut.outputMessage(errCode, errMsg));
									
	// Hit key to get all versions for a doc
	ansVersions := JOIN(ans, bair_boolean.key_exkeyi2,
										KEYED(HASH64(LEFT.ExternalKey)=RIGHT.HashKey) 
										AND LEFT.ExternalKey=RIGHT.ExternalKey,
										LIMIT(0));

	// Keep latest version of doc
	ansVersionsDedup := DEDUP(SORT(ansVersions,ExternalKey,-ver),ExternalKey);
	
	// Filter any older versions of doc out of answer
	ansResults := JOIN(ans,ansVersionsDedup,
									LEFT.docref.src = RIGHT.src AND
									LEFT.docref.doc = RIGHT.doc,
									TRANSFORM(LEFT));
									
	results := JOIN(ansResults, bair_boolean.key_ansrec, 
									KEYED(LEFT.ExternalKey=RIGHT.record_id) 
									AND RIGHT.gh12 != '',
									TRANSFORM(BairRx_Common.Layouts.SearchRec,
													SELF.EID := LEFT.ExternalKey,
													SELF:=RIGHT,
													SELF:= []),
									LIMIT(0), KEEP(1));
	
	
	// output(count(EID_Keys),named('EID_Keys_CNT_'+ inEntityType));
	// output(EID_Keys,named('EID_Keys_'+ inEntityType));
	// output(geoSrch,named('geoSrch_'+ inEntityType));
	// output(inFilters,named('inFilters_'+ inEntityType));
	// output(agFilters,named('agFilters_' + inEntityType));
	// output(finalFilterSrch,NAMED('finalFilterSrch_'+ inEntityType));
	// output(finalFilterGeoSrch,named('finalFilterGeoSrch_'+ inEntityType));
	// output(finalFilterNonGeoSrch,named('finalFilterNonGeoSrch_'+ inEntityType));
	// output(focusString,named('focusString_'+ inEntityType ));
	// output(rpn,named('rpn_'+ inEntityType ));
	// output(SearchSources,named('SearchSources_'+inEntityType ));
	// output(ans,named('ans_'+ inEntityType));
	// output(ansVersions,named('ansVersions_'+inEntityType));
	// output(ansVersionsDedup,named('ansVersionsDedup_'+inEntityType));
	// output(ansResults,named('ansResults_'+inEntityType));
	// output(count(results),named('CntboolResults_'+inEntityType ));
	// output(results,named('Results_'+inEntityType ));
	
	return(results);
END;