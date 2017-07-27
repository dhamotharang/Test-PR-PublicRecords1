import risk_indicators;

export Layout_CT1O := RECORD
	 string30 acctno := '';
      STRING30 account := '';
      STRING32 riskwiseid := '';
      STRING1 nameaddrflag := '';
      STRING15 first := '';
      STRING20 last := '';
      STRING50 addr := '';
      STRING30 city := '';
      STRING2 state := '';
      STRING9 zip := '';
      STRING27 reserved := '';
      STRING1 phonserviceflag := '';
      STRING30 cmpy := '';
	 DATASET(risk_indicators.Layout_Billing) Billing;	
END;