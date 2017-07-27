import address;
export Layouts := MODULE

//-----------------------------------------------
//Input File Layout
//-----------------------------------------------
export Layout_In := RECORD
	//	Entire_Credit_Header_List_Record			
		//Consumer_ID			
	String15	Encrypted_Experian_PIN			;
	String21	Filler1							;
	//	Consumer_Name_Section			
	String8		Consumer_Create_Date			;
	String8		Filler2							;
	String32	Surname							;
	String32	First_Name						;
	String32	Middle_Name						;
	String32	Second_Surname					;
	String32	Spouse_First_Name				;
	String1		Generation_Code					;
	//	Current_Address_Section_			
	String8		Address_Create_Date				;
	String8		Address_Update_Date				;//2009/09 file changed filler to be Address_Update_Date
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
	String9		Filler4							;
	//	Miscellaneous_Data_Section			
	String32	Reserved_for_future_Use			;
	//	Additional_Names_Section			
	String2		Additional_Name_Count			;
	//	Name_2			
	String8		Consumer_Create_Date2			;
	String8		Filler5							;
	String32	Surname2						;
	String32	First_Name2						;
	String32	Middle_Name2					;
	String32	Second_Surname2					;
	String1		Generation_Code2				;
	//	Name_3			
	String8		Consumer_Create_Date3			;
	String8		Filler6							;
	String32	Surname3						;
	String32	First_Name3						;
	String32	Middle_Name3					;
	String32	Second_Surname3					;
	String1		Generation_Code3				;
	//	Name_4			
	String8		Consumer_Create_Date4			;
	String8		Filler7							;
	String32	Surname4						;
	String32	First_Name4						;
	String32	Middle_Name4					;
	String32	Second_Surname4					;
	String1		Generation_Code4				;
	//	Previous_Address_Section			
	String2		Previous_Address_Count			;
	//	Previous_Address_1			
	String8		Address_Create_Date1			;
	String8		Address_Update_Date1			; //2009/09 file changed filler to be Address_Update_Date1
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
	String1		Filler9							;
	//	Previous_Address_2			
	String8		Address_Create_Date2			;
	String8		Address_Update_Date2			;//2009/09 file changed filler to be Address_Update_Date2
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
	String1		Filler11						;
	//	Previous_Address_3			
	String8		Address_Create_Date3			;
	String8		Address_Update_Date3			;//2009/09 file changed filler to be Address_Update_Date3
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
	String1		Filler13						;
	//	Previous_Address_4			
	String8		Address_Create_Date4			;
	String8		Address_Update_Date4			;//2009/09 file changed filler to be Address_Update_Date4
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
	String1		Filler15						;
	//	Previous_Address_5			
	String8		Address_Create_Date5			;
	String8		Address_Update_Date5			;//2009/09 file changed filler to be Address_Update_Date5
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
	String1		Filler17						;
	//	Previous_Address_6			
	String8		Address_Create_Date6			;
	String8		Address_Update_Date6			;//2009/09 file changed filler to be Address_Update_Date6
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
	String1		Filler19						;
	//	Previous_Address_7			
	String8		Address_Create_Date7			;
	String8		Address_Update_Date7			;//2009/09 file changed filler to be Address_Update_Date7
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
	String5		Filler21						;
	String1   EOL								;
END;

//-----------------------------------------------
//Input Delete File Layout 
//-----------------------------------------------
EXPORT Layout_Delete_In := RECORD
   String15		Encrypted_Experian_PIN			;
   String8		Delete_Date						;
   String2		Suppression_Code					;
   String76	  filler                  ;
END;

//-----------------------------------------------
//Input Delete File Layout Old (last process in 20091001 build
//-----------------------------------------------
EXPORT Layout_Delete_In_Old := RECORD
   String15		Encrypted_Experian_PIN			;
   String8		Delete_Date						;
   String1	    EOL								;
END;


//-----------------------------------------------
//Input Deceased File Layout 
//-----------------------------------------------
EXPORT Layout_Deceased_In := RECORD
   String15		Encrypted_Experian_PIN			;
   string86   filler;
END;

//-----------------------------------------------
//Input File Layout Separate Sections without fillers and EOL
//-----------------------------------------------
EXPORT Layout_In_Common := RECORD
	String15	Encrypted_Experian_PIN			;
	//	Consumer_Data_Section			
	String9		Social_Security_Number			;
	String8		Date_of_Birth					;
	String10	Telephone						;
	String1		Gender							;	
	String2		Additional_Name_Count			;
	String2		Previous_Address_Count			;	
END;


EXPORT Layout_In_Name := RECORD
	String8		Consumer_Create_Date			;
	String32	Surname							;
	String32	First_Name						;
	String32	Middle_Name						;
	String32	Second_Surname					;
	String32	Spouse_First_Name				;
	String1		Generation_Code					;
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
END;

EXPORT Layout_In_Address := RECORD
	//	Current_Address_Section_			
	String8		Address_Create_Date				;
	String8		Address_Update_Date  			;// New field in 2009/09 file.  Previously a filler
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
//	Previous_Address_1			
	String8		Address_Create_Date1			;
	String8		Address_Update_Date1			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date2			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date3			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date4			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date5			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date6			;// New field in 2009/09 file.  Previously a filler
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
	String8		Address_Update_Date7			;// New field in 2009/09 file.  Previously a filler
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
END;

//-----------------------------------------------
//Layouts for Clean Name and Addresses
//-----------------------------------------------
EXPORT Layout_Address 		:= RECORD
	String10	Orig_Prim_Range					;
	String2		Orig_Predir						;
	String32	Orig_Prim_Name					;
	String4		Orig_Addr_Suffix				;
	String2		Orig_Postdir					;
	String4		Orig_Unit_Desig					;
	String8		Orig_Sec_Range					;
	String32 	Orig_City 				:= ''	;
	String6  	Orig_State 				:= ''	;
	String5  	Orig_ZipCode			:= ''	;
	String5  	Orig_ZipCode4			:= ''	;
END;

	//Layout for clean addresses
EXPORT Layout_Clean_Address := RECORD
	Layout_Address;
	String182 Clean_Address;
END;

EXPORT Layout_Name	:= RECORD
	String32 Orig_fname  ;
	String32 Orig_mname  ;
	String32 Orig_lname  ;
	String3  Orig_suffix ;
END;

	//Layout for clean names
EXPORT Layout_Clean_Name := RECORD
	String32 Orig_fname  ;
	String32 Orig_mname  ;
	String32 Orig_lname  ;
	String3  Orig_suffix ;
	String1	 Gender		 ;
	String73 Clean_Name	 ;
END;

//-----------------------------------------------
//Layouts for Normalized Data
//-----------------------------------------------
EXPORT Layout_Norm_Name := RECORD
	Unsigned Seq_Rec_Id;
	Layout_In_Common;
	//	Consumer_Name_Section
	String3 	NameType 						;
	String8		Orig_Consumer_Create_Date		;
  Layout_Name;
  Layout_In_Address
END;

EXPORT Layout_Norm_Address := RECORD
	Unsigned Seq_Rec_Id;
	Layout_In_Common;
	//	Consumer_Name_Section			
	String3 	NameType 						;
	String8		Orig_Consumer_Create_Date		;
  Layout_Name;
	Unsigned1 	AddressSeq						;
	String8 	Orig_Address_Create_Date 		:= ''	;
	String8 	Orig_Address_Update_Date 		:= ''	;
	Layout_Address;
END;


//-----------------------------------------------
//Layout for Base
//-----------------------------------------------
EXPORT Layout_Out := RECORD
	Unsigned Seq_Rec_Id;
	Unsigned6 did   					   					:=0	;
	Unsigned 	DID_Score_field 	      		:=0	;
	Unsigned	current_rec_flag						:= 0;
	Unsigned  current_experian_pin				:= 0;
	Unsigned  date_first_seen 		   			:= 0;
	Unsigned  date_last_seen 			   			:= 0;
	Unsigned  date_vendor_first_reported 	:= 0;
	Unsigned 	date_vendor_last_reported  	:= 0;
	Layout_In_Common;
	//	Consumer_Name_Section			
	String3 	NameType 						;
	String8		Orig_Consumer_Create_Date		;
  Layout_Name;
	address.Layout_Clean_Name 					; 	
	Unsigned1 	AddressSeq						;
	String8 	Orig_Address_Create_Date 		:= ''	;
	String8 	Orig_Address_Update_Date 		:= ''	;
	Layout_Address;
	address.Layout_Clean182						; 
	Unsigned1	delete_flag								:= 0;
	Unsigned	delete_file_date					:= 0;
	Unsigned  Suppression_Code          := 0;
	Unsigned1 deceased_Ind							:= 0
END;

EXPORT Layout_Out_old := RECORD // used for source key
	Unsigned Seq_Rec_Id;
	Unsigned6   did   					   			:=0	;
	Unsigned 	DID_Score_field 	       	:=0	;
	Unsigned	current_rec_flag					:= 0;
	Unsigned  date_first_seen 		   	:= 0;
	Unsigned  date_last_seen 			   	:= 0;
	Unsigned  date_vendor_first_reported 	:= 0;
	Unsigned 	date_vendor_last_reported  	:= 0;
	Layout_In_Common;
	//	Consumer_Name_Section			
	String3 	NameType 						;
	String8		Orig_Consumer_Create_Date		;
  Layout_Name;
	address.Layout_Clean_Name 					; 	
	Unsigned1 	AddressSeq						;
	String8 	Orig_Address_date 		:= ''	;
	Layout_Address;
	address.Layout_Clean182						; 
	Unsigned1	delete_flag						:= 0;
	Unsigned	delete_file_date			:= 0;
END;

EXPORT Layout_SourceDoc := RECORD // used for source key
      Layout_Out_old-address.Layout_Clean182-address.Layout_Clean_Name;
END;


END;