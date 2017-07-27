import infoUSA, lib_AddrClean, address;

DEADCO_IN := infousa.File_DEADCO_In;


DEADCO_clean_layout_temp := record

infousa.Layout_DEADCO_In;
string73   clean_name;
string182  clean_address;

end;


DEADCO_clean_layout_temp tdeadcoclean(infousa.File_DEADCO_In L) := transform

self.clean_name    := AddrCleanLib.CleanPersonFML73(L.contact_name);
self.clean_address := AddrCleanLib.CleanAddress182(L.STREET1,L.CITY1 +' '+L.STATE1+' '+L.ZIP1_5 + L.ZIP1_4);
self.date_added    := if(length(trim(L.date_added, left, right)) = 6, if(trim(L.date_added, left, right) <> '195 8/',
                      trim(L.date_added, left, right), ''), '');

self := L;

end;

File_DEADCO_Clean_temp := project(infousa.File_DEADCO_In, tdeadcoclean(left));


infousa.Layout_DEADCO_Clean_In tDEADtoClean(File_DEADCO_Clean_temp L) := transform


self.dt_first_seen              := L.date_added;
self.dt_last_seen               := L.date_added;
self.dt_vendor_first_reported   := L.date_added;
self.dt_vendor_last_reported    := L.production_date[5..8] + L.production_date[1..4];
self.title				        := L.clean_name[1..5];
self.fname				        := L.clean_name[6..25];
self.mname				        := L.clean_name[26..45];
self.lname				        := L.clean_name[46..65];
self.name_suffix	            := L.clean_name[66..70];
self.name_cleaning_score		:= L.clean_name[71..73];
self.prim_range 	            := L.clean_address[1..10];
self.predir 			        := L.clean_address[11..12];
self.prim_name 		            := L.clean_address[13..40];
self.addr_suffix 	            := L.clean_address[41..44];
self.postdir 			        := L.clean_address[45..46];
self.unit_desig 	            := L.clean_address[47..56];
self.sec_range 		            := L.clean_address[57..64];
self.p_city_name 	            := L.clean_address[65..89];
self.v_city_name 	            := L.clean_address[90..114];
self.st 					    := L.clean_address[115..116];
self.zip5 					    := L.clean_address[117..121];
self.zip4 				        := L.clean_address[122..125];
self.cart 				        := L.clean_address[126..129];
self.cr_sort_sz 	            := L.clean_address[130];
self.lot 					    := L.clean_address[131..134];
self.lot_order 		            := L.clean_address[135];
self.dpbc 				        := L.clean_address[136..137];
self.chk_digit 		            := L.clean_address[138];
self.rec_type			        := L.clean_address[139..140];
self.ace_fips_st 			    := L.clean_address[141..142];
self.ace_fips_county 	        := L.clean_address[143..145];
self.geo_lat 			        := L.clean_address[146..155];
self.geo_long 		            := L.clean_address[156..166];
self.msa 					    := L.clean_address[167..170];
self.geo_blk 			        := L.clean_address[171..177];
self.geo_match 		            := L.clean_address[178];
self.err_stat 		            := L.clean_address[179..182];
self.phone                      := ADDRESS.CleanPhone(L.phone);
self := L;

end;


export File_DEADCO_Clean_In := project(File_DEADCO_clean_temp, tdeadtoclean(left));





