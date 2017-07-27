
IMPORT Autokey_batch, doxie;

rec_sample := RECORD
		STRING20  acctno       := '';
		UNSIGNED6 bdid         :=  0;
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
			{'001', 0, 'CIAO RESTAURANT' , '665 MARTINSVILLE RD STE 101', 'BASKING RIDGE', 'NJ', '07920'},
			{'002', 0, 'ZACKS ELECTRICAL', '15 NEWCOMB RD'              , 'WESTMINSTER'  , 'MA', '01473'},
			{'003', 0, 'PERRY ALEXIOU '  , '1551 2ND AVE'               , 'NEW YORK'     , 'NY', '10028'},
			{'004', 0, '87-32'           , '1411 BROADWAY FL 38'        , 'NEW YORK'     , 'NY', '10018'},
			{'005', 0, 'KATONAH HARDWARE', '143 KATONAH AVE '           , 'KATONAH '     , 'NY', '10536'},
			{'006', 0, 'TITAN USA'                   , '140 BALDWIN ST'   , 'W SPRINGFIELD', 'MA', '01089'},
			{'007', 0, 'STONEFORGE TAVERN'           , '90 PARAMOUNT DR'  , 'RAYNHAM'      , 'MA', '02767'},
			{'008', 0, 'FRANK & CAMILLES FINE PIANOS', '29 W 57TH ST FL 2', 'NEW YORK'     , 'NY', '10019'},
			{'009', 0, 'RONS STEEL SALES'            , '886 SOUTH ST'     , 'DAYTON'       , 'ME', '04005'},
			{'010', 0, 'A 1 PLASTICS'                , '136 TICHENOR ST'  , 'NEWARK '      , 'NJ', '07105'}
		],
		rec_sample
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM( Autokey_batch.layouts.rec_inBatchMaster,
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
