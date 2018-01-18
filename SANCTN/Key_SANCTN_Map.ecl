

import SANCTN,data_services;

tmsid_rec := record
typeof(SANCTN.file_out_incident_cleaned.BATCH_NUMBER) BATCH_NUMBER;
typeof(SANCTN.file_out_incident_cleaned.INCIDENT_NUMBER) INCIDENT_NUMBER;
unsigned6 doc;
unsigned8 __filepos {virtual (fileposition)} := 0;
end;



tmsid_table := dataset([],tmsid_rec);

//export Key_SANCTN_Map := index(tmsid_table,{src,doc,BATCH_NUMBER,INCIDENT_NUMBER,__filepos},data_services.data_location.prefix() + 'thor_data400::key::calbus::qa::doc.accnumber');

export Key_SANCTN_Map := index(tmsid_table,{doc,INCIDENT_NUMBER,BATCH_NUMBER,__filepos},data_services.data_location.prefix() + 'thor_data400::key::sanctn::qa::docref.docref');



