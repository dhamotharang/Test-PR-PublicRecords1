﻿//HPCC Systems KEL Compiler Version 1.2.0beta4
IMPORT KEL12 AS KEL;
IMPORT B_Person_2,B_Person_4,B_Person_Vehicle_2,B_Vehicle_2,B_Vehicle_4,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_1(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_2(__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2(__cfg).__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2;
  SHARED VIRTUAL TYPEOF(B_Vehicle_2(__cfg).__ENH_Vehicle_2) __ENH_Vehicle_2 := B_Vehicle_2(__cfg).__ENH_Vehicle_2;
  SHARED __EE90923 := __ENH_Person_2;
  SHARED __EE91294 := __ENH_Person_Vehicle_2;
  SHARED __EE93657 := __EE91294(__NN(__EE91294.Automobile_) AND __NN(__EE91294.Vehicle_Min_Date_) AND __NN(__EE91294.Subject_));
  SHARED __EE94633 := __EE93657;
  SHARED __EE90939 := __EE90923;
  SHARED __EE90969 := __EE90939;
  SHARED __EE93157 := __EE90969(__NN(__EE90969.P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_));
  __JC94649(B_Person_Vehicle_2(__cfg).__ST12768_Layout __EE94633, B_Person_2(__cfg).__ST8416_Layout __EE93157) := __EEQP(__EE93157.UID,__EE94633.Subject_) AND __NNEQ(__EE94633.Vehicle_Min_Date_,__EE93157.P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_) AND __T(__AND(__EEQ(__EE93157.UID,__EE94633.Subject_),__OP2(__EE94633.Vehicle_Min_Date_,=,__EE93157.P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_))) AND __EE94633.__Part = __EE93157.__Part;
  SHARED __EE94650 := JOIN(__EE94633,__EE93157,__JC94649(LEFT,RIGHT),TRANSFORM(B_Person_Vehicle_2(__cfg).__ST12768_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __EE91296 := __ENH_Vehicle_2;
  SHARED __EE94630 := __EE91296;
  SHARED __EE94707 := __EE94630(__T(__EE94630.Flag_Other_));
  SHARED __ST87424_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_At_First_Seen_;
    KEL.typ.nfloat Age_Year_At_First_Seen_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nint Depreciated_Price_;
    KEL.typ.nbool Flag_Depreciated_Price_;
    KEL.typ.nstr Vehicle_Min_Date_;
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
    KEL.typ.ndataset(E_Vehicle(__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nbool Flag_Auto_;
    KEL.typ.nbool Flag_Other_;
    KEL.typ.str Flag_Vina_Make_Desc_ := '';
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.nstr Vina_Body_Style_Vehicle_Type_;
    KEL.typ.nstr Vina_Model_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC94715(B_Person_Vehicle_2(__cfg).__ST12768_Layout __EE94650, B_Vehicle_4(__cfg).__ST9861_Layout __EE94707) := __EEQP(__EE94650.Automobile_,__EE94707.UID) AND __EE94650.__Part = __EE94707.__Part;
  __ST87424_Layout __JT94715(B_Person_Vehicle_2(__cfg).__ST12768_Layout __l, B_Vehicle_4(__cfg).__ST9861_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE94716 := JOIN(__EE94650,__EE94707,__JC94715(LEFT,RIGHT),__JT94715(LEFT,RIGHT),INNER,HASH);
  SHARED __ST86532_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) ____grp___U_I_D_;
    KEL.typ.nstr Vina_Vin_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE95756 := PROJECT(TABLE(PROJECT(__EE94716,TRANSFORM(__ST86532_Layout,SELF.____grp___U_I_D_ := LEFT.Subject_,SELF := LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),____grp___U_I_D_,Vina_Vin_,Date_First_Seen_Capped_,Date_Last_Seen_Capped_,Vehicle_Type_,__Part},____grp___U_I_D_,Vina_Vin_,Date_First_Seen_Capped_,Date_Last_Seen_Capped_,Vehicle_Type_,__Part,MERGE),__ST86532_Layout);
  SHARED __EE95771 := GROUP(__EE95756,____grp___U_I_D_,__Part,ALL);
  SHARED __EE95784 := TOPN(__EE95771(__NN(__EE95771.Date_First_Seen_Capped_) AND __NN(__EE95771.Date_Last_Seen_Capped_)),1, -__T(__EE95771.Date_First_Seen_Capped_), -__T(__EE95771.Date_Last_Seen_Capped_),__T(____grp___U_I_D_),__T(Vina_Vin_),__T(Vehicle_Type_));
  __JC95790(__ST86532_Layout __EE95784, B_Person_2(__cfg).__ST8416_Layout __EE90939) := __EEQP(__EE90939.UID,__EE95784.____grp___U_I_D_) AND __EE95784.__Part = __EE90939.__Part;
  SHARED __EE95797 := JOIN(__EE95784,__EE90939,__JC95790(LEFT,RIGHT),TRANSFORM(__ST86532_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST86325_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Vina_Vin_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE95829 := PROJECT(__EE95797,TRANSFORM(__ST86325_Layout,SELF.UID := LEFT.____grp___U_I_D_,SELF := LEFT));
  SHARED __ST86349_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE95843 := PROJECT(__EE95829,__ST86349_Layout);
  SHARED __ST86378_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr O_N_L_Y___Vehicle_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __EE95857 := PROJECT(__EE95843,TRANSFORM(__ST86378_Layout,SELF.O_N_L_Y___Vehicle_Type_ := LEFT.Vehicle_Type_,SELF := LEFT));
  SHARED __ST87718_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(B_Person_4(__cfg).__ST4433_Layout) Ast_Veh_Auto_Emrg_Price_Set_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.bool Invalid_Vehicle_Auto_Min_Date_ := FALSE;
    KEL.typ.bool Invalid_Vehicle_Other_Min_Date_ := FALSE;
    KEL.typ.nstr Most_Frequent_Vina_Make_;
    KEL.typ.nstr Most_Frequent_Vina_Make2_;
    KEL.typ.bool No_Person_Vehicle_Auto_Found_ := FALSE;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.ndataset(B_Person_2(__cfg).__ST4482_Layout) P_L___Ast_Veh_Auto_Emrg_Price_Set2_;
    KEL.typ.int P_L___Ast_Veh_Other_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Vehicle_Build_Current_Date_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr O_N_L_Y___Vehicle_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC95863(B_Person_2(__cfg).__ST8416_Layout __EE90923, __ST86378_Layout __EE95857) := __EEQP(__EE90923.UID,__EE95857.UID) AND __EE90923.__Part = __EE95857.__Part;
  __ST87718_Layout __JT95863(B_Person_2(__cfg).__ST8416_Layout __l, __ST86378_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE95926 := JOIN(__EE90923,__EE95857,__JC95863(LEFT,RIGHT),__JT95863(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  SHARED __EE91302 := __EE91296(__T(__EE91296.Flag_Auto_));
  SHARED __ST87021_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_At_First_Seen_;
    KEL.typ.nfloat Age_Year_At_First_Seen_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nint Depreciated_Price_;
    KEL.typ.nbool Flag_Depreciated_Price_;
    KEL.typ.nstr Vehicle_Min_Date_;
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
    KEL.typ.ndataset(E_Vehicle(__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nbool Flag_Auto_;
    KEL.typ.nbool Flag_Other_;
    KEL.typ.str Flag_Vina_Make_Desc_ := '';
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.nstr Vina_Body_Style_Vehicle_Type_;
    KEL.typ.nstr Vina_Model_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC93669(B_Person_Vehicle_2(__cfg).__ST12768_Layout __EE93657, B_Vehicle_4(__cfg).__ST9861_Layout __EE91302) := __EEQP(__EE93657.Automobile_,__EE91302.UID) AND __EE93657.__Part = __EE91302.__Part;
  __ST87021_Layout __JT93669(B_Person_Vehicle_2(__cfg).__ST12768_Layout __l, B_Vehicle_4(__cfg).__ST9861_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE93670 := JOIN(__EE93657,__EE91302,__JC93669(LEFT,RIGHT),__JT93669(LEFT,RIGHT),INNER,HASH);
  SHARED __ST88886_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(B_Person_4(__cfg).__ST4433_Layout) Ast_Veh_Auto_Emrg_Price_Set_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.bool Invalid_Vehicle_Auto_Min_Date_ := FALSE;
    KEL.typ.bool Invalid_Vehicle_Other_Min_Date_ := FALSE;
    KEL.typ.nstr Most_Frequent_Vina_Make_;
    KEL.typ.nstr Most_Frequent_Vina_Make2_;
    KEL.typ.bool No_Person_Vehicle_Auto_Found_ := FALSE;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.ndataset(B_Person_2(__cfg).__ST4482_Layout) P_L___Ast_Veh_Auto_Emrg_Price_Set2_;
    KEL.typ.int P_L___Ast_Veh_Other_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Vehicle_Build_Current_Date_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr O_N_L_Y___Vehicle_Type_;
    KEL.typ.ndataset(__ST87021_Layout) Person_Vehicle_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC95998(__ST87718_Layout __EE95926, __ST87021_Layout __EE93670) := __EEQP(__EE95926.UID,__EE93670.Subject_) AND __NNEQ(__EE93670.Vehicle_Min_Date_,__EE95926.P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_) AND __T(__AND(__EEQ(__EE95926.UID,__EE93670.Subject_),__OP2(__EE93670.Vehicle_Min_Date_,=,__EE95926.P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_))) AND __EE95926.__Part = __EE93670.__Part;
  __ST88886_Layout __Join__ST88886_Layout(__ST87718_Layout __r, DATASET(__ST87021_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Vehicle_ := __CN(__recs);
  END;
  SHARED __EE96227 := DENORMALIZE(DISTRIBUTE(__EE95926,HASH(UID)),DISTRIBUTE(__EE93670,HASH(Subject_)),__JC95998(LEFT,RIGHT),GROUP,__Join__ST88886_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST4348_Layout := RECORD
    KEL.typ.nstr Vina_Vin_;
    KEL.typ.nstr Vehicle_Type_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __NS98467_Layout := RECORD
    KEL.typ.nkdate Purch_Process_Date_;
    KEL.typ.nstr Purch_History_Flag_;
    KEL.typ.nint Purch_New_Amt_;
    KEL.typ.nint Purch_Total_;
    KEL.typ.nint Purch_Count_;
    KEL.typ.nint Purch_New_Age_Months_;
    KEL.typ.nint Purch_Old_Age_Months_;
    KEL.typ.nint Purch_Item_Count_;
    KEL.typ.nint Purch_Amt_Avg_;
  END;
  EXPORT __ST7689_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(__ST4348_Layout) Ast_Veh_Auto_New_Type_;
    __NS98467_Layout Best_Dunn_Data_;
    KEL.typ.bool Invalid_Vehicle_Auto_Min_Date_ := FALSE;
    KEL.typ.bool Invalid_Vehicle_Other_Min_Date_ := FALSE;
    KEL.typ.nstr Most_Frequent_Vina_Make_;
    KEL.typ.nstr Most_Frequent_Vina_Make2_;
    KEL.typ.bool No_Person_Vehicle_Auto_Found_ := FALSE;
    KEL.typ.nstr P_L___Ast_Veh_Auto2nd_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price1_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price2_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Other_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Other_Emrg_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Other_New_Type_;
    KEL.typ.str P___Lex_I_D_Seen_Dunn_Flag_ := '';
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST7689_Layout __ND96914__Project(__ST88886_Layout __PP96460) := TRANSFORM
    __EE96458 := __PP96460.Person_Vehicle_;
    __EE96567 := PROJECT(TABLE(PROJECT(__T(__EE96458),__ST4348_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Vina_Vin_,Vehicle_Type_,Date_First_Seen_Capped_,Date_Last_Seen_Capped_},Vina_Vin_,Vehicle_Type_,Date_First_Seen_Capped_,Date_Last_Seen_Capped_,MERGE),__ST4348_Layout);
    __EE96580 := TOPN(__EE96567(__NN(__EE96567.Date_First_Seen_Capped_) AND __NN(__EE96567.Date_Last_Seen_Capped_)),1, -__T(__EE96567.Date_First_Seen_Capped_), -__T(__EE96567.Date_Last_Seen_Capped_),__T(Vina_Vin_),__T(Vehicle_Type_));
    SELF.Ast_Veh_Auto_New_Type_ := __CN(__EE96580(__NN(Vina_Vin_) OR __NN(Vehicle_Type_) OR __NN(Date_First_Seen_Capped_) OR __NN(Date_Last_Seen_Capped_)));
    __EE96585 := __PP96460.Dunn_Data_;
    __ST84754_Layout := RECORD
      KEL.typ.nkdate M_A_X___Current_Date_;
      KEL.typ.nkdate Purch_Process_Date_;
      KEL.typ.nstr Purch_History_Flag_;
      KEL.typ.nint Purch_New_Amt_;
      KEL.typ.nint Purch_Total_;
      KEL.typ.nint Purch_Count_;
      KEL.typ.nint Purch_New_Age_Months_;
      KEL.typ.nint Purch_Old_Age_Months_;
      KEL.typ.nint Purch_Item_Count_;
      KEL.typ.nint Purch_Amt_Avg_;
      KEL.typ.epoch Date_First_Seen_ := 0;
      KEL.typ.epoch Date_Last_Seen_ := 0;
      KEL.typ.int __RecordCount := 0;
    END;
    __BS96636 := __T(__EE96585);
    __EE96638 := PROJECT(__CLEANANDDO(__BS96636,TABLE(__BS96636,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.Aggregates.MaxNG(__PP96460.Current_Date_) M_A_X___Current_Date_,Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_},Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_,MERGE)),__ST84754_Layout);
    __EE96666 := TOPN(__EE96638(__NN(__EE96638.M_A_X___Current_Date_) AND __NN(__EE96638.Purch_Process_Date_) AND __NN(__EE96638.Purch_Count_) AND __NN(__EE96638.Purch_New_Age_Months_)),1, -__T(__EE96638.M_A_X___Current_Date_), -__T(__EE96638.Purch_Process_Date_), -__T(__EE96638.Purch_Count_),__T(__EE96638.Purch_New_Age_Months_),__T(Purch_History_Flag_),__T(Purch_New_Amt_),__T(Purch_Total_),__T(Purch_Old_Age_Months_),__T(Purch_Item_Count_),__T(Purch_Amt_Avg_));
    __EE96912 := __CN(PROJECT(__EE96666,E_Person(__cfg).Dunn_Data_Layout));
    SELF.Best_Dunn_Data_ := (__T(__EE96912))[1];
    __CC1056 := '-99999';
    __CC1061 := '-99998';
    __CC1066 := '-99997';
    SELF.P_L___Ast_Veh_Auto2nd_Freq_Make_ := MAP(__PP96460.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC1056)),__PP96460.No_Person_Vehicle_Auto_Found_=>__ECAST(KEL.typ.nstr,__CN(__CC1061)),__T(__OP2(__PP96460.Most_Frequent_Vina_Make2_,<>,__PP96460.Most_Frequent_Vina_Make_))=>__ECAST(KEL.typ.nstr,__PP96460.Most_Frequent_Vina_Make2_),__ECAST(KEL.typ.nstr,__CN(__CC1066)));
    __CC1054 := -99999;
    __CC1059 := -99998;
    __CC1064 := -99997;
    SELF.P_L___Ast_Veh_Auto_Emrg_New_Msnc_Ev_ := MAP(__PP96460.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nint,__CN(__CC1054)),__PP96460.P_L___Ast_Veh_Auto_Cnt_Ev_ = 0=>__ECAST(KEL.typ.nint,__CN(__CC1059)),__T(__OP2(__PP96460.P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_,=,__CN(__CC1066)))=>__ECAST(KEL.typ.nint,__CN(__CC1064)),__ECAST(KEL.typ.nint,__FN3(KEL.Routines.BoundsFold,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96460.P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_),__PP96460.Vehicle_Build_Current_Date_),__CN(0),__CN(999))));
    __EE96756 := __PP96460.Ast_Veh_Auto_Emrg_Price_Set_;
    __EE96770 := __PP96460.Ast_Veh_Auto_Emrg_Price_Set_;
    SELF.P_L___Ast_Veh_Auto_Emrg_Price1_ := IF(__T(__NT((__T(__EE96756))[1].Depreciated_Price_)),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,(__T(__EE96770))[1].Depreciated_Price_));
    __EE96782 := __PP96460.P_L___Ast_Veh_Auto_Emrg_Price_Set2_;
    __EE96796 := __PP96460.P_L___Ast_Veh_Auto_Emrg_Price_Set2_;
    SELF.P_L___Ast_Veh_Auto_Emrg_Price2_ := IF(__T(__NT((__T(__EE96782))[1].Depreciated_Price_)),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,(__T(__EE96796))[1].Depreciated_Price_));
    SELF.P_L___Ast_Veh_Auto_Freq_Make_ := MAP(__PP96460.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC1056)),__PP96460.No_Person_Vehicle_Auto_Found_=>__ECAST(KEL.typ.nstr,__CN(__CC1061)),__ECAST(KEL.typ.nstr,__PP96460.Most_Frequent_Vina_Make_));
    SELF.P_L___Ast_Veh_Other_Emrg_New_Msnc_Ev_ := MAP(__PP96460.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nint,__CN(__CC1054)),__PP96460.P_L___Ast_Veh_Other_Cnt_Ev_ = 0=>__ECAST(KEL.typ.nint,__CN(__CC1059)),__T(__OP2(__PP96460.P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_,=,__CN(__CC1066)))=>__ECAST(KEL.typ.nint,__CN(__CC1064)),__ECAST(KEL.typ.nint,__FN3(KEL.Routines.BoundsFold,__FN2(KEL.Routines.MonthsBetween,KEL.Routines.CastStringToDate(__PP96460.P_L___Ast_Veh_Other_Emrg_New_Dt_Ev_),__PP96460.Vehicle_Build_Current_Date_),__CN(0),__CN(999))));
    SELF.P_L___Ast_Veh_Other_New_Type_ := __PP96460.O_N_L_Y___Vehicle_Type_;
    __BS96838 := __T(__PP96460.Data_Sources_);
    SELF.P___Lex_I_D_Seen_Dunn_Flag_ := IF(EXISTS(__BS96838(__T(__OP2(__T(__PP96460.Data_Sources_).Source_,=,__CN('A3'))))),'1','0');
    SELF := __PP96460;
  END;
  EXPORT __ENH_Person_1 := PROJECT(__EE96227,__ND96914__Project(LEFT));
END;
