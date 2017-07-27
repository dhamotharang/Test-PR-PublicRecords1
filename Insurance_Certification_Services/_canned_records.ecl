
IMPORT doxie, Autokey_batch, BatchServices;

ds_sample :=
	DATASET(
		// [
		// acctno,name_last,addr,zip,city,state,comp_name,name_first,filing_number,sic_code,fein,ssn,DOB,name_middle,did, bdid
		[{'2','','283 brandy hills','32129','','fl','MAMIYE BROTHERS INC','','','','','','','',0,0},
		 {'3','','','','','','','','','','','','','',0,7724008},
		 {'4','','','','','','','','','','271754130','','','',0,0},
		 {'5','','','','','','ameristar casinos','','','','','','','',0,0},
		 {'9','','201 hyde park','65109','','','wood ranch usa','','','','','','','',0,0}],
		BatchServices._Sample_layout_input_raw
	);

records := 
	PROJECT(
		ds_sample,
		TRANSFORM(Insurance_Certification_Services.layouts_batch.Batch_in,
			clean_address := doxie.cleanaddress182( LEFT.addr, TRIM(LEFT.city) + ' ' + TRIM(LEFT.state) + ' ' + TRIM(LEFT.zip) );
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
