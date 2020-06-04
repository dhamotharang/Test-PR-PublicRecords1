IMPORT _Control, ut;

EXPORT Copy_Vehicle_Main_Boca_to_Alpha() := FUNCTION

Res_CopyFiles := ut.FN_CopyFiles(Files.VEHICLE_MAIN_SF, 
																 Constants.THORDest, 
																 _Control.IPAddress.prod_thor_dali, 
																	'', 
																	  ,
																 Constants.BuildEmailTarget
																																);
																																
RETURN Res_CopyFiles;

END;