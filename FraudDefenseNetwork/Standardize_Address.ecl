export Standardize_Address(DatasetIn,DatasetOut) := macro

import address;

  #uniquename(inData)
  %inData%               := DatasetIn;
  #uniquename(pDatasetIn)
  #uniquename(dDatasetIn)
  #uniquename(UnqDatasetIn)
  #uniquename(xform)
  #uniquename(DatasetInCln)

  %pDatasetIn%           := project(%inData%, transform({recordof(%inData%),  unsigned8 hAddr},
                                                        self.hAddr     := hash64(trim(left.Address_1, left, right) + trim(left.Address_2, left, right));
                                                        self           := left;));
  %dDatasetIn%           := distribute(%pDatasetIn%, hAddr);

  %UnqDatasetIn%         := dedup(sort(%dDatasetIn%, hAddr, local), hAddr, local); 

  typeof(%pDatasetIn%)   %xform%(%pDatasetIn% l) := transform
       clean                                      := Address.GetCleanAddress (l.address_1, l.address_2, address.Components.Country.US).results;
       clean_Address_182                          := if (l.address_2 != '', address.CleanAddress182(l.address_1, l.address_2), '');
       self.clean_address.prim_range              := Clean_Address_182[1..10]; //prim_range
       self.clean_address.predir                  := Clean_Address_182[11..12]; //predir
				self.clean_address.prim_name			           := Clean_Address_182[13..40]; //prim_name
				self.clean_address.addr_suffix             := Clean_Address_182[41..44]; //addr_suffix				
				self.clean_address.postdir                 := Clean_Address_182[45..46]; //postdir
				self.clean_address.unit_desig              := Clean_Address_182[47..56]; //unit_desig
				self.clean_address.sec_range			           := Clean_Address_182[57..64]; //sec_range
				self.clean_address.p_city_name             := Clean_Address_182[65..89]; //p_city_name
				self.clean_address.v_city_name             := Clean_Address_182[90..114]; //v_city_name
				self.clean_address.st                      := Clean_Address_182[115..116]; //st
				self.clean_address.zip                     := Clean_Address_182[117..121]; //zip
				self.clean_address.zip4                    := Clean_Address_182[122..125]; //zip4
				self.clean_address.cart                    := Clean_Address_182[126..129]; //cart
				self.clean_address.cr_sort_sz              := Clean_Address_182[130]; //cr_sort_sz
				self.clean_address.lot                     := Clean_Address_182[131..134]; //lot
				self.clean_address.lot_order			           := Clean_Address_182[135]; //lot_order
				self.clean_address.dbpc                    := Clean_Address_182[136..137]; //dpbc
				self.clean_address.chk_digit			           := Clean_Address_182[138]; //chk_digit
				self.clean_address.rec_type                := Clean_Address_182[139..140]; //record_type
				self.clean_address.fips_state              := Clean_Address_182[141..142]; //ace_fips_state
				self.clean_address.fips_county             := Clean_Address_182[143..145]; //county
				self.clean_address.geo_lat                 := Clean_Address_182[146..155]; //geo_lat
				self.clean_address.geo_long			           := Clean_Address_182[156..166]; //geo_long
				self.clean_address.msa                     := Clean_Address_182[167..170]; //msa
				self.clean_address.geo_blk                 := Clean_Address_182[171..177]; //geo_blk
				self.clean_address.geo_match			           := Clean_Address_182[178]; //geo_match
				self.clean_address.err_stat			           := Clean_Address_182[179..182]; //err_stat				
       self                                       := l;
  end;
  %DatasetInCln%          := project(%UnqDatasetIn%, %xform%(left));

   DatasetOut             := join(%dDatasetIn%, %DatasetInCln%, left.hAddr = right.hAddr, 
                                 transform({recordof(%inData%)},
																              self.clean_address.prim_range                   := right.clean_address.prim_range	;
																								self.clean_address.predir                       := right.clean_address.predir		;
																								self.clean_address.prim_name                    := right.clean_address.prim_name	;
																								self.clean_address.addr_suffix                  := right.clean_address.addr_suffix	;
																								self.clean_address.postdir                      := right.clean_address.postdir      ;
																								self.clean_address.unit_desig                   := right.clean_address.unit_desig   ;
																								self.clean_address.sec_range                    := right.clean_address.sec_range	;
																								self.clean_address.p_city_name                  := right.clean_address.p_city_name	;
																								self.clean_address.v_city_name                  := right.clean_address.v_city_name	;
																								self.clean_address.st                           := right.clean_address.st           ;
																								self.clean_address.zip                          := right.clean_address.zip          ;
																								self.clean_address.zip4                         := right.clean_address.zip4         ;
																								self.clean_address.cart                         := right.clean_address.cart         ;
																								self.clean_address.cr_sort_sz                   := right.clean_address.cr_sort_sz   ;
																								self.clean_address.lot                          := right.clean_address.lot          ;
																								self.clean_address.lot_order                    := right.clean_address.lot_order	;
																								self.clean_address.dbpc                         := right.clean_address.dbpc         ;
																								self.clean_address.chk_digit                    := right.clean_address.chk_digit	;
																								self.clean_address.rec_type                     := right.clean_address.rec_type     ;
																								self.clean_address.fips_state 	                := right.clean_address.fips_state 	;
																								self.clean_address.fips_county	                := right.clean_address.fips_county	;
																								self.clean_address.geo_lat                      := right.clean_address.geo_lat      ;
																								self.clean_address.geo_long                     := right.clean_address.geo_long		;
																								self.clean_address.msa                          := right.clean_address.msa			;
																								self.clean_address.geo_blk                      := right.clean_address.geo_blk		;
																								self.clean_address.geo_match                    := right.clean_address.geo_match	;
																								self.clean_address.err_stat                     := right.clean_address.err_stat		;
                                           self                                            := left;)
																					     ,left outer, local);
endmacro;                             