IMPORT Models, UT, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT FAKE_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, STRING ReasonCodeSet = '') := FUNCTION
	Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	
		FAKE_0_0 := 501;
		
		reasonCodes := CASE(StringLib.StringToUpperCase(TRIM(ReasonCodeSet)),
											'RV50' => DATASET([{'F00'}, {'C12'}, {'A51'}, {'A45'}, {'00'}, {'00'}], {STRING4 HRI}),
																DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}, {'00'}], {STRING4 HRI}));
	
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)FAKE_0_0;
		SELF.seq := le.seq;
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;