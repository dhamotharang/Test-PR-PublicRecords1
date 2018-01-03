import doxie, data_services;

//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta(party_type = '' or party_type = 'NOT DEFINED');
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;//All parties
//FL Crash file does not have information pertinent to this layout.  Therefore only passing National records.

xpand_layout := 
record
string1 rec_type_o;
string10 accident_nbr;
string8 accident_date; 			
string2 section_nbr;
ntlFile;
end;

xpand_layout xpdrec(ntlFile L) := transform
self.rec_type_o 			:= '9';
self.accident_nbr 			:= (string10)((unsigned6)L.vehicle_incident_id+1000000000);
self.accident_date 			:= L.loss_date[7..10]+ L.loss_date[1..2]+ L.loss_date[4..5];
self.section_nbr			:= L.vehicle_nbr;
self						:= L;
end;

pntl := project(ntlFile,xpdrec(left)): persist('~thor_data400::persist::ntlcrash9');


export key_Ntlcrash9 := index(pntl,
                              {unsigned6 l_acc_nbr := (integer)accident_nbr},
                              {pntl},
                              data_services.data_location.prefix() + 'thor_data400::key::ntlcrash9_' + doxie.Version_SuperKey);