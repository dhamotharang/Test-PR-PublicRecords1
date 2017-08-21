import Address,lib_stringlib,FLAccidents,STD;

flc4_v4_in := dataset('~thor_data400::sprayed::flcrash4'
							,FLAccidents.Layout_FLCrash4_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));							

BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash4_v4;
end;

clean_addr trcleanaddr(flc4_v4_in le) := transform
//self.clean_address := if(le.driver_street <> '',Address.CleanAddress182(StringLib.StringCleanSpaces(le.driver_street),StringLib.StringCleanSpaces(le.driver_city+ ', '+le.driver_resident_state + '  '+ le.driver_zip)),'');
tmpfirstname		:= REGEXREPLACE(BadNameFilter,le.driver_fname,'');
tmplastname			:= REGEXREPLACE(BadNameFilter,le.driver_lname,'');
tmpmiddlename		:= REGEXREPLACE(BadNameFilter,le.driver_mname,'');
self.clean_name := if(StringLib.StringCleanSpaces(tmplastname+tmpfirstname) != '',Address.CleanPersonFML73(StringLib.StringFindReplace(StringLib.StringCleanSpaces(tmpfirstname+' '+ tmpmiddlename+' '+tmplastname),'.',' ')),'');
self 	:= le;
end;

File_clean_addr := project(flc4_v4_in,trcleanaddr(LEFT));
	
integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

flc4_v2_rec := RECORD
	FLAccidents.Layout_FLCrash4_v2;
END;

flc4_v2_rec flc4_convert_to_old(File_clean_addr l) := transform
self.rec_type_4                     := '4';
self.section_nbr	:= Intformat((integer)l.section_nbr,2,1);
//tmpstreet		:= REGEXREPLACE(BadNameFilter, l.driver_street, '');
self.driver_lic_type := IF(trim(l.driver_lic_type,left,right) = '','0',trim(l.driver_lic_type,left,right));
self.driver_address	 :=  StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter, l.driver_street, ''));                    
self.driver_st_city  := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.driver_city, ''));
self.driver_resident_state	:= StringLib.StringCleanSpaces(l.driver_resident_state);
self.driver_zip	:= map(trim(l.driver_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.driver_zip,left,right)) = true => l.driver_zip[1..5],
                       regexfind('[1-9]',trim(l.driver_zip,left,right)) = false => '',l.driver_zip);                    
self.driver_full_name    := StringLib.StringFindReplace(StringLib.StringCleanSpaces(l.driver_fname) + ' '+ StringLib.StringCleanSpaces(l.driver_mname) + ' '+StringLib.StringCleanSpaces(l.driver_lname),'.',' ');  
/*clndriver_dob            := StringLib.StringFindReplace(l.driver_dob,'-','');
string2 month := map(l.driver_dob[3..5] = 'JAN' => '01', 
											l.driver_dob[3..5] = 'FEB' => '02',
											l.driver_dob[3..5] = 'MAR' => '03',
											l.driver_dob[3..5] = 'APR' => '04',
											l.driver_dob[3..5] = 'MAY' => '05',
											l.driver_dob[3..5] = 'JUN' => '06',
											l.driver_dob[3..5] = 'JUL' => '07',
											l.driver_dob[3..5] = 'AUG' => '08',
											l.driver_dob[3..5] = 'SEP' => '09',
											l.driver_dob[3..5] = 'OCT' => '10',
											l.driver_dob[3..5] = 'NOV' => '11',
											l.driver_dob[3..5] = 'DEC' => '12','00');
string4	year := IF((integer)l.driver_dob[6..7] < (current_yy + 30),'20'+ l.driver_dob[6..7],'19'+ l.driver_dob[6..7]);*/
//self.driver_dob                     := year+month+trim(l.driver_dob)[1..2];
self.driver_dob                     := STD.date.ConvertDateFormat( l.driver_dob, '%Y%m%d','%m/%d/%Y');
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
self.first_driver_safety						:= IF(StringLib.StringCleanSpaces(l.helmet_code) != '',map_helmet_code,
																				IF(StringLib.StringCleanSpaces(l.restraint_system) != '',map_restraint,
																					IF(StringLib.StringCleanSpaces(l.eye_protection) != '',map_eye_protection,'00')));
																						
self.second_driver_safety						:= IF(StringLib.StringCleanSpaces(l.helmet_code) != '' AND StringLib.StringCleanSpaces(l.restraint_system) != '',map_restraint,
																						IF(StringLib.StringCleanSpaces(l.helmet_code) != '' AND StringLib.StringCleanSpaces(l.restraint_system) = '' ,map_eye_protection,
																							IF(StringLib.StringCleanSpaces(l.helmet_code) = '' AND StringLib.StringCleanSpaces(l.restraint_system) != '' ,map_eye_protection,'00')));
self.driver_eject_code							:= map(trim(l.driver_eject_code,left,right) = '4' => '0',
																						trim(l.driver_eject_code,left,right) = '88' => '0',
																						trim(l.driver_eject_code,left,right) = '' => '0',
																						trim(l.driver_eject_code,left,right));
self.recommand_reexam	:= IF(trim(l.recommand_reexam,left,right) = '','0',trim(l.recommand_reexam,left,right));
self.driver_physical_defects := IF(trim(l.driver_physical_defects,left,right) = '','0',
																		trim(l.driver_physical_defects,left,right));
self.first_contrib_cause	:= Intformat((integer)l.first_contrib_cause,2,1);
self.second_contrib_cause := Intformat((integer)l.second_contrib_cause,2,1);
self.third_contrib_cause	:= Intformat((integer)l.third_contrib_cause,2,1);
self.req_endorsement := IF(trim(l.req_endorsement,left,right) = '','0',trim(l.req_endorsement,left,right));
self.driver_phone_nbr								:= StringLib.StringFilterOut(l.driver_phone_nbr,'(-)');
																					
self.title			               := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                         := if(l.clean_name <> '',l.clean_name[71..73],'');
self := l;
self                               := [];
end;				

export InFile_FLCrash4_v4 := project(File_Clean_Addr,flc4_convert_to_old(LEFT));