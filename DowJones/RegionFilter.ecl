import Worldcheck_Bridger;

SET of String CountryRestrictions(string theRegion) := CASE(theRegion,
//	'158','244' represent INTERNATINAL and UNKNOWN. There are never in the search criteria
	'COUNTRY_GROUP_AFR' => ['158','244'],
	'COUNTRY_GROUP_ASIA' => ['158','244'],
	'COUNTRY_GROUP_CANADA' => ['39','158','244'],
	'COUNTRY_GROUP_EURO' => ['158','244'],
	'COUNTRY_GROUP_ME' => ['158','244'],
	'COUNTRY_GROUP_NA' => ['158','244'],
	'COUNTRY_GROUP_SA' => ['158','244'],
	'COUNTRY_GROUP_UNK' => ALL,
	'COUNTRY_GROUP_USA' => ['230','158','244'],
	[]);
	
unknownRegions := FUNCTION
	unk := SORT(regions(region='COUNTRY_GROUP_UNK'),id);
	known := SORT(regions(region<>'COUNTRY_GROUP_UNK'),id);
	unkonly := sort(JOIN(unk,known, LEFT.id=RIGHT.id, LEFT ONLY),id);								

	return unkonly;
END;

SupportedRegions(string theRegion) := IF(theRegion<>'COUNTRY_GROUP_UNK',regions(region=theRegion),
																									unknownRegions);
						

EXPORT RegionFilter(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp)) infile, string theRegion) := FUNCTION

		ds1 := JOIN(infile, SupportedRegions(theRegion), LEFT.id = RIGHT.id,
							TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
									SELF := LEFT;),
									INNER);
		// include search criteria
		ds := JOIN(ds1, DowJones.GetSearchCriteria(CountryRestrictions(theRegion)), LEFT.id = RIGHT.ID,
				TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp,
						self.search_criteria := RIGHT.criteria;
						SELF := LEFT;), LEFT OUTER);

		return ds;
END;