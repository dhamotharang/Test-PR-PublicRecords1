
GetMultiCategories(set of string fCategory) := PROJECT(AllCategories(category in fCategory),rCriteria);
FilterCountries(integer fCountry) := CASE(fCountry,
					1 => dsCountryCodes(name in Filters.usaCountries),					// 1 = USA only
					2 => dsCountryCodes(name not in Filters.usaCountries),			// 2 = International
					dsCountryCodes);																						// 0 = no filter

EXPORT GetMultiSearchCriteria(set of string fCategory = [], integer fCountry = 0) := 
			MakeGroupHeader(SORT(FilterCountries(fCountry),name), 1, 'Country')
		+MakeGroupHeader(dsRegion, 2, 'Regional Level')
		+MakeGroupHeader(GetCategories(fCategory), 3, 'Category')
		+MakeGroupHeader(dsDeceased, 4, 'Deceased State');