import Address,lib_stringlib,FLAccidents,STD;

flc5_v2_in := dataset('~thor_data400::sprayed::flcrash5'
						,FLAccidents.Layout_FLCrash5_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
						
BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash5_v4;
end;

clean_addr trcleanaddr(flc5_v2_in le) := transform
//self.clean_address := if(le.passenger_street <> '' and StringLib.StringCleanSpaces(regexreplace('0',le.passenger_zip,'')) <> '',Address.CleanAddress182(StringLib.StringCleanSpaces(le.passenger_street),StringLib.StringCleanSpaces(le.passenger_city+ ', '+le.passenger_state + '  '+ le.passenger_zip)),'');
tmpfirstname		:= REGEXREPLACE(BadNameFilter,le.passenger_firstname,'');
tmplastname			:= REGEXREPLACE(BadNameFilter,le.passenger_lastname,'');
tmpmiddlename		:= REGEXREPLACE(BadNameFilter,le.passenger_middleinitial,'');
self.clean_name := if(tmplastname <> '',Address.CleanPersonFML73(StringLib.StringFindReplace(lib_stringlib.StringLib.StringCleanSpaces(tmpfirstname +' '+ tmpmiddlename +' '+tmplastname),'.',' ')),'');
self := le;
end;

File_clean_addr := project(flc5_v2_in,trcleanaddr(LEFT));	

flc5_v2_rec := FLAccidents.Layout_FLCrash5_v2;

string8 today := StringLib.GetDateYYYYMMDD();

flc5_v2_rec flc5_convert_to_old(File_clean_addr l) := transform
// fSlashedMDYtoYmd(string pDateIn) 
						// :=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
									// +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									// +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
self.rec_type_5                     := '5';
self.section_nbr										:= Intformat((integer)l.section_nbr,2,1);          	 
self.passenger_full_name            := StringLib.StringCleanSpaces(StringLib.StringFindReplace(trim(l.passenger_firstname,left,right) + ' '+trim(l.passenger_middleinitial,left,right) +' '+ trim(l.passenger_lastname,left,right),'.',' '));
self.passenger_address							:= StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter, l.passenger_street, ''));
self.passenger_st_city              := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.passenger_city, ''));
self.passenger_state								:= StringLib.StringCleanSpaces(l.passenger_state);
self.passenger_zip									:= map(trim(l.passenger_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.passenger_zip,left,right)) = true => l.passenger_zip[1..5],
																						regexfind('[1-9]',trim(l.passenger_zip,left,right)) = false => '',l.passenger_zip); 
//clndob															:= StringLib.StringFilterOut(l.passenger_dob,'-');
self.passenger_dob                  := STD.date.ConvertDateFormat( l.passenger_dob, '%Y%m%d','%m/%d/%Y');
currentyr														:= (unsigned4)today[1..4];
dobyr																:= (unsigned4)self.passenger_dob[1..4];
currentmon													:= (unsigned2)today[5..6];
dobmon															:= (unsigned2)self.passenger_dob[5..6];
self.passenger_age									:= IF(trim(l.passenger_dob,left,right) = '','',
																					IF(currentmon < dobmon, (string3)((currentyr-1) - dobyr),(string3)(currentyr - dobyr)));
self.passenger_location							:= map(trim(l.seat_position,left,right) = '1' AND trim(l.row_position,left,right) = '1' => '1',
																						trim(l.seat_position,left,right) = '2' AND trim(l.row_position,left,right) = '1' => '2',
																						trim(l.seat_position,left,right) = '3' AND trim(l.row_position,left,right) = '1' => '3',
																						trim(l.seat_position,left,right) = '1' AND trim(l.row_position,left,right) = '2' => '4',
																						trim(l.seat_position,left,right) = '2' AND trim(l.row_position,left,right) = '2' => '5',
																						trim(l.seat_position,left,right) = '3' AND trim(l.row_position,left,right) = '2' => '6',
																						trim(l.other_position,left,right) = '2' => '7',
																						trim(l.other_position,left,right) = '3' => '7',
																						trim(l.other_position,left,right) = '4' => '7',
																						trim(l.seat_position,left,right) = '88' => '0',
																						trim(l.seat_position,left,right) = '' AND trim(l.other_position,left,right) = '88' => '0',
																						trim(l.seat_position,left,right) = '' AND trim(l.row_position,left,right) = '88' AND trim(l.other_position,left,right) = '' => '0',
																						trim(l.seat_position,left,right) = '' AND trim(l.row_position,left,right) = '' AND trim(l.other_position,left,right) = '' => '0','9');

map_helmet_code											:= map(trim(l.helmet_code,left,right) = '1' => '6',
																						trim(l.helmet_code,left,right) ='2' => '6','0');
map_restraint												:= map(trim(l.restraint_system,left,right) = '1' => '1',
																						trim(l.restraint_system,left,right) = '2' => '1',
																						trim(l.restraint_system,left,right) = '3' => '2',
																						trim(l.restraint_system,left,right) = '4' => '2',
																						trim(l.restraint_system,left,right) = '5' => '2',
																						trim(l.restraint_system,left,right) = '6' => '2',
																						trim(l.restraint_system,left,right) = '7' => '3',
																						trim(l.restraint_system,left,right) = '8' => '3',
																						trim(l.restraint_system,left,right) = '9' => '3',
																						trim(l.restraint_system,left,right) = '10' => '3','0');
map_eye_protection									:= map(trim(l.eye_protection,left,right) = '1' => '7',
																						trim(l.eye_protection,left,right) = '2' => '1', '0'); 
self.first_passenger_safe						:= IF(StringLib.StringCleanSpaces(l.helmet_code) != '',map_helmet_code,
																				IF(StringLib.StringCleanSpaces(l.restraint_system) != '',map_restraint,
																					IF(StringLib.StringCleanSpaces(l.eye_protection) != '',map_eye_protection,'0')));
self.second_passenger_safe					:= IF(StringLib.StringCleanSpaces(l.helmet_code) != '' AND StringLib.StringCleanSpaces(l.restraint_system) != '',map_restraint,
																						IF(StringLib.StringCleanSpaces(l.helmet_code) != '' AND StringLib.StringCleanSpaces(l.restraint_system) = '' ,map_eye_protection,
																							IF(StringLib.StringCleanSpaces(l.helmet_code) = '' AND StringLib.StringCleanSpaces(l.restraint_system) != '' ,map_eye_protection,'0')));    
self.passenger_eject_code						:= map(trim(l.passenger_eject_code,left,right) = '4' => '0',
																						trim(l.passenger_eject_code,left,right) = '88' => '0',
																						trim(l.passenger_eject_code,left,right) = '' => '0',
																						trim(l.passenger_eject_code,left,right));
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
self.title			               := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                         := if(l.clean_name <> '',l.clean_name[71..73],'');
self := l;
self                               := [];
end;							

export InFile_FlCrash5_v4 := project(File_clean_addr,flc5_convert_to_old(left));