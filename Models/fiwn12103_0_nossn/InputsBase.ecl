EXPORT InputsBase := MODULE,VIRTUAL
	EXPORT BOOLEAN ReasonCodes := TRUE;
	EXPORT STRING LandingZoneIP := fiwn12103_0_nossn.Constants.LandingZoneIP;
	EXPORT STRING InputFileFolder := '/data/LUCI/FIWN12103_0_NOSSN/';
	EXPORT STRING InputFileLayout := 'fiwn12103_0_nossn.z_layouts';
	EXPORT STRING InputFileName := 'FIWN12103_0_NOSSN_luci_validationfile.csv';
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
