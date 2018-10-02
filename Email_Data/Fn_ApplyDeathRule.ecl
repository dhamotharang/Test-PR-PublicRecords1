IMPORT Email_Data, STD, Header;
#option('multiplePersistInstances',FALSE);

EXPORT Fn_ApplyDeathRule(dataset(recordof(Layout_email.temp_Validate)) email_in) := FUNCTION
		fDeathMaster	:= Header.File_DID_Death_MasterV3_ssa;
	
	//Determine if record meets DOD filter
	Layout_email.temp_Validate DeathInd(email_in L, fDeathMaster R) := TRANSFORM
		tempDeathInd	:= IF(L.DID = (unsigned6)R.DID AND R.DOD8 < '19790101', TRUE,
											IF(L.DID = (unsigned6)R.DID AND R.DOD8 < L.date_first_seen AND R.DOD8 < L.date_vendor_first_reported, TRUE,FALSE));
		SELF.IsDeath	:= tempDeathInd;
		SELF	:= L;
	END;

	jDeathInd	:= JOIN(SORT(DISTRIBUTE(email_in(DID <> 0),HASH(DID)),DID, -process_date, LOCAL),
										SORT(DISTRIBUTE(fDeathMaster((unsigned6)DID <> 0 and (integer)DOD8 <> 0),HASH((unsigned6)DID)),DID,LOCAL),
										LEFT.DID = (unsigned6)RIGHT.DID,
										DeathInd(LEFT,RIGHT),LEFT OUTER, Keep(1), LOCAL);
										
	RETURN	jDeathInd(IsDeath = false);
END;
