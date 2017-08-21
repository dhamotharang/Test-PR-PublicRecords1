IMPORT ut, std, prte2;


EXPORT fSpray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('aircraft_reg','aircraft_reg','faa'),
									prte2.SprayFiles.Spray_Raw_Data('airmen_built','airmen','faa'),
									prte2.SprayFiles.Spray_Raw_Data('airmen_certs','airmen_certs','faa')
								);
END;
