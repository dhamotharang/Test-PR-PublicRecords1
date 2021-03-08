//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT ProfileBooster;
IMPORT CFG_Compile FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Vehicle(CFG_Compile __cfg = CFG_Compile) := MODULE
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
    KEL.typ.nstr Safety_Type_;
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
    KEL.typ.int __RecordCount;
  END;
  EXPORT PreEntityPayloadLayout := RECORD
    InLayout AND NOT [UID];
  END;
  EXPORT PreEntityLayout := RECORD
    InLayout.UID UID;
    DATASET(PreEntityPayloadLayout) __Payload;
    UNSIGNED4 __Part := 0;
  END;
  SHARED ExpandedPreEntityLayout := RECORD
    InLayout.UID UID;
    DATASET(InLayout) __Payload;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __PreEntityFilter(DATASET(ExpandedPreEntityLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),vehiclekey(DEFAULT:Vehicle_Key_:\'\'),originalvin(DEFAULT:Original_Vin_:\'\'),originalyearmake(DEFAULT:Original_Year_Make_:0),originalmake(DEFAULT:Original_Make_:\'\'),originalmakedescription(DEFAULT:Original_Make_Description_:\'\'),originalseries(DEFAULT:Original_Series_:\'\'),originalseriesdescription(DEFAULT:Original_Series_Description_:\'\'),originalmodel(DEFAULT:Original_Model_:\'\'),originalmodeldescription(DEFAULT:Original_Model_Description_:\'\'),originalbody(DEFAULT:Original_Body_:\'\'),originalbodydescription(DEFAULT:Original_Body_Description_:\'\'),originalnetweight(DEFAULT:Original_Net_Weight_:0),originalgrossweight(DEFAULT:Original_Gross_Weight_:0),originalnumberaxles(DEFAULT:Original_Number_Axles_:0),originalvehicleuse(DEFAULT:Original_Vehicle_Use_:\'\'),originalvehicleusedescription(DEFAULT:Original_Vehicle_Use_Description_:\'\'),originalvehicletype(DEFAULT:Original_Vehicle_Type_:\'\'),originalvehicletypedescription(DEFAULT:Original_Vehicle_Type_Description_:\'\'),originalmajorcolor(DEFAULT:Original_Major_Color_:\'\'),originalmajorcolordescription(DEFAULT:Original_Major_Color_Description_:\'\'),originalminorcolor(DEFAULT:Original_Minor_Color_:\'\'),originalminorcolordescription(DEFAULT:Original_Minor_Color_Description_:\'\'),vinavin(DEFAULT:Vina_Vin_:\'\'),vinavinpattern(DEFAULT:Vina_Vin_Pattern_:\'\'),vinabypasscode(DEFAULT:Vina_Bypass_Code_:\'\'),vinavehicletype(DEFAULT:Vina_Vehicle_Type_:\'\'),vinancicmake(DEFAULT:Vina_N_C_I_C_Make_:\'\'),vinamodelyearyy(DEFAULT:Vina_Model_Year_Y_Y_:0),vinarestraint(DEFAULT:Vina_Restraint_:\'\'),vinamakename(DEFAULT:Vina_Make_Name_:\'\'),vinayear(DEFAULT:Vina_Year_:0),vinavpseries(DEFAULT:Vina_Vp_Series_:\'\'),vinavpmodel(DEFAULT:Vina_Vp_Model_:\'\'),vinaairconditioning(DEFAULT:Vina_Air_Conditioning_:\'\'),vinapowersteering(DEFAULT:Vina_Power_Steering_:\'\'),vinapowerbrakes(DEFAULT:Vina_Power_Brakes_:\'\'),vinapowerwindows(DEFAULT:Vina_Power_Windows_:\'\'),vinatiltwheel(DEFAULT:Vina_Tilt_Wheel_:\'\'),vinaroof(DEFAULT:Vina_Roof_:0),vinaoptionalroof1(DEFAULT:Vina_Optional_Roof1_:0),vinaoptionalroof2(DEFAULT:Vina_Optional_Roof2_:0),vinaradio(DEFAULT:Vina_Radio_:\'\'),vinaoptionalradio1(DEFAULT:Vina_Optional_Radio1_:\'\'),vinaoptionalradio2(DEFAULT:Vina_Optional_Radio2_:\'\'),vinatransmission(DEFAULT:Vina_Transmission_:\'\'),vinaoptionaltransmission1(DEFAULT:Vina_Optional_Transmission1_:\'\'),vinaoptionaltransmission2(DEFAULT:Vina_Optional_Transmission2_:\'\'),vinaalb(DEFAULT:Vina_A_L_B_:0),vinafrontwd(DEFAULT:Vina_Front_W_D_:\'\'),vinafourwd(DEFAULT:Vina_Four_W_D_:\'\'),vinasecuritysystem(DEFAULT:Vina_Security_System_:\'\'),vinadrl(DEFAULT:Vina_D_R_L_:\'\'),vinaseriesname(DEFAULT:Vina_Series_Name_:\'\'),vinamodelyear(DEFAULT:Vina_Model_Year_:0),vinaseries(DEFAULT:Vina_Series_:\'\'),vinamodel(DEFAULT:Vina_Model_:\'\'),vinabodystyle(DEFAULT:Vina_Body_Style_:\'\'),vinamakedescription(DEFAULT:Vina_Make_Description_:\'\'),vinamodeldescription(DEFAULT:Vina_Model_Description_:\'\'),vinaseriesdescription(DEFAULT:Vina_Series_Description_:\'\'),vinabodystyledescription(DEFAULT:Vina_Body_Style_Description_:\'\'),vinacylinders(DEFAULT:Vina_Cylinders_:0),vinaenginesize(DEFAULT:Vina_Engine_Size_:0),vinafuelcode(DEFAULT:Vina_Fuel_Code_:\'\'),vinaprice(DEFAULT:Vina_Price_:0),bestmakecode(DEFAULT:Best_Make_Code_:\'\'),bestseriescode(DEFAULT:Best_Series_Code_:\'\'),bestmodelcode(DEFAULT:Best_Model_Code_:\'\'),bestbodycode(DEFAULT:Best_Body_Code_:\'\'),bestmodelyear(DEFAULT:Best_Model_Year_:0),bestmajorcolor(DEFAULT:Best_Major_Color_:\'\'),bestminorcolor(DEFAULT:Best_Minor_Color_:\'\'),brandedtitleflag(DEFAULT:Branded_Title_Flag_:\'\'),brandcode1(DEFAULT:Brand_Code1_:\'\'),branddate1(DEFAULT:Brand_Date1_:DATE),brandstate1(DEFAULT:Brand_State1_:\'\'),brandcode2(DEFAULT:Brand_Code2_:\'\'),branddate2(DEFAULT:Brand_Date2_:DATE),brandsate2(DEFAULT:Brand_Sate2_:\'\'),brandcode3(DEFAULT:Brand_Code3_:\'\'),branddate3(DEFAULT:Brand_Date3_:DATE),brandsate3(DEFAULT:Brand_Sate3_:\'\'),brandcode4(DEFAULT:Brand_Code4_:\'\'),branddate4(DEFAULT:Brand_Date4_:DATE),brandsate4(DEFAULT:Brand_Sate4_:\'\'),brandcode5(DEFAULT:Brand_Code5_:\'\'),branddate5(DEFAULT:Brand_Date5_:DATE),brandsate5(DEFAULT:Brand_Sate5_:\'\'),todflag(DEFAULT:Tod_Flag_:\'\'),modelclasscode(DEFAULT:Model_Class_Code_:\'\'),modelclass(DEFAULT:Model_Class_:\'\'),mindoorcount(DEFAULT:Min_Door_Count_:\'\'),safetytype(DEFAULT:Safety_Type_:\'\'),airbagdriver(DEFAULT:Airbag_Driver_:\'\'),airbagfrontdriverside(DEFAULT:Airbag_Front_Driver_Side_:\'\'),airbagfrontheadcurtain(DEFAULT:Airbag_Front_Head_Curtain_:\'\'),airbagfrontpassanger(DEFAULT:Airbag_Front_Passanger_:\'\'),airbagfrontpassangerside(DEFAULT:Airbag_Front_Passanger_Side_:\'\'),airbags(DEFAULT:Airbags_:\'\'),stateoforigin(DEFAULT:State_Of_Origin_:\'\'),latestvehicleflag(DEFAULT:Latest_Vehicle_Flag_:\'\'),latestvehicleiterationflag(DEFAULT:Latest_Vehicle_Iteration_Flag_:\'\'),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),sourcefirstdate(DEFAULT:Source_First_Date_:DATE),sourcelastdate(DEFAULT:Source_Last_Date_:DATE),standardlienholdername(DEFAULT:Standard_Lienholder_Name_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key((STRING20)vehicle_key <> '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.vehicle_key)));
  SHARED __d1_KELfiltered := ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key((STRING20)vehicle_key <> '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.vehicle_key)));
  SHARED __d2_KELfiltered := ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids((STRING20)vehicle_key <> '');
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.vehicle_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::ProfileBooster.ProfileBoosterV2_KEL::Vehicle::UidLookup',EXPIRE(28));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::ProfileBooster.ProfileBoosterV2_KEL::Vehicle');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::ProfileBooster.ProfileBoosterV2_KEL::Vehicle');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(DEFAULT:UID),vehicle_key(OVERRIDE:Vehicle_Key_:\'\'),orig_vin(OVERRIDE:Original_Vin_:\'\'),orig_year(OVERRIDE:Original_Year_Make_:0),orig_make_code(OVERRIDE:Original_Make_:\'\'),orig_make_desc(OVERRIDE:Original_Make_Description_:\'\'),orig_series_code(OVERRIDE:Original_Series_:\'\'),orig_series_desc(OVERRIDE:Original_Series_Description_:\'\'),orig_model_code(OVERRIDE:Original_Model_:\'\'),orig_model_desc(OVERRIDE:Original_Model_Description_:\'\'),orig_body_code(OVERRIDE:Original_Body_:\'\'),orig_body_desc(OVERRIDE:Original_Body_Description_:\'\'),orig_net_weight(OVERRIDE:Original_Net_Weight_:0),orig_gross_weight(OVERRIDE:Original_Gross_Weight_:0),orig_number_of_axles(OVERRIDE:Original_Number_Axles_:0),orig_vehicle_use_code(OVERRIDE:Original_Vehicle_Use_:\'\'),orig_vehicle_use_desc(OVERRIDE:Original_Vehicle_Use_Description_:\'\'),orig_vehicle_type_code(OVERRIDE:Original_Vehicle_Type_:\'\'),orig_vehicle_type_desc(OVERRIDE:Original_Vehicle_Type_Description_:\'\'),orig_major_color_code(OVERRIDE:Original_Major_Color_:\'\'),orig_major_color_desc(OVERRIDE:Original_Major_Color_Description_:\'\'),orig_minor_color_code(OVERRIDE:Original_Minor_Color_:\'\'),orig_minor_color_desc(OVERRIDE:Original_Minor_Color_Description_:\'\'),vina_vin(OVERRIDE:Vina_Vin_:\'\'),vina_vin_pattern_indicator(OVERRIDE:Vina_Vin_Pattern_:\'\'),vina_bypass_code(OVERRIDE:Vina_Bypass_Code_:\'\'),vina_veh_type(OVERRIDE:Vina_Vehicle_Type_:\'\'),vina_ncic_make(OVERRIDE:Vina_N_C_I_C_Make_:\'\'),vina_model_year_yy(OVERRIDE:Vina_Model_Year_Y_Y_:0),vina_vp_restraint(OVERRIDE:Vina_Restraint_:\'\'),vina_vp_abbrev_make_name(OVERRIDE:Vina_Make_Name_:\'\'),vina_vp_year(OVERRIDE:Vina_Year_:0),vina_vp_series(OVERRIDE:Vina_Vp_Series_:\'\'),vina_vp_model(OVERRIDE:Vina_Vp_Model_:\'\'),vina_vp_air_conditioning(OVERRIDE:Vina_Air_Conditioning_:\'\'),vina_vp_power_steering(OVERRIDE:Vina_Power_Steering_:\'\'),vina_vp_power_brakes(OVERRIDE:Vina_Power_Brakes_:\'\'),vina_vp_power_windows(OVERRIDE:Vina_Power_Windows_:\'\'),vina_vp_tilt_wheel(OVERRIDE:Vina_Tilt_Wheel_:\'\'),vina_vp_roof(OVERRIDE:Vina_Roof_:0),vina_vp_optional_roof1(OVERRIDE:Vina_Optional_Roof1_:0),vina_vp_optional_roof2(OVERRIDE:Vina_Optional_Roof2_:0),vina_vp_radio(OVERRIDE:Vina_Radio_:\'\'),vina_vp_optional_radio1(OVERRIDE:Vina_Optional_Radio1_:\'\'),vina_vp_optional_radio2(OVERRIDE:Vina_Optional_Radio2_:\'\'),vina_vp_transmission(OVERRIDE:Vina_Transmission_:\'\'),vina_vp_optional_transmission1(OVERRIDE:Vina_Optional_Transmission1_:\'\'),vina_vp_optional_transmission2(OVERRIDE:Vina_Optional_Transmission2_:\'\'),vina_vp_anti_lock_brakes(OVERRIDE:Vina_A_L_B_:0),vina_vp_front_wheel_drive(OVERRIDE:Vina_Front_W_D_:\'\'),vina_vp_four_wheel_drive(OVERRIDE:Vina_Four_W_D_:\'\'),vina_vp_security_system(OVERRIDE:Vina_Security_System_:\'\'),vina_vp_daytime_running_lights(OVERRIDE:Vina_D_R_L_:\'\'),vina_vp_series_name(OVERRIDE:Vina_Series_Name_:\'\'),vina_model_year(OVERRIDE:Vina_Model_Year_:0),vina_series(OVERRIDE:Vina_Series_:\'\'),vina_model(OVERRIDE:Vina_Model_:\'\'),vina_body_style(OVERRIDE:Vina_Body_Style_:\'\'),vina_make_desc(OVERRIDE:Vina_Make_Description_:\'\'),vina_model_desc(OVERRIDE:Vina_Model_Description_:\'\'),vina_series_desc(OVERRIDE:Vina_Series_Description_:\'\'),vina_body_style_desc(OVERRIDE:Vina_Body_Style_Description_:\'\'),vina_number_of_cylinders(OVERRIDE:Vina_Cylinders_:0),vina_engine_size(OVERRIDE:Vina_Engine_Size_:0),vina_fuel_code(OVERRIDE:Vina_Fuel_Code_:\'\'),vina_price(OVERRIDE:Vina_Price_:0),best_make_code(OVERRIDE:Best_Make_Code_:\'\'),best_series_code(OVERRIDE:Best_Series_Code_:\'\'),best_model_code(OVERRIDE:Best_Model_Code_:\'\'),best_body_code(OVERRIDE:Best_Body_Code_:\'\'),best_model_year(OVERRIDE:Best_Model_Year_:0),best_major_color_code(OVERRIDE:Best_Major_Color_:\'\'),best_minor_color_code(OVERRIDE:Best_Minor_Color_:\'\'),branded_title_flag(OVERRIDE:Branded_Title_Flag_:\'\'),brand_code_1(OVERRIDE:Brand_Code1_:\'\'),cleaned_brand_date_1(OVERRIDE:Brand_Date1_:DATE),brand_state_1(OVERRIDE:Brand_State1_:\'\'),brand_code_2(OVERRIDE:Brand_Code2_:\'\'),cleaned_brand_date_2(OVERRIDE:Brand_Date2_:DATE),brand_state_2(OVERRIDE:Brand_Sate2_:\'\'),brand_code_3(OVERRIDE:Brand_Code3_:\'\'),cleaned_brand_date_3(OVERRIDE:Brand_Date3_:DATE),brand_state_3(OVERRIDE:Brand_Sate3_:\'\'),brand_code_4(OVERRIDE:Brand_Code4_:\'\'),cleaned_brand_date_4(OVERRIDE:Brand_Date4_:DATE),brand_state_4(OVERRIDE:Brand_Sate4_:\'\'),brand_code_5(OVERRIDE:Brand_Code5_:\'\'),cleaned_brand_date_5(OVERRIDE:Brand_Date5_:DATE),brand_state_5(OVERRIDE:Brand_Sate5_:\'\'),tod_flag(OVERRIDE:Tod_Flag_:\'\'),model_class_code(OVERRIDE:Model_Class_Code_:\'\'),model_class(OVERRIDE:Model_Class_:\'\'),min_door_count(OVERRIDE:Min_Door_Count_:\'\'),safety_type(OVERRIDE:Safety_Type_:\'\'),airbag_driver(OVERRIDE:Airbag_Driver_:\'\'),airbag_front_driver_side(OVERRIDE:Airbag_Front_Driver_Side_:\'\'),airbag_front_head_curtain(OVERRIDE:Airbag_Front_Head_Curtain_:\'\'),airbag_front_pass(OVERRIDE:Airbag_Front_Passanger_:\'\'),airbag_front_pass_side(OVERRIDE:Airbag_Front_Passanger_Side_:\'\'),airbags(OVERRIDE:Airbags_:\'\'),state_origin(OVERRIDE:State_Of_Origin_:\'\'),latestvehicleflag(DEFAULT:Latest_Vehicle_Flag_:\'\'),latestvehicleiterationflag(DEFAULT:Latest_Vehicle_Iteration_Flag_:\'\'),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),sourcefirstdate(DEFAULT:Source_First_Date_:DATE),sourcelastdate(DEFAULT:Source_Last_Date_:DATE),standardlienholdername(DEFAULT:Standard_Lienholder_Name_:\'\'),source_code(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.vehicle_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Main_Key_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key');
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),vehicle_key(OVERRIDE:Vehicle_Key_:\'\'),originalvin(DEFAULT:Original_Vin_:\'\'),originalyearmake(DEFAULT:Original_Year_Make_:0),originalmake(DEFAULT:Original_Make_:\'\'),originalmakedescription(DEFAULT:Original_Make_Description_:\'\'),originalseries(DEFAULT:Original_Series_:\'\'),originalseriesdescription(DEFAULT:Original_Series_Description_:\'\'),originalmodel(DEFAULT:Original_Model_:\'\'),originalmodeldescription(DEFAULT:Original_Model_Description_:\'\'),originalbody(DEFAULT:Original_Body_:\'\'),originalbodydescription(DEFAULT:Original_Body_Description_:\'\'),originalnetweight(DEFAULT:Original_Net_Weight_:0),originalgrossweight(DEFAULT:Original_Gross_Weight_:0),originalnumberaxles(DEFAULT:Original_Number_Axles_:0),originalvehicleuse(DEFAULT:Original_Vehicle_Use_:\'\'),originalvehicleusedescription(DEFAULT:Original_Vehicle_Use_Description_:\'\'),originalvehicletype(DEFAULT:Original_Vehicle_Type_:\'\'),originalvehicletypedescription(DEFAULT:Original_Vehicle_Type_Description_:\'\'),originalmajorcolor(DEFAULT:Original_Major_Color_:\'\'),originalmajorcolordescription(DEFAULT:Original_Major_Color_Description_:\'\'),originalminorcolor(DEFAULT:Original_Minor_Color_:\'\'),originalminorcolordescription(DEFAULT:Original_Minor_Color_Description_:\'\'),vinavin(DEFAULT:Vina_Vin_:\'\'),vinavinpattern(DEFAULT:Vina_Vin_Pattern_:\'\'),vinabypasscode(DEFAULT:Vina_Bypass_Code_:\'\'),vinavehicletype(DEFAULT:Vina_Vehicle_Type_:\'\'),vinancicmake(DEFAULT:Vina_N_C_I_C_Make_:\'\'),vinamodelyearyy(DEFAULT:Vina_Model_Year_Y_Y_:0),vinarestraint(DEFAULT:Vina_Restraint_:\'\'),vinamakename(DEFAULT:Vina_Make_Name_:\'\'),vinayear(DEFAULT:Vina_Year_:0),vinavpseries(DEFAULT:Vina_Vp_Series_:\'\'),vinavpmodel(DEFAULT:Vina_Vp_Model_:\'\'),vinaairconditioning(DEFAULT:Vina_Air_Conditioning_:\'\'),vinapowersteering(DEFAULT:Vina_Power_Steering_:\'\'),vinapowerbrakes(DEFAULT:Vina_Power_Brakes_:\'\'),vinapowerwindows(DEFAULT:Vina_Power_Windows_:\'\'),vinatiltwheel(DEFAULT:Vina_Tilt_Wheel_:\'\'),vinaroof(DEFAULT:Vina_Roof_:0),vinaoptionalroof1(DEFAULT:Vina_Optional_Roof1_:0),vinaoptionalroof2(DEFAULT:Vina_Optional_Roof2_:0),vinaradio(DEFAULT:Vina_Radio_:\'\'),vinaoptionalradio1(DEFAULT:Vina_Optional_Radio1_:\'\'),vinaoptionalradio2(DEFAULT:Vina_Optional_Radio2_:\'\'),vinatransmission(DEFAULT:Vina_Transmission_:\'\'),vinaoptionaltransmission1(DEFAULT:Vina_Optional_Transmission1_:\'\'),vinaoptionaltransmission2(DEFAULT:Vina_Optional_Transmission2_:\'\'),vinaalb(DEFAULT:Vina_A_L_B_:0),vinafrontwd(DEFAULT:Vina_Front_W_D_:\'\'),vinafourwd(DEFAULT:Vina_Four_W_D_:\'\'),vinasecuritysystem(DEFAULT:Vina_Security_System_:\'\'),vinadrl(DEFAULT:Vina_D_R_L_:\'\'),vinaseriesname(DEFAULT:Vina_Series_Name_:\'\'),vinamodelyear(DEFAULT:Vina_Model_Year_:0),vinaseries(DEFAULT:Vina_Series_:\'\'),vinamodel(DEFAULT:Vina_Model_:\'\'),vinabodystyle(DEFAULT:Vina_Body_Style_:\'\'),vinamakedescription(DEFAULT:Vina_Make_Description_:\'\'),vinamodeldescription(DEFAULT:Vina_Model_Description_:\'\'),vinaseriesdescription(DEFAULT:Vina_Series_Description_:\'\'),vinabodystyledescription(DEFAULT:Vina_Body_Style_Description_:\'\'),vinacylinders(DEFAULT:Vina_Cylinders_:0),vinaenginesize(DEFAULT:Vina_Engine_Size_:0),vinafuelcode(DEFAULT:Vina_Fuel_Code_:\'\'),vinaprice(DEFAULT:Vina_Price_:0),bestmakecode(DEFAULT:Best_Make_Code_:\'\'),bestseriescode(DEFAULT:Best_Series_Code_:\'\'),bestmodelcode(DEFAULT:Best_Model_Code_:\'\'),bestbodycode(DEFAULT:Best_Body_Code_:\'\'),bestmodelyear(DEFAULT:Best_Model_Year_:0),bestmajorcolor(DEFAULT:Best_Major_Color_:\'\'),bestminorcolor(DEFAULT:Best_Minor_Color_:\'\'),brandedtitleflag(DEFAULT:Branded_Title_Flag_:\'\'),brandcode1(DEFAULT:Brand_Code1_:\'\'),branddate1(DEFAULT:Brand_Date1_:DATE),brandstate1(DEFAULT:Brand_State1_:\'\'),brandcode2(DEFAULT:Brand_Code2_:\'\'),branddate2(DEFAULT:Brand_Date2_:DATE),brandsate2(DEFAULT:Brand_Sate2_:\'\'),brandcode3(DEFAULT:Brand_Code3_:\'\'),branddate3(DEFAULT:Brand_Date3_:DATE),brandsate3(DEFAULT:Brand_Sate3_:\'\'),brandcode4(DEFAULT:Brand_Code4_:\'\'),branddate4(DEFAULT:Brand_Date4_:DATE),brandsate4(DEFAULT:Brand_Sate4_:\'\'),brandcode5(DEFAULT:Brand_Code5_:\'\'),branddate5(DEFAULT:Brand_Date5_:DATE),brandsate5(DEFAULT:Brand_Sate5_:\'\'),todflag(DEFAULT:Tod_Flag_:\'\'),modelclasscode(DEFAULT:Model_Class_Code_:\'\'),modelclass(DEFAULT:Model_Class_:\'\'),mindoorcount(DEFAULT:Min_Door_Count_:\'\'),safetytype(DEFAULT:Safety_Type_:\'\'),airbagdriver(DEFAULT:Airbag_Driver_:\'\'),airbagfrontdriverside(DEFAULT:Airbag_Front_Driver_Side_:\'\'),airbagfrontheadcurtain(DEFAULT:Airbag_Front_Head_Curtain_:\'\'),airbagfrontpassanger(DEFAULT:Airbag_Front_Passanger_:\'\'),airbagfrontpassangerside(DEFAULT:Airbag_Front_Passanger_Side_:\'\'),airbags(DEFAULT:Airbags_:\'\'),state_origin(OVERRIDE:State_Of_Origin_:\'\'),latest_vehicle_flag(OVERRIDE:Latest_Vehicle_Flag_:\'\'),latest_vehicle_iteration_flag(OVERRIDE:Latest_Vehicle_Iteration_Flag_:\'\'),date_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),src_first_date(OVERRIDE:Source_First_Date_:DATE|OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),src_last_date(OVERRIDE:Source_Last_Date_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),std_lienholder_name(OVERRIDE:Standard_Lienholder_Name_:\'\'),source_code(OVERRIDE:Source_:\'\'),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.vehicle_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Party_Key_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key');
  SHARED Date_Vendor_First_Reported_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Vendor_Last_Reported_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),vehicle_key(OVERRIDE:Vehicle_Key_:\'\'),originalvin(DEFAULT:Original_Vin_:\'\'),originalyearmake(DEFAULT:Original_Year_Make_:0),originalmake(DEFAULT:Original_Make_:\'\'),originalmakedescription(DEFAULT:Original_Make_Description_:\'\'),originalseries(DEFAULT:Original_Series_:\'\'),originalseriesdescription(DEFAULT:Original_Series_Description_:\'\'),originalmodel(DEFAULT:Original_Model_:\'\'),originalmodeldescription(DEFAULT:Original_Model_Description_:\'\'),originalbody(DEFAULT:Original_Body_:\'\'),originalbodydescription(DEFAULT:Original_Body_Description_:\'\'),originalnetweight(DEFAULT:Original_Net_Weight_:0),originalgrossweight(DEFAULT:Original_Gross_Weight_:0),originalnumberaxles(DEFAULT:Original_Number_Axles_:0),originalvehicleuse(DEFAULT:Original_Vehicle_Use_:\'\'),originalvehicleusedescription(DEFAULT:Original_Vehicle_Use_Description_:\'\'),originalvehicletype(DEFAULT:Original_Vehicle_Type_:\'\'),originalvehicletypedescription(DEFAULT:Original_Vehicle_Type_Description_:\'\'),originalmajorcolor(DEFAULT:Original_Major_Color_:\'\'),originalmajorcolordescription(DEFAULT:Original_Major_Color_Description_:\'\'),originalminorcolor(DEFAULT:Original_Minor_Color_:\'\'),originalminorcolordescription(DEFAULT:Original_Minor_Color_Description_:\'\'),vinavin(DEFAULT:Vina_Vin_:\'\'),vinavinpattern(DEFAULT:Vina_Vin_Pattern_:\'\'),vinabypasscode(DEFAULT:Vina_Bypass_Code_:\'\'),vinavehicletype(DEFAULT:Vina_Vehicle_Type_:\'\'),vinancicmake(DEFAULT:Vina_N_C_I_C_Make_:\'\'),vinamodelyearyy(DEFAULT:Vina_Model_Year_Y_Y_:0),vinarestraint(DEFAULT:Vina_Restraint_:\'\'),vinamakename(DEFAULT:Vina_Make_Name_:\'\'),vinayear(DEFAULT:Vina_Year_:0),vinavpseries(DEFAULT:Vina_Vp_Series_:\'\'),vinavpmodel(DEFAULT:Vina_Vp_Model_:\'\'),vinaairconditioning(DEFAULT:Vina_Air_Conditioning_:\'\'),vinapowersteering(DEFAULT:Vina_Power_Steering_:\'\'),vinapowerbrakes(DEFAULT:Vina_Power_Brakes_:\'\'),vinapowerwindows(DEFAULT:Vina_Power_Windows_:\'\'),vinatiltwheel(DEFAULT:Vina_Tilt_Wheel_:\'\'),vinaroof(DEFAULT:Vina_Roof_:0),vinaoptionalroof1(DEFAULT:Vina_Optional_Roof1_:0),vinaoptionalroof2(DEFAULT:Vina_Optional_Roof2_:0),vinaradio(DEFAULT:Vina_Radio_:\'\'),vinaoptionalradio1(DEFAULT:Vina_Optional_Radio1_:\'\'),vinaoptionalradio2(DEFAULT:Vina_Optional_Radio2_:\'\'),vinatransmission(DEFAULT:Vina_Transmission_:\'\'),vinaoptionaltransmission1(DEFAULT:Vina_Optional_Transmission1_:\'\'),vinaoptionaltransmission2(DEFAULT:Vina_Optional_Transmission2_:\'\'),vinaalb(DEFAULT:Vina_A_L_B_:0),vinafrontwd(DEFAULT:Vina_Front_W_D_:\'\'),vinafourwd(DEFAULT:Vina_Four_W_D_:\'\'),vinasecuritysystem(DEFAULT:Vina_Security_System_:\'\'),vinadrl(DEFAULT:Vina_D_R_L_:\'\'),vinaseriesname(DEFAULT:Vina_Series_Name_:\'\'),vinamodelyear(DEFAULT:Vina_Model_Year_:0),vinaseries(DEFAULT:Vina_Series_:\'\'),vinamodel(DEFAULT:Vina_Model_:\'\'),vinabodystyle(DEFAULT:Vina_Body_Style_:\'\'),vinamakedescription(DEFAULT:Vina_Make_Description_:\'\'),vinamodeldescription(DEFAULT:Vina_Model_Description_:\'\'),vinaseriesdescription(DEFAULT:Vina_Series_Description_:\'\'),vinabodystyledescription(DEFAULT:Vina_Body_Style_Description_:\'\'),vinacylinders(DEFAULT:Vina_Cylinders_:0),vinaenginesize(DEFAULT:Vina_Engine_Size_:0),vinafuelcode(DEFAULT:Vina_Fuel_Code_:\'\'),vinaprice(DEFAULT:Vina_Price_:0),bestmakecode(DEFAULT:Best_Make_Code_:\'\'),bestseriescode(DEFAULT:Best_Series_Code_:\'\'),bestmodelcode(DEFAULT:Best_Model_Code_:\'\'),bestbodycode(DEFAULT:Best_Body_Code_:\'\'),bestmodelyear(DEFAULT:Best_Model_Year_:0),bestmajorcolor(DEFAULT:Best_Major_Color_:\'\'),bestminorcolor(DEFAULT:Best_Minor_Color_:\'\'),brandedtitleflag(DEFAULT:Branded_Title_Flag_:\'\'),brandcode1(DEFAULT:Brand_Code1_:\'\'),branddate1(DEFAULT:Brand_Date1_:DATE),brandstate1(DEFAULT:Brand_State1_:\'\'),brandcode2(DEFAULT:Brand_Code2_:\'\'),branddate2(DEFAULT:Brand_Date2_:DATE),brandsate2(DEFAULT:Brand_Sate2_:\'\'),brandcode3(DEFAULT:Brand_Code3_:\'\'),branddate3(DEFAULT:Brand_Date3_:DATE),brandsate3(DEFAULT:Brand_Sate3_:\'\'),brandcode4(DEFAULT:Brand_Code4_:\'\'),branddate4(DEFAULT:Brand_Date4_:DATE),brandsate4(DEFAULT:Brand_Sate4_:\'\'),brandcode5(DEFAULT:Brand_Code5_:\'\'),branddate5(DEFAULT:Brand_Date5_:DATE),brandsate5(DEFAULT:Brand_Sate5_:\'\'),todflag(DEFAULT:Tod_Flag_:\'\'),modelclasscode(DEFAULT:Model_Class_Code_:\'\'),modelclass(DEFAULT:Model_Class_:\'\'),mindoorcount(DEFAULT:Min_Door_Count_:\'\'),safetytype(DEFAULT:Safety_Type_:\'\'),airbagdriver(DEFAULT:Airbag_Driver_:\'\'),airbagfrontdriverside(DEFAULT:Airbag_Front_Driver_Side_:\'\'),airbagfrontheadcurtain(DEFAULT:Airbag_Front_Head_Curtain_:\'\'),airbagfrontpassanger(DEFAULT:Airbag_Front_Passanger_:\'\'),airbagfrontpassangerside(DEFAULT:Airbag_Front_Passanger_Side_:\'\'),airbags(DEFAULT:Airbags_:\'\'),state_origin(OVERRIDE:State_Of_Origin_:\'\'),latest_vehicle_flag(OVERRIDE:Latest_Vehicle_Flag_:\'\'),latest_vehicle_iteration_flag(OVERRIDE:Latest_Vehicle_Iteration_Flag_:\'\'),date_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE:Date_Vendor_First_Reported_2Rule),date_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE:Date_Vendor_Last_Reported_2Rule),sourcefirstdate(DEFAULT:Source_First_Date_:DATE),sourcelastdate(DEFAULT:Source_Last_Date_:DATE),standardlienholdername(DEFAULT:Standard_Lienholder_Name_:\'\'),source_code(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.vehicle_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_linkids_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids');
  EXPORT InData := __d0 + __d1 + __d2;
  SHARED InDataDist(KEL.typ.bool sortpe) := IF(sortpe,SORT(InData,UID),DISTRIBUTE(InData,HASH(UID)));
  SHARED InDataDeduped(KEL.typ.bool sortpe) := TABLE(InDataDist(sortpe),{KEL.typ.int __RecordCount := COUNT(GROUP),UID,Vehicle_Key_,Original_Vin_,Original_Year_Make_,Original_Make_,Original_Make_Description_,Original_Series_,Original_Series_Description_,Original_Model_,Original_Model_Description_,Original_Body_,Original_Body_Description_,Original_Net_Weight_,Original_Gross_Weight_,Original_Number_Axles_,Original_Vehicle_Use_,Original_Vehicle_Use_Description_,Original_Vehicle_Type_,Original_Vehicle_Type_Description_,Original_Major_Color_,Original_Major_Color_Description_,Original_Minor_Color_,Original_Minor_Color_Description_,Vina_Vin_,Vina_Vin_Pattern_,Vina_Bypass_Code_,Vina_Vehicle_Type_,Vina_N_C_I_C_Make_,Vina_Model_Year_Y_Y_,Vina_Restraint_,Vina_Make_Name_,Vina_Year_,Vina_Vp_Series_,Vina_Vp_Model_,Vina_Air_Conditioning_,Vina_Power_Steering_,Vina_Power_Brakes_,Vina_Power_Windows_,Vina_Tilt_Wheel_,Vina_Roof_,Vina_Optional_Roof1_,Vina_Optional_Roof2_,Vina_Radio_,Vina_Optional_Radio1_,Vina_Optional_Radio2_,Vina_Transmission_,Vina_Optional_Transmission1_,Vina_Optional_Transmission2_,Vina_A_L_B_,Vina_Front_W_D_,Vina_Four_W_D_,Vina_Security_System_,Vina_D_R_L_,Vina_Series_Name_,Vina_Model_Year_,Vina_Series_,Vina_Model_,Vina_Body_Style_,Vina_Make_Description_,Vina_Model_Description_,Vina_Series_Description_,Vina_Body_Style_Description_,Vina_Cylinders_,Vina_Engine_Size_,Vina_Fuel_Code_,Vina_Price_,Best_Make_Code_,Best_Series_Code_,Best_Model_Code_,Best_Body_Code_,Best_Model_Year_,Best_Major_Color_,Best_Minor_Color_,Branded_Title_Flag_,Brand_Code1_,Brand_Date1_,Brand_State1_,Brand_Code2_,Brand_Date2_,Brand_Sate2_,Brand_Code3_,Brand_Date3_,Brand_Sate3_,Brand_Code4_,Brand_Date4_,Brand_Sate4_,Brand_Code5_,Brand_Date5_,Brand_Sate5_,Tod_Flag_,Model_Class_Code_,Model_Class_,Min_Door_Count_,Safety_Type_,Airbag_Driver_,Airbag_Front_Driver_Side_,Airbag_Front_Head_Curtain_,Airbag_Front_Passanger_,Airbag_Front_Passanger_Side_,Airbags_,State_Of_Origin_,Latest_Vehicle_Flag_,Latest_Vehicle_Iteration_Flag_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_First_Date_,Source_Last_Date_,Standard_Lienholder_Name_,Source_,Date_First_Seen_,Date_Last_Seen_,__Permits},UID,Vehicle_Key_,Original_Vin_,Original_Year_Make_,Original_Make_,Original_Make_Description_,Original_Series_,Original_Series_Description_,Original_Model_,Original_Model_Description_,Original_Body_,Original_Body_Description_,Original_Net_Weight_,Original_Gross_Weight_,Original_Number_Axles_,Original_Vehicle_Use_,Original_Vehicle_Use_Description_,Original_Vehicle_Type_,Original_Vehicle_Type_Description_,Original_Major_Color_,Original_Major_Color_Description_,Original_Minor_Color_,Original_Minor_Color_Description_,Vina_Vin_,Vina_Vin_Pattern_,Vina_Bypass_Code_,Vina_Vehicle_Type_,Vina_N_C_I_C_Make_,Vina_Model_Year_Y_Y_,Vina_Restraint_,Vina_Make_Name_,Vina_Year_,Vina_Vp_Series_,Vina_Vp_Model_,Vina_Air_Conditioning_,Vina_Power_Steering_,Vina_Power_Brakes_,Vina_Power_Windows_,Vina_Tilt_Wheel_,Vina_Roof_,Vina_Optional_Roof1_,Vina_Optional_Roof2_,Vina_Radio_,Vina_Optional_Radio1_,Vina_Optional_Radio2_,Vina_Transmission_,Vina_Optional_Transmission1_,Vina_Optional_Transmission2_,Vina_A_L_B_,Vina_Front_W_D_,Vina_Four_W_D_,Vina_Security_System_,Vina_D_R_L_,Vina_Series_Name_,Vina_Model_Year_,Vina_Series_,Vina_Model_,Vina_Body_Style_,Vina_Make_Description_,Vina_Model_Description_,Vina_Series_Description_,Vina_Body_Style_Description_,Vina_Cylinders_,Vina_Engine_Size_,Vina_Fuel_Code_,Vina_Price_,Best_Make_Code_,Best_Series_Code_,Best_Model_Code_,Best_Body_Code_,Best_Model_Year_,Best_Major_Color_,Best_Minor_Color_,Branded_Title_Flag_,Brand_Code1_,Brand_Date1_,Brand_State1_,Brand_Code2_,Brand_Date2_,Brand_Sate2_,Brand_Code3_,Brand_Date3_,Brand_Sate3_,Brand_Code4_,Brand_Date4_,Brand_Sate4_,Brand_Code5_,Brand_Date5_,Brand_Sate5_,Tod_Flag_,Model_Class_Code_,Model_Class_,Min_Door_Count_,Safety_Type_,Airbag_Driver_,Airbag_Front_Driver_Side_,Airbag_Front_Head_Curtain_,Airbag_Front_Passanger_,Airbag_Front_Passanger_Side_,Airbags_,State_Of_Origin_,Latest_Vehicle_Flag_,Latest_Vehicle_Iteration_Flag_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_First_Date_,Source_Last_Date_,Standard_Lienholder_Name_,Source_,Date_First_Seen_,Date_Last_Seen_,__Permits,LOCAL);
  EXPORT PreEntityInternal(KEL.typ.bool sortpe) := ROLLUP(GROUP(InDataDeduped(sortpe),UID,LOCAL),GROUP,TRANSFORM(PreEntityLayout,SELF.__Payload:=PROJECT(ROWS(LEFT),PreEntityPayloadLayout),SELF:=LEFT));
  EXPORT PreEntity := PreEntityInternal(false);
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
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED ExpandedPreEntityLayout PreEntitySourceFilter(PreEntityLayout __r) := TRANSFORM
    SELF.__Payload := __SourceFilter(PROJECT(__r.__Payload,TRANSFORM(InLayout,SELF:=__r,SELF:=LEFT)));
    SELF := __r;
  END;
  FilteredPreEntity := __PreEntityFilter(PROJECT(PreEntity,PreEntitySourceFilter(LEFT))(__NN(UID)));
  EXPORT __PostFilter := FilteredPreEntity;
  Vehicle_Group := __PostFilter;
  Layout Vehicle__Rollup(InLayout __r, DATASET(InLayout) __recs, ExpandedPreEntityLayout __other) := TRANSFORM
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
    SELF.Safety_Type_ := KEL.Intake.SingleValue(__recs,Safety_Type_);
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
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.__Part := __other.__Part;
    SELF := __r;
  END;
  Layout Vehicle__Single_Rollup(InLayout __r, ExpandedPreEntityLayout __other) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := __r.__RecordCount;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.__Part := __other.__Part;
    SELF := __r;
  END;
  SHARED __PreResult := PROJECT(Vehicle_Group(COUNT(__Payload) = 1),Vehicle__Single_Rollup(LEFT.__Payload[1],LEFT)) + PROJECT(Vehicle_Group(COUNT(__Payload) > 1),Vehicle__Rollup(LEFT.__Payload[1],LEFT.__Payload,LEFT));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::ProfileBooster.ProfileBoosterV2_KEL::Vehicle::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(28));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
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
  EXPORT Safety_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Safety_Type_);
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
  EXPORT SanityCheck := DATASET([{COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Main_Key_Invalid),COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Party_Key_Invalid),COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_linkids_Invalid),COUNT(Vehicle_Key__SingleValue_Invalid),COUNT(State_Of_Origin__SingleValue_Invalid),COUNT(Original_Vin__SingleValue_Invalid),COUNT(Original_Year_Make__SingleValue_Invalid),COUNT(Original_Make__SingleValue_Invalid),COUNT(Original_Make_Description__SingleValue_Invalid),COUNT(Original_Series__SingleValue_Invalid),COUNT(Original_Series_Description__SingleValue_Invalid),COUNT(Original_Model__SingleValue_Invalid),COUNT(Original_Model_Description__SingleValue_Invalid),COUNT(Original_Body__SingleValue_Invalid),COUNT(Original_Body_Description__SingleValue_Invalid),COUNT(Original_Net_Weight__SingleValue_Invalid),COUNT(Original_Gross_Weight__SingleValue_Invalid),COUNT(Original_Number_Axles__SingleValue_Invalid),COUNT(Original_Vehicle_Use__SingleValue_Invalid),COUNT(Original_Vehicle_Use_Description__SingleValue_Invalid),COUNT(Original_Vehicle_Type__SingleValue_Invalid),COUNT(Original_Vehicle_Type_Description__SingleValue_Invalid),COUNT(Original_Major_Color__SingleValue_Invalid),COUNT(Original_Major_Color_Description__SingleValue_Invalid),COUNT(Original_Minor_Color__SingleValue_Invalid),COUNT(Original_Minor_Color_Description__SingleValue_Invalid),COUNT(Vina_Vin__SingleValue_Invalid),COUNT(Vina_Vin_Pattern__SingleValue_Invalid),COUNT(Vina_Bypass_Code__SingleValue_Invalid),COUNT(Vina_Vehicle_Type__SingleValue_Invalid),COUNT(Vina_N_C_I_C_Make__SingleValue_Invalid),COUNT(Vina_Model_Year_Y_Y__SingleValue_Invalid),COUNT(Vina_Restraint__SingleValue_Invalid),COUNT(Vina_Make_Name__SingleValue_Invalid),COUNT(Vina_Year__SingleValue_Invalid),COUNT(Vina_Vp_Series__SingleValue_Invalid),COUNT(Vina_Vp_Model__SingleValue_Invalid),COUNT(Vina_Air_Conditioning__SingleValue_Invalid),COUNT(Vina_Power_Steering__SingleValue_Invalid),COUNT(Vina_Power_Brakes__SingleValue_Invalid),COUNT(Vina_Power_Windows__SingleValue_Invalid),COUNT(Vina_Tilt_Wheel__SingleValue_Invalid),COUNT(Vina_Roof__SingleValue_Invalid),COUNT(Vina_Optional_Roof1__SingleValue_Invalid),COUNT(Vina_Optional_Roof2__SingleValue_Invalid),COUNT(Vina_Radio__SingleValue_Invalid),COUNT(Vina_Optional_Radio1__SingleValue_Invalid),COUNT(Vina_Optional_Radio2__SingleValue_Invalid),COUNT(Vina_Transmission__SingleValue_Invalid),COUNT(Vina_Optional_Transmission1__SingleValue_Invalid),COUNT(Vina_Optional_Transmission2__SingleValue_Invalid),COUNT(Vina_A_L_B__SingleValue_Invalid),COUNT(Vina_Front_W_D__SingleValue_Invalid),COUNT(Vina_Four_W_D__SingleValue_Invalid),COUNT(Vina_Security_System__SingleValue_Invalid),COUNT(Vina_D_R_L__SingleValue_Invalid),COUNT(Vina_Series_Name__SingleValue_Invalid),COUNT(Vina_Model_Year__SingleValue_Invalid),COUNT(Vina_Series__SingleValue_Invalid),COUNT(Vina_Model__SingleValue_Invalid),COUNT(Vina_Body_Style__SingleValue_Invalid),COUNT(Vina_Make_Description__SingleValue_Invalid),COUNT(Vina_Model_Description__SingleValue_Invalid),COUNT(Vina_Series_Description__SingleValue_Invalid),COUNT(Vina_Body_Style_Description__SingleValue_Invalid),COUNT(Vina_Cylinders__SingleValue_Invalid),COUNT(Vina_Engine_Size__SingleValue_Invalid),COUNT(Vina_Fuel_Code__SingleValue_Invalid),COUNT(Vina_Price__SingleValue_Invalid),COUNT(Best_Make_Code__SingleValue_Invalid),COUNT(Best_Series_Code__SingleValue_Invalid),COUNT(Best_Model_Code__SingleValue_Invalid),COUNT(Best_Body_Code__SingleValue_Invalid),COUNT(Best_Model_Year__SingleValue_Invalid),COUNT(Best_Major_Color__SingleValue_Invalid),COUNT(Best_Minor_Color__SingleValue_Invalid),COUNT(Branded_Title_Flag__SingleValue_Invalid),COUNT(Brand_Code1__SingleValue_Invalid),COUNT(Brand_Date1__SingleValue_Invalid),COUNT(Brand_State1__SingleValue_Invalid),COUNT(Brand_Code2__SingleValue_Invalid),COUNT(Brand_Date2__SingleValue_Invalid),COUNT(Brand_Sate2__SingleValue_Invalid),COUNT(Brand_Code3__SingleValue_Invalid),COUNT(Brand_Date3__SingleValue_Invalid),COUNT(Brand_Sate3__SingleValue_Invalid),COUNT(Brand_Code4__SingleValue_Invalid),COUNT(Brand_Date4__SingleValue_Invalid),COUNT(Brand_Sate4__SingleValue_Invalid),COUNT(Brand_Code5__SingleValue_Invalid),COUNT(Brand_Date5__SingleValue_Invalid),COUNT(Brand_Sate5__SingleValue_Invalid),COUNT(Safety_Type__SingleValue_Invalid),COUNT(Airbag_Driver__SingleValue_Invalid),COUNT(Airbag_Front_Driver_Side__SingleValue_Invalid),COUNT(Airbag_Front_Head_Curtain__SingleValue_Invalid),COUNT(Airbag_Front_Passanger__SingleValue_Invalid),COUNT(Airbag_Front_Passanger_Side__SingleValue_Invalid),COUNT(Airbags__SingleValue_Invalid),COUNT(Tod_Flag__SingleValue_Invalid),COUNT(Model_Class_Code__SingleValue_Invalid),COUNT(Model_Class__SingleValue_Invalid),COUNT(Min_Door_Count__SingleValue_Invalid),COUNT(Latest_Vehicle_Flag__SingleValue_Invalid),COUNT(Latest_Vehicle_Iteration_Flag__SingleValue_Invalid),COUNT(Date_Vendor_First_Reported__SingleValue_Invalid),COUNT(Date_Vendor_Last_Reported__SingleValue_Invalid),COUNT(Standard_Lienholder_Name__SingleValue_Invalid),COUNT(Source_First_Date__SingleValue_Invalid),COUNT(Source_Last_Date__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Main_Key_Invalid,KEL.typ.int ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Party_Key_Invalid,KEL.typ.int ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_linkids_Invalid,KEL.typ.int Vehicle_Key__SingleValue_Invalid,KEL.typ.int State_Of_Origin__SingleValue_Invalid,KEL.typ.int Original_Vin__SingleValue_Invalid,KEL.typ.int Original_Year_Make__SingleValue_Invalid,KEL.typ.int Original_Make__SingleValue_Invalid,KEL.typ.int Original_Make_Description__SingleValue_Invalid,KEL.typ.int Original_Series__SingleValue_Invalid,KEL.typ.int Original_Series_Description__SingleValue_Invalid,KEL.typ.int Original_Model__SingleValue_Invalid,KEL.typ.int Original_Model_Description__SingleValue_Invalid,KEL.typ.int Original_Body__SingleValue_Invalid,KEL.typ.int Original_Body_Description__SingleValue_Invalid,KEL.typ.int Original_Net_Weight__SingleValue_Invalid,KEL.typ.int Original_Gross_Weight__SingleValue_Invalid,KEL.typ.int Original_Number_Axles__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Use__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Use_Description__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Type__SingleValue_Invalid,KEL.typ.int Original_Vehicle_Type_Description__SingleValue_Invalid,KEL.typ.int Original_Major_Color__SingleValue_Invalid,KEL.typ.int Original_Major_Color_Description__SingleValue_Invalid,KEL.typ.int Original_Minor_Color__SingleValue_Invalid,KEL.typ.int Original_Minor_Color_Description__SingleValue_Invalid,KEL.typ.int Vina_Vin__SingleValue_Invalid,KEL.typ.int Vina_Vin_Pattern__SingleValue_Invalid,KEL.typ.int Vina_Bypass_Code__SingleValue_Invalid,KEL.typ.int Vina_Vehicle_Type__SingleValue_Invalid,KEL.typ.int Vina_N_C_I_C_Make__SingleValue_Invalid,KEL.typ.int Vina_Model_Year_Y_Y__SingleValue_Invalid,KEL.typ.int Vina_Restraint__SingleValue_Invalid,KEL.typ.int Vina_Make_Name__SingleValue_Invalid,KEL.typ.int Vina_Year__SingleValue_Invalid,KEL.typ.int Vina_Vp_Series__SingleValue_Invalid,KEL.typ.int Vina_Vp_Model__SingleValue_Invalid,KEL.typ.int Vina_Air_Conditioning__SingleValue_Invalid,KEL.typ.int Vina_Power_Steering__SingleValue_Invalid,KEL.typ.int Vina_Power_Brakes__SingleValue_Invalid,KEL.typ.int Vina_Power_Windows__SingleValue_Invalid,KEL.typ.int Vina_Tilt_Wheel__SingleValue_Invalid,KEL.typ.int Vina_Roof__SingleValue_Invalid,KEL.typ.int Vina_Optional_Roof1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Roof2__SingleValue_Invalid,KEL.typ.int Vina_Radio__SingleValue_Invalid,KEL.typ.int Vina_Optional_Radio1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Radio2__SingleValue_Invalid,KEL.typ.int Vina_Transmission__SingleValue_Invalid,KEL.typ.int Vina_Optional_Transmission1__SingleValue_Invalid,KEL.typ.int Vina_Optional_Transmission2__SingleValue_Invalid,KEL.typ.int Vina_A_L_B__SingleValue_Invalid,KEL.typ.int Vina_Front_W_D__SingleValue_Invalid,KEL.typ.int Vina_Four_W_D__SingleValue_Invalid,KEL.typ.int Vina_Security_System__SingleValue_Invalid,KEL.typ.int Vina_D_R_L__SingleValue_Invalid,KEL.typ.int Vina_Series_Name__SingleValue_Invalid,KEL.typ.int Vina_Model_Year__SingleValue_Invalid,KEL.typ.int Vina_Series__SingleValue_Invalid,KEL.typ.int Vina_Model__SingleValue_Invalid,KEL.typ.int Vina_Body_Style__SingleValue_Invalid,KEL.typ.int Vina_Make_Description__SingleValue_Invalid,KEL.typ.int Vina_Model_Description__SingleValue_Invalid,KEL.typ.int Vina_Series_Description__SingleValue_Invalid,KEL.typ.int Vina_Body_Style_Description__SingleValue_Invalid,KEL.typ.int Vina_Cylinders__SingleValue_Invalid,KEL.typ.int Vina_Engine_Size__SingleValue_Invalid,KEL.typ.int Vina_Fuel_Code__SingleValue_Invalid,KEL.typ.int Vina_Price__SingleValue_Invalid,KEL.typ.int Best_Make_Code__SingleValue_Invalid,KEL.typ.int Best_Series_Code__SingleValue_Invalid,KEL.typ.int Best_Model_Code__SingleValue_Invalid,KEL.typ.int Best_Body_Code__SingleValue_Invalid,KEL.typ.int Best_Model_Year__SingleValue_Invalid,KEL.typ.int Best_Major_Color__SingleValue_Invalid,KEL.typ.int Best_Minor_Color__SingleValue_Invalid,KEL.typ.int Branded_Title_Flag__SingleValue_Invalid,KEL.typ.int Brand_Code1__SingleValue_Invalid,KEL.typ.int Brand_Date1__SingleValue_Invalid,KEL.typ.int Brand_State1__SingleValue_Invalid,KEL.typ.int Brand_Code2__SingleValue_Invalid,KEL.typ.int Brand_Date2__SingleValue_Invalid,KEL.typ.int Brand_Sate2__SingleValue_Invalid,KEL.typ.int Brand_Code3__SingleValue_Invalid,KEL.typ.int Brand_Date3__SingleValue_Invalid,KEL.typ.int Brand_Sate3__SingleValue_Invalid,KEL.typ.int Brand_Code4__SingleValue_Invalid,KEL.typ.int Brand_Date4__SingleValue_Invalid,KEL.typ.int Brand_Sate4__SingleValue_Invalid,KEL.typ.int Brand_Code5__SingleValue_Invalid,KEL.typ.int Brand_Date5__SingleValue_Invalid,KEL.typ.int Brand_Sate5__SingleValue_Invalid,KEL.typ.int Safety_Type__SingleValue_Invalid,KEL.typ.int Airbag_Driver__SingleValue_Invalid,KEL.typ.int Airbag_Front_Driver_Side__SingleValue_Invalid,KEL.typ.int Airbag_Front_Head_Curtain__SingleValue_Invalid,KEL.typ.int Airbag_Front_Passanger__SingleValue_Invalid,KEL.typ.int Airbag_Front_Passanger_Side__SingleValue_Invalid,KEL.typ.int Airbags__SingleValue_Invalid,KEL.typ.int Tod_Flag__SingleValue_Invalid,KEL.typ.int Model_Class_Code__SingleValue_Invalid,KEL.typ.int Model_Class__SingleValue_Invalid,KEL.typ.int Min_Door_Count__SingleValue_Invalid,KEL.typ.int Latest_Vehicle_Flag__SingleValue_Invalid,KEL.typ.int Latest_Vehicle_Iteration_Flag__SingleValue_Invalid,KEL.typ.int Date_Vendor_First_Reported__SingleValue_Invalid,KEL.typ.int Date_Vendor_Last_Reported__SingleValue_Invalid,KEL.typ.int Standard_Lienholder_Name__SingleValue_Invalid,KEL.typ.int Source_First_Date__SingleValue_Invalid,KEL.typ.int Source_Last_Date__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','UID',COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Main_Key_Invalid),COUNT(__d0)},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vehicle_key',COUNT(__d0(__NL(Vehicle_Key_))),COUNT(__d0(__NN(Vehicle_Key_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_vin',COUNT(__d0(__NL(Original_Vin_))),COUNT(__d0(__NN(Original_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_year',COUNT(__d0(__NL(Original_Year_Make_))),COUNT(__d0(__NN(Original_Year_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_make_code',COUNT(__d0(__NL(Original_Make_))),COUNT(__d0(__NN(Original_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_make_desc',COUNT(__d0(__NL(Original_Make_Description_))),COUNT(__d0(__NN(Original_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_series_code',COUNT(__d0(__NL(Original_Series_))),COUNT(__d0(__NN(Original_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_series_desc',COUNT(__d0(__NL(Original_Series_Description_))),COUNT(__d0(__NN(Original_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_model_code',COUNT(__d0(__NL(Original_Model_))),COUNT(__d0(__NN(Original_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_model_desc',COUNT(__d0(__NL(Original_Model_Description_))),COUNT(__d0(__NN(Original_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_body_code',COUNT(__d0(__NL(Original_Body_))),COUNT(__d0(__NN(Original_Body_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_body_desc',COUNT(__d0(__NL(Original_Body_Description_))),COUNT(__d0(__NN(Original_Body_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_net_weight',COUNT(__d0(__NL(Original_Net_Weight_))),COUNT(__d0(__NN(Original_Net_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_gross_weight',COUNT(__d0(__NL(Original_Gross_Weight_))),COUNT(__d0(__NN(Original_Gross_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_number_of_axles',COUNT(__d0(__NL(Original_Number_Axles_))),COUNT(__d0(__NN(Original_Number_Axles_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_vehicle_use_code',COUNT(__d0(__NL(Original_Vehicle_Use_))),COUNT(__d0(__NN(Original_Vehicle_Use_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_vehicle_use_desc',COUNT(__d0(__NL(Original_Vehicle_Use_Description_))),COUNT(__d0(__NN(Original_Vehicle_Use_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_vehicle_type_code',COUNT(__d0(__NL(Original_Vehicle_Type_))),COUNT(__d0(__NN(Original_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_vehicle_type_desc',COUNT(__d0(__NL(Original_Vehicle_Type_Description_))),COUNT(__d0(__NN(Original_Vehicle_Type_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_major_color_code',COUNT(__d0(__NL(Original_Major_Color_))),COUNT(__d0(__NN(Original_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_major_color_desc',COUNT(__d0(__NL(Original_Major_Color_Description_))),COUNT(__d0(__NN(Original_Major_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_minor_color_code',COUNT(__d0(__NL(Original_Minor_Color_))),COUNT(__d0(__NN(Original_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','orig_minor_color_desc',COUNT(__d0(__NL(Original_Minor_Color_Description_))),COUNT(__d0(__NN(Original_Minor_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vin',COUNT(__d0(__NL(Vina_Vin_))),COUNT(__d0(__NN(Vina_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vin_pattern_indicator',COUNT(__d0(__NL(Vina_Vin_Pattern_))),COUNT(__d0(__NN(Vina_Vin_Pattern_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_bypass_code',COUNT(__d0(__NL(Vina_Bypass_Code_))),COUNT(__d0(__NN(Vina_Bypass_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_veh_type',COUNT(__d0(__NL(Vina_Vehicle_Type_))),COUNT(__d0(__NN(Vina_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_ncic_make',COUNT(__d0(__NL(Vina_N_C_I_C_Make_))),COUNT(__d0(__NN(Vina_N_C_I_C_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_model_year_yy',COUNT(__d0(__NL(Vina_Model_Year_Y_Y_))),COUNT(__d0(__NN(Vina_Model_Year_Y_Y_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_restraint',COUNT(__d0(__NL(Vina_Restraint_))),COUNT(__d0(__NN(Vina_Restraint_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_abbrev_make_name',COUNT(__d0(__NL(Vina_Make_Name_))),COUNT(__d0(__NN(Vina_Make_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_year',COUNT(__d0(__NL(Vina_Year_))),COUNT(__d0(__NN(Vina_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_series',COUNT(__d0(__NL(Vina_Vp_Series_))),COUNT(__d0(__NN(Vina_Vp_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_model',COUNT(__d0(__NL(Vina_Vp_Model_))),COUNT(__d0(__NN(Vina_Vp_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_air_conditioning',COUNT(__d0(__NL(Vina_Air_Conditioning_))),COUNT(__d0(__NN(Vina_Air_Conditioning_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_power_steering',COUNT(__d0(__NL(Vina_Power_Steering_))),COUNT(__d0(__NN(Vina_Power_Steering_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_power_brakes',COUNT(__d0(__NL(Vina_Power_Brakes_))),COUNT(__d0(__NN(Vina_Power_Brakes_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_power_windows',COUNT(__d0(__NL(Vina_Power_Windows_))),COUNT(__d0(__NN(Vina_Power_Windows_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_tilt_wheel',COUNT(__d0(__NL(Vina_Tilt_Wheel_))),COUNT(__d0(__NN(Vina_Tilt_Wheel_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_roof',COUNT(__d0(__NL(Vina_Roof_))),COUNT(__d0(__NN(Vina_Roof_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_roof1',COUNT(__d0(__NL(Vina_Optional_Roof1_))),COUNT(__d0(__NN(Vina_Optional_Roof1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_roof2',COUNT(__d0(__NL(Vina_Optional_Roof2_))),COUNT(__d0(__NN(Vina_Optional_Roof2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_radio',COUNT(__d0(__NL(Vina_Radio_))),COUNT(__d0(__NN(Vina_Radio_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_radio1',COUNT(__d0(__NL(Vina_Optional_Radio1_))),COUNT(__d0(__NN(Vina_Optional_Radio1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_radio2',COUNT(__d0(__NL(Vina_Optional_Radio2_))),COUNT(__d0(__NN(Vina_Optional_Radio2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_transmission',COUNT(__d0(__NL(Vina_Transmission_))),COUNT(__d0(__NN(Vina_Transmission_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_transmission1',COUNT(__d0(__NL(Vina_Optional_Transmission1_))),COUNT(__d0(__NN(Vina_Optional_Transmission1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_optional_transmission2',COUNT(__d0(__NL(Vina_Optional_Transmission2_))),COUNT(__d0(__NN(Vina_Optional_Transmission2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_anti_lock_brakes',COUNT(__d0(__NL(Vina_A_L_B_))),COUNT(__d0(__NN(Vina_A_L_B_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_front_wheel_drive',COUNT(__d0(__NL(Vina_Front_W_D_))),COUNT(__d0(__NN(Vina_Front_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_four_wheel_drive',COUNT(__d0(__NL(Vina_Four_W_D_))),COUNT(__d0(__NN(Vina_Four_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_security_system',COUNT(__d0(__NL(Vina_Security_System_))),COUNT(__d0(__NN(Vina_Security_System_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_daytime_running_lights',COUNT(__d0(__NL(Vina_D_R_L_))),COUNT(__d0(__NN(Vina_D_R_L_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_vp_series_name',COUNT(__d0(__NL(Vina_Series_Name_))),COUNT(__d0(__NN(Vina_Series_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_model_year',COUNT(__d0(__NL(Vina_Model_Year_))),COUNT(__d0(__NN(Vina_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_series',COUNT(__d0(__NL(Vina_Series_))),COUNT(__d0(__NN(Vina_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_model',COUNT(__d0(__NL(Vina_Model_))),COUNT(__d0(__NN(Vina_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_body_style',COUNT(__d0(__NL(Vina_Body_Style_))),COUNT(__d0(__NN(Vina_Body_Style_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_make_desc',COUNT(__d0(__NL(Vina_Make_Description_))),COUNT(__d0(__NN(Vina_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_model_desc',COUNT(__d0(__NL(Vina_Model_Description_))),COUNT(__d0(__NN(Vina_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_series_desc',COUNT(__d0(__NL(Vina_Series_Description_))),COUNT(__d0(__NN(Vina_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_body_style_desc',COUNT(__d0(__NL(Vina_Body_Style_Description_))),COUNT(__d0(__NN(Vina_Body_Style_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_number_of_cylinders',COUNT(__d0(__NL(Vina_Cylinders_))),COUNT(__d0(__NN(Vina_Cylinders_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_engine_size',COUNT(__d0(__NL(Vina_Engine_Size_))),COUNT(__d0(__NN(Vina_Engine_Size_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_fuel_code',COUNT(__d0(__NL(Vina_Fuel_Code_))),COUNT(__d0(__NN(Vina_Fuel_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','vina_price',COUNT(__d0(__NL(Vina_Price_))),COUNT(__d0(__NN(Vina_Price_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_make_code',COUNT(__d0(__NL(Best_Make_Code_))),COUNT(__d0(__NN(Best_Make_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_series_code',COUNT(__d0(__NL(Best_Series_Code_))),COUNT(__d0(__NN(Best_Series_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_model_code',COUNT(__d0(__NL(Best_Model_Code_))),COUNT(__d0(__NN(Best_Model_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_body_code',COUNT(__d0(__NL(Best_Body_Code_))),COUNT(__d0(__NN(Best_Body_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_model_year',COUNT(__d0(__NL(Best_Model_Year_))),COUNT(__d0(__NN(Best_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_major_color_code',COUNT(__d0(__NL(Best_Major_Color_))),COUNT(__d0(__NN(Best_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','best_minor_color_code',COUNT(__d0(__NL(Best_Minor_Color_))),COUNT(__d0(__NN(Best_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','branded_title_flag',COUNT(__d0(__NL(Branded_Title_Flag_))),COUNT(__d0(__NN(Branded_Title_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_code_1',COUNT(__d0(__NL(Brand_Code1_))),COUNT(__d0(__NN(Brand_Code1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','cleaned_brand_date_1',COUNT(__d0(__NL(Brand_Date1_))),COUNT(__d0(__NN(Brand_Date1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_state_1',COUNT(__d0(__NL(Brand_State1_))),COUNT(__d0(__NN(Brand_State1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_code_2',COUNT(__d0(__NL(Brand_Code2_))),COUNT(__d0(__NN(Brand_Code2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','cleaned_brand_date_2',COUNT(__d0(__NL(Brand_Date2_))),COUNT(__d0(__NN(Brand_Date2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_state_2',COUNT(__d0(__NL(Brand_Sate2_))),COUNT(__d0(__NN(Brand_Sate2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_code_3',COUNT(__d0(__NL(Brand_Code3_))),COUNT(__d0(__NN(Brand_Code3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','cleaned_brand_date_3',COUNT(__d0(__NL(Brand_Date3_))),COUNT(__d0(__NN(Brand_Date3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_state_3',COUNT(__d0(__NL(Brand_Sate3_))),COUNT(__d0(__NN(Brand_Sate3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_code_4',COUNT(__d0(__NL(Brand_Code4_))),COUNT(__d0(__NN(Brand_Code4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','cleaned_brand_date_4',COUNT(__d0(__NL(Brand_Date4_))),COUNT(__d0(__NN(Brand_Date4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_state_4',COUNT(__d0(__NL(Brand_Sate4_))),COUNT(__d0(__NN(Brand_Sate4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_code_5',COUNT(__d0(__NL(Brand_Code5_))),COUNT(__d0(__NN(Brand_Code5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','cleaned_brand_date_5',COUNT(__d0(__NL(Brand_Date5_))),COUNT(__d0(__NN(Brand_Date5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','brand_state_5',COUNT(__d0(__NL(Brand_Sate5_))),COUNT(__d0(__NN(Brand_Sate5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','tod_flag',COUNT(__d0(__NL(Tod_Flag_))),COUNT(__d0(__NN(Tod_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','model_class_code',COUNT(__d0(__NL(Model_Class_Code_))),COUNT(__d0(__NN(Model_Class_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','model_class',COUNT(__d0(__NL(Model_Class_))),COUNT(__d0(__NN(Model_Class_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','min_door_count',COUNT(__d0(__NL(Min_Door_Count_))),COUNT(__d0(__NN(Min_Door_Count_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','safety_type',COUNT(__d0(__NL(Safety_Type_))),COUNT(__d0(__NN(Safety_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbag_driver',COUNT(__d0(__NL(Airbag_Driver_))),COUNT(__d0(__NN(Airbag_Driver_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbag_front_driver_side',COUNT(__d0(__NL(Airbag_Front_Driver_Side_))),COUNT(__d0(__NN(Airbag_Front_Driver_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbag_front_head_curtain',COUNT(__d0(__NL(Airbag_Front_Head_Curtain_))),COUNT(__d0(__NN(Airbag_Front_Head_Curtain_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbag_front_pass',COUNT(__d0(__NL(Airbag_Front_Passanger_))),COUNT(__d0(__NN(Airbag_Front_Passanger_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbag_front_pass_side',COUNT(__d0(__NL(Airbag_Front_Passanger_Side_))),COUNT(__d0(__NN(Airbag_Front_Passanger_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','airbags',COUNT(__d0(__NL(Airbags_))),COUNT(__d0(__NN(Airbags_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','state_origin',COUNT(__d0(__NL(State_Of_Origin_))),COUNT(__d0(__NN(State_Of_Origin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','LatestVehicleFlag',COUNT(__d0(__NL(Latest_Vehicle_Flag_))),COUNT(__d0(__NN(Latest_Vehicle_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','LatestVehicleIterationFlag',COUNT(__d0(__NL(Latest_Vehicle_Iteration_Flag_))),COUNT(__d0(__NN(Latest_Vehicle_Iteration_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','SourceFirstDate',COUNT(__d0(__NL(Source_First_Date_))),COUNT(__d0(__NN(Source_First_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','SourceLastDate',COUNT(__d0(__NL(Source_Last_Date_))),COUNT(__d0(__NN(Source_Last_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','StandardLienholderName',COUNT(__d0(__NL(Standard_Lienholder_Name_))),COUNT(__d0(__NN(Standard_Lienholder_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','source_code',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Main_Key','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','UID',COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_Party_Key_Invalid),COUNT(__d1)},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','vehicle_key',COUNT(__d1(__NL(Vehicle_Key_))),COUNT(__d1(__NN(Vehicle_Key_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalVin',COUNT(__d1(__NL(Original_Vin_))),COUNT(__d1(__NN(Original_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalYearMake',COUNT(__d1(__NL(Original_Year_Make_))),COUNT(__d1(__NN(Original_Year_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMake',COUNT(__d1(__NL(Original_Make_))),COUNT(__d1(__NN(Original_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMakeDescription',COUNT(__d1(__NL(Original_Make_Description_))),COUNT(__d1(__NN(Original_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalSeries',COUNT(__d1(__NL(Original_Series_))),COUNT(__d1(__NN(Original_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalSeriesDescription',COUNT(__d1(__NL(Original_Series_Description_))),COUNT(__d1(__NN(Original_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalModel',COUNT(__d1(__NL(Original_Model_))),COUNT(__d1(__NN(Original_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalModelDescription',COUNT(__d1(__NL(Original_Model_Description_))),COUNT(__d1(__NN(Original_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalBody',COUNT(__d1(__NL(Original_Body_))),COUNT(__d1(__NN(Original_Body_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalBodyDescription',COUNT(__d1(__NL(Original_Body_Description_))),COUNT(__d1(__NN(Original_Body_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalNetWeight',COUNT(__d1(__NL(Original_Net_Weight_))),COUNT(__d1(__NN(Original_Net_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalGrossWeight',COUNT(__d1(__NL(Original_Gross_Weight_))),COUNT(__d1(__NN(Original_Gross_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalNumberAxles',COUNT(__d1(__NL(Original_Number_Axles_))),COUNT(__d1(__NN(Original_Number_Axles_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalVehicleUse',COUNT(__d1(__NL(Original_Vehicle_Use_))),COUNT(__d1(__NN(Original_Vehicle_Use_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalVehicleUseDescription',COUNT(__d1(__NL(Original_Vehicle_Use_Description_))),COUNT(__d1(__NN(Original_Vehicle_Use_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalVehicleType',COUNT(__d1(__NL(Original_Vehicle_Type_))),COUNT(__d1(__NN(Original_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalVehicleTypeDescription',COUNT(__d1(__NL(Original_Vehicle_Type_Description_))),COUNT(__d1(__NN(Original_Vehicle_Type_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMajorColor',COUNT(__d1(__NL(Original_Major_Color_))),COUNT(__d1(__NN(Original_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMajorColorDescription',COUNT(__d1(__NL(Original_Major_Color_Description_))),COUNT(__d1(__NN(Original_Major_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMinorColor',COUNT(__d1(__NL(Original_Minor_Color_))),COUNT(__d1(__NN(Original_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','OriginalMinorColorDescription',COUNT(__d1(__NL(Original_Minor_Color_Description_))),COUNT(__d1(__NN(Original_Minor_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaVin',COUNT(__d1(__NL(Vina_Vin_))),COUNT(__d1(__NN(Vina_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaVinPattern',COUNT(__d1(__NL(Vina_Vin_Pattern_))),COUNT(__d1(__NN(Vina_Vin_Pattern_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaBypassCode',COUNT(__d1(__NL(Vina_Bypass_Code_))),COUNT(__d1(__NN(Vina_Bypass_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaVehicleType',COUNT(__d1(__NL(Vina_Vehicle_Type_))),COUNT(__d1(__NN(Vina_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaNCICMake',COUNT(__d1(__NL(Vina_N_C_I_C_Make_))),COUNT(__d1(__NN(Vina_N_C_I_C_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaModelYearYY',COUNT(__d1(__NL(Vina_Model_Year_Y_Y_))),COUNT(__d1(__NN(Vina_Model_Year_Y_Y_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaRestraint',COUNT(__d1(__NL(Vina_Restraint_))),COUNT(__d1(__NN(Vina_Restraint_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaMakeName',COUNT(__d1(__NL(Vina_Make_Name_))),COUNT(__d1(__NN(Vina_Make_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaYear',COUNT(__d1(__NL(Vina_Year_))),COUNT(__d1(__NN(Vina_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaVpSeries',COUNT(__d1(__NL(Vina_Vp_Series_))),COUNT(__d1(__NN(Vina_Vp_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaVpModel',COUNT(__d1(__NL(Vina_Vp_Model_))),COUNT(__d1(__NN(Vina_Vp_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaAirConditioning',COUNT(__d1(__NL(Vina_Air_Conditioning_))),COUNT(__d1(__NN(Vina_Air_Conditioning_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaPowerSteering',COUNT(__d1(__NL(Vina_Power_Steering_))),COUNT(__d1(__NN(Vina_Power_Steering_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaPowerBrakes',COUNT(__d1(__NL(Vina_Power_Brakes_))),COUNT(__d1(__NN(Vina_Power_Brakes_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaPowerWindows',COUNT(__d1(__NL(Vina_Power_Windows_))),COUNT(__d1(__NN(Vina_Power_Windows_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaTiltWheel',COUNT(__d1(__NL(Vina_Tilt_Wheel_))),COUNT(__d1(__NN(Vina_Tilt_Wheel_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaRoof',COUNT(__d1(__NL(Vina_Roof_))),COUNT(__d1(__NN(Vina_Roof_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalRoof1',COUNT(__d1(__NL(Vina_Optional_Roof1_))),COUNT(__d1(__NN(Vina_Optional_Roof1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalRoof2',COUNT(__d1(__NL(Vina_Optional_Roof2_))),COUNT(__d1(__NN(Vina_Optional_Roof2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaRadio',COUNT(__d1(__NL(Vina_Radio_))),COUNT(__d1(__NN(Vina_Radio_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalRadio1',COUNT(__d1(__NL(Vina_Optional_Radio1_))),COUNT(__d1(__NN(Vina_Optional_Radio1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalRadio2',COUNT(__d1(__NL(Vina_Optional_Radio2_))),COUNT(__d1(__NN(Vina_Optional_Radio2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaTransmission',COUNT(__d1(__NL(Vina_Transmission_))),COUNT(__d1(__NN(Vina_Transmission_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalTransmission1',COUNT(__d1(__NL(Vina_Optional_Transmission1_))),COUNT(__d1(__NN(Vina_Optional_Transmission1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaOptionalTransmission2',COUNT(__d1(__NL(Vina_Optional_Transmission2_))),COUNT(__d1(__NN(Vina_Optional_Transmission2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaALB',COUNT(__d1(__NL(Vina_A_L_B_))),COUNT(__d1(__NN(Vina_A_L_B_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaFrontWD',COUNT(__d1(__NL(Vina_Front_W_D_))),COUNT(__d1(__NN(Vina_Front_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaFourWD',COUNT(__d1(__NL(Vina_Four_W_D_))),COUNT(__d1(__NN(Vina_Four_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaSecuritySystem',COUNT(__d1(__NL(Vina_Security_System_))),COUNT(__d1(__NN(Vina_Security_System_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaDRL',COUNT(__d1(__NL(Vina_D_R_L_))),COUNT(__d1(__NN(Vina_D_R_L_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaSeriesName',COUNT(__d1(__NL(Vina_Series_Name_))),COUNT(__d1(__NN(Vina_Series_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaModelYear',COUNT(__d1(__NL(Vina_Model_Year_))),COUNT(__d1(__NN(Vina_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaSeries',COUNT(__d1(__NL(Vina_Series_))),COUNT(__d1(__NN(Vina_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaModel',COUNT(__d1(__NL(Vina_Model_))),COUNT(__d1(__NN(Vina_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaBodyStyle',COUNT(__d1(__NL(Vina_Body_Style_))),COUNT(__d1(__NN(Vina_Body_Style_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaMakeDescription',COUNT(__d1(__NL(Vina_Make_Description_))),COUNT(__d1(__NN(Vina_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaModelDescription',COUNT(__d1(__NL(Vina_Model_Description_))),COUNT(__d1(__NN(Vina_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaSeriesDescription',COUNT(__d1(__NL(Vina_Series_Description_))),COUNT(__d1(__NN(Vina_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaBodyStyleDescription',COUNT(__d1(__NL(Vina_Body_Style_Description_))),COUNT(__d1(__NN(Vina_Body_Style_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaCylinders',COUNT(__d1(__NL(Vina_Cylinders_))),COUNT(__d1(__NN(Vina_Cylinders_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaEngineSize',COUNT(__d1(__NL(Vina_Engine_Size_))),COUNT(__d1(__NN(Vina_Engine_Size_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaFuelCode',COUNT(__d1(__NL(Vina_Fuel_Code_))),COUNT(__d1(__NN(Vina_Fuel_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','VinaPrice',COUNT(__d1(__NL(Vina_Price_))),COUNT(__d1(__NN(Vina_Price_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestMakeCode',COUNT(__d1(__NL(Best_Make_Code_))),COUNT(__d1(__NN(Best_Make_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestSeriesCode',COUNT(__d1(__NL(Best_Series_Code_))),COUNT(__d1(__NN(Best_Series_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestModelCode',COUNT(__d1(__NL(Best_Model_Code_))),COUNT(__d1(__NN(Best_Model_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestBodyCode',COUNT(__d1(__NL(Best_Body_Code_))),COUNT(__d1(__NN(Best_Body_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestModelYear',COUNT(__d1(__NL(Best_Model_Year_))),COUNT(__d1(__NN(Best_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestMajorColor',COUNT(__d1(__NL(Best_Major_Color_))),COUNT(__d1(__NN(Best_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BestMinorColor',COUNT(__d1(__NL(Best_Minor_Color_))),COUNT(__d1(__NN(Best_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandedTitleFlag',COUNT(__d1(__NL(Branded_Title_Flag_))),COUNT(__d1(__NN(Branded_Title_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandCode1',COUNT(__d1(__NL(Brand_Code1_))),COUNT(__d1(__NN(Brand_Code1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandDate1',COUNT(__d1(__NL(Brand_Date1_))),COUNT(__d1(__NN(Brand_Date1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandState1',COUNT(__d1(__NL(Brand_State1_))),COUNT(__d1(__NN(Brand_State1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandCode2',COUNT(__d1(__NL(Brand_Code2_))),COUNT(__d1(__NN(Brand_Code2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandDate2',COUNT(__d1(__NL(Brand_Date2_))),COUNT(__d1(__NN(Brand_Date2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandSate2',COUNT(__d1(__NL(Brand_Sate2_))),COUNT(__d1(__NN(Brand_Sate2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandCode3',COUNT(__d1(__NL(Brand_Code3_))),COUNT(__d1(__NN(Brand_Code3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandDate3',COUNT(__d1(__NL(Brand_Date3_))),COUNT(__d1(__NN(Brand_Date3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandSate3',COUNT(__d1(__NL(Brand_Sate3_))),COUNT(__d1(__NN(Brand_Sate3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandCode4',COUNT(__d1(__NL(Brand_Code4_))),COUNT(__d1(__NN(Brand_Code4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandDate4',COUNT(__d1(__NL(Brand_Date4_))),COUNT(__d1(__NN(Brand_Date4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandSate4',COUNT(__d1(__NL(Brand_Sate4_))),COUNT(__d1(__NN(Brand_Sate4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandCode5',COUNT(__d1(__NL(Brand_Code5_))),COUNT(__d1(__NN(Brand_Code5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandDate5',COUNT(__d1(__NL(Brand_Date5_))),COUNT(__d1(__NN(Brand_Date5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','BrandSate5',COUNT(__d1(__NL(Brand_Sate5_))),COUNT(__d1(__NN(Brand_Sate5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','TodFlag',COUNT(__d1(__NL(Tod_Flag_))),COUNT(__d1(__NN(Tod_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','ModelClassCode',COUNT(__d1(__NL(Model_Class_Code_))),COUNT(__d1(__NN(Model_Class_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','ModelClass',COUNT(__d1(__NL(Model_Class_))),COUNT(__d1(__NN(Model_Class_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','MinDoorCount',COUNT(__d1(__NL(Min_Door_Count_))),COUNT(__d1(__NN(Min_Door_Count_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','SafetyType',COUNT(__d1(__NL(Safety_Type_))),COUNT(__d1(__NN(Safety_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','AirbagDriver',COUNT(__d1(__NL(Airbag_Driver_))),COUNT(__d1(__NN(Airbag_Driver_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','AirbagFrontDriverSide',COUNT(__d1(__NL(Airbag_Front_Driver_Side_))),COUNT(__d1(__NN(Airbag_Front_Driver_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','AirbagFrontHeadCurtain',COUNT(__d1(__NL(Airbag_Front_Head_Curtain_))),COUNT(__d1(__NN(Airbag_Front_Head_Curtain_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','AirbagFrontPassanger',COUNT(__d1(__NL(Airbag_Front_Passanger_))),COUNT(__d1(__NN(Airbag_Front_Passanger_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','AirbagFrontPassangerSide',COUNT(__d1(__NL(Airbag_Front_Passanger_Side_))),COUNT(__d1(__NN(Airbag_Front_Passanger_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','Airbags',COUNT(__d1(__NL(Airbags_))),COUNT(__d1(__NN(Airbags_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','state_origin',COUNT(__d1(__NL(State_Of_Origin_))),COUNT(__d1(__NN(State_Of_Origin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','latest_vehicle_flag',COUNT(__d1(__NL(Latest_Vehicle_Flag_))),COUNT(__d1(__NN(Latest_Vehicle_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','latest_vehicle_iteration_flag',COUNT(__d1(__NL(Latest_Vehicle_Iteration_Flag_))),COUNT(__d1(__NN(Latest_Vehicle_Iteration_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','date_vendor_first_reported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','date_vendor_last_reported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','src_first_date',COUNT(__d1(__NL(Source_First_Date_))),COUNT(__d1(__NN(Source_First_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','src_last_date',COUNT(__d1(__NL(Source_Last_Date_))),COUNT(__d1(__NN(Source_Last_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','std_lienholder_name',COUNT(__d1(__NL(Standard_Lienholder_Name_))),COUNT(__d1(__NN(Standard_Lienholder_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','source_code',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_Party_Key','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','UID',COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_VehicleV2__Key_Vehicle_linkids_Invalid),COUNT(__d2)},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','vehicle_key',COUNT(__d2(__NL(Vehicle_Key_))),COUNT(__d2(__NN(Vehicle_Key_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalVin',COUNT(__d2(__NL(Original_Vin_))),COUNT(__d2(__NN(Original_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalYearMake',COUNT(__d2(__NL(Original_Year_Make_))),COUNT(__d2(__NN(Original_Year_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMake',COUNT(__d2(__NL(Original_Make_))),COUNT(__d2(__NN(Original_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMakeDescription',COUNT(__d2(__NL(Original_Make_Description_))),COUNT(__d2(__NN(Original_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalSeries',COUNT(__d2(__NL(Original_Series_))),COUNT(__d2(__NN(Original_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalSeriesDescription',COUNT(__d2(__NL(Original_Series_Description_))),COUNT(__d2(__NN(Original_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalModel',COUNT(__d2(__NL(Original_Model_))),COUNT(__d2(__NN(Original_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalModelDescription',COUNT(__d2(__NL(Original_Model_Description_))),COUNT(__d2(__NN(Original_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalBody',COUNT(__d2(__NL(Original_Body_))),COUNT(__d2(__NN(Original_Body_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalBodyDescription',COUNT(__d2(__NL(Original_Body_Description_))),COUNT(__d2(__NN(Original_Body_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalNetWeight',COUNT(__d2(__NL(Original_Net_Weight_))),COUNT(__d2(__NN(Original_Net_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalGrossWeight',COUNT(__d2(__NL(Original_Gross_Weight_))),COUNT(__d2(__NN(Original_Gross_Weight_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalNumberAxles',COUNT(__d2(__NL(Original_Number_Axles_))),COUNT(__d2(__NN(Original_Number_Axles_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalVehicleUse',COUNT(__d2(__NL(Original_Vehicle_Use_))),COUNT(__d2(__NN(Original_Vehicle_Use_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalVehicleUseDescription',COUNT(__d2(__NL(Original_Vehicle_Use_Description_))),COUNT(__d2(__NN(Original_Vehicle_Use_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalVehicleType',COUNT(__d2(__NL(Original_Vehicle_Type_))),COUNT(__d2(__NN(Original_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalVehicleTypeDescription',COUNT(__d2(__NL(Original_Vehicle_Type_Description_))),COUNT(__d2(__NN(Original_Vehicle_Type_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMajorColor',COUNT(__d2(__NL(Original_Major_Color_))),COUNT(__d2(__NN(Original_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMajorColorDescription',COUNT(__d2(__NL(Original_Major_Color_Description_))),COUNT(__d2(__NN(Original_Major_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMinorColor',COUNT(__d2(__NL(Original_Minor_Color_))),COUNT(__d2(__NN(Original_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','OriginalMinorColorDescription',COUNT(__d2(__NL(Original_Minor_Color_Description_))),COUNT(__d2(__NN(Original_Minor_Color_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaVin',COUNT(__d2(__NL(Vina_Vin_))),COUNT(__d2(__NN(Vina_Vin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaVinPattern',COUNT(__d2(__NL(Vina_Vin_Pattern_))),COUNT(__d2(__NN(Vina_Vin_Pattern_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaBypassCode',COUNT(__d2(__NL(Vina_Bypass_Code_))),COUNT(__d2(__NN(Vina_Bypass_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaVehicleType',COUNT(__d2(__NL(Vina_Vehicle_Type_))),COUNT(__d2(__NN(Vina_Vehicle_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaNCICMake',COUNT(__d2(__NL(Vina_N_C_I_C_Make_))),COUNT(__d2(__NN(Vina_N_C_I_C_Make_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaModelYearYY',COUNT(__d2(__NL(Vina_Model_Year_Y_Y_))),COUNT(__d2(__NN(Vina_Model_Year_Y_Y_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaRestraint',COUNT(__d2(__NL(Vina_Restraint_))),COUNT(__d2(__NN(Vina_Restraint_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaMakeName',COUNT(__d2(__NL(Vina_Make_Name_))),COUNT(__d2(__NN(Vina_Make_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaYear',COUNT(__d2(__NL(Vina_Year_))),COUNT(__d2(__NN(Vina_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaVpSeries',COUNT(__d2(__NL(Vina_Vp_Series_))),COUNT(__d2(__NN(Vina_Vp_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaVpModel',COUNT(__d2(__NL(Vina_Vp_Model_))),COUNT(__d2(__NN(Vina_Vp_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaAirConditioning',COUNT(__d2(__NL(Vina_Air_Conditioning_))),COUNT(__d2(__NN(Vina_Air_Conditioning_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaPowerSteering',COUNT(__d2(__NL(Vina_Power_Steering_))),COUNT(__d2(__NN(Vina_Power_Steering_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaPowerBrakes',COUNT(__d2(__NL(Vina_Power_Brakes_))),COUNT(__d2(__NN(Vina_Power_Brakes_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaPowerWindows',COUNT(__d2(__NL(Vina_Power_Windows_))),COUNT(__d2(__NN(Vina_Power_Windows_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaTiltWheel',COUNT(__d2(__NL(Vina_Tilt_Wheel_))),COUNT(__d2(__NN(Vina_Tilt_Wheel_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaRoof',COUNT(__d2(__NL(Vina_Roof_))),COUNT(__d2(__NN(Vina_Roof_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalRoof1',COUNT(__d2(__NL(Vina_Optional_Roof1_))),COUNT(__d2(__NN(Vina_Optional_Roof1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalRoof2',COUNT(__d2(__NL(Vina_Optional_Roof2_))),COUNT(__d2(__NN(Vina_Optional_Roof2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaRadio',COUNT(__d2(__NL(Vina_Radio_))),COUNT(__d2(__NN(Vina_Radio_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalRadio1',COUNT(__d2(__NL(Vina_Optional_Radio1_))),COUNT(__d2(__NN(Vina_Optional_Radio1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalRadio2',COUNT(__d2(__NL(Vina_Optional_Radio2_))),COUNT(__d2(__NN(Vina_Optional_Radio2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaTransmission',COUNT(__d2(__NL(Vina_Transmission_))),COUNT(__d2(__NN(Vina_Transmission_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalTransmission1',COUNT(__d2(__NL(Vina_Optional_Transmission1_))),COUNT(__d2(__NN(Vina_Optional_Transmission1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaOptionalTransmission2',COUNT(__d2(__NL(Vina_Optional_Transmission2_))),COUNT(__d2(__NN(Vina_Optional_Transmission2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaALB',COUNT(__d2(__NL(Vina_A_L_B_))),COUNT(__d2(__NN(Vina_A_L_B_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaFrontWD',COUNT(__d2(__NL(Vina_Front_W_D_))),COUNT(__d2(__NN(Vina_Front_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaFourWD',COUNT(__d2(__NL(Vina_Four_W_D_))),COUNT(__d2(__NN(Vina_Four_W_D_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaSecuritySystem',COUNT(__d2(__NL(Vina_Security_System_))),COUNT(__d2(__NN(Vina_Security_System_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaDRL',COUNT(__d2(__NL(Vina_D_R_L_))),COUNT(__d2(__NN(Vina_D_R_L_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaSeriesName',COUNT(__d2(__NL(Vina_Series_Name_))),COUNT(__d2(__NN(Vina_Series_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaModelYear',COUNT(__d2(__NL(Vina_Model_Year_))),COUNT(__d2(__NN(Vina_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaSeries',COUNT(__d2(__NL(Vina_Series_))),COUNT(__d2(__NN(Vina_Series_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaModel',COUNT(__d2(__NL(Vina_Model_))),COUNT(__d2(__NN(Vina_Model_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaBodyStyle',COUNT(__d2(__NL(Vina_Body_Style_))),COUNT(__d2(__NN(Vina_Body_Style_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaMakeDescription',COUNT(__d2(__NL(Vina_Make_Description_))),COUNT(__d2(__NN(Vina_Make_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaModelDescription',COUNT(__d2(__NL(Vina_Model_Description_))),COUNT(__d2(__NN(Vina_Model_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaSeriesDescription',COUNT(__d2(__NL(Vina_Series_Description_))),COUNT(__d2(__NN(Vina_Series_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaBodyStyleDescription',COUNT(__d2(__NL(Vina_Body_Style_Description_))),COUNT(__d2(__NN(Vina_Body_Style_Description_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaCylinders',COUNT(__d2(__NL(Vina_Cylinders_))),COUNT(__d2(__NN(Vina_Cylinders_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaEngineSize',COUNT(__d2(__NL(Vina_Engine_Size_))),COUNT(__d2(__NN(Vina_Engine_Size_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaFuelCode',COUNT(__d2(__NL(Vina_Fuel_Code_))),COUNT(__d2(__NN(Vina_Fuel_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','VinaPrice',COUNT(__d2(__NL(Vina_Price_))),COUNT(__d2(__NN(Vina_Price_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestMakeCode',COUNT(__d2(__NL(Best_Make_Code_))),COUNT(__d2(__NN(Best_Make_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestSeriesCode',COUNT(__d2(__NL(Best_Series_Code_))),COUNT(__d2(__NN(Best_Series_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestModelCode',COUNT(__d2(__NL(Best_Model_Code_))),COUNT(__d2(__NN(Best_Model_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestBodyCode',COUNT(__d2(__NL(Best_Body_Code_))),COUNT(__d2(__NN(Best_Body_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestModelYear',COUNT(__d2(__NL(Best_Model_Year_))),COUNT(__d2(__NN(Best_Model_Year_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestMajorColor',COUNT(__d2(__NL(Best_Major_Color_))),COUNT(__d2(__NN(Best_Major_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BestMinorColor',COUNT(__d2(__NL(Best_Minor_Color_))),COUNT(__d2(__NN(Best_Minor_Color_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandedTitleFlag',COUNT(__d2(__NL(Branded_Title_Flag_))),COUNT(__d2(__NN(Branded_Title_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandCode1',COUNT(__d2(__NL(Brand_Code1_))),COUNT(__d2(__NN(Brand_Code1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandDate1',COUNT(__d2(__NL(Brand_Date1_))),COUNT(__d2(__NN(Brand_Date1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandState1',COUNT(__d2(__NL(Brand_State1_))),COUNT(__d2(__NN(Brand_State1_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandCode2',COUNT(__d2(__NL(Brand_Code2_))),COUNT(__d2(__NN(Brand_Code2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandDate2',COUNT(__d2(__NL(Brand_Date2_))),COUNT(__d2(__NN(Brand_Date2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandSate2',COUNT(__d2(__NL(Brand_Sate2_))),COUNT(__d2(__NN(Brand_Sate2_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandCode3',COUNT(__d2(__NL(Brand_Code3_))),COUNT(__d2(__NN(Brand_Code3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandDate3',COUNT(__d2(__NL(Brand_Date3_))),COUNT(__d2(__NN(Brand_Date3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandSate3',COUNT(__d2(__NL(Brand_Sate3_))),COUNT(__d2(__NN(Brand_Sate3_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandCode4',COUNT(__d2(__NL(Brand_Code4_))),COUNT(__d2(__NN(Brand_Code4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandDate4',COUNT(__d2(__NL(Brand_Date4_))),COUNT(__d2(__NN(Brand_Date4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandSate4',COUNT(__d2(__NL(Brand_Sate4_))),COUNT(__d2(__NN(Brand_Sate4_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandCode5',COUNT(__d2(__NL(Brand_Code5_))),COUNT(__d2(__NN(Brand_Code5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandDate5',COUNT(__d2(__NL(Brand_Date5_))),COUNT(__d2(__NN(Brand_Date5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','BrandSate5',COUNT(__d2(__NL(Brand_Sate5_))),COUNT(__d2(__NN(Brand_Sate5_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','TodFlag',COUNT(__d2(__NL(Tod_Flag_))),COUNT(__d2(__NN(Tod_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','ModelClassCode',COUNT(__d2(__NL(Model_Class_Code_))),COUNT(__d2(__NN(Model_Class_Code_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','ModelClass',COUNT(__d2(__NL(Model_Class_))),COUNT(__d2(__NN(Model_Class_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','MinDoorCount',COUNT(__d2(__NL(Min_Door_Count_))),COUNT(__d2(__NN(Min_Door_Count_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','SafetyType',COUNT(__d2(__NL(Safety_Type_))),COUNT(__d2(__NN(Safety_Type_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','AirbagDriver',COUNT(__d2(__NL(Airbag_Driver_))),COUNT(__d2(__NN(Airbag_Driver_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','AirbagFrontDriverSide',COUNT(__d2(__NL(Airbag_Front_Driver_Side_))),COUNT(__d2(__NN(Airbag_Front_Driver_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','AirbagFrontHeadCurtain',COUNT(__d2(__NL(Airbag_Front_Head_Curtain_))),COUNT(__d2(__NN(Airbag_Front_Head_Curtain_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','AirbagFrontPassanger',COUNT(__d2(__NL(Airbag_Front_Passanger_))),COUNT(__d2(__NN(Airbag_Front_Passanger_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','AirbagFrontPassangerSide',COUNT(__d2(__NL(Airbag_Front_Passanger_Side_))),COUNT(__d2(__NN(Airbag_Front_Passanger_Side_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','Airbags',COUNT(__d2(__NL(Airbags_))),COUNT(__d2(__NN(Airbags_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','state_origin',COUNT(__d2(__NL(State_Of_Origin_))),COUNT(__d2(__NN(State_Of_Origin_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','latest_vehicle_flag',COUNT(__d2(__NL(Latest_Vehicle_Flag_))),COUNT(__d2(__NN(Latest_Vehicle_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','latest_vehicle_iteration_flag',COUNT(__d2(__NL(Latest_Vehicle_Iteration_Flag_))),COUNT(__d2(__NN(Latest_Vehicle_Iteration_Flag_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','date_vendor_first_reported',COUNT(__d2(__NL(Date_Vendor_First_Reported_))),COUNT(__d2(__NN(Date_Vendor_First_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','date_vendor_last_reported',COUNT(__d2(__NL(Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(Date_Vendor_Last_Reported_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','SourceFirstDate',COUNT(__d2(__NL(Source_First_Date_))),COUNT(__d2(__NN(Source_First_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','SourceLastDate',COUNT(__d2(__NL(Source_Last_Date_))),COUNT(__d2(__NN(Source_Last_Date_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','StandardLienholderName',COUNT(__d2(__NL(Standard_Lienholder_Name_))),COUNT(__d2(__NN(Standard_Lienholder_Name_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','source_code',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Vehicle','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.VehicleV2__Key_Vehicle_linkids','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
