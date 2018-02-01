IMPORT risk_indicators, STD;

// Bureau Fraud Flags Model
// NOTE: This model will always return a score of 0 and up to one reason code.

EXPORT FP1712_0_0(DATASET(risk_indicators.Layout_Boca_Shell) clam,
                  INTEGER1 num_reasons)
									 := FUNCTION

  models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM

    factact_curr_alert_code := STD.Str.ToUpperCase(le.eqfx_fraudflags.factact_curr_alert_code);
    
    rc1 := MAP(factact_curr_alert_code = 'W' => 'GW',
               factact_curr_alert_code = 'X' => 'GX',
               factact_curr_alert_code = 'Q' => 'GQ',
               factact_curr_alert_code = 'V' => 'GV',
               factact_curr_alert_code = 'N' => 'GN',
                                                '00');
    rc1_desc := Risk_Indicators.getHRIDesc(rc1);
    
    reasons := DATASET([{rc1, rc1_desc}], risk_indicators.Layout_Desc);
    SELF.ri := reasons;
		SELF.score := '0';
    SELF := [];
  END;    
               
  model :=   project(clam, doModel(LEFT) );
	
	RETURN model;
END;