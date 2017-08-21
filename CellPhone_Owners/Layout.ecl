Export Layout := Module

Export VendorIn := Record
// Will not be included in basefile and even in the In file from vendor
String	likeFIELD_1;
String	FIELD_2;
String	FIRST_NAME;
String	LAST_NAME;
String	SUFFIX;
String	ADDRESS_1;
String	ADDRESS_2;
String	CITY;
String	STATE;
String	ZIP;
String	PHONE;
String	FIELD3;

// Will be included in basefile
String50	Appended_First_Name;
String1	Appended_Middle_Name;
String100	Appended_Surname;
String500	Appended_Company_Name;
String15	Appended_Callerid_Name;
String30	Appended_Street_Number;
String2	Appended_Pre_Directional;
String28	Appended_Street_Name;
String4	Appended_Street_Suffix;
String2	Appended_Post_Directional;
String4	Appended_Unit_Designator;
String12	Appended_Unit_Number;
String50	Appended_City;
String2	Appended_State_Code;
String5	Appended_Zip_Code;
String4	Appended_Zip_Code_Extension;
String3	Delivery_Point_Code;
String4	Carrier_Route_Code;
String3	Appended_County_Code;
String1	Zip4_Type_Code;
String1	Delivery_Point_Validation;
String1	Appended_Mail_Able_Flag;
String8	Validation_Date;
String10	Appended_Phone;
String1	Appended_Phone_Type;
String1	Appended_Direct_In_Dial_Flag;
String1	Appended_Record_Type;
String10	Appended_First_Date;
String10	Appended_Last_Date;
String50	Appended_Telco_Name;
String1	Appended_Phone_Score;
String1	Appended_Directory_Assistance_Flag;
String5	MCD_Match_Code;
String2	Match_Type;
String1	Match_Level;
String5	Lexis_Nexis_Match_Code;
String1	Prepaid_Phone_Flag;
String1100	Filler_Field_4;
End;

Export In_CellPhoneOwners := Record
		String12 MachineName;
		String8 SubfileFiledate; //temp field
		String8 Date_First_Seen;
		String8 Date_Last_Seen;
		String8 Vendor_First_Reported;
		String8 Vendor_Last_Reported;
		String2 SourceCode;
		String50	Appended_First_Name;
		String1	Appended_Middle_Name;
		String100	Appended_Surname;
		String500	Appended_Company_Name;
		String15	Appended_Callerid_Name;
		String30	Appended_Street_Number;
		String2	Appended_Pre_Directional;
		String28	Appended_Street_Name;
		String4	Appended_Street_Suffix;
		String2	Appended_Post_Directional;
		String4	Appended_Unit_Designator;
		String12	Appended_Unit_Number;
		String50	Appended_City;
		String2	Appended_State_Code;
		String5	Appended_Zip_Code;
		String4	Appended_Zip_Code_Extension;
		String3	Delivery_Point_Code;
		String4	Carrier_Route_Code;
		String3	Appended_County_Code;
		String1	Zip4_Type_Code;
		String1	Delivery_Point_Validation;
		String1	Appended_Mail_Able_Flag;
		String8	Validation_Date;
		String10	Appended_Phone;
		String1	Appended_Phone_Type;
		String1	Appended_Direct_In_Dial_Flag;
		String1	Appended_Record_Type;
		String10	Appended_First_Date;
		String10	Appended_Last_Date;
		String50	Appended_Telco_Name;
		String1	Appended_Phone_Score;
		String1	Appended_Directory_Assistance_Flag;
		String5	MCD_Match_Code;
		String2	Match_Type;
		String1	Match_Level;
		String5	Lexis_Nexis_Match_Code;
		String1	Prepaid_Phone_Flag;
		String1100	Filler_Field_4;
End;

Export NID_CellPhoneOwners := RECORD
	  In_CellPhoneOwners and not SubfileFiledate;
	  String1 nametype;
	  String5 cln_title;
	  String20 cln_fname;
	  String20 cln_mname;
	  String20 cln_lname;
	  String5 cln_suffix;
 END;
 
 Export AID_CellPhoneOwners := RECORD
			Unsigned8 raw_aid := 0;  
			NID_CellPhoneOwners;
			String2	Street_pre_direction;//AID_predir
			String2  Street_post_direction;//AID_postdir
			String10	Street_number;//AID_prim_range
			String28	Street_name;//AID_prim_name
			String4  Street_suffix;//AID_addr_suffix
			String8	Unit_number;//AID_sec_range
			String10	Unit_designation;//AID_unit_desig
			String5	Zip5;//AID_zip
			String4	Zip4;//AID_zip4
			String25	City;
			String25  v_city_name;			
			String2	State;//AID_st
			String4	cart;
			String1	cr_sort_sz;
			String4	lot;
			String1	lot_order;
			String2	dbpc;
			String1	chk_digit;
			String2	rec_type;
			String5	county;
			String10	geo_lat;
			String11	geo_long;
			String4	msa;
			String7	geo_blk;
			String1	geo_match;
			String4	err_stat;
End;

Export DID_CellPhoneOwners := Record
			Unsigned6 did := 0;   //known as unique_id or LEX ID for online, generated for customers
			Unsigned1 did_score := 0;	  
			AID_CellPhoneOwners; 
End;	




Export BDID_CellPhoneOwners := Record
		integer8 BDID := 0;
		integer8	BDID_Score := 0;
		DID_CellPhoneOwners;
End;

Export BaseLayout := BDID_CellPhoneOwners;

End;