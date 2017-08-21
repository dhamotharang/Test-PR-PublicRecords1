import Address,lib_stringlib,FLAccidents;

flc6_v2_in := dataset('~thor_data400::sprayed::flcrash6'
						,FLAccidents.Layout_FLCrash6_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');


BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash6_v4;
end;

clean_addr trcleanaddr(flc6_v2_in le) := transform
//self.clean_address := if(le.ped_street <> '' and StringLib.StringCleanSpaces(regexreplace('0',le.ped_zip,'')) <> '',Address.CleanAddress182(StringLib.StringCleanSpaces(le.ped_street),StringLib.StringCleanSpaces(le.ped_city+ ', '+le.ped_state + '  '+ le.ped_zip)),'');
tmpfirstname		:= REGEXREPLACE(BadNameFilter,le.pedest_first_name,'');
tmplastname			:= REGEXREPLACE(BadNameFilter,le.pedest_last_name,'');
tmpmiddlename		:= REGEXREPLACE(BadNameFilter,le.pedest_middle_initial,'');
self.clean_name := if(tmplastname <> '',Address.CleanPersonFML73(StringLib.StringFindReplace(StringLib.StringCleanSpaces(tmpfirstname+' '+ tmpmiddlename +' '+tmplastname),'.',' ')),'');
self := le;
end;

File_clean_addr := project(flc6_v2_in,trcleanaddr(LEFT));	

flc6_v2_rec := FLAccidents.Layout_FLCrash6_v2;

flc6_v2_rec flc6_convert_to_old(File_clean_addr l) := transform
self.rec_type_6              := '6';
self.section_nbr						 := Intformat((integer)l.section_nbr,2,1);
self.pedest_full_name        := StringLib.StringCleanSpaces(StringLib.StringFindReplace(trim(l.pedest_first_name,left,right) + ' '+trim(l.pedest_middle_initial,left,right) +' '+ trim(l.pedest_last_name,left,right),'.',' '));
self.ped_address						 := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter, l.ped_street, ''));
self.ped_st_city             := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.ped_city, ''));
self.ped_state							 := StringLib.StringCleanSpaces(l.ped_state);
self.ped_zip                 := map(trim(l.ped_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.ped_zip,left,right)) = true => l.ped_zip[1..5],
                                     regexfind('[1-9]',trim(l.ped_zip,left,right)) = false => '',l.ped_zip);
clnped											 := StringLib.StringFilterOut(l.ped_dob,'-');
self.ded_dob                 := clnped[5..6]+clnped[7..8]+clnped[1..4];
self.ped_bac_test_type			 := IF(trim(l.ped_bac_test_type1,left,right) <> '' and trim(l.ped_bac_test_type1,left,right) <> '77',l.ped_bac_test_type1,
																		IF(trim(l.ped_bac_test_type1,left,right) = '' and trim(l.ped_bac_test_type2,left,right) <> '' and trim(l.ped_bac_test_type2,left,right) <> '77',l.ped_bac_test_type2,
																			IF(trim(l.ped_bac_test_type1,left,right) = '77' OR trim(l.ped_bac_test_type2,left,right) = '77', '0','0')));
self.ped_alco_drugs	:= '0';
self.ped_action							 := map(trim(l.ped_action,left,right) = '1' => '01',
																		trim(l.ped_action,left,right) = '2' => '03',
																		trim(l.ped_action,left,right) = '3' => '04',
																		trim(l.ped_action,left,right) = '4' => '05',
																		trim(l.ped_action,left,right) = '5' => '77',
																		trim(l.ped_action,left,right) = '6' => '08',
																		trim(l.ped_action,left,right) = '7' => '09',
																		trim(l.ped_action,left,right) = '8' => '77',
																		trim(l.ped_action,left,right) = '9' => '07',
																		trim(l.ped_action,left,right) = '10' => '77',
																		trim(l.ped_action,left,right) = '77' => '77','88');
																		
self.ped_first_contrib_cause	:= map(trim(l.ped_first_contrib_cause,left,right) = '2' => '77',
																			trim(l.ped_first_contrib_cause,left,right) = '4' => '20',
																			trim(l.ped_first_contrib_cause,left,right) = '5' => '18',
																			trim(l.ped_first_contrib_cause,left,right) = '6' => '77',
																			trim(l.ped_first_contrib_cause,left,right) = '7' => '77',
																			trim(l.ped_first_contrib_cause,left,right) = '8' => '77',
																			trim(l.ped_first_contrib_cause,left,right) = '9' => '77',
																			trim(l.ped_first_contrib_cause,left,right) = '' => '88',Intformat((integer)l.ped_first_contrib_cause,2,1));
self.ped_second_contrib_cause	:= map(trim(l.ped_second_contrib_cause,left,right) = '2' => '77',
																			trim(l.ped_second_contrib_cause,left,right) = '4' => '20',
																			trim(l.ped_second_contrib_cause,left,right) = '5' => '18',
																			trim(l.ped_second_contrib_cause,left,right) = '6' => '77',
																			trim(l.ped_second_contrib_cause,left,right) = '7' => '77',
																			trim(l.ped_second_contrib_cause,left,right) = '8' => '77',
																			trim(l.ped_second_contrib_cause,left,right) = '9' => '77',
																			trim(l.ped_second_contrib_cause,left,right) = '' => '88',Intformat((integer)l.ped_second_contrib_cause,2,1));
self.ped_third_contrib_cause := '00';
// self.prim_range			            := l.clean_address[1..10];
// self.predir				            := l.clean_address[11..12];
// self.prim_name				        := l.clean_address[13..40];
// self.addr_suffix			        := l.clean_address[41..44];
// self.postdir				        := l.clean_address[45..46];
// self.unit_desig			            := l.clean_address[47..56];
// self.sec_range				        := l.clean_address[57..64];
// self.p_city_name			        := l.clean_address[65..89];
// self.v_city_name			        := l.clean_address[90..114];
// self.st					            := l.clean_address[115..116];
// self.zip					        := l.clean_address[117..121];
// self.zip4					        := l.clean_address[122..125];
// self.cart					        := l.clean_address[126..129];
// self.cr_sort_sz			            := l.clean_address[130];
// self.lot					        := l.clean_address[131..134];
// self.lot_order				        := l.clean_address[135];
// self.dpbc                           := l.clean_address[136..137];
// self.chk_digit				        := l.clean_address[138];
// self.rec_type				        := l.clean_address[139..140];
// self.ace_fips_st				    := l.clean_address[141..142];
// self.county                         := l.clean_address[143..145];
// self.geo_lat				       := l.clean_address[146..155];
// self.geo_long				       := l.clean_address[156..166];
// self.msa					       := l.clean_address[167..170];
// self.geo_blk				       := l.clean_address[171..177];
// self.geo_match				       := l.clean_address[178];
// self.err_stat				       := l.clean_address[179..182];
self.title			             := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                 := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                   := if(l.clean_name <> '',l.clean_name[71..73],'');
self := l;
self                         := [];

end;

export InFile_FLCrash6_v4 := project(File_clean_addr,flc6_convert_to_old(left));