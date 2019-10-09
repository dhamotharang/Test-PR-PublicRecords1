﻿import demowatchlistscreening, dx_demowatchlistscreening;

EXPORT Layouts := module
	
	export matches_entity_name := dx_DemoWatchlistScreening.layouts.matches_entity_name_layout;
/*	
export matches_entity_name := record
	String50	Block_ID;
	String50	Error_Message;
	String50	Warning_Message;
	String50	Search_Time;
	String50	Write_Time;
	String50	Entity_Records_Error_Message;
	String50	Entity_Records_Warning_Message;
	String50	Input_Record_Screening_List_Subset_Index;
	String50	Input_Record_EFT_Info_ID;
	String50	Input_Record_EFT_Info_Type;
	String50	Input_Record_EFT_Info_OFAC_Screened;
	String50	Input_Record_EFT_Info_OFAC_Screened2;
	String50	Input_Record_Reference_ID;
	String50	Input_Record_Reference_Number;
	String50	Input_Record_Entity_Type;
	String150	Input_Record_Name_Full;
	String50	Input_Record_Name_Title;
	String50	Input_Record_Name_First;
	String50	Input_Record_Name_Middle;
	String50	Input_Record_Name_Last;
	String50	Input_Record_Name_Generation;
	String50	Input_Record_Gender;
	String100	Input_Record_Addresses_Full_Address;
	String100	Input_Record_Addresses_Street_Address1;
	String100	Input_Record_Addresses_Street_Address2;
	String50	Input_Record_Addresses_Building_Or_Street_Number;
	String50	Input_Record_Addresses_Street_Pre_Direction;
	String50	Input_Record_Addresses_Street_Suffix_Or_Type;
	String50	Input_Record_Addresses_Sub_Building_Number;
	String50	Input_Record_Addresses_Type;
	String50	Input_Record_Addresses_Unit_Designation;
	String50	Input_Record_Addresses_Unit_Number;
	String50	Input_Record_Addresses_City;
	String50	Input_Record_Addresses_Postal_Code;
	String50	Input_Record_Addresses_State_Province_District;
	String50	Input_Record_Addresses_County;
	String50	Input_Record_Addresses_Country;
	String100	Input_Record_Addresses_Comments;
	String50	Input_Record_Addresses_Reference_Code;
	String50	Input_Record_Additional_Information_Type;
	String50	Input_Record_Additional_Information_Label;
	String50	Input_Record_Additional_Information_Value;
	String100	Input_Record_Additional_Information_Comments;
	String50	Input_Record_Phones_Type;
	String50	Input_Record_Phones_Number;
	String100	Input_Record_Phones_Comments;
	String50	Input_Record_Identification_Type;
	String50	Input_Record_Identification_Issued_Date;
	String50	Input_Record_Identification_Expiration_Date;
	String50	Input_Record_Identification_Issuer;
	String50	Input_Record_Identification_Label;
	String50	Input_Record_Identification_Number;
	String100	Input_Record_Identification_Comments;
	String50	Matches_Address_Additional_Information_EFT_Value;
	String50	Matches_Address_Additional_Information_Partial_Address;
	String50	Matches_Address_Additional_Information_Score;
	String50	Matches_Address_Additional_Information_Score_ID;
	String50	Matches_Address_Additional_Information_Value_Type;
	String50	Matches_Address_Additional_Information_Input_Instance;
	String50	Matches_Address_Best_Score;
	String50	Matches_Address_Best;
	String50	Matches_Address_Best_Is_Partial;
	String50	Matches_Address_Conflict;
	String50	Matches_Address_Index_Match;
	String50	Matches_Address_Best_Input_ID;
	String50	Matches_Address_Best_List_ID;
	String2		Matches_Address_Address_Details_ID_1;
	String50	Matches_Address_Address_Details_Type_1;
	String100	Matches_Address_Address_Details_Full_Address_1;
	String100	Matches_Address_Address_Details_Street_Address1_1;
	String100	Matches_Address_Address_Details_Street_Address2_1;
	String50	Matches_Address_Address_Details_City_1;
	String50	Matches_Address_Address_Details_State_1;
	String50	Matches_Address_Address_Details_Postal_Code_1;
	String50	Matches_Address_Address_Details_Country_1;
	String100	Matches_Address_Address_Details_Notes_1;
	String2		Matches_Address_Address_Details_ID_2;
	String50	Matches_Address_Address_Details_Type_2;
	String100	Matches_Address_Address_Details_Full_Address_2;
	String100	Matches_Address_Address_Details_Street_Address1_2;
	String100	Matches_Address_Address_Details_Street_Address2_2;
	String50	Matches_Address_Address_Details_City_2;
	String50	Matches_Address_Address_Details_State_2;
	String50	Matches_Address_Address_Details_Postal_Code_2;
	String50	Matches_Address_Address_Details_Country_2;
	String100	Matches_Address_Address_Details_Notes_2;
	String2		Matches_Address_Address_Details_ID_3;
	String50	Matches_Address_Address_Details_Type_3;
	String100	Matches_Address_Address_Details_Full_Address_3;
	String100	Matches_Address_Address_Details_Street_Address1_3;
	String100	Matches_Address_Address_Details_Street_Address2_3;
	String50	Matches_Address_Address_Details_City_3;
	String50	Matches_Address_Address_Details_State_3;
	String50	Matches_Address_Address_Details_Postal_Code_3;
	String50	Matches_Address_Address_Details_Country_3;
	String100	Matches_Address_Address_Details_Notes_3;
	String2		Matches_Address_Address_Details_ID_4;
	String50	Matches_Address_Address_Details_Type_4;
	String100	Matches_Address_Address_Details_Full_Address_4;
	String100	Matches_Address_Address_Details_Street_Address1_4;
	String100	Matches_Address_Address_Details_Street_Address2_4;
	String50	Matches_Address_Address_Details_City_4;
	String50	Matches_Address_Address_Details_State_4;
	String50	Matches_Address_Address_Details_Postal_Code_4;
	String50	Matches_Address_Address_Details_Country_4;
	String100	Matches_Address_Address_Details_Notes_4;
	String2		Matches_Address_Address_Details_ID_5;
	String50	Matches_Address_Address_Details_Type_5;
	String100	Matches_Address_Address_Details_Full_Address_5;
	String100	Matches_Address_Address_Details_Street_Address1_5;
	String100	Matches_Address_Address_Details_Street_Address2_5;
	String50	Matches_Address_Address_Details_City_5;
	String50	Matches_Address_Address_Details_State_5;
	String50	Matches_Address_Address_Details_Postal_Code_5;
	String50	Matches_Address_Address_Details_Country_5;
	String100	Matches_Address_Address_Details_Notes_5;
	String50	Matches_Citizenship_Best_Score;
	String50	Matches_Citizenship_Citizenships_EFT_Value;
	String50	Matches_Citizenship_Citizenships_Partial_Address;
	String50	Matches_Citizenship_Citizenships_Score;
	String50	Matches_Citizenship_Citizenships_Source_ID;
	String50	Matches_Citizenship_Citizenships_Value_Type;
	String50	Matches_Citizenship_Citizenships_Input_Instance;
	String50	Matches_Citizenship_Conflict;
	String50	Matches_Country_Best;
	String50	Matches_Country_Best_ID;
	String50	Matches_Country_Best_Score;
	String50	Matches_Country_Best_Type;
	String50	Matches_Country_Conflict;
	String50	Matches_Country_Input_Instance;
	String50	Matches_Country_Input_Type;
	String50	Matches_DOB_Best_Is_Partial;
	String50	Matches_DOB_Best_Score;
	String50	Matches_DOB_Conflict;
	String50	Matches_DOB_Additional_Information_EFT_Value;
	String50	Matches_DOB_Additional_Information_Partial_Address;
	String50	Matches_DOB_Additional_Information_Score;
	String50	Matches_DOB_Additional_Information_Source_ID;
	String50	Matches_DOB_Additional_Information_Value_Type;
	String50	Matches_DOB_Additional_Information_Input_Instance;
	String50	Matches_EFT_Context_End;
	String50	Matches_EFT_Context_Start;
	String50	Matches_EFT_Match;
	String50	Matches_Entity_Entity_Details_Check_Sum;
	String50	Matches_Entity_Entity_Details_Country;
	String50	Matches_Entity_Entity_Details_Date;
	String50	Matches_Entity_Entity_Details_Gender;
	String150	Matches_Entity_Entity_Details_Name_Full;
	String50	Matches_Entity_Entity_Details_Name_Title;
	String50	Matches_Entity_Entity_Details_Name_First;
	String50	Matches_Entity_Entity_Details_Name_Middle;
	String50	Matches_Entity_Entity_Details_Name_Last;
	String50	Matches_Entity_Entity_Details_Name_Generation;
	String500	Matches_Entity_Entity_Details_Notes;
	String50	Matches_Entity_Entity_Details_Number;
	String50	Matches_Entity_Entity_Details_Reason;
	String50	Matches_Entity_Entity_Details_Type;
	String50	Matches_Entity_Entity_Unique_ID;
	String50	Matches_Entity_Search_Criteria;
	String50	Matches_Entity_Match_Realert;
	String150	Matches_Entity_Name;
	String50	Matches_Entity_Offset;
	String50	Matches_Entity_Prev_Result_ID;
	String50	Matches_Entity_Score;
	String50	Matches_Entity_Source_Number;
	String50	Matches_Entity_Type_Conflict;
	String50	Matches_File_Build;
	String50	Matches_File_Custom;
	String50	Matches_File_ID;
	String50	Matches_File_Index;
	String150	Matches_File_Name;
	String50	Matches_File_Published;
	String50	Matches_File_Type;
	String50	Matches_Gender_Conflict;
	String50	Matches_ID_Best_Score;
	String50	Matches_ID_Conflict;
	String50	Matches_ID_Additional_Information_EFT_Value;
	String50	Matches_ID_Additional_Information_Partial_Address;
	String50	Matches_ID_Additional_Information_Score;
	String50	Matches_ID_Additional_Information_Source_ID;
	String50	Matches_ID_Additional_Information_Value_Type;
	String50	Matches_ID_Additional_Information_Input_Instance;
	String50	Matches_ID_Index_Match;
	String50	Matches_ID_Identification_Details_ID;
	String50	Matches_ID_Identification_Details_Type;
	String50	Matches_ID_Identification_Details_Label;
	String50	Matches_ID_Identification_Details_Number;
	String50	Matches_ID_Identification_Details_Issuer;
	String50	Matches_ID_Identification_Details_Issue_Date;
	String50	Matches_ID_Identification_Details_Exp_Date;
	String100	Matches_ID_Identification_Details_Notes;
	String50	Matches_Name_Address_Name;
	String50	Matches_Name_Address_Input_Instance;
	String100	Matches_Name_Best;
	String50	Matches_Name_Best_ID;
	String50	Matches_Name_Best_Score;
	String50	Matches_Name_Conflict;
	String50	Matches_Name_Index_Match;
	String50	Matches_Name_Alt_Names_ID;
	String50	Matches_Name_Alt_Names_Value;
	String150	Matches_Name_AKAs_Full_1;
	String50	Matches_Name_AKAs_Title_1;
	String50	Matches_Name_AKAs_First_1;
	String50	Matches_Name_AKAs_Middle_1;
	String50	Matches_Name_AKAs_Last_1;
	String50	Matches_Name_AKAs_Generation_1;
	String2		Matches_Name_AKAs_ID_1;
	String50	Matches_Name_AKAs_Type_1;
	String50	Matches_Name_AKAs_Category_1;
	String100	Matches_Name_AKAs_Notes_1;
	String150	Matches_Name_AKAs_Full_2;
	String50	Matches_Name_AKAs_Title_2;
	String50	Matches_Name_AKAs_First_2;
	String50	Matches_Name_AKAs_Middle_2;
	String50	Matches_Name_AKAs_Last_2;
	String50	Matches_Name_AKAs_Generation_2;
	String2		Matches_Name_AKAs_ID_2;
	String50	Matches_Name_AKAs_Type_2;
	String50	Matches_Name_AKAs_Category_2;
	String100	Matches_Name_AKAs_Notes_2;
	String150	Matches_Name_AKAs_Full_3;
	String50	Matches_Name_AKAs_Title_3;
	String50	Matches_Name_AKAs_First_3;
	String50	Matches_Name_AKAs_Middle_3;
	String50	Matches_Name_AKAs_Last_3;
	String50	Matches_Name_AKAs_Generation_3;
	String2		Matches_Name_AKAs_ID_3;
	String50	Matches_Name_AKAs_Type_3;
	String50	Matches_Name_AKAs_Category_3;
	String100	Matches_Name_AKAs_Notes_3;
	String150	Matches_Name_AKAs_Full_4;
	String50	Matches_Name_AKAs_Title_4;
	String50	Matches_Name_AKAs_First_4;
	String50	Matches_Name_AKAs_Middle_4;
	String50	Matches_Name_AKAs_Last_4;
	String50	Matches_Name_AKAs_Generation_4;
	String2		Matches_Name_AKAs_ID_4;
	String50	Matches_Name_AKAs_Type_4;
	String50	Matches_Name_AKAs_Category_4;
	String100	Matches_Name_AKAs_Notes_4;
	String150	Matches_Name_AKAs_Full_5;
	String50	Matches_Name_AKAs_Title_5;
	String50	Matches_Name_AKAs_First_5;
	String50	Matches_Name_AKAs_Middle_5;
	String50	Matches_Name_AKAs_Last_5;
	String50	Matches_Name_AKAs_Generation_5;
	String2		Matches_Name_AKAs_ID_5;
	String50	Matches_Name_AKAs_Type_5;
	String50	Matches_Name_AKAs_Category_5;
	String100	Matches_Name_AKAs_Notes_5;
	String150	Matches_Name_AKAs_Full_6;
	String50	Matches_Name_AKAs_Title_6;
	String50	Matches_Name_AKAs_First_6;
	String50	Matches_Name_AKAs_Middle_6;
	String50	Matches_Name_AKAs_Last_6;
	String50	Matches_Name_AKAs_Generation_6;
	String2		Matches_Name_AKAs_ID_6;
	String50	Matches_Name_AKAs_Type_6;
	String50	Matches_Name_AKAs_Category_6;
	String100	Matches_Name_AKAs_Notes_6;
	String150	Matches_Name_AKAs_Full_7;
	String50	Matches_Name_AKAs_Title_7;
	String50	Matches_Name_AKAs_First_7;
	String50	Matches_Name_AKAs_Middle_7;
	String50	Matches_Name_AKAs_Last_7;
	String50	Matches_Name_AKAs_Generation_7;
	String2		Matches_Name_AKAs_ID_7;
	String50	Matches_Name_AKAs_Type_7;
	String50	Matches_Name_AKAs_Category_7;
	String100	Matches_Name_AKAs_Notes_7;
	String150	Matches_Name_AKAs_Full_8;
	String50	Matches_Name_AKAs_Title_8;
	String50	Matches_Name_AKAs_First_8;
	String50	Matches_Name_AKAs_Middle_8;
	String50	Matches_Name_AKAs_Last_8;
	String50	Matches_Name_AKAs_Generation_8;
	String2		Matches_Name_AKAs_ID_8;
	String50	Matches_Name_AKAs_Type_8;
	String50	Matches_Name_AKAs_Category_8;
	String100	Matches_Name_AKAs_Notes_8;
	String150	Matches_Name_AKAs_Full_9;
	String50	Matches_Name_AKAs_Title_9;
	String50	Matches_Name_AKAs_First_9;
	String50	Matches_Name_AKAs_Middle_9;
	String50	Matches_Name_AKAs_Last_9;
	String50	Matches_Name_AKAs_Generation_9;
	String2		Matches_Name_AKAs_ID_9;
	String50	Matches_Name_AKAs_Type_9;
	String50	Matches_Name_AKAs_Category_9;
	String100	Matches_Name_AKAs_Notes_9;
	String150	Matches_Name_AKAs_Full_10;
	String50	Matches_Name_AKAs_Title_10;
	String50	Matches_Name_AKAs_First_10;
	String50	Matches_Name_AKAs_Middle_10;
	String50	Matches_Name_AKAs_Last_10;
	String50	Matches_Name_AKAs_Generation_10;
	String2		Matches_Name_AKAs_ID_10;
	String50	Matches_Name_AKAs_Type_10;
	String50	Matches_Name_AKAs_Category_10;
	String100	Matches_Name_AKAs_Notes_10;
	String50	Matches_Phone_Best_Score;
	String50	Matches_Phone_Conflict;
	String50	Matches_Phone_Index_Match;
	String50	Matches_Phone_Additional_Information_EFT_Value;
	String50	Matches_Phone_Additional_Information_Partial_Address;
	String50	Matches_Phone_Additional_Information_Score;
	String50	Matches_Phone_Additional_Information_Source_ID;
	String50	Matches_Phone_Additional_Information_Value_Type;
	String50	Matches_Phone_Additional_Information_Input_Instance;
	String50	Matches_Phone_Phone_Details_ID;
	String50	Matches_Phone_Phone_Details_Type;
	String50	Matches_Phone_Phone_Details_Number;
	String100	Matches_Phone_Phone_Details_Notes;
	String2		Matches_Codes_ID_1;
	String50	Matches_Codes_Value_1;
	String2		Matches_Codes_ID_2;
	String50	Matches_Codes_Value_2;
	String2		Matches_Codes_ID_3;
	String50	Matches_Codes_Value_3;
	String2		Matches_Codes_ID_4;
	String50	Matches_Codes_Value_4;
	String2		Matches_Codes_ID_5;
	String50	Matches_Codes_Value_5;
	String2		Matches_Terms_ID_1;
	String50	Matches_Terms_Values_1;
	String2		Matches_Terms_ID_2;
	String50	Matches_Terms_Values_2;
	String2		Matches_Terms_ID_3;
	String50	Matches_Terms_Values_3;
	String2		Matches_Terms_ID_4;
	String50	Matches_Terms_Values_4;
	String2		Matches_Terms_ID_5;
	String50	Matches_Terms_Values_5;
	String2		Matches_Cities_ID_1;
	String50	Matches_Cities_Value_1;
	String2		Matches_Cities_ID_2;
	String50	Matches_Cities_Value_2;
	String2		Matches_Cities_ID_3;
	String50	Matches_Cities_Value_3;
	String2		Matches_Cities_ID_4;
	String50	Matches_Cities_Value_4;
	String2		Matches_Cities_ID_5;
	String50	Matches_Cities_Value_5;
	String2		Matches_Ports_ID_1;
	String50	Matches_Ports_Value_1;
	String2		Matches_Ports_ID_2;
	String50	Matches_Ports_Value_2;
	String2		Matches_Ports_ID_3;
	String50	Matches_Ports_Value_3;
	String2		Matches_Ports_ID_4;
	String50	Matches_Ports_Value_4;
	String2		Matches_Ports_ID_5;
	String50	Matches_Ports_Value_5;
	String2		Matches_Descriptions_ID_1;
	String50	Matches_Descriptions_Type_1;
	String50	Matches_Descriptions_Value_1;
	String100	Matches_Descriptions_Notes_1;
	String2		Matches_Descriptions_ID_2;
	String50	Matches_Descriptions_Type_2;
	String50	Matches_Descriptions_Value_2;
	String100	Matches_Descriptions_Notes_2;
	String2		Matches_Descriptions_ID_3;
	String50	Matches_Descriptions_Type_3;
	String50	Matches_Descriptions_Value_3;
	String100	Matches_Descriptions_Notes_3;
	String2		Matches_Descriptions_ID_4;
	String50	Matches_Descriptions_Type_4;
	String50	Matches_Descriptions_Value_4;
	String100	Matches_Descriptions_Notes_4;
	String2		Matches_Descriptions_ID_5;
	String50	Matches_Descriptions_Type_5;
	String50	Matches_Descriptions_Value_5;
	String100	Matches_Descriptions_Notes_5;
end;
*/

end;