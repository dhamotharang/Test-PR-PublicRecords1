import Marketing_Best, Doxie, ut, DMA, Address, lib_stringlib;

file_in := DMA.file_suppressionMPS;

Cleanedlayout := record
	string5 		title;
	string20 		fname;
	string20 		mname;
	string20 		lname;
	string5 		name_suffix;
	string3 		name_score;
	string10  		prim_range;
	string2   		predir;
	string28  		prim_name;
	string4   		addr_suffix;
	string2   		postdir;
	string10  		unit_desig;
	string8   		sec_range;
	string25  		p_city_name;
	string25  		v_city_name;
	string2   		st;
	string5   		zip;
	string4   		zip4;
	string4   		cart;
	string1   		cr_sort_sz;
	string4   		lot;
	string1   		lot_order;
	string2   		dpbc;
	string1   		chk_digit;
	string2   		rec_type;
	string2   		ace_fips_st;
	string3			fips_county;
	string10  		geo_lat;
	string11  		geo_long;
	string4   		msa;
	string1   		geo_match;
	string4   		err_stat;
end;

Cleanedlayout CleanDNM(DMA.layout_SUPpressionMPS InputRecord) := transform

	string73 tempName := stringlib.StringToUpperCase(if(trim(trim(InputRecord.First_Name,left,right) + ' ' +
															 trim(InputRecord.Last_Name,left,right),left,right) <> '',
														 Address.CleanPerson73(trim(trim(InputRecord.Last_Name,left,right) + ', ' +
		                                                                            trim(InputRecord.First_Name,left,right),left,right)),''));													
	
	string182 tempAddress := stringlib.StringToUpperCase(if(InputRecord.Street <> '' or 
	                                                        InputRecord.CITY <> '' or
															InputRecord.STATE <> '' or
															InputRecord.ZIP <> '',
														 Address.CleanAddress182(trim(InputRecord.Street,left,right),
														                         trim(trim(InputRecord.City,left,right) + ', ' +
																				      trim(InputRecord.State,left,right) + ' ' +
																					  trim(InputRecord.ZIP,left,right) +
																					  trim(InputRecord.ZIP4,left,right),left,right)),
																			    ''));
		
	self.title			      		:= tempName[1..5];
	self.fname			      		:= tempName[6..25];
	self.mname			      		:= tempName[26..45];
	self.lname			      		:= tempName[46..65];
	self.name_suffix	    		:= tempName[66..70];
	self.name_score					:= tempName[71..73];
	self.prim_range    				:= tempAddress[1..10]; 
	self.predir 	      			:= tempAddress[11..12];
	self.prim_name 	  				:= tempAddress[13..40];
	self.addr_suffix   				:= tempAddress[41..44];
	self.postdir 	    			:= tempAddress[45..46];
	self.unit_desig 	  			:= tempAddress[47..56];
	self.sec_range 	  				:= tempAddress[57..64];
	self.p_city_name	  			:= tempAddress[65..89];
	self.v_city_name	  			:= tempAddress[90..114];
	self.st 			      		:= tempAddress[115..116];
	self.zip 		      			:= tempAddress[117..121];
	self.zip4 		      			:= tempAddress[122..125];
	self.cart 		      			:= tempAddress[126..129];
	self.cr_sort_sz 	 		 	:= tempAddress[130];
	self.lot 		      			:= tempAddress[131..134];
	self.lot_order 	  				:= tempAddress[135];
	self.dpbc 		      			:= tempAddress[136..137];
	self.chk_digit 	  				:= tempAddress[138];
	self.rec_type		  			:= tempAddress[139..140];
	self.ace_fips_st	  			:= tempAddress[141..142];
	self.fips_county 	  			:= tempAddress[143..145];
	self.geo_lat 	    			:= tempAddress[146..155];
	self.geo_long 	    			:= tempAddress[156..166];
	self.msa 		      			:= tempAddress[167..170];
	self.geo_match 	  				:= tempAddress[178];
	self.err_stat 	    			:= tempAddress[179..182];
	end;
	
cleanedFile := project(file_in,CleanDNM(left));

export key_DNM_Name_Address := index(cleanedFile, 
									{string28 l_prim_name := ut.StripOrdinal(prim_name), 
									string10 l_prim_range := TRIM(ut.CleanPrimRange(prim_range),LEFT), 
									l_st := st, 
									l_city_code := doxie.Make_CityCode(p_city_name),
									l_zip := zip,
									l_sec_range := sec_range,
									l_lname := lname,
									l_fname := fname},{cleanedFile},
									'~thor_data400::key::Marketing_Best::' + Doxie.Version_SuperKey + '::dnm_name_address');