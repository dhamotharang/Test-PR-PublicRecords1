import	STD, Address;

rgxBadAddress :=
			 '\\b(SAME|GENERAL.*DELIVERY|HOMELESS|DONALD LEE HOLLOWELL)\\b';
			 

// clean good physical addresses
NAC_POC.Layout_Interim xGoodPhysical(NAC_POC.Layout_Interim l) := transform
	Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
	STRING28  v_prim_name 		:= Clean_Address[13..40];
	STRING5   v_zip       		:= Clean_Address[117..121];
	STRING4   v_zip4      		:= Clean_Address[122..125];
	SELF.prim_range  			:= Clean_Address[ 1..  10];
	SELF.predir      			:= Clean_Address[ 11.. 12];
	SELF.prim_name   			:= v_prim_name;
	SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
	SELF.postdir     			:= Clean_Address[ 45.. 46];
	SELF.unit_desig  			:= Clean_Address[ 47.. 56];
	SELF.sec_range   			:= Clean_Address[ 57.. 64];
	SELF.p_city_name 			:= Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= Clean_Address[ 90..114];
	SELF.st          			:= Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cart        			:= Clean_Address[126..129];
	SELF.cr_sort_sz  			:= Clean_Address[130..130];
	SELF.lot         			:= Clean_Address[131..134];
	SELF.lot_order   			:= Clean_Address[135..135];
	SELF.dbpc        			:= Clean_Address[136..137];
	SELF.chk_digit   			:= Clean_Address[138..138];
	SELF.rec_type    			:= Clean_Address[139..140];
	SELF.fips_state 			:= Clean_Address[141..142];
	SELF.fips_county 			:= Clean_Address[143..145];
	SELF.geo_lat     			:= Clean_Address[146..155];
	SELF.geo_long    			:= Clean_Address[156..166];
	SELF.msa         			:= Clean_Address[167..170];
	SELF.geo_blk     			:= Clean_Address[171..177];
	SELF.geo_match   			:= Clean_Address[178..178];
	SELF.err_stat    			:= Clean_Address[179..182];
	
	self.phys_status := Clean_Address[179..182];			// status of physical address
	SELF := l;
END;

// clean mailing addresses
NAC_POC.Layout_Interim xMailingAddr(NAC_POC.Layout_Interim l) := TRANSFORM
				self.addr_selected := 'M';
	Clean_Address := address.CleanAddress182(l.Prepped_maddr1,l.Prepped_maddr2);
	STRING28  v_prim_name 		:= Clean_Address[13..40];
	STRING5   v_zip       		:= Clean_Address[117..121];
	STRING4   v_zip4      		:= Clean_Address[122..125];
	SELF.prim_range  			:= Clean_Address[ 1..  10];
	SELF.predir      			:= Clean_Address[ 11.. 12];
	SELF.prim_name   			:= v_prim_name;
	SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
	SELF.postdir     			:= Clean_Address[ 45.. 46];
	SELF.unit_desig  			:= Clean_Address[ 47.. 56];
	SELF.sec_range   			:= Clean_Address[ 57.. 64];
	SELF.p_city_name 			:= Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= Clean_Address[ 90..114];
	SELF.st          			:= Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cart        			:= Clean_Address[126..129];
	SELF.cr_sort_sz  			:= Clean_Address[130..130];
	SELF.lot         			:= Clean_Address[131..134];
	SELF.lot_order   			:= Clean_Address[135..135];
	SELF.dbpc        			:= Clean_Address[136..137];
	SELF.chk_digit   			:= Clean_Address[138..138];
	SELF.rec_type    			:= Clean_Address[139..140];
	SELF.fips_state 			:= Clean_Address[141..142];
	SELF.fips_county      := Clean_Address[143..145];
	SELF.geo_lat     			:= Clean_Address[146..155];
	SELF.geo_long    			:= Clean_Address[156..166];
	SELF.msa         			:= Clean_Address[167..170];
	SELF.geo_blk     			:= Clean_Address[171..177];
	SELF.geo_match   			:= Clean_Address[178..178];
	SELF.err_stat    			:= Clean_Address[179..182];
	
			self.mail_status := Clean_Address[179..182];		// status of mailing address
			self := l;
END;


EXPORT fn_CleanAddress(DATASET(Layout_Interim) ds) := FUNCTION

		dsPrepped := PROJECT(ds, TRANSFORM(Layout_Interim,
				self.addr_reject := IF(regexfind(rgxBadAddress, left.case_physical_address_street_1),'Y','');
				self.Prepped_addr1 := Std.str.cleanspaces(left.case_physical_address_street_1 + ' ' + left.case_physical_address_street_2);
				self.Prepped_addr2 := Std.str.cleanspaces(TRIM(left.case_physical_address_city) + ', ' + left.case_physical_address_state +
																						' ' + left.case_physical_address_zip[1..5]);
																						
				self.Prepped_maddr1 := Std.str.cleanspaces(left.case_mailing_address_street_1 + ' ' + left.case_mailing_address_street_2);
				self.Prepped_maddr2 := Std.str.cleanspaces(TRIM(left.case_mailing_address_city) + ', ' + left.case_mailing_address_state +
																						' ' + left.case_mailing_address_zip[1..5]);

				self := LEFT;));
				
		// choose best address
			badphys := dsPrepped(addr_reject='Y');
			goodphys := dsPrepped(addr_reject<>'Y');
			
			cleanPhys := PROJECT(goodphys, xGoodPhysical(LEFT));
			
			// use the mailing address if:
			//	1. the physical address is rejected
			//	2. the error status of the physical address is 'E'
			usemail := dsPrepped(addr_reject='Y') + cleanphys(phys_status[1]<>'S');
			
			cleanmail := PROJECT(usemail, xMailingAddr(LEFT));

				
		cleanAddresses := cleanphys(phys_status[1]='S')+cleanmail : PERSIST('~nac::extract::cleanaddresses');
		
		return cleanAddresses;
			
END;