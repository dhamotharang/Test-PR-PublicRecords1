﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Vehicle_9(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Vehicle(__cfg).__Result) __E_Vehicle := E_Vehicle(__cfg).__Result;
  SHARED __EE14942 := __E_Vehicle;
  EXPORT __ST11896_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Vehicle_Key_;
    KEL.typ.nstr State_Of_Origin_;
    KEL.typ.nstr Original_Vin_;
    KEL.typ.nint Original_Year_Make_;
    KEL.typ.nstr Original_Make_;
    KEL.typ.nstr Original_Make_Description_;
    KEL.typ.nstr Original_Series_;
    KEL.typ.nstr Original_Series_Description_;
    KEL.typ.nstr Original_Model_;
    KEL.typ.nstr Original_Model_Description_;
    KEL.typ.nstr Original_Body_;
    KEL.typ.nstr Original_Body_Description_;
    KEL.typ.nint Original_Net_Weight_;
    KEL.typ.nint Original_Gross_Weight_;
    KEL.typ.nint Original_Number_Axles_;
    KEL.typ.nstr Original_Vehicle_Use_;
    KEL.typ.nstr Original_Vehicle_Use_Description_;
    KEL.typ.nstr Original_Vehicle_Type_;
    KEL.typ.nstr Original_Vehicle_Type_Description_;
    KEL.typ.nstr Original_Major_Color_;
    KEL.typ.nstr Original_Major_Color_Description_;
    KEL.typ.nstr Original_Minor_Color_;
    KEL.typ.nstr Original_Minor_Color_Description_;
    KEL.typ.nstr Vina_Vin_;
    KEL.typ.nstr Vina_Vin_Pattern_;
    KEL.typ.nstr Vina_Bypass_Code_;
    KEL.typ.nstr Vina_Vehicle_Type_;
    KEL.typ.nstr Vina_N_C_I_C_Make_;
    KEL.typ.nint Vina_Model_Year_Y_Y_;
    KEL.typ.nstr Vina_Restraint_;
    KEL.typ.nstr Vina_Make_Name_;
    KEL.typ.nint Vina_Year_;
    KEL.typ.nstr Vina_Vp_Series_;
    KEL.typ.nstr Vina_Vp_Model_;
    KEL.typ.nstr Vina_Air_Conditioning_;
    KEL.typ.nstr Vina_Power_Steering_;
    KEL.typ.nstr Vina_Power_Brakes_;
    KEL.typ.nstr Vina_Power_Windows_;
    KEL.typ.nstr Vina_Tilt_Wheel_;
    KEL.typ.nint Vina_Roof_;
    KEL.typ.nint Vina_Optional_Roof1_;
    KEL.typ.nint Vina_Optional_Roof2_;
    KEL.typ.nstr Vina_Radio_;
    KEL.typ.nstr Vina_Optional_Radio1_;
    KEL.typ.nstr Vina_Optional_Radio2_;
    KEL.typ.nstr Vina_Transmission_;
    KEL.typ.nstr Vina_Optional_Transmission1_;
    KEL.typ.nstr Vina_Optional_Transmission2_;
    KEL.typ.nint Vina_A_L_B_;
    KEL.typ.nstr Vina_Front_W_D_;
    KEL.typ.nstr Vina_Four_W_D_;
    KEL.typ.nstr Vina_Security_System_;
    KEL.typ.nstr Vina_D_R_L_;
    KEL.typ.nstr Vina_Series_Name_;
    KEL.typ.nint Vina_Model_Year_;
    KEL.typ.nstr Vina_Series_;
    KEL.typ.nstr Vina_Model_;
    KEL.typ.nstr Vina_Body_Style_;
    KEL.typ.nstr Vina_Make_Description_;
    KEL.typ.nstr Vina_Model_Description_;
    KEL.typ.nstr Vina_Series_Description_;
    KEL.typ.nstr Vina_Body_Style_Description_;
    KEL.typ.nint Vina_Cylinders_;
    KEL.typ.nint Vina_Engine_Size_;
    KEL.typ.nstr Vina_Fuel_Code_;
    KEL.typ.nint Vina_Price_;
    KEL.typ.nstr Best_Make_Code_;
    KEL.typ.nstr Best_Series_Code_;
    KEL.typ.nstr Best_Model_Code_;
    KEL.typ.nstr Best_Body_Code_;
    KEL.typ.nint Best_Model_Year_;
    KEL.typ.nstr Best_Major_Color_;
    KEL.typ.nstr Best_Minor_Color_;
    KEL.typ.nstr Branded_Title_Flag_;
    KEL.typ.nstr Brand_Code1_;
    KEL.typ.nkdate Brand_Date1_;
    KEL.typ.nstr Brand_State1_;
    KEL.typ.nstr Brand_Code2_;
    KEL.typ.nkdate Brand_Date2_;
    KEL.typ.nstr Brand_Sate2_;
    KEL.typ.nstr Brand_Code3_;
    KEL.typ.nkdate Brand_Date3_;
    KEL.typ.nstr Brand_Sate3_;
    KEL.typ.nstr Brand_Code4_;
    KEL.typ.nkdate Brand_Date4_;
    KEL.typ.nstr Brand_Sate4_;
    KEL.typ.nstr Brand_Code5_;
    KEL.typ.nkdate Brand_Date5_;
    KEL.typ.nstr Brand_Sate5_;
    KEL.typ.nstr Safety_Type_;
    KEL.typ.nstr Airbag_Driver_;
    KEL.typ.nstr Airbag_Front_Driver_Side_;
    KEL.typ.nstr Airbag_Front_Head_Curtain_;
    KEL.typ.nstr Airbag_Front_Passanger_;
    KEL.typ.nstr Airbag_Front_Passanger_Side_;
    KEL.typ.nstr Airbags_;
    KEL.typ.nstr Tod_Flag_;
    KEL.typ.nstr Model_Class_Code_;
    KEL.typ.nstr Model_Class_;
    KEL.typ.nstr Min_Door_Count_;
    KEL.typ.nstr Latest_Vehicle_Flag_;
    KEL.typ.nstr Latest_Vehicle_Iteration_Flag_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Standard_Lienholder_Name_;
    KEL.typ.nkdate Source_First_Date_;
    KEL.typ.nkdate Source_Last_Date_;
    KEL.typ.ndataset(E_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Vina_Body_Style_Vehicle_Type_;
    KEL.typ.nstr Vina_Model_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST11896_Layout __ND15177__Project(E_Vehicle(__cfg).Layout __PP14357) := TRANSFORM
    SELF.Vina_Body_Style_Vehicle_Type_ := __OP2(__OP2(__FN1(KEL.Routines.TrimBoth,__PP14357.Vina_Body_Style_Description_),+,__CN('-')),+,__FN1(KEL.Routines.TrimBoth,__PP14357.Vina_Vehicle_Type_));
    SELF.Vina_Model_Date_ := __ECAST(KEL.typ.nstr,__FN3(KEL.Routines.DateFromParts,__OP2(__PP14357.Vina_Model_Year_,-,__CN(1)),__CN(1),__CN(1)));
    SELF := __PP14357;
  END;
  EXPORT __ENH_Vehicle_9 := PROJECT(__EE14942,__ND15177__Project(LEFT));
END;
