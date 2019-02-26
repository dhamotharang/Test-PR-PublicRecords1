//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Vehicle(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Vehicle_Key_;
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
    KEL.typ.nstr Tod_Flag_;
    KEL.typ.nstr Model_Class_Code_;
    KEL.typ.nstr Model_Class_;
    KEL.typ.nstr Min_Door_Count_;
    KEL.typ.nstr Saftey_Type_;
    KEL.typ.nstr Airbag_Driver_;
    KEL.typ.nstr Airbag_Front_Driver_Side_;
    KEL.typ.nstr Airbag_Front_Head_Curtain_;
    KEL.typ.nstr Airbag_Front_Passanger_;
    KEL.typ.nstr Airbag_Front_Passanger_Side_;
    KEL.typ.nstr Airbags_;
    KEL.typ.nstr State_Of_Origin_;
    KEL.typ.nstr Latest_Vehicle_Flag_;
    KEL.typ.nstr Latest_Vehicle_Iteration_Flag_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nkdate Source_First_Date_;
    KEL.typ.nkdate Source_Last_Date_;
    KEL.typ.nstr Standard_Lienholder_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),vehiclekey(Vehicle_Key_:\'\'),originalvin(Original_Vin_:\'\'),originalyearmake(Original_Year_Make_:0),originalmake(Original_Make_:\'\'),originalmakedescription(Original_Make_Description_:\'\'),originalseries(Original_Series_:\'\'),originalseriesdescription(Original_Series_Description_:\'\'),originalmodel(Original_Model_:\'\'),originalmodeldescription(Original_Model_Description_:\'\'),originalbody(Original_Body_:\'\'),originalbodydescription(Original_Body_Description_:\'\'),originalnetweight(Original_Net_Weight_:0),originalgrossweight(Original_Gross_Weight_:0),originalnumberaxles(Original_Number_Axles_:0),originalvehicleuse(Original_Vehicle_Use_:\'\'),originalvehicleusedescription(Original_Vehicle_Use_Description_:\'\'),originalvehicletype(Original_Vehicle_Type_:\'\'),originalvehicletypedescription(Original_Vehicle_Type_Description_:\'\'),originalmajorcolor(Original_Major_Color_:\'\'),originalmajorcolordescription(Original_Major_Color_Description_:\'\'),originalminorcolor(Original_Minor_Color_:\'\'),originalminorcolordescription(Original_Minor_Color_Description_:\'\'),vinavin(Vina_Vin_:\'\'),vinavinpattern(Vina_Vin_Pattern_:\'\'),vinabypasscode(Vina_Bypass_Code_:\'\'),vinavehicletype(Vina_Vehicle_Type_:\'\'),vinancicmake(Vina_N_C_I_C_Make_:\'\'),vinamodelyearyy(Vina_Model_Year_Y_Y_:0),vinarestraint(Vina_Restraint_:\'\'),vinamakename(Vina_Make_Name_:\'\'),vinayear(Vina_Year_:0),vinavpseries(Vina_Vp_Series_:\'\'),vinavpmodel(Vina_Vp_Model_:\'\'),vinaairconditioning(Vina_Air_Conditioning_:\'\'),vinapowersteering(Vina_Power_Steering_:\'\'),vinapowerbrakes(Vina_Power_Brakes_:\'\'),vinapowerwindows(Vina_Power_Windows_:\'\'),vinatiltwheel(Vina_Tilt_Wheel_:\'\'),vinaroof(Vina_Roof_:0),vinaoptionalroof1(Vina_Optional_Roof1_:0),vinaoptionalroof2(Vina_Optional_Roof2_:0),vinaradio(Vina_Radio_:\'\'),vinaoptionalradio1(Vina_Optional_Radio1_:\'\'),vinaoptionalradio2(Vina_Optional_Radio2_:\'\'),vinatransmission(Vina_Transmission_:\'\'),vinaoptionaltransmission1(Vina_Optional_Transmission1_:\'\'),vinaoptionaltransmission2(Vina_Optional_Transmission2_:\'\'),vinaalb(Vina_A_L_B_:0),vinafrontwd(Vina_Front_W_D_:\'\'),vinafourwd(Vina_Four_W_D_:\'\'),vinasecuritysystem(Vina_Security_System_:\'\'),vinadrl(Vina_D_R_L_:\'\'),vinaseriesname(Vina_Series_Name_:\'\'),vinamodelyear(Vina_Model_Year_:0),vinaseries(Vina_Series_:\'\'),vinamodel(Vina_Model_:\'\'),vinabodystyle(Vina_Body_Style_:\'\'),vinamakedescription(Vina_Make_Description_:\'\'),vinamodeldescription(Vina_Model_Description_:\'\'),vinaseriesdescription(Vina_Series_Description_:\'\'),vinabodystyledescription(Vina_Body_Style_Description_:\'\'),vinacylinders(Vina_Cylinders_:0),vinaenginesize(Vina_Engine_Size_:0),vinafuelcode(Vina_Fuel_Code_:\'\'),vinaprice(Vina_Price_:0),bestmakecode(Best_Make_Code_:\'\'),bestseriescode(Best_Series_Code_:\'\'),bestmodelcode(Best_Model_Code_:\'\'),bestbodycode(Best_Body_Code_:\'\'),bestmodelyear(Best_Model_Year_:0),bestmajorcolor(Best_Major_Color_:\'\'),bestminorcolor(Best_Minor_Color_:\'\'),brandedtitleflag(Branded_Title_Flag_:\'\'),brandcode1(Brand_Code1_:\'\'),branddate1(Brand_Date1_:DATE),brandstate1(Brand_State1_:\'\'),brandcode2(Brand_Code2_:\'\'),branddate2(Brand_Date2_:DATE),brandsate2(Brand_Sate2_:\'\'),brandcode3(Brand_Code3_:\'\'),branddate3(Brand_Date3_:DATE),brandsate3(Brand_Sate3_:\'\'),brandcode4(Brand_Code4_:\'\'),branddate4(Brand_Date4_:DATE),brandsate4(Brand_Sate4_:\'\'),brandcode5(Brand_Code5_:\'\'),branddate5(Brand_Date5_:DATE),brandsate5(Brand_Sate5_:\'\'),todflag(Tod_Flag_:\'\'),modelclasscode(Model_Class_Code_:\'\'),modelclass(Model_Class_:\'\'),mindoorcount(Min_Door_Count_:\'\'),safteytype(Saftey_Type_:\'\'),airbagdriver(Airbag_Driver_:\'\'),airbagfrontdriverside(Airbag_Front_Driver_Side_:\'\'),airbagfrontheadcurtain(Airbag_Front_Head_Curtain_:\'\'),airbagfrontpassanger(Airbag_Front_Passanger_:\'\'),airbagfrontpassangerside(Airbag_Front_Passanger_Side_:\'\'),airbags(Airbags_:\'\'),stateoforigin(State_Of_Origin_:\'\'),latestvehicleflag(Latest_Vehicle_Flag_:\'\'),latestvehicleiterationflag(Latest_Vehicle_Iteration_Flag_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),sourcefirstdate(Source_First_Date_:DATE),sourcelastdate(Source_Last_Date_:DATE),standardlienholdername(Standard_Lienholder_Name_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.VehicleKey)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.VehicleKey) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.nstr Saftey_Type_;
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
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Vehicle_Group := __PostFilter;
  Layout Vehicle__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Vehicle_Key_ := KEL.Intake.SingleValue(__recs,Vehicle_Key_);
    SELF.State_Of_Origin_ := KEL.Intake.SingleValue(__recs,State_Of_Origin_);
    SELF.Original_Vin_ := KEL.Intake.SingleValue(__recs,Original_Vin_);
    SELF.Original_Year_Make_ := KEL.Intake.SingleValue(__recs,Original_Year_Make_);
    SELF.Original_Make_ := KEL.Intake.SingleValue(__recs,Original_Make_);
    SELF.Original_Make_Description_ := KEL.Intake.SingleValue(__recs,Original_Make_Description_);
    SELF.Original_Series_ := KEL.Intake.SingleValue(__recs,Original_Series_);
    SELF.Original_Series_Description_ := KEL.Intake.SingleValue(__recs,Original_Series_Description_);
    SELF.Original_Model_ := KEL.Intake.SingleValue(__recs,Original_Model_);
    SELF.Original_Model_Description_ := KEL.Intake.SingleValue(__recs,Original_Model_Description_);
    SELF.Original_Body_ := KEL.Intake.SingleValue(__recs,Original_Body_);
    SELF.Original_Body_Description_ := KEL.Intake.SingleValue(__recs,Original_Body_Description_);
    SELF.Original_Net_Weight_ := KEL.Intake.SingleValue(__recs,Original_Net_Weight_);
    SELF.Original_Gross_Weight_ := KEL.Intake.SingleValue(__recs,Original_Gross_Weight_);
    SELF.Original_Number_Axles_ := KEL.Intake.SingleValue(__recs,Original_Number_Axles_);
    SELF.Original_Vehicle_Use_ := KEL.Intake.SingleValue(__recs,Original_Vehicle_Use_);
    SELF.Original_Vehicle_Use_Description_ := KEL.Intake.SingleValue(__recs,Original_Vehicle_Use_Description_);
    SELF.Original_Vehicle_Type_ := KEL.Intake.SingleValue(__recs,Original_Vehicle_Type_);
    SELF.Original_Vehicle_Type_Description_ := KEL.Intake.SingleValue(__recs,Original_Vehicle_Type_Description_);
    SELF.Original_Major_Color_ := KEL.Intake.SingleValue(__recs,Original_Major_Color_);
    SELF.Original_Major_Color_Description_ := KEL.Intake.SingleValue(__recs,Original_Major_Color_Description_);
    SELF.Original_Minor_Color_ := KEL.Intake.SingleValue(__recs,Original_Minor_Color_);
    SELF.Original_Minor_Color_Description_ := KEL.Intake.SingleValue(__recs,Original_Minor_Color_Description_);
    SELF.Vina_Vin_ := KEL.Intake.SingleValue(__recs,Vina_Vin_);
    SELF.Vina_Vin_Pattern_ := KEL.Intake.SingleValue(__recs,Vina_Vin_Pattern_);
    SELF.Vina_Bypass_Code_ := KEL.Intake.SingleValue(__recs,Vina_Bypass_Code_);
    SELF.Vina_Vehicle_Type_ := KEL.Intake.SingleValue(__recs,Vina_Vehicle_Type_);
    SELF.Vina_N_C_I_C_Make_ := KEL.Intake.SingleValue(__recs,Vina_N_C_I_C_Make_);
    SELF.Vina_Model_Year_Y_Y_ := KEL.Intake.SingleValue(__recs,Vina_Model_Year_Y_Y_);
    SELF.Vina_Restraint_ := KEL.Intake.SingleValue(__recs,Vina_Restraint_);
    SELF.Vina_Make_Name_ := KEL.Intake.SingleValue(__recs,Vina_Make_Name_);
    SELF.Vina_Year_ := KEL.Intake.SingleValue(__recs,Vina_Year_);
    SELF.Vina_Vp_Series_ := KEL.Intake.SingleValue(__recs,Vina_Vp_Series_);
    SELF.Vina_Vp_Model_ := KEL.Intake.SingleValue(__recs,Vina_Vp_Model_);
    SELF.Vina_Air_Conditioning_ := KEL.Intake.SingleValue(__recs,Vina_Air_Conditioning_);
    SELF.Vina_Power_Steering_ := KEL.Intake.SingleValue(__recs,Vina_Power_Steering_);
    SELF.Vina_Power_Brakes_ := KEL.Intake.SingleValue(__recs,Vina_Power_Brakes_);
    SELF.Vina_Power_Windows_ := KEL.Intake.SingleValue(__recs,Vina_Power_Windows_);
    SELF.Vina_Tilt_Wheel_ := KEL.Intake.SingleValue(__recs,Vina_Tilt_Wheel_);
    SELF.Vina_Roof_ := KEL.Intake.SingleValue(__recs,Vina_Roof_);
    SELF.Vina_Optional_Roof1_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Roof1_);
    SELF.Vina_Optional_Roof2_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Roof2_);
    SELF.Vina_Radio_ := KEL.Intake.SingleValue(__recs,Vina_Radio_);
    SELF.Vina_Optional_Radio1_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Radio1_);
    SELF.Vina_Optional_Radio2_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Radio2_);
    SELF.Vina_Transmission_ := KEL.Intake.SingleValue(__recs,Vina_Transmission_);
    SELF.Vina_Optional_Transmission1_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Transmission1_);
    SELF.Vina_Optional_Transmission2_ := KEL.Intake.SingleValue(__recs,Vina_Optional_Transmission2_);
    SELF.Vina_A_L_B_ := KEL.Intake.SingleValue(__recs,Vina_A_L_B_);
    SELF.Vina_Front_W_D_ := KEL.Intake.SingleValue(__recs,Vina_Front_W_D_);
    SELF.Vina_Four_W_D_ := KEL.Intake.SingleValue(__recs,Vina_Four_W_D_);
    SELF.Vina_Security_System_ := KEL.Intake.SingleValue(__recs,Vina_Security_System_);
    SELF.Vina_D_R_L_ := KEL.Intake.SingleValue(__recs,Vina_D_R_L_);
    SELF.Vina_Series_Name_ := KEL.Intake.SingleValue(__recs,Vina_Series_Name_);
    SELF.Vina_Model_Year_ := KEL.Intake.SingleValue(__recs,Vina_Model_Year_);
    SELF.Vina_Series_ := KEL.Intake.SingleValue(__recs,Vina_Series_);
    SELF.Vina_Model_ := KEL.Intake.SingleValue(__recs,Vina_Model_);
    SELF.Vina_Body_Style_ := KEL.Intake.SingleValue(__recs,Vina_Body_Style_);
    SELF.Vina_Make_Description_ := KEL.Intake.SingleValue(__recs,Vina_Make_Description_);
    SELF.Vina_Model_Description_ := KEL.Intake.SingleValue(__recs,Vina_Model_Description_);
    SELF.Vina_Series_Description_ := KEL.Intake.SingleValue(__recs,Vina_Series_Description_);
    SELF.Vina_Body_Style_Description_ := KEL.Intake.SingleValue(__recs,Vina_Body_Style_Description_);
    SELF.Vina_Cylinders_ := KEL.Intake.SingleValue(__recs,Vina_Cylinders_);
    SELF.Vina_Engine_Size_ := KEL.Intake.SingleValue(__recs,Vina_Engine_Size_);
    SELF.Vina_Fuel_Code_ := KEL.Intake.SingleValue(__recs,Vina_Fuel_Code_);
    SELF.Vina_Price_ := KEL.Intake.SingleValue(__recs,Vina_Price_);
    SELF.Best_Make_Code_ := KEL.Intake.SingleValue(__recs,Best_Make_Code_);
    SELF.Best_Series_Code_ := KEL.Intake.SingleValue(__recs,Best_Series_Code_);
    SELF.Best_Model_Code_ := KEL.Intake.SingleValue(__recs,Best_Model_Code_);
    SELF.Best_Body_Code_ := KEL.Intake.SingleValue(__recs,Best_Body_Code_);
    SELF.Best_Model_Year_ := KEL.Intake.SingleValue(__recs,Best_Model_Year_);
    SELF.Best_Major_Color_ := KEL.Intake.SingleValue(__recs,Best_Major_Color_);
    SELF.Best_Minor_Color_ := KEL.Intake.SingleValue(__recs,Best_Minor_Color_);
    SELF.Branded_Title_Flag_ := KEL.Intake.SingleValue(__recs,Branded_Title_Flag_);
    SELF.Brand_Code1_ := KEL.Intake.SingleValue(__recs,Brand_Code1_);
    SELF.Brand_Date1_ := KEL.Intake.SingleValue(__recs,Brand_Date1_);
    SELF.Brand_State1_ := KEL.Intake.SingleValue(__recs,Brand_State1_);
    SELF.Brand_Code2_ := KEL.Intake.SingleValue(__recs,Brand_Code2_);
    SELF.Brand_Date2_ := KEL.Intake.SingleValue(__recs,Brand_Date2_);
    SELF.Brand_Sate2_ := KEL.Intake.SingleValue(__recs,Brand_Sate2_);
    SELF.Brand_Code3_ := KEL.Intake.SingleValue(__recs,Brand_Code3_);
    SELF.Brand_Date3_ := KEL.Intake.SingleValue(__recs,Brand_Date3_);
    SELF.Brand_Sate3_ := KEL.Intake.SingleValue(__recs,Brand_Sate3_);
    SELF.Brand_Code4_ := KEL.Intake.SingleValue(__recs,Brand_Code4_);
    SELF.Brand_Date4_ := KEL.Intake.SingleValue(__recs,Brand_Date4_);
    SELF.Brand_Sate4_ := KEL.Intake.SingleValue(__recs,Brand_Sate4_);
    SELF.Brand_Code5_ := KEL.Intake.SingleValue(__recs,Brand_Code5_);
    SELF.Brand_Date5_ := KEL.Intake.SingleValue(__recs,Brand_Date5_);
    SELF.Brand_Sate5_ := KEL.Intake.SingleValue(__recs,Brand_Sate5_);
    SELF.Saftey_Type_ := KEL.Intake.SingleValue(__recs,Saftey_Type_);
    SELF.Airbag_Driver_ := KEL.Intake.SingleValue(__recs,Airbag_Driver_);
    SELF.Airbag_Front_Driver_Side_ := KEL.Intake.SingleValue(__recs,Airbag_Front_Driver_Side_);
    SELF.Airbag_Front_Head_Curtain_ := KEL.Intake.SingleValue(__recs,Airbag_Front_Head_Curtain_);
    SELF.Airbag_Front_Passanger_ := KEL.Intake.SingleValue(__recs,Airbag_Front_Passanger_);
    SELF.Airbag_Front_Passanger_Side_ := KEL.Intake.SingleValue(__recs,Airbag_Front_Passanger_Side_);
    SELF.Airbags_ := KEL.Intake.SingleValue(__recs,Airbags_);
    SELF.Tod_Flag_ := KEL.Intake.SingleValue(__recs,Tod_Flag_);
    SELF.Model_Class_Code_ := KEL.Intake.SingleValue(__recs,Model_Class_Code_);
    SELF.Model_Class_ := KEL.Intake.SingleValue(__recs,Model_Class_);
    SELF.Min_Door_Count_ := KEL.Intake.SingleValue(__recs,Min_Door_Count_);
    SELF.Latest_Vehicle_Flag_ := KEL.Intake.SingleValue(__recs,Latest_Vehicle_Flag_);
    SELF.Latest_Vehicle_Iteration_Flag_ := KEL.Intake.SingleValue(__recs,Latest_Vehicle_Iteration_Flag_);
    SELF.Date_Vendor_First_Reported_ := KEL.Intake.SingleValue(__recs,Date_Vendor_First_Reported_);
    SELF.Date_Vendor_Last_Reported_ := KEL.Intake.SingleValue(__recs,Date_Vendor_Last_Reported_);
    SELF.Standard_Lienholder_Name_ := KEL.Intake.SingleValue(__recs,Standard_Lienholder_Name_);
    SELF.Source_First_Date_ := KEL.Intake.SingleValue(__recs,Source_First_Date_);
    SELF.Source_Last_Date_ := KEL.Intake.SingleValue(__recs,Source_Last_Date_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Vehicle__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Vehicle_Group,COUNT(ROWS(LEFT))=1),GROUP,Vehicle__Single_Rollup(LEFT)) + ROLLUP(HAVING(Vehicle_Group,COUNT(ROWS(LEFT))>1),GROUP,Vehicle__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Vehicle_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vehicle_Key_);
  EXPORT State_Of_Origin__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Of_Origin_);
  EXPORT Original_Vin__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Vin_);
  EXPORT Original_Year_Make__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Year_Make_);
  EXPORT Original_Make__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Make_);
  EXPORT Original_Make_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Make_Description_);
  EXPORT Original_Series__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Series_);
  EXPORT Original_Series_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Series_Description_);
  EXPORT Original_Model__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Model_);
  EXPORT Original_Model_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Model_Description_);
  EXPORT Original_Body__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Body_);
  EXPORT Original_Body_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Body_Description_);
  EXPORT Original_Net_Weight__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Net_Weight_);
  EXPORT Original_Gross_Weight__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Gross_Weight_);
  EXPORT Original_Number_Axles__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Number_Axles_);
  EXPORT Original_Vehicle_Use__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Vehicle_Use_);
  EXPORT Original_Vehicle_Use_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Vehicle_Use_Description_);
  EXPORT Original_Vehicle_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Vehicle_Type_);
  EXPORT Original_Vehicle_Type_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Vehicle_Type_Description_);
  EXPORT Original_Major_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Major_Color_);
  EXPORT Original_Major_Color_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Major_Color_Description_);
  EXPORT Original_Minor_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Minor_Color_);
  EXPORT Original_Minor_Color_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Minor_Color_Description_);
  EXPORT Vina_Vin__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Vin_);
  EXPORT Vina_Vin_Pattern__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Vin_Pattern_);
  EXPORT Vina_Bypass_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Bypass_Code_);
  EXPORT Vina_Vehicle_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Vehicle_Type_);
  EXPORT Vina_N_C_I_C_Make__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_N_C_I_C_Make_);
  EXPORT Vina_Model_Year_Y_Y__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Model_Year_Y_Y_);
  EXPORT Vina_Restraint__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Restraint_);
  EXPORT Vina_Make_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Make_Name_);
  EXPORT Vina_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Year_);
  EXPORT Vina_Vp_Series__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Vp_Series_);
  EXPORT Vina_Vp_Model__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Vp_Model_);
  EXPORT Vina_Air_Conditioning__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Air_Conditioning_);
  EXPORT Vina_Power_Steering__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Power_Steering_);
  EXPORT Vina_Power_Brakes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Power_Brakes_);
  EXPORT Vina_Power_Windows__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Power_Windows_);
  EXPORT Vina_Tilt_Wheel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Tilt_Wheel_);
  EXPORT Vina_Roof__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Roof_);
  EXPORT Vina_Optional_Roof1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Roof1_);
  EXPORT Vina_Optional_Roof2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Roof2_);
  EXPORT Vina_Radio__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Radio_);
  EXPORT Vina_Optional_Radio1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Radio1_);
  EXPORT Vina_Optional_Radio2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Radio2_);
  EXPORT Vina_Transmission__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Transmission_);
  EXPORT Vina_Optional_Transmission1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Transmission1_);
  EXPORT Vina_Optional_Transmission2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Optional_Transmission2_);
  EXPORT Vina_A_L_B__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_A_L_B_);
  EXPORT Vina_Front_W_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Front_W_D_);
  EXPORT Vina_Four_W_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Four_W_D_);
  EXPORT Vina_Security_System__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Security_System_);
  EXPORT Vina_D_R_L__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_D_R_L_);
  EXPORT Vina_Series_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Series_Name_);
  EXPORT Vina_Model_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Model_Year_);
  EXPORT Vina_Series__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Series_);
  EXPORT Vina_Model__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Model_);
  EXPORT Vina_Body_Style__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Body_Style_);
  EXPORT Vina_Make_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Make_Description_);
  EXPORT Vina_Model_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Model_Description_);
  EXPORT Vina_Series_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Series_Description_);
  EXPORT Vina_Body_Style_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Body_Style_Description_);
  EXPORT Vina_Cylinders__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Cylinders_);
  EXPORT Vina_Engine_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Engine_Size_);
  EXPORT Vina_Fuel_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Fuel_Code_);
  EXPORT Vina_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vina_Price_);
  EXPORT Best_Make_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Make_Code_);
  EXPORT Best_Series_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Series_Code_);
  EXPORT Best_Model_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Model_Code_);
  EXPORT Best_Body_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Body_Code_);
  EXPORT Best_Model_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Model_Year_);
  EXPORT Best_Major_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Major_Color_);
  EXPORT Best_Minor_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Best_Minor_Color_);
  EXPORT Branded_Title_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Branded_Title_Flag_);
  EXPORT Brand_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Code1_);
  EXPORT Brand_Date1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Date1_);
  EXPORT Brand_State1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_State1_);
  EXPORT Brand_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Code2_);
  EXPORT Brand_Date2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Date2_);
  EXPORT Brand_Sate2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Sate2_);
  EXPORT Brand_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Code3_);
  EXPORT Brand_Date3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Date3_);
  EXPORT Brand_Sate3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Sate3_);
  EXPORT Brand_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Code4_);
  EXPORT Brand_Date4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Date4_);
  EXPORT Brand_Sate4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Sate4_);
  EXPORT Brand_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Code5_);
  EXPORT Brand_Date5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Date5_);
  EXPORT Brand_Sate5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Brand_Sate5_);
  EXPORT Saftey_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Saftey_Type_);
  EXPORT Airbag_Driver__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbag_Driver_);
  EXPORT Airbag_Front_Driver_Side__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbag_Front_Driver_Side_);
  EXPORT Airbag_Front_Head_Curtain__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbag_Front_Head_Curtain_);
  EXPORT Airbag_Front_Passanger__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbag_Front_Passanger_);
  EXPORT Airbag_Front_Passanger_Side__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbag_Front_Passanger_Side_);
  EXPORT Airbags__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Airbags_);
  EXPORT Tod_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tod_Flag_);
  EXPORT Model_Class_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Model_Class_Code_);
  EXPORT Model_Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Model_Class_);
  EXPORT Min_Door_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Min_Door_Count_);
  EXPORT Latest_Vehicle_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Latest_Vehicle_Flag_);
  EXPORT Latest_Vehicle_Iteration_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Latest_Vehicle_Iteration_Flag_);
  EXPORT Date_Vendor_First_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Vendor_First_Reported_);
  EXPORT Date_Vendor_Last_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Vendor_Last_Reported_);
  EXPORT Standard_Lienholder_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standard_Lienholder_Name_);
  EXPORT Source_First_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_First_Date_);
  EXPORT Source_Last_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_Last_Date_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Vehicle_Key__SingleValue_Invalid),COUNT(State_Of_Origin__SingleValue_Invalid),COUNT(Original_Vin__SingleValue_Invalid),COUNT(Original_Year_Make__SingleValue_Invalid),COUNT(Original_Make__SingleValue_Invalid),COUNT(Original_Make_Description__SingleValue_Invalid),COUNT(Original_Series__SingleValue_Invalid),COUNT(Original_Series_Description__SingleValue_Invalid),COUNT(Original_Model__SingleValue_Invalid),COUNT(Original_Model_Description__SingleValue_Invalid),COUNT(Original_Body__SingleValue_Invalid),COUNT(Original_Body_Description__SingleValue_Invalid),COUNT(Original_Net_Weight__SingleValue_Invalid),COUNT(Original_Gross_Weight__SingleValue_Invalid),COUNT(Original_Number_Axles__SingleValue_Invalid),COUNT(Original_Vehicle_Use__SingleValue_Invalid),COUNT(Original_Vehicle_Use_Description__SingleValue_Invalid),COUNT(Original_Vehicle_Type__SingleValue_Invalid),COUNT(Original_Vehicle_Type_Description__SingleValue_Invalid),COUNT(Original_Major_Color__SingleValue_Invalid),COUNT(Original_Major_Color_Description__SingleValue_Invalid),COUNT(Original_Minor_Color__SingleValue_Invalid),COUNT(Original_Minor_Color_Description__SingleValue_Invalid),COUNT(Vina_Vin__SingleValue_Invalid),COUNT(Vina_Vin_Pattern__SingleValue_Invalid),COUNT(Vina_Bypass_Code__SingleValue_Invalid),COUNT(Vina_Vehicle_Type__SingleValue_Invalid),COUNT(Vina_N_C_I_C_Make__SingleValue_Invalid),COUNT(Vina_Model_Year_Y_Y__SingleValue_Invalid),COUNT(Vina_Restraint__SingleValue_Invalid),COUNT(Vina_Make_Name__SingleValue_Invalid),COUNT(Vina_Year__SingleValue_Invalid),COUNT(Vina_Vp_Series__SingleValue_Invalid),COUNT(Vina_Vp_Model__SingleValue_Invalid),COUNT(Vina_Air_Conditioning__SingleValue_Invalid),COUNT(Vina_Power_Steering__SingleValue_Invalid),COUNT(Vina_Power_Brakes__SingleValue_Invalid),COUNT(Vina_Power_Windows__SingleValue_Invalid),COUNT(Vina_Tilt_Wheel__SingleValue_Invalid),COUNT(Vina_Roof__SingleValue_Invalid),COUNT(Vina_Optional_Roof1__SingleValue_Invalid),COUNT(Vina_Optional_Roof2__SingleValue_Invalid),COUNT(Vina_Radio__SingleValue_Invalid),COUNT(Vina_Optional_Radio1__SingleValue_Invalid),COUNT(Vina_Optional_Radio2__SingleValue_Invalid),COUNT(Vina_Transmission__SingleValue_Invalid),COUNT(Vina_Optional_Transmission1__SingleValue_Invalid),COUNT(Vina_Optional_Transmission2__SingleValue_Invalid),COUNT(Vina_A_L_B__SingleValue_Invalid),COUNT(Vina_Front_W_D__SingleValue_Invalid),COUNT(Vina_Four_W_D__SingleValue_Invalid),COUNT(Vina_Security_System__SingleValue_Invalid),COUNT(Vina_D_R_L__SingleValue_Invalid),COUNT(Vina_Series_Name__SingleValue_Invalid),COUNT(Vina_Model_Year__SingleValue_Invalid),COUNT(Vina_Series__SingleValue_Invalid),COUNT(Vina_Model__SingleValue_Invalid),COUNT(Vina_Body_Style__SingleValue_Invalid),COUNT(Vina_Make_Description__SingleValue_Invalid),COUNT(Vina_Model_Description__SingleValue_Invalid),COUNT(Vina_Series_Description__SingleValue_Invalid),COUNT(Vina_Body_Style_Description__SingleValue_Invalid),COUNT(Vina_Cylinders__SingleValue_Invalid),COUNT(Vina_Engine_Size__SingleValue_Invalid),COUNT(Vina_Fuel_Code__SingleValue_Invalid),COUNT(Vina_Price__SingleValue_Invalid),COUNT(Best_Make_Code__SingleValue_Invalid),COUNT(Best_Series_Code__SingleValue_Invalid),COUNT(Best_Model_Code__SingleValue_Invalid),COUNT(Best_Body_Code__SingleValue_Invalid),COUNT(Best_Model_Year__SingleValue_Invalid),COUNT(Best_Major_Color__SingleValue_Invalid),COUNT(Best_Minor_Color__SingleValue_Invalid),COUNT(Branded_Title_Flag__SingleValue_Invalid),COUNT(Brand_Code1__SingleValue_Invalid),COUNT(Brand_Date1__SingleValue_Invalid),COUNT(Brand_State1__SingleValue_Invalid),COUNT(Brand_Code2__SingleValue_Invalid),COUNT(Brand_Date2__SingleValue_Invalid),COUNT(Brand_Sate2__SingleValue_Invalid),COUNT(Brand_Code3__SingleValue_Invalid),COUNT(Brand_Date3__SingleValue_Invalid),COUNT(Brand_Sate3__SingleValue_Invalid),COUNT(Brand_Code4__SingleValue_Invalid),COUNT(Brand_Date4__SingleValue_Invalid),COUNT(Brand_Sate4__SingleValue_Invalid),COUNT(Brand_Code5__SingleValue_Invalid),COUNT(Brand_Date5__SingleValue_Invalid),COUNT(Brand_Sate5__SingleValue_Invalid),COUNT(Saftey_Type__SingleValue_Invalid),COUNT(Airbag_Driver__SingleValue_Invalid),COUNT(Airbag_Front_Driver_Side__SingleValue_Invalid),COUNT(Airbag_Front_Head_Curtain__SingleValue_Invalid),COUNT(Airbag_Front_Passanger__SingleValue_Invalid),COUNT(Airbag_Front_Passanger_Side__SingleValue_Invalid),COUNT(Airbags__SingleValue_Invalid),COUNT(Tod_Flag__SingleValue_Invalid),COUNT(Model_Class_Code__SingleValue_Invalid),COUNT(Model_Class__SingleValue_Invalid),COUNT(Min_Door_Count__SingleValue_Invalid),COUNT(Latest_Vehicle_Flag__SingleValue_Invalid),COUNT(Latest_Vehicle_Iteration_Flag__SingleValue_Invalid),COUNT(Date_Vendor_First_Reported__SingleValue_Invalid),COUNT(Date_Vendor_Last_Reported__SingleValue_Invalid),COUNT(Standard_Lienholder_Name__SingleValue_Invalid),COUNT(Source_First_Date__SingleValue_Invalid),COUNT(Source_Last_Date__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Vehicle_Key__SingleValue_Invalid,KEL.typ.int State_Of_Origin__SingleValue_Invalid,KEL.typ.int Original_Vin__SingleValue_Invalid,KEL.typ.int Original_Year_Make__SingleValue_Invalid,KEL.typ.int Original_Make__SingleValue_Invalid,KEL.typ.int Original_Make_Description__SingleValue_Invalid,KEL.typ.int Original_Series__SingleValue_Invalid,KEL.typ.int Original_Series_Description__SingleValue_Invalid,KEL.typ.int Original_Model__SingleValue_Invalid,KEL.typ.int Original_Model_Description__SingleValue_Invalid,KEL.typ.int Original_Body__SingleValue_Invalid,KEL.typ.int Original_Body_Description__SingleValue_Invalid,KEL.typ.int Original_Net_Weight__SingleValue_Invalid,KEL.typ.int Original_Gross_Weight__SingleValue_Invalid,KEL.typ.int Original_Number_Axles__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Use__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Use_Description__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Type__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Type_Description__SingleValue_Invalid,KEL.typ.int Original_Major_Color__SingleValue_Invalid,KEL.typ.int Original_Major_Color_Description__SingleValue_Invalid,KEL.typ.int Original_Minor_Color__SingleValue_Invalid,KEL.typ.int Original_Minor_Color_Description__SingleValue_Invalid,KEL.typ.int Vina_Vin__SingleValue_Invalid,KEL.typ.int Vina_Vin_Pattern__SingleValue_Invalid,KEL.typ.int Vina_Bypass_Code__SingleValue_Invalid,KEL.typ.int Vina_Vehicle_Type__SingleValue_Invalid,KEL.typ.int Vina_N_C_I_C_Make__SingleValue_Invalid,KEL.typ.int Vina_Model_Year_Y_Y__SingleValue_Invalid,KEL.typ.int Vina_Restraint__SingleValue_Invalid,KEL.typ.int Vina_Make_Name__SingleValue_Invalid,KEL.typ.int Vina_Year__SingleValue_Invalid,KEL.typ.int Vina_Vp_Series__SingleValue_Invalid,KEL.typ.int Vina_Vp_Model__SingleValue_Invalid,KEL.typ.int Vina_Air_Conditioning__SingleValue_Invalid,KEL.typ.int Vina_Power_Steering__SingleValue_Invalid,KEL.typ.int Vina_Power_Brakes__SingleValue_Invalid,KEL.typ.int Vina_Power_Windows__SingleValue_Invalid,KEL.typ.int Vina_Tilt_Wheel__SingleValue_Invalid,KEL.typ.int Vina_Roof__SingleValue_Invalid,KEL.typ.int Vina_Optional_Roof1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Roof2__SingleValue_Invalid,KEL.typ.int Vina_Radio__SingleValue_Invalid,KEL.typ.int Vina_Optional_Radio1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Radio2__SingleValue_Invalid,KEL.typ.int Vina_Transmission__SingleValue_Invalid,KEL.typ.int Vina_Optional_Transmission1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Transmission2__SingleValue_Invalid,KEL.typ.int Vina_A_L_B__SingleValue_Invalid,KEL.typ.int Vina_Front_W_D__SingleValue_Invalid,KEL.typ.int Vina_Four_W_D__SingleValue_Invalid,KEL.typ.int Vina_Security_System__SingleValue_Invalid,KEL.typ.int Vina_D_R_L__SingleValue_Invalid,KEL.typ.int Vina_Series_Name__SingleValue_Invalid,KEL.typ.int Vina_Model_Year__SingleValue_Invalid,KEL.typ.int Vina_Series__SingleValue_Invalid,KEL.typ.int Vina_Model__SingleValue_Invalid,KEL.typ.int Vina_Body_Style__SingleValue_Invalid,KEL.typ.int Vina_Make_Description__SingleValue_Invalid,KEL.typ.int Vina_Model_Description__SingleValue_Invalid,KEL.typ.int Vina_Series_Description__SingleValue_Invalid,KEL.typ.int Vina_Body_Style_Description__SingleValue_Invalid,KEL.typ.int Vina_Cylinders__SingleValue_Invalid,KEL.typ.int Vina_Engine_Size__SingleValue_Invalid,KEL.typ.int Vina_Fuel_Code__SingleValue_Invalid,KEL.typ.int Vina_Price__SingleValue_Invalid,KEL.typ.int Best_Make_Code__SingleValue_Invalid,KEL.typ.int Best_Series_Code__SingleValue_Invalid,KEL.typ.int Best_Model_Code__SingleValue_Invalid,KEL.typ.int Best_Body_Code__SingleValue_Invalid,KEL.typ.int Best_Model_Year__SingleValue_Invalid,KEL.typ.int Best_Major_Color__SingleValue_Invalid,KEL.typ.int Best_Minor_Color__SingleValue_Invalid,KEL.typ.int Branded_Title_Flag__SingleValue_Invalid,KEL.typ.int Brand_Code1__SingleValue_Invalid,KEL.typ.int Brand_Date1__SingleValue_Invalid,KEL.typ.int Brand_State1__SingleValue_Invalid,KEL.typ.int Brand_Code2__SingleValue_Invalid,KEL.typ.int Brand_Date2__SingleValue_Invalid,KEL.typ.int Brand_Sate2__SingleValue_Invalid,KEL.typ.int Brand_Code3__SingleValue_Invalid,KEL.typ.int Brand_Date3__SingleValue_Invalid,KEL.typ.int Brand_Sate3__SingleValue_Invalid,KEL.typ.int Brand_Code4__SingleValue_Invalid,KEL.typ.int Brand_Date4__SingleValue_Invalid,KEL.typ.int Brand_Sate4__SingleValue_Invalid,KEL.typ.int Brand_Code5__SingleValue_Invalid,KEL.typ.int Brand_Date5__SingleValue_Invalid,KEL.typ.int Brand_Sate5__SingleValue_Invalid,KEL.typ.int Saftey_Type__SingleValue_Invalid,KEL.typ.int Airbag_Driver__SingleValue_Invalid,KEL.typ.int Airbag_Front_Driver_Side__SingleValue_Invalid,KEL.typ.int Airbag_Front_Head_Curtain__SingleValue_Invalid,KEL.typ.int Airbag_Front_Passanger__SingleValue_Invalid,KEL.typ.int Airbag_Front_Passanger_Side__SingleValue_Invalid,KEL.typ.int Airbags__SingleValue_Invalid,KEL.typ.int Tod_Flag__SingleValue_Invalid,KEL.typ.int Model_Class_Code__SingleValue_Invalid,KEL.typ.int Model_Class__SingleValue_Invalid,KEL.typ.int Min_Door_Count__SingleValue_Invalid,KEL.typ.int Latest_Vehicle_Flag__SingleValue_Invalid,KEL.typ.int Latest_Vehicle_Iteration_Flag__SingleValue_Invalid,KEL.typ.int Date_Vendor_First_Reported__SingleValue_Invalid,KEL.typ.int Date_Vendor_Last_Reported__SingleValue_Invalid,KEL.typ.int Standard_Lienholder_Name__SingleValue_Invalid,KEL.typ.int Source_First_Date__SingleValue_Invalid,KEL.typ.int Source_Last_Date__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleKey',COUNT(__d0(__NL(Vehicle_Key_))),COUNT(__d0(__NN(Vehicle_Key_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalVin',COUNT(__d0(__NL(Original_Vin_))),COUNT(__d0(__NN(Original_Vin_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalYearMake',COUNT(__d0(__NL(Original_Year_Make_))),COUNT(__d0(__NN(Original_Year_Make_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMake',COUNT(__d0(__NL(Original_Make_))),COUNT(__d0(__NN(Original_Make_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMakeDescription',COUNT(__d0(__NL(Original_Make_Description_))),COUNT(__d0(__NN(Original_Make_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSeries',COUNT(__d0(__NL(Original_Series_))),COUNT(__d0(__NN(Original_Series_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSeriesDescription',COUNT(__d0(__NL(Original_Series_Description_))),COUNT(__d0(__NN(Original_Series_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalModel',COUNT(__d0(__NL(Original_Model_))),COUNT(__d0(__NN(Original_Model_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalModelDescription',COUNT(__d0(__NL(Original_Model_Description_))),COUNT(__d0(__NN(Original_Model_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalBody',COUNT(__d0(__NL(Original_Body_))),COUNT(__d0(__NN(Original_Body_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalBodyDescription',COUNT(__d0(__NL(Original_Body_Description_))),COUNT(__d0(__NN(Original_Body_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalNetWeight',COUNT(__d0(__NL(Original_Net_Weight_))),COUNT(__d0(__NN(Original_Net_Weight_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalGrossWeight',COUNT(__d0(__NL(Original_Gross_Weight_))),COUNT(__d0(__NN(Original_Gross_Weight_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalNumberAxles',COUNT(__d0(__NL(Original_Number_Axles_))),COUNT(__d0(__NN(Original_Number_Axles_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalVehicleUse',COUNT(__d0(__NL(Original_Vehicle_Use_))),COUNT(__d0(__NN(Original_Vehicle_Use_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalVehicleUseDescription',COUNT(__d0(__NL(Original_Vehicle_Use_Description_))),COUNT(__d0(__NN(Original_Vehicle_Use_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalVehicleType',COUNT(__d0(__NL(Original_Vehicle_Type_))),COUNT(__d0(__NN(Original_Vehicle_Type_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalVehicleTypeDescription',COUNT(__d0(__NL(Original_Vehicle_Type_Description_))),COUNT(__d0(__NN(Original_Vehicle_Type_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMajorColor',COUNT(__d0(__NL(Original_Major_Color_))),COUNT(__d0(__NN(Original_Major_Color_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMajorColorDescription',COUNT(__d0(__NL(Original_Major_Color_Description_))),COUNT(__d0(__NN(Original_Major_Color_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMinorColor',COUNT(__d0(__NL(Original_Minor_Color_))),COUNT(__d0(__NN(Original_Minor_Color_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalMinorColorDescription',COUNT(__d0(__NL(Original_Minor_Color_Description_))),COUNT(__d0(__NN(Original_Minor_Color_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaVin',COUNT(__d0(__NL(Vina_Vin_))),COUNT(__d0(__NN(Vina_Vin_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaVinPattern',COUNT(__d0(__NL(Vina_Vin_Pattern_))),COUNT(__d0(__NN(Vina_Vin_Pattern_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaBypassCode',COUNT(__d0(__NL(Vina_Bypass_Code_))),COUNT(__d0(__NN(Vina_Bypass_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaVehicleType',COUNT(__d0(__NL(Vina_Vehicle_Type_))),COUNT(__d0(__NN(Vina_Vehicle_Type_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaNCICMake',COUNT(__d0(__NL(Vina_N_C_I_C_Make_))),COUNT(__d0(__NN(Vina_N_C_I_C_Make_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaModelYearYY',COUNT(__d0(__NL(Vina_Model_Year_Y_Y_))),COUNT(__d0(__NN(Vina_Model_Year_Y_Y_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaRestraint',COUNT(__d0(__NL(Vina_Restraint_))),COUNT(__d0(__NN(Vina_Restraint_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaMakeName',COUNT(__d0(__NL(Vina_Make_Name_))),COUNT(__d0(__NN(Vina_Make_Name_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaYear',COUNT(__d0(__NL(Vina_Year_))),COUNT(__d0(__NN(Vina_Year_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaVpSeries',COUNT(__d0(__NL(Vina_Vp_Series_))),COUNT(__d0(__NN(Vina_Vp_Series_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaVpModel',COUNT(__d0(__NL(Vina_Vp_Model_))),COUNT(__d0(__NN(Vina_Vp_Model_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaAirConditioning',COUNT(__d0(__NL(Vina_Air_Conditioning_))),COUNT(__d0(__NN(Vina_Air_Conditioning_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaPowerSteering',COUNT(__d0(__NL(Vina_Power_Steering_))),COUNT(__d0(__NN(Vina_Power_Steering_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaPowerBrakes',COUNT(__d0(__NL(Vina_Power_Brakes_))),COUNT(__d0(__NN(Vina_Power_Brakes_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaPowerWindows',COUNT(__d0(__NL(Vina_Power_Windows_))),COUNT(__d0(__NN(Vina_Power_Windows_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaTiltWheel',COUNT(__d0(__NL(Vina_Tilt_Wheel_))),COUNT(__d0(__NN(Vina_Tilt_Wheel_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaRoof',COUNT(__d0(__NL(Vina_Roof_))),COUNT(__d0(__NN(Vina_Roof_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalRoof1',COUNT(__d0(__NL(Vina_Optional_Roof1_))),COUNT(__d0(__NN(Vina_Optional_Roof1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalRoof2',COUNT(__d0(__NL(Vina_Optional_Roof2_))),COUNT(__d0(__NN(Vina_Optional_Roof2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaRadio',COUNT(__d0(__NL(Vina_Radio_))),COUNT(__d0(__NN(Vina_Radio_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalRadio1',COUNT(__d0(__NL(Vina_Optional_Radio1_))),COUNT(__d0(__NN(Vina_Optional_Radio1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalRadio2',COUNT(__d0(__NL(Vina_Optional_Radio2_))),COUNT(__d0(__NN(Vina_Optional_Radio2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaTransmission',COUNT(__d0(__NL(Vina_Transmission_))),COUNT(__d0(__NN(Vina_Transmission_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalTransmission1',COUNT(__d0(__NL(Vina_Optional_Transmission1_))),COUNT(__d0(__NN(Vina_Optional_Transmission1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaOptionalTransmission2',COUNT(__d0(__NL(Vina_Optional_Transmission2_))),COUNT(__d0(__NN(Vina_Optional_Transmission2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaALB',COUNT(__d0(__NL(Vina_A_L_B_))),COUNT(__d0(__NN(Vina_A_L_B_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaFrontWD',COUNT(__d0(__NL(Vina_Front_W_D_))),COUNT(__d0(__NN(Vina_Front_W_D_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaFourWD',COUNT(__d0(__NL(Vina_Four_W_D_))),COUNT(__d0(__NN(Vina_Four_W_D_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaSecuritySystem',COUNT(__d0(__NL(Vina_Security_System_))),COUNT(__d0(__NN(Vina_Security_System_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaDRL',COUNT(__d0(__NL(Vina_D_R_L_))),COUNT(__d0(__NN(Vina_D_R_L_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaSeriesName',COUNT(__d0(__NL(Vina_Series_Name_))),COUNT(__d0(__NN(Vina_Series_Name_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaModelYear',COUNT(__d0(__NL(Vina_Model_Year_))),COUNT(__d0(__NN(Vina_Model_Year_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaSeries',COUNT(__d0(__NL(Vina_Series_))),COUNT(__d0(__NN(Vina_Series_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaModel',COUNT(__d0(__NL(Vina_Model_))),COUNT(__d0(__NN(Vina_Model_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaBodyStyle',COUNT(__d0(__NL(Vina_Body_Style_))),COUNT(__d0(__NN(Vina_Body_Style_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaMakeDescription',COUNT(__d0(__NL(Vina_Make_Description_))),COUNT(__d0(__NN(Vina_Make_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaModelDescription',COUNT(__d0(__NL(Vina_Model_Description_))),COUNT(__d0(__NN(Vina_Model_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaSeriesDescription',COUNT(__d0(__NL(Vina_Series_Description_))),COUNT(__d0(__NN(Vina_Series_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaBodyStyleDescription',COUNT(__d0(__NL(Vina_Body_Style_Description_))),COUNT(__d0(__NN(Vina_Body_Style_Description_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaCylinders',COUNT(__d0(__NL(Vina_Cylinders_))),COUNT(__d0(__NN(Vina_Cylinders_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaEngineSize',COUNT(__d0(__NL(Vina_Engine_Size_))),COUNT(__d0(__NN(Vina_Engine_Size_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaFuelCode',COUNT(__d0(__NL(Vina_Fuel_Code_))),COUNT(__d0(__NN(Vina_Fuel_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VinaPrice',COUNT(__d0(__NL(Vina_Price_))),COUNT(__d0(__NN(Vina_Price_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestMakeCode',COUNT(__d0(__NL(Best_Make_Code_))),COUNT(__d0(__NN(Best_Make_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSeriesCode',COUNT(__d0(__NL(Best_Series_Code_))),COUNT(__d0(__NN(Best_Series_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestModelCode',COUNT(__d0(__NL(Best_Model_Code_))),COUNT(__d0(__NN(Best_Model_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestBodyCode',COUNT(__d0(__NL(Best_Body_Code_))),COUNT(__d0(__NN(Best_Body_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestModelYear',COUNT(__d0(__NL(Best_Model_Year_))),COUNT(__d0(__NN(Best_Model_Year_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestMajorColor',COUNT(__d0(__NL(Best_Major_Color_))),COUNT(__d0(__NN(Best_Major_Color_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestMinorColor',COUNT(__d0(__NL(Best_Minor_Color_))),COUNT(__d0(__NN(Best_Minor_Color_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandedTitleFlag',COUNT(__d0(__NL(Branded_Title_Flag_))),COUNT(__d0(__NN(Branded_Title_Flag_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandCode1',COUNT(__d0(__NL(Brand_Code1_))),COUNT(__d0(__NN(Brand_Code1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandDate1',COUNT(__d0(__NL(Brand_Date1_))),COUNT(__d0(__NN(Brand_Date1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandState1',COUNT(__d0(__NL(Brand_State1_))),COUNT(__d0(__NN(Brand_State1_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandCode2',COUNT(__d0(__NL(Brand_Code2_))),COUNT(__d0(__NN(Brand_Code2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandDate2',COUNT(__d0(__NL(Brand_Date2_))),COUNT(__d0(__NN(Brand_Date2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandSate2',COUNT(__d0(__NL(Brand_Sate2_))),COUNT(__d0(__NN(Brand_Sate2_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandCode3',COUNT(__d0(__NL(Brand_Code3_))),COUNT(__d0(__NN(Brand_Code3_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandDate3',COUNT(__d0(__NL(Brand_Date3_))),COUNT(__d0(__NN(Brand_Date3_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandSate3',COUNT(__d0(__NL(Brand_Sate3_))),COUNT(__d0(__NN(Brand_Sate3_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandCode4',COUNT(__d0(__NL(Brand_Code4_))),COUNT(__d0(__NN(Brand_Code4_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandDate4',COUNT(__d0(__NL(Brand_Date4_))),COUNT(__d0(__NN(Brand_Date4_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandSate4',COUNT(__d0(__NL(Brand_Sate4_))),COUNT(__d0(__NN(Brand_Sate4_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandCode5',COUNT(__d0(__NL(Brand_Code5_))),COUNT(__d0(__NN(Brand_Code5_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandDate5',COUNT(__d0(__NL(Brand_Date5_))),COUNT(__d0(__NN(Brand_Date5_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BrandSate5',COUNT(__d0(__NL(Brand_Sate5_))),COUNT(__d0(__NN(Brand_Sate5_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TodFlag',COUNT(__d0(__NL(Tod_Flag_))),COUNT(__d0(__NN(Tod_Flag_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ModelClassCode',COUNT(__d0(__NL(Model_Class_Code_))),COUNT(__d0(__NN(Model_Class_Code_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ModelClass',COUNT(__d0(__NL(Model_Class_))),COUNT(__d0(__NN(Model_Class_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinDoorCount',COUNT(__d0(__NL(Min_Door_Count_))),COUNT(__d0(__NN(Min_Door_Count_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SafteyType',COUNT(__d0(__NL(Saftey_Type_))),COUNT(__d0(__NN(Saftey_Type_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagDriver',COUNT(__d0(__NL(Airbag_Driver_))),COUNT(__d0(__NN(Airbag_Driver_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagFrontDriverSide',COUNT(__d0(__NL(Airbag_Front_Driver_Side_))),COUNT(__d0(__NN(Airbag_Front_Driver_Side_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagFrontHeadCurtain',COUNT(__d0(__NL(Airbag_Front_Head_Curtain_))),COUNT(__d0(__NN(Airbag_Front_Head_Curtain_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagFrontPassanger',COUNT(__d0(__NL(Airbag_Front_Passanger_))),COUNT(__d0(__NN(Airbag_Front_Passanger_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagFrontPassangerSide',COUNT(__d0(__NL(Airbag_Front_Passanger_Side_))),COUNT(__d0(__NN(Airbag_Front_Passanger_Side_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Airbags',COUNT(__d0(__NL(Airbags_))),COUNT(__d0(__NN(Airbags_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateOfOrigin',COUNT(__d0(__NL(State_Of_Origin_))),COUNT(__d0(__NN(State_Of_Origin_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LatestVehicleFlag',COUNT(__d0(__NL(Latest_Vehicle_Flag_))),COUNT(__d0(__NN(Latest_Vehicle_Flag_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LatestVehicleIterationFlag',COUNT(__d0(__NL(Latest_Vehicle_Iteration_Flag_))),COUNT(__d0(__NN(Latest_Vehicle_Iteration_Flag_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFirstDate',COUNT(__d0(__NL(Source_First_Date_))),COUNT(__d0(__NN(Source_First_Date_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceLastDate',COUNT(__d0(__NL(Source_Last_Date_))),COUNT(__d0(__NN(Source_Last_Date_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardLienholderName',COUNT(__d0(__NL(Standard_Lienholder_Name_))),COUNT(__d0(__NN(Standard_Lienholder_Name_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Vehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
