

IMPORT doxie,ut;

f := USAA.file_direct_marketing(seq != 0);

EXPORT key_direct_marketing_did := 
        INDEX(f,{seq},{f},'~thor_data400::key::USAA_direct_marketing_did_'+doxie.Version_SuperKey);
