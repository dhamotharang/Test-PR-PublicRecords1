IMPORT BairRx_Common;

// --
// This filter will try to resolve agency names to oris so we can filter as much data as possible at 
// the geohash level and minimize the need to use boolean searches in some of cases.
// By mapping agency names to unique ORIs we're also making the boolean search more efficient.
// -- 
// We have 2 types of agency filters in place: boolean filters and/or agency data only option.
// The query should be able to handle both these filters independently or when they are both active.
// --
EXPORT AgencyFilter(DATASET(BairRx_Common.Layouts.FilterExpression) inFilter, BOOLEAN AgencyDataOnly, STRING RequestAgencyORI) := MODULE

	SHARED IsORIFilter(string XP) := REGEXFIND('^DATA_PROVIDER_ORI', XP);
	SHARED IsAgencyFilter(string XP) := REGEXFIND('^AGENCY\\(', XP);
	SHARED IsSimpleFilter(string XP) := ~REGEXFIND('\\bNOT|\\bOR|\\bAND',XP);
	SHARED CleanFilter(string XP) := REGEXREPLACE('^(AGENCY|DATA_PROVIDER_ORI)(\\s)?\\(|=|"|\\)$', XP, '');

	EXPORT LayoutORI := RECORD
		string ori;
		string ori_exp;
		string agency := '';		
	END;

	// Process a dataset of expressions and flag agency filters.
	EXPORT GetAgencyExp() := inFilter(isAgencyFilter(expression) OR IsORIFilter(expression), IsSimpleFilter(expression))[1].expression; // will only attempt to resolve simple filters
	EXPORT GetCleanAgencyExp() := CleanFilter(GetAgencyExp()); 
	
	// This function will scan the data provider key and try to find a match for the provided agency name.
	// Returns a dataset of matching ORIs.
	EXPORT GetORIsFromExp() := FUNCTION
		K := BairRx_Common.Keys.DataProviderKey;
		XP := GetAgencyExp();
		XPC:= CleanFilter(XP);		
		WPATTERN := '(\\b'+XPC+'\\b)';
		// adding a limit just to avoid trying to resolve names that are too generic, e.g. agency(POLICE)
		ORIS := PROJECT(LIMIT(K(XPC<>'',REGEXFIND(WPATTERN, stringlib.StringToUpperCase(data_provider_name))), 10, SKIP), 
			TRANSFORM(LayoutORI, SELF.ori := LEFT.data_provider_ori, SELF.ori_exp := LEFT.data_provider_ori, SELF.agency := LEFT.data_provider_name));
		RETURN IF(IsORIFilter(XP) AND IsSimpleFilter(XP), DATASET([{XPC,XPC}], LayoutORI), ORIS);
	END;
	
	// Returns a dataset of ORIs based on either a boolean agency filter or the specified agency ori or both.
	EXPORT GetORIFromInput() := FUNCTION
		dORIsFromExp 		:= GetORIsFromExp();
		dORIFromAgency 	:= dORIsFromExp(ori = RequestAgencyORI);
		// if both agency filters *AND* agency data only option are specified, then request agency needs to be one of the filters.
		RETURN IF(AgencyDataOnly, IF(EXISTS(dORIsFromExp), dORIFromAgency, DATASET([{RequestAgencyORI,''}], LayoutORI)), dORIsFromExp);
	END;

	// The set of ORIs (sources) we're allowed to return based on the received input criteria.	
	EXPORT SET OF STRING GetAllowedSrcORI() := SET(GetORIFromInput(),ori);		
	// Are we filtering by agency?
	EXPORT BOOLEAN IsActive() := AgencyDataOnly OR (EXISTS(GetORIFromInput()));
		
	// Filter the input filter dataset, replacing the agency filter with a 'resolved' ORI filter.
	// If agency filter does not exist or cannot be resolved, output is the same as input.
	EXPORT GetFiltered() := FUNCTION			
		d0 := GetORIFromInput();		
		d1 := ROLLUP(d0, TRUE, TRANSFORM(LayoutORI, SELF.ori_exp := TRIM(LEFT.ori_exp, LEFT, RIGHT) + ' OR ' + RIGHT.ori_exp, SELF := LEFT));		
		ORIFilter := IF(d1[1].ori_exp<>'', 'DATA_PROVIDER_ORI('+TRIM(d1[1].ori_exp,LEFT,RIGHT)+')', '');					
		inFiltered := inFilter(~isAgencyFilter(expression), ~IsORIFilter(expression))+DATASET([{ORIFilter, TRUE}], BairRx_Common.Layouts.FilterExpression);			
		RETURN PROJECT(IF(ORIFilter<>'', inFiltered, inFilter), BairRx_Common.Layouts.FilterExpression);			
	END;
	
	// A boolean search is only needed if we have any filters in place other than an ori_filter. 
	// An expression flagged as ori_filter is one that has been resolved by this attribute.
	EXPORT BOOLEAN IsBooleanActive() := EXISTS(GetFiltered()(~ori_filter)); 
	
END;