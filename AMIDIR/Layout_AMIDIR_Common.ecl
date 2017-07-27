export Layout_AMIDIR_Common := record
	string30  Key;
	string8   Process_Date;
	string8   Date_First_Seen;
	string8   Date_Last_Seen;
	string8   Date_Vendor_First_Reported;
	string8   Date_Vendor_Last_Reported;
	string11  Physician_First_Name;	
	string14  Physician_Last_Name;
	string30  Physician_Full_Name;  
	string3   Physician_Prof_Suffix_Code;
	string6   Physician_Prof_Suffix;
	string1   Physician_Gender_Code;	
	string6   Physician_Gender;
	string4   Physician_Year_Of_Birth;
	string3   Primary_Specialty_Code;
	string50  Primary_Specialty;
	string3   Secondary_Specialty_Code;
	string50  Secondary_Specialty;
	string1   Practice_Type_Code;
	string30  Practice_Type;
	string1   Board_Certification_Indicator;
	string3   Board_Certification;
	string4   Year_Graduated;
	string1   Professional_Degree_Code;
	string10  Professional_Degree;
	string5   Medical_School_Code;
	string60  Medical_School_Name;
	string4   Patients_Per_Week;
	string1   Prescriptions_Per_Week_Code;
	string4   Prescriptions_Per_Week_High;
	string4   Prescriptions_Per_Week_Low;
	string7   Hospital_Affiliation_Code;   	
	string60  Hospital_Affiliation;       
	string1   Patients_Treated_Cardiovascular_Code;
	string3   Patients_Treated_Cardiovascular_High;		
	string3   Patients_Treated_Cardiovascular_Low;		
	string1   Patients_Treated_Hypertension_Code;
	string3   Patients_Treated_Hypertension_High;
	string3   Patients_Treated_Hypertension_Low;
	string1   Patients_Treated_Hypercholerterlemia_Code;
	string3   Patients_Treated_Hypercholerterlemia_High;
	string3   Patients_Treated_Hypercholerterlemia_Low;
	string1   Patients_Treated_Fertility_Code;
	string3   Patients_Treated_Fertility_High;
	string3   Patients_Treated_Fertility_Low;
	string1   Patients_Treated_Sexually_Transmit_Code;
	string3   Patients_Treated_Sexually_Transmit_High;
	string3   Patients_Treated_Sexually_Transmit_Low;
	string1   Patients_Treated_Diabetes_Code;
	string3   Patients_Treated_Diabetes_High;
	string3   Patients_Treated_Diabetes_Low;
	string1   Patients_Treated_CNS_Disorders_Code;
	string3   Patients_Treated_CNS_Disorders_High;
	string3   Patients_Treated_CNS_Disorders_Low;
	string1   Patients_Treated_HIV_Code;
	string3   Patients_Treated_HIV_High;
	string3   Patients_Treated_HIV_Low;
	string1   Patients_Treated_Lasik_Surgery_Code;
	string3   Patients_Treated_Lasik_Surgery_High;
	string3   Patients_Treated_Lasik_Surgery_Low;
	string1   Patients_Treated_Cataracts_Code;
	string3   Patients_Treated_Cataracts_High;
	string3   Patients_Treated_Cataracts_Low;
	string1   Patients_Treated_Contact_Lens_Code;
	string3   Patients_Treated_Contact_Lens_High;
	string3   Patients_Treated_Contact_Lens_Low;
	string2   State_Of_License;
	string2   Country_Of_License;
	string30  License_Number;
	string8   Expiration_Date;
	string3   License_Board_Type_Code; 
	string6   License_Board_Type;
	string4   Physician_Activity_Financial_Code;
	string3   Physician_Activity_Financial;
	string4   Physician_Activity_Boat_Code;
	string3   Physician_Activity_Boating;
	string4   Physician_Activity_Fish_Code;
	string3   Physician_Activity_Fishing;
	string4   Physician_Activity_Golf_Code;
	string3   Physician_Activity_Golf;
	string4   Physician_Activity_Snow_Ski_Code;		
	string3   Physician_Activity_Snow_Ski;
	string4   Physician_Activity_Tennis_Code;
	string3   Physician_Activity_Tennis;
	string4   Physician_Activity_Cruise_Code;
	string3   Physician_Activity_Cruise;
	string30  Business_Name;
	string30  Business_Address_Street_Line;
	string16  Business_Address_City;
	string2   Business_Address_State;
	string2   Business_Address_State_Code;
	string5   Business_Address_Zip_5; 
	string4   Business_Address_Zip_4; 
	string3   Business_Address_County_Code;   
	string20  Business_Address_County;
	string1   Business_Address_Type_Code;
	string20  Business_Address_Type;
	string10  Business_Phone;
	string1   Employee_Size_Code;
	string6   Employee_Size_High;
	string6   Employee_Size_Low;
	string3   Business_Type_Code;		
	string30  Business_Type;
	string14  Office_Manager_Last_Name;
	string11  Office_Manager_First_Name;
	string5   Number_Of_Nurses;
	string5   Number_Of_Nurse_Practitioners;
	string5   Number_Of_Physician_Assistants;
	string5   Number_Of_Dental_Hygienists;
	string5   Number_Of_Dental_Office_Chairs;
	string9   ABI_Number;
	string6   SIC;
	string9   Current_Linkage_Number;   
	string6   UPIN;
	string9   DEA_Number;	
	string7   Hospital_Number;
	string35  Hospital_Name;
	string8   Physician_DOB_yyyymmdd;
	string5   Physician_Name_Clean_title;
	string20  Physician_Name_Clean_fname;
	string20  Physician_Name_Clean_mname;
	string20  Physician_Name_Clean_lname;
	string5   Physician_Name_Clean_name_suffix;
	string3   Physician_Name_Clean_cleaning_score;
	string5   Office_Manager_Name_Clean_title;
	string20  Office_Manager_Name_Clean_fname;
	string20  Office_Manager_Name_Clean_mname;
	string20  Office_Manager_Name_Clean_lname;
	string5   Office_Manager_Name_Clean_name_suffix;
	string3   Office_Manager_Name_Clean_cleaning_score;
	string10  Business_Address_Clean_prim_range;
	string2   Business_Address_Clean_predir;
	string28  Business_Address_Clean_prim_name;
	string4   Business_Address_Clean_addr_suffix;
	string2   Business_Address_Clean_postdir;
	string10  Business_Address_Clean_unit_desig;
	string8   Business_Address_Clean_sec_range;
	string25  Business_Address_Clean_p_city_name;
	string25  Business_Address_Clean_v_city_name;
	string2   Business_Address_Clean_st;
	string5   Business_Address_Clean_zip;
	string4   Business_Address_Clean_zip4;
	string4   Business_Address_Clean_cart;
	string1   Business_Address_Clean_cr_sort_sz;
	string4   Business_Address_Clean_lot;
	string1   Business_Address_Clean_lot_order;
	string2   Business_Address_Clean_dpbc;
	string1   Business_Address_Clean_chk_digit;
	string2   Business_Address_Clean_record_type;
	string2   Business_Address_Clean_ace_fips_st;
	string3   Business_Address_Clean_fipscounty;
	string10  Business_Address_Clean_geo_lat;
	string11  Business_Address_Clean_geo_long;
	string4   Business_Address_Clean_msa;
	string7   Business_Address_Clean_geo_blk;
	string1   Business_Address_Clean_geo_match;
	string4   Business_Address_Clean_err_stat;
end;
	
	
	