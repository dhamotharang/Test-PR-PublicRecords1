IMPORT RiskIntelligenceNetwork_Analytics, RiskIntelligenceNetwork_Services;

EXPORT Functions := MODULE

		EXPORT GetRealtimeAssessment(DATASET(RiskIntelligenceNetwork_Services.Layouts.realtime_appends_rec) ds_in) := FUNCTION
					results := FraudgovKELRoxie.RinAssessmentOutput;
					RETURN results;
		END;
		
END;