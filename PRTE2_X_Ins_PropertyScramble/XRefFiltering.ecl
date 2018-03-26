
EXPORT XRefFiltering(DATASET(Layouts.Layout_Base_XRef) DS) := MODULE

	EXPORT Boolean IsPropertyData := DS.is_property = 'Y';
	EXPORT Boolean isPOBoxRecord := DS.is_property<>'Y';
	EXPORT Boolean IsCustomProd := DS.is_custom_prod = 'Y';
	EXPORT Boolean NotCustomProd := NOT IsCustomProd;
	// EXPORT searchpattern1 := '( UNIT | APT )';
	// EXPORT Boolean isAptCondo := DS.apt<>'' OR REGEXFIND(searchpattern1,DS.street));
	EXPORT Boolean isAptCondo := DS.is_condo='Y';
	EXPORT Boolean NotAptCondo := NOT isAptCondo;

	// The following separate POB, Custom, or Other (General Properties)
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						Rescramble_Home_Properties := DS(IsPropertyData AND NotCustomProd AND NotAptCondo);
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						ReScramble_POBs_Only := DS(isPOBoxRecord AND NotCustomProd);
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						Rescramble_Customs_Only := DS(IsCustomProd);
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						Rescramble_Condo_Properties := DS(IsPropertyData AND NotCustomProd AND isAptCondo);


// -- useful filters to make your work easier ----------------------------------------------
	// The following filter properties by property type and include all custom=Y or ''
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						All_Standard_Property_Data := DS(IsPropertyData);		//HOMES and CONDOs (no POB)
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						CondoApt_Property_Data := DS(IsPropertyData AND isAptCondo);	//CONDOs
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
						Homes_Property_Data := DS(IsPropertyData AND NotAptCondo);		//HOMES


	EXPORT Fn_Validate_XRef_Groups := FUNCTION
					GroupRec := RECORD
						STRING2 state := '';
						STRING5 zip := '';
					END;
					GroupRec xFormGR(Layouts.Layout_Base_XRef L) := TRANSFORM
							SELF  := L;
							SELF  := [];
					END;

					gbpDS := SORT(PROJECT(Homes_Property_Data, xFormGR(LEFT)), state,zip);
					
					groupByRec := RECORD
							gbpDS;
							INTEGER cnt := COUNT(GROUP);
					END;
					XTAB:= TABLE(gbpDS, groupByRec, state,zip);
					
				RETURN MAX(XTAB,cnt);
		END;

END;