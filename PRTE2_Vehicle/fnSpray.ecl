IMPORT ut, std, prte2;

EXPORT fnSpray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('VehicleV2__Main_','main','vehicle');
									prte2.SprayFiles.Spray_Raw_Data('VehicleV2__Party_','party','vehicle');
								
								);
END;

