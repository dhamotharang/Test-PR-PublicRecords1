
IMPORT ut, Marketing_Best, Watchdog;

EXPORT functions := MODULE

	SHARED STREET_NAME_SIMILARITY_THRESHOLD := 40;
	SHARED PRIM_RANGE_SIMILARITY_THRESHOLD  := 25;

	// ...Local functions used for rollup:

	// ...For similar prim_ranges due to miskey or error, e.g. '1323' and '1373', or '3106' and '31106'
	SHARED prim_ranges_are_close_enough(QSTRING10 s1, QSTRING10 s2) := 
		FUNCTION
			RETURN datalib.StringSimilar100(s1,s2) <= PRIM_RANGE_SIMILARITY_THRESHOLD;
		END;
	
	// ...For similar streetnames due to miskey or error, e.g. 890 'KIRKWOOD' and 890 '890 KIRKWOOD', 'LACROSSE' and 'LA CROSSE'.
	SHARED street_names_are_close_enough(QSTRING28 s1, QSTRING s2) := 
		FUNCTION
			RETURN datalib.StringSimilar100(s1,s2) <= STREET_NAME_SIMILARITY_THRESHOLD;
		END;

	// ...For similar apartment or suite numbers due to miskey or error, e.g. APT '3108' and '3108E'.
	SHARED sec_ranges_are_close_enough(QSTRING28 s1, QSTRING s2) := 
		FUNCTION
			RETURN (s1 = '' AND s2 = '') OR ut.Lead_Contains(s1,s2);
		END;

	EXPORT addresses_are_similar_enough(layout_header_plus_seq l, layout_header_plus_seq r) := 
		FUNCTION
			RETURN l.did = r.did AND  
						 l.st = r.st AND
						 l.city_name = r.city_name AND
						 prim_ranges_are_close_enough(l.prim_range, r.prim_range) AND
						 street_names_are_close_enough(l.prim_name, r.prim_name) AND 
						 sec_ranges_are_close_enough(l.sec_range, r.sec_range);
		END;

	EXPORT STRING display_addr_1(Marketing_Best.layout_equifax_base addr) :=
		FUNCTION
			RETURN TRIM(addr.prim_range) 
					 + IF( TRIM(addr.predir)      != '', ' ' + TRIM(addr.predir), '' )
					 + IF( TRIM(addr.prim_name)   != '', ' ' + TRIM(addr.prim_name), '' )
					 + IF( TRIM(addr.addr_suffix) != '', ' ' + TRIM(addr.addr_suffix), '' )
					 + IF( TRIM(addr.postdir)     != '', ' ' + TRIM(addr.postdir), '' );
		END;
	
END;