import address_attributes, AddrFraud, doxie, doxie_build, header, ut, PRTE2_Header;

//consolidate header down to individual addresses
	// head := doxie.header_pre_keybuild;
	head := PRTE2_Header.files.file_header_building;
	earliest := Address_Attributes.Constants.YearsAgo(8)[1..6];
	head_valid := head(
		dt_first_seen != 0,
		dt_last_seen > (unsigned3)earliest,
		/*prim_name[1..6] != 'PO BOX',*/
		TRIM(zip)!='',
		/*TRIM(prim_range)!='',*/
		TRIM(prim_name)!=''
		/*,TRIM(suffix)!=''*/);

//layout change
	rHead := RECORD
		STRING8	dt_first_seen;
		STRING8	dt_last_seen;
		RECORDOF(header.layout_header) AND NOT [dt_first_seen, dt_last_seen];
	END;
//

//slim down header
	dHead_valid := DISTRIBUTE(head_valid, HASH64(zip, prim_range, prim_name, suffix));
	rHead slimdown(dHead_valid l) := TRANSFORM
		SELF.dt_first_seen := (STRING)l.dt_first_seen + '01';
		SELF.dt_last_seen  := (STRING)l.dt_last_seen  + '01';
		SELF := l;
	END;
	slim_head := PROJECT(dHead_valid, slimdown(LEFT), LOCAL);

// rollup on people per address
	rHead dateRoll(rHead l, rHead r) := TRANSFORM
		SELF.dt_last_seen  := (STRING)max((UNSIGNED4)l.dt_last_seen,  (UNSIGNED4)r.dt_last_seen);
		SELF.dt_first_seen := (STRING)min((UNSIGNED4)l.dt_first_seen, (UNSIGNED4)r.dt_first_seen);
		SELF := l;
	END;

	slimsort := SORT(slim_head, did, zip, prim_range, prim_name, suffix, predir, postdir, sec_range, LOCAL);
	didRolled := ROLLUP(slimsort,
		LEFT.did				= RIGHT.did AND 
		LEFT.zip        = RIGHT.zip AND 
		LEFT.prim_range = RIGHT.prim_range AND 
		LEFT.prim_name  = RIGHT.prim_name AND 
		LEFT.suffix     = RIGHT.suffix AND
		LEFT.predir     = RIGHT.predir AND
		LEFT.postdir    = RIGHT.postdir AND
		LEFT.sec_range 	= RIGHT.sec_range,
		dateRoll(LEFT,RIGHT), LOCAL);

//roll address details AND  counts
	rOccupants := record
		AddrFraud.Layouts.Address AND NOT [did,geolink,latitude,longitude];
		AddrFraud.Layouts.Occupancy;
	end;
//

	dist_a2d := DISTRIBUTE(didRolled, HASH64(zip, prim_range, prim_name, suffix, predir, postdir));

	rOccupants initializeAddr(dist_a2d l) := TRANSFORM
		SELF.dt_first_seen := (UNSIGNED4)l.dt_first_seen;
		SELF.dt_last_seen  := (UNSIGNED4)l.dt_last_seen;
		SELF.occupants     := IF(Address_Attributes.Constants.isCurrent((UNSIGNED4)l.dt_last_seen), 1, 0 ); // this person is currently at this address
		
		// this person was last seen at this address within the last year, two years, etc.
		SELF.occupants_1yr := IF(Address_Attributes.Constants.oneYrAgo   BETWEEN (UNSIGNED4)l.dt_first_seen AND (UNSIGNED4)l.dt_last_seen, 1, 0);
		SELF.occupants_2yr := IF(Address_Attributes.Constants.twoYrAgo   BETWEEN (UNSIGNED4)l.dt_first_seen AND (UNSIGNED4)l.dt_last_seen, 1, 0);
		SELF.occupants_3yr := IF(Address_Attributes.Constants.threeYrAgo BETWEEN (UNSIGNED4)l.dt_first_seen AND (UNSIGNED4)l.dt_last_seen, 1, 0);
		SELF.occupants_4yr := IF(Address_Attributes.Constants.fourYrAgo  BETWEEN (UNSIGNED4)l.dt_first_seen AND (UNSIGNED4)l.dt_last_seen, 1, 0);
		SELF.occupants_5yr := IF(Address_Attributes.Constants.fiveYrAgo  BETWEEN (UNSIGNED4)l.dt_first_seen AND (UNSIGNED4)l.dt_last_seen, 1, 0);

		SELF.turnover_1yr_in  := IF( (UNSIGNED4)l.dt_first_seen BETWEEN Address_Attributes.Constants.oneYrAgo   AND Address_Attributes.Constants.today,           1, 0 );
		SELF.turnover_1yr_out := IF( (UNSIGNED4)l.dt_last_seen  BETWEEN Address_Attributes.Constants.oneYrAgo   AND Address_Attributes.Constants.todayMinus(180), 1, 0 ); // you haven't moved out unless we haven't seen you in 6mo
		SELF.turnover_2yr_in  := IF( (UNSIGNED4)l.dt_first_seen BETWEEN Address_Attributes.Constants.twoYrAgo   AND Address_Attributes.Constants.oneYrAgo,        1, 0 );
		SELF.turnover_2yr_out := IF( (UNSIGNED4)l.dt_last_seen  BETWEEN Address_Attributes.Constants.twoYrAgo   AND Address_Attributes.Constants.oneYrAgo,        1, 0 );
		SELF.turnover_3yr_in  := IF( (UNSIGNED4)l.dt_first_seen BETWEEN Address_Attributes.Constants.threeYrAgo AND Address_Attributes.Constants.twoYrAgo,        1, 0 );
		SELF.turnover_3yr_out := IF( (UNSIGNED4)l.dt_last_seen  BETWEEN Address_Attributes.Constants.threeYrAgo AND Address_Attributes.Constants.twoYrAgo,        1, 0 );
		SELF.turnover_4yr_in  := IF( (UNSIGNED4)l.dt_first_seen BETWEEN Address_Attributes.Constants.fourYrAgo  AND Address_Attributes.Constants.threeYrAgo,      1, 0 );
		SELF.turnover_4yr_out := IF( (UNSIGNED4)l.dt_last_seen  BETWEEN Address_Attributes.Constants.fourYrAgo  AND Address_Attributes.Constants.threeYrAgo,      1, 0 );
		SELF.turnover_5yr_in  := IF( (UNSIGNED4)l.dt_first_seen BETWEEN Address_Attributes.Constants.fiveYrAgo  AND Address_Attributes.Constants.fourYrAgo,       1, 0 );
		SELF.turnover_5yr_out := IF( (UNSIGNED4)l.dt_last_seen  BETWEEN Address_Attributes.Constants.fiveYrAgo  AND Address_Attributes.Constants.fourYrAgo,       1, 0 );

		SELF := l;
		SELF := [];

	END;
	addr := PROJECT(dist_a2d, initializeAddr(LEFT), LOCAL);

	rOccupants rollOccupants(rOccupants l, rOccupants r) := TRANSFORM
		SELF.occupants     := l.occupants     + r.occupants;
		SELF.occupants_1yr := l.occupants_1yr + r.occupants_1yr;
		SELF.occupants_2yr := l.occupants_2yr + r.occupants_2yr;
		SELF.occupants_3yr := l.occupants_3yr + r.occupants_3yr;
		SELF.occupants_4yr := l.occupants_4yr + r.occupants_4yr;
		SELF.occupants_5yr := l.occupants_5yr + r.occupants_5yr;
		
		SELF.turnover_1yr_in  := l.turnover_1yr_in  + r.turnover_1yr_in;
		SELF.turnover_1yr_out := l.turnover_1yr_out + r.turnover_1yr_out;
		SELF.turnover_2yr_in  := l.turnover_2yr_in  + r.turnover_2yr_in;
		SELF.turnover_2yr_out := l.turnover_2yr_out + r.turnover_2yr_out;
		SELF.turnover_3yr_in  := l.turnover_3yr_in  + r.turnover_3yr_in;
		SELF.turnover_3yr_out := l.turnover_3yr_out + r.turnover_3yr_out;
		SELF.turnover_4yr_in  := l.turnover_4yr_in  + r.turnover_4yr_in;
		SELF.turnover_4yr_out := l.turnover_4yr_out + r.turnover_4yr_out;
		SELF.turnover_5yr_in  := l.turnover_5yr_in  + r.turnover_5yr_in;
		SELF.turnover_5yr_out := l.turnover_5yr_out + r.turnover_5yr_out;
		
		
		SELF.dt_first_seen := MIN(l.dt_first_seen, r.dt_first_seen);
		SELF.dt_last_seen  := MAX(l.dt_last_seen,  r.dt_last_seen);
		SELF := l;
	END;


	sortaddr := SORt( addr, zip, prim_range, prim_name, suffix, predir, postdir, sec_range, LOCAL );
	withOccupants := ROLLUP( sortaddr,
		LEFT.zip        = RIGHT.zip AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.prim_name  = RIGHT.prim_name AND
		LEFT.suffix     = RIGHT.suffix AND
		LEFT.predir     = RIGHT.predir AND
		LEFT.postdir    = RIGHT.postdir AND
		LEFT.sec_range  = RIGHT.sec_range,
		rollOccupants(LEFT,RIGHT), LOCAL):PERSIST('~prte::jshaw::persist::address_velocity');
	
EXPORT file_address_velocity := withOccupants;