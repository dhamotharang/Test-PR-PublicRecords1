
IMPORT doxie,ut;

f := USAA.file_marketing_prospects(did != 0);

EXPORT key_marketing_prospects_did := 
        INDEX(f,{did},{f},'~thor_data400::key::USAA_marketing_prospects_did_'+doxie.Version_SuperKey);
