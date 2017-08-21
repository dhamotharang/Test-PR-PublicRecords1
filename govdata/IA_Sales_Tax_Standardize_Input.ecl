IMPORT Address, Ut, lib_stringlib, _Control, _Validate;

EXPORT IA_Sales_Tax_Standardize_Input :=
MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess(DATASET(govdata.Layout_IA_Sales_Tax_Sprayed) pRawFileInput) := FUNCTION
	
		govdata.Layout_IA_Sales_Tax_Sprayed tPreProcessIndividuals(govdata.Layout_IA_Sales_Tax_Sprayed l) := TRANSFORM
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Date for validation
			//////////////////////////////////////////////////////////////////////////////////////
      // strip_issue_date := REGEXREPLACE('\\-',                                             //Remove the hyphens
                                       // REGEXREPLACE('\\-(\\d$)',                          //Add a leading zero to the day if single digit
                                                    // REGEXREPLACE('\\-(\\d\\-)',           //Add a leading zero to the month if single digit
                                                                 // TRIM(l.issue_date,LEFT,RIGHT),
                                                                 // '\\-0$1'),
                                                    // '\\-0$1'),
                                       // '');
       
       //Remove the hyphens and add a leading zero to the day or month if single digit
      strip_issue_date := govdata.Date_Standard.YYYYMMDD(TRIM(l.issue_date,LEFT,RIGHT), 'YYYY-M-D');
       
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////																																												 
                                         
			SELF.permit_nbr       									:= TRIM(l.permit_nbr,LEFT,RIGHT);
			SELF.issue_date 												:= IF(_validate.date.fIsValid(strip_issue_date),strip_issue_date, l.issue_date);
			SELF.owner_name													:= ut.CleanSpacesAndUpper(l.owner_name);
			SELF.business_name											:= ut.CleanSpacesAndUpper(l.business_name);
			SELF.city_mailing_address								:= ut.CleanSpacesAndUpper(l.city_mailing_address);
			SELF.mailing_address								    := ut.CleanSpacesAndUpper(l.mailing_address);
			SELF.state_mailing_address						  := ut.CleanSpacesAndUpper(l.state_mailing_address);
			SELF.mailing_zip_code     						  := ut.CleanSpacesAndUpper(l.mailing_zip_code);
			SELF.location_address     						  := ut.CleanSpacesAndUpper(l.location_address);
			SELF.city_of_location     						  := ut.CleanSpacesAndUpper(l.city_of_location);
			SELF.state_of_location    						  := ut.CleanSpacesAndUpper(l.state_of_location);
			SELF.location_zip_code    						  := ut.CleanSpacesAndUpper(l.location_zip_code);
			SELF 																		:= l;
			SELF 																		:= [];
			
		END;
		
		dPreProcess := PROJECT(pRawFileInput, tPreProcessIndividuals(left));
	
    // -- project the sprayed file in to the base layout
	  govdata.Layout_IA_SalesTax_Base Make_Base_Layout(RECORDOF(dPreProcess) L) := TRANSFORM
      SELF := L;
      SELF := [];
    END;

    dsIASalesTx_pre_base := PROJECT(dPreProcess, Make_Base_Layout(LEFT));

 		RETURN dsIASalesTx_pre_base;

	END;
	//////////////////////////////////////////////////////////////////////////////////////
	// -- END fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll(DATASET(govdata.Layout_IA_Sales_Tax_Sprayed)	pRawFileInput
							,STRING														            pPersistname = '~thor_data400::in::ia::persist::sales_tax::standardize_input'             
	) :=
	FUNCTION
	
		dPreprocess					:= fPreProcess(pRawFileInput) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;