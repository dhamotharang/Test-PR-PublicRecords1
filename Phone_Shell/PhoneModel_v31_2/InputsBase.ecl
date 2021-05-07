EXPORT InputsBase := MODULE,VIRTUAL
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
