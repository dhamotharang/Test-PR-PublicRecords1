IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                  prte2.SprayFiles.Spray_Raw_Data('OshairKeys__accident', 'accident', 'oshair'),
									prte2.SprayFiles.Spray_Raw_Data('OshairKeys__inspection', 'inspection', 'oshair'),
									prte2.SprayFiles.Spray_Raw_Data('OshairKeys__violations', 'violations', 'oshair'),
									prte2.SprayFiles.Spray_Raw_Data('OshairKeys__substance', 'substance', 'oshair'),
									prte2.SprayFiles.Spray_Raw_Data('OshairKeys__program', 'program', 'oshair')
									);										

END;