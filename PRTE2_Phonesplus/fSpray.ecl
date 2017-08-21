IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('phonesplus__*_archive','boca::hist','phonesplusv2',true),//group's file name on linux box, file name on thor, group name
									prte2.SprayFiles.Spray_Raw_Data('prte__phonesplus__base','boca::ge','phonesplusv2',true)
								);
END;