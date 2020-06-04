IMPORT _Control, ut;

EXPORT Copy_Vehicle_Party_Boca_to_Alpha() := FUNCTION

Res_CopyFiles := ut.FN_CopyFiles(Files.VEHICLE_PARTY_SF, 
																 Constants.THORDest,  
																_Control.IPAddress.prod_thor_dali, 
																'', 
																  ,
																Constants.BuildEmailTarget
																);
																
RETURN Res_CopyFiles;

END;