﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Zip_Code_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Zip_Code().Typ) Zip_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'zip(DEFAULT:Zip_:0),subject(DEFAULT:Subject_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'zip(OVERRIDE:Zip_:0),did(OVERRIDE:Subject_:0),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'zip(OVERRIDE:Zip_:0),did(OVERRIDE:Subject_:0),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'zip(OVERRIDE:Zip_:0),s_did(OVERRIDE:Subject_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Header__Key_Addr_Hist,TRANSFORM(RECORDOF(__in.Dataset_Header__Key_Addr_Hist),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED3)zip != 0 AND (UNSIGNED)s_did != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Zip_Code().Typ) Zip_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Zip_,Subject_,ALL));
  Zip_Code_Person_Group := __PostFilter;
  Layout Zip_Code_Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Zip_Code_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Zip_Code_Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Zip_Code_Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Zip_Code_Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Zip_Code_Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Zip__Orphan := JOIN(InData(__NN(Zip_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Zip_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Zip__Orphan),COUNT(Subject__Orphan)}],{KEL.typ.int Zip__Orphan,KEL.typ.int Subject__Orphan});
  EXPORT NullCounts := DATASET([
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Zip_))),COUNT(__d1(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Zip_))),COUNT(__d2(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','s_did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
