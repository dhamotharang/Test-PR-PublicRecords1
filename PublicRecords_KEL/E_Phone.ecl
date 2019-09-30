//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nbool Is_Phone_Marketable_;
    KEL.typ.nint Phone_Marketability_Score_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phone10(DEFAULT:UID|DEFAULT:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Fraudpoint3__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Fraudpoint3__Key_Address),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid := __d2_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'person_q.personal_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)person_q.personal_phone > 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_1_Invalid := __d3_KELfiltered((KEL.typ.uid)person_q.personal_phone = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)person_q.personal_phone <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'person_q.work_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm(person_q.work_phone <> '');
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_2_Invalid := __d4_KELfiltered((KEL.typ.uid)person_q.work_phone = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)person_q.work_phone <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_Address),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid := __d5_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid := __d6_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'clean_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),email_src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_DX_Email__Key_Email_Payload,TRANSFORM(RECORDOF(__in.Dataset_DX_Email__Key_Email_Payload),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)clean_phone > 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid := __d7_KELfiltered((KEL.typ.uid)clean_phone = 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered((KEL.typ.uid)clean_phone <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping8 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(OVERRIDE:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),source(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)phone10 <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_YellowPages__kfetch_yellowpages_linkids_Invalid := __d8_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping9 := 'efx_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),efx_mrkt_telever(OVERRIDE:Is_Phone_Marketable_),efx_mrkt_telescore(OVERRIDE:Phone_Marketability_Score_:0),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),source(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)efx_phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid := __d9_KELfiltered((KEL.typ.uid)efx_phone = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)efx_phone <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping10 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_DID,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_DID),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_DID_Invalid := __d10_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping11 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Address,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Address),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Address_Invalid := __d11_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d11_Prefiltered := __d11_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping12 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid := __d12_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping13 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'|OVERRIDE:Current_Flag_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),listing_type_bus(OVERRIDE:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid := __d13_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d13_Prefiltered := __d13_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping14 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),no_solicitation_code(OVERRIDE:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phone_type(OVERRIDE:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validation_date(OVERRIDE:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_14Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_14Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Address),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Address_Invalid := __d14_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d14_Prefiltered := __d14_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping15 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),no_solicitation_code(OVERRIDE:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phone_type(OVERRIDE:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validation_date(OVERRIDE:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_15Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_15Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid := __d15_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d15_Prefiltered := __d15_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d15 := __SourceFilter(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_16Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_16Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping16 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_16Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_16Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d16_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d16_KELfiltered := __d16_Norm((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid := __d16_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d16_Prefiltered := __d16_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d16 := __SourceFilter(KEL.FromFlat.Convert(__d16_Prefiltered,InLayout,__Mapping16,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_17Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_17Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping17 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_17Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_17Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d17_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d17_KELfiltered := __d17_Norm((UNSIGNED)cellphone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid := __d17_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d17_Prefiltered := __d17_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d17 := __SourceFilter(KEL.FromFlat.Convert(__d17_Prefiltered,InLayout,__Mapping17,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_18Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_18Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping18 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_18Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_18Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d18_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address),SELF:=RIGHT));
  EXPORT __d18_KELfiltered := __d18_Norm((UNSIGNED)cellphone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address_Invalid := __d18_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d18_Prefiltered := __d18_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d18 := __SourceFilter(KEL.FromFlat.Convert(__d18_Prefiltered,InLayout,__Mapping18,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_19Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_19Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping19 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),file_source(OVERRIDE:Source_File_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_19Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_19Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d19_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Phone),SELF:=RIGHT));
  EXPORT __d19_KELfiltered := __d19_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid := __d19_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d19_Prefiltered := __d19_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d19 := __SourceFilter(KEL.FromFlat.Convert(__d19_Prefiltered,InLayout,__Mapping19,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_20Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_20Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping20 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),file_source(OVERRIDE:Source_File_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_20Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_20Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d20_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Did_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Did_Phone),SELF:=RIGHT));
  EXPORT __d20_KELfiltered := __d20_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Did_Phone_Invalid := __d20_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d20_Prefiltered := __d20_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d20 := __SourceFilter(KEL.FromFlat.Convert(__d20_Prefiltered,InLayout,__Mapping20,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping21 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d21_Norm := NORMALIZE(__in,LEFT.Dataset_Key_CellPhone__Key_Neustar_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_CellPhone__Key_Neustar_Phone),SELF:=RIGHT));
  EXPORT __d21_KELfiltered := __d21_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid := __d21_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d21_Prefiltered := __d21_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d21 := __SourceFilter(KEL.FromFlat.Convert(__d21_Prefiltered,InLayout,__Mapping21,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_22Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_22Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping22 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),orig_publish_code(OVERRIDE:Publish_Code_:\'\'),append_portability_indicator(OVERRIDE:Portability_Indicator_:0),append_nxx_type(OVERRIDE:N_X_X_Type_:0),append_coctype(OVERRIDE:C_O_C_Type_:\'\'),append_scc(OVERRIDE:S_C_C_:\'\'),append_ported_match(OVERRIDE:Ported_Match_:0),append_phone_use(OVERRIDE:Phone_Use_:\'\'),append_company_type(OVERRIDE:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),append_ocn(OVERRIDE:Carrier_Name_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),max_orig_conf_score(OVERRIDE:Maximum_Confidence_Score_:0),min_orig_conf_score(OVERRIDE:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),orig_rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),append_phone_type(OVERRIDE:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_22Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_22Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d22_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d22_KELfiltered := __d22_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid := __d22_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d22_Prefiltered := __d22_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d22 := __SourceFilter(KEL.FromFlat.Convert(__d22_Prefiltered,InLayout,__Mapping22,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15 + __d16 + __d17 + __d18 + __d19 + __d20 + __d21 + __d22;
  EXPORT Header_Phone_Quality_Layout := RECORD
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Prior_Area_Codes_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Active_Layout := RECORD
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Confidence_Scores_Layout := RECORD
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Listing_Types_Layout := RECORD
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Types_Layout := RECORD
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Marketability_Layout := RECORD
    KEL.typ.nbool Is_Phone_Marketable_;
    KEL.typ.nint Phone_Marketability_Score_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Types_Layout := RECORD
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.ndataset(Header_Phone_Quality_Layout) Header_Phone_Quality_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.ndataset(Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(Active_Layout) Active_;
    KEL.typ.ndataset(Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(Marketability_Layout) Marketability_;
    KEL.typ.ndataset(Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Portability_Indicator_ := KEL.Intake.SingleValue(__recs,Portability_Indicator_);
    SELF.Current_Flag_ := KEL.Intake.SingleValue(__recs,Current_Flag_);
    SELF.Business_Flag_ := KEL.Intake.SingleValue(__recs,Business_Flag_);
    SELF.N_X_X_Type_ := KEL.Intake.SingleValue(__recs,N_X_X_Type_);
    SELF.Publish_Code_ := KEL.Intake.SingleValue(__recs,Publish_Code_);
    SELF.C_O_C_Type_ := KEL.Intake.SingleValue(__recs,C_O_C_Type_);
    SELF.S_C_C_ := KEL.Intake.SingleValue(__recs,S_C_C_);
    SELF.Phone_Number_Company_Type_ := KEL.Intake.SingleValue(__recs,Phone_Number_Company_Type_);
    SELF.Ported_Match_ := KEL.Intake.SingleValue(__recs,Ported_Match_);
    SELF.Phone_Use_ := KEL.Intake.SingleValue(__recs,Phone_Use_);
    SELF.No_Solicit_Code_ := KEL.Intake.SingleValue(__recs,No_Solicit_Code_);
    SELF.Omit_Indicator_ := KEL.Intake.SingleValue(__recs,Omit_Indicator_);
    SELF.Header_Phone_Quality_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Phone_Quality_,T_N_T_},Phone_Quality_,T_N_T_),Header_Phone_Quality_Layout)(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Source_File_ := KEL.Intake.SingleValue(__recs,Source_File_);
    SELF.Iver_Indicator_ := KEL.Intake.SingleValue(__recs,Iver_Indicator_);
    SELF.Validation_Flag_ := KEL.Intake.SingleValue(__recs,Validation_Flag_);
    SELF.Validation_Date_ := KEL.Intake.SingleValue(__recs,Validation_Date_);
    SELF.Carrier_Name_ := KEL.Intake.SingleValue(__recs,Carrier_Name_);
    SELF.Prior_Area_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Prior_Area_Code_},Prior_Area_Code_),Prior_Area_Codes_Layout)(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Is_Active_,Source_},Is_Active_,Source_),Active_Layout)(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_},Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_),Confidence_Scores_Layout)(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Listing_Type_,Source_},Listing_Type_,Source_),Listing_Types_Layout)(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Phone_Type_,Source_},Phone_Type_,Source_),Phone_Types_Layout)(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Marketability_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Is_Phone_Marketable_,Phone_Marketability_Score_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_},Is_Phone_Marketable_,Phone_Marketability_Score_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_),Marketability_Layout)(__NN(Is_Phone_Marketable_) OR __NN(Phone_Marketability_Score_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Record_Type_,Source_},Record_Type_,Source_),Record_Types_Layout)(__NN(Record_Type_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Header_Phone_Quality_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Header_Phone_Quality_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Prior_Area_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Prior_Area_Codes_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Active_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Confidence_Scores_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Listing_Types_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Types_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Marketability_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Marketability_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Is_Phone_Marketable_) OR __NN(Phone_Marketability_Score_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Types_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Record_Type_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone10_);
  EXPORT Portability_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Portability_Indicator_);
  EXPORT Current_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Flag_);
  EXPORT Business_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Business_Flag_);
  EXPORT N_X_X_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,N_X_X_Type_);
  EXPORT Publish_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Publish_Code_);
  EXPORT C_O_C_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,C_O_C_Type_);
  EXPORT S_C_C__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,S_C_C_);
  EXPORT Phone_Number_Company_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_Company_Type_);
  EXPORT Ported_Match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ported_Match_);
  EXPORT Phone_Use__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Use_);
  EXPORT No_Solicit_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,No_Solicit_Code_);
  EXPORT Omit_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Omit_Indicator_);
  EXPORT Source_File__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_File_);
  EXPORT Iver_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Iver_Indicator_);
  EXPORT Validation_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Validation_Flag_);
  EXPORT Validation_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Validation_Date_);
  EXPORT Carrier_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Carrier_Name_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_YellowPages__kfetch_yellowpages_linkids_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Did_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Portability_Indicator__SingleValue_Invalid),COUNT(Current_Flag__SingleValue_Invalid),COUNT(Business_Flag__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Publish_Code__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_C_C__SingleValue_Invalid),COUNT(Phone_Number_Company_Type__SingleValue_Invalid),COUNT(Ported_Match__SingleValue_Invalid),COUNT(Phone_Use__SingleValue_Invalid),COUNT(No_Solicit_Code__SingleValue_Invalid),COUNT(Omit_Indicator__SingleValue_Invalid),COUNT(Source_File__SingleValue_Invalid),COUNT(Iver_Indicator__SingleValue_Invalid),COUNT(Validation_Flag__SingleValue_Invalid),COUNT(Validation_Date__SingleValue_Invalid),COUNT(Carrier_Name__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_YellowPages__kfetch_yellowpages_linkids_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Did_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Portability_Indicator__SingleValue_Invalid,KEL.typ.int Current_Flag__SingleValue_Invalid,KEL.typ.int Business_Flag__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Publish_Code__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_C_C__SingleValue_Invalid,KEL.typ.int Phone_Number_Company_Type__SingleValue_Invalid,KEL.typ.int Ported_Match__SingleValue_Invalid,KEL.typ.int Phone_Use__SingleValue_Invalid,KEL.typ.int No_Solicit_Code__SingleValue_Invalid,KEL.typ.int Omit_Indicator__SingleValue_Invalid,KEL.typ.int Source_File__SingleValue_Invalid,KEL.typ.int Iver_Indicator__SingleValue_Invalid,KEL.typ.int Validation_Flag__SingleValue_Invalid,KEL.typ.int Validation_Date__SingleValue_Invalid,KEL.typ.int Carrier_Name__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d0(__NL(Portability_Indicator_))),COUNT(__d0(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d0(__NL(N_X_X_Type_))),COUNT(__d0(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d0(__NL(C_O_C_Type_))),COUNT(__d0(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d0(__NL(S_C_C_))),COUNT(__d0(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d0(__NL(Ported_Match_))),COUNT(__d0(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d0(__NL(Phone_Use_))),COUNT(__d0(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d0(__NL(Phone_Number_Company_Type_))),COUNT(__d0(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d0(__NL(Maximum_Confidence_Score_))),COUNT(__d0(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d0(__NL(Minimum_Confidence_Score_))),COUNT(__d0(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d0(__NL(Phone_Quality_))),COUNT(__d0(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d0(__NL(T_N_T_))),COUNT(__d0(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d0(__NL(Phone_Type_))),COUNT(__d0(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d0(__NL(Validation_Date_))),COUNT(__d0(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d0(__NL(Is_Phone_Marketable_))),COUNT(__d0(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d0(__NL(Phone_Marketability_Score_))),COUNT(__d0(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d1(__NL(Portability_Indicator_))),COUNT(__d1(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d1(__NL(N_X_X_Type_))),COUNT(__d1(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d1(__NL(C_O_C_Type_))),COUNT(__d1(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d1(__NL(S_C_C_))),COUNT(__d1(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d1(__NL(Ported_Match_))),COUNT(__d1(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d1(__NL(Phone_Use_))),COUNT(__d1(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d1(__NL(Phone_Number_Company_Type_))),COUNT(__d1(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d1(__NL(Maximum_Confidence_Score_))),COUNT(__d1(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d1(__NL(Minimum_Confidence_Score_))),COUNT(__d1(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d1(__NL(Phone_Quality_))),COUNT(__d1(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d1(__NL(T_N_T_))),COUNT(__d1(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d1(__NL(Phone_Type_))),COUNT(__d1(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d1(__NL(Validation_Date_))),COUNT(__d1(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d1(__NL(Is_Phone_Marketable_))),COUNT(__d1(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d1(__NL(Phone_Marketability_Score_))),COUNT(__d1(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(__d2)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d2(__NL(Phone10_))),COUNT(__d2(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d2(__NL(Portability_Indicator_))),COUNT(__d2(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d2(__NL(N_X_X_Type_))),COUNT(__d2(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d2(__NL(C_O_C_Type_))),COUNT(__d2(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d2(__NL(S_C_C_))),COUNT(__d2(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d2(__NL(Ported_Match_))),COUNT(__d2(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d2(__NL(Phone_Use_))),COUNT(__d2(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d2(__NL(Phone_Number_Company_Type_))),COUNT(__d2(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d2(__NL(Carrier_Name_))),COUNT(__d2(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d2(__NL(Confidence_Score_))),COUNT(__d2(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d2(__NL(No_Solicit_Code_))),COUNT(__d2(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d2(__NL(Maximum_Confidence_Score_))),COUNT(__d2(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d2(__NL(Minimum_Confidence_Score_))),COUNT(__d2(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d2(__NL(Phone_Quality_))),COUNT(__d2(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d2(__NL(T_N_T_))),COUNT(__d2(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d2(__NL(Iver_Indicator_))),COUNT(__d2(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d2(__NL(Phone_Type_))),COUNT(__d2(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d2(__NL(Validation_Flag_))),COUNT(__d2(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d2(__NL(Validation_Date_))),COUNT(__d2(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d2(__NL(Is_Phone_Marketable_))),COUNT(__d2(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d2(__NL(Phone_Marketability_Score_))),COUNT(__d2(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(__NL(Date_Vendor_First_Reported_))),COUNT(__d2(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(__NL(Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_1_Invalid),COUNT(__d3)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d3(__NL(Phone10_))),COUNT(__d3(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d3(__NL(Portability_Indicator_))),COUNT(__d3(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d3(__NL(N_X_X_Type_))),COUNT(__d3(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d3(__NL(C_O_C_Type_))),COUNT(__d3(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d3(__NL(S_C_C_))),COUNT(__d3(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d3(__NL(Ported_Match_))),COUNT(__d3(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d3(__NL(Phone_Use_))),COUNT(__d3(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d3(__NL(Phone_Number_Company_Type_))),COUNT(__d3(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d3(__NL(Carrier_Name_))),COUNT(__d3(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d3(__NL(Confidence_Score_))),COUNT(__d3(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d3(__NL(No_Solicit_Code_))),COUNT(__d3(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d3(__NL(Maximum_Confidence_Score_))),COUNT(__d3(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d3(__NL(Minimum_Confidence_Score_))),COUNT(__d3(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d3(__NL(Phone_Quality_))),COUNT(__d3(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d3(__NL(T_N_T_))),COUNT(__d3(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d3(__NL(Iver_Indicator_))),COUNT(__d3(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d3(__NL(Phone_Type_))),COUNT(__d3(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d3(__NL(Validation_Flag_))),COUNT(__d3(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d3(__NL(Validation_Date_))),COUNT(__d3(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d3(__NL(Is_Phone_Marketable_))),COUNT(__d3(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d3(__NL(Phone_Marketability_Score_))),COUNT(__d3(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(__NL(Date_Vendor_First_Reported_))),COUNT(__d3(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(__NL(Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_2_Invalid),COUNT(__d4)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d4(__NL(Phone10_))),COUNT(__d4(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d4(__NL(Portability_Indicator_))),COUNT(__d4(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d4(__NL(N_X_X_Type_))),COUNT(__d4(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d4(__NL(C_O_C_Type_))),COUNT(__d4(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d4(__NL(S_C_C_))),COUNT(__d4(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d4(__NL(Ported_Match_))),COUNT(__d4(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d4(__NL(Phone_Use_))),COUNT(__d4(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d4(__NL(Phone_Number_Company_Type_))),COUNT(__d4(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d4(__NL(Carrier_Name_))),COUNT(__d4(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d4(__NL(Confidence_Score_))),COUNT(__d4(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d4(__NL(No_Solicit_Code_))),COUNT(__d4(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d4(__NL(Maximum_Confidence_Score_))),COUNT(__d4(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d4(__NL(Minimum_Confidence_Score_))),COUNT(__d4(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d4(__NL(Phone_Quality_))),COUNT(__d4(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d4(__NL(T_N_T_))),COUNT(__d4(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d4(__NL(Source_File_))),COUNT(__d4(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d4(__NL(Iver_Indicator_))),COUNT(__d4(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d4(__NL(Phone_Type_))),COUNT(__d4(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d4(__NL(Validation_Flag_))),COUNT(__d4(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d4(__NL(Validation_Date_))),COUNT(__d4(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d4(__NL(Is_Phone_Marketable_))),COUNT(__d4(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d4(__NL(Phone_Marketability_Score_))),COUNT(__d4(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(__NL(Date_Vendor_First_Reported_))),COUNT(__d4(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(__NL(Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(__d5)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d5(__NL(Phone10_))),COUNT(__d5(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d5(__NL(Portability_Indicator_))),COUNT(__d5(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d5(__NL(N_X_X_Type_))),COUNT(__d5(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d5(__NL(C_O_C_Type_))),COUNT(__d5(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d5(__NL(S_C_C_))),COUNT(__d5(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d5(__NL(Ported_Match_))),COUNT(__d5(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d5(__NL(Phone_Use_))),COUNT(__d5(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d5(__NL(Phone_Number_Company_Type_))),COUNT(__d5(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d5(__NL(Carrier_Name_))),COUNT(__d5(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d5(__NL(Confidence_Score_))),COUNT(__d5(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d5(__NL(No_Solicit_Code_))),COUNT(__d5(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d5(__NL(Maximum_Confidence_Score_))),COUNT(__d5(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d5(__NL(Minimum_Confidence_Score_))),COUNT(__d5(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d5(__NL(Phone_Quality_))),COUNT(__d5(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d5(__NL(T_N_T_))),COUNT(__d5(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d5(__NL(Source_File_))),COUNT(__d5(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d5(__NL(Iver_Indicator_))),COUNT(__d5(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d5(__NL(Phone_Type_))),COUNT(__d5(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d5(__NL(Validation_Flag_))),COUNT(__d5(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d5(__NL(Validation_Date_))),COUNT(__d5(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d5(__NL(Is_Phone_Marketable_))),COUNT(__d5(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d5(__NL(Phone_Marketability_Score_))),COUNT(__d5(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(__NL(Date_Vendor_First_Reported_))),COUNT(__d5(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(__NL(Date_Vendor_Last_Reported_))),COUNT(__d5(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(__d6)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d6(__NL(Phone10_))),COUNT(__d6(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d6(__NL(Portability_Indicator_))),COUNT(__d6(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d6(__NL(N_X_X_Type_))),COUNT(__d6(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d6(__NL(C_O_C_Type_))),COUNT(__d6(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d6(__NL(S_C_C_))),COUNT(__d6(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d6(__NL(Ported_Match_))),COUNT(__d6(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d6(__NL(Phone_Use_))),COUNT(__d6(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d6(__NL(Phone_Number_Company_Type_))),COUNT(__d6(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d6(__NL(Carrier_Name_))),COUNT(__d6(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d6(__NL(Confidence_Score_))),COUNT(__d6(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d6(__NL(No_Solicit_Code_))),COUNT(__d6(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d6(__NL(Maximum_Confidence_Score_))),COUNT(__d6(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d6(__NL(Minimum_Confidence_Score_))),COUNT(__d6(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d6(__NL(Phone_Quality_))),COUNT(__d6(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d6(__NL(T_N_T_))),COUNT(__d6(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d6(__NL(Source_File_))),COUNT(__d6(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d6(__NL(Iver_Indicator_))),COUNT(__d6(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d6(__NL(Phone_Type_))),COUNT(__d6(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d6(__NL(Validation_Flag_))),COUNT(__d6(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d6(__NL(Validation_Date_))),COUNT(__d6(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d6(__NL(Is_Phone_Marketable_))),COUNT(__d6(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d6(__NL(Phone_Marketability_Score_))),COUNT(__d6(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d6(__NL(Date_Vendor_First_Reported_))),COUNT(__d6(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d6(__NL(Date_Vendor_Last_Reported_))),COUNT(__d6(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(__d7)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_phone',COUNT(__d7(__NL(Phone10_))),COUNT(__d7(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d7(__NL(Listing_Type_))),COUNT(__d7(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d7(__NL(Publish_Code_))),COUNT(__d7(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d7(__NL(Portability_Indicator_))),COUNT(__d7(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d7(__NL(N_X_X_Type_))),COUNT(__d7(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d7(__NL(C_O_C_Type_))),COUNT(__d7(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d7(__NL(S_C_C_))),COUNT(__d7(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d7(__NL(Ported_Match_))),COUNT(__d7(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d7(__NL(Phone_Use_))),COUNT(__d7(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d7(__NL(Phone_Number_Company_Type_))),COUNT(__d7(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d7(__NL(Prior_Area_Code_))),COUNT(__d7(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d7(__NL(Carrier_Name_))),COUNT(__d7(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d7(__NL(Confidence_Score_))),COUNT(__d7(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d7(__NL(No_Solicit_Code_))),COUNT(__d7(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d7(__NL(Maximum_Confidence_Score_))),COUNT(__d7(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d7(__NL(Minimum_Confidence_Score_))),COUNT(__d7(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d7(__NL(Omit_Indicator_))),COUNT(__d7(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d7(__NL(Current_Flag_))),COUNT(__d7(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d7(__NL(Business_Flag_))),COUNT(__d7(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d7(__NL(Phone_Quality_))),COUNT(__d7(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d7(__NL(T_N_T_))),COUNT(__d7(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d7(__NL(Record_Type_))),COUNT(__d7(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d7(__NL(Source_File_))),COUNT(__d7(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d7(__NL(Iver_Indicator_))),COUNT(__d7(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d7(__NL(Phone_Type_))),COUNT(__d7(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d7(__NL(Validation_Flag_))),COUNT(__d7(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d7(__NL(Validation_Date_))),COUNT(__d7(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d7(__NL(Is_Phone_Marketable_))),COUNT(__d7(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d7(__NL(Phone_Marketability_Score_))),COUNT(__d7(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d7(__NL(Date_Vendor_First_Reported_))),COUNT(__d7(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d7(__NL(Date_Vendor_Last_Reported_))),COUNT(__d7(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','email_src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_YellowPages__kfetch_yellowpages_linkids_Invalid),COUNT(__d8)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d8(__NL(Phone10_))),COUNT(__d8(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d8(__NL(Listing_Type_))),COUNT(__d8(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d8(__NL(Publish_Code_))),COUNT(__d8(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d8(__NL(Portability_Indicator_))),COUNT(__d8(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d8(__NL(N_X_X_Type_))),COUNT(__d8(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d8(__NL(C_O_C_Type_))),COUNT(__d8(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d8(__NL(S_C_C_))),COUNT(__d8(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d8(__NL(Ported_Match_))),COUNT(__d8(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d8(__NL(Phone_Use_))),COUNT(__d8(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d8(__NL(Phone_Number_Company_Type_))),COUNT(__d8(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d8(__NL(Prior_Area_Code_))),COUNT(__d8(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d8(__NL(Carrier_Name_))),COUNT(__d8(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d8(__NL(Confidence_Score_))),COUNT(__d8(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nosolicitcode',COUNT(__d8(__NL(No_Solicit_Code_))),COUNT(__d8(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d8(__NL(Maximum_Confidence_Score_))),COUNT(__d8(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d8(__NL(Minimum_Confidence_Score_))),COUNT(__d8(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d8(__NL(Omit_Indicator_))),COUNT(__d8(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d8(__NL(Current_Flag_))),COUNT(__d8(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d8(__NL(Business_Flag_))),COUNT(__d8(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d8(__NL(Phone_Quality_))),COUNT(__d8(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d8(__NL(T_N_T_))),COUNT(__d8(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d8(__NL(Record_Type_))),COUNT(__d8(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d8(__NL(Source_File_))),COUNT(__d8(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d8(__NL(Iver_Indicator_))),COUNT(__d8(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d8(__NL(Phone_Type_))),COUNT(__d8(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d8(__NL(Validation_Flag_))),COUNT(__d8(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d8(__NL(Validation_Date_))),COUNT(__d8(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d8(__NL(Is_Phone_Marketable_))),COUNT(__d8(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d8(__NL(Phone_Marketability_Score_))),COUNT(__d8(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d8(__NL(Date_Vendor_First_Reported_))),COUNT(__d8(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d8(__NL(Date_Vendor_Last_Reported_))),COUNT(__d8(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Equifax_Business__Data_kfetch_LinkIDs_Invalid),COUNT(__d9)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_phone',COUNT(__d9(__NL(Phone10_))),COUNT(__d9(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d9(__NL(Listing_Type_))),COUNT(__d9(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d9(__NL(Publish_Code_))),COUNT(__d9(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d9(__NL(Portability_Indicator_))),COUNT(__d9(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d9(__NL(N_X_X_Type_))),COUNT(__d9(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d9(__NL(C_O_C_Type_))),COUNT(__d9(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d9(__NL(S_C_C_))),COUNT(__d9(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d9(__NL(Ported_Match_))),COUNT(__d9(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d9(__NL(Phone_Use_))),COUNT(__d9(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d9(__NL(Phone_Number_Company_Type_))),COUNT(__d9(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d9(__NL(Prior_Area_Code_))),COUNT(__d9(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d9(__NL(Is_Active_))),COUNT(__d9(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d9(__NL(Carrier_Name_))),COUNT(__d9(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d9(__NL(Confidence_Score_))),COUNT(__d9(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d9(__NL(No_Solicit_Code_))),COUNT(__d9(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d9(__NL(Maximum_Confidence_Score_))),COUNT(__d9(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d9(__NL(Minimum_Confidence_Score_))),COUNT(__d9(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d9(__NL(Omit_Indicator_))),COUNT(__d9(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d9(__NL(Current_Flag_))),COUNT(__d9(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d9(__NL(Business_Flag_))),COUNT(__d9(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d9(__NL(Phone_Quality_))),COUNT(__d9(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d9(__NL(T_N_T_))),COUNT(__d9(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d9(__NL(Record_Type_))),COUNT(__d9(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d9(__NL(Source_File_))),COUNT(__d9(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d9(__NL(Iver_Indicator_))),COUNT(__d9(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d9(__NL(Phone_Type_))),COUNT(__d9(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d9(__NL(Validation_Flag_))),COUNT(__d9(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d9(__NL(Validation_Date_))),COUNT(__d9(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_telever',COUNT(__d9(__NL(Is_Phone_Marketable_))),COUNT(__d9(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_telescore',COUNT(__d9(__NL(Phone_Marketability_Score_))),COUNT(__d9(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d9(__NL(Date_Vendor_First_Reported_))),COUNT(__d9(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d9(__NL(Date_Vendor_Last_Reported_))),COUNT(__d9(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_DID_Invalid),COUNT(__d10)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d10(__NL(Phone10_))),COUNT(__d10(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d10(__NL(Listing_Type_))),COUNT(__d10(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d10(__NL(Publish_Code_))),COUNT(__d10(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d10(__NL(Portability_Indicator_))),COUNT(__d10(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d10(__NL(N_X_X_Type_))),COUNT(__d10(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d10(__NL(C_O_C_Type_))),COUNT(__d10(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d10(__NL(S_C_C_))),COUNT(__d10(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d10(__NL(Ported_Match_))),COUNT(__d10(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d10(__NL(Phone_Use_))),COUNT(__d10(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d10(__NL(Phone_Number_Company_Type_))),COUNT(__d10(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d10(__NL(Prior_Area_Code_))),COUNT(__d10(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d10(__NL(Is_Active_))),COUNT(__d10(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d10(__NL(Carrier_Name_))),COUNT(__d10(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d10(__NL(Confidence_Score_))),COUNT(__d10(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d10(__NL(No_Solicit_Code_))),COUNT(__d10(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d10(__NL(Maximum_Confidence_Score_))),COUNT(__d10(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d10(__NL(Minimum_Confidence_Score_))),COUNT(__d10(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d10(__NL(Omit_Indicator_))),COUNT(__d10(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d10(__NL(Current_Flag_))),COUNT(__d10(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d10(__NL(Business_Flag_))),COUNT(__d10(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d10(__NL(Phone_Quality_))),COUNT(__d10(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d10(__NL(T_N_T_))),COUNT(__d10(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d10(__NL(Record_Type_))),COUNT(__d10(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d10(__NL(Source_File_))),COUNT(__d10(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d10(__NL(Iver_Indicator_))),COUNT(__d10(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d10(__NL(Phone_Type_))),COUNT(__d10(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d10(__NL(Validation_Flag_))),COUNT(__d10(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d10(__NL(Validation_Date_))),COUNT(__d10(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d10(__NL(Is_Phone_Marketable_))),COUNT(__d10(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d10(__NL(Phone_Marketability_Score_))),COUNT(__d10(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d10(__NL(Date_Vendor_First_Reported_))),COUNT(__d10(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d10(__NL(Date_Vendor_Last_Reported_))),COUNT(__d10(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d10(__NL(Original_Source_))),COUNT(__d10(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Address_Invalid),COUNT(__d11)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d11(__NL(Phone10_))),COUNT(__d11(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d11(__NL(Listing_Type_))),COUNT(__d11(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d11(__NL(Publish_Code_))),COUNT(__d11(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d11(__NL(Portability_Indicator_))),COUNT(__d11(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d11(__NL(N_X_X_Type_))),COUNT(__d11(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d11(__NL(C_O_C_Type_))),COUNT(__d11(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d11(__NL(S_C_C_))),COUNT(__d11(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d11(__NL(Ported_Match_))),COUNT(__d11(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d11(__NL(Phone_Use_))),COUNT(__d11(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d11(__NL(Phone_Number_Company_Type_))),COUNT(__d11(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d11(__NL(Prior_Area_Code_))),COUNT(__d11(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d11(__NL(Is_Active_))),COUNT(__d11(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d11(__NL(Carrier_Name_))),COUNT(__d11(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d11(__NL(Confidence_Score_))),COUNT(__d11(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d11(__NL(No_Solicit_Code_))),COUNT(__d11(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d11(__NL(Maximum_Confidence_Score_))),COUNT(__d11(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d11(__NL(Minimum_Confidence_Score_))),COUNT(__d11(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d11(__NL(Omit_Indicator_))),COUNT(__d11(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d11(__NL(Current_Flag_))),COUNT(__d11(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d11(__NL(Business_Flag_))),COUNT(__d11(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d11(__NL(Phone_Quality_))),COUNT(__d11(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d11(__NL(T_N_T_))),COUNT(__d11(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d11(__NL(Record_Type_))),COUNT(__d11(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d11(__NL(Source_File_))),COUNT(__d11(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d11(__NL(Iver_Indicator_))),COUNT(__d11(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d11(__NL(Phone_Type_))),COUNT(__d11(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d11(__NL(Validation_Flag_))),COUNT(__d11(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d11(__NL(Validation_Date_))),COUNT(__d11(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d11(__NL(Is_Phone_Marketable_))),COUNT(__d11(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d11(__NL(Phone_Marketability_Score_))),COUNT(__d11(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d11(__NL(Date_Vendor_First_Reported_))),COUNT(__d11(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d11(__NL(Date_Vendor_Last_Reported_))),COUNT(__d11(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d11(__NL(Original_Source_))),COUNT(__d11(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(__d12)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d12(__NL(Phone10_))),COUNT(__d12(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d12(__NL(Listing_Type_))),COUNT(__d12(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d12(__NL(Publish_Code_))),COUNT(__d12(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d12(__NL(Portability_Indicator_))),COUNT(__d12(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d12(__NL(N_X_X_Type_))),COUNT(__d12(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d12(__NL(C_O_C_Type_))),COUNT(__d12(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d12(__NL(S_C_C_))),COUNT(__d12(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d12(__NL(Ported_Match_))),COUNT(__d12(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d12(__NL(Phone_Use_))),COUNT(__d12(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d12(__NL(Phone_Number_Company_Type_))),COUNT(__d12(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d12(__NL(Prior_Area_Code_))),COUNT(__d12(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d12(__NL(Is_Active_))),COUNT(__d12(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d12(__NL(Carrier_Name_))),COUNT(__d12(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d12(__NL(Confidence_Score_))),COUNT(__d12(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d12(__NL(No_Solicit_Code_))),COUNT(__d12(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d12(__NL(Maximum_Confidence_Score_))),COUNT(__d12(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d12(__NL(Minimum_Confidence_Score_))),COUNT(__d12(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d12(__NL(Omit_Indicator_))),COUNT(__d12(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d12(__NL(Current_Flag_))),COUNT(__d12(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d12(__NL(Business_Flag_))),COUNT(__d12(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d12(__NL(Phone_Quality_))),COUNT(__d12(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d12(__NL(T_N_T_))),COUNT(__d12(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d12(__NL(Record_Type_))),COUNT(__d12(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d12(__NL(Source_File_))),COUNT(__d12(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d12(__NL(Iver_Indicator_))),COUNT(__d12(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d12(__NL(Phone_Type_))),COUNT(__d12(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d12(__NL(Validation_Flag_))),COUNT(__d12(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d12(__NL(Validation_Date_))),COUNT(__d12(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d12(__NL(Is_Phone_Marketable_))),COUNT(__d12(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d12(__NL(Phone_Marketability_Score_))),COUNT(__d12(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d12(__NL(Date_Vendor_First_Reported_))),COUNT(__d12(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d12(__NL(Date_Vendor_Last_Reported_))),COUNT(__d12(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d12(__NL(Original_Source_))),COUNT(__d12(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_LinkIds_Invalid),COUNT(__d13)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d13(__NL(Phone10_))),COUNT(__d13(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d13(__NL(Listing_Type_))),COUNT(__d13(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d13(__NL(Publish_Code_))),COUNT(__d13(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d13(__NL(Portability_Indicator_))),COUNT(__d13(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d13(__NL(N_X_X_Type_))),COUNT(__d13(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d13(__NL(C_O_C_Type_))),COUNT(__d13(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d13(__NL(S_C_C_))),COUNT(__d13(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d13(__NL(Ported_Match_))),COUNT(__d13(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d13(__NL(Phone_Use_))),COUNT(__d13(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d13(__NL(Phone_Number_Company_Type_))),COUNT(__d13(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d13(__NL(Prior_Area_Code_))),COUNT(__d13(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d13(__NL(Is_Active_))),COUNT(__d13(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d13(__NL(Carrier_Name_))),COUNT(__d13(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d13(__NL(Confidence_Score_))),COUNT(__d13(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d13(__NL(No_Solicit_Code_))),COUNT(__d13(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d13(__NL(Maximum_Confidence_Score_))),COUNT(__d13(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d13(__NL(Minimum_Confidence_Score_))),COUNT(__d13(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d13(__NL(Omit_Indicator_))),COUNT(__d13(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d13(__NL(Current_Flag_))),COUNT(__d13(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Listing_Type_Bus',COUNT(__d13(__NL(Business_Flag_))),COUNT(__d13(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d13(__NL(Phone_Quality_))),COUNT(__d13(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d13(__NL(T_N_T_))),COUNT(__d13(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d13(__NL(Record_Type_))),COUNT(__d13(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d13(__NL(Source_File_))),COUNT(__d13(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d13(__NL(Iver_Indicator_))),COUNT(__d13(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d13(__NL(Phone_Type_))),COUNT(__d13(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d13(__NL(Validation_Flag_))),COUNT(__d13(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d13(__NL(Validation_Date_))),COUNT(__d13(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d13(__NL(Is_Phone_Marketable_))),COUNT(__d13(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d13(__NL(Phone_Marketability_Score_))),COUNT(__d13(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d13(__NL(Date_Vendor_First_Reported_))),COUNT(__d13(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d13(__NL(Date_Vendor_Last_Reported_))),COUNT(__d13(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d13(__NL(Original_Source_))),COUNT(__d13(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Address_Invalid),COUNT(__d14)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d14(__NL(Phone10_))),COUNT(__d14(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d14(__NL(Listing_Type_))),COUNT(__d14(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d14(__NL(Publish_Code_))),COUNT(__d14(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d14(__NL(Portability_Indicator_))),COUNT(__d14(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d14(__NL(N_X_X_Type_))),COUNT(__d14(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d14(__NL(C_O_C_Type_))),COUNT(__d14(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d14(__NL(S_C_C_))),COUNT(__d14(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d14(__NL(Ported_Match_))),COUNT(__d14(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d14(__NL(Phone_Use_))),COUNT(__d14(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d14(__NL(Phone_Number_Company_Type_))),COUNT(__d14(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d14(__NL(Prior_Area_Code_))),COUNT(__d14(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d14(__NL(Is_Active_))),COUNT(__d14(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d14(__NL(Carrier_Name_))),COUNT(__d14(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d14(__NL(Confidence_Score_))),COUNT(__d14(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_solicitation_code',COUNT(__d14(__NL(No_Solicit_Code_))),COUNT(__d14(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d14(__NL(Maximum_Confidence_Score_))),COUNT(__d14(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d14(__NL(Minimum_Confidence_Score_))),COUNT(__d14(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d14(__NL(Omit_Indicator_))),COUNT(__d14(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d14(__NL(Current_Flag_))),COUNT(__d14(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d14(__NL(Business_Flag_))),COUNT(__d14(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d14(__NL(Phone_Quality_))),COUNT(__d14(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d14(__NL(T_N_T_))),COUNT(__d14(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d14(__NL(Record_Type_))),COUNT(__d14(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d14(__NL(Source_File_))),COUNT(__d14(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d14(__NL(Iver_Indicator_))),COUNT(__d14(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_type',COUNT(__d14(__NL(Phone_Type_))),COUNT(__d14(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_flag',COUNT(__d14(__NL(Validation_Flag_))),COUNT(__d14(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_date',COUNT(__d14(__NL(Validation_Date_))),COUNT(__d14(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d14(__NL(Is_Phone_Marketable_))),COUNT(__d14(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d14(__NL(Phone_Marketability_Score_))),COUNT(__d14(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d14(__NL(Date_Vendor_First_Reported_))),COUNT(__d14(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d14(__NL(Date_Vendor_Last_Reported_))),COUNT(__d14(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d14(__NL(Original_Source_))),COUNT(__d14(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(__d15)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d15(__NL(Phone10_))),COUNT(__d15(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d15(__NL(Listing_Type_))),COUNT(__d15(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d15(__NL(Publish_Code_))),COUNT(__d15(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d15(__NL(Portability_Indicator_))),COUNT(__d15(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d15(__NL(N_X_X_Type_))),COUNT(__d15(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d15(__NL(C_O_C_Type_))),COUNT(__d15(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d15(__NL(S_C_C_))),COUNT(__d15(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d15(__NL(Ported_Match_))),COUNT(__d15(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d15(__NL(Phone_Use_))),COUNT(__d15(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d15(__NL(Phone_Number_Company_Type_))),COUNT(__d15(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d15(__NL(Prior_Area_Code_))),COUNT(__d15(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d15(__NL(Is_Active_))),COUNT(__d15(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d15(__NL(Carrier_Name_))),COUNT(__d15(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d15(__NL(Confidence_Score_))),COUNT(__d15(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_solicitation_code',COUNT(__d15(__NL(No_Solicit_Code_))),COUNT(__d15(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d15(__NL(Maximum_Confidence_Score_))),COUNT(__d15(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d15(__NL(Minimum_Confidence_Score_))),COUNT(__d15(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d15(__NL(Omit_Indicator_))),COUNT(__d15(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d15(__NL(Current_Flag_))),COUNT(__d15(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d15(__NL(Business_Flag_))),COUNT(__d15(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d15(__NL(Phone_Quality_))),COUNT(__d15(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d15(__NL(T_N_T_))),COUNT(__d15(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d15(__NL(Record_Type_))),COUNT(__d15(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d15(__NL(Source_File_))),COUNT(__d15(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d15(__NL(Iver_Indicator_))),COUNT(__d15(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_type',COUNT(__d15(__NL(Phone_Type_))),COUNT(__d15(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_flag',COUNT(__d15(__NL(Validation_Flag_))),COUNT(__d15(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_date',COUNT(__d15(__NL(Validation_Date_))),COUNT(__d15(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d15(__NL(Is_Phone_Marketable_))),COUNT(__d15(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d15(__NL(Phone_Marketability_Score_))),COUNT(__d15(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d15(__NL(Date_Vendor_First_Reported_))),COUNT(__d15(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d15(__NL(Date_Vendor_Last_Reported_))),COUNT(__d15(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d15(__NL(Original_Source_))),COUNT(__d15(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(__d16)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d16(__NL(Phone10_))),COUNT(__d16(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d16(__NL(Listing_Type_))),COUNT(__d16(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d16(__NL(Publish_Code_))),COUNT(__d16(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d16(__NL(Portability_Indicator_))),COUNT(__d16(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d16(__NL(N_X_X_Type_))),COUNT(__d16(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d16(__NL(C_O_C_Type_))),COUNT(__d16(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d16(__NL(S_C_C_))),COUNT(__d16(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d16(__NL(Ported_Match_))),COUNT(__d16(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d16(__NL(Phone_Use_))),COUNT(__d16(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d16(__NL(Phone_Number_Company_Type_))),COUNT(__d16(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d16(__NL(Prior_Area_Code_))),COUNT(__d16(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d16(__NL(Is_Active_))),COUNT(__d16(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d16(__NL(Carrier_Name_))),COUNT(__d16(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d16(__NL(Confidence_Score_))),COUNT(__d16(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d16(__NL(No_Solicit_Code_))),COUNT(__d16(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d16(__NL(Maximum_Confidence_Score_))),COUNT(__d16(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d16(__NL(Minimum_Confidence_Score_))),COUNT(__d16(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d16(__NL(Omit_Indicator_))),COUNT(__d16(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d16(__NL(Current_Flag_))),COUNT(__d16(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d16(__NL(Business_Flag_))),COUNT(__d16(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d16(__NL(Phone_Quality_))),COUNT(__d16(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d16(__NL(T_N_T_))),COUNT(__d16(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d16(__NL(Record_Type_))),COUNT(__d16(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d16(__NL(Source_File_))),COUNT(__d16(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d16(__NL(Iver_Indicator_))),COUNT(__d16(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d16(__NL(Phone_Type_))),COUNT(__d16(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d16(__NL(Validation_Flag_))),COUNT(__d16(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d16(__NL(Validation_Date_))),COUNT(__d16(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d16(__NL(Is_Phone_Marketable_))),COUNT(__d16(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d16(__NL(Phone_Marketability_Score_))),COUNT(__d16(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d16(__NL(Date_Vendor_First_Reported_))),COUNT(__d16(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d16(__NL(Date_Vendor_Last_Reported_))),COUNT(__d16(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d16(__NL(Source_))),COUNT(__d16(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d16(__NL(Original_Source_))),COUNT(__d16(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d16(Date_First_Seen_=0)),COUNT(__d16(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d16(Date_Last_Seen_=0)),COUNT(__d16(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid),COUNT(__d17)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d17(__NL(Phone10_))),COUNT(__d17(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d17(__NL(Listing_Type_))),COUNT(__d17(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d17(__NL(Publish_Code_))),COUNT(__d17(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d17(__NL(Portability_Indicator_))),COUNT(__d17(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d17(__NL(N_X_X_Type_))),COUNT(__d17(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d17(__NL(C_O_C_Type_))),COUNT(__d17(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d17(__NL(S_C_C_))),COUNT(__d17(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d17(__NL(Ported_Match_))),COUNT(__d17(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d17(__NL(Phone_Use_))),COUNT(__d17(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d17(__NL(Phone_Number_Company_Type_))),COUNT(__d17(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d17(__NL(Prior_Area_Code_))),COUNT(__d17(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d17(__NL(Is_Active_))),COUNT(__d17(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d17(__NL(Carrier_Name_))),COUNT(__d17(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d17(__NL(Confidence_Score_))),COUNT(__d17(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d17(__NL(No_Solicit_Code_))),COUNT(__d17(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d17(__NL(Maximum_Confidence_Score_))),COUNT(__d17(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d17(__NL(Minimum_Confidence_Score_))),COUNT(__d17(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d17(__NL(Omit_Indicator_))),COUNT(__d17(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d17(__NL(Current_Flag_))),COUNT(__d17(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d17(__NL(Business_Flag_))),COUNT(__d17(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d17(__NL(Phone_Quality_))),COUNT(__d17(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d17(__NL(T_N_T_))),COUNT(__d17(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d17(__NL(Record_Type_))),COUNT(__d17(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d17(__NL(Source_File_))),COUNT(__d17(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d17(__NL(Iver_Indicator_))),COUNT(__d17(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d17(__NL(Phone_Type_))),COUNT(__d17(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d17(__NL(Validation_Flag_))),COUNT(__d17(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d17(__NL(Validation_Date_))),COUNT(__d17(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d17(__NL(Is_Phone_Marketable_))),COUNT(__d17(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d17(__NL(Phone_Marketability_Score_))),COUNT(__d17(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d17(__NL(Date_Vendor_First_Reported_))),COUNT(__d17(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d17(__NL(Date_Vendor_Last_Reported_))),COUNT(__d17(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d17(__NL(Source_))),COUNT(__d17(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d17(__NL(Original_Source_))),COUNT(__d17(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d17(Date_First_Seen_=0)),COUNT(__d17(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d17(Date_Last_Seen_=0)),COUNT(__d17(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address_Invalid),COUNT(__d18)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d18(__NL(Phone10_))),COUNT(__d18(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d18(__NL(Listing_Type_))),COUNT(__d18(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d18(__NL(Publish_Code_))),COUNT(__d18(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d18(__NL(Portability_Indicator_))),COUNT(__d18(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d18(__NL(N_X_X_Type_))),COUNT(__d18(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d18(__NL(C_O_C_Type_))),COUNT(__d18(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d18(__NL(S_C_C_))),COUNT(__d18(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d18(__NL(Ported_Match_))),COUNT(__d18(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d18(__NL(Phone_Use_))),COUNT(__d18(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d18(__NL(Phone_Number_Company_Type_))),COUNT(__d18(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d18(__NL(Prior_Area_Code_))),COUNT(__d18(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d18(__NL(Is_Active_))),COUNT(__d18(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d18(__NL(Carrier_Name_))),COUNT(__d18(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d18(__NL(Confidence_Score_))),COUNT(__d18(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d18(__NL(No_Solicit_Code_))),COUNT(__d18(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d18(__NL(Maximum_Confidence_Score_))),COUNT(__d18(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d18(__NL(Minimum_Confidence_Score_))),COUNT(__d18(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d18(__NL(Omit_Indicator_))),COUNT(__d18(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d18(__NL(Current_Flag_))),COUNT(__d18(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d18(__NL(Business_Flag_))),COUNT(__d18(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d18(__NL(Phone_Quality_))),COUNT(__d18(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d18(__NL(T_N_T_))),COUNT(__d18(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d18(__NL(Record_Type_))),COUNT(__d18(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d18(__NL(Source_File_))),COUNT(__d18(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d18(__NL(Iver_Indicator_))),COUNT(__d18(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d18(__NL(Phone_Type_))),COUNT(__d18(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d18(__NL(Validation_Flag_))),COUNT(__d18(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d18(__NL(Validation_Date_))),COUNT(__d18(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d18(__NL(Is_Phone_Marketable_))),COUNT(__d18(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d18(__NL(Phone_Marketability_Score_))),COUNT(__d18(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d18(__NL(Date_Vendor_First_Reported_))),COUNT(__d18(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d18(__NL(Date_Vendor_Last_Reported_))),COUNT(__d18(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d18(__NL(Source_))),COUNT(__d18(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d18(__NL(Original_Source_))),COUNT(__d18(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d18(Date_First_Seen_=0)),COUNT(__d18(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d18(Date_Last_Seen_=0)),COUNT(__d18(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(__d19)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d19(__NL(Phone10_))),COUNT(__d19(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d19(__NL(Listing_Type_))),COUNT(__d19(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d19(__NL(Publish_Code_))),COUNT(__d19(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d19(__NL(Portability_Indicator_))),COUNT(__d19(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d19(__NL(N_X_X_Type_))),COUNT(__d19(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d19(__NL(C_O_C_Type_))),COUNT(__d19(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d19(__NL(S_C_C_))),COUNT(__d19(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d19(__NL(Ported_Match_))),COUNT(__d19(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d19(__NL(Phone_Use_))),COUNT(__d19(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d19(__NL(Phone_Number_Company_Type_))),COUNT(__d19(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d19(__NL(Prior_Area_Code_))),COUNT(__d19(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d19(__NL(Is_Active_))),COUNT(__d19(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d19(__NL(Carrier_Name_))),COUNT(__d19(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d19(__NL(Confidence_Score_))),COUNT(__d19(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d19(__NL(No_Solicit_Code_))),COUNT(__d19(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d19(__NL(Maximum_Confidence_Score_))),COUNT(__d19(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d19(__NL(Minimum_Confidence_Score_))),COUNT(__d19(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d19(__NL(Omit_Indicator_))),COUNT(__d19(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d19(__NL(Current_Flag_))),COUNT(__d19(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d19(__NL(Business_Flag_))),COUNT(__d19(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d19(__NL(Phone_Quality_))),COUNT(__d19(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d19(__NL(T_N_T_))),COUNT(__d19(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d19(__NL(Record_Type_))),COUNT(__d19(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_source',COUNT(__d19(__NL(Source_File_))),COUNT(__d19(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iver_indicator',COUNT(__d19(__NL(Iver_Indicator_))),COUNT(__d19(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d19(__NL(Phone_Type_))),COUNT(__d19(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d19(__NL(Validation_Flag_))),COUNT(__d19(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d19(__NL(Validation_Date_))),COUNT(__d19(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d19(__NL(Is_Phone_Marketable_))),COUNT(__d19(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d19(__NL(Phone_Marketability_Score_))),COUNT(__d19(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d19(__NL(Date_Vendor_First_Reported_))),COUNT(__d19(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d19(__NL(Date_Vendor_Last_Reported_))),COUNT(__d19(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d19(__NL(Source_))),COUNT(__d19(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d19(__NL(Original_Source_))),COUNT(__d19(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d19(Date_First_Seen_=0)),COUNT(__d19(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d19(Date_Last_Seen_=0)),COUNT(__d19(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Did_Phone_Invalid),COUNT(__d20)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d20(__NL(Phone10_))),COUNT(__d20(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d20(__NL(Listing_Type_))),COUNT(__d20(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d20(__NL(Publish_Code_))),COUNT(__d20(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d20(__NL(Portability_Indicator_))),COUNT(__d20(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d20(__NL(N_X_X_Type_))),COUNT(__d20(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d20(__NL(C_O_C_Type_))),COUNT(__d20(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d20(__NL(S_C_C_))),COUNT(__d20(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d20(__NL(Ported_Match_))),COUNT(__d20(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d20(__NL(Phone_Use_))),COUNT(__d20(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d20(__NL(Phone_Number_Company_Type_))),COUNT(__d20(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d20(__NL(Prior_Area_Code_))),COUNT(__d20(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d20(__NL(Is_Active_))),COUNT(__d20(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d20(__NL(Carrier_Name_))),COUNT(__d20(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d20(__NL(Confidence_Score_))),COUNT(__d20(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d20(__NL(No_Solicit_Code_))),COUNT(__d20(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d20(__NL(Maximum_Confidence_Score_))),COUNT(__d20(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d20(__NL(Minimum_Confidence_Score_))),COUNT(__d20(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d20(__NL(Omit_Indicator_))),COUNT(__d20(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d20(__NL(Current_Flag_))),COUNT(__d20(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d20(__NL(Business_Flag_))),COUNT(__d20(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d20(__NL(Phone_Quality_))),COUNT(__d20(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d20(__NL(T_N_T_))),COUNT(__d20(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d20(__NL(Record_Type_))),COUNT(__d20(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_source',COUNT(__d20(__NL(Source_File_))),COUNT(__d20(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iver_indicator',COUNT(__d20(__NL(Iver_Indicator_))),COUNT(__d20(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d20(__NL(Phone_Type_))),COUNT(__d20(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d20(__NL(Validation_Flag_))),COUNT(__d20(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d20(__NL(Validation_Date_))),COUNT(__d20(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d20(__NL(Is_Phone_Marketable_))),COUNT(__d20(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d20(__NL(Phone_Marketability_Score_))),COUNT(__d20(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d20(__NL(Date_Vendor_First_Reported_))),COUNT(__d20(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d20(__NL(Date_Vendor_Last_Reported_))),COUNT(__d20(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d20(__NL(Source_))),COUNT(__d20(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d20(__NL(Original_Source_))),COUNT(__d20(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d20(Date_First_Seen_=0)),COUNT(__d20(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d20(Date_Last_Seen_=0)),COUNT(__d20(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(__d21)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d21(__NL(Phone10_))),COUNT(__d21(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d21(__NL(Listing_Type_))),COUNT(__d21(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d21(__NL(Publish_Code_))),COUNT(__d21(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d21(__NL(Portability_Indicator_))),COUNT(__d21(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d21(__NL(N_X_X_Type_))),COUNT(__d21(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d21(__NL(C_O_C_Type_))),COUNT(__d21(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d21(__NL(S_C_C_))),COUNT(__d21(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d21(__NL(Ported_Match_))),COUNT(__d21(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d21(__NL(Phone_Use_))),COUNT(__d21(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d21(__NL(Phone_Number_Company_Type_))),COUNT(__d21(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d21(__NL(Prior_Area_Code_))),COUNT(__d21(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d21(__NL(Is_Active_))),COUNT(__d21(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d21(__NL(Carrier_Name_))),COUNT(__d21(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d21(__NL(Confidence_Score_))),COUNT(__d21(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d21(__NL(No_Solicit_Code_))),COUNT(__d21(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d21(__NL(Maximum_Confidence_Score_))),COUNT(__d21(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d21(__NL(Minimum_Confidence_Score_))),COUNT(__d21(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d21(__NL(Omit_Indicator_))),COUNT(__d21(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d21(__NL(Current_Flag_))),COUNT(__d21(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d21(__NL(Business_Flag_))),COUNT(__d21(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d21(__NL(Phone_Quality_))),COUNT(__d21(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d21(__NL(T_N_T_))),COUNT(__d21(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d21(__NL(Record_Type_))),COUNT(__d21(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d21(__NL(Source_File_))),COUNT(__d21(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d21(__NL(Iver_Indicator_))),COUNT(__d21(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d21(__NL(Phone_Type_))),COUNT(__d21(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d21(__NL(Validation_Flag_))),COUNT(__d21(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d21(__NL(Validation_Date_))),COUNT(__d21(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d21(__NL(Is_Phone_Marketable_))),COUNT(__d21(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d21(__NL(Phone_Marketability_Score_))),COUNT(__d21(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d21(__NL(Date_Vendor_First_Reported_))),COUNT(__d21(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d21(__NL(Date_Vendor_Last_Reported_))),COUNT(__d21(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d21(__NL(Source_))),COUNT(__d21(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d21(__NL(Original_Source_))),COUNT(__d21(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d21(Date_First_Seen_=0)),COUNT(__d21(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d21(Date_Last_Seen_=0)),COUNT(__d21(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid),COUNT(__d22)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d22(__NL(Phone10_))),COUNT(__d22(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d22(__NL(Listing_Type_))),COUNT(__d22(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_publish_code',COUNT(__d22(__NL(Publish_Code_))),COUNT(__d22(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_portability_indicator',COUNT(__d22(__NL(Portability_Indicator_))),COUNT(__d22(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_nxx_type',COUNT(__d22(__NL(N_X_X_Type_))),COUNT(__d22(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_coctype',COUNT(__d22(__NL(C_O_C_Type_))),COUNT(__d22(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_scc',COUNT(__d22(__NL(S_C_C_))),COUNT(__d22(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_ported_match',COUNT(__d22(__NL(Ported_Match_))),COUNT(__d22(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_phone_use',COUNT(__d22(__NL(Phone_Use_))),COUNT(__d22(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_company_type',COUNT(__d22(__NL(Phone_Number_Company_Type_))),COUNT(__d22(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d22(__NL(Prior_Area_Code_))),COUNT(__d22(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d22(__NL(Is_Active_))),COUNT(__d22(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_ocn',COUNT(__d22(__NL(Carrier_Name_))),COUNT(__d22(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d22(__NL(Confidence_Score_))),COUNT(__d22(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d22(__NL(No_Solicit_Code_))),COUNT(__d22(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','max_orig_conf_score',COUNT(__d22(__NL(Maximum_Confidence_Score_))),COUNT(__d22(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','min_orig_conf_score',COUNT(__d22(__NL(Minimum_Confidence_Score_))),COUNT(__d22(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d22(__NL(Omit_Indicator_))),COUNT(__d22(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d22(__NL(Current_Flag_))),COUNT(__d22(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d22(__NL(Business_Flag_))),COUNT(__d22(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d22(__NL(Phone_Quality_))),COUNT(__d22(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d22(__NL(T_N_T_))),COUNT(__d22(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_rec_type',COUNT(__d22(__NL(Record_Type_))),COUNT(__d22(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d22(__NL(Source_File_))),COUNT(__d22(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d22(__NL(Iver_Indicator_))),COUNT(__d22(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_phone_type',COUNT(__d22(__NL(Phone_Type_))),COUNT(__d22(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d22(__NL(Validation_Flag_))),COUNT(__d22(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d22(__NL(Validation_Date_))),COUNT(__d22(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d22(__NL(Is_Phone_Marketable_))),COUNT(__d22(__NN(Is_Phone_Marketable_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d22(__NL(Phone_Marketability_Score_))),COUNT(__d22(__NN(Phone_Marketability_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d22(__NL(Date_Vendor_First_Reported_))),COUNT(__d22(__NN(Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d22(__NL(Date_Vendor_Last_Reported_))),COUNT(__d22(__NN(Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d22(__NL(Source_))),COUNT(__d22(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d22(__NL(Original_Source_))),COUNT(__d22(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d22(Date_First_Seen_=0)),COUNT(__d22(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d22(Date_Last_Seen_=0)),COUNT(__d22(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
