IMPORT ut, std, prte2;


EXPORT fn_Spray_Files := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('search','search','proflic_mari'),
									prte2.SprayFiles.Spray_Raw_Data('Disciplinary_Actions','disciplinary_actions','proflic_mari'),
									prte2.SprayFiles.Spray_Raw_Data('individual_detail','individual_detail','proflic_mari'),
									prte2.SprayFiles.Spray_Raw_Data('regulatory_actions','regulatory_actions','proflic_mari')
								);
END;


