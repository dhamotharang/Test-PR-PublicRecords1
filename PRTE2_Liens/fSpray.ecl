IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('liensv2__main_','main','liensv2',true),//group's file name on linux box, file name on thor, group name
									prte2.SprayFiles.Spray_Raw_Data('liensv2__party','party','liensv2',true),
									prte2.SprayFiles.Spray_Raw_Data('liensv2_status','status','liensv2',true)
								);
END;