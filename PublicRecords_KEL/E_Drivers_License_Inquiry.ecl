﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Drivers_License,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Drivers_License_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Drivers_License().Typ) License_Information_;
    KEL.typ.ntyp(E_Inquiry().Typ) Inquiry_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'License_Information_(DEFAULT:License_Information_:0),Inquiry_(DEFAULT:Inquiry_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'License_Information_(DEFAULT:License_Information_:0),Inquiry_(DEFAULT:Inquiry_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(person_q.dl <> '' OR person_q.dl_st <> '');
  SHARED __d0_License_Information__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid License_Information_;
  END;
  SHARED __d0_License_Information__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'person_q.dl,person_q.dl_st','__in'),E_Drivers_License(__in,__cfg).Lookup,TRIM((STRING)LEFT.person_q.dl) + '|' + TRIM((STRING)LEFT.person_q.dl_st) = RIGHT.KeyVal,TRANSFORM(__d0_License_Information__Layout,SELF.License_Information_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Inquiry__Layout := RECORD
    RECORDOF(__d0_License_Information__Mapped);
    KEL.typ.uid Inquiry_;
  END;
  SHARED __d0_Inquiry__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_License_Information__Mapped,'search_info.transaction_id,SequenceNumber','__in'),E_Inquiry(__in,__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.SequenceNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Inquiry__Layout,SELF.Inquiry_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Inquiry__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License().Typ) License_Information_;
    KEL.typ.ntyp(E_Inquiry().Typ) Inquiry_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,License_Information_,Inquiry_,ALL));
  Drivers_License_Inquiry_Group := __PostFilter;
  Layout Drivers_License_Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Drivers_License_Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Drivers_License_Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Drivers_License_Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Drivers_License_Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Drivers_License_Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT License_Information__Orphan := JOIN(InData(__NN(License_Information_)),E_Drivers_License(__in,__cfg).__Result,__EEQP(LEFT.License_Information_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Inquiry__Orphan := JOIN(InData(__NN(Inquiry_)),E_Inquiry(__in,__cfg).__Result,__EEQP(LEFT.Inquiry_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(License_Information__Orphan),COUNT(Inquiry__Orphan)}],{KEL.typ.int License_Information__Orphan,KEL.typ.int Inquiry__Orphan});
  EXPORT NullCounts := DATASET([
    {'DriversLicenseInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseInformation',COUNT(__d0(__NL(License_Information_))),COUNT(__d0(__NN(License_Information_)))},
    {'DriversLicenseInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Inquiry',COUNT(__d0(__NL(Inquiry_))),COUNT(__d0(__NN(Inquiry_)))},
    {'DriversLicenseInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'DriversLicenseInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'DriversLicenseInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
