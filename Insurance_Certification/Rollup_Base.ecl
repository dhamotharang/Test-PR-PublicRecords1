IMPORT ut,Insurance_Certification;

EXPORT Rollup_Base :=	module

  /*------------------------------*/
	/* Rollup for Certificaion file */
	/*------------------------------*/
	EXPORT Rollup_Base_Cert(DATASET(Layouts_Certification.Keybuild) pDataset) := FUNCTION

		pDataset_sort	:=	SORT(	pDataset, 
													EXCEPT Date_FirstSeen, Date_lastSeen, DateAdded, DateUpdated, 
													       DartID, ProfileLastUpdated, unique_id ,LOCAL );
   
		Layouts_Certification.Keybuild RollupUpdate(
																Layouts_Certification.Keybuild l, 
																Layouts_Certification.Keybuild r ) := TRANSFORM
		
			SELF.Date_FirstSeen	:= ut.EarliestDate(ut.EarliestDate(L.Date_FirstSeen, R.Date_FirstSeen),
													 	 ut.EarliestDate(L.Date_lastSeen, R.Date_lastSeen));
			SELF.Date_lastSeen	:= max(L.Date_lastSeen,R.Date_lastSeen);
			SELF.DateAdded	    := ut.EarliestDate(ut.EarliestDate(L.DateAdded, R.DateAdded),
														 ut.EarliestDate(L.DateUpdated, R.DateUpdated));
			SELF.DateUpdated  	:= max(L.DateUpdated,R.DateUpdated);
			SELF.ProfileLastUpdated := (string)max((unsigned8)L.ProfileLastUpdated,
																											 (unsigned8)R.ProfileLastUpdated);
			SELF                := L;
		END;
	
		pDataset_rollup := ROLLUP( pDataset_sort, RollupUpdate(LEFT, RIGHT), RECORD, 
														 EXCEPT Date_FirstSeen, Date_lastSeen, DateAdded, DateUpdated,
														 DartID, ProfileLastUpdated, unique_id ,LOCAL);
						 
		RETURN pDataset_rollup;
	END;

  /*------------------------------*/
	/* Rollup for Policy file */
	/*------------------------------*/
	EXPORT Rollup_Base_Pol(DATASET(Layouts_Policy.Keybuild) pDataset) := FUNCTION

		pDataset_sort	:=	SORT(	pDataset, EXCEPT Date_FirstSeen, Date_lastSeen, DartID ,LOCAL );
   
		Layouts_Policy.Keybuild RollupUpdate(
																Layouts_Policy.Keybuild l, 
																Layouts_Policy.Keybuild r ) := TRANSFORM
		
			SELF.Date_FirstSeen	:= ut.EarliestDate(ut.EarliestDate(L.Date_FirstSeen, R.Date_FirstSeen),
														 ut.EarliestDate(L.Date_lastSeen, R.Date_lastSeen));
			SELF.Date_lastSeen	:= max(L.Date_lastSeen,R.Date_lastSeen);
			SELF                := L;
		END;
	
		pDataset_rollup := ROLLUP( pDataset_sort, RollupUpdate(LEFT, RIGHT), RECORD, 
														 EXCEPT Date_FirstSeen, Date_lastSeen, DartID ,LOCAL);
						 
		RETURN pDataset_rollup;
	END;

END;
