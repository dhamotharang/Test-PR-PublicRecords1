/*
One time BWR to expand base file layout for accidents_alpha base.
*/
IMPORT Data_Services, PromoteSupers, FLAccidents_Ecrash;
EXPORT Update_Base_accidents_alpha := FUNCTION

 Lay := RECORD
  Layouts_accidents_alpha;
 END;
				 
 ds_Base := DATASET(Data_Services.foreign_prod+'thor_data400::base::accidents_alpha', Lay, THOR);
				 
 FLAccidents_Ecrash.Layout_eCrash.Accidents_Alpha ExpandBaseLayout(ds_Base L) := TRANSFORM
  SELF := L;
  SELF := [];
 END;																									 
 upd_base_layout := PROJECT(ds_Base, ExpandBaseLayout(LEFT));
		
 PromoteSupers.Mac_SF_BuildProcess(upd_base_layout,'~thor_data400::base::accidents_alpha',buildBase,,,true);
		
 RETURN buildBase;
END;

