﻿EXPORT InputsBase := MODULE,VIRTUAL
	EXPORT BOOLEAN ReasonCodes := TRUE;
	EXPORT STRING LandingZoneIP := rvs2005_0_1.Constants.LandingZoneIP;
	EXPORT STRING InputFileFolder := '/data/LUCI/RVS2005_0_1/';
	EXPORT STRING InputFileLayout := 'rvs2005_0_1.z_layouts';
	EXPORT STRING InputFileName := 'RVS2005_0_1_luci_validationfile.csv';
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
