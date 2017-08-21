IMPORT ut, std, prte2;

EXPORT fn_Spray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('email__base','boca','email_data');
									
								);
END;