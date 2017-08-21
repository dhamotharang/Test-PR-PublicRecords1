IMPORT Advo, BatchReverseServices, CellPhone, Doxie, Header, PhonesPlus_v2, Risk_Indicators;

EXPORT mac_Run() := FUNCTION
	
	ds_geocode_recs := geocode_search_records(dod = '' OR (UNSIGNED)dod >= Census_Options.min_dod);	// 20140101);
	
	// 1. Attach phone records. 

	rec_geocode_plus_phone := RECORD
		layouts_Census.final;
		STRING10 phone10;
		STRING1  phone_type;
		string12  phone_status;
		STRING8  phone_status_date;
		STRING10 cellphone;
		string12  cellphone_status;
		STRING8  cellphone_status_date;
	END;
	
	// ...Gong records...
	ds_geocode_with_gong1 :=
		JOIN(
			//DISTRIBUTE(ds_geocode_recs, HASH64((STRING28)prim_name, (STRING2)st, (STRING5)zip, (STRING10)prim_range)),
			//DISTRIBUTE(gong_by_address_current,HASH64(prim_name, st, z5, prim_range)),
			DISTRIBUTE(ds_geocode_recs, HASH64(st, zip)),
			DISTRIBUTE(gong_by_address_current,HASH64(st, z5)),
			LEFT.st = RIGHT.st AND
			LEFT.zip = RIGHT.z5 AND
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.sec_range = RIGHT.sec_range,
			TRANSFORM(
				rec_geocode_plus_phone,
				SELF.phone10 := RIGHT.phone10,
				self.phone_status := IF(RIGHT.connected,'ACTIVE','INACTIVE');
				self.phone_status_date := RIGHT.date_last_seen;
				SELF         := LEFT,
				SELF         := []
			),
			LEFT OUTER, LOCAL, KEEP(1));
			
	ds_geocode_with_gong_phone := ds_geocode_with_gong1(phone10<>'');
	
	ds_geocode_with_gong2 :=
		JOIN(
			//DISTRIBUTE(ds_geocode_recs, HASH64((STRING28)prim_name, (STRING2)st, (STRING5)zip, (STRING10)prim_range)),
			//DISTRIBUTE(gong_by_address_current,HASH64(prim_name, st, z5, prim_range)),
			DISTRIBUTE(ds_geocode_with_gong1(phone10=''), HASH64(st, zip)),
			DISTRIBUTE(gong_by_address_historical,HASH64(st, z5)),
			LEFT.st = RIGHT.st AND
			LEFT.zip = RIGHT.z5 AND
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.sec_range = RIGHT.sec_range,
			TRANSFORM(
				rec_geocode_plus_phone,
				SELF.phone10 := RIGHT.phone10,
				self.phone_status := IF(RIGHT.connected,'ACTIVE','INACTIVE');
				self.phone_status_date := RIGHT.date_last_seen;
				SELF         := LEFT,
				SELF         := []
			),
			LEFT OUTER, LOCAL, KEEP(1));	
			
			ds_geocode_with_gong := ds_geocode_with_gong_phone + ds_geocode_with_gong2;

	// ...for Gong records, determine phone type...
	// (Use non-local join to avoid horrendous skew.)
	ds_geocode_with_phonetype := 
		JOIN(
			DISTRIBUTE(ds_geocode_with_gong,HASH64(phone10[4..6],phone10[1..3],phone10[7])),
			DISTRIBUTE(Risk_Indicators.File_Telcordia_tds,HASH64(nxx,npa,tb)),
			LEFT.phone10[1..3] = RIGHT.npa AND
			LEFT.phone10[4..6] = RIGHT.nxx AND
			LEFT.phone10[7]    = RIGHT.tb,
			TRANSFORM(
				rec_geocode_plus_phone,
				SELF.phone_type := IF( TRIM(LEFT.phone10,LEFT,RIGHT) = '', '', functions.fn_GetPhoneTypeCode(RIGHT) ),
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER, LOCAL, KEEP(1));
			
	// ...see if the Gong number has been switched to a cellular number...
	ds_geocode_with_neustar := 
		JOIN(
			DISTRIBUTE(ds_geocode_with_phonetype,HASH64(phone10)),
			DISTRIBUTE(CellPhone.fileNeuStar,HASH64(CellPhone)),
			LEFT.phone10 = RIGHT.CellPhone,
			TRANSFORM(
				rec_geocode_plus_phone,
				SELF.phone_type := IF( LEFT.phone10 = RIGHT.CellPhone, constants.CELL_PHONE, LEFT.phone_type ),
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER, LOCAL, KEEP(1));
	
	// Now, CellPhone records
	ds_geocode_with_PhonesPlus :=
		JOIN(
			DISTRIBUTE(ds_geocode_with_neustar, HASH64(prim_name, st, zip, prim_range)),
			DISTRIBUTE(Phonesplus_v2.file_phonesplus_base(current_rec = true),HASH64(prim_name, state, zip5, prim_range)),
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.st = RIGHT.state AND
			(UNSIGNED)LEFT.zip = (UNSIGNED)RIGHT.zip5 AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.sec_range = RIGHT.sec_range AND
			LEFT.fname = RIGHT.fname AND
			LEFT.lname = RIGHT.lname AND
			RIGHT.datelastseen >= 201207, // from up to three years prior to running
			TRANSFORM(
				rec_geocode_plus_phone,
				SELF.cellphone := RIGHT.CellPhone,
				self.cellphone_status := IF(RIGHT.in_flag, 'ACTIVE', 'INACTIVE');
				self.cellphone_status_date := RIGHT.dateLastSeen+'01';
				SELF           := LEFT,
				SELF           := []
			),
			LEFT OUTER, LOCAL, KEEP(1));

	ds_geocode_with_phones_srtd := SORT(DISTRIBUTE(ds_geocode_with_PhonesPlus,HASH64(id)),(UNSIGNED)id,LOCAL);
	ds_geocode_with_phones_ddpd := DEDUP(ds_geocode_with_phones_srtd,(UNSIGNED)id,LOCAL); // Unique IDs for seeding--see below.

	// 2. Seed the final output layout with Link_id.
	census_recs_seed := 
		PROJECT(
			ds_geocode_with_phones_ddpd,
			TRANSFORM(
				layouts_census.layout_for_joins,
				SELF.link_id := LEFT.id,
				SELF := []
			));
			
	// 3. Add current and alternate addresses, and associated phones.
	ds_geocode_with_phones_grpd := GROUP(ds_geocode_with_phones_srtd,(UNSIGNED)id,LOCAL);
	//ds_geocode_with_phones_rsrt := SORT(ds_geocode_with_phones_grpd,-(st IN ['DE','MI','NM']),-dt_first_seen);
	ds_geocode_with_phones_rsrt := SORT(ds_geocode_with_phones_grpd,-(st IN Census_Options.st_filter),-dt_first_seen);

	census_recs_with_geocode :=
		DENORMALIZE(
			census_recs_seed, ds_geocode_with_phones_rsrt,
			(UNSIGNED)LEFT.link_id = (UNSIGNED)RIGHT.id,
			GROUP,
			TRANSFORM(
				layouts_census.layout_for_joins,
				SELF.title                   := RIGHT.title,
				SELF.fname                   := RIGHT.fname,
				SELF.mname                   := RIGHT.mname,
				SELF.lname                   := RIGHT.lname,
				SELF.name_suffix             := RIGHT.name_suffix,
				SELF.ssn                     := RIGHT.ssn,
				SELF.dob                     := RIGHT.dob,
				SELF.dod                     := RIGHT.dod,
				
				SELF.addr_curr_prim_range    := ROWS(RIGHT)[1].prim_range, 
				SELF.addr_curr_predir        := ROWS(RIGHT)[1].predir,
				SELF.addr_curr_prim_name     := ROWS(RIGHT)[1].prim_name,
				SELF.addr_curr_suffix        := ROWS(RIGHT)[1].suffix,
				SELF.addr_curr_postdir       := ROWS(RIGHT)[1].postdir,
				SELF.addr_curr_unit_desig    := ROWS(RIGHT)[1].unit_desig,
				SELF.addr_curr_sec_range     := ROWS(RIGHT)[1].sec_range,
				SELF.addr_curr_city_name     := ROWS(RIGHT)[1].city_name,
				SELF.addr_curr_st            := ROWS(RIGHT)[1].st,
				SELF.addr_curr_zip           := ROWS(RIGHT)[1].zip,
				SELF.addr_curr_zip4          := ROWS(RIGHT)[1].zip4,
				SELF.addr_curr_geo_lat       := IF( ROWS(RIGHT)[1].geo_lat = 0      , '', (STRING10)ROWS(RIGHT)[1].geo_lat ),
				SELF.addr_curr_geo_long      := IF( ROWS(RIGHT)[1].geo_long = 0     , '', (STRING11)ROWS(RIGHT)[1].geo_long ),
				SELF.addr_curr_dt_first_seen := IF( ROWS(RIGHT)[1].dt_first_seen = 0, '', (STRING6)ROWS(RIGHT)[1].dt_first_seen ),
				SELF.addr_curr_dt_last_seen  := IF( ROWS(RIGHT)[1].dt_last_seen = 0 , '', (STRING6)ROWS(RIGHT)[1].dt_last_seen ),

				SELF.listed_phone_num        := ROWS(RIGHT)[1].phone10,
				SELF.listed_phone_type       := IF( ROWS(RIGHT)[1].phone10 = '', '', ROWS(RIGHT)[1].phone_type ),
				SELF.listed_phone_status       := IF( ROWS(RIGHT)[1].phone10 = '', '', ROWS(RIGHT)[1].phone_status ),
				SELF.listed_phone_status_date       := IF( ROWS(RIGHT)[1].phone10 = '', '', ROWS(RIGHT)[1].phone_status_date ),
				SELF.alternate_phone_num     := ROWS(RIGHT)[2].phone10,
				SELF.alternate_phone_type    := IF( ROWS(RIGHT)[2].phone10 = '', '', ROWS(RIGHT)[2].phone_type ),
				SELF.alternate_phone_status       := IF( ROWS(RIGHT)[2].phone10 = '', '', ROWS(RIGHT)[1].phone_status ),
				SELF.alternate_phone_status_date       := IF( ROWS(RIGHT)[2].phone10 = '', '', ROWS(RIGHT)[1].phone_status_date ),
				SELF.cellphone_num           := ROWS(RIGHT)[1].cellphone,
				SELF.cellphone_status           := ROWS(RIGHT)[1].cellphone_status,
				SELF.cellphone_status_date      := ROWS(RIGHT)[1].cellphone_status_date,
		
				SELF.addr_alt_prim_range     := ROWS(RIGHT)[2].prim_range,
				SELF.addr_alt_predir         := ROWS(RIGHT)[2].predir,
				SELF.addr_alt_prim_name      := ROWS(RIGHT)[2].prim_name,
				SELF.addr_alt_suffix         := ROWS(RIGHT)[2].suffix,
				SELF.addr_alt_postdir        := ROWS(RIGHT)[2].postdir,
				SELF.addr_alt_unit_desig     := ROWS(RIGHT)[2].unit_desig,
				SELF.addr_alt_sec_range      := ROWS(RIGHT)[2].sec_range,
				SELF.addr_alt_city_name      := ROWS(RIGHT)[2].city_name,
				SELF.addr_alt_st             := ROWS(RIGHT)[2].st,
				SELF.addr_alt_zip            := ROWS(RIGHT)[2].zip,
				SELF.addr_alt_zip4           := ROWS(RIGHT)[2].zip4,
				SELF.addr_alt_geo_lat        := IF( ROWS(RIGHT)[2].geo_lat = 0      , '', (STRING10)ROWS(RIGHT)[2].geo_lat ),
				SELF.addr_alt_geo_long       := IF( ROWS(RIGHT)[2].geo_long = 0     , '', (STRING11)ROWS(RIGHT)[2].geo_long ),
				SELF.addr_alt_dt_first_seen  := IF( ROWS(RIGHT)[2].dt_first_seen = 0, '', (STRING6)ROWS(RIGHT)[2].dt_first_seen ),
				SELF.addr_alt_dt_last_seen   := IF( ROWS(RIGHT)[2].dt_last_seen = 0 , '', (STRING6)ROWS(RIGHT)[2].dt_last_seen ),
				
				SELF := LEFT,
				SELF := []
			),
			LOCAL);

	// 4. Add drivers license data...and while we're at it, re-format DOB and DOD as MMDDYYYY.
	census_recs_with_DL := 
		JOIN(
			census_recs_with_geocode,
			DISTRIBUTED(DL_records, HASH64(did)),
			(UNSIGNED)LEFT.link_id = (UNSIGNED)RIGHT.did,
			TRANSFORM(layouts_census.layout_for_joins,
				SELF.dl_number := RIGHT.dl_number,
				SELF.dl_state  := IF( TRIM(RIGHT.dl_number,LEFT,RIGHT) != '', (STRING2)RIGHT.orig_state, '' ),
				SELF.gender    := IF( RIGHT.sex_flag NOT IN ['M','F'], '', (STRING1)RIGHT.sex_flag ),
				SELF.race      := (STRING1)RIGHT.race,
				SELF.dob       := IF( TRIM(LEFT.dob,LEFT,RIGHT) = '0', '', 
				                      LEFT.dob[5..6] + LEFT.dob[7..8] + LEFT.dob[1..4] ),
				SELF.dod       := IF( TRIM(LEFT.dod,LEFT,RIGHT) = '0', '',
				                      LEFT.dod[5..6] + LEFT.dod[7..8] + LEFT.dod[1..4] ),
				SELF           := LEFT,
				SELF           := []
			),
			LEFT OUTER, LOCAL
		);
	
	// 5. Add first and second historical addresses. 
	
	// a. Remove the current and alternate addresses from the larger list of address history.
	addr_history_minus_current_and_alternate_pre := 
		JOIN(
			DISTRIBUTE(historical_header_records,HASH64(did)),
			DISTRIBUTED(ds_geocode_recs,HASH64(id)),
			LEFT.did = RIGHT.id AND 
		//	functions.addresses_are_similar_enough(LEFT,RIGHT),
			LEFT.st = RIGHT.st AND
			LEFT.zip = RIGHT.zip AND 
			(
			functions.prim_ranges_are_close_enough(LEFT.prim_range, RIGHT.prim_range) 
				OR functions.street_names_are_close_enough(LEFT.prim_name, RIGHT.prim_name) 
			) AND 
			functions.sec_ranges_are_close_enough(LEFT.sec_range, RIGHT.sec_range),
			TRANSFORM(LEFT),
			LEFT ONLY, LOCAL
		);
	
	// b. Remove any historical addresses that are more recent than 20100401.
	addr_history_minus_current_and_alternate := 
		//addr_history_minus_current_and_alternate_pre(dt_first_seen <= 201004 AND dt_last_seen <= 201004);
		addr_history_minus_current_and_alternate_pre(dt_first_seen <= 201506 AND dt_last_seen <= 201506);

	// c. Resort, group, dedup, keeping 2.
	remaining_addr_history_sort := SORT(addr_history_minus_current_and_alternate,did,-seq, LOCAL);
	remaining_addr_history_grpd := GROUP(remaining_addr_history_sort,did);
	remaining_addr_history_ddp2 := DEDUP(remaining_addr_history_grpd,did, KEEP 2);
	
	// d. Distribute randomly, call clean182, scrape off the lat and long.
	remaining_addr_history_dist := DISTRIBUTE(remaining_addr_history_ddp2,RANDOM());
	
	rec_remaining_addr_history_with_clean182 := RECORD
		RECORDOF(historical_header_records);
		STRING200 clean_address;
	END;
	
	remaining_addr_history_with_clean182 :=
		PROJECT(
			remaining_addr_history_dist,
			TRANSFORM(
				rec_remaining_addr_history_with_clean182,
				SELF.clean_address := '';

/*
					doxie.cleanaddress182( 
							IF( TRIM(LEFT.prim_range) != '', TRIM(LEFT.prim_range) + ' ', '' ) +
							IF( TRIM(LEFT.predir) != '', TRIM(LEFT.predir) + ' ', '' ) +
							IF( TRIM(LEFT.prim_name) != '', TRIM(LEFT.prim_name) + ' ', '' ) +
							IF( TRIM(LEFT.suffix) != '', TRIM(LEFT.suffix) + ' ', '' ) +
							IF( TRIM(LEFT.postdir) != '', TRIM(LEFT.postdir) + ' ', '' ) +
							IF( TRIM(LEFT.unit_desig) != '', TRIM(LEFT.unit_desig) + ' ', '' ) +
							IF( TRIM(LEFT.sec_range) != '', TRIM(LEFT.sec_range), '' )
							, 
							TRIM(LEFT.city_name) + ' ' + TRIM(LEFT.st) + ' ' + TRIM(LEFT.zip) 
							),*/
				SELF := LEFT
			));
	
	rec_remaining_addr_history_with_lat_long := RECORD
		RECORDOF(historical_header_records);
		REAL geo_lat;
		REAL geo_long;
	END;
		
	remaining_addr_history_with_lat_long := 
		PROJECT(
			remaining_addr_history_with_clean182,
			TRANSFORM(
				rec_remaining_addr_history_with_lat_long,
				SELF.geo_lat  := (REAL)LEFT.clean_address[146..155],
				SELF.geo_long := (REAL)LEFT.clean_address[156..166],
				SELF          := LEFT	
			));

	// Redistribute by did and attach hist_1 and hist_2 address records to output layout.
	remaining_addr_history_redist := DISTRIBUTE(remaining_addr_history_with_lat_long,HASH64(did));
	remaining_addr_history_resort := SORT(remaining_addr_history_redist,did,-seq, LOCAL);
	remaining_addr_history_regrpd := GROUP(remaining_addr_history_resort,did);
	
	census_recs_with_hist_addrs :=
		DENORMALIZE(
			census_recs_with_DL, remaining_addr_history_regrpd,
			(UNSIGNED)LEFT.link_id = (UNSIGNED)RIGHT.did,
			GROUP,
			TRANSFORM(
				layouts_census.layout_for_joins,
				SELF.addr_hist1_prim_range    := ROWS(RIGHT)[1].prim_range, 
				SELF.addr_hist1_predir        := ROWS(RIGHT)[1].predir,
				SELF.addr_hist1_prim_name     := ROWS(RIGHT)[1].prim_name,
				SELF.addr_hist1_suffix        := ROWS(RIGHT)[1].suffix,
				SELF.addr_hist1_postdir       := ROWS(RIGHT)[1].postdir,
				SELF.addr_hist1_unit_desig    := ROWS(RIGHT)[1].unit_desig,
				SELF.addr_hist1_sec_range     := ROWS(RIGHT)[1].sec_range,
				SELF.addr_hist1_city_name     := ROWS(RIGHT)[1].city_name,
				SELF.addr_hist1_st            := ROWS(RIGHT)[1].st,
				SELF.addr_hist1_zip           := ROWS(RIGHT)[1].zip,
				SELF.addr_hist1_zip4          := ROWS(RIGHT)[1].zip4,
				SELF.addr_hist1_geo_lat       := IF( ROWS(RIGHT)[1].geo_lat = 0      , '', (STRING10)ROWS(RIGHT)[1].geo_lat ),
				SELF.addr_hist1_geo_long      := IF( ROWS(RIGHT)[1].geo_long = 0     , '', (STRING11)ROWS(RIGHT)[1].geo_long ),
				SELF.addr_hist1_dt_first_seen := IF( ROWS(RIGHT)[1].dt_first_seen = 0, '', (STRING6)ROWS(RIGHT)[1].dt_first_seen ),
				SELF.addr_hist1_dt_last_seen  := IF( ROWS(RIGHT)[1].dt_last_seen = 0 , '', (STRING6)ROWS(RIGHT)[1].dt_last_seen ),
		
				SELF.addr_hist2_prim_range    := ROWS(RIGHT)[2].prim_range,
				SELF.addr_hist2_predir        := ROWS(RIGHT)[2].predir,
				SELF.addr_hist2_prim_name     := ROWS(RIGHT)[2].prim_name,
				SELF.addr_hist2_suffix        := ROWS(RIGHT)[2].suffix,
				SELF.addr_hist2_postdir       := ROWS(RIGHT)[2].postdir,
				SELF.addr_hist2_unit_desig    := ROWS(RIGHT)[2].unit_desig,
				SELF.addr_hist2_sec_range     := ROWS(RIGHT)[2].sec_range,
				SELF.addr_hist2_city_name     := ROWS(RIGHT)[2].city_name,
				SELF.addr_hist2_st            := ROWS(RIGHT)[2].st,
				SELF.addr_hist2_zip           := ROWS(RIGHT)[2].zip,
				SELF.addr_hist2_zip4          := ROWS(RIGHT)[2].zip4,
				SELF.addr_hist2_geo_lat       := IF( ROWS(RIGHT)[2].geo_lat = 0      , '', (STRING10)ROWS(RIGHT)[2].geo_lat ),
				SELF.addr_hist2_geo_long      := IF( ROWS(RIGHT)[2].geo_long = 0     , '', (STRING11)ROWS(RIGHT)[2].geo_long ),
				SELF.addr_hist2_dt_first_seen := IF( ROWS(RIGHT)[2].dt_first_seen = 0, '', (STRING6)ROWS(RIGHT)[2].dt_first_seen ),
				SELF.addr_hist2_dt_last_seen  := IF( ROWS(RIGHT)[2].dt_last_seen = 0 , '', (STRING6)ROWS(RIGHT)[2].dt_last_seen ),
				
        SELF := LEFT,
				SELF := []
			),
			LOCAL);

	results_raw := 
		PROJECT(
			census_recs_with_hist_addrs, 
			TRANSFORM(
				layouts_census.layout_out,
				SELF.link_id := (STRING20)LEFT.link_id,
				SELF := LEFT
			));
	
	//results_redacted := PROJECT(results_raw, transforms.xfm_redact_results(LEFT));
// this is new for 2015

	ds2015 := CensusRFP.ConvertTo2015(results_raw);	
		
	RETURN ds2015;

END;
