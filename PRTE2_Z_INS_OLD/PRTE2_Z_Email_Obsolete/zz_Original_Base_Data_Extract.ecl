IMPORT Address;

EXPORT zz_Original_Base_Data_Extract := MODULE

//TODO - switch to use constants and files
baseCustTestLogicalFile 	:= '~foreign::10.194.12.1::thor::in::ct::marketdataprefill::20120918::marketview';
baseCustTestDS 		:= DATASET(baseCustTestLogicalFile, _layouts.base, THOR);

_layouts.phase1_incoming_layout xGetBaseFile(_layouts.base L) := TRANSFORM
				SELF.LexId := (STRING)L.did;
				SELF.email := L.clean_email;
				SELF.fname := L.clean_name.fname;
				SELF.lname := L.clean_name.lname;
				SELF.address := Address.Addr1FromComponents(L.clean_address.prim_range,L.clean_address.predir,L.clean_address.prim_name,
														L.clean_address.addr_suffix,L.clean_address.postdir,L.clean_address.unit_desig,L.clean_address.sec_range);
				SELF.city := L.clean_address.p_city_name;
				SELF.zip := L.clean_address.zip;
				SELF.state := L.clean_address.st;
				SELF.phone := '';
				SELF.source := L.email_src;
				SELF.ip := L.orig_ip;
				SELF.date_time := '';
				// SELF.gender := '';
				SELF.dob := (STRING)L.best_dob;
				SELF.nonincentivized_opt_in := '';
				SELF.incentivized_opt_in := '';
END;

EXPORT Original_Base_Data_Extracted := PROJECT(baseCustTestDS, xGetBaseFile(LEFT));

END;