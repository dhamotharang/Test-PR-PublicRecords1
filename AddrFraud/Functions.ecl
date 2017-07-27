import address_attributes, iesp, easi, header, infutor;

export Functions := MODULE

	EXPORT GeoDist( real lat1, real lon1, real lat2, real lon2 ) :=
		// calculate the great circle distance between two points (lat1,lon1) and (lat2,lon2).
		// it's possible that a speedup could be made by converting this to a function that
		// calculates -lat1/57.2958 and -lat2/57.2958 once instead of multiple times; perhaps a macro would be best,
		// though it's not the most convenient syntax when being called
		3963.0 * acos(
			sin(-lat1/57.2958)*sin(-lat2/57.2958)
			+ cos(-lat1/57.2958)*cos(-lat2/57.2958)*cos(-lon2/57.2958 + lon1/57.2958)
		);
		
	EXPORT DecToDMS( string inStr) := Function
		//Convert from decimal latitude or longitude format into Degrees Minutes Seconds format
		inDec := (real)inStr;
		degrees := (integer)(abs(inDec));
		minutes := (abs(inDec) - degrees) * 60;
		tmin := (integer)minutes;
		seconds := (minutes - tmin) * 60;
		tsec := (integer)seconds;
		finalDMS := intformat(truncate(degrees),3,1) + intformat(tmin,2,1) + intformat(tsec,2,1);
		Return finalDMS;
	End;
	
	export CalculateScore( dataset(Layouts.AddrRisk_Key) unscored ) := FUNCTION
	
		Layouts.AddrRisk_Scored addScore( unscored le, Easi.Key_Easi_Census ri ) := TRANSFORM
		
			set_default_score := if((integer)le.occupants < 1 or (integer)ri.LOWINC < 1 or (integer)ri.FAMOTF18_P < 1, 1, 0); //per legal 11/01/11 - set a default score when no data is present
			
			//Indexes
			Crime_Index_Raw 	:= if(le.crimes*100000/le.occupants > 1000, 999, le.crimes*100000/le.occupants);
			Poverty_Index_Raw := ((real)ri.LOWINC/100);
		
			personsPerHouse := 2;
			
			Foreclosure_Index_Raw := le.foreclosures*100000/(le.occupants/personsPerHouse);
			Disruption_Index_Raw  := ((real)ri.FAMOTF18_P/100);
			
			Mobility_Index_Raw    := (le.turnover_1yr_in + le.turnover_1yr_out)/le.occupants_1yr;
			
			//Account for zero values
			//Crime_Index 	:= if(Crime_Index_Raw<=0, .043635, abs(Crime_Index_Raw));
			//Crime_Index 	:= 2.387 * (if(Crime_Index_Raw<=0, 0, Crime_Index_Raw));  //2.387 arbitrary weight
			Crime_Index 	:= .5*(if(Crime_Index_Raw<=0, 0, Crime_Index_Raw));
			
			//Poverty_Index := if(Poverty_Index_Raw<=0, .091344, abs(Poverty_Index_Raw));
			Poverty_Index := 100*(if(Poverty_Index_Raw<=0, 0, Poverty_Index_Raw));
			
			//Foreclosure_Index := if(Foreclosure_Index_Raw<=0, .012574, abs(Foreclosure_Index_Raw));
			Foreclosure_Index := .0233*(if(Foreclosure_Index_Raw<=0, 0, Foreclosure_Index_Raw));
			
			//Disruption_Index := if(Disruption_Index_Raw<=0, .023284, abs(Disruption_Index_Raw));
			Disruption_Index := 100*(if(Disruption_Index_Raw<=0, 0, Disruption_Index_Raw));

			//Mobility_Index := if(Mobility_Index_Raw<=0, .512008, abs(Mobility_Index_Raw));
			Mobility_Index := 100 * abs(Mobility_Index_Raw);
			
			risk_SOS := if(Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index >= 1000, 999, Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index);
			
			Risk_Index := if(set_default_score = 1, 0, risk_SOS); 
			
		
			self.Crime_Index := Crime_Index;
			self.Poverty_Index := abs(Poverty_Index);
			self.Foreclosure_Index := Foreclosure_Index;
			self.Disruption_Index := abs(Disruption_Index);
			self.Mobility_Index := Mobility_Index;
			self.Risk_Index := Risk_Index;

			self := le;
			self.miles := 0;
		END;
	
	
		final := join( unscored, Easi.Key_Easi_Census, keyed(left.geolink=right.geolink), addScore(left,right), keep(1), left outer );
		return final;
	END;
	
	export AddrToDID( dataset(header.layout_header) head, boolean ByGeoBlk = true ) := FUNCTION
		dist := distribute( head, hash32( st, county, geo_blk ) );
		
		header.layout_header slimdown( dist le ) := TRANSFORM
			// we're calculating by geo block, so blank out the specific address components.
			self.prim_range := if( ByGeoBlk, '', le.prim_range );
			self.predir     := if( ByGeoBlk, '', le.predir     );
			self.prim_name  := if( ByGeoBlk, '', le.prim_name  );
			self.suffix     := if( ByGeoBlk, '', le.suffix     );
			self.postdir    := if( ByGeoBlk, '', le.postdir    );
			self.unit_desig := if( ByGeoBlk, '', le.unit_desig );
			self.sec_range  := if( ByGeoBlk, '', le.sec_range  );
			self := le;
		END;
		slim := project( dist, slimdown(left), local );
		
		// rollup on people		
		header.layout_header dateRoll( header.layout_header le, header.layout_header ri ) := TRANSFORM
			self.dt_last_seen  := max(le.dt_last_seen,  ri.dt_last_seen);
			self.dt_first_seen := min(le.dt_first_seen, ri.dt_first_seen);
			self := le;
		END;
		
		slimsort := sort( slim, did, st, county, geo_blk, prim_range, prim_name, suffix, local );
		dateRolled := rollup( slimsort,
			left.did=right.did
				and left.st         = right.st
				and left.county     = right.county
				and left.geo_blk    = right.geo_blk
				and left.prim_range = right.prim_range
				and left.prim_name  = right.prim_name 
				and left.suffix     = right.suffix,
			dateRoll(left,right), local );

		return dateRolled;
	END;
	
	export AddrToDIDInfutor( dataset(layouts.Infutor_geolink) head, boolean ByGeoBlk = true ) := FUNCTION
		dist := distribute( head, hash32( st, fips_county, geo_blk ) );
		
		Layouts.Infutor_geolink slimdown( dist le ) := TRANSFORM
			// we're calculating by geo block, so blank out the specific address components.
			self.prim_range := if( ByGeoBlk, '', le.prim_range );
			self.predir     := if( ByGeoBlk, '', le.predir     );
			self.prim_name  := if( ByGeoBlk, '', le.prim_name  );
			self.addr_suffix:= if( ByGeoBlk, '', le.addr_suffix);
			self.postdir    := if( ByGeoBlk, '', le.postdir    );
			self.unit_desig := if( ByGeoBlk, '', le.unit_desig );
			self.sec_range  := if( ByGeoBlk, '', le.sec_range  );
			self := le;
		END;
		slim := project( dist, slimdown(left), local );
		
		// rollup on people		
		Layouts.Infutor_geolink dateRoll( Layouts.Infutor_geolink le, Layouts.Infutor_geolink ri ) := TRANSFORM
			self.last_activity_dt  := max(le.last_activity_dt,  ri.last_activity_dt);
			self.orig_filing_dt 	 := min(le.orig_filing_dt, ri.orig_filing_dt);
			self := le;
		END;
		
		slimsort := sort( slim, did, st, fips_county, geo_blk, prim_range, prim_name, addr_suffix, local );
		dateRolled := rollup( slimsort,
			left.did=right.did
				and left.st          = right.st
				and left.fips_county = right.fips_county
				and left.geo_blk     = right.geo_blk
				and left.prim_range  = right.prim_range
				and left.prim_name   = right.prim_name 
				and left.addr_suffix = right.addr_suffix,
			dateRoll(left,right), local );

		return dateRolled;
	END;
	
	export Add( ds1, ds2, layout_add, both ) := MACRO
		#uniquename(layout_both)
		%layout_both% := record
			ds1;
			layout_add;
		end;
		
		#uniquename(add2)
		%layout_both% %add2%( ds1 le, ds2 ri ) := TRANSFORM
			self := le;
			self := ri;
		end;

		both := join(
			distribute( ds1, hash( st, county, geo_blk ) ),
			distribute( ds2, hash( st, county, geo_blk ) ),
			left.st        = right.st
				and left.county    = right.county
				and left.geo_blk   = right.geo_blk
				and left.prim_range = right.prim_range
				and left.prim_name = right.prim_name
				and left.suffix    = right.suffix
				and left.unit_desig= right.unit_desig
				and left.sec_range = right.sec_range,
			%add2%(left,right), left outer, local, keep(1)
		);
	ENDMACRO;
		
		
	EXPORT FindGeoBlocks( real4 latitude, real4 longitude, real4 radius_miles ) := FUNCTION
		// find all geo blocks within radius_miles of the input (lat,lon).
		// convert from miles to latitudinal degrees. in order to avoid minor floating
		// point imprecision, give a small amount of wiggle room in the threshold.
		DEGREE_THRESHOLD := (radius_miles/69.167374)*1.1;
		
		matches := Key_GeoLink_LatLon(
			keyed( lat1000 between (integer4)(1000*(latitude-DEGREE_THRESHOLD)) and roundup(1000*(latitude+DEGREE_THRESHOLD) )) 
		);
		
		L := record
			qstring12 geolink;
			real4 lat;
			real4 lon;
			real4 miles;
		end;
		
		L addMiles( matches le ) := TRANSFORM
			self.miles := GeoDist( latitude, longitude, le.lat, le.lon );
			self := le;
		END;
		withMiles := project( matches, addMiles(LEFT) );
		
		filtered := sort( withMiles( miles < radius_miles ), miles );
		return filtered;
	END;

	export isAdjacent(string2 state1, string2 state2) := (state1 = state2) or 
						CASE(state1,
											//'AK' => state2 in [AK],
											'AL' => state2 in ['MS', 'TN', 'GA', 'FL'],
											'AR' => state2 in ['TX', 'OK', 'MO', 'TN', 'MS', 'LA'],
											//'AS' => state2 in ['AS'],
											'AZ' => state2 in ['CA', 'NV', 'UT', 'CO', 'NM'],
											'CA' => state2 in ['OR', 'NV', 'AZ'],
											'CO' => state2 in ['UT', 'WY', 'NE', 'KS', 'OK', 'NM', 'AZ'],
											'CT' => state2 in ['NY', 'MA', 'RI'],
											'DE' => state2 in ['NJ', 'PA', 'MD'],
											'DC' => state2 in ['MD', 'VA'],
											'FL' => state2 in ['AL', 'GA'],
											//'FM' => state2 in ['FM'],
											'GA' => state2 in ['FL', 'AL', 'TN', 'NC', 'SC'],
											//'GU' => state2 in ['GU'],
											//'HI' => state2 in ['HI'],
											'ID' => state2 in ['WA', 'OR', 'NV', 'UT', 'WY', 'MT'],
											'IL' => state2 in ['WI', 'IA', 'MO', 'KY', 'IN'],
											'IN' => state2 in ['IL', 'KY', 'OH', 'MI'],
											'IA' => state2 in ['MN', 'WI', 'IL', 'MO', 'NE', 'SD'],
											'KS' => state2 in ['NE', 'CO', 'OK', 'MO'],
											'KY' => state2 in ['MO', 'IL', 'IN', 'OH', 'WV', 'VA', 'TN'],
											'LA' => state2 in ['TX', 'AR', 'MS'],
											'MA' => state2 in ['RI', 'CT', 'NY', 'VT', 'NH', 'ME'],
											'MD' => state2 in ['WV', 'VA', 'PA', 'DE', 'DC'],
											'ME' => state2 in ['NH', 'MA'],
											//'MH' => state2 in ['MH'],
											'MI' => state2 in ['WI', 'IN', 'OH'],
											'MN' => state2 in ['ND', 'SD', 'IA', 'WI'],
											'MO' => state2 in ['IA', 'IL', 'KY', 'TN', 'AR', 'OK', 'KS', 'NE'],
											'MS' => state2 in ['LA', 'AR', 'TN', 'AL'],
											'MT' => state2 in ['ID', 'ND', 'SD', 'WY'],
											'NE' => state2 in ['WY', 'SD', 'IA', 'MO', 'KS', 'CO'],
											'NH' => state2 in ['VT', 'MA', 'ME'],
											'NV' => state2 in ['CA', 'OR', 'ID', 'UT', 'AZ'],
											'NJ' => state2 in ['DE', 'NY', 'PA'],
											'NM' => state2 in ['AZ', 'UT', 'CO', 'OK', 'TX'],
											'NY' => state2 in ['VT', 'MA', 'CT', 'NJ', 'PA'],
											'NC' => state2 in ['VA', 'GA', 'TN', 'SC'],
											'ND' => state2 in ['MT', 'MN', 'SD'],
											//'MP' => state2 in ['MP'],
											'OH' => state2 in ['MI', 'PA', 'WV', 'KY', 'IN'],
											'OK' => state2 in ['CO', 'KS', 'MO', 'AR', 'TX', 'NM'],
											'OR' => state2 in ['WA', 'ID', 'CA', 'NV'],
											//'PW' => state2 in ['PW'],
											'PA' => state2 in ['NY', 'NJ', 'DE', 'MD', 'WV', 'OH'],
											//'PR' => state2 in ['PR'],
											'RI' => state2 in ['MA', 'CT'],
											'SC' => state2 in ['NC', 'GA'],
											'SD' => state2 in ['MT', 'ND', 'MN', 'IA', 'NE', 'WY'],
											'TN' => state2 in ['MO', 'KY', 'VA', 'NC', 'GA', 'AL', 'MS', 'AR'],
											'TX' => state2 in ['NM', 'OK', 'AR', 'LA'],
											'UT' => state2 in ['ID', 'WY', 'CO', 'NM', 'AZ', 'NV'],
											'VA' => state2 in ['MD', 'WV', 'KY', 'TN', 'NC', 'DC'],
											//'VI' => state2 in ['VI'],
											'VT' => state2 in ['NY', 'MA', 'NH'],
											'WA' => state2 in ['OR','ID'],
											'WI' => state2 in ['MN', 'MI', 'IL', 'IA'],
											'WV' => state2 in ['MD', 'VA', 'KY', 'OH', 'PA'],
											'WY' => state2 in ['ID', 'MT', 'SD', 'NE', 'CO', 'UT'],
											FALSE);


	// create a list of all distances from geoblock1 to geoblock2 where the distance between is <= maxdist.
	export FileDistance( real maxdist ) := FUNCTION
		f := addrfraud.File_GeoBlock_Info;

		layout_g2g := record
			string12 geolink1;
			string12 geolink2;
			real4 distance;
		end;
		
		// this is a large dataset. the isAdjacent condition will limit its size by only considering those
		// geoblock pairs where both are in the same or immediately neighboring states.
		geo2geo := join( f, f, isAdjacent(left.geolink[1..2],right.geolink[1..2]),
			transform( layout_g2g,
				self.geolink1 := left.geolink,
				self.geolink2 := right.geolink,
				self.distance := GeoDist( (real4)left.lat, (real4)left.long, (real4)right.lat, (real4)right.long )
			),
			all
		);

		// limit this down to a reasonable number; eg, the points (48.840136,-115.799561) and (43.013183,-96.673508) are in
		// bordering states but are too far apart to be relevant.
		l_seq := record
			geo2geo;
			integer4 seq := 1;
		end;
		withseq := table( geo2geo( geolink1!=geolink2 ), l_seq );

		l_seq iter( l_seq le, l_seq ri ) := TRANSFORM
			self.seq := if( le.geolink1=ri.geolink1, le.seq+1, 1 );
			self := ri;
		END;
		geo2geo_preiter := sort( distribute( withseq, hash32((string12)geolink1)), geolink1, distance, local );
		geo2geo_iter := iterate( geo2geo_preiter, iter(left,right), local );
		geo2geo_filtered := project( geo2geo_iter(seq <= maxdist), layout_g2g ):persist('~thor_data400::persist::filedistance_geo2geo');

		return geo2geo_filtered;
	END;
	
	
	export formatIESP_out(dataset(layouts.AddrRisk_Scored) Scored) :=Function
		iesp.addressrisksearch.t_AddrRiskSearchRecord toESDL(scored l):=transform
			self.GeoLink 								:= l.GeoLink;
			self.GeoLocation.Latitude 	:= (string)l.Latitude;
			self.GeoLocation.Longitude 	:= (string)l.Longitude;
			self.Occupants.Current 		:= (string)l.occupants;
			self.Occupants.Last 			:= (string)l.occupants_1yr;
			self.Occupants.Two 				:= (string)l.occupants_2yr;
			self.Occupants.Three 			:= (string)l.occupants_3yr;
			self.Occupants.Four 			:= (string)l.occupants_4yr;
			self.Occupants.Five 			:= (string)l.occupants_5yr;
			self.PeopleMovedIn.Current := '';
			self.PeopleMovedIn.Last 	:= (string)l.turnover_1yr_in;
			self.PeopleMovedIn.Two 		:= (string)l.turnover_2yr_in;
			self.PeopleMovedIn.Three 	:= (string)l.turnover_3yr_in;
			self.PeopleMovedIn.Four 	:= (string)l.turnover_4yr_in;
			self.PeopleMovedIn.Five 	:= (string)l.turnover_5yr_in;
			self.PeopleMovedOut.Current := '';
			self.PeopleMovedOut.Last 	:= (string)l.turnover_1yr_out;
			self.PeopleMovedOut.Two 	:= (string)l.turnover_2yr_out;
			self.PeopleMovedOut.Three := (string)l.turnover_3yr_out;
			self.PeopleMovedOut.Four 	:= (string)l.turnover_4yr_out;
			self.PeopleMovedOut.Five 	:= (string)l.turnover_5yr_out;
			self.Crimes.Current 			:= (string)l.crimes;
			self.Crimes.Last 					:= (string)l.crimes_1yr;
			self.Crimes.Two 					:= (string)l.crimes_2yr;
			self.Crimes.Three 				:= (string)l.crimes_3yr;
			self.Crimes.Four 					:= (string)l.crimes_4yr;
			self.Crimes.Five 					:= (string)l.crimes_5yr;
			self.Foreclosures.Current := (string)l.foreclosures;
			self.Foreclosures.Last 		:= (string)l.foreclosures_1yr;
			self.Foreclosures.Two 		:= (string)l.foreclosures_2yr;
			self.Foreclosures.Three 	:= (string)l.foreclosures_3yr;
			self.Foreclosures.Four 		:= (string)l.foreclosures_4yr;
			self.Foreclosures.Five 		:= (string)l.foreclosures_5yr;
			self.SexOffenders.Current := (string)l.sexoffenders;
			self.SexOffenders.Last 		:= (string)l.sexoffenders_1yr;
			self.SexOffenders.Two 		:= (string)l.sexoffenders_2yr;
			self.SexOffenders.Three 	:= (string)l.sexoffenders_3yr;
			self.SexOffenders.Four 		:= (string)l.sexoffenders_4yr;
			self.SexOffenders.Five 		:= (string)l.sexoffenders_5yr;
			self.Indices.Crime 				:= (string)l.Crime_Index;
			self.Indices.Poverty 			:= (string)l.Poverty_Index;
			self.Indices.Foreclosure 	:= (string)l.Foreclosure_Index;
			self.Indices.Disruption		:= (string)l.Disruption_Index;
			self.Indices.Mobility			:= (string)l.Mobility_Index;
			self.Indices.Risk					:= (string)l.Risk_Index;
			self.MilesToTargetProperty := (string)l.miles;
			self :=[];
		End;

		Scored2 := project(scored, toESDL(left));
		d := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d l):=transform
			self.RecordCount := Count(Scored2);
			self.Records := sort(Scored2, MilesToTargetProperty);
			self := [];
		End;

		Final := project(d, finalform(left));			
		Return Final;
	End;												


	export formatAR_IESP_out_0(dataset(layouts.AddrRisk_Scored) Input) :=Function //All Report details
		iesp.addressrisksearch.t_AddrRiskSearchRecord toESDL(Input l):=transform
			self.GeoLink 								:= l.GeoLink;
			self.GeoLocation.Latitude 	:= (string)l.Latitude;
			self.GeoLocation.Longitude 	:= (string)l.Longitude;
			
			self.Occupants.Current 		:= (string)l.occupants;
			self.Occupants.Last 			:= (string)l.occupants_1yr;
			self.Occupants.Two 				:= (string)l.occupants_2yr;
			self.Occupants.Three 			:= (string)l.occupants_3yr;
			self.Occupants.Four 			:= (string)l.occupants_4yr;
			self.Occupants.Five 			:= (string)l.occupants_5yr;
			
			self.PeopleMovedIn.Current := '';
			self.PeopleMovedIn.Last 	:= (string)l.turnover_1yr_in;
			self.PeopleMovedIn.Two 		:= (string)l.turnover_2yr_in;
			self.PeopleMovedIn.Three 	:= (string)l.turnover_3yr_in;
			self.PeopleMovedIn.Four 	:= (string)l.turnover_4yr_in;
			self.PeopleMovedIn.Five 	:= (string)l.turnover_5yr_in;
			
			self.PeopleMovedOut.Current := '';
			self.PeopleMovedOut.Last 	:= (string)l.turnover_1yr_out;
			self.PeopleMovedOut.Two 	:= (string)l.turnover_2yr_out;
			self.PeopleMovedOut.Three := (string)l.turnover_3yr_out;
			self.PeopleMovedOut.Four 	:= (string)l.turnover_4yr_out;
			self.PeopleMovedOut.Five 	:= (string)l.turnover_5yr_out;
			
			self.Crimes.Current 			:= (string)l.crimes;
			self.Crimes.Last 					:= (string)l.crimes_1yr;
			self.Crimes.Two 					:= (string)l.crimes_2yr;
			self.Crimes.Three 				:= (string)l.crimes_3yr;
			self.Crimes.Four 					:= (string)l.crimes_4yr;
			self.Crimes.Five 					:= (string)l.crimes_5yr;
			
			self.Foreclosures.Current := (string)l.foreclosures;
			self.Foreclosures.Last 		:= (string)l.foreclosures_1yr;
			self.Foreclosures.Two 		:= (string)l.foreclosures_2yr;
			self.Foreclosures.Three 	:= (string)l.foreclosures_3yr;
			self.Foreclosures.Four 		:= (string)l.foreclosures_4yr;
			self.Foreclosures.Five 		:= (string)l.foreclosures_5yr;
			
			self.SexOffenders.Current := (string)l.sexoffenders;
			self.SexOffenders.Last 		:= (string)l.sexoffenders_1yr;
			self.SexOffenders.Two 		:= (string)l.sexoffenders_2yr;
			self.SexOffenders.Three 	:= (string)l.sexoffenders_3yr;
			self.SexOffenders.Four 		:= (string)l.sexoffenders_4yr;
			self.SexOffenders.Five 		:= (string)l.sexoffenders_5yr;
			
			self.Indices.Crime 				:= (string)l.Crime_Index;
			self.Indices.Poverty 			:= (string)l.Poverty_Index;
			self.Indices.Foreclosure 	:= (string)l.Foreclosure_Index;
			self.Indices.Disruption		:= (string)l.Disruption_Index;
			self.Indices.Mobility			:= (string)l.Mobility_Index;
			self.Indices.Risk					:= (string)l.Risk_Index;
			
			self.MilesToTargetProperty := (string)l.miles;
			self :=[];
		End;

		Input2 := project(Input, toESDL(left));

		d := dataset([{0}], {integer i});

		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d l):=transform
			self.RecordCount := Count(Input2);
			self.Records := sort(Input2, MilesToTargetProperty);
			self := [];
		End;

		Final := project(d, finalform(left));			

		Return Final;
	End;		
	export formatAR_IESP_out_1(dataset(layouts.AddrRisk_Scored) Scored) :=Function  //Risk Score only
		iesp.addressrisksearch.t_AddrRiskSearchRecord toESDL(scored l):=transform
			self.GeoLink 								:= (string)l.GeoLink;
			self.GeoLocation.Latitude 	:= (string)l.Latitude;
			self.GeoLocation.Longitude 	:= (string)l.Longitude;
			self.Indices.Risk						:= (string)l.Risk_Index;
			self.MilesToTargetProperty 	:= (string)l.miles;
			self :=[];
		End;

		Scored2 := project(scored, toESDL(left));

		d := dataset([{0}], {integer i});

		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d le):=transform
			self.RecordCount := Count(Scored2);
			self.Records := sort(Scored2, MilesToTargetProperty);
			self := [];
		End;

		Final := project(d, finalform(left));			

		Return Final;
	End;




	export formatAR_IESP_out_2(dataset(Address_Attributes.Layouts.AR_SexOffender) input) :=Function  //Sex Offenders
		iesp.addressrisksearch.t_SexOffenderRecord toSO_ESDL(input l):=transform
			self.UniqueID 										 := (string)l.did;
			self.Name.First                    := (string)l.fname;
			self.Name.Middle                   := (string)l.mname;
			self.Name.Last                     := (string)l.lname;
			self.DOB.Year                      := (string)l.DOB[1..4];
			self.DOB.Month                     := (string)l.DOB[5..6];
			self.DOB.Day                       := (string)l.DOB[7..8];
			self.Address.StreetNumber          := (string)l.prim_range;
			self.Address.StreetPreDirection    := (string)l.predir;
			self.Address.StreetName            := (string)l.prim_name;
			self.Address.StreetSuffix          := (string)l.addr_suffix;
			self.Address.StreetPostDirection   := (string)l.postdir;
			self.Address.UnitNumber            := (string)l.sec_range;
			self.Address.City                  := (string)l.p_city_name;
			self.Address.State                 := (string)l.St;
			self.Address.Zip5                  := (string)l.zip5;
			self.Address.Zip4                  := (string)l.zip4;
			self.Latitude 										 := (string)l.geo_lat;
			self.Longitude  									 := (string)l.geo_long;
			self :=[];
		End;

		sex_offenders := project(input, toSO_ESDL(left));

		d1 := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchRecord formSearchRecord(d1 l):=transform
			self.SexOffenderRecords  := sex_offenders;
			self := [];
		End;
		SearchRecords := project(d1, formSearchRecord(left));	

		d2 := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d2 l):=transform
			self.RecordCount := Count(sex_offenders);
			self.Records := SearchRecords;
			self := [];
		End;

		Final := project(d2, finalform(left));			

		Return Final;
	End;



	export formatAR_IESP_out_3(dataset(Address_Attributes.Layouts.AR_PublicSafety) Input) :=Function  //Public Safety
		iesp.addressrisksearch.t_PublicSafetyRecord  toPS_ESDL(input l):=transform
			self.bdid 										 		 := (string)l.BDID;
			self.CompanyName    					 		 := (string)l.name;
			self.Phone10	                     := (string)l.phone10;
			self.Address.StreetNumber          := (string)l.prim_range;
			self.Address.StreetPreDirection    := (string)l.predir;
			self.Address.StreetName            := (string)l.prim_name;
			self.Address.StreetSuffix          := (string)l.addr_suffix;
			self.Address.StreetPostDirection   := (string)l.postdir;
			self.Address.UnitNumber            := (string)l.sec_range;
			self.Address.City                  := (string)l.p_city_name;
			self.Address.State                 := (string)l.St;
			self.Address.Zip5                  := (string)l.zip;
			self.Address.Zip4                  := (string)l.zip4;
			self.Latitude 										 := (string)l.geo_lat;
			self.Longitude  									 := (string)l.geo_long;
			self :=[];
		End;

		PublicSafety := project(input, toPS_ESDL(left));

		d1 := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchRecord formSearchRecord(d1 l):=transform
			self.PublicSafetyRecords   := PublicSafety;
			self := [];
		End;
		SearchRecords := project(d1, formSearchRecord(left));	

		d2 := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d2 l):=transform
			self.RecordCount := Count(PublicSafety);
			self.Records := SearchRecords;
			self := [];
		End;

		Final := project(d2, finalform(left));			

		Return Final;
	End;



	export formatAR_IESP_out_4(dataset(layouts.AddrRisk_Scored) Input) :=Function //Risk score with details
		iesp.addressrisksearch.t_AddrRiskSearchRecord toESDL(Input l):=transform
			self.GeoLink 								:= l.GeoLink;
			self.GeoLocation.Latitude 	:= (string)l.Latitude;
			self.GeoLocation.Longitude 	:= (string)l.Longitude;
			
			self.Occupants.Current 		:= (string)l.occupants;
			self.Occupants.Last 			:= (string)l.occupants_1yr;
			self.Occupants.Two 				:= (string)l.occupants_2yr;
			self.Occupants.Three 			:= (string)l.occupants_3yr;
			self.Occupants.Four 			:= (string)l.occupants_4yr;
			self.Occupants.Five 			:= (string)l.occupants_5yr;
			
			self.PeopleMovedIn.Current := '';
			self.PeopleMovedIn.Last 	:= (string)l.turnover_1yr_in;
			self.PeopleMovedIn.Two 		:= (string)l.turnover_2yr_in;
			self.PeopleMovedIn.Three 	:= (string)l.turnover_3yr_in;
			self.PeopleMovedIn.Four 	:= (string)l.turnover_4yr_in;
			self.PeopleMovedIn.Five 	:= (string)l.turnover_5yr_in;
			
			self.PeopleMovedOut.Current := '';
			self.PeopleMovedOut.Last 	:= (string)l.turnover_1yr_out;
			self.PeopleMovedOut.Two 	:= (string)l.turnover_2yr_out;
			self.PeopleMovedOut.Three := (string)l.turnover_3yr_out;
			self.PeopleMovedOut.Four 	:= (string)l.turnover_4yr_out;
			self.PeopleMovedOut.Five 	:= (string)l.turnover_5yr_out;
			
			self.Crimes.Current 			:= (string)l.crimes;
			self.Crimes.Last 					:= (string)l.crimes_1yr;
			self.Crimes.Two 					:= (string)l.crimes_2yr;
			self.Crimes.Three 				:= (string)l.crimes_3yr;
			self.Crimes.Four 					:= (string)l.crimes_4yr;
			self.Crimes.Five 					:= (string)l.crimes_5yr;
			
			self.Foreclosures.Current := (string)l.foreclosures;
			self.Foreclosures.Last 		:= (string)l.foreclosures_1yr;
			self.Foreclosures.Two 		:= (string)l.foreclosures_2yr;
			self.Foreclosures.Three 	:= (string)l.foreclosures_3yr;
			self.Foreclosures.Four 		:= (string)l.foreclosures_4yr;
			self.Foreclosures.Five 		:= (string)l.foreclosures_5yr;
			
			self.SexOffenders.Current := (string)l.sexoffenders;
			self.SexOffenders.Last 		:= (string)l.sexoffenders_1yr;
			self.SexOffenders.Two 		:= (string)l.sexoffenders_2yr;
			self.SexOffenders.Three 	:= (string)l.sexoffenders_3yr;
			self.SexOffenders.Four 		:= (string)l.sexoffenders_4yr;
			self.SexOffenders.Five 		:= (string)l.sexoffenders_5yr;
			
			self.Indices.Crime 				:= (string)l.Crime_Index;
			self.Indices.Poverty 			:= (string)l.Poverty_Index;
			self.Indices.Foreclosure 	:= (string)l.Foreclosure_Index;
			self.Indices.Disruption		:= (string)l.Disruption_Index;
			self.Indices.Mobility			:= (string)l.Mobility_Index;
			self.Indices.Risk					:= (string)l.Risk_Index;
			
			self.MilesToTargetProperty := (string)l.miles;
			self :=[];
		End;

		Input2 := project(Input, toESDL(left));

		d := dataset([{0}], {integer i});

		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d l):=transform
			self.RecordCount := Count(Input2);
			self.Records := sort(Input2, MilesToTargetProperty);
			self := [];
		End;

		Final := project(d, finalform(left));			

		Return Final;
	End;
//
End;

