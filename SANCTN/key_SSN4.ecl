Import Data_Services, doxie_files, doxie,ut;

f_sanctn_party := SANCTN.file_base_party;


slim_SSN := record
string9 SSNUMBER;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;


slim_SSN 		tSANCTN_key(f_sanctn_party L) := transform
filterInvalidChar := stringlib.stringfilterout(stringlib.stringtouppercase(L.SSNUMBER),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-');
self.SSNUMBER := if(filterInvalidChar != '',filterInvalidChar,L.SSN_APPENDED);
self               := L;
end;

dsParty := project(f_sanctn_party, tSANCTN_key(LEFT));
dsParty_srt := SORT(dsParty,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,SSNUMBER);
dsParty_dedup := dedup(dsParty_srt,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,SSNUMBER);
dsParty_filter := dsParty_dedup(SSNUMBER[6..9] != '');

KeyName 			:= 'thor_data400::key::sanctn::';

export key_SSN4 := index(dsParty_filter
													,{STRING4 SSN4 := SSNUMBER[6..9]}
													,{BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}
													,Data_Services.Data_location.Prefix('sanctn')+KeyName +'ssn4_'+doxie.Version_SuperKey);

