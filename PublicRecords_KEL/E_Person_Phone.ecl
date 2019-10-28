﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Phone FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Person_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nint Owner_Flag_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nint Source_File_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),phonenumber(DEFAULT:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),pflag2(OVERRIDE:Phone_Quality_:\'\'),tnt(OVERRIDE:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),phone10(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_DID,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_DID),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'did(OVERRIDE:Subject_:0),phone_number(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),no_solicitation_code(OVERRIDE:No_Solicit_Code_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),phone_type(OVERRIDE:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validation_date(OVERRIDE:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_4Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_5Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)did<>0 AND (UNSIGNED)phone <> 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'did(OVERRIDE:Subject_:0),cellphone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_6Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_6Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)did != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),file_source(OVERRIDE:Source_File_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_7Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Did_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Did_Phone),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:Subject_:0),cellphone(OVERRIDE:Phone_Number_:0),append_latest_phone_owner_flag(OVERRIDE:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),phonequality(DEFAULT:Phone_Quality_:\'\'),tnt(DEFAULT:T_N_T_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),iverindicator(DEFAULT:Iver_Indicator_:0),sourcefile(DEFAULT:Source_File_:0),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)did != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8;
  EXPORT Header_Phone_Quality_Layout := RECORD
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Owner_Layout := RECORD
    KEL.typ.nint Owner_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Details_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(Header_Phone_Quality_Layout) Header_Phone_Quality_;
    KEL.typ.ndataset(Owner_Layout) Owner_;
    KEL.typ.ndataset(Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Phone_Number_,ALL));
  Person_Phone_Group := __PostFilter;
  Layout Person_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Header_Phone_Quality_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Phone_Quality_,T_N_T_},Phone_Quality_,T_N_T_),Header_Phone_Quality_Layout)(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Owner_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Owner_Flag_},Owner_Flag_),Owner_Layout)(__NN(Owner_Flag_)));
    SELF.Phone_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Confidence_Score_,No_Solicit_Code_,Record_Type_,Phone_Type_,Validation_Flag_,Validation_Date_,Source_File_,Iver_Indicator_,Source_},Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Confidence_Score_,No_Solicit_Code_,Record_Type_,Phone_Type_,Validation_Flag_,Validation_Date_,Source_File_,Iver_Indicator_,Source_),Phone_Details_Layout)(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Confidence_Score_) OR __NN(No_Solicit_Code_) OR __NN(Record_Type_) OR __NN(Phone_Type_) OR __NN(Validation_Flag_) OR __NN(Validation_Date_) OR __NN(Source_File_) OR __NN(Iver_Indicator_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_,Header_Hit_Flag_},Source_,Original_Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Header_Phone_Quality_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Header_Phone_Quality_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Owner_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Owner_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Owner_Flag_)));
    SELF.Phone_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Details_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Confidence_Score_) OR __NN(No_Solicit_Code_) OR __NN(Record_Type_) OR __NN(Phone_Type_) OR __NN(Validation_Flag_) OR __NN(Validation_Date_) OR __NN(Source_File_) OR __NN(Iver_Indicator_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d0(__NL(Owner_Flag_))),COUNT(__d0(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pflag2',COUNT(__d0(__NL(Phone_Quality_))),COUNT(__d0(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tnt',COUNT(__d0(__NL(T_N_T_))),COUNT(__d0(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d0(__NL(Phone_Type_))),COUNT(__d0(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d0(__NL(Validation_Date_))),COUNT(__d0(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d1(__NL(Owner_Flag_))),COUNT(__d1(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d1(__NL(Phone_Quality_))),COUNT(__d1(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d1(__NL(T_N_T_))),COUNT(__d1(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d1(__NL(Phone_Type_))),COUNT(__d1(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d1(__NL(Validation_Date_))),COUNT(__d1(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d2(__NL(Owner_Flag_))),COUNT(__d2(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d2(__NL(Phone_Quality_))),COUNT(__d2(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d2(__NL(T_N_T_))),COUNT(__d2(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d2(__NL(No_Solicit_Code_))),COUNT(__d2(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d2(__NL(Phone_Type_))),COUNT(__d2(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d2(__NL(Validation_Flag_))),COUNT(__d2(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d2(__NL(Validation_Date_))),COUNT(__d2(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d2(__NL(Confidence_Score_))),COUNT(__d2(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d2(__NL(Iver_Indicator_))),COUNT(__d2(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d3(__NL(Owner_Flag_))),COUNT(__d3(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d3(__NL(Phone_Quality_))),COUNT(__d3(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d3(__NL(T_N_T_))),COUNT(__d3(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d3(__NL(No_Solicit_Code_))),COUNT(__d3(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d3(__NL(Phone_Type_))),COUNT(__d3(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d3(__NL(Validation_Flag_))),COUNT(__d3(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d3(__NL(Validation_Date_))),COUNT(__d3(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d3(__NL(Confidence_Score_))),COUNT(__d3(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d3(__NL(Iver_Indicator_))),COUNT(__d3(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d4(__NL(Owner_Flag_))),COUNT(__d4(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d4(__NL(Phone_Quality_))),COUNT(__d4(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d4(__NL(T_N_T_))),COUNT(__d4(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_solicitation_code',COUNT(__d4(__NL(No_Solicit_Code_))),COUNT(__d4(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_type',COUNT(__d4(__NL(Phone_Type_))),COUNT(__d4(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_flag',COUNT(__d4(__NL(Validation_Flag_))),COUNT(__d4(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_date',COUNT(__d4(__NL(Validation_Date_))),COUNT(__d4(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d4(__NL(Confidence_Score_))),COUNT(__d4(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d4(__NL(Iver_Indicator_))),COUNT(__d4(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d4(__NL(Source_File_))),COUNT(__d4(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d5(__NL(Owner_Flag_))),COUNT(__d5(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d5(__NL(Phone_Quality_))),COUNT(__d5(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d5(__NL(T_N_T_))),COUNT(__d5(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d5(__NL(No_Solicit_Code_))),COUNT(__d5(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d5(__NL(Phone_Type_))),COUNT(__d5(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d5(__NL(Validation_Flag_))),COUNT(__d5(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d5(__NL(Validation_Date_))),COUNT(__d5(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d5(__NL(Confidence_Score_))),COUNT(__d5(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d5(__NL(Iver_Indicator_))),COUNT(__d5(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d5(__NL(Source_File_))),COUNT(__d5(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d6(__NL(Owner_Flag_))),COUNT(__d6(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d6(__NL(Phone_Quality_))),COUNT(__d6(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d6(__NL(T_N_T_))),COUNT(__d6(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d6(__NL(No_Solicit_Code_))),COUNT(__d6(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d6(__NL(Phone_Type_))),COUNT(__d6(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d6(__NL(Validation_Flag_))),COUNT(__d6(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d6(__NL(Validation_Date_))),COUNT(__d6(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d6(__NL(Confidence_Score_))),COUNT(__d6(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d6(__NL(Iver_Indicator_))),COUNT(__d6(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d6(__NL(Source_File_))),COUNT(__d6(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d7(__NL(Subject_))),COUNT(__d7(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d7(__NL(Owner_Flag_))),COUNT(__d7(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d7(__NL(Phone_Quality_))),COUNT(__d7(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d7(__NL(T_N_T_))),COUNT(__d7(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d7(__NL(Prior_Area_Code_))),COUNT(__d7(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d7(__NL(Current_Flag_))),COUNT(__d7(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d7(__NL(Business_Flag_))),COUNT(__d7(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d7(__NL(Publish_Code_))),COUNT(__d7(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d7(__NL(Listing_Type_))),COUNT(__d7(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d7(__NL(Omit_Indicator_))),COUNT(__d7(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d7(__NL(No_Solicit_Code_))),COUNT(__d7(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d7(__NL(Record_Type_))),COUNT(__d7(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d7(__NL(Phone_Type_))),COUNT(__d7(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d7(__NL(Validation_Flag_))),COUNT(__d7(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d7(__NL(Validation_Date_))),COUNT(__d7(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d7(__NL(Confidence_Score_))),COUNT(__d7(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iver_indicator',COUNT(__d7(__NL(Iver_Indicator_))),COUNT(__d7(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_source',COUNT(__d7(__NL(Source_File_))),COUNT(__d7(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d8(__NL(Subject_))),COUNT(__d8(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_latest_phone_owner_flag',COUNT(__d8(__NL(Owner_Flag_))),COUNT(__d8(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d8(__NL(Phone_Quality_))),COUNT(__d8(__NN(Phone_Quality_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d8(__NL(T_N_T_))),COUNT(__d8(__NN(T_N_T_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d8(__NL(Prior_Area_Code_))),COUNT(__d8(__NN(Prior_Area_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d8(__NL(Current_Flag_))),COUNT(__d8(__NN(Current_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d8(__NL(Business_Flag_))),COUNT(__d8(__NN(Business_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d8(__NL(Publish_Code_))),COUNT(__d8(__NN(Publish_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d8(__NL(Listing_Type_))),COUNT(__d8(__NN(Listing_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d8(__NL(Omit_Indicator_))),COUNT(__d8(__NN(Omit_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d8(__NL(No_Solicit_Code_))),COUNT(__d8(__NN(No_Solicit_Code_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d8(__NL(Record_Type_))),COUNT(__d8(__NN(Record_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d8(__NL(Phone_Type_))),COUNT(__d8(__NN(Phone_Type_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d8(__NL(Validation_Flag_))),COUNT(__d8(__NN(Validation_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d8(__NL(Validation_Date_))),COUNT(__d8(__NN(Validation_Date_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d8(__NL(Confidence_Score_))),COUNT(__d8(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d8(__NL(Iver_Indicator_))),COUNT(__d8(__NN(Iver_Indicator_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d8(__NL(Source_File_))),COUNT(__d8(__NN(Source_File_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
