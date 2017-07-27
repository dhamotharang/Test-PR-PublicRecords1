import doxie_files, doxie,ut,sanctn_mari,Data_Services,Lib_stringlib;				 
									 
f_sanctn_party := SANCTN_Mari.files_SANCTN_DID.party_did(SSN != '');

KeyName 			:= 'thor_data400::key::sanctn::np::';

slim_SSN := record
f_sanctn_party.SSN;
f_sanctn_party.BATCH;
f_sanctn_party.INCIDENT_NUM;
f_sanctn_party.PARTY_NUM;
end;

dsParty := project(f_sanctn_party,transform(slim_SSN,self:=left));
dsParty_dedup := dedup(dsParty,RECORD);
dsParty_filter := dsParty_dedup(ssn[6..9] != '');

export key_SSN4 := index(dsParty_filter
												,{STRING4 SSN4 := SSN[6..9]}
												,{BATCH,INCIDENT_NUM,PARTY_NUM}
												,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::SSN4');



