﻿/*2019-08-17T22:41:57Z (Hennigar, Jennifer (RIS-BCT))
CCPA-256
*/
import AID, address, BIPV2;
export Layouts := module	
	 					
		export Vendor := record, maxlength(100000)
			String10		NPI;
			String1			Entity_Type_Code;
			String10		Replacement_NPI;
			String9			Employer_Identification_Number;
			String70		Provider_Organization_Name;
			String35		Provider_Last_Name; 
			String20		Provider_First_Name;
			String20		Provider_Middle_Name;
			String5  		Provider_Name_Prefix_Text;
			String5  		Provider_Name_Suffix_Text;
			String20 		Provider_Credential_Text;
			String70 		Provider_Other_Organization_Name;
			String1			Provider_Other_Organization_Name_Type_Code;
			String35 		Provider_Other_Last_Name;
			String20 		Provider_Other_First_Name;
			String20 		Provider_Other_Middle_Name;
			String5			Provider_Other_Name_Prefix_Text;
			String5			Provider_Other_Name_Suffix_Text;
			String20 		Provider_Other_Credential_Text;
			String1			Provider_Other_Last_Name_Type_Code;
			String55 		Provider_First_Line_Business_Mailing_Address;
			String55 		Provider_Second_Line_Business_Mailing_Address;
			String40 		Provider_Business_Mailing_Address_City_Name;
			String40 		Provider_Business_Mailing_Address_State_Name;
			String20 		Provider_Business_Mailing_Address_Postal_Code;
			String2			Provider_Business_Mailing_Address_Country_Code;
			String20 		Provider_Business_Mailing_Address_Telephone_Number;
			String20 		Provider_Business_Mailing_Address_Fax_Number;
			String55 		Provider_First_Line_Business_Practice_Location_Address;
			String55 		Provider_Second_Line_Business_Practice_Location_Address;
			String40 		Provider_Business_Practice_Location_Address_City_Name;
			String40 		Provider_Business_Practice_Location_Address_State_Name;
			String20 		Provider_Business_Practice_Location_Address_Postal_Code;
			String2			Provider_Business_Practice_Location_Address_Country_Code;
			String20 		Provider_Business_Practice_Location_Address_Telephone_Number;
			String20 		Provider_Business_Practice_Location_Address_Fax_Number;
			String10 		Provider_Enumeration_Date;
			String10 		Last_Update_Date;
			String2			NPI_Deactivation_Reason_Code;
			String10 		NPI_Deactivation_Date;
			String10 		NPI_Reactivation_Date;
			String1			Provider_Gender_Code;
			String35 		Authorized_Official_Last_Name;
			String20 		Authorized_Official_First_Name;
			String20 		Authorized_Official_Middle_Name;
			String35 		Authorized_Official_Title_or_Position;
			String20 		Authorized_Official_Telephone_Number;
			String10 		Healthcare_Provider_Taxonomy_Code_1;
			String20 		Provider_License_Number_1;
			String2			Provider_License_Number_State_Code_1;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_1;
			String10 		Healthcare_Provider_Taxonomy_Code_2;
			String20 		Provider_License_Number_2;
			String2			Provider_License_Number_State_Code_2;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_2;
			String10 		Healthcare_Provider_Taxonomy_Code_3;
			String20 		Provider_License_Number_3;
			String2			Provider_License_Number_State_Code_3;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_3;
			String10 		Healthcare_Provider_Taxonomy_Code_4;
			String20 		Provider_License_Number_4;
			String2			Provider_License_Number_State_Code_4;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_4;
			String10 		Healthcare_Provider_Taxonomy_Code_5;
			String20 		Provider_License_Number_5;
			String2			Provider_License_Number_State_Code_5;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_5;
			String10 		Healthcare_Provider_Taxonomy_Code_6;
			String20 		Provider_License_Number_6;
			String2			Provider_License_Number_State_Code_6;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_6;
			String10 		Healthcare_Provider_Taxonomy_Code_7;
			String20 		Provider_License_Number_7;
			String2			Provider_License_Number_State_Code_7;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_7;
			String10 		Healthcare_Provider_Taxonomy_Code_8;
			String20 		Provider_License_Number_8;
			String2			Provider_License_Number_State_Code_8;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_8;
			String10 		Healthcare_Provider_Taxonomy_Code_9;
			String20 		Provider_License_Number_9;
			String2			Provider_License_Number_State_Code_9;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_9;
			String10 		Healthcare_Provider_Taxonomy_Code_10;
			String20 		Provider_License_Number_10;
			String2			Provider_License_Number_State_Code_10;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_10;
			String10 		Healthcare_Provider_Taxonomy_Code_11;
			String20 		Provider_License_Number_11;
			String2			Provider_License_Number_State_Code_11;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_11;
			String10 		Healthcare_Provider_Taxonomy_Code_12;
			String20 		Provider_License_Number_12;
			String2			Provider_License_Number_State_Code_12;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_12;
			String10 		Healthcare_Provider_Taxonomy_Code_13;
			String20 		Provider_License_Number_13;
			String2			Provider_License_Number_State_Code_13;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_13;
			String10 		Healthcare_Provider_Taxonomy_Code_14;
			String20 		Provider_License_Number_14;
			String2			Provider_License_Number_State_Code_14;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_14;
			String10 		Healthcare_Provider_Taxonomy_Code_15;
			String20 		Provider_License_Number_15;
			String2			Provider_License_Number_State_Code_15;
			String1			Healthcare_Provider_Primary_Taxonomy_Switch_15;
			String20 		Other_Provider_Identifier_1;
			String2			Other_Provider_Identifier_Type_Code_1;
			String2			Other_Provider_Identifier_State_1;
			String80 		Other_Provider_Identifier_Issuer_1;
			String20 		Other_Provider_Identifier_2;
			String2			Other_Provider_Identifier_Type_Code_2;
			String2			Other_Provider_Identifier_State_2;
			String80 		Other_Provider_Identifier_Issuer_2;
			String20 		Other_Provider_Identifier_3;
			String2			Other_Provider_Identifier_Type_Code_3;
			String2			Other_Provider_Identifier_State_3;
			String80 		Other_Provider_Identifier_Issuer_3;
			String20 		Other_Provider_Identifier_4;
			String2			Other_Provider_Identifier_Type_Code_4;
			String2			Other_Provider_Identifier_State_4;
			String80 		Other_Provider_Identifier_Issuer_4;
			String20 		Other_Provider_Identifier_5;
			String2			Other_Provider_Identifier_Type_Code_5;
			String2			Other_Provider_Identifier_State_5;
			String80 		Other_Provider_Identifier_Issuer_5;
			String20 		Other_Provider_Identifier_6;
			String2			Other_Provider_Identifier_Type_Code_6;
			String2			Other_Provider_Identifier_State_6;
			String80 		Other_Provider_Identifier_Issuer_6;
			String20 		Other_Provider_Identifier_7;
			String2			Other_Provider_Identifier_Type_Code_7;
			String2			Other_Provider_Identifier_State_7;
			String80 		Other_Provider_Identifier_Issuer_7;
			String20 		Other_Provider_Identifier_8;
			String2			Other_Provider_Identifier_Type_Code_8;
			String2			Other_Provider_Identifier_State_8;
			String80 		Other_Provider_Identifier_Issuer_8;
			String20 		Other_Provider_Identifier_9;
			String2			Other_Provider_Identifier_Type_Code_9;
			String2			Other_Provider_Identifier_State_9;
			String80 		Other_Provider_Identifier_Issuer_9;
			String20 		Other_Provider_Identifier_10;
			String2			Other_Provider_Identifier_Type_Code_10;
			String2			Other_Provider_Identifier_State_10;
			String80 		Other_Provider_Identifier_Issuer_10;
			String20 		Other_Provider_Identifier_11;
			String2			Other_Provider_Identifier_Type_Code_11;
			String2			Other_Provider_Identifier_State_11;
			String80 		Other_Provider_Identifier_Issuer_11;
			String20 		Other_Provider_Identifier_12;
			String2			Other_Provider_Identifier_Type_Code_12;
			String2			Other_Provider_Identifier_State_12;
			String80 		Other_Provider_Identifier_Issuer_12;
			String20 		Other_Provider_Identifier_13;
			String2			Other_Provider_Identifier_Type_Code_13;
			String2			Other_Provider_Identifier_State_13;
			String80 		Other_Provider_Identifier_Issuer_13;
			String20 		Other_Provider_Identifier_14;
			String2			Other_Provider_Identifier_Type_Code_14;
			String2			Other_Provider_Identifier_State_14;
			String80 		Other_Provider_Identifier_Issuer_14;
			String20 		Other_Provider_Identifier_15;
			String2			Other_Provider_Identifier_Type_Code_15;
			String2			Other_Provider_Identifier_State_15;
			String80 		Other_Provider_Identifier_Issuer_15;
			String20 		Other_Provider_Identifier_16;
			String2			Other_Provider_Identifier_Type_Code_16;
			String2			Other_Provider_Identifier_State_16;
			String80 		Other_Provider_Identifier_Issuer_16;
			String20 		Other_Provider_Identifier_17;
			String2			Other_Provider_Identifier_Type_Code_17;
			String2			Other_Provider_Identifier_State_17;
			String80 		Other_Provider_Identifier_Issuer_17;
			String20 		Other_Provider_Identifier_18;
			String2			Other_Provider_Identifier_Type_Code_18;
			String2			Other_Provider_Identifier_State_18;
			String80 		Other_Provider_Identifier_Issuer_18;
			String20 		Other_Provider_Identifier_19;
			String2			Other_Provider_Identifier_Type_Code_19;
			String2			Other_Provider_Identifier_State_19;
			String80 		Other_Provider_Identifier_Issuer_19;
			String20 		Other_Provider_Identifier_20;
			String2			Other_Provider_Identifier_Type_Code_20;
			String2			Other_Provider_Identifier_State_20;
			String80 		Other_Provider_Identifier_Issuer_20;
			String20 		Other_Provider_Identifier_21;
			String2			Other_Provider_Identifier_Type_Code_21;
			String2			Other_Provider_Identifier_State_21;
			String80 		Other_Provider_Identifier_Issuer_21;
			String20 		Other_Provider_Identifier_22;
			String2			Other_Provider_Identifier_Type_Code_22;
			String2			Other_Provider_Identifier_State_22;
			String80 		Other_Provider_Identifier_Issuer_22;
			String20 		Other_Provider_Identifier_23;
			String2			Other_Provider_Identifier_Type_Code_23;
			String2			Other_Provider_Identifier_State_23;
			String80 		Other_Provider_Identifier_Issuer_23;
			String20 		Other_Provider_Identifier_24;
			String2			Other_Provider_Identifier_Type_Code_24;
			String2			Other_Provider_Identifier_State_24;
			String80 		Other_Provider_Identifier_Issuer_24;
			String20 		Other_Provider_Identifier_25;
			String2			Other_Provider_Identifier_Type_Code_25;
			String2			Other_Provider_Identifier_State_25;
			String80 		Other_Provider_Identifier_Issuer_25;
			String20 		Other_Provider_Identifier_26;
			String2			Other_Provider_Identifier_Type_Code_26;
			String2			Other_Provider_Identifier_State_26;
			String80 		Other_Provider_Identifier_Issuer_26;
			String20 		Other_Provider_Identifier_27;
			String2			Other_Provider_Identifier_Type_Code_27;
			String2			Other_Provider_Identifier_State_27;
			String80 		Other_Provider_Identifier_Issuer_27;
			String20 		Other_Provider_Identifier_28;
			String2			Other_Provider_Identifier_Type_Code_28;
			String2			Other_Provider_Identifier_State_28;
			String80 		Other_Provider_Identifier_Issuer_28;
			String20 		Other_Provider_Identifier_29;
			String2			Other_Provider_Identifier_Type_Code_29;
			String2			Other_Provider_Identifier_State_29;
			String80 		Other_Provider_Identifier_Issuer_29;
			String20 		Other_Provider_Identifier_30;
			String2			Other_Provider_Identifier_Type_Code_30;
			String2			Other_Provider_Identifier_State_30;
			String80 		Other_Provider_Identifier_Issuer_30;
			String20 		Other_Provider_Identifier_31;
			String2			Other_Provider_Identifier_Type_Code_31;
			String2			Other_Provider_Identifier_State_31;
			String80 		Other_Provider_Identifier_Issuer_31;
			String20 		Other_Provider_Identifier_32;
			String2			Other_Provider_Identifier_Type_Code_32;
			String2			Other_Provider_Identifier_State_32;
			String80 		Other_Provider_Identifier_Issuer_32;
			String20 		Other_Provider_Identifier_33;
			String2			Other_Provider_Identifier_Type_Code_33;
			String2			Other_Provider_Identifier_State_33;
			String80 		Other_Provider_Identifier_Issuer_33;
			String20 		Other_Provider_Identifier_34;
			String2			Other_Provider_Identifier_Type_Code_34;
			String2			Other_Provider_Identifier_State_34;
			String80 		Other_Provider_Identifier_Issuer_34;
			String20 		Other_Provider_Identifier_35;
			String2			Other_Provider_Identifier_Type_Code_35;
			String2			Other_Provider_Identifier_State_35;
			String80 		Other_Provider_Identifier_Issuer_35;
			String20 		Other_Provider_Identifier_36;
			String2			Other_Provider_Identifier_Type_Code_36;
			String2			Other_Provider_Identifier_State_36;
			String80 		Other_Provider_Identifier_Issuer_36;
			String20 		Other_Provider_Identifier_37;
			String2			Other_Provider_Identifier_Type_Code_37;
			String2			Other_Provider_Identifier_State_37;
			String80 		Other_Provider_Identifier_Issuer_37;
			String20 		Other_Provider_Identifier_38;
			String2			Other_Provider_Identifier_Type_Code_38;
			String2			Other_Provider_Identifier_State_38;
			String80 		Other_Provider_Identifier_Issuer_38;
			String20 		Other_Provider_Identifier_39;
			String2			Other_Provider_Identifier_Type_Code_39;
			String2			Other_Provider_Identifier_State_39;
			String80 		Other_Provider_Identifier_Issuer_39;
			String20 		Other_Provider_Identifier_40;
			String2			Other_Provider_Identifier_Type_Code_40;
			String2			Other_Provider_Identifier_State_40;
			String80 		Other_Provider_Identifier_Issuer_40;
			String20 		Other_Provider_Identifier_41;
			String2			Other_Provider_Identifier_Type_Code_41;
			String2			Other_Provider_Identifier_State_41;
			String80 		Other_Provider_Identifier_Issuer_41;
			String20 		Other_Provider_Identifier_42;
			String2			Other_Provider_Identifier_Type_Code_42;
			String2			Other_Provider_Identifier_State_42;
			String80 		Other_Provider_Identifier_Issuer_42;
			String20 		Other_Provider_Identifier_43;
			String2			Other_Provider_Identifier_Type_Code_43;
			String2			Other_Provider_Identifier_State_43;
			String80 		Other_Provider_Identifier_Issuer_43;
			String20 		Other_Provider_Identifier_44;
			String2			Other_Provider_Identifier_Type_Code_44;
			String2			Other_Provider_Identifier_State_44;
			String80 		Other_Provider_Identifier_Issuer_44;
			String20 		Other_Provider_Identifier_45;
			String2			Other_Provider_Identifier_Type_Code_45;
			String2			Other_Provider_Identifier_State_45;
			String80 		Other_Provider_Identifier_Issuer_45;
			String20 		Other_Provider_Identifier_46;
			String2			Other_Provider_Identifier_Type_Code_46;
			String2			Other_Provider_Identifier_State_46;
			String80 		Other_Provider_Identifier_Issuer_46;
			String20 		Other_Provider_Identifier_47;
			String2			Other_Provider_Identifier_Type_Code_47;
			String2			Other_Provider_Identifier_State_47;
			String80 		Other_Provider_Identifier_Issuer_47;
			String20 		Other_Provider_Identifier_48;
			String2			Other_Provider_Identifier_Type_Code_48;
			String2			Other_Provider_Identifier_State_48;
			String80 		Other_Provider_Identifier_Issuer_48;
			String20 		Other_Provider_Identifier_49;
			String2			Other_Provider_Identifier_Type_Code_49;
			String2			Other_Provider_Identifier_State_49;
			String80 		Other_Provider_Identifier_Issuer_49;
			String20 		Other_Provider_Identifier_50;
			String2			Other_Provider_Identifier_Type_Code_50;
			String2			Other_Provider_Identifier_State_50;
			String80 		Other_Provider_Identifier_Issuer_50;
			String1			Is_Sole_Proprietor;
			String1			Is_Organization_Subpart;
			String70		Parent_Organization_LBN;
			String9			Parent_Organization_TIN;
			String5			Authorized_Official_Name_Prefix ;
			String5 		Authorized_Official_Name_Suffix; 
			String20		Authorized_Official_Credential;
			STRING70    Healthcare_Provider_Taxonomy_Group_1;
			STRING70    Healthcare_Provider_Taxonomy_Group_2;
			STRING70    Healthcare_Provider_Taxonomy_Group_3;
			STRING70    Healthcare_Provider_Taxonomy_Group_4;
			STRING70    Healthcare_Provider_Taxonomy_Group_5;
			STRING70    Healthcare_Provider_Taxonomy_Group_6;
			STRING70    Healthcare_Provider_Taxonomy_Group_7;
			STRING70    Healthcare_Provider_Taxonomy_Group_8;
			STRING70    Healthcare_Provider_Taxonomy_Group_9;
			STRING70    Healthcare_Provider_Taxonomy_Group_10;
			STRING70    Healthcare_Provider_Taxonomy_Group_11;
			STRING70    Healthcare_Provider_Taxonomy_Group_12;
			STRING70    Healthcare_Provider_Taxonomy_Group_13;
			STRING70    Healthcare_Provider_Taxonomy_Group_14;
			STRING70    Healthcare_Provider_Taxonomy_Group_15;
		end;
		
		export base_prev := record
			bipv2.IDlayouts.l_xlink_ids;
			unsigned6									did					:= 0;
			unsigned1									did_score		:= 0;
			unsigned6									Bdid							:= 0;
			unsigned1									bdid_score						:= 0;
			string8   									process_date  := '0';
			unsigned4 									dt_first_seen		:= 0								;
			unsigned4 									dt_last_seen		:= 0								;
			unsigned4 									dt_vendor_first_reported	:= 0			;
			unsigned4 									dt_vendor_last_reported		:= 0			;			
			Vendor;
			string100									taxonomy_desc1;
			string100									taxonomy_desc2;
			string100									taxonomy_desc3;
			string100									taxonomy_desc4;
			string100									taxonomy_desc5;
			string100									taxonomy_desc6;
			string100									taxonomy_desc7;
			string100									taxonomy_desc8;
			string100									taxonomy_desc9;
			string100									taxonomy_desc10;
			string100									taxonomy_desc11;
			string100									taxonomy_desc12;
			string100									taxonomy_desc13;
			string100									taxonomy_desc14;
			string100									taxonomy_desc15;			
			string12									entity_type_desc;
			string11									deactivation_reason_desc;
			string26									organization_name_type_desc;
			string17									last_name_type_desc;
			string50                                    mailing_country_desc;
			string50                                    practice_location_country_desc;
			string28                                    other_pid_issuer_desc_1;                
			string28                                    other_pid_issuer_desc_2;                
			string28                                    other_pid_issuer_desc_3;                
			string28                                    other_pid_issuer_desc_4;                
			string28                                    other_pid_issuer_desc_5;                
			string28                                    other_pid_issuer_desc_6;                
			string28                                    other_pid_issuer_desc_7;                
			string28                                    other_pid_issuer_desc_8;                
			string28                                    other_pid_issuer_desc_9;                
			string28                                    other_pid_issuer_desc_10;               
			string28                                    other_pid_issuer_desc_11;               
			string28                                    other_pid_issuer_desc_12;               
			string28                                    other_pid_issuer_desc_13;               
			string28                                    other_pid_issuer_desc_14;               
			string28                                    other_pid_issuer_desc_15;               
			string28                                    other_pid_issuer_desc_16;               
			string28                                    other_pid_issuer_desc_17;               
			string28                                    other_pid_issuer_desc_18;               
			string28                                    other_pid_issuer_desc_19;               
			string28                                    other_pid_issuer_desc_20;               
			string28                                    other_pid_issuer_desc_21;               
			string28                                    other_pid_issuer_desc_22;               
			string28                                    other_pid_issuer_desc_23;               
			string28                                    other_pid_issuer_desc_24;               
			string28                                    other_pid_issuer_desc_25;               
			string28                                    other_pid_issuer_desc_26;               
			string28                                    other_pid_issuer_desc_27;               
			string28                                    other_pid_issuer_desc_28;               
			string28                                    other_pid_issuer_desc_29;               
			string28                                    other_pid_issuer_desc_30;               
			string28                                    other_pid_issuer_desc_31;               
			string28                                    other_pid_issuer_desc_32;               
			string28                                    other_pid_issuer_desc_33;               
			string28                                    other_pid_issuer_desc_34;               
			string28                                    other_pid_issuer_desc_35;               
			string28                                    other_pid_issuer_desc_36;               
			string28                                    other_pid_issuer_desc_37;               
			string28                                    other_pid_issuer_desc_38;               
			string28                                    other_pid_issuer_desc_39;               
			string28                                    other_pid_issuer_desc_40;               
			string28                                    other_pid_issuer_desc_41;               
			string28                                    other_pid_issuer_desc_42;               
			string28                                    other_pid_issuer_desc_43;               
			string28                                    other_pid_issuer_desc_44;               
			string28                                    other_pid_issuer_desc_45;               
			string28                                    other_pid_issuer_desc_46;               
			string28                                    other_pid_issuer_desc_47;               
			string28                                    other_pid_issuer_desc_48;               
			string28                                    other_pid_issuer_desc_49;               
			string28                                    other_pid_issuer_desc_50;               			
			Address.Layout_Clean_Name				clean_name_provider							;
			Address.Layout_Clean_Name				clean_name_provider_other							;
			Address.Layout_Clean_Name				clean_name_authorized_official ;
			string10 									cleanMailingPhone;
			string10 									cleanLocationPhone;
			AID.Common.xAID         					RawAID_Mailing;
			AID.Common.xAID         					AceAID_Mailing;
			string100									Mailing_Prep_Address1;
			string50									Mailing_Prep_AddressLast;
			AID.Common.xAID         					RawAID_Location;			
			AID.Common.xAID         					AceAID_Location;			
			string100									Location_Prep_Address1;
			string50									Location_Prep_AddressLast;		
			unsigned8	source_rec_id;
			unsigned8	 lnpid;
		end;				
		
		export base := record
			bipv2.IDlayouts.l_xlink_ids;
			unsigned6									did												:= 0;
			unsigned1									did_score									:= 0;
			unsigned6									Bdid											:= 0;
			unsigned1									bdid_score								:= 0;
			string8   								process_date  						:= '0';
			unsigned4 								dt_first_seen							:= 0;
			unsigned4 								dt_last_seen							:= 0;
			unsigned4 								dt_vendor_first_reported	:= 0;
			unsigned4 								dt_vendor_last_reported		:= 0;			
			Vendor;
			string100									taxonomy_desc1;
			string100									taxonomy_desc2;
			string100									taxonomy_desc3;
			string100									taxonomy_desc4;
			string100									taxonomy_desc5;
			string100									taxonomy_desc6;
			string100									taxonomy_desc7;
			string100									taxonomy_desc8;
			string100									taxonomy_desc9;
			string100									taxonomy_desc10;
			string100									taxonomy_desc11;
			string100									taxonomy_desc12;
			string100									taxonomy_desc13;
			string100									taxonomy_desc14;
			string100									taxonomy_desc15;			
			string12									entity_type_desc;
			string11									deactivation_reason_desc;
			string26									organization_name_type_desc;
			string17									last_name_type_desc;
			string50                 	mailing_country_desc;
			string50                 	practice_location_country_desc;
			string28                 	other_pid_issuer_desc_1;                
			string28                 	other_pid_issuer_desc_2;                
			string28                 	other_pid_issuer_desc_3;                
			string28                 	other_pid_issuer_desc_4;                
			string28                 	other_pid_issuer_desc_5;                
			string28                 	other_pid_issuer_desc_6;                
			string28                 	other_pid_issuer_desc_7;                
			string28                 	other_pid_issuer_desc_8;                
			string28                 	other_pid_issuer_desc_9;                
			string28                 	other_pid_issuer_desc_10;               
			string28                 	other_pid_issuer_desc_11;               
			string28                 	other_pid_issuer_desc_12;               
			string28                 	other_pid_issuer_desc_13;               
			string28                 	other_pid_issuer_desc_14;               
			string28                 	other_pid_issuer_desc_15;               
			string28                 	other_pid_issuer_desc_16;               
			string28                 	other_pid_issuer_desc_17;               
			string28                 	other_pid_issuer_desc_18;               
			string28                 	other_pid_issuer_desc_19;               
			string28                 	other_pid_issuer_desc_20;               
			string28                 	other_pid_issuer_desc_21;               
			string28                 	other_pid_issuer_desc_22;               
			string28                 	other_pid_issuer_desc_23;               
			string28                 	other_pid_issuer_desc_24;               
			string28                 	other_pid_issuer_desc_25;               
			string28                 	other_pid_issuer_desc_26;               
			string28                 	other_pid_issuer_desc_27;               
			string28                 	other_pid_issuer_desc_28;               
			string28                 	other_pid_issuer_desc_29;               
			string28                 	other_pid_issuer_desc_30;               
			string28                 	other_pid_issuer_desc_31;               
			string28                 	other_pid_issuer_desc_32;               
			string28                 	other_pid_issuer_desc_33;               
			string28                 	other_pid_issuer_desc_34;               
			string28                 	other_pid_issuer_desc_35;               
			string28                 	other_pid_issuer_desc_36;               
			string28                 	other_pid_issuer_desc_37;               
			string28                 	other_pid_issuer_desc_38;               
			string28                 	other_pid_issuer_desc_39;               
			string28                 	other_pid_issuer_desc_40;               
			string28                 	other_pid_issuer_desc_41;               
			string28                 	other_pid_issuer_desc_42;               
			string28                 	other_pid_issuer_desc_43;               
			string28                 	other_pid_issuer_desc_44;               
			string28                 	other_pid_issuer_desc_45;               
			string28                 	other_pid_issuer_desc_46;               
			string28                 	other_pid_issuer_desc_47;               
			string28                  other_pid_issuer_desc_48;               
			string28                  other_pid_issuer_desc_49;               
			string28                  other_pid_issuer_desc_50;               			
			Address.Layout_Clean_Name	clean_name_provider;
			Address.Layout_Clean_Name	clean_name_provider_other;
			Address.Layout_Clean_Name	clean_name_authorized_official;
			string10 									cleanMailingPhone;
			string10 									cleanLocationPhone;
			AID.Common.xAID         	RawAID_Mailing;
			AID.Common.xAID         	AceAID_Mailing;
			string100									Mailing_Prep_Address1;
			string50									Mailing_Prep_AddressLast;
			AID.Common.xAID         	RawAID_Location;			
			AID.Common.xAID         	AceAID_Location;			
			string100									Location_Prep_Address1;
			string50									Location_Prep_AddressLast;		
			unsigned8									source_rec_id;
			unsigned8	 								lnpid;
			integer2									xadl2_weight 				:= 0;	// HC-1224
			unsigned2									xadl2_score	 				:= 0;
			integer1									xadl2_distance			:= 0;
			unsigned4									xadl2_keys_used			:= 0;
			string										xadl2_keys_desc			:= '';
			string60									xadl2_matches				:= '';
			string										xadl2_matches_desc	:= '';
			unsigned4 								global_sid					:= 22931; // Source ID for NPPES - CCPA project 20190528  
			unsigned8 								record_sid; 
		end;				
		
		
		export Address_Layout := record
			unsigned8										unique_id;	        //to denormalize to original record
			unsigned4										address_type;   	//mailing or location
			string100										Append_Prep_Address1;
			string50										Append_Prep_AddressLast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
			Address.Layout_Clean182_fips							Clean_Address;
		end;
		
		export KeyBuildFirst := record
			integer                 unique_id; 
			base;			
			// base // - [xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];			
			Address.Layout_Clean182_fips 				clean_mailing_address;
			Address.Layout_Clean182_fips        clean_location_address;
			unsigned1 zero := 0;
			end;
			
		export KeyBuildFirst_noxadl := record
			integer                 unique_id; 
			base - [xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];			
			Address.Layout_Clean182_fips 				clean_mailing_address;
			Address.Layout_Clean182_fips        clean_location_address;
			unsigned1 zero := 0;
			end;
			
		export KeyBuild_BIP := record
			// base - [lnpid];		
			base - [lnpid, xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];						
			Address.Layout_Clean182_fips 				clean_mailing_address;
			Address.Layout_Clean182_fips        clean_location_address;
			Address.Layout_Clean182_fips 				clean_norm_address;
			unsigned1 zero := 0;
			end;

		export KeyBuild := record
			KeyBuild_BIP -bipv2.IDlayouts.l_xlink_ids -source_rec_id;
			end;
			
		export TempKeyBuild := record			//For BDID and DID purposes
			integer                 unique_id; 
			base;			
			// base // - [xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];						
			Address.Layout_Clean182_fips 				clean_mailing_address;
			Address.Layout_Clean182_fips                 clean_location_address;
			string10	mailing_prim_range; 			
			string28	mailing_prim_name;				
			string8		mailing_sec_range;				
			string2		mailing_st;	
			string5		mailing_zip;	
			string10	location_prim_range; 			
			string28	location_prim_name;				
			string8		location_sec_range;	
			string25	location_p_city_name;
			string2		location_st;	
			string5		location_zip;	
			string20    provider_fname;
			string20    provider_mname;
			string20    provider_lname;
			string5     provider_name_suffix;
			string2		source;
			end; 					
			
		EXPORT Input_Taxonomy := RECORD
		  STRING10 taxonomy_code;
			STRING   taxonomy_type;
			STRING   classification;
			STRING   specialization;
			STRING   definition;
			STRING10 effective_date;					// stored as MM/DD/YYYY
			STRING10 deactivation_date;				// stored as MM/DD/YYYY
			STRING10 last_modification_date;	// stored as MM/DD/YYYY
			STRING   notes;
		END;
end;                