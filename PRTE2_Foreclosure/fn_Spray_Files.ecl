IMPORT ut, std, prte2;


EXPORT fn_Spray_Files := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('foreclosure__base','boca','foreclosure');
									
								);
END;

