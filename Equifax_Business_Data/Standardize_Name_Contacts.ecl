IMPORT ut, NID, codes, _validate, std, Address;

EXPORT Standardize_Name_Contacts := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes contact names 
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNames(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pPreProcessInput, string pversion) :=	FUNCTION
			
		// -- Mapping Clean contact name 
		Equifax_Business_Data.Layouts.Base_Contacts tMapCleanContactName(pPreProcessInput L) := TRANSFORM
      SELF.global_sid := 28781;			
			SELF.clean_name.fname := L.efx_fstnam;
			SELF.clean_name.lname := L.efx_lastnam;
			SELF								  := L;			
		END;
	
		cleanedStandardizedNames := project(pPreProcessInput, tMapCleanContactName(LEFT)) : INDEPENDENT;
				
		// -- Mapping Clean Person Name - uses NID to clean names
		sendRecs		:= cleanedStandardizedNames(trim(efx_fstnam + efx_lastnam) <> '');
		notSendRecs := cleanedStandardizedNames(trim(efx_fstnam + efx_lastnam) = '');

		NID.Mac_CleanParsedNames(PROJECT(sendRecs, Equifax_Business_Data.Layouts.Base_Contacts) 
																		,NID_output
																		,clean_name.title ,clean_name.fname ,clean_name.mname ,clean_name.lname,,,,,,,,,,true);
																		
		Equifax_Business_Data.Layouts.Base_Contacts tCleanPers(NID_output L) := TRANSFORM
			SELF.clean_name.title		    := L.cln_title;
			SELF.clean_name.fname	      := L.cln_fname;
			SELF.clean_name.mname	      := L.cln_mname;
			SELF.clean_name.lname		    := L.cln_lname;
			SELF							:= L;			
		END;			

    dStandardizedNames := project(NID_output, tCleanPers(LEFT)) + notSendRecs : INDEPENDENT;			
			
		RETURN dStandardizedNames;

	END;  //End fStandardizeNames
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pBaseContactsFile
	            ,STRING pversion
							,STRING pPersistname = Equifax_Business_Data.Persistnames().StandardizeNameContacts
							) := FUNCTION

  	dStandardizeName	:= fStandardizeNames(pBaseContactsFile, pversion)
		: persist(pPersistname, SINGLE)
		;			 
	
		return dStandardizeName;
	
	END;

END;