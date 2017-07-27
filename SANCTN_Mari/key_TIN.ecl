import doxie_files, doxie,ut,sanctn_mari,Data_Services,Lib_stringlib;				 
									 
f_sanctn_party := SANCTN_Mari.files_SANCTN_DID.party_did(TIN != '');

KeyName 			:= 'thor_data400::key::sanctn::np::';

slim_TIN := record
f_sanctn_party.TIN;
f_sanctn_party.BATCH;
f_sanctn_party.INCIDENT_NUM;
f_sanctn_party.PARTY_NUM;
end;

dsParty := project(f_sanctn_party,transform(slim_TIN, self:=left));
dsParty_dedup := dedup(dsParty,RECORD);

export key_TIN := index(dsParty_dedup
												,{TIN}
												,{BATCH,INCIDENT_NUM,PARTY_NUM}
												,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::TIN');



