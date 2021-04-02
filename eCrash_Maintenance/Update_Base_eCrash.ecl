/*
One time BWR to expand eCrash base file layout
*/
IMPORT Data_Services, RoxieKeyBuild, FLAccidents_Ecrash;

EXPORT Update_Base_eCrash(STRING BuildDate) := FUNCTION

Files_eCrash := FLAccidents_Ecrash.Files_eCrash;
Layout_Basefile := FLAccidents_Ecrash.Layout_Basefile;

	ds_Base := DATASET(Data_Services.foreign_prod+'thor::base::ecrash::qa::ecrash', Layouts_eCrash_Base, THOR);

	Layout_Basefile ExpandBaseLayout(ds_Base L) := TRANSFORM
     SELF := L;
     SELF := [];
  END;												 
	upd_base_layout := PROJECT(ds_Base, ExpandBaseLayout(LEFT));

	deCrashAccidents	:= DISTRIBUTE(upd_base_layout, HASH32(incident_id));
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(deCrashAccidents, Files_eCrash.BASE_ECRASH_PREFIX, Files_eCrash.SUFFIX_BASE_ECRASH, BuildDate, UpdatedeCrashBase, 3, FALSE, TRUE); 

	RETURN UpdatedeCrashBase;
END;
