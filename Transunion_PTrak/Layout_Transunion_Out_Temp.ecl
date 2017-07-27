/*2008-09-03T14:32:34Z (a herzberg)

*/
IMPORT address;
EXPORT Layout_Transunion_Out_Temp := MODULE
//-----------------------------------------------------------------
// NAME AND ADDRESS RECORD LAYOUT DECLATION
//-----------------------------------------------------------------
EXPORT AddressRec := RECORD,  MAXLENGTH (5000)
	STRING Address1 := ''	;
	STRING Address2 := ''	;
	STRING City 		:= ''	;
	STRING State 		:= ''	;
	STRING ZipCode	:= ''	;
	STRING UpdatedDate:= ''	;
END;

EXPORT NameRec := RECORD, MAXLENGTH (1000)
	STRING15 FirstName		;
	STRING15 MiddleName		;
	STRING2 MiddleInitial	:= '';
	STRING25 LastName		;
	STRING3 Suffix			;
	STRING Gender		:= ''	;
	STRING2 Dob_MM			;
	STRING2 Dob_DD			;
	STRING4 Dob_YYYY		;
	STRING DeathIndicator	;
END;

EXPORT AKARec := RECORD,  MAXLENGTH (1000)
	STRING15 FirstName		:= ''	;
	STRING15 MiddleName		:= ''	;
	STRING2 MiddleInitial	:= '';
	STRING25 LastName		:= ''	;
	STRING3 Suffix			:= ''	;
END;

//-----------------------------------------------------------------
// LAYOUT DECLARATION FOR NORMALIZED NAME ADDRESS AND CLEAN TRANSFORMS
//-----------------------------------------------------------------

//Layout for normalized addresses
EXPORT NormNameAddressRec := RECORD, MAXLENGTH(5000)
	STRING1 FileType 					;
	STRING12 VendorDocumentIdentifier		;	// = PartyID in vendor file
	STRING10 TransferDate	:= ''				;
	NameRec CurrentName						;
	STRING11 SSNFull						;
	STRING6 SSNFirst5Digit	:= ''	;
	STRING5 SSNLast4Digit		:= ''	;
	STRING10 ConsumerUpdateDate		:= ''	;
	STRING10 DateOfDeath			:= ''	;
	STRING8 TelephoneNumber					;
	STRING CitedID	:= ''	;
	STRING FileID		:= ''	;
	STRING Publication	:= ''	;
	AddressRec CurrentAddress				;
	STRING6 HOUSENUMBER:= ''	;
	STRING2 STREETTYPE:= ''	;
	STRING2 STREETDIRECTION:= ''	;
	STRING27 STREETNAME:= ''	;
	STRING5 APARTMENTNUMBER:= ''	;
	STRING27 CITY:= ''	;
	STRING2 STATE:= ''	;
	STRING5 ZIPCODE:= ''	;
	STRING4 ZIP4U:= ''	;
	dataset(Transunion_PTrak.Layout_Transunion_Full_In.AddressRec) PreviousAddress;	
	AKARec  FormerName						;
	AKARec  AliasName 						;
	AKARec  AdditionalName					;
	STRING32 AKA1 := ''	;
	STRING32 AKA2 := ''	;
	STRING32 AKA3 := ''	;
	STRING1 RECORDTYPE := ''				;
	STRING1 ADDRESSSTANDARDIZATION := ''	;
	STRING8 FILESINCEDATE := ''				;
	STRING8 COMPILATIONDATE:= ''			;
	STRING1 BIRTHDATEIND:= ''				;							               
	STRING1 Orig_DECEASEDINDICATOR:= ''		;
	UNSIGNED1 AddressSeq					; 
	AddressRec NormAddress					;
	STRING73 Name 		:= ''				;
	STRING2 NameType 	:= ''				;
END;
	
	//Layout for clean addresses
EXPORT NormCleanAddressRec := RECORD, MAXLENGTH(2000)
	AddressRec NormAddress;
	STRING182 CleanAddress;
END;

	//Layout for clean names
EXPORT NormCleandNameRec := RECORD, MAXLENGTH(2000)
	STRING73 Name;
	STRING73 CleanName;
END;

	//Layout to join normalized name and address to clean name
EXPORT FinalNormCleanNameRec := RECORD, MAXLENGTH(2000)
    NormNameAddressRec;
	STRING73 CleanName;
END;
	//Layout to join clean name and normalized named and address to clean address

EXPORT FinalNormCleanNameAddressRec := RECORD, MAXLENGTH(2000)
	FinalNormCleanNameRec;
	STRING182 CleanAddress;
END;


//-----------------------------------------------------------------
// FINAL OUTPUT LAYOUT 
//-----------------------------------------------------------------

EXPORT LayoutTransunionBaseOut := RECORD, MAXLENGTH (5000)
	//Data contained in the input layout
	NormNameAddressRec;
	//Additional clean Name and Address data
	address.Layout_Clean_Name				;  
	address.Layout_Clean182					; 
	//Additional reformated date, ssn and telephone data
	STRING8 TRANSFERDATE_Unformatted		; //YYYYMMDD
	STRING8 DEATHDATE_unformatted			; //YYYYMMDD
	STRING8 BIRTHDATE_unformatted			; //YYYYMMDD
	STRING8 UPDATEDATE_unformatted			; //YYYYMMDD
	STRING8 CONSUMERUPDATEDATE_unformatted	; //YYYYMMDD	
	STRING9 SSN_unformatted					;
	STRING8 TELEPHONE_unformatted			;
	STRING1 DECEASEDINDICATOR				;
	
	UNSIGNED6   did   				:=0		;
	UNSIGNED	DID_Score_field 	:=0		;
END;
END;
