IMPORT Address, Ut, lib_stringlib, _Validate, MDR;

EXPORT Standardize_Input := MODULE
	EXPORT fAssignSeq(DATASET(Experian_FEIN.layouts.Input.sprayed) pRawFileInput, STRING pversion) := FUNCTION

		// Add a unique_id to the input records to use for normalizing FEIN fields	
		Experian_FEIN.layouts.TempRec tAssignSeq(Experian_FEIN.layouts.Input.Sprayed l, UNSIGNED8 cnt) := TRANSFORM
			SELF.unique_id := cnt;
			SELF := L;
		END;

		dAssignSeq := PROJECT(pRawFileInput, tAssignSeq(left,counter));

		// Normalize the raw input records
		Experian_FEIN.layouts.NormRec	tNormalizeRec(Experian_FEIN.layouts.TempRec l, unsigned8 cnt) := TRANSFORM
			SELF.unique_id := l.unique_id;
			SELF.Norm_Type := CHOOSE(
				cnt,
				'1',/*FEIN 1*/
				'2',/*FEIN 2*/
				'3',/*FEIN 3*/
				'4',/*FEIN 4*/
				'5' /*FEIN 5*/
			);

			SELF.Norm_Tax_ID := CHOOSE(
				cnt,
				l.Tax_ID_1,
				l.Tax_ID_2,
				l.Tax_ID_3,
				l.Tax_ID_4,
				l.Tax_ID_5
			);

			SELF.Norm_Confidence_Level := CHOOSE(
				cnt,
				l.Confidence_Level_1,
				l.Confidence_Level_2,
				l.Confidence_Level_3,
				l.Confidence_Level_4,
				l.Confidence_Level_5
			);

			SELF.Norm_Display_Configuration := CHOOSE(
				cnt,
				l.Display_Configuration_1,
				l.Display_Configuration_2,
				l.Display_Configuration_3,
				l.Display_Configuration_4,
				l.Display_Configuration_5
			);

			SELF := L;
		END;

		dNormalize := normalize(dAssignSeq,	5,	tNormalizeRec(left, counter));

		RETURN dNormalize;
	END;

	EXPORT fPreprocess(dataset(Layouts.NormRec) dNormalize, string pversion) := FUNCTION
		Layouts.base tPreProcessRecs(Layouts.NormRec l) := TRANSFORM
			// Prepare Addresses for Cleaning using macro
			addr1 := ut.CleanSpacesAndUpper(l.Business_Address);
			addr2 := stringlib.stringcleanspaces(
				ut.CleanSpacesAndUpper(l.Business_City)
				+ IF (trim(l.Business_City) <> '',', ','')
				+ ut.CleanSpacesAndUpper(l.Business_State)
				+ ' '
				+ ut.CleanSpacesAndUpper(l.Business_Zip)
			);
			// Map Fields
			SELF.prep_addr_line1 := addr1;
			SELF.prep_addr_line_last := addr2;
			SELF.dt_vendor_first_reported := (unsigned4)pversion;
			SELF.dt_vendor_last_reported := (unsigned4)pversion;
			SELF.Business_Identification_Number := trim(l.Business_Identification_Number,left,right);
			SELF.Business_Name := ut.CleanSpacesAndUpper(l.Business_Name);
			SELF.Business_Address := ut.CleanSpacesAndUpper(l.Business_Address);
			SELF.Business_City := ut.CleanSpacesAndUpper(l.Business_City);
			SELF.Business_State := ut.CleanSpacesAndUpper(l.Business_State);
			SELF.Business_Zip := trim(l.Business_Zip,left,right);
			SELF.Norm_Tax_ID  := trim(l.Norm_Tax_ID,left,right);
			SELF.Norm_Confidence_Level := trim(l.Norm_Confidence_Level,left,right);
			SELF.Norm_Display_Configuration := ut.CleanSpacesAndUpper(l.Norm_Display_Configuration);
			SELF.Long_Name := ut.CleanSpacesAndUpper(l.Long_Name);
			SELF.source := IF(
				l.Norm_Confidence_Level = '1' AND l.Norm_Display_Configuration = 'Y',
				MDR.sourceTools.src_Experian_FEIN_Unrest, /*unrestricted 'E6'*/
				MDR.sourceTools.src_Experian_FEIN_Rest    /*restricted 'E5'*/
			); 
			SELF := l;
			SELF := [];
		END;

		dPreProcess := PROJECT(dNormalize, tPreProcessRecs(LEFT));

		RETURN dPreProcess;
	END;
	
	/*----------------*/
	/* FUNCTION: fAll */
	/*----------------*/

	EXPORT fAll(
		DATASET(Layouts.Input.sprayed) pRawFileInput,
		STRING pversion,
		STRING pPersistname = persistnames().StandardizeInput
	) := FUNCTION
		dNormalize := fAssignseq (pRawFileInput,pversion);

		dPreprocess := fPreProcess(dNormalize,pversion); // : PERSIST(pPersistname);

		dGoodRecs := dPreprocess(Norm_Tax_ID <> '');

		RETURN dGoodRecs;
	END;

END;
