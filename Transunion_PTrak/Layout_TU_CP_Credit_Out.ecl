import ut,address;
export Layout_TU_CP_Credit_Out := MODULE

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


EXPORT Layout_TU_Norm_Name := RECORD
	Layout_TU_CP_Credit_In                ;
	STRING2 	NameType 						;
	STRING73 	Name 							;
	STRING50 	 Address1 	:= ''	;
	STRING12 	 Address2 	:= ''	;
END;	

EXPORT Layout_TU_Norm_Clean_Name := RECORD
	Layout_TU_Norm_Name;
	address.Layout_Clean_Name 					;  
END;


EXPORT Layout_TU_Norm_Clean_Address := RECORD
	Layout_TU_Norm_Clean_Name				;
	address.Layout_Clean182						; 
END;

EXPORT Layout_TU_All_Out := RECORD
	Layout_TU_Norm_Clean_Address			; 
	UNSIGNED6   did   				:=0			;
	UNSIGNED	DID_Score_field 	:=0			;
END;
END;

	





