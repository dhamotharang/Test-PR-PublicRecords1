import FBN_new, ADDRESS,Business_HeaderV2;


file_in := Business_HeaderV2.Source_Files.infousa_fbn.BusinessHeader;


search_pattern := '^(.*)/(.*)/(.*)';

FBN_new.Layout_FBN_fixed_Clean tclean(file_in L) := transform


clean_name    := address.CleanPersonFML73(L.CNTCT_FIRST_NAME + ' ' +
                                                    L.CNTCT_LAST_NAME + 
													L.CNTCT_SUFFIX);
clean_bus_address := address.CleanAddress182(L.BUS_STR_ADDR,L.BUS_CITY +' '+L.BUS_STATE+' '+L.BUS_ZIP + L.BUS_ZIP_4);
clean_cntct_address := address.CleanAddress182(L.cntct_STR_ADDR,L.CNTCT_CITY +' '+L.CNTCT_STATE+' '+L.CNTCT_ZIP);
self.CCT_Clean_title				        := clean_name[1..5];
self.CCT_Clean_fname				        := clean_name[6..25];
self.CCT_Clean_mname				        := clean_name[26..45];
self.CCT_Clean_lname				        := clean_name[46..65];
self.CCT_Clean_name_suffix	            := clean_name[66..70];
self.CCT_Clean_cleaning_score		            := clean_name[71..73];
self.business_address_clean_prim_range 	            := clean_bus_address[1..10];
self.business_address_clean_predir 			        := clean_bus_address[11..12];
self.business_address_clean_prim_name 		            := clean_bus_address[13..40];
self.business_address_clean_addr_suffix 	            := clean_bus_address[41..44];
self.business_address_clean_postdir 			        := clean_bus_address[45..46];
self.business_address_clean_unit_desig 	            := clean_bus_address[47..56];
self.business_address_clean_sec_range 		            := clean_bus_address[57..64];
self.business_address_clean_p_city_name 	            := clean_bus_address[65..89];
self.business_address_clean_v_city_name 	            := clean_bus_address[90..114];
self.business_address_clean_st 					    := clean_bus_address[115..116];
self.business_address_clean_zip 					    := clean_bus_address[117..121];
self.business_address_clean_zip4 				        := clean_bus_address[122..125];
self.business_address_clean_cart 				        := clean_bus_address[126..129];
self.business_address_clean_cr_sort_sz 	            := clean_bus_address[130];
self.business_address_clean_lot 					    := clean_bus_address[131..134];
self.business_address_clean_lot_order 		            := clean_bus_address[135];
self.business_address_clean_dpbc 				        := clean_bus_address[136..137];
self.business_address_clean_chk_digit 		            := clean_bus_address[138];
self.business_address_clean_record_type			        := clean_bus_address[139..140];
self.business_address_clean_ace_fips_st 			    := clean_bus_address[141..142];
self.business_address_clean_fipscounty 	        := clean_bus_address[143..145];
self.business_address_clean_geo_lat 			        := clean_bus_address[146..155];
self.business_address_clean_geo_long 		            := clean_bus_address[156..166];
self.business_address_clean_msa 					    := clean_bus_address[167..170];
self.business_address_clean_geo_blk 			        := clean_bus_address[171..177];
self.business_address_clean_geo_match 		            := clean_bus_address[178];
self.business_address_clean_err_stat 		            := clean_bus_address[179..182];
self.cct_address_clean_prim_range 	            := clean_cntct_address[1..10];
self.cct_address_clean_predir 			        := clean_cntct_address[11..12];
self.cct_address_clean_prim_name 		            := clean_cntct_address[13..40];
self.cct_address_clean_addr_suffix 	            := clean_cntct_address[41..44];
self.cct_address_clean_postdir 			        := clean_cntct_address[45..46];
self.cct_address_clean_unit_desig 	            := clean_cntct_address[47..56];
self.cct_address_clean_sec_range 		            := clean_cntct_address[57..64];
self.cct_address_clean_p_city_name 	            := clean_cntct_address[65..89];
self.cct_address_clean_v_city_name 	            := clean_cntct_address[90..114];
self.cct_address_clean_st 					    := clean_cntct_address[115..116];
self.cct_address_clean_zip 					    := clean_cntct_address[117..121];
self.cct_address_clean_zip4 				        := clean_cntct_address[122..125];
self.cct_address_clean_cart 				        := clean_cntct_address[126..129];
self.cct_address_clean_cr_sort_sz 	            := clean_cntct_address[130];
self.cct_address_clean_lot 					    := clean_cntct_address[131..134];
self.cct_address_clean_lot_order 		            := clean_cntct_address[135];
self.cct_address_clean_dpbc 				        := clean_cntct_address[136..137];
self.cct_address_clean_chk_digit 		            := clean_cntct_address[138];
self.cct_address_clean_record_type			        := clean_cntct_address[139..140];
self.cct_address_clean_ace_fips_st 			    := clean_cntct_address[141..142];
self.cct_address_clean_fipscounty 	        := clean_cntct_address[143..145];
self.cct_address_clean_geo_lat 			        := clean_cntct_address[146..155];
self.cct_address_clean_geo_long 		            := clean_cntct_address[156..166];
self.cct_address_clean_msa 					    := clean_cntct_address[167..170];
self.cct_address_clean_geo_blk 			        := clean_cntct_address[171..177];
self.cct_address_clean_geo_match 		            := clean_cntct_address[178];
self.cct_address_clean_err_stat 		            := clean_cntct_address[179..182];
self.ContactTelephone_clean                    := ADDRESS.CleanPhone(L.CNTCT_PHONE_NUM);
self.BusinessTelephone_clean                   := ADDRESS.CleanPhone(L.BUS_PHONE_NUM);
self.filing_date                        := if(trim(L.filing_date, left, right)[1]='/', ' ','20' + regexfind(search_pattern,L.filing_date, 3) +
                                           regexfind(search_pattern,L.filing_date, 1) + regexfind(search_pattern,L.filing_date, 2));

self.dt_first_seen                 := if(self.filing_date <> '', self.filing_date, '');                    
self.dt_last_seen                  := if(self.filing_date <> '', self.filing_date, '');
self.dt_vendor_first_reported      := L.process_date;
self.dt_vendor_last_reported       := L.process_date;

self := L;

end;



export File_FBN_Clean_fixed := project(file_in, tclean(left));;