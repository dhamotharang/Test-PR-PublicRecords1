import Address,lib_stringlib,FLAccidents;

flc9_v4_in := dataset('~thor_data400::sprayed::flcrash9'
						,FLAccidents.Layout_FLCrash9_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));

BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

clean_addr := record
//string182 clean_address;
string73  clean_name;
FLAccidents.Layout_FLCrash9_v4;
end;

clean_addr trcleanaddr(flc9_v4_in le) := transform
//self.clean_address := if(le.witness_street <> '' and StringLib.StringCleanSpaces(regexreplace('0',le.witness_zip,'')) <> '',Address.CleanAddress182(StringLib.StringCleanSpaces(le.witness_street),StringLib.StringCleanSpaces(le.witness_city+ ', '+le.witness_state + '  '+ le.witness_zip)),'');
tmpfirstname		:= REGEXREPLACE(BadNameFilter,le.witness_fname,'');
tmplastname			:= REGEXREPLACE(BadNameFilter,le.witness_lname,'');
tmpmiddlename		:= REGEXREPLACE(BadNameFilter,le.witness_mname,'');
self.clean_name := if(tmplastname <> '',Address.CleanPersonFML73(StringLib.StringFindReplace(StringLib.StringCleanSpaces(tmpfirstname+' '+ tmpmiddlename +' '+tmplastname),'.',' ')),'');
self := le;
end;

File_clean_addr := project(flc9_v4_in,trcleanaddr(LEFT));	

flc9_v4_rec := FLAccidents.Layout_FLCrash9;

flc9_v4_rec flc9_convert(File_clean_addr l) := transform
self.rec_type_9          := '9';
self.witness_full_name   := StringLib.StringCleanSpaces(StringLib.StringFindReplace(l.witness_fname+ ' '+l.witness_mname+' '+ l.witness_lname,'.',' '));
self.witness_address		 := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter, l.witness_street, ''));
self.witness_st_city     := StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.witness_city, ''));
self.witness_state			 := StringLib.StringCleanSpaces(l.witness_state);
self.witness_zip         := map(trim(l.witness_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.witness_zip,left,right)) = true => l.witness_zip[1..5],
																regexfind('[1-9]',trim(l.witness_zip,left,right)) = false => '',l.witness_zip);
self.title			         := if(l.clean_name <> '',l.clean_name[1..5],'');
self.fname				       := if(l.clean_name <> '',l.clean_name[6..25],'');
self.mname				       := if(l.clean_name <> '',l.clean_name[26..45],'');
self.lname				       := if(l.clean_name <> '',l.clean_name[46..65],'');
self.suffix	             := if(l.clean_name <> '',l.clean_name[66..70],'');
self.score               := if(l.clean_name <> '',l.clean_name[71..73],'');
self 										 := l;
self                     := [];
end;

export InFile_FLCrash9_v4 := project(File_clean_addr,flc9_convert(left));