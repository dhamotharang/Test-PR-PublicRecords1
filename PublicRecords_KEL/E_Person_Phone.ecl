//HPCC Systems KEL Compiler Version 1.1.0beta2
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
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),phonenumber(DEFAULT:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
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
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_Address),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'did(OVERRIDE:Subject_:0),phone10(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_DID,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_DID),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'did(OVERRIDE:Subject_:0),phone10(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Address,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Address),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'did(OVERRIDE:Subject_:0),phone10(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:Subject_:0),phone_number(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Address),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'did(OVERRIDE:Subject_:0),phone_number(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_9Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered;
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping10 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_10Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_10Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((UNSIGNED)did<>0 AND (UNSIGNED)phone <> 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered;
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping11 := 'did(OVERRIDE:Subject_:0),cellphone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_11Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_11Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((UNSIGNED)did != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d11_Prefiltered := __d11_KELfiltered;
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping12 := 'did(OVERRIDE:Subject_:0),cellphone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_12Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_12Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((UNSIGNED)did != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered;
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping13 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_13Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_13Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Phone),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d13_Prefiltered := __d13_KELfiltered;
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping14 := 'did(OVERRIDE:Subject_:0),phone(OVERRIDE:Phone_Number_:0),ownerflag(DEFAULT:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_14Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_14Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Did_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Did_Phone),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d14_Prefiltered := __d14_KELfiltered;
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_15Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping15 := 'did(OVERRIDE:Subject_:0),cellphone(OVERRIDE:Phone_Number_:0),append_latest_phone_owner_flag(OVERRIDE:Owner_Flag_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_15Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_15Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm((UNSIGNED)did != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d15_Prefiltered := __d15_KELfiltered;
  SHARED __d15 := __SourceFilter(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15;
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
    KEL.typ.nint Owner_Flag_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Phone_Number_,Owner_Flag_,ALL));
  Person_Phone_Group := __PostFilter;
  Layout Person_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_,Header_Hit_Flag_},Source_,Original_Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Phone__Single_Rollup(InLayout __r) := TRANSFORM
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
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d1(__NL(Owner_Flag_))),COUNT(__d1(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d2(__NL(Owner_Flag_))),COUNT(__d2(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d3(__NL(Owner_Flag_))),COUNT(__d3(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d4(__NL(Owner_Flag_))),COUNT(__d4(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d5(__NL(Owner_Flag_))),COUNT(__d5(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d6(__NL(Owner_Flag_))),COUNT(__d6(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d7(__NL(Subject_))),COUNT(__d7(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d7(__NL(Owner_Flag_))),COUNT(__d7(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d8(__NL(Subject_))),COUNT(__d8(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d8(__NL(Owner_Flag_))),COUNT(__d8(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d9(__NL(Subject_))),COUNT(__d9(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d9(__NL(Phone_Number_))),COUNT(__d9(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d9(__NL(Owner_Flag_))),COUNT(__d9(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d9(__NL(Header_Hit_Flag_))),COUNT(__d9(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d10(__NL(Subject_))),COUNT(__d10(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d10(__NL(Phone_Number_))),COUNT(__d10(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d10(__NL(Owner_Flag_))),COUNT(__d10(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d10(__NL(Original_Source_))),COUNT(__d10(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d11(__NL(Subject_))),COUNT(__d11(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d11(__NL(Phone_Number_))),COUNT(__d11(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d11(__NL(Owner_Flag_))),COUNT(__d11(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d11(__NL(Header_Hit_Flag_))),COUNT(__d11(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d11(__NL(Original_Source_))),COUNT(__d11(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d12(__NL(Subject_))),COUNT(__d12(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d12(__NL(Phone_Number_))),COUNT(__d12(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d12(__NL(Owner_Flag_))),COUNT(__d12(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d12(__NL(Header_Hit_Flag_))),COUNT(__d12(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d12(__NL(Original_Source_))),COUNT(__d12(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d13(__NL(Subject_))),COUNT(__d13(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d13(__NL(Phone_Number_))),COUNT(__d13(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d13(__NL(Owner_Flag_))),COUNT(__d13(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d13(__NL(Original_Source_))),COUNT(__d13(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d14(__NL(Subject_))),COUNT(__d14(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d14(__NL(Phone_Number_))),COUNT(__d14(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerFlag',COUNT(__d14(__NL(Owner_Flag_))),COUNT(__d14(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d14(__NL(Header_Hit_Flag_))),COUNT(__d14(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d14(__NL(Original_Source_))),COUNT(__d14(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d15(__NL(Subject_))),COUNT(__d15(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d15(__NL(Phone_Number_))),COUNT(__d15(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_latest_phone_owner_flag',COUNT(__d15(__NL(Owner_Flag_))),COUNT(__d15(__NN(Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d15(__NL(Header_Hit_Flag_))),COUNT(__d15(__NN(Header_Hit_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d15(__NL(Original_Source_))),COUNT(__d15(__NN(Original_Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
