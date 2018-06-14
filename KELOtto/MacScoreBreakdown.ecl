EXPORT MacScoreBreakdown(inData) := FUNCTIONMACRO

	ScoreBreakDownLayout := RECORD
		INTEGER8 customer_id_; // GCID
		INTEGER8 industry_type_; // SNAP/DSNAP etc..
		STRING Entity_Context_Uid_; // for the entity
		STRING IndicatorType ;// (known risk, velocity, identity, address…)
		STRING IndicatorDescription;// ("Known Risk", "Velocity" etc..)
		INTEGER8 RiskLevel;// (Percentile or Quartile)
		STRING PopulationType;// (Element, Contributory Avg, Customer Avg..)
		INTEGER8 Value;
	END;

	ScoreBreakDownLayout  tScoreBreakDown(inData L, INTEGER C) := TRANSFORM
		SELF.IndicatorType := CHOOSE(C, 'KR','VL','ID','ADDR');
		SELF.IndicatorDescription := CHOOSE(C, 'Known Risk', 'Velocity', 'Identity', 'Address');
		SELF.RiskLevel := RANDOM() % 101;
		SELF.PopulationType := 'Entity';
		SELF.Value := RANDOM() % 201;
	  SELF := L;
	END;

	outData := NORMALIZE(inData, 3, tScoreBreakDown(LEFT, COUNTER));
  RETURN outData;
ENDMACRO;