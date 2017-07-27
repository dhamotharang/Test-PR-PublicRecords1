import doxie_files, doxie,ut,Data_Services;


f_sanctn_party := SANCTN.file_base_party(did != 0);

slim_sanctn := record
f_sanctn_party.DID;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;

tbl_did := table(f_sanctn_party,slim_sanctn,DID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);

KeyName 			:= 'thor_data400::key::sanctn::';

export key_sanctn_DID := index(tbl_DID
                               ,{DID}
															 ,{BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER}
                               ,Data_Services.Data_location.Prefix('sanctn')+KeyName +'did_'+doxie.Version_SuperKey);


