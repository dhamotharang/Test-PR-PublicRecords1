IMPORT ut, PRTE2_FAA_Data, PRTE2_Common;
#workunit('name', 'Boca PRTE2 FAA File Spray');

Files := PRTE2_FAA_Data.Files;
STRING fileVersion := ut.GetDate+'h';
CSVName_aircraft_reg := 'FAA_Base_aircraft_reg20150715.csv';
CSVName_airmen       := 'FAA_Base_airmen20150715.csv';
CSVName_airmen_certs := 'FAA_Base_airmen_certs20150715.csv';

BuildFile_aircraft_reg := PRTE2_FAA_Data.Fn_Spray_And_Build_BaseMain(CSVName_aircraft_reg, fileVersion, Files.aircraft_reg_Name);
BuildFile_airmen       := PRTE2_FAA_Data.Fn_Spray_And_Build_BaseMain(CSVName_airmen, fileVersion, Files.airmen_Name);
BuildFile_airmen_certs := PRTE2_FAA_Data.Fn_Spray_And_Build_BaseMain(CSVName_airmen_certs, fileVersion, Files.airmen_certs_Name);

SEQUENTIAL (BuildFile_aircraft_reg,
            BuildFile_airmen,
						BuildFile_airmen_certs);