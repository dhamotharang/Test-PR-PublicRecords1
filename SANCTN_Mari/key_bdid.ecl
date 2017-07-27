import doxie_files, doxie,ut,Data_Services;


f_sanctn := SANCTN_Mari.files_SANCTN_DID.party_did(BDID != 0);

KeyName 			:= 'thor_data400::key::sanctn::np::';

slim_sanctn := record
f_sanctn.BDID;
f_sanctn.BATCH;
f_sanctn.INCIDENT_NUM;
f_sanctn.PARTY_NUM;
end;

tbl_bdid := table(f_sanctn,slim_sanctn,BDID,BATCH,INCIDENT_NUM,PARTY_NUM,few);

export key_BDID := index(tbl_BDID
                               ,{BDID}
															 ,{BATCH,INCIDENT_NUM,PARTY_NUM}
                               ,Data_Services.Data_Location.Prefix('sanctn')+ keyname + doxie.Version_SuperKey +'::BDID');


