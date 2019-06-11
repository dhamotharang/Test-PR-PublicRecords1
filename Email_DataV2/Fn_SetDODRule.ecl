IMPORT Email_DataV2, STD, Header, ut;

EXPORT Fn_SetDODRule (DATASET(RECORDOF(Email_DataV2.Layouts.temp_Validate)) email_in) := FUNCTION
		fDeathMaster	:= Header.File_DID_Death_MasterV3_ssa;
		
 //Split files to only capture DID records for join
 email_did 		:= email_in(DID <> 0);
 email_NoDID 	:= email_in(DID = 0);
	
	//Determine if record meets DOD filter
	Layouts.temp_Validate DeathInd(email_in L, fDeathMaster R) := TRANSFORM
		tempDeathInd	:= IF(L.DID = (unsigned6)R.DID AND R.DOD8 < '19790101', TRUE,
											IF(L.DID = (unsigned6)R.DID AND R.DOD8 < L.date_first_seen AND R.DOD8 < L.date_vendor_first_reported, TRUE,FALSE));
		SELF.IsDeath	:= tempDeathInd;
		SELF	:= L;
	END;

	jDeathInd	:= JOIN(SORT(DISTRIBUTE(email_did,HASH(DID)),DID, -process_date, LOCAL),
										SORT(DISTRIBUTE(fDeathMaster((unsigned6)DID <> 0 and (integer)DOD8 <> 0),HASH((unsigned6)DID)),DID,LOCAL),
										LEFT.DID = (unsigned6)RIGHT.DID,
										DeathInd(LEFT,RIGHT),LEFT OUTER, Keep(1), LOCAL);
										
	RETURN	jDeathInd + email_NoDID;
END;