IMPORT BatchShare;

EXPORT iParam :=
MODULE

		EXPORT batchParams := interface (BatchShare.IParam.BatchParams)
			EXPORT STRING8 EndDate := RelationshipIdentifier_Services.Constants.Defaults.AsOfDate : STORED('AsOfDate');
			EXPORT BOOLEAN IncludeNeighbor := RelationshipIdentifier_Services.Constants.Defaults.IncludeNeighbor : STORED('IncludeNeighbor');
		END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParams();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))
				EXPORT STRING8 EndDate := RelationshipIdentifier_Services.Constants.Defaults.AsOfDate : STORED('AsOfDate');
				EXPORT BOOLEAN IncludeNeighbor := RelationshipIdentifier_Services.Constants.Defaults.IncludeNeighbor : STORED('IncludeNeighbor');
			END;
			
			RETURN inMod;
		END;
		
		
END;
