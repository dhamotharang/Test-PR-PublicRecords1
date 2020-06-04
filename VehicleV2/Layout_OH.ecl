IMPORT	AID,Address;

EXPORT Layout_OH	:=
MODULE

	//---------------------------------------------------------
	//-----------OH INPUT FORMAT LAYOUT
	//---------------------------------------------------------
	EXPORT	Raw_Main	:=
	RECORD
		STRING2 	CategoryCode;
		STRING20 	VIN;
		STRING4 	ModelYr;
		STRING20 	TitleNum;
		STRING1 	OwnerCode;
		STRING6 	GrossWeight;
		STRING35 	OwnerName;
		STRING30 	OwnerStreetAddress;
		STRING15 	OwnerCity;
		STRING2 	OwnerState;
		STRING9 	OwnerZip;
		STRING2 	CountyNumber;
		STRING8 	VehiclePurchaseDt;
		STRING6 	VehicleTaxWeight;
		STRING1 	VehicleTaxCode;
		STRING6 	VehicleUnladdenWeight;
		STRING35 	AdditionalOwnerName;
		STRING8 	RegistrationIssueDt;
		STRING4 	VehicleMake;
		STRING2 	VehicleType;
		STRING8 	VehicleExpDt;
		STRING8 	PreviousPlateNum;
		STRING8 	PlateNum;
		STRING2		EOL;
	END;
	
	//------------------------------------------------------------
	//ADD NAME TYPE INDICATORS
	//------------------------------------------------------------
	EXPORT	Prepped	:=
	RECORD
		Raw_Main;
		STRING8		ProcessDate;
		string2		Source_Code;
		string2		State_Origin;
		STRING1		Append_OwnerNameTypeInd			:=	'';
		STRING1		Append_AddlOwnerNameTypeInd	:=	'';
	END;
	
	//------------------------------------------------------------
	//OUTPUT CLEAN FILE LAYOUTS
	//------------------------------------------------------------
	EXPORT Clean_Main	:=
	RECORD
		STRING8		ProcessDate;
		STRING2		Source_Code;
		STRING2		State_Origin;
		STRING2 	CategoryCode;
		STRING20 	VIN;
		STRING4 	ModelYr;
		STRING20 	TitleNum;
		STRING1 	OwnerCode;
		STRING6 	GrossWeight;
		STRING70	Orig_OwnerName;
		STRING35 	OwnerName;
		STRING1		Append_OwnerNameTypeInd			:=	'';
		STRING30 	OwnerStreetAddress;
		STRING15 	OwnerCity;
		STRING2 	OwnerState;
		STRING9 	OwnerZip;
		STRING2 	CountyNumber;
		STRING8 	VehiclePurchaseDt;
		STRING6 	VehicleTaxWeight;
		STRING1 	VehicleTaxCode;
		STRING6 	VehicleUnladdenWeight;
		STRING70	Orig_AdditionalOwnerName;
		STRING35 	AdditionalOwnerName;
		STRING1		Append_AddlOwnerNameTypeInd	:=	'';
		STRING8 	RegistrationIssueDt;
		STRING4 	VehicleMake;
		STRING2 	VehicleType;
		STRING8 	VehicleExpDt;
		STRING8 	PreviousPlateNum;
		STRING8 	PlateNum;
		//Additional fields: clean name1, name 2 and address
		address.Layout_Clean_Name;
		STRING5		title2											:=	'';
		STRING20	fname2											:=	'';
		STRING20	mname2											:=	'';
		STRING20	lname2											:=	'';
		STRING5		name_suffix2								:=	'';
		STRING3		name_score2									:=	'';
		STRING35	company_name1								:=	'';
		STRING35	company_name2								:=	'';
		STRING8		prev_plate_from_name				:=	'';
		STRING100	Append_PrepAddr1						:=	'';
		STRING50	Append_PrepAddr2						:=	'';
		AID.Common.xAID	Append_RawAID					:=	0;
	END;

	EXPORT	OH_as_VehicleV2	:=
	RECORD
		STRING30				Vehicle_Key;
		STRING15				Iteration_Key;
		STRING15				Sequence_Key;
		UNSIGNED4    		dt_first_seen;
		UNSIGNED4				dt_last_seen;
		UNSIGNED4    		dt_vendor_first_reported;
		UNSIGNED4    		dt_vendor_last_reported;
		STRING8					VehiclePurchaseDt;
		STRING2     		state_origin;
		STRING1     		VINA_VINFLAG;
		STRING1					History;
		STRING2     		source_code;
		STRING2     		CategoryCode;
		STRING25				Raw_VIN;
		STRING25    		ORIG_VIN;
		STRING4					ORIG_MAKE_YEAR;
		STRING5    			Orig_MAKE_CODE;
		STRING5    			Orig_BODY_CODE;
		string3					Orig_Series_Code;
		STRING6     		Orig_NET_WEIGHT;
		STRING6     		Orig_GROSS_WEIGHT;
		STRING6 				Orig_VehicleTaxWeight;
		STRING1 				Orig_VehicleTaxCode;
		string1					Orig_REGISTRANT1_CUSTOMER_TYPE;
		string70				Orig_Reg_1_Customer_Name;
		string1					Orig_REGISTRANT2_CUSTOMER_TYPE;
		string70				Orig_Reg_2_Customer_Name;
		string2					Orig_TitleTypeCode;
		string10				Orig_TitleDate;
		string10				Orig_TitleTransferDate;
		STRING10				Orig_RegistrationExpDate;
		STRING10				Orig_RegistrationIssueDate;
		STRING5					Orig_County;
		STRING4    			YEAR_MAKE;
		STRING5    			MAKE_CODE;
		STRING4    			VEHICLE_TYPE;
		STRING5    			BODY_CODE;
		STRING3         VESSEL_TYPE;
		STRING1         NUMBER_OF_AXLES;
		STRING1         VEHICLE_USE;
		STRING3         MODEL;
		STRING10        LICENSE_PLATE_NUMBERxBG4;
		STRING8         REGISTRATION_EFFECTIVE_DATE;
		STRING8         REGISTRATION_EXPIRATION_DATE;
		STRING1         REGISTRATION_STATUS_CODE;
		STRING10        TRUE_LICENSE_PLSTE_NUMBER;  
		STRING20        TITLE_NUMBERxBG9;
		STRING8         TITLE_ISSUE_DATE;
		STRING20				PreviousPlateNum;
		STRING1         REGISTRANT_1_CUSTOMER_TYPE;
		STRING68        REG_1_CUSTOMER_NAME;
		STRING50        REG_1_STREET_ADDRESS;
		STRING5         REG_1_APARTMENT_NUMBER;
		STRING34        REG_1_CITY;
		STRING2         REG_1_STATE;
		STRING10        REG_1_ZIP5_ZIP4_FOREIGN_POSTAL;
		STRING3         REG_1_RESIDENCE_COUNTY;
		STRING1         REGISTRANT_2_CUSTOMER_TYPE;
		STRING68        REG_2_CUSTOMER_NAME;
		STRING50        REG_2_STREET_ADDRESS;
		STRING5         REG_2_APARTMENT_NUMBER;
		STRING30        REG_2_CITY;
		STRING2         REG_2_STATE;
		STRING10        REG_2_ZIP5_ZIP4_FOREIGN_POSTAL;
		STRING2         REG_2_RESIDENCE_COUNTY;
		
		STRING5         reg_1_title;
		STRING20        reg_1_fname;
		STRING20        reg_1_mname;
		STRING20        reg_1_lname;
		STRING5         reg_1_name_suffix;
		STRING68				reg_1_company_name;
		STRING100				Append_Reg1_PrepAddr1;
		STRING50				Append_Reg1_PrepAddr2;
		AID.Common.xAID	Append_Reg1_RawAID;
		STRING10        reg_1_prim_range;
		STRING2         reg_1_predir;
		STRING28        reg_1_prim_name;
		STRING4         reg_1_suffix;
		STRING2         reg_1_postdir;
		STRING10        reg_1_unit_desig;
		STRING8         reg_1_sec_range;
		STRING25        reg_1_p_city_name;
		STRING25        reg_1_v_city_name;
		STRING2         reg_1_state_2;
		STRING5         reg_1_zip5;
		STRING4         reg_1_zip4;
		STRING5         reg_1_county;
		STRING10        reg_1_geo_lat;
		STRING11        reg_1_geo_long;
		STRING4					reg_1_err_stat;
		
		STRING5         reg_2_title;
		STRING20        reg_2_fname;
		STRING20        reg_2_mname;
		STRING20        reg_2_lname;
		STRING5         reg_2_name_suffix;
		STRING68				reg_2_company_name;
		STRING100				Append_Reg2_PrepAddr1;
		STRING50				Append_Reg2_PrepAddr2;
		AID.Common.xAID	Append_Reg2_RawAID;
		STRING10        reg_2_prim_range;
		STRING2         reg_2_predir;
		STRING28        reg_2_prim_name;
		STRING4         reg_2_suffix;
		STRING2         reg_2_postdir;
		STRING10        reg_2_unit_desig;
		STRING8         reg_2_sec_range;
		STRING25        reg_2_p_city_name;
		STRING25        reg_2_v_city_name;
		STRING2         reg_2_state_2;
		STRING5         reg_2_zip5;
		STRING4         reg_2_zip4;
		STRING5         reg_2_county;
		STRING10        reg_2_geo_lat;
		STRING11        reg_2_geo_long;
		STRING4					reg_2_err_stat;
		
		//****VINA fields start
		STRING1 				VINA_Veh_Type;
		STRING5 				VINA_NCIC_Make;
		STRING2 				VINA_Model_Year_YY;
		STRING17				VINA_VIN;
		STRING1 				VINA_VIN_Pattern_Indicator;
		STRING1 				VINA_Bypass_Code;
		STRING1 				VINA_VP_Restraint;
		STRING4 				VINA_VP_Abbrev_Make_Name;
		STRING2 				VINA_VP_Year;
		STRING3 				VINA_VP_Series;
		STRING3 				VINA_VP_Model;
		STRING1 				VINA_VP_Air_Conditioning;
		STRING1 				VINA_VP_Power_Steering;
		STRING1 				VINA_VP_Power_Brakes;
		STRING1 				VINA_VP_Power_Windows;
		STRING1 				VINA_VP_Tilt_Wheel;
		STRING1 				VINA_VP_Roof;
		STRING1 				VINA_VP_Optional_Roof1;
		STRING1 				VINA_VP_Optional_Roof2;
		STRING1 				VINA_VP_Radio;
		STRING1 				VINA_VP_Optional_Radio1;
		STRING1 				VINA_VP_Optional_Radio2;
		STRING1 				VINA_VP_Transmission;
		STRING1 				VINA_VP_Optional_Transmission1;
		STRING1 				VINA_VP_Optional_Transmission2;
		STRING1 				VINA_VP_Anti_Lock_Brakes;
		STRING1 				VINA_VP_Front_Wheel_Drive;
		STRING1 				VINA_VP_Four_Wheel_Drive;
		STRING1 				VINA_VP_Security_System;
		STRING1 				VINA_VP_Daytime_Running_Lights;
		STRING25				VINA_VP_Series_Name;
		STRING4 				VINA_Model_Year;
		STRING3 				VINA_Series;
		STRING3 				VINA_Model;
		STRING2 				VINA_Body_Style;
		STRING36				VINA_Make_Desc;
		STRING36				VINA_Model_Desc;
		STRING25				VINA_Series_Desc;
		STRING25				VINA_Body_Style_Desc;
		STRING2 				VINA_Number_Of_Cylinders;
		STRING4 				VINA_Engine_Size;
		STRING1 				VINA_Fuel_Code;
		STRING6 				VINA_Price;
		STRING5					Best_Make_Code;
		STRING3					Best_Series_Code;
		STRING3					Best_Model_Code;
		STRING5					Best_Body_Code;
		STRING4					Best_Model_Year;
		STRING3					Best_Major_Color_Code;
		STRING3					Best_Minor_Color_Code;
				//****VINA fields End
		STRING3         MINOR_COLOR_CODE;  
		STRING3         MAJOR_COLOR_CODE;
		STRING20				Orig_Body_Desc;
		STRING30				Orig_Model_Desc;
		STRING25				Orig_Series_Desc;
		STRING30        Orig_Vehicle_Use_Desc;
		STRING15				Orig_Major_Color_Desc;
		STRING15				Orig_Minor_Color_Desc;
		STRING30				Orig_Vehicle_Type_Desc;
		STRING4         model_year; 
		STRING36        make_desc;	
		STRING40        vehicle_type_desc;
		STRING25        series_desc;
		STRING36        model_desc;
		STRING25        body_style_desc;
		STRING15        major_color_desc;
		STRING15        minor_color_desc; 
		STRING36        make_description;
		STRING36        model_description;
		STRING25        series_description;
		STRING25        body_style_description;
		UNSIGNED8				source_rec_id := 0;	 	//Added for BIP project
		//Added for CCPA-103
		UNSIGNED4       global_sid := 0;
		UNSIGNED8       record_sid := 0;
  END;

END;