IMPORT Business_Risk_BIP, Models, Risk_Indicators;

EXPORT FAKE_1_0(GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell, STRING ReasonCodeSet = '') := 
	FUNCTION
	
		Models.Layout_ModelOut doModel(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		
			reasonCodes := CASE(StringLib.StringToUpperCase(TRIM(ReasonCodeSet)),
												'BR' => DATASET([{'B040'}, {'BF113'}, {'P524'}, {'P539'}, {'00'}, {'00'}], {STRING4 HRI}),
																	DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}, {'00'}], {STRING4 HRI}));
			SELF.seq   := le.seq;
			SELF.score := '501';		
			SELF.ri := 
				PROJECT(
					reasonCodes, 
					TRANSFORM( Risk_Indicators.Layout_Desc,
							SELF.hri := LEFT.hri,
							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
					));
		END;

		model := PROJECT(busShell, doModel(LEFT));

		RETURN(model);
	END;
