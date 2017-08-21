export MAC_Parse_Geo
(
	 infile, 	// input recordset
	 name,   	// company name field in input recordset
	 state,  	// state field in input recordset
	 cty_name,	// city name field in the output recordset
	 outfile
) := MACRO

// add unique sequence number to input file
#uniquename(layout_infile_seq)
#uniquename(uid)
%layout_infile_seq% := RECORD
	infile;
	UNSIGNED8 %uid%;
END;

#uniquename(infile_seq)
ut.MAC_Sequence_Records_NewRec(infile, %layout_infile_seq%, %uid%, %infile_seq%)

#uniquename(init)
%init% := DISTRIBUTE(%infile_seq%, HASH(%uid%));

#uniquename(word)
#uniquename(cityname)
#uniquename(vcity)
#uniquename(magic1)
#uniquename(magic2)
#uniquename(find_city)

PATTERN %word% := text.alpha+;
PATTERN %cityname% := %word% REPEAT(text.ws %word%, 0, 3);
PATTERN %vcity% := VALIDATE(%cityname%, LENGTH(MATCHTEXT) > 2 
		AND Address.IsCityName(stringlib.stringtouppercase(MATCHTEXT))); 
PATTERN %magic1% := 'CITY' text.ws 'OF' text.ws;
PATTERN %magic2% := text.ws 'CITY';
PATTERN %find_city% :=	(FIRST | text.pws) 
							%magic1%? %vcity% %magic2%? 
						(LAST | text.pws);

#uniquename(layout_city)
%layout_city% := RECORD
	STRING30  pcty := MATCHTEXT(%vcity%);
	STRING2   st   := %init%.state;
	UNSIGNED8 rcid := %init%.%uid%;
	INTEGER1 magic_word := IF(MATCHED(%magic1%) OR MATCHED(%magic2%), 1 , 0);
	REAL affinity := 0;
END;

#uniquename(parsed)
%parsed% := PARSE(%init%, trim(name), %find_city%, %layout_city%, SCAN all);

#uniquename(pd_rcid)
%pd_rcid% := DISTRIBUTE(%parsed%, HASH(rcid)) : PERSIST(persistnames().MACParseGeo.Raw);

// The SCAN ALL parse may generate multiple rows with the
// same matchtext, so keep only unique ones per input record.
#uniquename(d)
%d% := DISTRIBUTE(
				DEDUP(
					SORT(%pd_rcid%,  rcid, pcty, LOCAL), 
									 rcid, pcty, LOCAL), HASH(pcty));

#uniquename(layout_stats_full)
%layout_stats_full% := RECORD
	%d%.pcty;
	%d%.st;
	UNSIGNED8 ct_n_s := COUNT(GROUP);
	UNSIGNED8 ct_s := 0;
	REAL perstate := 0;
	REAL perallother := 0;
	REAL affinity := 0;
END;

// Number of occurrences of each city per state.
#uniquename(table_full)
%table_full% := TABLE(%d%, %layout_stats_full%, pcty, st, LOCAL);

#uniquename(layout_stats_state)
%layout_stats_state% := RECORD
	%table_full%.st;
	UNSIGNED8 ct_s := SUM(GROUP, %table_full%.ct_n_s);
END;

// Total number of records (not unique cities) per state.
// *Not* a local operation.
#uniquename(table_state)
%table_state% := TABLE(%table_full%, %layout_stats_state%, st);

#uniquename(count_per_state)
%table_full% %count_per_state%(%table_full% le, %table_state% ri) := 
TRANSFORM
	SELF.ct_s := ri.ct_s;
	SELF.perstate := le.ct_n_s / ri.ct_s;
	SELF := le;
END;

// Join back on the original city/state table to get the ratio
// of each city to all cities per state.
#uniquename(perstate)
%perstate% := JOIN(	%table_full%, %table_state%, 
					LEFT.st = RIGHT.st, 
					%count_per_state%(LEFT, RIGHT), HASH);

// All city records.
#uniquename(ct_all)
%ct_all% := SUM(%table_state%, ct_s ) : PERSIST(persistnames().MACParseGeo.CityCount);

#uniquename(layout_stats_city)
%layout_stats_city% := RECORD
	%d%.pcty;
	UNSIGNED8 ct_n := COUNT(GROUP);
END;

// Number of occurrences of each city overall.
#uniquename(table_city)
%table_city% := TABLE(%d%, %layout_stats_city%, pcty, LOCAL);

// The 'affinity' of a city is defined as the ratio of its
// frequency in each state to its frequency in all other states.
// If the city is seen only in a single state, its affinity is
// set to a high value (10000).
#uniquename(get_affinity)
%layout_stats_full% %get_affinity%(%perstate% le, %table_city% ri) := 
TRANSFORM
	SELF.perallother := (ri.ct_n - le.ct_n_s) / (%ct_all% - le.ct_s);
	SELF.affinity := IF(SELF.perallother = 0, 
							10000, 
							le.perstate / SELF.perallother);
	SELF := le;
END;

#uniquename(full_stats)
%full_stats% := JOIN(	%perstate%, %table_city%, 
						LEFT.pcty = RIGHT.pcty, 
						%get_affinity%(LEFT, RIGHT), HASH);

// Dedup to get a list of unique cities.  If a city occurs in more
// than one state, we pick the highest affinity for it.
#uniquename(unique_stats)
%unique_stats% := DEDUP(
						SORT(
							DISTRIBUTE(	%full_stats%, 
										HASH(pcty)), 
							pcty, 
							-affinity, 
							LOCAL
							),
						pcty,
						LOCAL
					   );

#uniquename(layout_CityAffinity)
%layout_CityAffinity% := RECORD
	STRING25 city;
	REAL affinity;
END;

#uniquename(MakeNarrow)
%layout_CityAffinity% %MakeNarrow%(%unique_stats% le) := TRANSFORM
	SELF.city := le.pcty;
	SELF := le;
END;

#uniquename(narrow)
%narrow% := PROJECT(%unique_stats%, %MakeNarrow%(LEFT)) : PERSIST(persistnames().MACParseGeo.CityAffinity);

#uniquename(d_pcty)
%d_pcty% := DISTRIBUTE(
				DEDUP(
					SORT(%pd_rcid%, rcid, pcty, magic_word, LOCAL),
									rcid, pcty, magic_word, LOCAL), HASH(pcty));

#uniquename(add_affinity)
TYPEOF(%d_pcty%) %add_affinity%(%d_pcty% le, %narrow% ri) := TRANSFORM
	SELF.affinity := ri.affinity;
	SELF := le;
END;

#uniquename(withaffinity)
%withaffinity% := JOIN(	%d_pcty%, %narrow%, 
						LEFT.pcty = RIGHT.city,
						%add_affinity%(LEFT, RIGHT), LOCAL);

#uniquename(dist_rcid)
%dist_rcid% := DISTRIBUTE(%withaffinity%,  HASH(rcid));

// Keep only the best city for each record: Best is defined as
// having a magic word and the highest affinity.
#uniquename(best_city)
%best_city% := DEDUP(
						SORT(	%dist_rcid%, 
								rcid, 
								-magic_word, 
								-affinity, LOCAL
							),
						rcid, LOCAL
					 );

// Throw away parsed cities without the magic word whose affinity 
// is less than 8: a good empirical value as of 11/13/2003.
#uniquename(geo_result)
%geo_result% := %best_city%(magic_word = 1 OR affinity > 8);

#uniquename(layout_result)
%layout_result% := RECORD
	infile;
	QSTRING25 cty_name;
END;

#uniquename(format_result)
%layout_result% %format_result%(%init% le, %geo_result% ri) := TRANSFORM
	SELF.cty_name := ri.pcty;
	SELF := le;
END;

outfile := JOIN(	%init%, %geo_result%, 
					LEFT.%uid% = RIGHT.rcid,
					%format_result%(LEFT, RIGHT),
					LEFT OUTER, LOCAL) : PERSIST(persistnames().MACParseGeo.City);

ENDMACRO;