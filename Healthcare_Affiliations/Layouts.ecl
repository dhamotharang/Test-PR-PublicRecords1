Import IESP, Org_Mast;
EXPORT Layouts := MODULE

	EXPORT BatchSearchBy := RECORD
		INTEGER AcctNo;
		iesp.healthcare_provideraffiliation.t_AffiliationSearchBy;
	END;

	EXPORT RunTimeConfig := RECORD
		INTEGER maxAddressesPerMatch := Healthcare_Affiliations.Constants.maxAddressesPerMatch;
	END;

	EXPORT Batch_in := RECORD
		INTEGER AcctNo := 0;
		STRING EntityID :='';
		STRING EntityIDType :=''; //values['','LNFID','LNPID','']
	END;

	EXPORT MatchRecs := RECORD
		batch_in;
		Org_Mast.Layouts.affiliations_base;
	END;

	EXPORT SearchRecs := RECORD
		batch_in;
		String ID := '';
		String IDType := '';
		String RelationshipType := '';
		String Effectivedate := '';
		String Expiredate := '';
	END;
	
	EXPORT PreResultRecs := RECORD
		INTEGER AcctNo;
		STRING LastFirst;
		iesp.healthcare_provideraffiliation.t_AffiliationSearchResult;
	END;	
	
	EXPORT ResultRecs := RECORD
		INTEGER AcctNo;
		iesp.healthcare_provideraffiliation.t_AffiliationSearchResult;
	END;	

END;