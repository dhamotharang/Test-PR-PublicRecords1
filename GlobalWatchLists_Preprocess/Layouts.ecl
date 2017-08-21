EXPORT Layouts := MODULE

EXPORT rInputBOE := RECORD
   string Name_6;
   string Name_1;
   string Name_2;
   string Name_3;
   string Name_4;
   string Name_5;
   string Title;
   string DOB;
   string Town_of_Birth;
   string Country_of_Birth;
   string Nationality;
   string Passport_Details;
   string NI_Number;
   string Position;
   string Address_1;
   string Address_2;
   string Address_3;
   string Address_4;
   string Address_5;
   string Address_6;
   string Post_Zip_Code;
   string Country;
   string Other_Information;
   string Group_Type;
   string Alias_Type;
   string Regime;
   string Listed_On;
   string Last_updated;
   string Group_ID;
END;

EXPORT rInputOFAC := RECORD
  string row_data;
END;

EXPORT rOSFICanada := RECORD
  unicode row_data;
END;

EXPORT rOFACPrimary := RECORD
  string 	Record_Type;
  string  SDN_ID;
  string  First_Name;
  string  Last_Name;
  string  Title;
  string  AKA_ID;
  string  AKA_Type;
  string  AKA_Category;
  string  GIV_Designator;
  string  Remarks;
  string  Call_Sign;
  string  Vessel_Type;
  string  Tonnage;
  string  Gross_Registered_Tonnage;
  string  Vessel_Flag;
  string	Vessel_Owner;
END;

EXPORT rOFACProgram := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Program;
END;

EXPORT rOFACAddress := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Address_ID;
  string	Address_Line_1;
  string	Address_Line_2;
  string	Address_Line_3;
  string	Address_City;
  string	Address_State;
  string	Address_Postal_Code;
  string	Address_Country;
END;

EXPORT rOFACID := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	ID_ID;
  string	ID_Type;
  string	ID_Number;
  string	ID_Country;
  string	ID_Issue_Date;
  string	ID_Expiration_Date;
END;

EXPORT rOFACNationality := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Nationality_ID;
  string	Nationality;
  string	Primary_Nationality_Flag;
END;

EXPORT rOFACCitizenship := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Citizenship_ID;
  string	Citizenship;
  string	Primary_Citizenship_Flag;
END;

EXPORT rOFACDOB := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Date_of_Birth_ID;
  string	Date_of_Birth;
  string	Primary_Date_of_Birth_Flag;
end;

EXPORT rOFACPOB := RECORD
  string	Record_Type;
  string	SDN_ID;
  string	Place_of_Birth_ID;
  string	Place_of_Birth;
  string	Primary_Place_of_Birth_Flag;
END;

EXPORT rOFACSanctionCodes := RECORD
	string	SanctionCode;
	string	SanctionName;
END;

EXPORT rCountryCodes := RECORD
  string2 country_code;
  string44 country_name_short;
  string3 country_code_num;
  string5 country_code_5;
  string52 country_name_full;
  string3 country_code_3;
  string55 country_name_alt;
END;

EXPORT rDebarredParties := RECORD
	string Name_Info;
	string DOB;
	string registration_info;
	string Date;
END;


EXPORT rDeniedEntity := RECORD
  string Extract_Date;
  string Extract_Vendor_Code;
  string Data_Type;
  string Country;
  string Entities;
  string License_Requirement;
  string License_Review_Policy;
  string Federal_Register_Citation;
end;

EXPORT rDeniedPersons := RECORD
   string Name;
   string eff_date;
   string exp_date;
   string Standard_Order;
   string Street_Address;
   string Federal_Citation;
   string denial_type;
END;

EXPORT rUnverified := RECORD
  string country;
	string lstd_entity_address;
  string federal_citation_pub_date;
END;

EXPORT rWorldBank := RECORD
  string orig_firm_name;
  string address;
  string country;
  string IneligibilityPeriodfrom;
  string Ineligibilityperiodto;
  string grounds;
END;

EXPORT rInterpolMostWanted := RECORD
  string ID;
  string FamilyName;
  string Forename;
  string Sex;
  string DateofBirth;
  string BirthPlace;
  string Language;
  string Nationality;
  string Offenses;
  string WarrantBy_1;
  string Height;
  string Weight;
  string Hair;
  string Eyes;
  string PhotoName;
END;

EXPORT rInterpolMostWantedINT := RECORD //RL = 15680
  string9 Serial_Number;
  string3 Data_for_Country;
  string3 Language;
  string4 Institution;
  string12 Location;
  string5 Application_Code;
  string5 Plan_Code;
  string30 Account_Number;
  string20 CIF_Key;
  string20 CIF_Key_Binary;
  string15 SS_EID;
  string2 SS_EID_Identifier;
  string8 Date_Processed;
  string1 Change_Delete_Switch;
  string1 Record_Type;
  string50 Line_Data_1;
  string1 Line_Code_1;
  string1 Line_Gender_1;
  string50 Line_Data_2;
  string1 Line_Code_2;
  string1 Line_Gender_2;
  string50 Line_Data_3;
  string1 Line_Code_3;
  string1 Line_Gender_3;
  string50 Line_Data_4;
  string1 Line_Code_4;
  string1 Line_Gender_4;
  string50 Line_Data_5;
  string1 Line_Code_5;
  string1 Line_Gender_5;
  string50 Line_Data_6;
  string1 Line_Code_6;
  string1 Line_Gender_6;
  string50 Line_Data_7;
  string1 Line_Code_7;
  string1 Line_Gender_7;
  string50 Line_Data_8;
  string1 Line_Code_8;
  string1 Line_Gender_8;
  string15 Data_Condition_Codes;
  string20 User_Link_1;
  string20 User_Link_2;
  string18 Link_Key;
  string18 Unlink_Number;
  string15 Date_of_Birth;
  string13 Passport_Number;
  string20 Secondary_User_1;
  string30 Constant_Data;
  string25 Place_of_Birth;
  string25 Review_Data_1;
  string25 Review_Data_2;
  string25 Blocked_Country;
  string2 Filler;
  string70 Check_Data_1;
  string30 Cleaned_First_Name;
  string30 Cleaned_Last_Name;
  string2660 Check_Data_2;
  string100 Original_Primary_Name;
  string1 Original_Gender;
  string50 Original_Title_01;
  string50 Original_Title_02;
  string50 Original_Title_03;
  string50 Original_Title_04;
  string50 Original_Title_05;
  string50 Original_Title_06;
  string50 Original_Title_07;
  string50 Original_Title_08;
  string50 Original_Title_09;
  string50 Original_Title_10;
  string100 Original_Designation_01;
  string100 Original_Designation_02;
  string100 Original_Designation_03;
  string100 Original_Designation_04;
  string100 Original_Designation_05;
  string100 Original_Designation_06;
  string100 Original_Designation_07;
  string100 Original_Designation_08;
  string100 Original_Designation_09;
  string100 Original_Designation_10;
  string25 Original_Natl_ID_01;
  string3 Original_ID_Type_01;
  string25 Original_Natl_ID_02;
  string3 Original_ID_Type_02;
  string25 Original_Natl_ID_03;
  string3 Original_ID_Type_03;
  string25 Original_Natl_ID_04;
  string3 Original_ID_Type_04;
  string25 Original_Natl_ID_05;
  string3 Original_ID_Type_05;
  string25 Original_Natl_ID_06;
  string3 Original_ID_Type_06;
  string25 Original_Natl_ID_07;
  string3 Original_ID_Type_07;
  string25 Original_Natl_ID_08;
  string3 Original_ID_Type_08;
  string25 Original_Natl_ID_09;
  string3 Original_ID_Type_09;
  string25 Original_Natl_ID_10;
  string3 Original_ID_Type_10;
  string50 Original_Alias_01;
  string1 Original_Alias_Code_01;
  string50 Original_Alias_02;
  string1 Original_Alias_Code_02;
  string50 Original_Alias_03;
  string1 Original_Alias_Code_03;
  string50 Original_Alias_04;
  string1 Original_Alias_Code_04;
  string50 Original_Alias_05;
  string1 Original_Alias_Code_05;
  string50 Original_Alias_06;
  string1 Original_Alias_Code_06;
  string50 Original_Alias_07;
  string1 Original_Alias_Code_07;
  string50 Original_Alias_08;
  string1 Original_Alias_Code_08;
  string50 Original_Alias_09;
  string1 Original_Alias_Code_09;
  string50 Original_Alias_10;
  string1 Original_Alias_Code_10;
  string50 Original_Alias_11;
  string1 Original_Alias_Code_11;
  string50 Original_Alias_12;
  string1 Original_Alias_Code_12;
  string50 Original_Alias_13;
  string1 Original_Alias_Code_13;
  string50 Original_Alias_14;
  string1 Original_Alias_Code_14;
  string50 Original_Alias_15;
  string1 Original_Alias_Code_15;
  string50 Original_Alias_16;
  string1 Original_Alias_Code_16;
  string50 Original_Alias_17;
  string1 Original_Alias_Code_17;
  string50 Original_Alias_18;
  string1 Original_Alias_Code_18;
  string50 Original_Alias_19;
  string1 Original_Alias_Code_19;
  string50 Original_Alias_20;
  string1 Original_Alias_Code_20;
  string50 Original_Alias_21;
  string1 Original_Alias_Code_21;
  string50 Original_Alias_22;
  string1 Original_Alias_Code_22;
  string50 Original_Alias_23;
  string1 Original_Alias_Code_23;
  string50 Original_Alias_24;
  string1 Original_Alias_Code_24;
  string50 Original_Alias_25;
  string1 Original_Alias_Code_25;
  string50 Original_Add_01_Line_01;
  string50 Original_Add_01_Line_02;
  string50 Original_Add_01_Line_03;
  string50 Original_Add_01_Line_04;
  string50 Original_Add_02_Line_01;
  string50 Original_Add_02_Line_02;
  string50 Original_Add_02_Line_03;
  string50 Original_Add_02_Line_04;
  string50 Original_Add_03_Line_01;
  string50 Original_Add_03_Line_02;
  string50 Original_Add_03_Line_03;
  string50 Original_Add_03_Line_04;
  string50 Original_Add_04_Line_01;
  string50 Original_Add_04_Line_02;
  string50 Original_Add_04_Line_03;
  string50 Original_Add_04_Line_04;
  string50 Original_Add_05_Line_01;
  string50 Original_Add_05_Line_02;
  string50 Original_Add_05_Line_03;
  string50 Original_Add_05_Line_04;
  string50 Original_Add_06_Line_01;
  string50 Original_Add_06_Line_02;
  string50 Original_Add_06_Line_03;
  string50 Original_Add_06_Line_04;
  string50 Original_Add_07_Line_01;
  string50 Original_Add_07_Line_02;
  string50 Original_Add_07_Line_03;
  string50 Original_Add_07_Line_04;
  string50 Original_Add_08_Line_01;
  string50 Original_Add_08_Line_02;
  string50 Original_Add_08_Line_03;
  string50 Original_Add_08_Line_04;
  string50 Original_Add_09_Line_01;
  string50 Original_Add_09_Line_02;
  string50 Original_Add_09_Line_03;
  string50 Original_Add_09_Line_04;
  string50 Original_Add_10_Line_01;
  string50 Original_Add_10_Line_02;
  string50 Original_Add_10_Line_03;
  string50 Original_Add_10_Line_04;
  string50 Original_Country_01;
  string50 Original_Country_02;
  string50 Original_Country_03;
  string50 Original_Country_04;
  string50 Original_Country_05;
  string50 Original_Country_06;
  string50 Original_Country_07;
  string50 Original_Country_08;
  string50 Original_Country_09;
  string50 Original_Country_10;
  string20 Original_Language_01;
  string20 Original_Language_02;
  string20 Original_Language_03;
  string20 Original_Language_04;
  string20 Original_Language_05;
  string20 Original_Language_06;
  string20 Original_Language_07;
  string20 Original_Language_08;
  string20 Original_Language_09;
  string20 Original_Language_10;
  string25 Original_DOB_01;
  string25 Original_DOB_02;
  string25 Original_DOB_03;
  string25 Original_DOB_04;
  string25 Original_DOB_05;
  string25 Original_DOB_06;
  string25 Original_DOB_07;
  string25 Original_DOB_08;
  string25 Original_DOB_09;
  string25 Original_DOB_10;
  string50 Original_POB_01;
  string50 Original_POB_02;
  string50 Original_POB_03;
  string50 Original_POB_04;
  string50 Original_POB_05;
  string50 Original_POB_06;
  string50 Original_POB_07;
  string50 Original_POB_08;
  string50 Original_POB_09;
  string50 Original_POB_10;
  string20 Original_Sanction_Name_01;
  string20 Original_Sanction_Name_02;
  string20 Original_Sanction_Name_03;
  string20 Original_Sanction_Name_04;
  string20 Original_Sanction_Name_05;
  string20 Original_Sanction_Name_06;
  string20 Original_Sanction_Name_07;
  string20 Original_Sanction_Name_08;
  string20 Original_Sanction_Name_09;
  string20 Original_Sanction_Name_10;
  string8 Original_Sanction_Date_01;
  string8 Original_Sanction_Date_02;
  string8 Original_Sanction_Date_03;
  string8 Original_Sanction_Date_04;
  string8 Original_Sanction_Date_05;
  string8 Original_Sanction_Date_06;
  string8 Original_Sanction_Date_07;
  string8 Original_Sanction_Date_08;
  string8 Original_Sanction_Date_09;
  string8 Original_Sanction_Date_10;
  string8 Original_Date_Added_To_List;
  string8 Original_Date_Removed_From_List;
  string100 Original_Grounds_For_Addition;
  string1000 Original_Crimes;
  string10 Original_NCIC;
  string20 Original_Height;
  string20 Original_Weight;
  string20 Original_Build;
  string25 Original_Hair;
  string20 Original_Eyes;
  string20 Original_Complexion;
  string25 Original_Race;
  string50 Original_Occupation;
  string500 Original_Scars_And_Marks;
  string1000 Original_Additional_Info;
  string1000 Original_Caution;
  string400 Original_Reward;
  string200 Original_Warrant_Issued_By;
  string50 Original_Linked_With_01;
  string50 Original_Linked_With_02;
  string50 Original_Linked_With_03;
  string50 Original_Linked_With_04;
  string50 Original_Linked_With_05;
  string50 Original_Linked_With_06;
  string50 Original_Linked_With_07;
  string50 Original_Linked_With_08;
  string50 Original_Linked_With_09;
  string50 Original_Linked_With_10;
  string8 Original_Call_Sign;
  string25 Original_Vess_Type;
  string14 Original_Tonnage;
  string8 Original_GRT;
  string40 Original_Vess_Flag;
  string150 Original_Vess_Owner;
  string8 Original_Alt_Type;
end;

EXPORT rInnovativeSystems	:= RECORD //RL = 15680
	string9 Serial_Number;
  string3 Data_for_Country;
  string3 Language;
  string4 Institution;
  string12 Location;
  string5 Application_Code;
  string5 Plan_Code;
  string30 Account_Number;
  string20 CIF_Key;
  string20 CIF_Key_Binary;
  string15 SS_EID;
  string2 SS_EID_Identifier;
  string8 Date_Processed;
  string1 Change_Delete_Switch;
  string1 Record_Type;
  string50 Line_Data_1;
  string1 Line_Code_1;
  string1 Line_Gender_1;
  string50 Line_Data_2;
  string1 Line_Code_2;
  string1 Line_Gender_2;
  string50 Line_Data_3;
  string1 Line_Code_3;
  string1 Line_Gender_3;
  string50 Line_Data_4;
  string1 Line_Code_4;
  string1 Line_Gender_4;
  string50 Line_Data_5;
  string1 Line_Code_5;
  string1 Line_Gender_5;
  string50 Line_Data_6;
  string1 Line_Code_6;
  string1 Line_Gender_6;
  string50 Line_Data_7;
  string1 Line_Code_7;
  string1 Line_Gender_7;
  string50 Line_Data_8;
  string1 Line_Code_8;
  string1 Line_Gender_8;
  string15 Data_Condition_Codes;
  string20 User_Link_1;
  string20 User_Link_2;
  string18 Link_Key;
  string18 Unlink_Number;
  string15 Date_of_Birth;
  string13 Passport_Number;
  string20 Secondary_User_1;
  string30 Constant_Data;
  string25 Place_of_Birth;
  string25 Review_Data_1;
  string25 Review_Data_2;
  string25 Blocked_Country;
  string2 Filler;
  string70 Check_Data_1;
  string30 Cleaned_First_Name;
  string30 Cleaned_Last_Name;
  string2660 Check_Data_2;
  string25 Original_Primary_Name_01;
  string25 Original_Primary_Name_02;
  string25 Original_Primary_Name_03;
  string25 Original_Primary_Name_04;
  string1 Original_Gender;
  string50 Original_Title_01;
  string50 Original_Title_02;
  string50 Original_Title_03;
  string50 Original_Title_04;
  string50 Original_Title_05;
  string50 Original_Title_06;
  string50 Original_Title_07;
  string50 Original_Title_08;
  string50 Original_Title_09;
  string50 Original_Title_10;
  string100 Original_Designation_01;
  string100 Original_Designation_02;
  string100 Original_Designation_03;
  string100 Original_Designation_04;
  string100 Original_Designation_05;
  string100 Original_Designation_06;
  string100 Original_Designation_07;
  string100 Original_Designation_08;
  string100 Original_Designation_09;
  string100 Original_Designation_10;
  string25 Original_Natl_ID_01;
  string3 Original_ID_Type_01;
  string25 Original_Natl_ID_02;
  string3 Original_ID_Type_02;
  string25 Original_Natl_ID_03;
  string3 Original_ID_Type_03;
  string25 Original_Natl_ID_04;
  string3 Original_ID_Type_04;
  string25 Original_Natl_ID_05;
  string3 Original_ID_Type_05;
  string25 Original_Natl_ID_06;
  string3 Original_ID_Type_06;
  string25 Original_Natl_ID_07;
  string3 Original_ID_Type_07;
  string25 Original_Natl_ID_08;
  string3 Original_ID_Type_08;
  string25 Original_Natl_ID_09;
  string3 Original_ID_Type_09;
  string25 Original_Natl_ID_10;
  string3 Original_ID_Type_10;
  string50 Original_Alias_01;
  string1 Original_Alias_Code_01;
  string50 Original_Alias_02;
  string1 Original_Alias_Code_02;
  string50 Original_Alias_03;
  string1 Original_Alias_Code_03;
  string50 Original_Alias_04;
  string1 Original_Alias_Code_04;
  string50 Original_Alias_05;
  string1 Original_Alias_Code_05;
  string50 Original_Alias_06;
  string1 Original_Alias_Code_06;
  string50 Original_Alias_07;
  string1 Original_Alias_Code_07;
  string50 Original_Alias_08;
  string1 Original_Alias_Code_08;
  string50 Original_Alias_09;
  string1 Original_Alias_Code_09;
  string50 Original_Alias_10;
  string1 Original_Alias_Code_10;
  string50 Original_Alias_11;
  string1 Original_Alias_Code_11;
  string50 Original_Alias_12;
  string1 Original_Alias_Code_12;
  string50 Original_Alias_13;
  string1 Original_Alias_Code_13;
  string50 Original_Alias_14;
  string1 Original_Alias_Code_14;
  string50 Original_Alias_15;
  string1 Original_Alias_Code_15;
  string50 Original_Alias_16;
  string1 Original_Alias_Code_16;
  string50 Original_Alias_17;
  string1 Original_Alias_Code_17;
  string50 Original_Alias_18;
  string1 Original_Alias_Code_18;
  string50 Original_Alias_19;
  string1 Original_Alias_Code_19;
  string50 Original_Alias_20;
  string1 Original_Alias_Code_20;
  string50 Original_Alias_21;
  string1 Original_Alias_Code_21;
  string50 Original_Alias_22;
  string1 Original_Alias_Code_22;
  string50 Original_Alias_23;
  string1 Original_Alias_Code_23;
  string50 Original_Alias_24;
  string1 Original_Alias_Code_24;
  string50 Original_Alias_25;
  string1 Original_Alias_Code_25;
  string50 Original_Add_01_Line_01;
  string50 Original_Add_01_Line_02;
  string50 Original_Add_01_Line_03;
  string50 Original_Add_01_Line_04;
  string50 Original_Add_02_Line_01;
  string50 Original_Add_02_Line_02;
  string50 Original_Add_02_Line_03;
  string50 Original_Add_02_Line_04;
  string50 Original_Add_03_Line_01;
  string50 Original_Add_03_Line_02;
  string50 Original_Add_03_Line_03;
  string50 Original_Add_03_Line_04;
  string50 Original_Add_04_Line_01;
  string50 Original_Add_04_Line_02;
  string50 Original_Add_04_Line_03;
  string50 Original_Add_04_Line_04;
  string50 Original_Add_05_Line_01;
  string50 Original_Add_05_Line_02;
  string50 Original_Add_05_Line_03;
  string50 Original_Add_05_Line_04;
  string50 Original_Add_06_Line_01;
  string50 Original_Add_06_Line_02;
  string50 Original_Add_06_Line_03;
  string50 Original_Add_06_Line_04;
  string50 Original_Add_07_Line_01;
  string50 Original_Add_07_Line_02;
  string50 Original_Add_07_Line_03;
  string50 Original_Add_07_Line_04;
  string50 Original_Add_08_Line_01;
  string50 Original_Add_08_Line_02;
  string50 Original_Add_08_Line_03;
  string50 Original_Add_08_Line_04;
  string50 Original_Add_09_Line_01;
  string50 Original_Add_09_Line_02;
  string50 Original_Add_09_Line_03;
  string50 Original_Add_09_Line_04;
  string50 Original_Add_10_Line_01;
  string50 Original_Add_10_Line_02;
  string50 Original_Add_10_Line_03;
  string50 Original_Add_10_Line_04;
  string50 Original_Country_01;
  string50 Original_Country_02;
  string50 Original_Country_03;
  string50 Original_Country_04;
  string50 Original_Country_05;
  string50 Original_Country_06;
  string50 Original_Country_07;
  string50 Original_Country_08;
  string50 Original_Country_09;
  string50 Original_Country_10;
  string20 Original_Language_01;
  string20 Original_Language_02;
  string20 Original_Language_03;
  string20 Original_Language_04;
  string20 Original_Language_05;
  string20 Original_Language_06;
  string20 Original_Language_07;
  string20 Original_Language_08;
  string20 Original_Language_09;
  string20 Original_Language_10;
  string25 Original_DOB_01;
  string25 Original_DOB_02;
  string25 Original_DOB_03;
  string25 Original_DOB_04;
  string25 Original_DOB_05;
  string25 Original_DOB_06;
  string25 Original_DOB_07;
  string25 Original_DOB_08;
  string25 Original_DOB_09;
  string25 Original_DOB_10;
  string50 Original_POB_01;
  string50 Original_POB_02;
  string50 Original_POB_03;
  string50 Original_POB_04;
  string50 Original_POB_05;
  string50 Original_POB_06;
  string50 Original_POB_07;
  string50 Original_POB_08;
  string50 Original_POB_09;
  string50 Original_POB_10;
  string20 Original_Sanction_Name_01;
  string20 Original_Sanction_Name_02;
  string20 Original_Sanction_Name_03;
  string20 Original_Sanction_Name_04;
  string20 Original_Sanction_Name_05;
  string20 Original_Sanction_Name_06;
  string20 Original_Sanction_Name_07;
  string20 Original_Sanction_Name_08;
  string20 Original_Sanction_Name_09;
  string20 Original_Sanction_Name_10;
  string8 Original_Sanction_Date_01;
  string8 Original_Sanction_Date_02;
  string8 Original_Sanction_Date_03;
  string8 Original_Sanction_Date_04;
  string8 Original_Sanction_Date_05;
  string8 Original_Sanction_Date_06;
  string8 Original_Sanction_Date_07;
  string8 Original_Sanction_Date_08;
  string8 Original_Sanction_Date_09;
  string8 Original_Sanction_Date_10;
  string8 Original_Date_Added_To_List;
  string8 Original_Date_Removed_From_List;
  string100 Original_Grounds_For_Addition;
  string1000 Original_Crimes;
  string10 Original_NCIC;
  string20 Original_Height;
  string20 Original_Weight;
  string20 Original_Build;
  string25 Original_Hair;
  string20 Original_Eyes;
  string20 Original_Complexion;
  string25 Original_Race;
  string50 Original_Occupation;
  string500 Original_Scars_And_Marks;
  string1000 Original_Additional_Info;
  string1000 Original_Caution;
  string400 Original_Reward;
  string200 Original_Warrant_Issued_By;
  string50 Original_Linked_With_01;
  string50 Original_Linked_With_02;
  string50 Original_Linked_With_03;
  string50 Original_Linked_With_04;
  string50 Original_Linked_With_05;
  string50 Original_Linked_With_06;
  string50 Original_Linked_With_07;
  string50 Original_Linked_With_08;
  string50 Original_Linked_With_09;
  string50 Original_Linked_With_10;
  string8 Original_Call_Sign;
  string25 Original_Vess_Type;
  string14 Original_Tonnage;
  string8 Original_GRT;
  string40 Original_Vess_Flag;
  string150 Original_Vess_Owner;
  string8 Original_Alt_Type;
END;

EXPORT rEUterroristListPerson := RECORD
	string Sflag;
  string Line;
  string FullName;
  string FirstName;
  string LastName;
  string Date_of_Birth;
  string Alt_DoB_1;
  string Alt_DoB_2;
  string Individual_ID;
  string AKA;
  string Passport;
  string ID_Card;
  string ETA_Membership;
  string Other_Membership;
  string Citizenship;
  string Born_In;
END;

EXPORT rEUterroristListGroup := RECORD
	string Record_Num;
  string Unparsed_Data;
  string Sflag;
  string GroupName;
  string Unparsed_Names;
END;

EXPORT rStateDeptOfTerrorists := RECORD
  string Organization;
  string AKA;
END;

EXPORT rFARegistrants := RECORD
	string	Registrant;
	string	Registration_Num;
	string	Registration_Date;
	string	Business_Name;
END;

EXPORT rFAPrincipals	:= RECORD
	string	Country_Location_Represented;
	string	Foreign_Principal;
	string	Foreign_Principal_Registration_Date;
	string	Address;
	string	State;
	string	Registrant;
	string	Registration_Num;
	string	Registration_Date;
END;

EXPORT rFAShortFormRegs	:= RECORD
	string	Short_Form_Name;
	string	Short_Form_Date;
	string	Short_Form_Termination_Date;
	string	Registrant;
	string	Registration_Num;
	string	Registration_Date;
	string	Address;
	string	State;
END;

EXPORT rFAJoinRE_FP	:= RECORD
	string	Country;
	string	Registrant_ID;
	string	Registrant;
	string	Registrant_Terminated;
	string	Address_Line_1;
	string	Address_Line_2;
	string	Address_Line_3;
	string	Foreign_Principal;
	string	orig_raw_name;
END;


	

END;