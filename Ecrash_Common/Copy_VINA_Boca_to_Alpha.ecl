IMPORT _Control, ut;

EXPORT Copy_VINA_Boca_to_Alpha() := FUNCTION

Res_CopyFiles := ut.FN_CopyFiles(Files.VINA_SF, 
																 Constants.THORDest,  
																_Control.IPAddress.prod_thor_dali, 
																 '', 
																	 ,
																 Constants.BuildEmailTarget
																);
																																
RETURN Res_CopyFiles;

END;
