import address, std;
/*
	Clean NCF2 Address records
	
*/
		boolean fnBadAddress(string addr1, string addr2) :=
					trim(regexreplace(nac_v2.Mod_Sets.RegexBadAddress,Std.Str.CleanSpaces(addr1),'$2',nocase))
																	in nac_v2.Mod_Sets.SetBadAddress
					or trim(regexreplace(nac_v2.Mod_Sets.RegexBadAddress,Std.Str.CleanSpaces(addr2),'$2',nocase))
															in nac_v2.Mod_Sets.SetBadAddress;

		 layouts2.rAddressEx xPrep(layouts2.rAddressEx L) := TRANSFORM


				SELF.Prepped_addr1    := StandardizeName(L.Street1 + ' ' + L.Street2);
				SELF.Prepped_addr2    := StandardizeName(TRIM(L.City) + if(L.City = '' OR Std.Str.EndsWith(TRIM(L.City),','),'',',') 
																			+ ' ' + L.State + ' ' + L.ZipCode);

				self := L;
				self := [];
		END;


EXPORT proc_cleanAddr(DATASET(layouts2.rAddressEx) filein) := FUNCTION
	
		prepped := PROJECT(filein, xPrep(left));
		
		UniqueAddresses := dedup(
									prepped(
										Prepped_addr2<>''
										//,Prepped_addr1<>''
										,NOT fnBadAddress(Prepped_addr1,Prepped_addr2)
									),Prepped_addr1,Prepped_addr2,all);

		layouts2.rAddressEx tr4(UniqueAddresses l) := transform
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
			SELF := l;
		END;

		AddressClean := project(UniqueAddresses,tr4(left));
		
		restored := join(distribute(prepped,  hash64(Prepped_addr2,Prepped_addr1))
								,distribute(AddressClean, hash64(Prepped_addr2,Prepped_addr1)),
								left.Prepped_addr2=right.Prepped_addr2
								and left.Prepped_addr1=right.Prepped_addr1
								,transform(layouts2.rAddressEx
									,self.prim_range   :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_range,'')
									,self.predir       :=if(left.Prepped_addr1=right.Prepped_addr1,right.predir,'')
									,self.prim_name    :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_name,'')
									,self.addr_suffix  :=if(left.Prepped_addr1=right.Prepped_addr1,right.addr_suffix,'')
									,self.postdir      :=if(left.Prepped_addr1=right.Prepped_addr1,right.postdir,'')
									,self.unit_desig   :=if(left.Prepped_addr1=right.Prepped_addr1,right.unit_desig,'')
									,self.sec_range    :=if(left.Prepped_addr1=right.Prepped_addr1,right.sec_range,'')
									,self.p_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.p_city_name,'')
									,self.v_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.v_city_name,'')
									,self.st           :=if(left.Prepped_addr1=right.Prepped_addr1,right.st,'')
									,self.zip          :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip,'')
									,self.zip4         :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip4,'')
									,self.cart         :=if(left.Prepped_addr1=right.Prepped_addr1,right.cart,'')
									,self.cr_sort_sz   :=if(left.Prepped_addr1=right.Prepped_addr1,right.cr_sort_sz,'')
									,self.lot          :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot,'')
									,self.lot_order    :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot_order,'')
									,self.dbpc         :=if(left.Prepped_addr1=right.Prepped_addr1,right.dbpc,'')
									,self.chk_digit    :=if(left.Prepped_addr1=right.Prepped_addr1,right.chk_digit,'')
									,self.rec_type     :=if(left.Prepped_addr1=right.Prepped_addr1,right.rec_type,'')
									,self.fips_state  	:=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_state,'')
									,self.fips_county   :=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_county,'')
									,self.geo_lat      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_lat,'')
									,self.geo_long     :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_long,'')
									,self.msa          :=if(left.Prepped_addr1=right.Prepped_addr1,right.msa,'')
									,self.geo_blk      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_blk,'')
									,self.geo_match    :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_match,'')
									,self.err_stat     :=if(left.Prepped_addr1=right.Prepped_addr1,right.err_stat,'')
									,self:=left)
								,left outer
								,local);
		
		return restored;

END;