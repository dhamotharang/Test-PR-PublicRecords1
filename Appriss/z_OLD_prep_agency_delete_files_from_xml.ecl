//AGENCY DELETE FILES

basename:=cluster_name+'::in::appriss_agency_delete_raw_xml'; // samplebookingexport

rform := RECORD,MAXLENGTH(8000)
STRING maxQueueSID {XPATH('@maxQueueSid')}; //data attribute
STRING agencyKey {XPATH('agencyKey')};  
STRING agencyORI {XPATH('agencyORI')};  
STRING docType {XPATH('documentType')};  
END;

ds_xml := DATASET(basename,rform,XML('subscriber/agencyDelete'));

export prep_agency_delete_files_from_xml := ds_xml;