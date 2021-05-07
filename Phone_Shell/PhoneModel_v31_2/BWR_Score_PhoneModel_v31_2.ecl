IMPORT PhoneModel_v31_2;

Inp := MODULE(PhoneModel_v31_2.InputsBase)
	EXPORT STRING LandingZoneIP := PhoneModel_v31_2.Constants.LandingZoneIP;
	EXPORT STRING InputFileFolder := '/data/LUCI/PhoneModel_v31_2/';
	EXPORT STRING InputFileLayout := 'PhoneModel_v31_2.z_layouts';
	EXPORT STRING InputFileName := 'PhoneModel_v31_2_luci_validationfile.csv';
	EXPORT UNSIGNED CSVSprayHeaderLines := 1;
	EXPORT STRING CSVSpraySeparator := '|';
	EXPORT STRING CSVSprayQuote := '\"';
	EXPORT BOOLEAN IsCSVFile := FALSE;
	EXPORT BOOLEAN PreSprayed := TRUE;
	EXPORT STRING SprayedFileName := '';
	EXPORT BOOLEAN Despray := TRUE;
	EXPORT STRING DespraySuffix := WORKUNIT;
	EXPORT BOOLEAN FullDebugOutput := FALSE;
END;

modelRun := PhoneModel_v31_2.Score_PhoneModel_v31_2(Inp.FullDebugOutput,Inp.LandingZoneIP,Inp.InputFileFolder,
                                                Inp.InputFileLayout,Inp.InputFileName,Inp.CSVSprayHeaderLines,
                                                Inp.CSVSpraySeparator,Inp.CSVSprayQuote,Inp.IsCSVFile,Inp.PreSprayed,
                                                Inp.SprayedFileName,Inp.Despray,Inp.DespraySuffix);

modelRun.runScore;
