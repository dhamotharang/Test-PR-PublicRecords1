import address;
export Layouts := MODULE

//-----------------------------------------------
//Input File Layout
//-----------------------------------------------
export Layout_In := RECORD
     STRING10       Address_ID;
     STRING2        State_Code;
     STRING2        State_Abbr;
     STRING5        Zip_Code;
     STRING4        Zip_4;
     STRING3        Del_Point_Check_Digit;
     STRING4        Carrier_Route;
     STRING28       City_Name;
     STRING10       House_Number;
     STRING2        Pre_Direction;
     STRING28       Street_Name;
     STRING4        Street_Suffix;
     STRING2        Post_Direction;
     STRING6        Unit_Designator;
     STRING8        Unit_Designator_Number;
     STRING6        Filler;
     STRING10       Living_Unit_ID;
     STRING10       Telephone_Number;
     STRING10       Second_Phone_Number;
     STRING10       Third_Phone_Number;
     STRING8        Living_Unit_Start_Date;
     STRING8        Last_Activity_Date_of_LU;
     STRING1        Mail_Objector;
     STRING1        Phone_Objector;
			//NAME 1
     STRING10       Person_1_PID;
     STRING1        Person_1_Type;
     STRING15       Person_1_First_Name;
     STRING1        Person_1_Middle_Initial;
     STRING20       Person_1_Last_Name;
     STRING6        Person_1_Surname_Suffix;
     STRING6        Person_1_Title_of_Respect;
     STRING1        Person_1_Gender;
     STRING8        Person_1_Date_of_Birth;
     STRING9        Person_1_SSN;
			//NAME 2
     STRING10       Person_2_PID;
     STRING1        Person_2_Type;
     STRING15       Person_2_First_Name;
     STRING1        Person_2_Middle_Initial;
     STRING20       Person_2_Last_Name;
     STRING6        Person_2_Surname_Suffix;
     STRING6        Person_2_Title_of_Respect;
     STRING1        Person_2_Gender;
     STRING8        Person_2_Date_of_Birth;
     STRING9        Person_2_SSN;
			//NAME 3
     STRING10       Person_3_PID;
     STRING1        Person_3_Type;
     STRING15       Person_3_First_Name;
     STRING1        Person_3_Middle_Initial;
     STRING20       Person_3_Last_Name;
     STRING6        Person_3_Surname_Suffix;
     STRING6        Person_3_Title_of_Respect;
     STRING1        Person_3_Gender;
     STRING8        Person_3_Date_of_Birth;
     STRING9        Person_3_SSN;
			//NAME 4
     STRING10       Person_4_PID;
     STRING1        Person_4_Type;
     STRING15       Person_4_First_Name;
     STRING1        Person_4_Middle_Initial;
     STRING20       Person_4_Last_Name;
     STRING6        Person_4_Surname_Suffix;
     STRING6        Person_4_Title_of_Respect;
     STRING1        Person_4_Gender;
     STRING8        Person_4_Date_of_Birth;
     STRING9        Person_4_SSN;
			//NAME 5
     STRING10       Person_5_PID;
     STRING1        Person_5_Type;
     STRING15       Person_5_First_Name;
     STRING1        Person_5_Middle_Initial;
     STRING20       Person_5_Last_Name;
     STRING6        Person_5_Surname_Suffix;
     STRING6        Person_5_Title_of_Respect;
     STRING1        Person_5_Gender;
     STRING8        Person_5_Date_of_Birth;
     STRING9        Person_5_SSN;
			//NAME 6
     STRING10       Person_6_PID;
     STRING1        Person_6_Type;
     STRING15       Person_6_First_Name;
     STRING1        Person_6_Middle_Initial;
     STRING20       Person_6_Last_Name;
     STRING6        Person_6_Surname_Suffix;
     STRING6        Person_6_Title_of_Respect;
     STRING1        Person_6_Gender;
     STRING8        Person_6_Date_of_Birth;
     STRING9        Person_6_SSN;
			//NAME 7
     STRING10       Person_7_PID;
     STRING1        Person_7_Type;
     STRING15       Person_7_First_Name;
     STRING1        Person_7_Middle_Initial;
     STRING20       Person_7_Last_Name;
     STRING6        Person_7_Surname_Suffix;
     STRING6        Person_7_Title_of_Respect;
     STRING1        Person_7_Gender;
     STRING8        Person_7_Date_of_Birth;
     STRING9        Person_7_SSN;
			//NAME 8
     STRING10       Person_8_PID;
     STRING1        Person_8_Type;
     STRING15       Person_8_First_Name;
     STRING1        Person_8_Middle_Initial;
     STRING20       Person_8_Last_Name;
     STRING6        Person_8_Surname_Suffix;
     STRING6        Person_8_Title_of_Respect;
     STRING1        Person_8_Gender;
     STRING8        Person_8_Date_of_Birth;
     STRING9        Person_8_SSN;
	 
     STRING1        Dwelling_Unit_Size;
     STRING1        Dwelling_Type;
     STRING1	    FILLER2;
END;


//-----------------------------------------------
//Input File Layout Separate Sections without fillers and EOL
//-----------------------------------------------
EXPORT Layout_In_Common := RECORD
     STRING10       Address_ID;
     STRING2        State_Code;
     STRING3        Del__Point_Check_Digit;
     STRING4        Carrier_Route;
     STRING10       Living_Unit_ID;
     STRING10       Telephone_Number;
     STRING10       Second_Phone_Number;
     STRING10       Third_Phone_Number;
     STRING8        Living_Unit_Start_Date;
     STRING8        Last_Activity_Date_of_LU;
     STRING1        Mail_Objector;
     STRING1        Phone_Objector;
     STRING1        Dwelling_Unit_Size;
     STRING1        Dwelling_Type;
END;

// EXPORT Layout_In_Name := RECORD
 
			// NAME 1
     // STRING10       Person_1_PID;
     // STRING1        Person_1_Type;
     // STRING15       Person_1_First_Name;
     // STRING1        Person_1_Middle_Initial;
     // STRING20       Person_1_Last_Name;
     // STRING6        Person_1_Surname_Suffix;
     // STRING6        Person_1_Title_of_Respect;
     // STRING1        Person_1_Gender;
     // STRING8        Person_1_Date_of_Birth;
     // STRING9        Person_1_SSN;
			// NAME 2
     // STRING10       Person_2_PID;
     // STRING1        Person_2_Type;
     // STRING15       Person_2_First_Name;
     // STRING1        Person_2_Middle_Initial;
     // STRING20       Person_2_Last_Name;
     // STRING6        Person_2_Surname_Suffix;
     // STRING6        Person_2_Title_of_Respect;
     // STRING1        Person_2_Gender;
     // STRING8        Person_2_Date_of_Birth;
     // STRING9        Person_2_SSN;
			// NAME 3
     // STRING10       Person_3_PID;
     // STRING1        Person_3_Type;
     // STRING15       Person_3_First_Name;
     // STRING1        Person_3_Middle_Initial;
     // STRING20       Person_3_Last_Name;
     // STRING6        Person_3_Surname_Suffix;
     // STRING6        Person_3_Title_of_Respect;
     // STRING1        Person_3_Gender;
     // STRING8        Person_3_Date_of_Birth;
     // STRING9        Person_3_SSN;
			// NAME 4
     // STRING10       Person_4_PID;
     // STRING1        Person_4_Type;
     // STRING15       Person_4_First_Name;
     // STRING1        Person_4_Middle_Initial;
     // STRING20       Person_4_Last_Name;
     // STRING6        Person_4_Surname_Suffix;
     // STRING6        Person_4_Title_of_Respect;
     // STRING1        Person_4_Gender;
     // STRING8        Person_4_Date_of_Birth;
     // STRING9        Person_4_SSN;
			// NAME 5
     // STRING10       Person_5_PID;
     // STRING1        Person_5_Type;
     // STRING15       Person_5_First_Name;
     // STRING1        Person_5_Middle_Initial;
     // STRING20       Person_5_Last_Name;
     // STRING6        Person_5_Surname_Suffix;
     // STRING6        Person_5_Title_of_Respect;
     // STRING1        Person_5_Gender;
     // STRING8        Person_5_Date_of_Birth;
     // STRING9        Person_5_SSN;
			// NAME 6
     // STRING10       Person_6_PID;
     // STRING1        Person_6_Type;
     // STRING15       Person_6_First_Name;
     // STRING1        Person_6_Middle_Initial;
     // STRING20       Person_6_Last_Name;
     // STRING6        Person_6_Surname_Suffix;
     // STRING6        Person_6_Title_of_Respect;
     // STRING1        Person_6_Gender;
     // STRING8        Person_6_Date_of_Birth;
     // STRING9        Person_6_SSN;
			// NAME 7
     // STRING10       Person_7_PID;
     // STRING1        Person_7_Type;
     // STRING15       Person_7_First_Name;
     // STRING1        Person_7_Middle_Initial;
     // STRING20       Person_7_Last_Name;
     // STRING6        Person_7_Surname_Suffix;
     // STRING6        Person_7_Title_of_Respect;
     // STRING1        Person_7_Gender;
     // STRING8        Person_7_Date_of_Birth;
     // STRING9        Person_7_SSN;
			// NAME 8
     // STRING10       Person_8_PID;
     // STRING1        Person_8_Type;
     // STRING15       Person_8_First_Name;
     // STRING1        Person_8_Middle_Initial;
     // STRING20       Person_8_Last_Name;
     // STRING6        Person_8_Surname_Suffix;
     // STRING6        Person_8_Title_of_Respect;
     // STRING1        Person_8_Gender;
     // STRING8        Person_8_Date_of_Birth;
     // STRING9        Person_8_SSN;
	
 // END;

EXPORT Layout_In_Address := RECORD
     STRING2        State_Abbr;
     STRING5        Zip_Code;
     STRING4        Zip_4;
     STRING28       City_Name;
     STRING10       House_Number;
     STRING2        Pre_Direction;
     STRING28       Street_Name;
     STRING4        Street_Suffix;
     STRING2        Post_Direction;
     STRING6        Unit_Designator;
     STRING8        Unit_Designator_Number;
END;

//-----------------------------------------------
//Layouts for Normalized Name and Addresses only
//-----------------------------------------------
EXPORT Layout_Name := RECORD
	String32		Orig_fname;
	String32		Orig_mname;
	String32		Orig_lname;
	String3			Orig_suffix;
	String6			Orig_Title;
	STRING10		Orig_PID;
	STRING1			Orig_Type;
	STRING6			Orig_Title_of_Respect;
	STRING1			Orig_Gender;
	STRING8			Orig_Date_of_Birth;
	STRING9			Orig_SSN;
END;

EXPORT Layout_Address := RECORD
	String10		Orig_Prim_Range;
	String2			Orig_Predir;
	String32		Orig_Prim_Name;
	String4			Orig_Addr_Suffix;			
	String2			Orig_Postdir;				
	String4			Orig_Unit_Desig;
	String8			Orig_Sec_Range;
	String32 		Orig_City := '';
	String2  		Orig_State := '';
	String5  		Orig_ZipCode := '';
	String4  		Orig_ZipCode4 := '';
END;

	//Layout for clean addresses
EXPORT Layout_Clean_Address := RECORD
					Layout_Address;
END;

	//Layout for clean names
EXPORT Layout_Clean_Name := RECORD
	String32		Orig_fname;
	String32		Orig_mname;
	String32		Orig_lname;
	String3			Orig_suffix;
	String73		Clean_Name;
END;

//-----------------------------------------------
//Layouts for Normalized Data
//-----------------------------------------------
EXPORT Layout_Norm_Name := RECORD
	Unsigned		Seq_Rec_Id;
					Layout_In_Common;
	String3			NameType;
					Layout_Name;
					Layout_In_Address;
END;

EXPORT Layout_Norm_Address := RECORD
	Unsigned 		Seq_Rec_Id;
					Layout_In_Common;
	String3 		NameType;
					Layout_Name;
	Unsigned1		AddressSeq;
	String8			Orig_Address_Start_date :='';
	String8			Orig_Address_date :='';
					Layout_Address;
	String2			Phone_Type :='';
	Unsigned1		PhoneSeq;
	String10		Orig_Phone_Num :='';
END;

EXPORT Layout_Cln_Name := RECORD
					Layout_Norm_Address;
	String73		Clean_Name;
END;

EXPORT Layout_Cln_Addr := RECORD
					Layout_Cln_Name;
	unsigned8		rawaidin;
END;

//-----------------------------------------------
//Layout for Base
//-----------------------------------------------
EXPORT Layout_Out := RECORD
	Unsigned		Seq_Rec_Id;
	Unsigned6		did :=0;
	Unsigned 		DID_Score_field :=0;
	Unsigned		current_rec_flag :=0;
	Unsigned  		date_first_seen :=0;
	Unsigned  		date_last_seen :=0;
	Unsigned  		date_vendor_first_reported :=0;
	Unsigned 		date_vendor_last_reported :=0;
					Layout_In_Common;
	//	Consumer_Name_Section			
	String3			NameType;
					Layout_Name;
	String8			Date_of_Birth:='';
					address.Layout_Clean_Name; 	
	Unsigned1 		AddressSeq;
	String8 		Orig_Address_Start_date :='';
	String8			Orig_Address_date :='';
					Layout_Address;
	String2			Phone_Type :='';
	String10		Orig_Phone_Num :='';
	Unsigned8		rawAIDin;
	Unsigned8		cleanaid;
	String1			addresstype;
					address.Layout_Clean182;
END;

END;