import ut,address;
export Layout_Experian_CP_Out := MODULE

EXPORT Address_Rec 		:= RECORD
	STRING50 	 Address1 	:= ''	;
	STRING12 	 Address2 	:= ''	;
	STRING32 City 		:= ''	;
	STRING6  State 		:= ''	;
	STRING5  ZipCode		:= ''	;
	STRING5  ZipCode4		:= ''	;
END;

	//Layout for clean addresses
EXPORT Norm_Clean_Address_Rec := RECORD
	Address_Rec;
	STRING182 Clean_Address;
END;

	//Layout for clean names
EXPORT Norm_Cleand_NameRec := RECORD
	STRING73 Name	  ;
	STRING73 Clean_Name;
END;


EXPORT Layout_Experian_Norm_Name := RECORD
	//	Entire_Credit_Header_List_Record			
		//Consumer_ID			
	String15	Encrypted_Experian_PIN			;
	//	Consumer_Name_Section			
	String8		Consumer_Create_Date			;
	String32	Surname							;
	String32	First_Name						;
	String32	Middle_Name						;
	String32	Second_Surname					;
	String32	Spouse_First_Name				;
	String1		Generation_Code					;
	//	Current_Address_Section_			
	String8		Address_Create_Date				;
	String10	Street_Address					;
	String2		Street_Predirectional			;
	String32	Street_Name						;
	String4		Street_Suffix					;
	String2		Street_PostDirectional			;
	String4		Unit_Type						;
	String8		Unit_ID							;
	String32	City_Name						;
	String2		State_Abbreviation				;
	String5		ZIP_Code						;
	String4		ZIP_Plus_Four					;
	//	Consumer_Data_Section			
	String9		Social_Security_Number			;
	String8		Date_of_Birth					;
	String10	Telephone						;
	String1		Gender							;
	//	Miscellaneous_Data_Section			
	//	Additional_Names_Section			
	String2		Additional_Name_Count			;
	//	Name_2			
	String8		Consumer_Create_Date2			;
	String32	Surname2						;
	String32	First_Name2						;
	String32	Middle_Name2					;
	String32	Second_Surname2					;
	String1		Generation_Code2				;
	//	Name_3			
	String8		Consumer_Create_Date3			;
	String32	Surname3						;
	String32	First_Name3						;
	String32	Middle_Name3					;
	String32	Second_Surname3					;
	String1		Generation_Code3				;
	//	Name_4			
	String8		Consumer_Create_Date4			;
	String32	Surname4						;
	String32	First_Name4						;
	String32	Middle_Name4					;
	String32	Second_Surname4					;
	String1		Generation_Code4				;
	//	Previous_Address_Section			
	String2		Previous_Address_Count			;
	//	Previous_Address_1			
	String8		Address_Create_Date1			;
	String10	Street_Address_Previous1		;
	String2		Street_Predirectional1			;
	String32	Street_Name1					;
	String4		Street_Suffix1					;
	String2		Street_PostDirectional1			;
	String4		Unit_Type1						;
	String8		Unit_ID1						;
	String32	City_Name1						;
	String2		State_Abbreviation1				;
	String5		ZIP_Code1						;
	String4		ZIP_Plus_Four1					;
	//	Previous_Address_2			
	String8		Address_Create_Date2			;
	String10	Street_Address_Previous2		;
	String2		Street_Predirectional2			;
	String32	Street_Name2					;
	String4		Street_Suffix2					;
	String2		Street_PostDirectional2			;
	String4		Unit_Type2						;
	String8		Unit_ID2						;
	String32	City_Name2						;
	String2		State_Abbreviation2				;
	String5		ZIP_Code2						;
	String4		ZIP_Plus_Four2					;
	//	Previous_Address_3			
	String8		Address_Create_Date3			;
	String10	Street_Address_Previous3		;
	String2		Street_Predirectional3			;
	String32	Street_Name3					;
	String4		Street_Suffix3					;
	String2		Street_PostDirectional3			;
	String4		Unit_Type3						;
	String8		Unit_ID3						;
	String32	City_Name3						;
	String2		State_Abbreviation3				;
	String5		ZIP_Code3						;
	String4		ZIP_Plus_Four3					;
	//	Previous_Address_4			
	String8		Address_Create_Date4			;
	String10	Street_Address_Previous4		;
	String2		Street_Predirectional4			;
	String32	Street_Name4					;
	String4		Street_Suffix4					;
	String2		Street_PostDirectional4			;
	String4		Unit_Type4						;
	String8		Unit_ID4						;
	String32	City_Name4						;
	String2		State_Abbreviation4				;
	String5		ZIP_Code4						;
	String4		ZIP_Plus_Four4					;
	//	Previous_Address_5			
	String8		Address_Create_Date5			;
	String10	Street_Address_Previous5		;
	String2		Street_Predirectional5			;
	String32	Street_Name5					;
	String4		Street_Suffix5					;
	String2		Street_PostDirectional5			;
	String4		Unit_Type5						;
	String8		Unit_ID5						;
	String32	City_Name5						;
	String2		State_Abbreviation5				;
	String5		ZIP_Code5						;
	String4		ZIP_Plus_Four5					;
	//	Previous_Address_6			
	String8		Address_Create_Date6			;
	String10	Street_Address_Previous6		;
	String2		Street_Predirectional6			;
	String32	Street_Name6					;
	String4		Street_Suffix6					;
	String2		Street_PostDirectional6			;
	String4		Unit_Type6						;
	String8		Unit_ID6						;
	String32	City_Name6						;
	String2		State_Abbreviation6				;
	String5		ZIP_Code6						;
	String4		ZIP_Plus_Four6					;
	//	Previous_Address_7			
	String8		Address_Create_Date7			;
	String10	Street_Address_Previous7		;
	String2		Street_Predirectional7			;
	String32	Street_Name7					;
	String4		Street_Suffix7					;
	String2		Street_PostDirectional7			;
	String4		Unit_Type7						;
	String8		Unit_ID7						;
	String32	City_Name7						;
	String2		State_Abbreviation7				;
	String5		ZIP_Code7						;
	String4		ZIP_Plus_Four7					;
	STRING1 	RecType						;
	STRING2 	NameType 						;
	STRING73 	Name 							;
	address.Layout_Clean_Name 					;  
	UNSIGNED1 	AddressSeq						;
	Address_Rec									;
END;	


EXPORT Layout_Experian_Norm_Address := RECORD
	Layout_Experian_Norm_Name;
	address.Layout_Clean182						; 
END;

EXPORT Layout_Experian_All_Out := RECORD
	Layout_Experian_Norm_Address				; 
	UNSIGNED6   did   				:=0			;
	UNSIGNED	DID_Score_field 	:=0			;
END;

END;

	