import address_attributes, addrfraud, ADVO, dx_header, ln_propertyv2, riskwise, ut;

export functions := MODULE
	//shared
	shared boolean isCurrent( unsigned4 dt_last_seen ) := ut.DaysApart( (string8)dt_last_seen, address_attributes.Constants.todayStr ) < 180;
	
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

	export AddrToDID( dataset(dx_header.layout_header) head, boolean ByGeoBlk = true ) := FUNCTION
		dist := distribute( head, hash32( st, county, geo_blk ) );
		
		dx_header.layout_header slimdown( dist le ) := TRANSFORM
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
		dx_header.layout_header dateRoll( dx_header.layout_header le, dx_header.layout_header ri ) := TRANSFORM
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
	
	export AddrToDIDInfutor( dataset(Address_Attributes.Layouts.Infutor_geolink) head, boolean ByGeoBlk = true ) := FUNCTION
		dist := distribute( head, hash32( st, fips_county, geo_blk ) );
		
		Address_Attributes.Layouts.Infutor_geolink slimdown( dist le ) := TRANSFORM
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
		Address_Attributes.Layouts.Infutor_geolink dateRoll( Address_Attributes.Layouts.Infutor_geolink le, Address_Attributes.Layouts.Infutor_geolink ri ) := TRANSFORM
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

//Get Nearby Geolinks - inGeolink is the target, geolinks is the number up to 50 to return
	EXPORT getGeolinks(string12 inGeolink, integer nearby_geolinks) := Function
		target_geolink := dataset([{inGeolink}], Address_Attributes.Layouts.rGeolink);
		
		File_Geolinks	:= Addrfraud.key_geolinkdistance_geolink;		
		
		Address_Attributes.Layouts.rGeolink findGeolinks(target_geolink l , File_Geolinks r) := TRANSFORM
			self.geolink := r.geolink2;
		END;
		
		geolinks_found := join(target_geolink, File_Geolinks,
											keyed(left.geolink = right.geolink1),
											findGeolinks(left, right), Left Outer, keep(nearby_geolinks));		
		
		return if(nearby_geolinks = 0, target_geolink, target_geolink + geolinks_found);
	End;

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
		f := Address_Attributes.file_geolink_info();

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


//Foreclosure Function -Identify the foreclosure stage by deed category
	EXPORT getForeclosureStage(string input_Deed_Category) := MAP(
									input_Deed_Category IN ['S','G','T','R'] 	=> '4', //sold or auctioned, and lis pendens released
									input_Deed_Category IN ['U'] 							=> '3', //Foreclosure
									input_Deed_Category IN ['Q','F'] 					=> '2', //quit claim, or legal affirmation of deficiency
									input_Deed_Category IN ['L','N'] 					=> '1', //notice of default or lis pendens filed
									'0');					

//Identify all single family dwellings by land use code
	EXPORT getSFD(string input_Land_Use) := (input_Land_Use IN ['SFR','100','109','135','136','137','138','160','163','264','454','460','465','500','999','1000','1001','1006','1007','1008','1012','1015','1016','1109','1999','8000','8001','9300','9301']);

//Identify all multifamily dwellings by land use code
	EXPORT getDwelling_Type(string input_Land_Use) := (input_Land_Use IN ['102','103','106','112','113','114','115','161','117','118','132','133','134','151','165','245','450','452','1002','1003','1004','1005','1010','1100','1101','1102','1103','1104','1106','1107','1108','1110','1111','1112','1113','8007']);

	EXPORT filterVehicle := 
									['323','626','**','1D','2WH','2WHE','2WHL','2C','2-D','2D\'','2D','2D*','2DHT',
									'2DOOR','2DR','2DS','2F','2H','2HBK','2N','2P','2S','2T','2T*','2U','2W','2WD',
									'2WH','2-WHL','2WHL','2X','2X4','3DRH','3HBK','3P','4X2','ACCEN','ACCLA','ACCOR',
									'ALERO','AVENG','BERET','BREEZ','CAMAR','CELIC','CENTU','CIERA','CIRRU','CIVIC',
									'CN','CON','COROL','CORVE','COUP','COUPE','CP','CPE','CUTLA','CV','ECLIP','ESCOR',
									'FIRE','FIREB','FOCUS','HATC','HATCH','HB','HBACK','HTCH','HTCHB','HTP','INTEG',
									'INTRE','INTRI','KIT','METRO','MIATA','MUSTA','MX6','MYSTI','NEON','PRELU','PROBE',
									'PROTE','RC','RD','RDR','RDSTR','ROADS','SEBRI','SENTR','SEPHI','SHADO','SKYLA',
									'SPIRI','STRAT','SUNBI','SUNFI','TBIRD','TEMPO','TERCE','THUND','TRANS','TUDOR',
									'3 DOO','3 DOR','3 DR','3-D','3D','3DOOR','3DOR','3-DR','3DR','3DR M','3H','3L',
									'4','1DSDN','2DSDN','2SWGN','300M','3DSDN','3SWGN','4DR','4B','4-D','4D-','4D',
									'4D*','4DHT','4DOOR','4DR','4DS','4DSDN','4H','4HBK','4L','4P','4S','4SWGN','4T',
									'4W','5DR','5D','5DOOR','5DR','5HBK','ALTIM','AUROR','AUT','AVALO','CAMRY','CAPRI',
									'CAR','CONCO','CONTI','CONTO','CORSI','COUGA','CROWN','DEVIL','DYNAS','ELANT',
									'ELDOR','FODOR','GALAN','GRAN','HMDE','HARDT','HMDE','I30','IMPAL','JETTA','LB',
									'LEBAR','LEGAC','LEGEN','LESAB','LIFT','LIFTB','LTD','LUMIN','MALIB','MARK','MAXIM',
									'MFGH','MFGHM','MFHGM','MIRAG','MONTE','OTHRP','PARK','PASS','PASSE','PC','PRIZM',
									'QUEST','REGAL','SABLE','SD','SDDEL','SE','SED','SEDAN','SEVIL','STAW','STAW','STW',
									'SW','TALON','TAURU','TG','TO','TOPAZ','TOWN','TOWNC','TRACE','TX','WAG','WAGON',
									'WGN','3 WHL','3W','3WHL','4WHLR','AT','ATV','BG','DB','DBG','DUNE','DUNEB','GC','TRIT',
									'BS','BU','BUS','EBUS','MWKSH','SB','SCH B','SCHL','CLUB','CLUBC','CREW','CREWC',
									'EXCAB','EXT','EXTC','EXTC','EXTCA','QUAD','SCAB','SUPC','SUPCA','SUPER','XCAB',
									'DS','SEMI','TR','TRAC','TRACT','TTRAC','2SCTR','3SCTR','AM','AMB','AMBUL','CYCLE',
									'MB','MC','MO','MP','MS','SIDE','SOLO','SOLOD','1500','2500','1 TON','1/2 T','1TON',
									'2 TON','2 WD','2TON','3/4 T','3K ','BR150','C15','C15 F','C1500','CK150','CW','DAKOT',
									'EL CA','ELCAM','EXPL','F150','F250','F350','FLTSD','FSERI','K1500','LARED','P/U',
									'PIC**','PICK','PICKU','PK','PKUP','PM','PS','RAM','RAM 1','RAM15','RAMCH','RCAB',
									'REG','REG C','REGCA','S10','S10 B','S15','SIERR','SILVE','SONOM','TACOM','TWO W',
									'XLT','HC','HV','MH','MHM','MK','MM','MOTOR','MR','MRCH','MRTHM','MTHM','MTHRM',
									'MTRH','MTRH','MTRHM','MTRHO','RA','RS','RT','RV','4 RUN','4RUNN','APV','BLAZ',
									'BLAZE','BLZR','BRAVA','BRON','BRONC','CHERO','CJ5','CJ7','CRV','DURAN','EXPED',
									'EXPLO','JIMMY','LL','MPV','NAVIG','PATHF','RANCH','RANGE','RODEO','SAFAR','SCOUT',
									'SPORT','SPT U','SPTU','SPUTI','SUB','SUBN','SUBP','SUBR','SUBT','SUBU','SUBUR',
									'SURB','SUV','TAHOE','TRACK','TROOP','UTLP','UTLT','WRANG','YUKON','6 WHL','6W',
									'6WHL','8 WHL','CHCAB','FT','OTHRT','PN','PNL','TK','TRG','TRK','TRUC','TRUCK','DT',
									'DUMP','GARBP','GG','GLASR','HE','HEARS','HR','HRS','HRSE','TOW','TOWT','TT','WK',
									'WKR','WRECK','6D','8V','AEROS','ASPIR','ASTRO','CARAV','CARGO','CARLT','CG','CGOV',
									'COA','COH','CONV','CONVE','CONVT','CY','ECONO','GRAND','LIM','LIMO','LM','MVAN',
									'MINI','MINIV','MV','MVAN','PANEL','SAVAN','SN','SV','VAN','VANG','VANDU','VANH',
									'VANI','VANP','VANR','VANT','VC','VENTU','VILLA','VN','VOYAG','VT','WINDS','XV',
									'4 WD','4 WH','4 WHE','4 WHL','4 X 4','4-W','4W\'','4W*','4WD','4WH','4WHEE','4-WHL',
									'4WHL','4X4','JEEP','JEEPT','JEP','JP'];
									
	EXPORT getBodyType(string input_Body_Type_Code) := MAP(
									input_Body_Type_Code IN ['323','626','**','1D','2WH','2WHE','2WHL','2C','2-D','2D\'','2D','2D*','2DHT','2DOOR','2DR','2DS','2F','2H','2HBK','2N','2P','2S','2T','2T*','2U','2W','2WD','2WH','2-WHL','2WHL','2X','2X4','3DRH','3HBK','3P','4X2','ACCEN','ACCLA','ACCOR','ALERO','AVENG','BERET','BREEZ','CAMAR','CELIC','CENTU','CIERA','CIRRU','CIVIC','CN','CON','COROL','CORVE','COUP','COUPE','CP','CPE','CUTLA','CV','ECLIP','ESCOR','FIRE','FIREB','FOCUS','HATC','HATCH','HB','HBACK','HTCH','HTCHB','HTP','INTEG','INTRE','INTRI','KIT','METRO','MIATA','MUSTA','MX6','MYSTI','NEON','PRELU','PROBE','PROTE','RC','RD','RDR','RDSTR','ROADS','SEBRI','SENTR','SEPHI','SHADO','SKYLA','SPIRI','STRAT','SUNBI','SUNFI','TBIRD','TEMPO','TERCE','THUND','TRANS','TUDOR'] => '2', //Two door
									input_Body_Type_Code IN ['3 DOO','3 DOR','3 DR','3-D','3D','3DOOR','3DOR','3-DR','3DR','3DR M','3H','3L'] => '3', //Three Door
									input_Body_Type_Code IN ['4','1DSDN','2DSDN','2SWGN','300M','3DSDN','3SWGN','4DR','4B','4-D','4D-','4D','4D*','4DHT','4DOOR','4DR','4DS','4DSDN','4H','4HBK','4L','4P','4S','4SWGN','4T','4W','5DR','5D','5DOOR','5DR','5HBK','ALTIM','AUROR','AUT','AVALO','CAMRY','CAPRI','CAR','CONCO','CONTI','CONTO','CORSI','COUGA','CROWN','DEVIL','DYNAS','ELANT','ELDOR','FODOR','GALAN','GRAN','HMDE','HARDT','HMDE','I30','IMPAL','JETTA','LB','LEBAR','LEGAC','LEGEN','LESAB','LIFT','LIFTB','LTD','LUMIN','MALIB','MARK','MAXIM','MFGH','MFGHM','MFHGM','MIRAG','MONTE','OTHRP','PARK','PASS','PASSE','PC','PRIZM','QUEST','REGAL','SABLE','SD','SDDEL','SE','SED','SEDAN','SEVIL','STAW','STAW','STW','SW','TALON','TAURU','TG','TO','TOPAZ','TOWN','TOWNC','TRACE','TX','WAG','WAGON','WGN'] => '4', //
									input_Body_Type_Code IN ['3 WHL','3W','3WHL','4WHLR','AT','ATV','BG','DB','DBG','DUNE','DUNEB','GC','TRIT'] => 'A', //ATV
									input_Body_Type_Code IN ['BS','BU','BUS','EBUS','MWKSH','SB','SCH B','SCHL'] => 'B', //Bus
									input_Body_Type_Code IN ['CLUB','CLUBC','CREW','CREWC','EXCAB','EXT','EXTC','EXTC','EXTCA','QUAD','SCAB','SUPC','SUPCA','SUPER','XCAB'] => 'C', //Extended Cab truck
									input_Body_Type_Code IN ['DS','SEMI','TR','TRAC','TRACT','TTRAC'] => 'H', //Heavy Duty
									input_Body_Type_Code IN ['2SCTR','3SCTR','AM','AMB','AMBUL','CYCLE','MB','MC','MO','MP','MS','SIDE','SOLO','SOLOD'] => 'M', //Motorcycle
									input_Body_Type_Code IN ['1500','2500','1 TON','1/2 T','1TON','2 TON','2 WD','2TON','3/4 T','3K ','BR150','C15','C15 F','C1500','CK150','CW','DAKOT','EL CA','ELCAM','EXPL','F150','F250','F350','FLTSD','FSERI','K1500','LARED','P/U','PIC**','PICK','PICKU','PK','PKUP','PM','PS','RAM','RAM 1','RAM15','RAMCH','RCAB','REG','REG C','REGCA','S10','S10 B','S15','SIERR','SILVE','SONOM','TACOM','TWO W','XLT'] => 'P', //Pickup
									input_Body_Type_Code IN ['HC','HV','MH','MHM','MK','MM','MOTOR','MR','MRCH','MRTHM','MTHM','MTHRM','MTRH','MTRH','MTRHM','MTRHO','RA','RS','RT','RV'] => 'R', //RV
									input_Body_Type_Code IN ['4 RUN','4RUNN','APV','BLAZ','BLAZE','BLZR','BRAVA','BRON','BRONC','CHERO','CJ5','CJ7','CRV','DURAN','EXPED','EXPLO','JIMMY','LL','MPV','NAVIG','PATHF','RANCH','RANGE','RODEO','SAFAR','SCOUT','SPORT','SPT U','SPTU','SPUTI','SUB','SUBN','SUBP','SUBR','SUBT','SUBU','SUBUR','SURB','SUV','TAHOE','TRACK','TROOP','UTLP','UTLT','WRANG','YUKON'] => 'S', //SUV
									input_Body_Type_Code IN ['6 WHL','6W','6WHL','8 WHL','CHCAB','FT','OTHRT','PN','PNL','TK','TRG','TRK','TRUC','TRUCK'] => 'T', //Truck
									input_Body_Type_Code IN ['DT','DUMP','GARBP','GG','GLASR','HE','HEARS','HR','HRS','HRSE','TOW','TOWT','TT','WK','WKR','WRECK'] => 'U', //Utility
									input_Body_Type_Code IN ['6D','8V','AEROS','ASPIR','ASTRO','CARAV','CARGO','CARLT','CG','CGOV','COA','COH','CONV','CONVE','CONVT','CY','ECONO','GRAND','LIM','LIMO','LM','MVAN','MINI','MINIV','MV','MVAN','PANEL','SAVAN','SN','SV','VAN','VANG','VANDU','VANH','VANI','VANP','VANR','VANT','VC','VENTU','VILLA','VN','VOYAG','VT','WINDS','XV'] => 'V', //Van
									input_Body_Type_Code IN ['4 WD','4 WH','4 WHE','4 WHL','4 X 4','4-W','4W\'','4W*','4WD','4WH','4WHEE','4-WHL','4WHL','4X4','JEEP','JEEPT','JEP','JP'] => 'X', //4x4
									'0');

	EXPORT getFuelType(string input_State, string input_Fuel_Type_Code) := MAP(
									input_Fuel_Type_Code IN ['F'] and input_State ='NE'	=> 'X', //Flexible
									input_Fuel_Type_Code IN ['1'] and input_State ='TX'	=> 'D', //Diesel
									input_Fuel_Type_Code IN ['A'] 											=> 'A', //Alcohol
									input_Fuel_Type_Code IN ['2','D','Y'] 							=> 'D', //Diesel
									input_Fuel_Type_Code IN ['5','E'] 									=> 'E', //Electric
									input_Fuel_Type_Code IN ['H'] 											=> 'H', //Ethanol
									input_Fuel_Type_Code IN ['0','1','F','G'] 					=> 'G', //Gas
									input_Fuel_Type_Code IN ['3','6','C','L','N','P'] 	=> 'N', //Natural Gas
									input_Fuel_Type_Code IN ['O'] 											=> 'O', //Other
									input_Fuel_Type_Code IN ['4'] 											=> 'S', //Solar
									'0');

	EXPORT getSiteInfluence(string site_influence) := MAP(
								site_influence IN ['W','B','Z'] 		=> 'A',   //These value represent a property being near a body of water (lake, river, stream, ocean.)
								site_influence IN ['L','O','N','U']	=> 'V',   //These values represent being able to view a body of water
								'N');	
	
	EXPORT walkablityCodes := [4100,4110,4111,4119,4120,4121,4130,4131,4140,4141,4142,4150,4151,4170,4173,5140,5141,
																	5145,5146,5147,5148,5149,5400,5410,5411,5420,5421,5430,5431,5440,5441,5450,5451,5460,
																	5461,5490,5499,5920,5921,5800,5810,5812,5813,7200,7210,7211,7212,7213,7215,7216,7217,
																	7218,7219,7230,7231,7240,7241,5910,5912,8000,8010,8011,8020,8021,8030,8031,8040,8041,
																	8042,8043,8049,8050,8051,8052,8059,8060,8062,8063,5090,5091,5092,5112,5113,5120,5122,
																	5130,5131,5136,5137,5139,5250,5251,5260,5261,5300,5310,5311,5330,5331,5390,5399,5530,
																	5531,5600,5610,5611,5620,5621,5630,5632,5640,5641,5650,5651,5660,5661,5690,5699,5700,
																	5710,5712,5713,5714,5719,5720,5722,5730,5731,5734,5735,5736,5900,5930,5932,5940,5941,
																	5942,5943,5944,5945,5946,5947,5948,5949,5992,5993,5994,5995,8660,8661,7800,7810,7812,
																	7819,7820,7822,7829,7830,7832,7833,7840,7841,7900,7910,7911,7920,7922,7929,7930,7933,
																	7940,7941,7948,7990,7991,7992,7993,7996,7997,7999,8400,8410,8412,8420,8422,8200,8210,
																	8211,8220,8221,8222,8230,8231,8240,8243,8244,8249,8290,8299,6020,6021,6022,6029,6030,
																	6035,6036,6060,6061,6062,8350,8351,8360,8361,8320,8322,5500,7250,7251,7530,7532,7533,
																	7534,7536,7537,7600,7620,7622,7623,7629,7630,7631,7640,7641,7690,7692,7694,7699,4300,
																	4310,4311,9100,9110,9111,9120,9121,9130,9131,9190,9199,9200,9210,9211,9220,9221,9222,
																	9223,9224,9229];

	EXPORT getWalkabilitySIC(integer SIC) := MAP(
	/*public transportation*/	SIC IN [4100,4110,4111,4119,4120,4121,4130,4131,4140,4141,4142,4150,4151,4170,4173]	=> 'PT',  
	/*grocery food*/					SIC IN [5140,5141,5145,5146,5147,5148,5149,5400,5410,5411,5420,5421,5430,5431,5440,5441,5450,5451,5460,5461,5490,5499,5920,5921]	=> 'GF',  
	/*restaurant food*/				SIC IN [5800,5810,5812,5813]	=> 'RF',  
	/*personal care*/					SIC IN [7200,7210,7211,7212,7213,7215,7216,7217,7218,7219,7230,7231,7240,7241]	=> 'PC',  
	/*drugs pharmacy*/				SIC IN [5910,5912]	=> 'DR',  
	/*medical care*/					SIC IN [8000,8010,8011,8020,8021,8030,8031,8040,8041,8042,8043,8049,8050,8051,8052,8059,8060,8062,8063]	=> 'MD',  
	/*retail goods*/					SIC IN [5090,5091,5092,5112,5113,5120,5122,5130,5131,5136,5137,5139,5250,5251,5260,5261,5300,5310,5311,5330,5331,5390,5399,5530,5531,5600,5610,5611,5620,5621,5630,5632,5640,5641,5650,5651,5660,5661,5690,5699,5700,5710,5712,5713,5714,5719,5720,5722,5730,5731,5734,5735,5736,5900,5930,5932,5940,5941,5942,5943,5944,5945,5946,5947,5948,5949,5992,5993,5994,5995]	=> 'RG',  
	/*church*/								SIC IN [8660,8661]	=> 'CH',  
	/*entertainment*/					SIC IN [7800,7810,7812,7819,7820,7822,7829,7830,7832,7833,7840,7841,7900,7910,7911,7920,7922,7929,7930,7933,7940,7941,7948,7990,7991,7992,7993,7996,7997,7999,8400,8410,8412,8420,8422]	=> 'EN',  
	/*schools*/								SIC IN [8200,8210,8211,8220,8221,8222,8230,8231,8240,8243,8244,8249,8290,8299]	=> 'SC',  
	/*banking*/								SIC IN [6020,6021,6022,6029,6030,6035,6036,6060,6061,6062]	=> 'BK',  
  /*daycare*/								SIC IN [8350,8351,8360,8361,8320,8322]	=> 'DC', 
	/*repair shops*/					SIC IN [5500,7250,7251,7530,7532,7533,7534,7536,7537,7600,7620,7622,7623,7629,7630,7631,7640,7641,7690,7692,7694,7699]	=> 'RE',  
	/*public service*/				SIC IN [4300,4310,4311,9100,9110,9111,9120,9121,9130,9131,9190,9199,9200,9210,9211,9220,9221,9222,9223,9224,9229]	=> 'PS',  
														'NA');

	EXPORT getWalkabilityLandUse(integer LandUse) := MAP(
	/*public transportation*/	//SIC IN []	=> 'PT',  
	/*grocery food*/					LandUse IN [257,283,284,2006,2017,2018,2019,2020,2021,2022]	=> 'GF',  
	/*restaurant food*/				LandUse IN [221,242,243,261,285,2012,2013,2014,2015,2016,2048]	=> 'RF',  
	/*personal care*/					LandUse IN [240,2026,2047]	=> 'PC',  
	/*drugs pharmacy*/				LandUse IN [2053]	=> 'DR',  
	/*medical care*/					LandUse IN [235,237,238,2011,3005,3006,9104,9105,9214,9219]	=> 'MD',  
	/*retail goods*/					LandUse IN [217,220,266,268,269,270,273,276,278,279,281,282,2001,2002,2003,2004,2005,2007,2008,2009,2010,2028,2029,2041,2045,2050,2051]	=> 'RG',  
	/*church*/								LandUse IN [671,675,9101]	=> 'CH',  
	/*entertainment*/					LandUse IN [620,690,699,700,701,703,706,709,712,721,24,725,727,728,733,742,745,750,754,755,757,766,769,770,775,780,784,787,790,795,796,797,798,799,2038,2039,4000,4001,4002,4003,4004,4005,4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022,4023,4024,4025,4026,4027,4028,4029,4030,4031]	=> 'EN',  
	/*schools*/								LandUse IN [650,652,654,655,656,660,664,665,670,680,9102,9103,9203,9204]	=> 'SC',  
	/*banking*/								LandUse IN [222,3007]	=> 'BK',  
  /*daycare*/								LandUse IN [2032]	=> 'DC', 
	/*repair shops*/					LandUse IN [204,2024,2027]	=> 'RE',  
	/*public service*/				LandUse IN [605,606,609,602,603,604,610,9205,9207,9208,9215]	=> 'PS',  
														'NA');		
	EXPORT landUseGovt := ['602','603','604','605','606','607','609','610','611','614','615','630','640','641','650','652','654','655','656','660','664','665','670',
												 '680','8005','8006','9200','9201','9202','9203','9204','9205','9206','9207','9208','9209','9210','9211','9212','9213','9214',
												 '9215','9216','9217','9218','9219','9308'];
												 
	EXPORT sicGovt := ['4300','4310','4311','9100','9110','9111','9120','9121','9130','9131','9190','9199','9200','9210','9211','9220','9221','9222','9223','9224',
										 '9229','9300','9310','9311','9400','9410','9411','9430','9431','9440','9441','9450','9451','9500','9510','9511','9512','9530','9531','9532',
										 '9600','9610','9611','9620','9621','9630','9631','9640','9641','9650','9651','9660','9661','9700','9710','9711','9720','9721','9900','9990','9999'];

	EXPORT getFBISafetyScore(integer murder, integer rape, integer robbery, integer assault, integer burglary, integer theft, integer auto_theft, integer arson) := function
	//based on coefficients per 100,000 people where statistics are given (usually MSAs)
		FBIScore := (murder * 2.387439) + (rape * .742623) + (robbery * .274218) + (assault * .191583) + (burglary * .087779) + (theft * .033585) + (auto_theft * .093856) + (arson * .045073);
		RETURN FBIScore;
	end;

	EXPORT Dwell_Density ( dataset(Address_Attributes.Layouts.layout_dwell_addr_in) Address_in ) := FUNCTION
		// in_data := dataset([{'102','','ARBOR','ST','','','','SAINT CLOUD','MN','56301'}], layout_in);
		//Set up property key
		isFCRA := false;
		rolled_props := ln_propertyv2.File_Prop_Address_Prep_V4(isFCRA);
		
		//Append ADVO SFD/MFD/Vacancy Status
		Address_Attributes.Layouts.layout_dwell_working getADVO(Address_in l, Advo.Key_Addr1 r) := transform
			self.DwellType 		:= r.Address_Type;
			self.Vacant 			:= r.Address_Vacancy_Indicator;
			self := l;
			self := [];
		end;

		ADVOAppend := join(Address_in, Advo.Key_Addr1, 
			keyed (left.zip=right.zip) 								and 
			keyed (left.prim_range=right.prim_range) 	and 
			keyed (left.prim_name=right.prim_name) 	and 
			keyed (left.suffix=right.addr_suffix)		and
			keyed (left.predir=right.predir)		and
			keyed (left.postdir=right.postdir)		and
			keyed (left.sec_range=right.sec_range),
			getADVO(left, right), Left Outer, keep(1));

		// Append the ADL and SSN counts to the table- lookup by address key
		hdr_addr := join(Address_in, dx_header.key_header_address(), 
				keyed(left.prim_name=right.prim_name) and
				keyed(left.zip=right.zip) and keyed(right.prim_range=left.prim_range) and
				left.predir=right.predir and left.postdir=right.postdir and
				left.sec_range=right.sec_range and
				right.dt_last_seen[1..4] = ut.GetDate[1..4] and
				right.ssn <> '',
				transform(RIGHT), atmost(riskwise.max_atmost), keep(100));

		hdr_addr_ssn := dedup(sort(hdr_addr, ssn), ssn); 

		Address_Attributes.Layouts.layout_withOccupants initializeAddr(hdr_addr_ssn l) := TRANSFORM
			self.occupants := if( isCurrent( l.dt_last_seen ), 1, 0 );
			self := l;
			self := [];
		END;

		addr := project(hdr_addr_ssn, initializeAddr(left));

		Address_Attributes.Layouts.layout_withOccupants rollOccupants(Address_Attributes.Layouts.layout_withOccupants l, Address_Attributes.Layouts.layout_withOccupants r) := TRANSFORM
			self.occupants     := l.occupants + r.occupants;
			self.dt_first_seen := min(l.dt_first_seen, r.dt_first_seen);
			self.dt_last_seen  := max(l.dt_last_seen,  r.dt_last_seen);
			self := l;
		END;

		sortaddr := sort( addr, zip, prim_range, prim_name, suffix, unit_desig, sec_range);
		withOccupants := rollup( sortaddr,
						left.zip        = right.zip
				and left.prim_range = right.prim_range
				and left.prim_name  = right.prim_name
				and left.suffix     = right.suffix
				and left.unit_desig = right.unit_desig
				and left.sec_range  = right.sec_range,
			rollOccupants(left,right));

		Address_Attributes.Layouts.layout_dwell_working addDwellDensity(ADVOAppend l, withOccupants r) := transform
			self.occupants := r.occupants;
			self := l;
			self := [];
		end;

		withDwellingDensity := join(ADVOAppend, withOccupants,		
			  (left.prim_range=right.prim_range) and
			  (left.prim_name=right.prim_name) 	and
			  (left.sec_range=right.sec_range) 	and
			  (left.zip=right.zip),
				addDwellDensity(left, right), left outer, keep(1));

		// Append Address LN Property Data
		Address_Attributes.Layouts.layout_dwell_working getProperty(withDwellingDensity l, LN_PropertyV2.Key_Prop_Address_V4 r) := transform
			self.occupant_owned := r.occupant_owned;
			self.building_area := r.building_area;
			self.no_of_rooms := r.no_of_rooms;
			self.no_of_bedrooms := r.no_of_bedrooms;
			self.no_of_baths := r.no_of_baths;
			self.built_date := r.built_date;
			self.bld_years_old := if(r.built_date != 0, (integer)ut.getdate[1..4] - (integer)r.built_date[1..4], 0);
			self := l;
			self := [];
		end;
				
		PropertyHedonics := join(withDwellingDensity, LN_PropertyV2.Key_Prop_Address_V4,		
			 keyed (left.prim_range=right.prim_range) and
			 keyed (left.prim_name=right.prim_name) 	and
			 keyed (left.sec_range=right.sec_range) 	and
			 keyed (left.zip=right.zip),
				getProperty(left, right), left outer, keep(1));
		
		//Calculate dwelling density indicators
		Address_Attributes.Layouts.Dwelling_Density_Final CalcIndicators(PropertyHedonics l) := transform 
				//Determine is the property is a rental
				//The owner is not present, the structure is occupied, and is deliverable.
				self.possible_rental := if(~l.occupant_owned AND l.occupants > 0 AND l.vacant = 'N', 1, 0);
				
				// Crowding Index using Census 2005-2007 American Community Survey stats
				// This section could be improved by calculating the averages per zipcode or county with the AVM build
				imputed := if(l.no_of_bedrooms = 0 AND l.no_of_baths = 0 AND l.building_area = 0,TRUE,FALSE);  
				self.dd_imputed := imputed;
				
				// Crowding Index - bedrooms per person -> acceptable density = 3 people per bedroom is legal limit 1.5 is national average
				// Higher value = worse score -> 4 is unacceptable
				// If no hedonic data is available, use 4 bedrooms as divisor
				self.dd_bd := if(l.no_of_bedrooms = 0, (l.occupants / 4) , (l.occupants / ((real4)l.no_of_bedrooms)));  
				bd_calc := if(l.no_of_bedrooms = 0, 0, 1);
				
				// Crowding Index - bathrooms per person -> acceptable density = 4 people per bathroom
				// Higher value = worse score -> greater than .25 is acceptable
				// If no hedonic data is available, use 3 bathrooms as divisor
				self.dd_bt := if(l.no_of_baths = 0, (l.occupants / 3), (l.occupants / ((real4)l.no_of_baths)));  
				bt_calc := if(l.no_of_baths = 0, 0, 1);
				
				// Crowding Index - squarefoot per person -> natl ave = 246sqft / person (single family dwelling) & 166sqft / person (multi-family dwelling)
				// Lower value = worse score -> greater than 247 (SFD) or 166 (MFD) acceptable
				// National average 2200 (SFD) 900 (MFD)
				self.sf_limit := if(l.DwellType = '1', 247, 166);
				self.ave_sf := if(l.DwellType = '1', 2000, 800);
				self.dd_sf := if(l.building_area = 0, self.ave_sf / l.occupants, (((real4)l.building_area)) / l.occupants);
				sf_calc := if(l.building_area = 0, 0, 1);
				self.dd_indicator := if((self.dd_bd > 4 OR self.dd_bt > 4 OR self.dd_sf < self.sf_limit), 'S', 'N'); //S-Suspicious, N-Normal
				
				// Scale confidence score 0- Imputed, 1 Source, 2 Sources, 3 Sources (very confident)
				self.dd_confidence := if(imputed = true, 0, ((bd_calc)+ (bt_calc)+ (sf_calc)) ); 
				self := l;
		end;	

		DwellingDensity := project(PropertyHedonics, CalcIndicators(Left));
		Return DwellingDensity;
	END;


//Property Normalization - Garage Type Normalization
	EXPORT getGarageType(string input_Garage_Type) := MAP(
									input_Garage_Type IN ['1','2','3','4','5','6','430','440','650','670','690','710','716','750','770','850','880','890','910','911','912','913','971','999','00X','G','GAR','LOG','M','MXD','R','UD0','UD1','UD2','UD3','UD4','UD5','UD6','UDA','UF0','UF1','UF2','UF3','UFM','UFO','UFR','UFW','YES','Z'] 	=> '4', 
									//Undefined = 4
									input_Garage_Type IN ['10','20','60','61','62','63','64','70','80','81','82','83','84','90','110','111','112','113','114','115','116','120','121','122','130','170','190','200','210','240','250','260','270','320','340','350','360','361','362','363','370','380','390','400','420','450','451','452','453','454','460','470','510','610','640','651','652','653','654','660','670','690','720','740','780','790','800','890','900','990','A','ABK','ACR','AFF','AFN','AFR','AML','AMN','ASC','AST','AT0','AT1','AT2','AT3','AT4','ATB','AUF','AUM','AWO','B','BN0','BN1','BN2','BRF','BRK','BS0','BS2','BS3','BS4','BS5','BS6','BSF','BST','BU0','BU1','BU2','BU3','BU4','BUN','D00','ECL','EFR','FAF','FAM','FB1','FB2','FB3','FB4','FBI','FBL','FBR','FCL','FFR','FMN','FNC','FRC','FST','G','I00','MBC','MNC','STO','STU','T','TUC','U','UBI','UFS','V','VNL','Y'] => '3', 
									//Attached = 3
									input_Garage_Type IN ['30','100','150','160','220','230','280','290','300','310','330','410','480','490','500','501','502','520','530','540','550','560','570','580','590','600','620','630','660','680','701','730','750','760','761','762','763','810','820','830','840','860','870','920','921','922','923','924','940','950','951','952','953','954','960','980','ALU','ALW','BLO','CC6','CNB','CRE','D','DAC','DBC','DBF','DBL','DBR','DBS','DC1','DCB','DFC','DFF','DFN','DFR','DFS','DGH','DML','DMN','DST','DT0','DT1','DT2','DT3','DT4','DWO','E','E00','EDT','F00','FCN','FDM','K00','MM0','MTL','MWO','PML','PRF','S00','SLT','STE','UDF','UDM','UFB','UFC','UFD','UFF','V01','V02','WOF'] => '2', 
									//Detached = 2
									input_Garage_Type IN ['40','50','50','140','190','870','930','A00','A01','A02','A03','A04','A05','A06','AGH','ATC','B00','C','C00','CAF','CAL','CAW','CNC','CR0','CR1','CR2','CR3','CR4','CR5','CR6','CVC','D00','DD0','DGC','DTC','EBR','F00','FF0','FF0','G00','GAC','H00','I00','J00','K00','L00','M00','N00','O','O00','OPE','P00','POL','Q00','R00','T00','U00','UA0','V','WOC','WOO','Z00']=> '1', 
									//Carport = 1
									input_Garage_Type IN ['0','F','K','L','LOT','N','NON','OFF','P','PAV','R','RMP','S','SP0','STR','UIM','UU0']=>'0', 
									//None = 0
									'5');																						
									//Undefined = 5

//NAICS Codes - depricated
EXPORT isAgriculture := (['111120','111130','112112','112120','112130','112210','112310','112320','112330','112340','112390','112410','112420','112511','112512','112519','112910','112920','112930','112990','113110','113210','113310','114111','114112','114119','114210','115111','115112','1151132111','112112','112120','112130','112210','112310','112320','112330','112340','112390','112410','112420','112511','112512','112519','112910','112920','112930','112990','113110','113210','113310','114111','114112','114119','114210','115111','115112','115113','115114','115115','115116','115210']);
EXPORT isAgrMeatFishDiary := (['112111','112120','112130','112210','112310','112320','112330','112340','112390','112410','112420','112511','112512','112519','114111','114112','114119']);
EXPORT isAgrOrigFruitsVegNuts := (['111150','111160','111211','111219','111310','111320','111331','111332','111333','111334','111335','111336','111339','111411','111419','111992']);
EXPORT isGroceryStores := (['445110','445210','445220','445230','445291','445292','445299','445310']);
EXPORT isConvenStores := (['445120','447110','447190']);
EXPORT isPharmacyHealth := (['446110','446120','446130','446191','446199']);
EXPORT isRetailStores := (['446199','448110','448120','448130','448140','448150','448190','448210','448310','448320','451110','451120','451130','451140','451211','451212','451220','452111','452112','452910','452990','453110','453210','453220','453310','453910','453920','453930','453991','453998']);
EXPORT isManufFood := (['311111','311119','311211','311212','311213','311221','311222','311223','311225','311230','311311','311312','311313','311320','311330','311340','311411','311412','311421','311422','311423','311511','311512','311513','311514','311520','311611','311612','311613','311615','311711','311712','311811','311812','311813','311821','311822','311823','311830','311911','311919','311920','311930','311941','311942','311991','311999','312111','312112','312113','312120','312130','312140','424410','424420','424430','424440','424450','424460','424470','424480','424490','424810','424820']);
EXPORT isMedical := (['541940','621111','621112','621210','621310','621320','621330','621340','621391','621399','621410','621420','621491','621492','621493','621498','621511','621512','621610','621910','621991','621999','622110','622210','622310','623110','623210','623220','623311','623312','623990','624110','624120','624190']);
EXPORT isManufMedical := (['325411','325412','325413','334510','339112','339113','339114','339115','339116','423450','423460','424210']);
EXPORT isConstruction := (['236115','236116','236117','236118','236210','236220','238120','238130','238140','238150','238160','238170','238190','238210','238220','238290','238310','238320','238330','238340','238350','238390','238910','238990']);
EXPORT isManufConstruction := (['321213','321214','321219','321911','321912','321918','321920','321991','321992']);
EXPORT isLegal := (['541110','541120','541199']);
EXPORT isBanking := (['522110','522130','522190','522291','522292','522310','524127','524128']);
EXPORT isRealEstate := (['531210','531320','531390','541191','541350','551111']);
EXPORT isMilitary := (['332992','332993','332994','332995','336411','336412','336413','336414','336415','336419','336510','336611','336612','336991','336992','336999','928110']);
EXPORT isShipping := (['481112','481212','481219','482111','482112','483111','483113','483211','484110','484121','484122','484210','484220','484230','485111','488310','488320','488330','488390','488510','488991','488999']);
EXPORT isTravel := (['481111','481211','481219','483112','483113','483114','483212','485111','485112','485113','485119','485999']);
EXPORT isInsurance := (['524113','524114','524210','524291','524292','524298','525120','525190']);
EXPORT isPublicService := (['922110', '922130', '922150']);
EXPORT isPublicSafety := (['922120', '922160']);
EXPORT isCorrectional := (['922140']);
EXPORT isSchool := (['611110','611210','611310','611410','611420','611430','611511','611512','611513','611519','611610','611620','611630','611691','611692','611699','611710']);
EXPORT isDaycare := (['624410']);
EXPORT isHardgoodRepair := (['811111','811112','811113','811118','811121','811122','811191','811192','811198','811211','811212','811213','811219','811310','811411','811412','811420','811430','811490']);
EXPORT isEntertainment := (['711110','711120','711130','711190','711211','711212','711219','711310','711320','711410','711510','712110','712120','712130','712190','713110','713120','713210','713290','713910','713920','713930','713940','713950','713990']);
EXPORT isChurch := (['813110']);
EXPORT isPersonalCare := (['812111','812112','812113','812191','812199','812310','812320','812331','812910']);
EXPORT isCareFacility := (['622210','622310','623110','623210','623220','623311','623312','623990','624120','624190']);
EXPORT isRestaurant := (['722110','722211','722212','722213','722310','722320','722330','722410']);

End;
