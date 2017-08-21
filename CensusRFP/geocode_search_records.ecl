
IMPORT Advo, BatchReverseServices;

options := Census_Options;
/*	MODULE				//(calbee.interfaces.Records)
		EXPORT exclude_persons            := FALSE;  // Includes people in the output.
		EXPORT exclude_businesses         := TRUE;   // Includes businesses in the output.
		EXPORT dt_range_start             := 201003; // YYYYMM format, or 0.
		EXPORT dt_range_end               := (UNSIGNED3)thorlib.wuid()[2..7]; //YYYYMM format, or 0.
		EXPORT exclude_if_match_is_best   := FALSE;  // Don't return if the found record matches best record
		EXPORT exclude_if_match_isnt_best := FALSE;  // Don't return if the found record doesn't match best record
		EXPORT date_of_residence          := 201004;
	END;
*/
advo_file := Advo.Files().File_Cleaned_Base : INDEPENDENT;
advo_filt := advo_file( StringLib.StringFind(prim_name, 'PO BOX', 1) = 0 AND
                        Residential_or_Business_Ind != 'B' AND
												//st IN ['DE','MI','NM']);
												st in options.st_filter);
												//st IN ['NJ','MI','NM']);

// Get the ADVO data.
addresses_all := 
	PROJECT(
		advo_filt,
		TRANSFORM(
			Layouts_census.Address,
			SELF.geo_lat := (real)LEFT.geo_lat,
			SELF.geo_long := (real)LEFT.geo_long,
			SELF := LEFT
		));

geocode_records_all := georges_GeocodeSearch_Records(addresses_all,options);
geocode_records_filt_on_state := geocode_records_all;

geocode_records_filt_on_state_ddpd := 
	DEDUP(
		SORT(
			DISTRIBUTED(geocode_records_filt_on_state,HASH64(id)),
			id,LOCAL
		),
		id,LOCAL
	);

// Look outside of DL, MI, NM to see where the person has lived and may have an alternate address.
geocode_records_plus_alt := 
	JOIN(
		DISTRIBUTED(geocode_records_filt_on_state_ddpd,HASH64(id)),
		DISTRIBUTED(geocode_records_all,HASH64(id)),
		LEFT.id = RIGHT.id,
		TRANSFORM(RIGHT),
		INNER
	);
		
// Get a snapshot of all addresses both in [ DL, MI, NM ] and possible alternates in other states.
EXPORT geocode_search_records := 
    geocode_records_plus_alt( options.date_of_residence BETWEEN dt_first_seen AND dt_last_seen)
      : PERSIST('Geocode_Search_Records');

// Total THOR time--
