import address_attributes, AddrFraud, doxie, doxie_build, header, ut;

//consolidate header down to individual addresses
	// head := doxie.header_pre_keybuild;
	head := doxie_build.file_header_building;
	earliest := ((STRING)Address_Attributes.Constants.YearsAgo(8))[1..6];
	head_valid := head(
		dt_first_seen != 0,
		dt_last_seen > (unsigned3)earliest,
		/*prim_name[1..6] != 'PO BOX',*/
		trim(zip)!='',
		/*trim(prim_range)!='',*/
		trim(prim_name)!=''
		/*,trim(suffix)!=''*/);

//layout change
	rHead := record
		string8	dt_first_seen;
		string8	dt_last_seen;
		recordof(header.layout_header) and not [dt_first_seen, dt_last_seen];
	end;
//

//slim down header
	dHead_valid := distribute(head_valid, hash64(zip, prim_range, prim_name, suffix));
	rHead slimdown(dHead_valid l) := TRANSFORM
		self.dt_first_seen := (string)l.dt_first_seen + '01';
		self.dt_last_seen  := (string)l.dt_last_seen  + '01';
		self := l;
	END;
	slim_head := project(dHead_valid, slimdown(left), local);

// rollup on people per address
	rHead dateRoll(rHead l, rHead r) := TRANSFORM
		self.dt_last_seen  := (string)max((unsigned4)l.dt_last_seen,  (unsigned4)r.dt_last_seen);
		self.dt_first_seen := (string)min((unsigned4)l.dt_first_seen, (unsigned4)r.dt_first_seen);
		self := l;
	END;

	slimsort := sort(slim_head, did, zip, prim_range, prim_name, suffix, predir, postdir, sec_range, local);
	didRolled := rollup(slimsort,
		left.did				= right.did and 
		left.zip        = right.zip and 
		left.prim_range = right.prim_range and 
		left.prim_name  = right.prim_name and 
		left.suffix     = right.suffix and
		left.predir     = right.predir and
		left.postdir    = right.postdir and
		left.sec_range 	= right.sec_range,
		dateRoll(left,right), local);

//roll address details and  counts
	rOccupants := record
		AddrFraud.Layouts.Address and not [did,geolink,latitude,longitude];
		AddrFraud.Layouts.Occupancy;
	end;
//

	dist_a2d := distribute(didRolled, hash64(zip, prim_range, prim_name, suffix, predir, postdir));

	rOccupants initializeAddr(dist_a2d l) := TRANSFORM
		self.dt_first_seen := (unsigned4)l.dt_first_seen;
		self.dt_last_seen := (unsigned4)l.dt_last_seen;
		self.occupants     := if(Address_Attributes.Constants.isCurrent((unsigned4)l.dt_last_seen), 1, 0 ); // this person is currently at this address
		
		// this person was last seen at this address within the last year, two years, etc.
		self.occupants_1yr := if(Address_Attributes.Constants.oneYrAgo   between (unsigned4)l.dt_first_seen and (unsigned4)l.dt_last_seen, 1, 0);
		self.occupants_2yr := if(Address_Attributes.Constants.twoYrAgo   between (unsigned4)l.dt_first_seen and (unsigned4)l.dt_last_seen, 1, 0);
		self.occupants_3yr := if(Address_Attributes.Constants.threeYrAgo between (unsigned4)l.dt_first_seen and (unsigned4)l.dt_last_seen, 1, 0);
		self.occupants_4yr := if(Address_Attributes.Constants.fourYrAgo  between (unsigned4)l.dt_first_seen and (unsigned4)l.dt_last_seen, 1, 0);
		self.occupants_5yr := if(Address_Attributes.Constants.fiveYrAgo  between (unsigned4)l.dt_first_seen and (unsigned4)l.dt_last_seen, 1, 0);

		self.turnover_1yr_in  := if( (unsigned4)l.dt_first_seen between Address_Attributes.Constants.oneYrAgo   and Address_Attributes.Constants.today,           1, 0 );
		self.turnover_1yr_out := if( (unsigned4)l.dt_last_seen  between Address_Attributes.Constants.oneYrAgo   and Address_Attributes.Constants.todayMinus(180), 1, 0 ); // you haven't moved out unless we haven't seen you in 6mo
		self.turnover_2yr_in  := if( (unsigned4)l.dt_first_seen between Address_Attributes.Constants.twoYrAgo   and Address_Attributes.Constants.oneYrAgo,        1, 0 );
		self.turnover_2yr_out := if( (unsigned4)l.dt_last_seen  between Address_Attributes.Constants.twoYrAgo   and Address_Attributes.Constants.oneYrAgo,        1, 0 );
		self.turnover_3yr_in  := if( (unsigned4)l.dt_first_seen between Address_Attributes.Constants.threeYrAgo and Address_Attributes.Constants.twoYrAgo,        1, 0 );
		self.turnover_3yr_out := if( (unsigned4)l.dt_last_seen  between Address_Attributes.Constants.threeYrAgo and Address_Attributes.Constants.twoYrAgo,        1, 0 );
		self.turnover_4yr_in  := if( (unsigned4)l.dt_first_seen between Address_Attributes.Constants.fourYrAgo  and Address_Attributes.Constants.threeYrAgo,      1, 0 );
		self.turnover_4yr_out := if( (unsigned4)l.dt_last_seen  between Address_Attributes.Constants.fourYrAgo  and Address_Attributes.Constants.threeYrAgo,      1, 0 );
		self.turnover_5yr_in  := if( (unsigned4)l.dt_first_seen between Address_Attributes.Constants.fiveYrAgo  and Address_Attributes.Constants.fourYrAgo,       1, 0 );
		self.turnover_5yr_out := if( (unsigned4)l.dt_last_seen  between Address_Attributes.Constants.fiveYrAgo  and Address_Attributes.Constants.fourYrAgo,       1, 0 );

		self := l;
		self := [];

	END;
	addr := project(dist_a2d, initializeAddr(left), local);

	rOccupants rollOccupants(rOccupants l, rOccupants r) := TRANSFORM
		self.occupants     := l.occupants     + r.occupants;
		self.occupants_1yr := l.occupants_1yr + r.occupants_1yr;
		self.occupants_2yr := l.occupants_2yr + r.occupants_2yr;
		self.occupants_3yr := l.occupants_3yr + r.occupants_3yr;
		self.occupants_4yr := l.occupants_4yr + r.occupants_4yr;
		self.occupants_5yr := l.occupants_5yr + r.occupants_5yr;
		
		self.turnover_1yr_in  := l.turnover_1yr_in  + r.turnover_1yr_in;
		self.turnover_1yr_out := l.turnover_1yr_out + r.turnover_1yr_out;
		self.turnover_2yr_in  := l.turnover_2yr_in  + r.turnover_2yr_in;
		self.turnover_2yr_out := l.turnover_2yr_out + r.turnover_2yr_out;
		self.turnover_3yr_in  := l.turnover_3yr_in  + r.turnover_3yr_in;
		self.turnover_3yr_out := l.turnover_3yr_out + r.turnover_3yr_out;
		self.turnover_4yr_in  := l.turnover_4yr_in  + r.turnover_4yr_in;
		self.turnover_4yr_out := l.turnover_4yr_out + r.turnover_4yr_out;
		self.turnover_5yr_in  := l.turnover_5yr_in  + r.turnover_5yr_in;
		self.turnover_5yr_out := l.turnover_5yr_out + r.turnover_5yr_out;
		
		
		self.dt_first_seen := min(l.dt_first_seen, r.dt_first_seen);
		self.dt_last_seen  := max(l.dt_last_seen,  r.dt_last_seen);
		self := l;
	END;


	sortaddr := sort( addr, zip, prim_range, prim_name, suffix, predir, postdir, sec_range, local );
	withOccupants := rollup( sortaddr,
		left.zip        = right.zip and
		left.prim_range = right.prim_range and
		left.prim_name  = right.prim_name and
		left.suffix     = right.suffix and
		left.predir     = right.predir and
		left.postdir    = right.postdir and
		left.sec_range  = right.sec_range,
		rollOccupants(left,right), local);
	
EXPORT file_address_velocity := withOccupants;