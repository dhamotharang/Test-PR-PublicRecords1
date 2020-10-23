/*
One time BWR to expand base file layout father version with new field is_Suppressed.
*/
IMPORT Data_Services, PromoteSupers, FLAccidents_Ecrash;
EXPORT Update_Base_isSuppressed := FUNCTION

  ds_Base := DATASET(Data_Services.foreign_prod+'thor_data400::base::ecrash', Layouts_eCrash_Base, THOR);


	FLAccidents_Ecrash.Layout_Basefile ExpandBaseLayout(ds_Base L) := TRANSFORM
																																			SELF.is_Suppressed := '0';
																																			SELF := L;
																																		END;
												 
	upd_base_layout := PROJECT(ds_Base, ExpandBaseLayout(LEFT));

	PromoteSupers.Mac_SF_BuildProcess(upd_base_layout,'~thor_data400::base::ecrash',buildBase,,,true);

	RETURN buildBase;
END;