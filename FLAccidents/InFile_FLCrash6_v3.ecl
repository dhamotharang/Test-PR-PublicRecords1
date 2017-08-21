import ut,Address,lib_stringlib;

flc6_v2_in := dataset(ut.foreign_prod + '~thor_data400::sprayed::flcrash6'
						,FLAccidents.Layout_FLCrash6_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));



clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash6_v3;
end;

clean_addr trcleanaddr(flc6_v2_in le) := transform
//self.clean_address := if(le.ped_street <> '' and lib_stringlib.StringLib.StringCleanSpaces(regexreplace('0',le.ped_zip,'')) <> '',Address.CleanAddress182(lib_stringlib.StringLib.StringCleanSpaces(le.ped_street),lib_stringlib.StringLib.StringCleanSpaces(le.ped_city)+ ', '+lib_stringlib.StringLib.StringCleanSpaces(le.ped_state) + '  '+ lib_stringlib.StringLib.StringCleanSpaces(le.ped_zip)),'');
self.clean_name := if(le.pedest_last_name <> '',Address.CleanPersonFML73(StringLib.StringFindReplace(lib_stringlib.StringLib.StringCleanSpaces(le.pedest_first_name+' '+ le.pedest_middle_initial +' '+le.pedest_last_name),'.',' ')),'');
self := le;
end;

File_clean_addr := project(flc6_v2_in,trcleanaddr(LEFT));	

flc6_v2_rec := FLAccidents.Layout_FLCrash6_v2;

flc6_v2_rec flc6_convert_to_old(File_clean_addr l) := transform


self.rec_type_6                    := '6';
self.pedest_full_name              := StringLib.StringFindReplace(trim(l.pedest_first_name,left,right) + ' '+trim(l.pedest_middle_initial,left,right) +' '+ trim(l.pedest_last_name,left,right),'.',' ');
self.ped_address                   := lib_stringlib.StringLib.StringCleanSpaces(l.ped_street);
self.ped_st_city                      := lib_stringlib.StringLib.StringCleanSpaces(l.ped_city);
self.ped_zip                       := map( trim(l.ped_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.ped_zip,left,right)) = true => l.ped_zip[1..5],
                                         regexfind('[1-9]',trim(l.ped_zip,left,right)) = false => '',l.ped_zip);
self.ded_dob                       := lib_stringlib.StringLib.StringFilterOut(l.ded_dob,'/');
self.title			               := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				           := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				           := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				           := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	                       := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score                         := if(l.clean_name <> '',l.clean_name[71..73],'');
self := l;
self                               := [];

end;

export InFile_FLCrash6_v3 := project(File_clean_addr,flc6_convert_to_old(left));


                                    
