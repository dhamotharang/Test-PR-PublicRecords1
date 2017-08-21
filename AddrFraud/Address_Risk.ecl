import header, doxie_build, ut, doxie_files, liensv2, property, risk_indicators,SexOffender;

// these values only apply when risk_indicators.iid_constants.validation_debug is also true
// that value=false in production, so prebuilt files are never used there.
USE_PREBUILT_SO   := true;
USE_PREBUILT_CRIM := true;

TURNOVER_THRESHOLD := 90; // #days it takes prior to today to be considered a turnover

export Address_Risk := MODULE
	shared boolean isCurrent( unsigned4 dt_last_seen ) := ut.DaysApart( (string8)dt_last_seen, Constants.todayStr ) < 180;

	// given two dates (as strings), pick the appropriate one (pick populated over unpopulated; min/max for first/last seen)
	shared string8 pickDate( string8 dt1, string8 dt2, boolean isFirst ) := map(
		(unsigned4)dt1=0 => dt2,
		(unsigned4)dt2=0 => dt1,
		isFirst => (string8)min( (unsigned4)dt1, (unsigned4)dt2 ),
		(string8)max( (unsigned4)dt1, (unsigned4)dt2 )
	);

	export _getOccupants( dataset(Layouts.Address) addr_person ) := FUNCTION
		dist := distribute( addr_person, hash( st, county, geo_blk ) );
		
		layout_withOccupants := record
			Layouts.Address;
			Layouts.Occupancy;
		end;


		layout_withOccupants initializeAddr( Layouts.Address le ) := TRANSFORM
			self.occupants     := if( isCurrent( le.dt_last_seen ), 1, 0 ); // this person is currently at this address
			
			// this person was last seen at this address within the last year, two years, etc.
			self.occupants_1yr := if( Constants.oneYrAgo   between le.dt_first_seen and le.dt_last_seen, 1, 0 );
			self.occupants_2yr := if( Constants.twoYrAgo   between le.dt_first_seen and le.dt_last_seen, 1, 0 );
			self.occupants_3yr := if( Constants.threeYrAgo between le.dt_first_seen and le.dt_last_seen, 1, 0 );
			self.occupants_4yr := if( Constants.fourYrAgo  between le.dt_first_seen and le.dt_last_seen, 1, 0 );
			self.occupants_5yr := if( Constants.fiveYrAgo  between le.dt_first_seen and le.dt_last_seen, 1, 0 );

			self.turnover_1yr_in  := if( le.dt_first_seen between Constants.oneYrAgo   and Constants.today,           1, 0 );
			self.turnover_1yr_out := if( le.dt_last_seen  between Constants.oneYrAgo   and Constants.todayMinus(180), 1, 0 ); // you haven't moved out unless we haven't seen you in 6mo
			self.turnover_2yr_in  := if( le.dt_first_seen between Constants.twoYrAgo   and Constants.oneYrAgo,        1, 0 );
			self.turnover_2yr_out := if( le.dt_last_seen  between Constants.twoYrAgo   and Constants.oneYrAgo,        1, 0 );
			self.turnover_3yr_in  := if( le.dt_first_seen between Constants.threeYrAgo and Constants.twoYrAgo,        1, 0 );
			self.turnover_3yr_out := if( le.dt_last_seen  between Constants.threeYrAgo and Constants.twoYrAgo,        1, 0 );
			self.turnover_4yr_in  := if( le.dt_first_seen between Constants.fourYrAgo  and Constants.threeYrAgo,      1, 0 );
			self.turnover_4yr_out := if( le.dt_last_seen  between Constants.fourYrAgo  and Constants.threeYrAgo,      1, 0 );
			self.turnover_5yr_in  := if( le.dt_first_seen between Constants.fiveYrAgo  and Constants.fourYrAgo,       1, 0 );
			self.turnover_5yr_out := if( le.dt_last_seen  between Constants.fiveYrAgo  and Constants.fourYrAgo,       1, 0 );

			self := le;
			// self := [];
		END;
		addr := project( dist, initializeAddr(left), local );

		layout_withOccupants rollOccupants( layout_withOccupants le, layout_withOccupants ri ) := TRANSFORM
			self.occupants     := le.occupants     + ri.occupants;
			self.occupants_1yr := le.occupants_1yr + ri.occupants_1yr;
			self.occupants_2yr := le.occupants_2yr + ri.occupants_2yr;
			self.occupants_3yr := le.occupants_3yr + ri.occupants_3yr;
			self.occupants_4yr := le.occupants_4yr + ri.occupants_4yr;
			self.occupants_5yr := le.occupants_5yr + ri.occupants_5yr;
			
			self.turnover_1yr_in  := le.turnover_1yr_in  + ri.turnover_1yr_in;
			self.turnover_1yr_out := le.turnover_1yr_out + ri.turnover_1yr_out;
			self.turnover_2yr_in  := le.turnover_2yr_in  + ri.turnover_2yr_in;
			self.turnover_2yr_out := le.turnover_2yr_out + ri.turnover_2yr_out;
			self.turnover_3yr_in  := le.turnover_3yr_in  + ri.turnover_3yr_in;
			self.turnover_3yr_out := le.turnover_3yr_out + ri.turnover_3yr_out;
			self.turnover_4yr_in  := le.turnover_4yr_in  + ri.turnover_4yr_in;
			self.turnover_4yr_out := le.turnover_4yr_out + ri.turnover_4yr_out;
			self.turnover_5yr_in  := le.turnover_5yr_in  + ri.turnover_5yr_in;
			self.turnover_5yr_out := le.turnover_5yr_out + ri.turnover_5yr_out;
			
			
			self.dt_first_seen := min(le.dt_first_seen, ri.dt_first_seen);
			self.dt_last_seen  := max(le.dt_last_seen,  ri.dt_last_seen);
			self := le;
		END;
		
		
		sortaddr := sort( addr, st, county, geo_blk, prim_range, prim_name, suffix, unit_desig, sec_range, geo_blk, local );
		withOccupants := rollup( sortaddr,
			left.st        = right.st
				and left.county     = right.county
				and left.geo_blk    = right.geo_blk
				and left.prim_range = right.prim_range
				and left.prim_name  = right.prim_name
				and left.suffix     = right.suffix
				and left.unit_desig = right.unit_desig
				and left.sec_range  = right.sec_range,
			rollOccupants(left,right), local );
			
		return withOccupants;
	end;
	
	
	
	
	
	
	
	

	export _getCriminal( dataset(Layouts.Address) addr_person ) := FUNCTION
		layout_criminal := record
			Layouts.Address;
			unsigned4 arr_date;
			doxie_files.File_Offenders_Risk.offense.court_off_desc_1;
		end;
		
		dist_person := distribute( addr_person, did );
		
		#if(risk_indicators.iid_constants.validation_debug and USE_PREBUILT_CRIM)
		crim_file := dataset( '~thor400_88_dev::persist::criminal_offender_risk', recordof(doxie_files.file_offenders_risk), flat );
		dist_offenders := distribute( crim_file( traffic_flag='N', conviction_flag in ['Y','D'] ), (unsigned6)did );
		#else
		dist_offenders := distribute( doxie_files.File_Offenders_Risk( traffic_flag='N', conviction_flag in ['Y','D'] ), (unsigned6)did );
		#END
	
		layout_criminal getOffender( dist_person le, dist_offenders ri ) := TRANSFORM
			self.court_off_desc_1 := ri.offense.court_off_desc_1;
			self.arr_date := (unsigned4)ri.offense.arr_date;
			self := le;
			self := [];
		end;
		crim_offender := join( dist_person, dedup(dist_offenders,record,all,local), left.did=(unsigned6)right.did, getOffender(LEFT,RIGHT), local );
		
		dist := distribute(crim_offender(arr_date!=0), hash( st, county, geo_blk ) );
		
		layout_withCrimes := record
			Layouts.Address;
			Layouts.Crimes;
		end;
		
		layout_withCrimes initializeCrim( layout_criminal le ) := TRANSFORM
			self.crimes     := if( (unsigned4)le.arr_date between Constants.oneYrAgo   and Constants.today     , 1, 0 ); // this person was arrested w/in the last year
			self.crimes_1yr := if( (unsigned4)le.arr_date between Constants.twoYrAgo   and Constants.oneYrAgo  , 1, 0 );
			self.crimes_2yr := if( (unsigned4)le.arr_date between Constants.threeYrAgo and Constants.twoYrAgo  , 1, 0 );
			self.crimes_3yr := if( (unsigned4)le.arr_date between Constants.fourYrAgo  and Constants.threeYrAgo, 1, 0 );
			self.crimes_4yr := if( (unsigned4)le.arr_date between Constants.fiveYrAgo  and Constants.fourYrAgo , 1, 0 );
			self.crimes_5yr := if( (unsigned4)le.arr_date between Constants.sixYrAgo   and Constants.fiveYrAgo , 1, 0 );

			self := le;
		END;
		addr := project( dist, initializeCrim(left), local );
		
		layout_withCrimes rollCrimes( layout_withCrimes le, layout_withCrimes ri ) := TRANSFORM
			self.crimes     := le.crimes     + ri.crimes;
			self.crimes_1yr := le.crimes_1yr + ri.crimes_1yr;
			self.crimes_2yr := le.crimes_2yr + ri.crimes_2yr;
			self.crimes_3yr := le.crimes_3yr + ri.crimes_3yr;
			self.crimes_4yr := le.crimes_4yr + ri.crimes_4yr;
			self.crimes_5yr := le.crimes_5yr + ri.crimes_5yr;
			self.dt_first_seen := min(le.dt_first_seen, ri.dt_first_seen);
			self.dt_last_seen  := max(le.dt_last_seen,  ri.dt_last_seen);
			self := le;
		END;
		
		sortaddr := sort( addr, st, county, geo_blk, prim_range, prim_name, suffix, unit_desig, sec_range, local );
		withCrimes := rollup( sortaddr,
			left.st        = right.st
				and left.county     = right.county
				and left.geo_blk    = right.geo_blk
				and left.prim_range = right.prim_range
				and left.prim_name  = right.prim_name
				and left.suffix     = right.suffix
				and left.unit_desig = right.unit_desig
				and left.sec_range  = right.sec_range,
			rollCrimes(left,right), local );
		return withCrimes;
		
	END;
	
	export _getForeclosures( dataset(Layouts.Address) addr_person ) := FUNCTION
		layout_withforeclosures := record
			Layouts.Address;
			Layouts.Foreclosures;
		end;
		
		dist_addr_person := distribute( addr_person, did );
		dist_foreclosures := distribute( Property.File_Foreclosure(deed_category='U', trim(recording_date)!=''), (unsigned)name1_did );

		layout_withForeclosures initializeForeclosures( dist_addr_person l, dist_foreclosures r ) := TRANSFORM
			self.foreclosures     := if( (unsigned4)r.recording_date between Constants.oneYrAgo   and Constants.today     , 1, 0 );
			self.foreclosures_1yr := if( (unsigned4)r.recording_date between Constants.twoYrAgo   and Constants.oneYrAgo  , 1, 0 );
			self.foreclosures_2yr := if( (unsigned4)r.recording_date between Constants.threeYrAgo and Constants.twoYrAgo  , 1, 0 );
			self.foreclosures_3yr := if( (unsigned4)r.recording_date between Constants.fourYrAgo  and Constants.threeYrAgo, 1, 0 );
			self.foreclosures_4yr := if( (unsigned4)r.recording_date between Constants.fiveYrAgo  and Constants.fourYrAgo , 1, 0 );
			self.foreclosures_5yr := if( (unsigned4)r.recording_date between Constants.sixYrAgo   and Constants.fiveYrAgo , 1, 0 );
			self := l;
		END;
		
		addr := join( dist_addr_person, dist_foreclosures, left.did=(unsigned)right.name1_did, initializeForeclosures(left,right), local );
		
		layout_withForeclosures rollForeclosures( layout_withForeclosures l, layout_withForeclosures r ) := TRANSFORM
			self.foreclosures     := l.foreclosures     + r.foreclosures;
			self.foreclosures_1yr := l.foreclosures_1yr + r.foreclosures_1yr;
			self.foreclosures_2yr := l.foreclosures_2yr + r.foreclosures_2yr;
			self.foreclosures_3yr := l.foreclosures_3yr + r.foreclosures_3yr;
			self.foreclosures_4yr := l.foreclosures_4yr + r.foreclosures_4yr;
			self.foreclosures_5yr := l.foreclosures_5yr + r.foreclosures_5yr;
			self.dt_first_seen := min(l.dt_first_seen, r.dt_first_seen);
			self.dt_last_seen  := max(l.dt_last_seen,  r.dt_last_seen);
			self := l;
		END;
		
		redist := distribute( addr, hash(st,county,geo_blk) );
		
		sortaddr := sort( redist, st, county, geo_blk, prim_range, prim_name, suffix, unit_desig, sec_range, local );
		withForeclosures := rollup( sortaddr,
			left.st        = right.st
				and left.county    = right.county
				and left.geo_blk   = right.geo_blk
				and left.prim_range = right.prim_range
				and left.prim_name = right.prim_name
				and left.suffix    = right.suffix
				and left.unit_desig= right.unit_desig
				and left.sec_range = right.sec_range,
			rollForeclosures(left,right), local );
		return withForeclosures;
		
	END;
	
 	export _getSexOffenders( dataset(Layouts.Address) addr_person ) := FUNCTION
   		layout_sexoffender := record
   			Layouts.Address;
   			Layouts.SexOffenders;
			doxie_build.file_so_Enh_keybuilding.dt_first_reported;
			doxie_build.file_so_Enh_keybuilding.dt_last_reported;
   		end;
   		
   		dist_addr_person := distribute( addr_person, did );
		
		/* GET SEX OFFENDER DATA, ROLLUP ON DID TO KEEP ONLY ONE RECORD PER PERSON */
		// #if(risk_indicators.iid_constants.validation_debug and USE_PREBUILT_SO)
		SO_file := SexOffender.file_Main;
   	dist_SO := distribute( so_file( did!=0 ), did );
		// #else
   		// dist_SO := distribute( doxie_build.file_so_Enh_keybuilding( did!=0 ), did );
		// #end
		
		layout_so := recordof(dist_so);
		layout_so rollSO( layout_so le, layout_so ri ) := TRANSFORM
			self.dt_first_reported := pickDate( le.dt_first_reported, ri.dt_first_reported, true  );
			self.dt_last_reported  := pickDate( le.dt_first_reported, ri.dt_first_reported, false );
			self := le;
		end;
		dist_so_rolled := rollup( sort(dist_so,did,local), left.did=right.did, rollSO(left,right), local );
		/* </GET> */

   		layout_sexoffender getSexOffenders( dist_addr_person le, dist_SO_rolled ri ) := TRANSFORM
			self := le;
			self.dt_first_reported := ri.dt_first_reported;
			self.dt_last_reported  := ri.dt_last_reported;
			self := [];
   		end;
   		
   		// inner joining input persons to sex offenders rolled will produce results for sex offenders only
   		sexoffenders := join( dist_addr_person, dist_so_rolled, left.did=right.did, getSexOffenders(LEFT,RIGHT), local, keep(1) );
		
   		dist := distribute(sexoffenders, hash( st, county, geo_blk ));
   		
		
   		layout_withSexOffender := record
   			Layouts.Address;
   			Layouts.SexOffenders;
   		end;
   	
   		layout_withSexOffender initializeSexOffender( dist l ) := TRANSFORM
   			// this logic works under the premise of 'once a sex offender, always a sex offender'
			// values are calculated by determining whether the individual was reported prior to
			// the cutoff (eg, prior to today, then they're currently a sex offender)
   			self.SexOffenders     := if( (unsigned4)l.dt_first_reported < Constants.today     , 1, 0 );
   			self.SexOffenders_1yr := if( (unsigned4)l.dt_first_reported < Constants.oneYrAgo  , 1, 0 );
   			self.SexOffenders_2yr := if( (unsigned4)l.dt_first_reported < Constants.twoYrAgo  , 1, 0 );
   			self.SexOffenders_3yr := if( (unsigned4)l.dt_first_reported < Constants.threeYrAgo, 1, 0 );
   			self.SexOffenders_4yr := if( (unsigned4)l.dt_first_reported < Constants.fourYrAgo , 1, 0 );
   			self.SexOffenders_5yr := if( (unsigned4)l.dt_first_reported < Constants.fiveYrAgo , 1, 0 );
   			self := l;
   		END;
   		
   		addr := project( dist, initializeSexOffender(left), local );
   		
   		layout_withSexOffender rollSexOffender( layout_withSexOffender l, layout_withSexOffender r ) := TRANSFORM
   			self.SexOffenders     := l.SexOffenders     + r.SexOffenders;
   			self.SexOffenders_1yr := l.SexOffenders_1yr + r.SexOffenders_1yr;
   			self.SexOffenders_2yr := l.SexOffenders_2yr + r.SexOffenders_2yr;
   			self.SexOffenders_3yr := l.SexOffenders_3yr + r.SexOffenders_3yr;
   			self.SexOffenders_4yr := l.SexOffenders_4yr + r.SexOffenders_4yr;
   			self.SexOffenders_5yr := l.SexOffenders_5yr + r.SexOffenders_5yr;
   			self := l;
   		END;
   		
   		sortaddr := sort( addr, st, county, geo_blk, prim_range, prim_name, suffix, unit_desig, sec_range, local );
   		withSexOffender := rollup( sortaddr,
   			left.st        = right.st
   				and left.county    = right.county
   				and left.geo_blk   = right.geo_blk
   				and left.prim_range = right.prim_range
   				and left.prim_name = right.prim_name
   				and left.suffix    = right.suffix
   				and left.unit_desig= right.unit_desig
   				and left.sec_range = right.sec_range,
   			rollSexOffender(left,right), local );
   		return withSexOffender;
   		
   	END;


	export BuildRiskDataset( dataset(Layouts.Address) addr_person ) := FUNCTION
		/* given information on addresses and individuals there, calculate information on that address
		examples:
			occupant turnover rates
			motor vehicle velocity
			crime index
			etc.
		*/

		gotOccupants := _getOccupants( addr_person );
		gotCrim := _getCriminal( addr_person );
		Functions.Add( gotOccupants, gotCrim, Layouts.Crimes, withCrim );
		
		gotForeclosure := _getForeclosures( addr_person );
		Functions.Add( withCrim, gotforeclosure, Layouts.Foreclosures, withforeclosures );
		
		gotSO := _getSexOffenders( addr_person );
		Functions.Add( withForeclosures, gotSO, Layouts.SexOffenders, withSexOffenders);
		
		
		// for every sex offender, add one offense as of the first year the sex offense was recorded
		// (even though this logic could be described as "once a sex offender, always a sex offender,"
		// we're treating that as one offense that occurred once the person registered)
		
		recordof( withSexOffenders ) countSO( withSexOffenders le ) := TRANSFORM
			self.crimes_5yr := le.crimes_5yr + le.sexoffenders_5yr;
			self.crimes_4yr := le.crimes_4yr + le.sexoffenders_4yr-le.sexoffenders_5yr; // 4yr sex offenses is cumulative from 5 to 4, so subtract previous values
			self.crimes_3yr := le.crimes_3yr + le.sexoffenders_3yr-le.sexoffenders_4yr;
			self.crimes_2yr := le.crimes_2yr + le.sexoffenders_2yr-le.sexoffenders_3yr;
			self.crimes_1yr := le.crimes_1yr + le.sexoffenders_1yr-le.sexoffenders_2yr;
			self.crimes     := le.crimes     + le.sexoffenders    -le.sexoffenders_1yr;
			self := le;
		END;
		
		withSOCounted := project(withSexOffenders, countSO(LEFT) );

		return withSOCounted;
	end;

export BuildOccupantDataset( dataset(Layouts.Address) addr_person ) := FUNCTION

		gotOccupants := _getOccupants( addr_person );

		return gotOccupants;

	end;

END;