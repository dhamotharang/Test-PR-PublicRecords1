IMPORT AID, ut, NID, codes, Address, _validate, std;

EXPORT ThorPatch_DatesSeen_County := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes company names and phone numbers
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNamesPhone(DATASET(Equifax_Business_Data.Layouts.Base) pPreProcessInput) :=	FUNCTION
			
	newBase := RECORD
		Equifax_Business_Data.Layouts.Base;	
		unsigned4 global_sid := 0;   //this is a unique source ID that will be coming from Orbit.  
																 // The Orbit infrastructure is not available yet.  
																 // In the meantime, when adding the field leave it unpopulated.  
																 // More information will come as the Orbit change moves along.
		unsigned8 record_sid := 0; //this is a source specific unique and persistent record id.  
															 // Same as the persistent record id we have in some datasets.  
															 // In new development using the ingest process, it will be the record id from SALT.  
															 // For CCPA, this field is not required to be populated.  
	END;			
			
		// -- Mapping Clean company name and clean phone numbers
		newBase tMapCleanCompanyName(pPreProcessInput L) := TRANSFORM   
			SELF.EFX_COUNTYNM := IF(STD.STR.FilterOut(L.EFX_COUNTYNM, '0123456789') = '',
			                        EFX_COUNTYNUM_TABLE.COUNTYNUM(ut.CleanSpacesAndUpper(L.EFX_COUNTYNM), ut.CleanSpacesAndUpper(L.EFX_STATE)),L.EFX_COUNTYNM);
			SELF.EFX_COUNTY := IF(
			                      STD.STR.FilterOut(L.EFX_COUNTYNM, '0123456789') = '',L.EFX_COUNTYNM
														,EFX_COUNTYNAME_TABLE.COUNTYNAME(ut.CleanSpacesAndUpper(L.EFX_STATE), ut.CleanSpacesAndUpper(L.EFX_COUNTYNM), ut.CleanSpacesAndUpper(L.EFX_COUNTY)));	
			date_first_seen := ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.Record_Update_Refresh_Date);
 		 	SELF.dt_first_seen											:= IF(_validate.date.fIsValid(date_first_seen) and _validate.date.fIsValid(date_first_seen,_validate.date.rules.DateInPast)	,(UNSIGNED4)date_first_seen, 0);
			SELF.dt_last_seen												:= IF(_validate.date.fIsValid(date_first_seen) and _validate.date.fIsValid(date_first_seen,_validate.date.rules.DateInPast)	,(UNSIGNED4)date_first_seen, 0);
      SELF.record_sid := L.rcid;
			SELF								  := L;			
		END;
	
		dStandardizedNames := project(pPreProcessInput, tMapCleanCompanyName(LEFT)) : INDEPENDENT;
			
		RETURN dStandardizedNames;

	END;  //End fStandardizeNamesPhone
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Equifax_Business_Data.Layouts.Base) pBaseFile	
							,STRING pPersistname = 'thor_data400::base::equifax_business_data::thor::patch::cleanedAddresses') := FUNCTION

  	dStandardizeName	:= fStandardizeNamesPhone(pBaseFile);			 
								 
		RETURN dStandardizeName;
	
	END;

END;