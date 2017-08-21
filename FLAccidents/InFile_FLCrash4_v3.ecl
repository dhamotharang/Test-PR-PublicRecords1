import ut,Address,lib_stringlib;

flc4_v2_in := dataset(ut.foreign_prod + '~thor_data400::sprayed::flcrash4'
							,FLAccidents.Layout_FLCrash4_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));							

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash4_v3;
end;

clean_addr trcleanaddr(flc4_v2_in le) := transform
//self.clean_address := if(le.driver_street <> '',Address.CleanAddress182(lib_stringlib.StringLib.StringCleanSpaces(le.driver_street),lib_stringlib.StringLib.StringCleanSpaces(le.driver_city)+ ', '+lib_stringlib.StringLib.StringCleanSpaces(le.driver_resident_state) + '  '+ lib_stringlib.StringLib.StringCleanSpaces(le.driver_zip)),'');
self.clean_name := if(le.driver_lname <> '',Address.CleanPersonFML73(StringLib.StringFindReplace(lib_stringlib.StringLib.StringCleanSpaces(le.driver_fname)+' '+ lib_stringlib.StringLib.StringCleanSpaces(le.driver_mname)+' '+lib_stringlib.StringLib.StringCleanSpaces(le.driver_lname),'.',' ')),'');
self := le;
end;

File_clean_addr := project(flc4_v2_in,trcleanaddr(LEFT));	


flc4_v2_rec := FLAccidents.Layout_FLCrash4_v2;


flc4_v2_rec flc4_convert_to_old(File_clean_addr l) := transform
self.rec_type_4                     := '4';                     
self.driver_address                 := lib_stringlib.StringLib.StringCleanSpaces( l.driver_street);                   
self.driver_st_city                 := lib_stringlib.StringLib.StringCleanSpaces( l.driver_city);
self.driver_full_name               := StringLib.StringFindReplace(lib_stringlib.StringLib.StringCleanSpaces(l.driver_fname) + ' '+ lib_stringlib.StringLib.StringCleanSpaces(l.driver_mname) + ' '+lib_stringlib.StringLib.StringCleanSpaces(l.driver_lname),'.',' ');  
self.driver_dob                     := lib_stringlib.StringLib.StringFilterOut(l.driver_dob,'/');
/*self.prim_range			            := l.clean_address[1..10];
self.predir				            := l.clean_address[11..12];
self.prim_name				        := l.clean_address[13..40];
self.addr_suffix			        := l.clean_address[41..44];
self.postdir				        := l.clean_address[45..46];
self.unit_desig			            := l.clean_address[47..56];
self.sec_range				        := l.clean_address[57..64];
self.p_city_name			        := l.clean_address[65..89];
self.v_city_name			        := l.clean_address[90..114];
self.st					            := l.clean_address[115..116];
self.zip					        := l.clean_address[117..121];
self.zip4					        := l.clean_address[122..125];
self.cart					        := l.clean_address[126..129];
self.cr_sort_sz			            := l.clean_address[130];
self.lot					        := l.clean_address[131..134];
self.lot_order				        := l.clean_address[135];
self.dpbc                           := l.clean_address[136..137];
self.chk_digit				        := l.clean_address[138];
self.rec_type				        := l.clean_address[139..140];
self.ace_fips_st				    := l.clean_address[141..142];
self.county                         := l.clean_address[143..145];
self.geo_lat				       := l.clean_address[146..155];
self.geo_long				       := l.clean_address[156..166];
self.msa					       := l.clean_address[167..170];
self.geo_blk				       := l.clean_address[171..177];
self.geo_match				       := l.clean_address[178];
self.err_stat				       := l.clean_address[179..182];*/
self.title			               := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                         := if(l.clean_name <> '',l.clean_name[71..73],'');
self := l;
self                               := [];

end;				

export InFile_FLCrash4_v3 := project(File_Clean_Addr,flc4_convert_to_old(LEFT));



