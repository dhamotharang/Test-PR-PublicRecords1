EXPORT BasicScoringFunctions := MODULE
  EXPORT MacWeightedResult(inData) := FUNCTIONMACRO
  IMPORT FraudGovPlatform;
    LOCAL Prep := PROJECT(DISTRIBUTE(inData), TRANSFORM({INTEGER1 EntityType, RECORDOF(LEFT)}, 
			entity_type := LEFT.entity_context_uid_[2..3];
			SELF.EntityType := (INTEGER1)entity_type,
			SELF.indicatordescription := IF(LEFT.indicatordescription != FraudGovPlatform_Analytics.Constants.KelEntityDescription.UNK, LEFT.indicatordescription, 
				CASE(entity_type, 
						FraudGovPlatform_Analytics.Constants.KelEntityType.LEXID => FraudGovPlatform_Analytics.Constants.KelEntityDescription.LEXID,
						FraudGovPlatform_Analytics.Constants.KelEntityType.SSN => FraudGovPlatform_Analytics.Constants.KelEntityDescription.SSN,
						FraudGovPlatform_Analytics.Constants.KelEntityType.PHONENO => FraudGovPlatform_Analytics.Constants.KelEntityDescription.PHONENO,
						FraudGovPlatform_Analytics.Constants.KelEntityType.EMAIL => FraudGovPlatform_Analytics.Constants.KelEntityDescription.EMAIL,
						FraudGovPlatform_Analytics.Constants.KelEntityType.PHYSICAL_ADDRESS => FraudGovPlatform_Analytics.Constants.KelEntityDescription.PHYSICAL_ADDRESS,
						FraudGovPlatform_Analytics.Constants.KelEntityType.IPADDRESS => FraudGovPlatform_Analytics.Constants.KelEntityDescription.IPADDRESS,
						FraudGovPlatform_Analytics.Constants.KelEntityType.EVENT => FraudGovPlatform_Analytics.Constants.KelEntityDescription.EVENT,
						FraudGovPlatform_Analytics.Constants.KelEntityDescription.UNK)),
			SELF.indicatortype := IF(LEFT.indicatortype != FraudGovPlatform_Analytics.Constants.KelEntityTypeName.UNK, LEFT.indicatortype,  
				CASE(entity_type, 
						FraudGovPlatform_Analytics.Constants.KelEntityType.LEXID => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.LEXID,
						FraudGovPlatform_Analytics.Constants.KelEntityType.SSN => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.SSN,
						FraudGovPlatform_Analytics.Constants.KelEntityType.PHONENO => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.PHONENO,
						FraudGovPlatform_Analytics.Constants.KelEntityType.EMAIL => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.EMAIL,
						FraudGovPlatform_Analytics.Constants.KelEntityType.PHYSICAL_ADDRESS => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.PHYSICAL_ADDRESS,
						FraudGovPlatform_Analytics.Constants.KelEntityType.IPADDRESS => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.IPADDRESS,
						FraudGovPlatform_Analytics.Constants.KelEntityType.EVENT => FraudGovPlatform_Analytics.Constants.KelEntityTypeName.EVENT,
						FraudGovPlatform_Analytics.Constants.KelEntityDescription.UNK)),
			SELF := LEFT)); 

    LOCAL WeightedResult := JOIN(Prep(Value != ''), FraudGovPlatform.Key_WeightingChart, 
			KEYED(LEFT.Field=RIGHT.Field AND (INTEGER)LEFT.EntityType = RIGHT.EntityType) AND
			(
			 (
				 RIGHT.Value != '' AND LEFT.Value = RIGHT.Value
			 )
			 OR
			 (
				 RIGHT.Value = '' AND (RIGHT.Low = 0 AND RIGHT.High = 0) 
			 )                           
			 OR
			 (
				 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
					 (
						 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
						 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
					 )
			 )
			), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight}, 
				SELF.Weight := RIGHT.Weight, 
				SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
				SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => RIGHT.UiDescription, LEFT.Label);
				SELF.field := LEFT.field +
					MAP(TRIM(RIGHT.Value) != '' =>  '_' + RIGHT.Value, MAP(RIGHT.Low > 0 => '_' + (STRING)RIGHT.Low, '') + MAP(RIGHT.High > 0 => '_' + (STRING)RIGHT.High, ''));
				SELF := LEFT), LOOKUP, LEFT OUTER);
		RETURN WeightedResult;
  ENDMACRO;
  
  EXPORT MacScoreBreakdownAggregate(inData, fieldString = '', groupByFieldString = FALSE) := FUNCTIONMACRO
    LOCAL ScoreBreakdownAggregate := TABLE(inData(customer_id_>0), 
		{customer_id_, industry_type_, entity_context_uid_, INTEGER entity_type_ := (INTEGER)entity_context_uid_[2..3], indicatortype, indicatordescription, 
			INTEGER RiskLevel := 0 , 
			STRING populationtype := FraudGovPlatform_Analytics.Constants.KelScorePopulationType.ELEMENT, 
			INTEGER Value := SUM(GROUP, Weight), 
			INTEGER ValueCurved := (SUM(GROUP, Weight) * 100000) + RANDOM() % 10000
			#IF(#TEXT(fieldString) != '') ,#EXPAND(fieldString) #END}, 
			customer_id_, industry_type_, entity_context_uid_, entity_context_uid_[2..3], indicatortype, indicatordescription, 
			#IF(groupByFieldString AND #TEXT(fieldString) != '') #EXPAND(fieldString), #END
		MERGE);
		
		//HardCoded until we implement a more robust average
		LOCAL AverageScoreBreakdown := TABLE(inData(customer_id_>0), 
		{customer_id_, industry_type_, entity_context_uid_, INTEGER entity_type_ := (INTEGER)entity_context_uid_[2..3], indicatortype, indicatordescription, 
			INTEGER RiskLevel := 0 , 
			STRING populationtype := FraudGovPlatform_Analytics.Constants.KelScorePopulationType.AVERAGE, 
			INTEGER Value := FraudGovPlatform_Analytics.Constants.RealtimeScoringAverage, 
			INTEGER ValueCurved := (FraudGovPlatform_Analytics.Constants.RealtimeScoringAverage * 100000) + RANDOM() % 10000
			#IF(#TEXT(fieldString) != '') ,#EXPAND(fieldString) #END}, 
			customer_id_, industry_type_, entity_context_uid_, entity_context_uid_[2..3], indicatortype, indicatordescription, 
			#IF(groupByFieldString AND #TEXT(fieldString) != '') #EXPAND(fieldString), #END
		MERGE); 
		
    RETURN ScoreBreakdownAggregate + AverageScoreBreakdown;    
  ENDMACRO;
	
	EXPORT ScaleRange(Number, TargetMin, TargetMax, SourceMin, SourceMax) := FUNCTION
		Value := MAP(Number > SourceMax => SourceMax, Number);
		RETURN (UNSIGNED)((TargetMax - TargetMin) * (Value - SourceMin) / (SourceMax - SourceMin) + SourceMin);	
	END;

  EXPORT MacCalculateScore(inData, fieldString = '', ScoreBreakDownValue = 'Value', groupByFieldString = FALSE, TargetMin = 0, TargetMax = 100, SourceMin = 0, SourceMax = 33) := FUNCTIONMACRO
		LOCAL ScoresPrep := TABLE(inData,
			{customer_id_, industry_type_, entity_context_uid_, 
			Score := FraudGovPlatform_Analytics.BasicScoringFunctions.ScaleRange(SUM(GROUP, ScoreBreakDownValue), TargetMin, TargetMax, SourceMin, SourceMax), 
			CurveScore := FraudGovPlatform_Analytics.BasicScoringFunctions.ScaleRange((SUM(GROUP, ScoreBreakDownValue)*1000000) + HASH32(entity_context_uid_) % 1000000, TargetMin, TargetMax, SourceMin, SourceMax)
			#IF(#TEXT(fieldString) != '') ,#EXPAND(fieldString) #END}, 
			customer_id_, industry_type_, entity_context_uid_,
			#IF(groupByFieldString AND #TEXT(fieldString) != '') #EXPAND(fieldString), #END
			MERGE);             
		RETURN ScoresPrep;
	ENDMACRO;
END;