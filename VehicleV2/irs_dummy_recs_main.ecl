import ut;
layout_old := 
  record
	string30		Vehicle_Key;
	string15		Iteration_Key;
	string2			Source_Code;
	string2			State_Origin;
	unsigned8		State_Bitmap_Flag;
	string25		Orig_VIN;
	string4			Orig_Year;
	string5			Orig_Make_Code;
	string36		Orig_Make_Desc;
	string3			Orig_Series_Code;
	string25		Orig_Series_Desc;
	string3			Orig_Model_Code;
	string30		Orig_Model_Desc;
	string5			Orig_Body_Code;
	string20		Orig_Body_Desc;
	string6         Orig_Net_Weight;
	string6         Orig_Gross_Weight;
    string1         Orig_Number_Of_Axles;
	string1         Orig_Vehicle_Use_code;
	string30        Orig_Vehicle_Use_Desc;
	string5			Orig_Vehicle_Type_Code;
	string30		Orig_Vehicle_Type_Desc;
	string3			Orig_Major_Color_Code;
	string15		Orig_Major_Color_Desc;
	string3			Orig_Minor_Color_Code;
	string15		Orig_Minor_Color_Desc;
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
	string5			Best_Make_Code;
	string3			Best_Series_Code;
	string3			Best_Model_Code;
	string5			Best_Body_Code;
	string4			Best_Model_Year;
	string3			Best_Major_Color_Code;
	string3			Best_Minor_Color_Code;
	end; 
//Modified for CCPA-103
export irs_dummy_recs_main :=  project(dataset('~thor_data400::vehv2::irs_main',layout_old,flat),transform(VehicleV2.Layout_Base_Main,
                                                                                                           //Added for CCPA-103
                                                                                                           self.global_sid := 0, 
																																																					 self.record_sid := 0,
																																																					 self:=left,
																																																					 self := []
																																																					)
																			);