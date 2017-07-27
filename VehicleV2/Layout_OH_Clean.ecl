IMPORT Address;
EXPORT Layout_OH_Clean := MODULE

//------------------------------------------------------------
//NORMALIZE AND CLEAN LAYOUTS
//------------------------------------------------------------

	EXPORT Layout_Norm_Names := RECORD
		STRING35 Name		;
		STRING2 NameType	;
	END;

	EXPORT Layout_Norm_Names_Clean := RECORD
		STRING35 Name		;
		STRING2 NameType	;
		STRING73 CleanName;
	END;
	
	
	EXPORT Layout_Addresses_Clean := RECORD
		STRING30 	OwnerStreetAddress		;
		STRING15 	OwnerCity				;
		STRING2 	OwnerState				;
		STRING9 	OwnerZip				;
		STRING182 	CleanAddress			;
	END;
	
//------------------------------------------------------------
//OUTPUT CLEAN FILE LAYOUTS
//------------------------------------------------------------
	EXPORT Layout_OH_Clean_Main := RECORD
		STRING8		ProcessDate				;
		STRING2 	CategoryCode			;
		STRING20 	VIN						;
		STRING4 	ModelYr					;
		STRING20 	TitleNum				;
		STRING1 	OwnerCode				;
		STRING6 	GrossWeight				;
		STRING35 	OwnerName				;
		STRING30 	OwnerStreetAddress		;
		STRING15 	OwnerCity				;
		STRING2 	OwnerState				;
		STRING9 	OwnerZip				;
		STRING2 	CountyNumber			;
		STRING8 	VehiclePurchaseDt		;
		STRING6 	VehicleTaxWeight		;
		STRING1 	VehicleTaxCode			;
		STRING6 	VehicleUnladdenWeight	;
		STRING35 	AdditionalOwnerName		;
		STRING8 	RegistrationIssueDt		;
		STRING4 	VehicleMake				;
		STRING2 	VehicleType				;
		STRING8 	VehicleExpDt			;
		STRING8 	PreviousPlateNum		;
		STRING8 	PlateNum;
		//Additional fields: clean name1, name 2 and address
		address.Layout_Clean_Name 			;
		STRING5  title2	:= ''				;
		STRING20 fname2	:= ''				;
		STRING20 mname2	:= ''				;
		STRING20 lname2	:= ''				;
		STRING5  name_suffix2 := ''			;
		STRING3  name_score2 := ''			;
		address.Layout_Clean182 			;
		STRING35 company_name1 := ''		;
		STRING35 company_name2 := ''		;
		STRING8 prev_plate_from_name := ''	;
	END;
END;