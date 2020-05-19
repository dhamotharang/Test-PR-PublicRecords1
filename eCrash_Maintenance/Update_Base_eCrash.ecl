/*
One time BWR to expand eCrash base file layout
*/
IMPORT Data_Services, PromoteSupers, FLAccidents_Ecrash;
EXPORT Update_Base_eCrash := FUNCTION

	ds_Base := DATASET(Data_Services.foreign_prod+'thor_data400::base::ecrash', Layouts_eCrash_Base, THOR);

	FLAccidents_Ecrash.Layout_Basefile ExpandBaseLayout(ds_Base L) := TRANSFORM
     SELF := L;
     SELF := [];
  END;												 
	upd_base_layout := PROJECT(ds_Base, ExpandBaseLayout(LEFT));

	PromoteSupers.Mac_SF_BuildProcess(upd_base_layout,'~thor_data400::base::ecrash',buildBase,,,true);

	RETURN buildBase;
END;

