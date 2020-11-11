IMPORT prte2;

EXPORT fSpray := FUNCTION

return sequential(
									prte2.SprayFiles.Spray_Raw_Data('prte__ecrashv2__prct__base', 'boca', 'ecrashv2'),
									prte2.SprayFiles.Spray_Raw_Data('prte__ecrashv2__ins__base', 'ins', 'ecrashv2'),
									prte2.SprayFiles.Spray_Raw_Data('prte__ecrashv2_agency', 'agency', 'ecrashv2')
									);


END;