import Address, ut, RoxieKeyBuild;

export proc_build_mps_all(string fileDate) := module
	export proc_build_base := function

		file_in := file_in_suppressionMPS;

		layout_suppressionMPS CleanDNM(DMA.layout_in_suppressionMPS InputRecord) := transform

			string73 tempName := stringlib.StringToUpperCase(if(trim(trim(InputRecord.FirstName,left,right) + ' ' + trim(InputRecord.LastName,left,right),left,right) <> '',
																												Address.CleanPerson73(trim(trim(InputRecord.LastName,left,right) + ', ' +
																												trim(InputRecord.FirstName,left,right),left,right)),''));													
			
			string182 tempAddress := stringlib.StringToUpperCase(if(InputRecord.StreetAddress <> '' or 
																															InputRecord.City <> '' or
																															InputRecord.State <> '' or
																															InputRecord.Zip <> '',
																															Address.CleanAddress182(trim(InputRecord.StreetAddress,left,right),
																															trim(trim(InputRecord.City,left,right) + ', ' +
																															trim(InputRecord.State,left,right) + ' ' +
																															trim(InputRecord.Zip,left,right) +
																															trim(InputRecord.Zip4,left,right),left,right)),
																															''));
				
			self.title			      		:= tempName[1..5];
			self.fname			      		:= tempName[6..25];
			self.mname			      		:= tempName[26..45];
			self.lname			      		:= tempName[46..65];
			self.name_suffix	    		:= tempName[66..70];
			self.name_score						:= tempName[71..73];
			self.prim_range    				:= tempAddress[1..10]; 
			self.predir 	      			:= tempAddress[11..12];
			self.prim_name 	  				:= tempAddress[13..40];
			self.addr_suffix   				:= tempAddress[41..44];
			self.postdir 	    				:= tempAddress[45..46];
			self.unit_desig 	  			:= tempAddress[47..56];
			self.sec_range 	  				:= tempAddress[57..64];
			self.p_city_name	  			:= tempAddress[65..89];
			self.v_city_name	  			:= tempAddress[90..114];
			self.st 			      			:= tempAddress[115..116];
			self.zip 		      				:= tempAddress[117..121];
			self.zip4 		      			:= tempAddress[122..125];
			self.cart 		      			:= tempAddress[126..129];
			self.cr_sort_sz 	 		 		:= tempAddress[130];
			self.lot 		      				:= tempAddress[131..134];
			self.lot_order 	  				:= tempAddress[135];
			self.dpbc 		      			:= tempAddress[136..137];
			self.chk_digit 	  				:= tempAddress[138];
			self.rec_type		  				:= tempAddress[139..140];
			self.ace_fips_st	  			:= tempAddress[141..142];
			self.fips_county 	  			:= tempAddress[143..145];
			self.geo_lat 	    				:= tempAddress[146..155];
			self.geo_long 	    			:= tempAddress[156..166];
			self.msa 		      				:= tempAddress[167..170];
			self.geo_match 	  				:= tempAddress[178];
			self.err_stat 	    			:= tempAddress[179..182];
			end;
		
		cleanedFile := project(file_in,CleanDNM(left));
		
		return cleanedFile;
	end;

	export proc_build_key := function							
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_DNM_name_address,
																							'~thor_data400::key::DNM::@version@::name.address',
																							'~thor_data400::key::DNM::'+filedate+'::name.address',
																							DNMNameAddrKeyOut
																							);
				
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DNM::@version@::name.address',
																					'~thor_data400::key::DNM::'+filedate+'::name.address',
																					mv_dnm
																				 );
												
		RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::DNM::@version@::name.address', 'Q', mv_dnm_key);

		update_dops := RoxieKeyBuild.updateversion('DoNotMailKeys',filedate,'kgummadi@seisint.com;christopher.brodeur@lexisnexis.com;randy.reyes@lexisnexis.com',,'N');
		
		return sequential(DNMNameAddrKeyOut,mv_dnm,mv_dnm_key,update_dops);
	end;
	
end;