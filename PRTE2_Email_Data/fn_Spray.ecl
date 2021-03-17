IMPORT ut, std, prte2;

EXPORT fn_Spray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('emailV2__base','boca','email_data'),
									prte2.SprayFiles.Spray_Raw_Data('emailV2__ins', 'ins','email_data')
									);


END;