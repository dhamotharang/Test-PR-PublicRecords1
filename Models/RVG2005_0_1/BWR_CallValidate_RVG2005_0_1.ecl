IMPORT RVG2005_0_1;

Inp := MODULE(RVG2005_0_1.InputsBase)
	EXPORT BOOLEAN ReasonCodes := TRUE;
	EXPORT STRING LandingZoneIP := RVG2005_0_1.Constants.LandingZoneIP;
	EXPORT STRING InputFileFolder := '/data/LUCI/RVG2005_0_1/';
	EXPORT STRING InputFileLayout := 'RVG2005_0_1.z_layouts';
	EXPORT STRING InputFileName := 'RVG2005_0_1_luci_validationfile.csv';
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

modelRun := RVG2005_0_1.Validate_RVG2005_0_1(Inp.ReasonCodes,Inp.LandingZoneIP,Inp.InputFileFolder,
                                                Inp.InputFileLayout,Inp.InputFileName,Inp.CSVSprayHeaderLines,
                                                Inp.CSVSpraySeparator,Inp.CSVSprayQuote,Inp.IsCSVFile,Inp.PreSprayed,
                                                Inp.SprayedFileName,Inp.Despray,Inp.DespraySuffix);

modelRun.runValidation;
