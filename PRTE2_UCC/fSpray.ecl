IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION
	RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('UCCV2__Main__base','main','UCC',true),//group's file name on linux box, file name on thor, group name
									prte2.SprayFiles.Spray_Raw_Data('UCCV2__Party__base','party','UCC',true)
								);
END;