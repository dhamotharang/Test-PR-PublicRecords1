IMPORT doxie, Autokey_batch, BatchServices;

rec_sample := RECORD
		STRING20  acctno       := '';
		STRING64  addr         := '';
		STRING25  city				 := '';
		STRING2   state        := '';
		STRING5   zip          := '';
		STRING3	 	country			 := '';
		STRING120 comp_name    := '';
		STRING16	workphone 	 := '';
		UNSIGNED6 bdid         :=  0;
END;

ds_sample :=
	DATASET(
		[
			//acctno,addr,zip,city,state,country,comp_name,phone,bdid,bid
			{'1','','SYDNEY','','','AU','C/O GROVE RESEARCH AND ADVISORY','',0},
			{'2','24 RUE MONTOYER','','','','','EUROPEAN APPAREL AND TEXTILE ASSOCIATION','',0},
			{'3','171 NEPEAN','OTTAWA','','','CAN','GLOBAL ECOLABELLING NETWORK','',0},
			{'4','100 BARR HARBOR','','pa','','','','',0},
			{'5','','','','','','','6507220659',0}
		],rec_sample
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM( NaturalDisaster_Readiness.Layouts.batch_in,
			clean_address := doxie.cleanaddress182( LEFT.addr, TRIM(LEFT.city) + ' ' + TRIM(LEFT.state) + ' ' + TRIM(LEFT.zip) );
			SELF.prim_range  := clean_address[1..10],
			SELF.predir      := clean_address[11..12],
			SELF.prim_name   := clean_address[13..40],
			SELF.addr_suffix := clean_address[41..44],
			SELF.postdir     := clean_address[45..46],
			SELF.sec_range   := clean_address[57..64],
			SELF.p_city_name := IF(clean_address[90..114] != '',clean_address[90..114],LEFT.city);
			SELF.st          := IF(clean_address[115..116] != '',clean_address[115..116],LEFT.state);
			SELF.z5          := IF(clean_address[117..121] != '',clean_address[117..121],LEFT.zip);
			SELF             := LEFT
		)
	);
	
EXPORT _canned_records := records;
