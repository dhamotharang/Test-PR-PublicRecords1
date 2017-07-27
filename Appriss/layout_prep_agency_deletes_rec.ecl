export layout_prep_agency_deletes_rec := RECORD,MAXLENGTH(8000)
STRING maxQueueSID ;//{XPATH('@maxQueueSid')}; //data attribute
STRING agencyKey ;//{XPATH('agencyKey')};  
STRING agencyORI;//  {XPATH('agencyORI')};  
STRING docType;//  {XPATH('documentType')};  
END;