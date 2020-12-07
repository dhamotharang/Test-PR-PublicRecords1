IMPORT  _Validate,  tools,  ut, MDR, std, Scrubs_Equifax_Business_Data;

export  Standardize_Input_Contacts :=  MODULE;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- map fields
	// -- do any conversions/validations
	//////////////////////////////////////////////////////////////////////////////////////
EXPORT fPreProcess(DATASET(Equifax_Business_Data.Layouts.Sprayed_Input_Contacts) pRawInput, string pversion) := FUNCTION
	  
		Equifax_Business_Data.Layouts.Base_Contacts standardizeContactInputXrf(Layouts.Sprayed_Input_Contacts L) := TRANSFORM
					date_first_seen := pversion;
					self.rcid                         := 0;					
			    self.source := MDR.sourceTools.src_Equifax_Business_Data;
					self.efx_id := ut.CleanSpacesAndUpper(l.efx_id);
					self.efx_contct := ut.CleanSpacesAndUpper(l.efx_contct);
					temp_titlecd := ut.CleanSpacesAndUpper(l.efx_titlecd);
					self.efx_titlecd := if(Scrubs_Equifax_Business_Data.Functions.fn_verify_title(temp_titlecd) = 1, temp_titlecd, '');
					temp_titledesc := ut.CleanSpacesAndUpper(l.efx_titledesc);
					self.efx_titledesc := if(Scrubs_Equifax_Business_Data.Functions.fn_verify_title_desc(temp_titledesc) = 1, temp_titledesc, '');
					self.efx_lastnam := ut.CleanSpacesAndUpper(l.efx_lastnam);
					self.efx_fstnam := ut.CleanSpacesAndUpper(l.efx_fstnam);
					self.efx_email := ut.CleanSpacesAndUpper(l.efx_email);
					self.efx_date := ut.CleanSpacesAndUpper(l.efx_date);
					SELF.process_date                 := STD.Date.CurrentDate(TRUE);
 		 	    self.dt_first_seen								:= 0;
			    self.dt_last_seen									:= 0;
					self.dt_vendor_first_reported	    := IF(_validate.date.fIsValid(date_first_seen), (UNSIGNED4)date_first_seen[1..8], 0);
					self.dt_vendor_last_reported		  := IF(_validate.date.fIsValid(date_first_seen), (UNSIGNED4)date_first_seen[1..8], 0);
					self.record_type                  := 'C';
					SELF.Exploded_Title_Description := ut.CleanSpacesAndUpper(EFX_TITLE_TABLE.TITLE(L.EFX_TITLECD));
					self															:= l;
					self															:= [];
			end;
			
		dCleanedContactsInput := PROJECT(pRawInput, standardizeContactInputXrf(LEFT));
		
		RETURN dCleanedContactsInput;

	END;

	EXPORT fAll( DATASET(Equifax_Business_Data.Layouts.Sprayed_Input_Contacts) pRawFileInput
							,STRING  pversion
							,STRING  pPersistname = Equifax_Business_Data.Persistnames().StandardizeInputContacts
	           ) := FUNCTION
						 
		dPreprocess	:= fPreProcess(pRawFileInput, pversion)  
		: PERSIST(pPersistname,SINGLE)
		;

		RETURN dPreprocess;
	
	END;

END;
