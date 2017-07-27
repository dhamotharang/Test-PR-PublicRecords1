
IMPORT doxie;

rec_sample := RECORD
		STRING20  acctno       := '';
		UNSIGNED6 bdid         :=  0;
		UNSIGNED6 bid          :=  0;
		STRING120 comp_name    := '';
		STRING64  addr         := '';
		STRING25  p_city_name  := '';
		STRING2   st           := '';
		STRING5   z5           := '';
		STRING4   zip4         := '';
END;

ds_sample :=
	DATASET(
		[
			{'001', 0      , 867770129 , 'JEM NIGHT CLUB'                 , '671 WASHINGTON AVE'        , 'MIAMI BEACH'  , 'FL', '33139'},
			{'002', 0      , 2282186089, 'DEEMARET HEALTH CARE CENTER'    , '1140 S HAWKINS AVENUE'     , 'AKRON'        , 'OH', '44320'},
			{'003', 0      , 4406350866, 'DITATAS SINKS AND MORE'         , '380 EAST I240 SERVICE ROAD', 'OKLAHOMA CITY', 'OK', '73149'},
			{'004', 0      , 5225281767, 'NORTHEAST ELECTRICS'            , '35 KULICK RD'              , 'FAIRFIELD'    , 'NJ', '07004'},
			{'005', 0      , 5261493835, 'LIBERTY FISH MARKET'            , '11715 LIBERTY AVENUE'      , 'RICHMOND HILL', 'NY', '11418'},
			{'006', 2584014, 5203723760, 'SOFT AND SALTY SEAFOOD'         , '5456 RAGGED POINT RD'      , 'CAMBRIDGE'    , 'MD', '21613'},
			{'007', 3384628, 5193682799, 'DUNKIN DONUTS'                  , '137 BROADWAY'              , 'NEWPORT'      , 'RI', '02840'},
			{'008', 0      , 0         , 'LASCO ACOUSTICS AND DRYWALL INC', '2701 GATTIS SCHOOL RD'     , 'AUSTIN'       , 'TX', '73301'},
			{'009', 0      , 0         , 'LASCO ACOUSTICS AND DRYWALL INC', ''                          , ''             , ''  , ''}
		],
		rec_sample
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM( LaborActions_WHD_Services.layouts_batch.Batch_in,
			clean_address := doxie.cleanaddress182( LEFT.addr, TRIM(LEFT.p_city_name) + ' ' + TRIM(LEFT.st) + ' ' + TRIM(LEFT.z5) );
			SELF.prim_range  := clean_address[1..10],
			SELF.predir      := clean_address[11..12],
			SELF.prim_name   := clean_address[13..40],
			SELF.addr_suffix := clean_address[41..44],
			SELF.postdir     := clean_address[45..46],
			SELF.sec_range   := clean_address[57..64],
			SELF.p_city_name := clean_address[90..114],
			SELF.st          := clean_address[115..116],
			SELF.z5          := clean_address[117..121],
			SELF             := LEFT
		)
	);
	
EXPORT _canned_records := records;
