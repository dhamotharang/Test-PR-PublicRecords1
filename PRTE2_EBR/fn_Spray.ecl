IMPORT ut, std, prte2;

EXPORT fn_Spray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('EBRKeys__Header__0010_','0010_header','ebr',);
									prte2.SprayFiles.Spray_Raw_Data('EBRKeys__demobdid__5600_','5600_demographic_data','ebr');
									prte2.SprayFiles.Spray_Raw_Data('EBRKeys__demodata__5610_','5610_demographic_data','ebr');
									
								);
END;