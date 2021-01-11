IMPORT fib12010_0;

Inp := MODULE(fib12010_0.InputsBase)
	EXPORT BOOLEAN ReasonCodes := TRUE;
	EXPORT STRING LandingZoneIP := Constants.LandingZoneIP;
	EXPORT STRING InputFileFolder := '/data/LUCI/FIB12010_0/';
	EXPORT STRING InputFileLayout := 'fib12010_0.z_layouts';
	EXPORT STRING InputFileName := 'FIB12010_0_luci_validationfile.csv';
	EXPORT UNSIGNED CSVSprayHeaderLines := 1;
	EXPORT STRING CSVSpraySeparator := '|';
	EXPORT STRING CSVSprayQuote := '\"';
	EXPORT BOOLEAN IsCSVFile := FALSE;
	EXPORT BOOLEAN PreSprayed := FALSE;
	EXPORT STRING SprayedFileName := '';
	EXPORT BOOLEAN Despray := TRUE;
	EXPORT STRING DespraySuffix := '';
	EXPORT BOOLEAN FullDebugOutput := FALSE;
END;

modelRun := fib12010_0.Validate_FIB12010_0(Inp.ReasonCodes,Inp.LandingZoneIP,Inp.InputFileFolder,
                                                Inp.InputFileLayout,Inp.InputFileName,Inp.CSVSprayHeaderLines,
                                                Inp.CSVSpraySeparator,Inp.CSVSprayQuote,Inp.IsCSVFile,Inp.PreSprayed,
                                                Inp.SprayedFileName,Inp.Despray,Inp.DespraySuffix);

modelRun.runValidation;
