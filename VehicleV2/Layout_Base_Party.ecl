import Standard;

export Layout_Base_Party
 :=
  record
	string30		Vehicle_Key;
	string15		Iteration_Key;
	string15		Sequence_Key;
	string2			Source_Code;
	string2			State_Origin;
	unsigned8		State_Bitmap_Flag;
	string1			Latest_Vehicle_Flag;
	string1			Latest_Vehicle_Iteration_Flag;
	string1			History;
	unsigned3		Date_First_Seen;
	unsigned3		Date_Last_Seen;
	unsigned3		Date_Vendor_First_Reported;
	unsigned3		Date_Vendor_Last_Reported;
	string1			Orig_Party_Type;
	string1			Orig_Name_Type;
	string10		Orig_Conjunction;
	string70		Orig_Name;
	string70		Orig_Address;
	string35		Orig_City;
	string2			Orig_State;
	String30        orig_province;
    String30        orig_country;
	string10		Orig_Zip;
	string9			Orig_SSN;
	string9			Orig_FEIN;
	string20		Orig_DL_Number;
	string8			Orig_DOB;
	string1			Orig_Sex;
	string8			Orig_Lien_Date;
	Standard.Name	Append_Clean_Name;
	string70		Append_Clean_CName;
	Standard.Addr	Append_Clean_Address;
	unsigned6		Append_DID;						// overload BDID here and use Orig_Name_Type to determine which?
	unsigned1		Append_DID_Score;				// overload BDID_Score here and use Orig_Name_Type to determine which?
	unsigned6		Append_BDID;
	unsigned1		Append_BDID_Score;
	string20		Append_DL_Number;
	string9			Append_SSN;						// overload FEIN here and use Orig_Name_Type to determine which?
	string9			Append_FEIN;
	string8         Append_DOB;
	string8			Reg_First_Date;
	string8			Reg_Earliest_Effective_Date;
	string8			Reg_Latest_Effective_Date;
	string8			Reg_Latest_Expiration_Date;
	unsigned1		Reg_Rollup_Count;
	string10		Reg_Decal_Number;
	string4			Reg_Decal_Year;
	string1			Reg_Status_Code;
	string20		Reg_Status_Desc;
	string10		Reg_True_License_Plate;
	string10		Reg_License_Plate;
	string2			Reg_License_State;
	string4			Reg_License_Plate_Type_Code;
	string65		Reg_License_Plate_Type_Desc;
	string2			Reg_Previous_License_State;
	string10		Reg_Previous_License_Plate;
	string20		Ttl_Number;
	string8			Ttl_Earliest_Issue_Date;
	string8			Ttl_Latest_Issue_Date;
	string8			Ttl_Previous_Issue_Date;
	unsigned1		Ttl_Rollup_Count;
	string2			Ttl_Status_Code;
	string48		Ttl_Status_Desc;
	string7			Ttl_Odometer_Mileage;
	string1			Ttl_Odometer_Status_Code;
	string42		Ttl_Odometer_Status_Desc;
	string8			Ttl_Odometer_Date;
	string8	    SRC_FIRST_DATE	:= '';	//New fields added for Infutor batch project - bug #155364
	string8	    SRC_LAST_DATE	:= '';		//New fields added for Infutor batch project
	//Added for CCPA-103 
	unsigned4   global_sid := 0;
	unsigned8   record_sid := 0;
	//Added for DF-25578
	string30    raw_name := '';
  end
 ;