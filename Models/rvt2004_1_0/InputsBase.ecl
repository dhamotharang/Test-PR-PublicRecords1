EXPORT InputsBase := MODULE,VIRTUAL
	EXPORT BOOLEAN ReasonCodes := TRUE;
	EXPORT STRING LandingZoneIP := '10.173.10.159';
	EXPORT STRING InputFileFolder := '/var/lib/HPCCSystems/mydropzone/LUCI/';
	EXPORT STRING InputFileLayout := 'rvt2004_1_0.z_layouts';
	EXPORT STRING InputFileName := 'RVT2004_1_0_luci_validationfile.csv';
	EXPORT UNSIGNED CSVSprayHeaderLines := 1;
	EXPORT STRING CSVSpraySeparator := '|';
	EXPORT STRING CSVSprayQuote := '\"';
	EXPORT BOOLEAN IsCSVFile := FALSE;
	EXPORT BOOLEAN PreSprayed := TRUE;
	EXPORT STRING SprayedFileName := '~fazetu01::rvt2004_1_0-validation-data.csv_thor';
	EXPORT BOOLEAN Despray := TRUE;
	EXPORT STRING DespraySuffix := WORKUNIT;
	EXPORT BOOLEAN FullDebugOutput := FALSE;
END;
