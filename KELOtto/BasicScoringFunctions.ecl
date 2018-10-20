/* 
  This needs to be switched to optionally use indexes for roxie queries.
*/

EXPORT BasicScoringFunctions := MODULE
  IMPORT KELOtto;
  EXPORT MacWeightedResult(inData) := FUNCTIONMACRO
    LOCAL Prep := PROJECT(DISTRIBUTE(inData), TRANSFORM({INTEGER1 EntityType, RECORDOF(LEFT)}, 
										 entity_type := LEFT.entity_context_uid_[2..3];
	                   SELF.EntityType := (INTEGER1)entity_type,
  	                 SELF.indicatordescription := MAP(LEFT.indicatordescription != 'unk' => LEFT.indicatordescription, 
                                                   MAP(entity_type = '01' => 'Identity',
                                                   MAP(entity_type = '15' => 'SSN',
                                                   MAP(entity_type = '16' => 'Phone',
                                                   MAP(entity_type = '17' => 'Email',
                                                   MAP(entity_type = '09' => 'Address',
                                                   MAP(entity_type = '18' => 'IP',
                                                   MAP(entity_type = '11' => 'Identity','unk')))))))),
                    
                    SELF.indicatortype :=        MAP(LEFT.indicatortype != 'unk' => LEFT.indicatortype, 
                                                   MAP(entity_type = '01' => 'ID',
                                                   MAP(entity_type = '15' => 'SSN',
                                                   MAP(entity_type = '16' => 'PH',
                                                   MAP(entity_type = '17' => 'EML',
                                                   MAP(entity_type = '09' => 'ADDR',
                                                   MAP(entity_type = '18' => 'IP',
                                                   MAP(entity_type = '11' => 'ID','unk')))))))),
										SELF := LEFT)); 

    LOCAL WeightedResult := JOIN(Prep(Value != ''), KELOtto.BasicScoring.KeyWeightingChart, 
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
                           INTEGER RiskLevel := 0 , populationtype := 'Element', 
                           INTEGER Value := SUM(GROUP, Weight), ValueCurved := (SUM(GROUP, Weight) * 100000) + RANDOM() % 10000
													 #IF(#TEXT(fieldString) != '') ,#EXPAND(fieldString) #END}, 
													 customer_id_, industry_type_, entity_context_uid_, entity_context_uid_[2..3], indicatortype, indicatordescription, 
													 #IF(groupByFieldString AND #TEXT(fieldString) != '') #EXPAND(fieldString), #END
													 MERGE);
    RETURN ScoreBreakdownAggregate;    
  ENDMACRO;
	
	EXPORT ScaleRange(Number, TargetMin, TargetMax, SourceMin, SourceMax) := FUNCTION
		Value := MAP(Number > SourceMax => SourceMax, Number);
		RETURN (UNSIGNED)((TargetMax - TargetMin) * (Value - SourceMin) / (SourceMax - SourceMin) + SourceMin);
		
	END;

  EXPORT MacCalculateScore(inData, fieldString = '', ScoreBreakDownValue = 'Value', groupByFieldString = FALSE, TargetMin = 0, TargetMax = 100, SourceMin = 0, SourceMax = 33) := FUNCTIONMACRO
		LOCAL ScoresPrep := TABLE(inData,
               {customer_id_, industry_type_, entity_context_uid_, 
							 Score := KELOtto.BasicScoringFunctions.ScaleRange(SUM(GROUP, ScoreBreakDownValue), TargetMin, TargetMax, SourceMin, SourceMax), 
							 CurveScore := KELOtto.BasicScoringFunctions.ScaleRange((SUM(GROUP, ScoreBreakDownValue)*1000000) + HASH32(entity_context_uid_) % 1000000, TargetMin, TargetMax, SourceMin, SourceMax)
							 #IF(#TEXT(fieldString) != '') ,#EXPAND(fieldString) #END}, 
							 customer_id_, industry_type_, entity_context_uid_,
							 #IF(groupByFieldString AND #TEXT(fieldString) != '') #EXPAND(fieldString), #END
							 MERGE);             
		RETURN ScoresPrep;
	ENDMACRO;
END;