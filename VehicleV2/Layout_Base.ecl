import	AID, BIPV2;

export	Layout_Base	:=
module

	export	Main	:=
	record
		string30		vehicle_key;
		string15		iteration_key;
		string2     source_code;
    string2     state_origin;
		unsigned8		State_Bitmap_Flag;
    string25    orig_vin;
		string4			orig_year;
		string5			orig_make_code;
		string36		orig_make_desc;
		string3			orig_series_code;
		string25		orig_series_desc;
		string3			orig_model_code;
		string30		orig_model_desc;
		string5			orig_body_code;
		string20		orig_body_desc;
		string6     orig_net_weight;
		string6     orig_gross_weight;
		string1     orig_number_of_axles;
		string1     orig_vehicle_use_code;
		string30    orig_vehicle_use_desc;
		string5			orig_vehicle_type_code;
		string30		orig_vehicle_type_desc;
		string3			orig_major_color_code;
		string15		orig_major_color_desc;
		string3			orig_minor_color_code;
		string15		orig_minor_color_desc;
		
		string1 		VINA_Veh_Type;
		string5 		VINA_NCIC_Make;
		string2 		VINA_Model_Year_YY;
		string17		VINA_VIN;
		string1 		VINA_VIN_Pattern_Indicator;
		string1 		VINA_Bypass_Code;
		string1 		VINA_VP_Restraint;
		string4 		VINA_VP_Abbrev_Make_Name;
		string2 		VINA_VP_Year;
		string3 		VINA_VP_Series;
		string3 		VINA_VP_Model;
		string1 		VINA_VP_Air_Conditioning;
		string1 		VINA_VP_Power_Steering;
		string1 		VINA_VP_Power_Brakes;
		string1 		VINA_VP_Power_Windows;
		string1 		VINA_VP_Tilt_Wheel;
		string1 		VINA_VP_Roof;
		string1 		VINA_VP_Optional_Roof1;
		string1 		VINA_VP_Optional_Roof2;
		string1 		VINA_VP_Radio;
		string1 		VINA_VP_Optional_Radio1;
		string1 		VINA_VP_Optional_Radio2;
		string1 		VINA_VP_Transmission;
		string1 		VINA_VP_Optional_Transmission1;
		string1 		VINA_VP_Optional_Transmission2;
		string1 		VINA_VP_Anti_Lock_Brakes;
		string1 		VINA_VP_Front_Wheel_Drive;
		string1 		VINA_VP_Four_Wheel_Drive;
		string1 		VINA_VP_Security_System;
		string1 		VINA_VP_Daytime_Running_Lights;
		string25		VINA_VP_Series_Name;
		string4 		VINA_Model_Year;
		string3 		VINA_Series;
		string3 		VINA_Model;
		string2 		VINA_Body_Style;
		string36		VINA_Make_Desc;
		string36		VINA_Model_Desc;
		string25		VINA_Series_Desc;
		string25		VINA_Body_Style_Desc;
		string2 		VINA_Number_Of_Cylinders;
		string4 		VINA_Engine_Size;
		string1 		VINA_Fuel_Code;
		string6 		VINA_Price;
		string5			best_make_code;
		string3			best_series_code;
		string3			best_model_code;
		string5			best_body_code;
		string4			best_model_year;
		string3			best_major_color_code;
		string3			best_minor_color_code;
		string1     Branded_title_flag	;
  string3     Brand_Code_1	;
  string10  Brand_Date_1	;
  string2   Brand_State_1	;
  string3   Brand_Code_2	 ;
  string10 Brand_Date_2	 ;
  string2 Brand_State_2	 ;
  string3 Brand_Code_3	 ;
  string10 Brand_Date_3	 ;
  string2 Brand_State_3	 ;
  string3 Brand_Code_4	 ;
  string10 Brand_Date_4	 ;
  string2 Brand_State_4	 ;
  string3 Brand_Code_5	 ;
  string10 Brand_Date_5	 ;
  string2 Brand_State_5	 ;
  string1 TOD_flag	;
  string3 Model_class_code	;
  string50 Model_Class	;
  string2 Min_Door_count	;
  string3 Safety_type	;
  string50 AIRBAG_DRIVER	;
  string50 AIRBAG_FRONT_DRIVER_SIDE	;
  string50 AIRBAG_FRONT_HEAD_CURTAIN	;
  string50 AIRBAG_FRONT_PASS	;
  string50 AIRBAG_FRONT_PASS_SIDE	;
  string50 AIRBAGS	;
	//Added for CCPA-103
	unsigned4 global_sid := 0;
	unsigned8 record_sid := 0;
  end;
	
	export	Party	:=
	record
		string30				Vehicle_Key;
		string15				Iteration_Key;
		string15				Sequence_Key;
		string2					Source_Code;
		string2					State_Origin;
		
		unsigned8				State_Bitmap_Flag;
		string1					Latest_Vehicle_Flag;
		string1					Latest_Vehicle_Iteration_Flag;
		string1					History;
		unsigned4				Date_First_Seen;
		unsigned4				Date_Last_Seen;
		unsigned4				Date_Vendor_First_Reported;
		unsigned4				Date_Vendor_Last_Reported;
		string1					Orig_Party_Type;
		string1					Orig_Name_Type;
		string10				Orig_Conjunction;
		string70				Orig_Name;
		
		string70				Orig_Address;
		string35				Orig_City;
		string2					Orig_State;
		String30        orig_province;
		String30        orig_country;
		string10				Orig_Zip;
		
		string9					Orig_SSN;
		string9					Orig_FEIN;
		string20				Orig_DL_Number;
		string8					Orig_DOB;
		string1					Orig_Sex;
		string8					Orig_Lien_Date;
		
		string5					title;
		string20				fname;
		string20				mname;
		string20				lname;
		string5					name_suffix;
		string3					name_score;
		string70				Append_Clean_CName;
		
		string150				Append_Ace1_PrepAddr1	:=	'';
		string100				Append_Ace1_PrepAddr2	:=	'';
		AID.Common.xAID	Append_Ace1_RawAID		:=	0;
		string150				Append_Ace2_PrepAddr1	:=	'';
		string50				Append_Ace2_PrepAddr2	:=	'';
		AID.Common.xAID	Append_Ace2_RawAID		:=	0;
		
		string10				prim_range;
		string2					predir;
		string28				prim_name;
		string4					addr_suffix;
		string2					postdir;
		string10				unit_desig;
		string8					sec_range;
		string25				v_city_name;
		string2					st;
		string5					zip5;
		string4					zip4;
		string2					addr_rec_type;
		string2					fips_state;
		string3					fips_county;
		string10				geo_lat;
		string11				geo_long;
		string4					cbsa;
		string7					geo_blk;
		string1					geo_match;
		string4					err_stat;
		
		string10				ace_prim_range;
		string2					ace_predir;
		string28				ace_prim_name;
		string4					ace_addr_suffix;
		string2					ace_postdir;
		string10				ace_unit_desig;
		string8					ace_sec_range;
		string25				ace_p_city_name;
		string25				ace_v_city_name;
		string2					ace_st;
		string5					ace_zip5;
		string4					ace_zip4;
		string2					ace_addr_rec_type;
		string2					ace_fips_state;
		string3					ace_fips_county;
		string10				ace_geo_lat;
		string11				ace_geo_long;
		string4					ace_cbsa;
		string7					ace_geo_blk;
		string1					ace_geo_match;
		string4					ace_err_stat;
		
		unsigned6				Append_DID;
		unsigned1				Append_DID_Score;
		unsigned6				Append_BDID;
		unsigned1				Append_BDID_Score;
		string20				Append_DL_Number;
		string9					Append_SSN;
		string9					Append_FEIN;
		string8     		Append_DOB;
		
		string8					Reg_First_Date;
		string8					Registration_Effective_Date;
		string8					Reg_Earliest_Effective_Date;
		string8					Reg_Latest_Effective_Date;
		string8					Registration_Expiration_Date;
		string10				Reg_Latest_Expiration_Date;
		unsigned1				Reg_Rollup_Count;
		string10				Reg_Decal_Number;
		string4					Reg_Decal_Year;
		string1					Reg_Status_Code;
		string20				Reg_Status_Desc;
		string10				Reg_True_License_Plate;
		string10				Reg_License_Plate;
		string2					Reg_License_State;
		string4					Reg_License_Plate_Type_Code;
		string65				Reg_License_Plate_Type_Desc;
		string2					Reg_Previous_License_State;
		string10				Reg_Previous_License_Plate;
		string20				Ttl_Number;
		string8					Title_Issue_Date;
		string8					Ttl_Earliest_Issue_Date;
		string8					Ttl_Latest_Issue_Date;
		string8					Ttl_Previous_Issue_Date;
		unsigned1				Ttl_Rollup_Count;
		string2					Ttl_Status_Code;
		string48				Ttl_Status_Desc;
    string2         Previous_Title_State;
		string7					Ttl_Odometer_Mileage;
		string1					Ttl_Odometer_Status_Code;
		string42				Ttl_Odometer_Status_Desc;
		string8					Ttl_Odometer_Date;
		string8	SRC_FIRST_DATE	:= '';	//New fields added for Infutor batch project - bug #155364
		string8	SRC_LAST_DATE	:= '';		//New fields added for Infutor batch project
	end;
export	Party_Bip	:=record
		Party;
		BIPV2.IDlayouts.l_xlink_ids;		 			//Added for BIP project
		unsigned8				source_rec_id := 0;	 	//Added for BIP project
   end;
	 
//New layout added for CCPA-103	 
export	Party_CCPA	:=record
		Party_Bip;
		//Added for CCPA-103
		unsigned4 global_sid := 0;
		unsigned8 record_sid := 0;
		//Added for DF-25578
		string30 raw_name;
   end;
	 
	export	Party_AID	:=
	record
		Party_Bip;
		unsigned6				Append_SeqNum;
		string1					Append_AddressInd;
		string150				Append_PrepAddr1;
		string100				Append_PrepAddr2;
		string30        raw_name;
		AID.Common.xAID	Append_RawAID	:=	0;
		
		// Clean mail and physical addresses
		
		string10				AID_ACEClean_prim_range;
		string2					AID_ACEClean_predir;
		string28				AID_ACEClean_prim_name;
		string4					AID_ACEClean_addr_suffix;
		string2					AID_ACEClean_postdir;
		string10				AID_ACEClean_unit_desig;
		string8					AID_ACEClean_sec_range;
		string25				AID_ACEClean_p_city_name;
		string25				AID_ACEClean_v_city_name;
		string2					AID_ACEClean_st;
		string5					AID_ACEClean_zip;
		string4					AID_ACEClean_zip4;
		string4					AID_ACEClean_cart;
		string1					AID_ACEClean_cr_sort_sz;
		string4					AID_ACEClean_lot;
		string1					AID_ACEClean_lot_order;
		string2					AID_ACEClean_dbpc;
		string1					AID_ACEClean_chk_digit;
		string2					AID_ACEClean_record_type;
		string2					AID_ACEClean_ace_fips_st;
		string3					AID_ACEClean_fipscounty;
		string10				AID_ACEClean_geo_lat;
		string11				AID_ACEClean_geo_long;
		string4					AID_ACEClean_msa;
		string7					AID_ACEClean_geo_blk;
		string1					AID_ACEClean_geo_match;
		string4					AID_ACEClean_err_stat;
				
		string10				Ace1_prim_range;
		string2					Ace1_predir;
		string28				Ace1_prim_name;
		string4					Ace1_addr_suffix;
		string2					Ace1_postdir;
		string10				Ace1_unit_desig;
		string8					Ace1_sec_range;
		string25				Ace1_p_city_name;
		string25				Ace1_v_city_name;
		string2					Ace1_st;
		string5					Ace1_zip5;
		string4					Ace1_zip4;
		string2					Ace1_addr_rec_type;
		string2					Ace1_fips_state;
		string3					Ace1_fips_county;
		string10				Ace1_geo_lat;
		string11				Ace1_geo_long;
		string4					Ace1_cbsa;
		string7					Ace1_geo_blk;
		string1					Ace1_geo_match;
		string4					Ace1_err_stat;
		
		string10				Ace2_prim_range;
		string2					Ace2_predir;
		string28				Ace2_prim_name;
		string4					Ace2_addr_suffix;
		string2					Ace2_postdir;
		string10				Ace2_unit_desig;
		string8					Ace2_sec_range;
		string25				Ace2_p_city_name;
		string25				Ace2_v_city_name;
		string2					Ace2_st;
		string5					Ace2_zip5;
		string4					Ace2_zip4;
		string2					Ace2_addr_rec_type;
		string2					Ace2_fips_state;
		string3					Ace2_fips_county;
		string10				Ace2_geo_lat;
		string11				Ace2_geo_long;
		string4					Ace2_cbsa;
		string7					Ace2_geo_blk;
		string1					Ace2_geo_match;
		string4					Ace2_err_stat;
	end;
	
	export Party_Base_Bip:=record
		BIPV2.IDlayouts.l_xlink_ids;		 			//Added for BIP project
		unsigned8				source_rec_id := 0;	 	//Added for BIP project
		VehicleV2.Layout_Base_Party;
	end;
/*
export	Party_Bid	:=record
		Party;
		unsigned6				BID;
		unsigned1				BID_Score;
   end;
*/

//Old Party layout prior to new source date fields being added - bug #155364
	export Party_old := 
		record
		string30				Vehicle_Key;
		string15				Iteration_Key;
		string15				Sequence_Key;
		string2					Source_Code;
		string2					State_Origin;
		unsigned8				State_Bitmap_Flag;
		string1					Latest_Vehicle_Flag;
		string1					Latest_Vehicle_Iteration_Flag;
		string1					History;
		unsigned4				Date_First_Seen;
		unsigned4				Date_Last_Seen;
		unsigned4				Date_Vendor_First_Reported;
		unsigned4				Date_Vendor_Last_Reported;
		string1					Orig_Party_Type;
		string1					Orig_Name_Type;
		string10				Orig_Conjunction;
		string70				Orig_Name;
		string70				Orig_Address;
		string35				Orig_City;
		string2					Orig_State;
		String30        orig_province;
		String30        orig_country;
		string10				Orig_Zip;
		string9					Orig_SSN;
		string9					Orig_FEIN;
		string20				Orig_DL_Number;
		string8					Orig_DOB;
		string1					Orig_Sex;
		string8					Orig_Lien_Date;
		string5					title;
		string20				fname;
		string20				mname;
		string20				lname;
		string5					name_suffix;
		string3					name_score;
		string70				Append_Clean_CName;
		string150				Append_Ace1_PrepAddr1	:=	'';
		string100				Append_Ace1_PrepAddr2	:=	'';
		AID.Common.xAID	Append_Ace1_RawAID		:=	0;
		string150				Append_Ace2_PrepAddr1	:=	'';
		string50				Append_Ace2_PrepAddr2	:=	'';
		AID.Common.xAID	Append_Ace2_RawAID		:=	0;
		string10				prim_range;
		string2					predir;
		string28				prim_name;
		string4					addr_suffix;
		string2					postdir;
		string10				unit_desig;
		string8					sec_range;
		string25				v_city_name;
		string2					st;
		string5					zip5;
		string4					zip4;
		string2					addr_rec_type;
		string2					fips_state;
		string3					fips_county;
		string10				geo_lat;
		string11				geo_long;
		string4					cbsa;
		string7					geo_blk;
		string1					geo_match;
		string4					err_stat;
		string10				ace_prim_range;
		string2					ace_predir;
		string28				ace_prim_name;
		string4					ace_addr_suffix;
		string2					ace_postdir;
		string10				ace_unit_desig;
		string8					ace_sec_range;
		string25				ace_p_city_name;
		string25				ace_v_city_name;
		string2					ace_st;
		string5					ace_zip5;
		string4					ace_zip4;
		string2					ace_addr_rec_type;
		string2					ace_fips_state;
		string3					ace_fips_county;
		string10				ace_geo_lat;
		string11				ace_geo_long;
		string4					ace_cbsa;
		string7					ace_geo_blk;
		string1					ace_geo_match;
		string4					ace_err_stat;
		unsigned6				Append_DID;
		unsigned1				Append_DID_Score;
		unsigned6				Append_BDID;
		unsigned1				Append_BDID_Score;
		string20				Append_DL_Number;
		string9					Append_SSN;
		string9					Append_FEIN;
		string8     		Append_DOB;
		string8					Reg_First_Date;
		string8					Registration_Effective_Date;
		string8					Reg_Earliest_Effective_Date;
		string8					Reg_Latest_Effective_Date;
		string8					Registration_Expiration_Date;
		string10				Reg_Latest_Expiration_Date;
		unsigned1				Reg_Rollup_Count;
		string10				Reg_Decal_Number;
		string4					Reg_Decal_Year;
		string1					Reg_Status_Code;
		string20				Reg_Status_Desc;
		string10				Reg_True_License_Plate;
		string10				Reg_License_Plate;
		string2					Reg_License_State;
		string4					Reg_License_Plate_Type_Code;
		string65				Reg_License_Plate_Type_Desc;
		string2					Reg_Previous_License_State;
		string10				Reg_Previous_License_Plate;
		string20				Ttl_Number;
		string8					Title_Issue_Date;
		string8					Ttl_Earliest_Issue_Date;
		string8					Ttl_Latest_Issue_Date;
		string8					Ttl_Previous_Issue_Date;
		unsigned1				Ttl_Rollup_Count;
		string2					Ttl_Status_Code;
		string48				Ttl_Status_Desc;
    string2         Previous_Title_State;
		string7					Ttl_Odometer_Mileage;
		string1					Ttl_Odometer_Status_Code;
		string42				Ttl_Odometer_Status_Desc;
		string8					Ttl_Odometer_Date;
	end;
	
	export	Party_Bip_old	:=record
		Party_old;
		BIPV2.IDlayouts.l_xlink_ids;		 			//Added for BIP project
		unsigned8				source_rec_id := 0;	 	//Added for BIP project
   end;
	
end;