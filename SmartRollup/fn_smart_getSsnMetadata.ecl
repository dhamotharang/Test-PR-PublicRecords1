IMPORT doxie,iesp,risk_indicators,personReports;

EXPORT fn_smart_getSsnMetadata(UNSIGNED6 did,STRING9 ssn,STRING1 valid,BOOLEAN includeHRI) := FUNCTION

	maxHriPer_Value := personReports.layouts.max_hri;
	ssnDidRecs := DATASET([{ssn,did,valid,0,0,0,'',DATASET([],risk_indicators.layout_desc)}],personReports.layouts.ssn_hri_rec);
	doxie.mac_AddHRISSN(ssnDidRecs,ssnInfoMetadata,FALSE);

	ssnInfoMetadatESDL := PROJECT(ssnInfoMetadata,TRANSFORM(iesp.share.t_SSNInfoEx,
		SELF.SSN := LEFT.SSN,
		SELF.Valid := LEFT.valid_ssn,
		SELF.IssuedLocation := LEFT.ssn_issue_place,
		SELF.IssuedStartDate := iesp.ECL2ESP.toDateYM(LEFT.ssn_issue_early),
		SELF.IssuedEndDate := iesp.ECL2ESP.toDateYM(LEFT.ssn_issue_last),
		SELF.HighRiskIndicators := IF(includeHRI,PROJECT(LEFT.HRI_SSN,TRANSFORM(iesp.share.t_RiskIndicator,
			SELF.RiskCode := LEFT.hri,
			SELF.Description := LEFT.desc)))
		));
	// OUTPUT(ssnInfoMetadata);
	RETURN ssnInfoMetadatESDL;
END;