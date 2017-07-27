IMPORT iesp;

EXPORT IParams := MODULE

	EXPORT relationshipParams := INTERFACE
		EXPORT BOOLEAN   relationship_highConfidenceRelatives := FALSE;
		EXPORT BOOLEAN   relationship_highConfidenceAssociates := FALSE;
		EXPORT UNSIGNED2 relationship_relLookbackMonths := 0;
		EXPORT STRING24  relationship_transAssocMask := '';
  END;

	EXPORT storeHighConfidence(STRING32 AppTyp) := FUNCTION
		BOOLEAN isAppTypKBA := StringLib.StringContains(AppTyp,'KBA',TRUE);
		#STORED('relationship_highConfidenceRelatives' ,isAppTypKBA);
		#STORED('relationship_highConfidenceAssociates',isAppTypKBA);
		RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), EXTEND);
	END;
	
	EXPORT storeParams(iesp.share.t_RelationshipOption relationship,STRING32 AppTyp='') := FUNCTION
		BOOLEAN isAppTypKBA := StringLib.StringContains(AppTyp,'KBA',TRUE);
		BOOLEAN HighConfidenceRelatives  := IF(isAppTypKBA,TRUE,relationship.HighConfidenceRelatives);
		BOOLEAN HighConfidenceAssociates := IF(isAppTypKBA,TRUE,relationship.HighConfidenceAssociates);
		#STORED('relationship_highConfidenceRelatives' ,HighConfidenceRelatives);
		#STORED('relationship_highConfidenceAssociates',HighConfidenceAssociates);
		#STORED('relationship_relLookbackMonths'       ,relationship.RelativeLookBackMonths);
		#STORED('relationship_transAssocMask'          ,relationship.TransactionalAssociatesMask);
		RETURN OUTPUT (DATASET ([],{INTEGER x}), NAMED('__internal__'), EXTEND);
	END;

	EXPORT getParams(
		inModule='MODULE(Relationship.IParams.relationshipParams) END',
		inInterface='Relationship.IParams.relationshipParams') := FUNCTIONMACRO
		outModule:=MODULE(PROJECT(inModule,inInterface,OPT))
			EXPORT BOOLEAN   relationship_highConfidenceRelatives  := FALSE : STORED('relationship_highConfidenceRelatives');
			EXPORT BOOLEAN   relationship_highConfidenceAssociates := FALSE : STORED('relationship_highConfidenceAssociates');
			EXPORT UNSIGNED2 relationship_relLookbackMonths        := 0     : STORED('relationship_relLookbackMonths');
			EXPORT STRING24  relationship_transAssocMask           := ''    : STORED('relationship_transAssocMask');
		END;
		RETURN outModule;
	ENDMACRO;

END;