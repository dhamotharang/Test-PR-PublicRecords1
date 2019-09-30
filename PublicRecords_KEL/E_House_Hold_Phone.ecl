//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Household,E_Phone FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_House_Hold_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Household().Typ) Household_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phonenumber(DEFAULT:Phone_Number_:0),household(DEFAULT:Household_:0),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'phone10(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_DID,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_DID),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'phone10(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Address,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Address),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'phone10(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'phone_number(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_3Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Address),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'phone_number(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_4Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone_number != 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'cellphone(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_5Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'cellphone(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_6Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_6Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'phone(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_7Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Phone),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone != 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'phone(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Did_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Did_Phone),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)hhid != 0 AND (UNSIGNED)phone != 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'cellphone(OVERRIDE:Phone_Number_:0),hhid(OVERRIDE:Household_:0),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_9Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)HHID <> 0 and (UNSIGNED)cellphone != 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered;
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Household().Typ) Household_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Phone_Number_,Household_,ALL));
  House_Hold_Phone_Group := __PostFilter;
  Layout House_Hold_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout House_Hold_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(House_Hold_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,House_Hold_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(House_Hold_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,House_Hold_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Household__Orphan := JOIN(InData(__NN(Household_)),E_Household(__in,__cfg).__Result,__EEQP(LEFT.Household_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Phone_Number__Orphan),COUNT(Household__Orphan)}],{KEL.typ.int Phone_Number__Orphan,KEL.typ.int Household__Orphan});
  EXPORT NullCounts := DATASET([
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d0(__NL(Household_))),COUNT(__d0(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d1(__NL(Household_))),COUNT(__d1(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d2(__NL(Household_))),COUNT(__d2(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d3(__NL(Household_))),COUNT(__d3(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d4(__NL(Household_))),COUNT(__d4(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d5(__NL(Household_))),COUNT(__d5(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d6(__NL(Household_))),COUNT(__d6(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d7(__NL(Household_))),COUNT(__d7(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d8(__NL(Household_))),COUNT(__d8(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d9(__NL(Phone_Number_))),COUNT(__d9(__NN(Phone_Number_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hhid',COUNT(__d9(__NL(Household_))),COUNT(__d9(__NN(Household_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'HouseHoldPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
