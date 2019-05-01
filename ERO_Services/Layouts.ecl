import BatchServices, BatchShare, Doxie;

export Layouts := module

	// **************************************************************************************
	//   1. Always use Layouts.BatchIn/Layouts.BatchOut to define input and output layouts. 
	// 	 2. You should try to use the common layouts defined in BatchServices.Layouts as 
	//			much as possible.	Ideally, only fields that are specific to your service should 
	//			be added here.
	//	 3. Try to keep BatchIn/BatchOut defined at the top of this attribute, under
	//			
	//			 <INPUT_OUTPUT_LAYOUTS> 
	//			 </INPUT_OUTPUT_LAYOUTS> 	
	//
	//			comments, just so other people know where to look for.
	// **************************************************************************************
	
	// **************************************************************************************
	// <INPUT_OUTPUT_LAYOUTS>
	
	export BatchIn := record		
		//Autokey_batch.Layouts.rec_inBatchMaster		<-- currently used for every batch service.
		BatchShare.Layouts.ShareAcct; // acctno
		BatchShare.Layouts.SharePII;  // ssn and DOB
		BatchShare.Layouts.ShareDID;
		//BatchShare.Layouts.ShareName;		
			STRING30 		name_first    := '';  //need to support more than 20 chars
			STRING20 		name_middle   := '';
			STRING40 		name_last     := '';  //need to support more than 20 chars
			STRING5	 		name_suffix   := '';
	  	BatchShare.Layouts.ShareAddress;
		//BatchShare.Layouts.ShareErrors;
	
		/* Domain specific fields should be added below */
	   STRING50 Filler1 ;  //customer input value to return in output unchanged.
     STRING1 Gender  ;
     STRING30 DL_Number;
     STRING2 DL_State ;
     STRING30 VEH_Plate ;
     STRING2 VEH_State ;
     STRING30 FBI_Num   ;
     STRING30 State_Crim_Num ;
     STRING40 Relative_Last_Name ;
     STRING30 Relative_First_Name;
     STRING20 LexID_Suppression_1;
     STRING20 LexID_Suppression_2;
     STRING200 Dedupe_Address_1;
		 STRING50 Dedupe_City_1   ;
     STRING2 Dedupe_State_1  ;
     STRING5 Dedupe_Zip_1     ;
     STRING200 Dedupe_Address_2 ;
		 STRING50 Dedupe_City_2    ;
     STRING2 Dedupe_State_2  ;
     STRING5 Dedupe_Zip_2    ;
  END;

	// -----[ Output record layouts--individual from each function call, and altogether ]-----
	
	export Subject_out := record
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING10 subject_Source_Count;
		STRING10 subject_SN_DOB_MATCH;
		STRING10 subject_ADDR1_MATCH;
		STRING10 subject_ADDR2_MATCH;
		STRING10 subject_Penalty;
		STRING40 subject_Last_Name ;
		STRING30 subject_First_Name ;
		STRING20 subject_Middle_Name ;
		STRING5 subject_Suffix ;
		STRING200 subject_AKAS_LIST;
		STRING9 subject_SSN;
		STRING10 subject_DOB ;
		STRING10 subject_Gender;	
	end;
	
	export Deceased_out := record
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING1 Death_Indicator;
		STRING200 Death_Name;
		STRING10 Death_DOD;
		STRING10 Death_DOB;
		STRING9 Death_SSN;
	end;
	
	export DriversLicense_out := record
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING70 DL_Name ;
		STRING9 DL_SSN ;
		STRING10 DL_DOB; 
		STRING1 DL_Gender;
		STRING25 DL_Number; 
		STRING10 DL_Issue_Date ;  
		STRING10 DL_Expiration_Date ;
		STRING200 DL_Street_Address;  
		STRING25 DL_City ; 
		STRING2 DL_State ; 
		STRING5 DL_Zip;  
		STRING2 DL_Unique_Address_Flag ; 	
	end;
	
	export DriversLicense_out_plus_DL_Address := record(DriversLicense_out)
		string10 DL_prim_range;
		string2  DL_predir;
		string28 DL_prim_name;
		string4  DL_addr_suffix;
		string2  DL_postdir;
		string10 DL_unit_desig;
		string8  DL_sec_range;
		string25 DL_p_city_name;
		string2  DL_st;
		string5  DL_z5;
	end;
	
	export Addresses_out := record // 2 records
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING1 addr_Detention_Center_Match;
		STRING1 addr_Dedupe_Addr_1_Match;
		STRING10 addr_Dedupe_Addr_1_Most_Recent_Rptd_Date;
		STRING1 addr_Dedupe_Addr_2_Match;
		STRING10 addr_Dedupe_Addr_2_Most_Recent_Rptd_Date;
		STRING200 addr_Address_1;
		STRING50 addr_City_1;
		STRING2 addr_State_1;
		STRING5 addr_Zip_1;
		STRING30 addr_County_1;
		STRING20 addr_Phone_1 ;
		STRING10 addr_Last_Date_Reported_1;
		STRING10 addr_First_Date_Reported_1;
		STRING30 addr_Delivery_Type_Indicator_1 ;
		STRING1 addr_POBox_Indicator_1;
		STRING60 addr_HRI_1;
		STRING200 addr_Address_2;
		STRING50 addr_City_2;
		STRING2 addr_State_2;
		STRING5 addr_Zip_2;
		STRING30 addr_County_2;
		STRING20 addr_Phone_2;
		STRING10 addr_Last_Date_Reported_2;
		STRING10 addr_First_Date_Reported_2;
		STRING30 addr_Delivery_Type_Indicator_2;
		STRING1 addr_POBox_Indicator_2;
		STRING60 addr_HRI_2;	
	end;
  
	export Addresses_raw := record // 2 records
	  Addresses_out;
		BatchShare.Layouts.ShareAddress addr_raw_1;//need component based address for filling LookupId record
		BatchShare.Layouts.ShareAddress addr_raw_2;//need component based address for filling LookupId record
	end;
	
	export Vehicles_out := record // 3 records
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING100 VEH_Vehicle_Name_1 ;
		STRING50 VEH_VIN_1;
		STRING20 VEH_Plate_Number_1;
		STRING2 VEH_Plate_State_1 ;
		STRING100 VEH_Color_Year_Make_Model_Series_1;
		STRING10 VEH_Registration_Date_1;
		STRING10 VEH_Expiration_Date_1;
		STRING30 VEH_Match_Code_1;
		STRING100 VEH_Vehicle_Name_2;
		STRING50 VEH_VIN_2;
		STRING20 VEH_Plate_Number_2;
		STRING2 VEH_Plate_State_2 ;
		STRING100 VEH_Color_Year_Make_Model_Series_2;
		STRING10 VEH_Registration_Date_2;
		STRING10 VEH_Expiration_Date_2;
		STRING30 VEH_Match_Code_2;
		STRING100 VEH_Vehicle_Name_3;
		STRING50 VEH_VIN_3;
		STRING20 VEH_Plate_Number_3;
		STRING2 VEH_Plate_State_3 ;
		STRING100 VEH_Color_Year_Make_Model_Series_3;
		STRING10 VEH_Registration_Date_3;
		STRING10 VEH_Expiration_Date_3;
		STRING30 VEH_Match_Code_3;	
	end;

	export Vehicles_out_plus_addresses := record(Vehicles_out) // 3 records
		STRING200 VEH_temp_address_1;
		STRING200 VEH_temp_address_2;
		STRING200 VEH_temp_address_3;	
	end;
	
	export Accidents_out := record // 2 records
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING60 ACC_Driver_Name_1;
		STRING64 ACC_Driver_Address_1;
		STRING25 ACC_Driver_City_1;
		STRING2 ACC_Driver_State_1;
		STRING5 ACC_Driver_Zip_1;
		STRING15 ACC_Driver_DL_1;
		STRING2 ACC_Driver_DL_State_1;
		STRING41 ACC_Driver_Insurance_Company_1;
		STRING25 ACC_Driver_Insurance_Policy_Number_1;
		STRING40 ACC_State_issued_Accident_Number_1;
		STRING10 ACC_Date_1;
		STRING2 ACC_State_1;
		STRING30 ACC_City_1;
		STRING50 ACC_County_1;
		STRING8 ACC_veh_Plate_1;
		STRING2 ACC_veh_State_1;
		STRING22 ACC_veh_VIN_1;
		STRING100 ACC_Veh_Type_1;
		STRING60 ACC_Owner_Name_1;
		STRING64 ACC_Owner_Address_1;
		STRING25 ACC_Owner_City_1 ;
		STRING2 ACC_Owner_State_1;
		STRING5 ACC_Owner_Zip_1;
		STRING15 ACC_Owner_DL_1;
		STRING10 ACC_Owner_DOB_1;
		STRING30 ACC_Match_1;

		STRING60 ACC_Driver_Name_2;
		STRING64 ACC_Driver_Address_2;
		STRING25 ACC_Driver_City_2;
		STRING2 ACC_Driver_State_2;
		STRING5 ACC_Driver_Zip_2;
		STRING15 ACC_Driver_DL_2;
		STRING2 ACC_Driver_DL_State_2;
		STRING41 ACC_Driver_Insurance_Company_2;
		STRING25 ACC_Driver_Insurance_Policy_Number_2;
		STRING40 ACC_State_issued_Accident_Number_2;
		STRING10 ACC_Date_2;
		STRING2 ACC_State_2;
		STRING30 ACC_City_2;
		STRING50 ACC_County_2;
		STRING8 ACC_veh_Plate_2;
		STRING2 ACC_veh_State_2;
		STRING22 ACC_veh_VIN_2;
		STRING100 ACC_Veh_Type_2;
		STRING60 ACC_Owner_Name_2;
		STRING64 ACC_Owner_Address_2;
		STRING25 ACC_Owner_City_2 ;
		STRING2 ACC_Owner_State_2;
		STRING5 ACC_Owner_Zip_2;
		STRING15 ACC_Owner_DL_2;
		STRING10 ACC_Owner_DOB_2;
		STRING30 ACC_Match_2;
	end;
	
	export CriminalOffenses_out := record // criminal info plus 5 offenses
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING60 Off_Crim_Name;
		STRING100 Off_Crim_AKAs;
		STRING9 Off_Crim_SSN;
		STRING10 Off_Crim_DOB;
		STRING3 Off_Crim_Height; 
		STRING3 Off_Crim_Weight;
		STRING7 Off_Crim_Gender;
		STRING30 Off_Crim_Race;
		STRING15 Off_Crim_Eye_color;
		STRING15 Off_Crim_Hair;

		STRING500 Off_1;
		STRING10 Off_Date_1 ;
		STRING150 Off_Sentence_1;
		STRING10 Off_Sentence_Date_1;
		STRING10 Off_Incarceration_Date_1;
		STRING40 Off_Court_Name_1 ;
		STRING35 Off_Court_Case_Number_1;
		STRING80 Off_Jurisdiction_State_1 ;
		STRING360 Off_Adjudication_1 ;
		STRING10 Off_Adjudication_Date_1;
		STRING30 Off_FBI_Number_1;
		STRING30 Off_DOC_Number_1 ;
		STRING30 Off_Sex_Off_Registry_Id_1 ;
		STRING10 Off_Arrest_Date_1 ;
		STRING35 Off_Arrest_Level_Degree_1;
		STRING9 Off_Court_Fine_1 ;
		STRING30 Off_Court_Plea_1 ;
		STRING80 Off_Court_Disposition_1;
		STRING10 Off_Court_Disposition_Date_1 ;
		STRING20 Off_Suspended_Time_1;
		STRING60 Off_Party_Status_1;

		STRING500 Off_2;
		STRING10 Off_Date_2 ;
		STRING150 Off_Sentence_2;
		STRING10 Off_Sentence_Date_2;
		STRING10 Off_Incarceration_Date_2;
		STRING40 Off_Court_Name_2 ;
		STRING35 Off_Court_Case_Number_2;
		STRING80 Off_Jurisdiction_State_2 ;
		STRING360 Off_Adjudication_2 ;
		STRING10 Off_Adjudication_Date_2;
		STRING30 Off_FBI_Number_2;
		STRING30 Off_DOC_Number_2 ;
		STRING30 Off_Sex_Off_Registry_Id_2 ;
		STRING10 Off_Arrest_Date_2 ;
		STRING35 Off_Arrest_Level_Degree_2;
		STRING9 Off_Court_Fine_2 ;
		STRING30 Off_Court_Plea_2 ;
		STRING80 Off_Court_Disposition_2;
		STRING10 Off_Court_Disposition_Date_2 ;
		STRING20 Off_Suspended_Time_2;
		STRING60 Off_Party_Status_2;

		STRING500 Off_3;
		STRING10 Off_Date_3 ;
		STRING150 Off_Sentence_3;
		STRING10 Off_Sentence_Date_3;
		STRING10 Off_Incarceration_Date_3;
		STRING40 Off_Court_Name_3 ;
		STRING35 Off_Court_Case_Number_3;
		STRING80 Off_Jurisdiction_State_3 ;
		STRING360 Off_Adjudication_3 ;
		STRING10 Off_Adjudication_Date_3;
		STRING30 Off_FBI_Number_3;
		STRING30 Off_DOC_Number_3 ;
		STRING30 Off_Sex_Off_Registry_Id_3 ;
		STRING10 Off_Arrest_Date_3 ;
		STRING35 Off_Arrest_Level_Degree_3;
		STRING9 Off_Court_Fine_3 ;
		STRING30 Off_Court_Plea_3 ;
		STRING80 Off_Court_Disposition_3;
		STRING10 Off_Court_Disposition_Date_3 ;
		STRING20 Off_Suspended_Time_3;
		STRING60 Off_Party_Status_3;

		STRING500 Off_4;
		STRING10 Off_Date_4 ;
		STRING150 Off_Sentence_4;
		STRING10 Off_Sentence_Date_4;
		STRING10 Off_Incarceration_Date_4;
		STRING40 Off_Court_Name_4 ;
		STRING35 Off_Court_Case_Number_4;
		STRING80 Off_Jurisdiction_State_4 ;
		STRING360 Off_Adjudication_4 ;
		STRING10 Off_Adjudication_Date_4;
		STRING30 Off_FBI_Number_4;
		STRING30 Off_DOC_Number_4 ;
		STRING30 Off_Sex_Off_Registry_Id_4 ;
		STRING10 Off_Arrest_Date_4 ;
		STRING35 Off_Arrest_Level_Degree_4;
		STRING9 Off_Court_Fine_4 ;
		STRING30 Off_Court_Plea_4 ;
		STRING80 Off_Court_Disposition_4;
		STRING10 Off_Court_Disposition_Date_4 ;
		STRING20 Off_Suspended_Time_4;
		STRING60 Off_Party_Status_4;

		STRING500 Off_5;
		STRING10 Off_Date_5 ;
		STRING150 Off_Sentence_5;
		STRING10 Off_Sentence_Date_5;
		STRING10 Off_Incarceration_Date_5;
		STRING40 Off_Court_Name_5 ;
		STRING35 Off_Court_Case_Number_5;
		STRING80 Off_Jurisdiction_State_5 ;
		STRING360 Off_Adjudication_5 ;
		STRING10 Off_Adjudication_Date_5;
		STRING30 Off_FBI_Number_5;
		STRING30 Off_DOC_Number_5 ;
		STRING30 Off_Sex_Off_Registry_Id_5 ;
		STRING10 Off_Arrest_Date_5 ;
		STRING35 Off_Arrest_Level_Degree_5;
		STRING9 Off_Court_Fine_5 ;
		STRING30 Off_Court_Plea_5 ;
		STRING80 Off_Court_Disposition_5;
		STRING10 Off_Court_Disposition_Date_5 ;
		STRING20 Off_Suspended_Time_5;
		STRING60 Off_Party_Status_5;	
	end;
	
	export BatchOut := record
	
		//	BatchShare.Layouts.ShareBest;		
		/* Domain specific fields should be added below */		
		// best subject 
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		Subject_out          AND NOT [acctno,did];
		Deceased_out         AND NOT [acctno,did];
		Addresses_out        AND NOT [acctno,did];
		DriversLicense_out   AND NOT [acctno,did];
		Vehicles_out         AND NOT [acctno,did];
		Accidents_out        AND NOT [acctno,did];
		CriminalOffenses_out AND NOT [acctno,did];

		BatchShare.Layouts.ShareErrors;

	end;
	
	// </INPUT_OUTPUT_LAYOUTS>
	// **************************************************************************************
		
	export IntermediateData := record		
	  string20 saved_acctno := '';
		BatchIn;	
		STRING input_raw_City   ;
    STRING input_raw_St  ;
    STRING input_raw_zip    ;
    string dedupprim_range1;
		string dedupprim_name1;
		string dedupzip1;
		string dedupprim_range2;
		string dedupprim_name2;
		string dedupzip2;
	 //	BatchShare.Layouts.ShareErrors;
	end;
	
	// **************************************************************************************
	// The layout LookupId will be used to handle lookup search. 
	// **************************************************************************************
	
	export Date := record
		integer1 Month;
		integer1 Day;
		integer2 Year;
	end;

	export LookupId := record
		BatchShare.Layouts.ShareAcct;		// acctno
		BatchShare.Layouts.ShareErrors; // for search_status (see autokey get_fids (AutokeyB2_batch.Layouts.rec_output_IDs_batch)), etc.
		
		// Entity identifiers
		unsigned6 did  := 0;
		unsigned6 bdid := 0;
		string30 	vehicle_key;
		string15 	iteration_key;
		string15 	sequence_key := '';
		
		// System behavior
		boolean 	is_deep_dive := false;		
		
		// Input data
		string9 input_ssn;
		date    input_dob;
		string1 input_gender; // (valid values: 'M','F'; used by CRIM, & DL)
		STRING30 input_FBI_Num   ;//used in Crim
		BatchShare.Layouts.ShareName    input_name; 
		BatchShare.Layouts.ShareAddress input_addr;
		STRING input_raw_City   ;
    STRING input_raw_St  ;
    STRING input_raw_zip    ;
		string dedupprim_range1;
		string dedupprim_name1;
		string dedupzip1;
		string dedupprim_range2;
		string dedupprim_name2;
		string dedupzip2;
		
		// Best data
		STRING subject_SSN;
		STRING subject_DOB;
		BatchShare.Layouts.ShareName    best_name;
		BatchShare.Layouts.ShareAddress addr1;
		BatchShare.Layouts.ShareAddress addr2;
		BatchShare.Layouts.ShareAddress dl_addr;
  	Addresses_out        AND NOT [acctno,did];
		// Match-coding
		string10 	matchCode := '';  // from autokey get_fids (AutokeyB2_batch.Layouts.rec_output_IDs_batch)
	  STRING subject_ADDR1_MATCH;
		STRING subject_ADDR2_MATCH;
		/* Domain specific fields should be added below */		
	END;
	
	export layout_LookupId_plus_standardized_addrs := record(LookupId)
		string ids_temp_address_1;
		string ids_temp_address_2;
		string ids_temp_dl_address;
	end;
	
export  subject_out_temp := record
     Subject_out;
		 BatchShare.Layouts.ShareName    input_name;
		 BatchShare.Layouts.ShareAddress input_addr;
		 string9 input_ssn;
		 date    input_dob;
		 STRING1 input_gender;
  	 STRING30 input_FBI_Num   ;//used in Crim
		 STRING input_raw_City   ;
     STRING input_raw_St  ;
     STRING input_raw_zip    ;
		 BatchShare.Layouts.ShareAddress header_addr;
     string dedupprim_range1;
	 	 string dedupprim_name1;
		 string dedupzip1;
		 string dedupprim_range2;
		 string dedupprim_name2;
		 string dedupzip2;
 end;		 
//this layout is used in 2 different areas, 1 to pass the input relnames to penalty, 2 to store the relatives for a subject to compare.	
export layout_extra_penalty := record
     BatchShare.Layouts.ShareAcct;
     BatchShare.Layouts.ShareDID;
		 BatchShare.Layouts.ShareAddress input_addr;
		 STRING subject_SN_DOB_MATCH;
	 	 UNSIGNED subject_Penalty;
		 string1 needsTieBreaker := '';
     STRING Relative_Last_Name ;
     STRING Relative_First_Name;
		 STRING DL_Number;
     STRING DL_State ;
     STRING VEH_Plate ;
     STRING VEH_State ;
		 integer1 rel_Match := 0;
 end;	
export layout_batch_in_for_penalties := record
	   BatchServices.Layouts.layout_batch_in_for_penalties;
		 layout_extra_penalty;
 end;
export layout_for_akas := record
  string100 subject_name;
  doxie.Layout_presentation;	
 end;

end; //of layouts module
