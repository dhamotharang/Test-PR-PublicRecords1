IMPORT FLAccidents_Ecrash;

Scrubs_Dataset :=	FLAccidents_Ecrash.Files_MBSAgency.DS_SPRAY_AGENCY;

EXPORT In_eCrash_MBSAgency := Scrubs_Dataset;