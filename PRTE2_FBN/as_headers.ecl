import FBNV2;

Export as_headers := module
 
EXPORT new_business_linking := FBNV2.fFBNV2_As_Business_Linking(files.contact_base_1 (DID>0) ,files.business_base_1 (BDID>0),true); 

EXPORT new_business_header := FBNV2.fFBNV2_As_Business_Header(files.business_base_1 (BDID>0 and tmsid[1..3] not in ['ACU']),true); 

EXPORT new_business_contact := FBNV2.fFBNV2_As_Business_contact(files.contact_base_1 (DID>0 and tmsid[1..3] not in ['ACU']),files.business_base_1 (BDID>0 and tmsid[1..3] not in ['ACU']), true); 


End;
