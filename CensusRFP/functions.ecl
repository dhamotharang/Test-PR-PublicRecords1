
IMPORT ut, Header, Marketing_Best, Risk_Indicators, Watchdog;

EXPORT functions := MODULE

	SHARED SET OF STRING3 Toll_Free_Area_Codes := ['800','811','822','833','844','855','866','877','888','899'];

	EXPORT fn_GetPhoneTypeCode(Risk_Indicators.Layout_Telcordia_tds inRec) :=
		FUNCTION
			phone_type_code := IF( inRec.npa IN Toll_Free_Area_Codes OR REGEXFIND('I',inRec.SSC), 
														 constants.TOLL_FREE,
														 MAP(inRec.COCType IN ['EOC','PMC','RCC','SP1','SP2'] AND 
																 REGEXFIND('(C|R|S)',inRec.SSC) => constants.CELL_PHONE,
																 REGEXFIND('B',      inRec.SSC) => constants.PAGER,
																 REGEXFIND('N',      inRec.SSC) => constants.POTS,
																 REGEXFIND('V',      inRec.SSC) => constants.VOIP,
																 REGEXFIND('T',      inRec.SSC) => constants.TIME,
																 REGEXFIND('W',      inRec.SSC) => constants.WEATHER,
																 REGEXFIND('8',      inRec.SSC) => constants.PUERTO_RICO_VIRGIN_ISLANDS,
																 /* ELSE........................*/ constants.UNKNOWN_TYPE)
														);
			RETURN phone_type_code;
		END;
															 
	SHARED STREET_NAME_SIMILARITY_THRESHOLD := 40;
	SHARED PRIM_RANGE_SIMILARITY_THRESHOLD  := 25;

	// ...Local functions used for rollup:

	// ...For similar prim_ranges due to miskey or error, e.g. '1323' and '1373', or '3106' and '31106'
	EXPORT prim_ranges_are_close_enough(QSTRING10 s1, QSTRING10 s2) := 
		FUNCTION
			RETURN datalib.StringSimilar100(s1,s2) <= PRIM_RANGE_SIMILARITY_THRESHOLD;
		END;
	
	// ...For similar streetnames due to miskey or error, e.g. 890 'KIRKWOOD' and 890 '890 KIRKWOOD', 'LACROSSE' and 'LA CROSSE'.
	EXPORT street_names_are_close_enough(QSTRING28 s1, QSTRING s2) := 
		FUNCTION
			RETURN datalib.StringSimilar100(s1,s2) <= STREET_NAME_SIMILARITY_THRESHOLD;
		END;

	// ...For similar apartment or suite numbers due to miskey or error, e.g. APT '3108' and '3108E'.
	EXPORT sec_ranges_are_close_enough(QSTRING28 s1, QSTRING s2) := 
		FUNCTION
			RETURN s1 = '' OR s2 = '' OR ut.Lead_Contains(s1,s2);
		END;

	EXPORT addresses_are_similar_enough(header.Layout_Header l, header.Layout_Header r) := 
		FUNCTION
			RETURN l.did = r.did AND  
						 l.st = r.st AND
             l.zip = r.zip AND (
						 prim_ranges_are_close_enough(l.prim_range, r.prim_range) 
						 OR street_names_are_close_enough(l.prim_name, r.prim_name) ) AND 
						 sec_ranges_are_close_enough(l.sec_range, r.sec_range);
		END;

	// EXPORT mac_addresses_are_similar_enough_2(header.Layout_Header l, header.Layout_Header r) := 
		// FUNCTION
			// RETURN l.did = r.did AND  
						 // l.st = r.st AND
             // l.zip = r.zip AND (
						 // calbee.functions.prim_ranges_are_close_enough(l.prim_range, r.prim_range) 
						 // OR calbee.functions.street_names_are_close_enough(l.prim_name, r.prim_name) ) AND 
						 // calbee.functions.sec_ranges_are_close_enough(l.sec_range, r.sec_range);
		// END;
END;