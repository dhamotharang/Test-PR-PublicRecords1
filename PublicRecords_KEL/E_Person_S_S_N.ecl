//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Person_S_S_N(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Addr_Date_First_Seen_;
    KEL.typ.nkdate Run_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),social(DEFAULT:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),src(OVERRIDE:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),src(OVERRIDE:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'appended_adl(OVERRIDE:Subject_:0),person_q.ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((unsigned) appended_adl != 0 AND (UNSIGNED)person_q.ssn != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Death_MasterV2_SSA_DID,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Death_MasterV2_SSA_DID),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Death_MasterV2__key_ssn_ssa,TRANSFORM(RECORDOF(__in.Dataset_Death_MasterV2__key_ssn_ssa),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'appended_lexid(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),addrdatefirstseen(DEFAULT:Addr_Date_First_Seen_:DATE),rundate(DEFAULT:Run_Date_:DATE),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Fraudpoint3__Key_SSN,TRANSFORM(RECORDOF(__in.Dataset_Fraudpoint3__Key_SSN),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((unsigned)appended_lexid!=0 AND (unsigned) ssn != 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Addr_Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Run_Date_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'rec.did(OVERRIDE:Subject_:0),rec.ssn(OVERRIDE:Social_:0),src(OVERRIDE:Source_:\'\'),rec.addr_dt_first_seen(OVERRIDE:Addr_Date_First_Seen_:DATE:Addr_Date_First_Seen_6Rule),rec.run_date(OVERRIDE:Run_Date_:DATE:Run_Date_6Rule),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)rec.did != 0 AND (UNSIGNED)rec.ssn != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping6_Transform(LEFT)));
  SHARED Addr_Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Run_Date_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),src(OVERRIDE:Source_:\'\'),addr_dt_first_seen(OVERRIDE:Addr_Date_First_Seen_:DATE:Addr_Date_First_Seen_7Rule),run_date(OVERRIDE:Run_Date_:DATE:Run_Date_7Rule),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered;
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping7_Transform(LEFT)));
  SHARED Addr_Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Run_Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),src(OVERRIDE:Source_:\'\'),addr_dt_first_seen(OVERRIDE:Addr_Date_First_Seen_:DATE:Addr_Date_First_Seen_8Rule),run_date(OVERRIDE:Run_Date_:DATE:Run_Date_8Rule),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered;
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping8_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nkdate Addr_Date_First_Seen_;
    KEL.typ.nkdate Run_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Social_,ALL));
  Person_S_S_N_Group := __PostFilter;
  Layout Person_S_S_N__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_,Addr_Date_First_Seen_,Run_Date_},Source_,Header_Hit_Flag_,Addr_Date_First_Seen_,Run_Date_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(Addr_Date_First_Seen_) OR __NN(Run_Date_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_S_S_N__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(Addr_Date_First_Seen_) OR __NN(Run_Date_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_S_S_N__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_S_S_N__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number(__in,__cfg).__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Social__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Social__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d0(__NL(Addr_Date_First_Seen_))),COUNT(__d0(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d0(__NL(Run_Date_))),COUNT(__d0(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d1(__NL(Social_))),COUNT(__d1(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d1(__NL(Addr_Date_First_Seen_))),COUNT(__d1(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d1(__NL(Run_Date_))),COUNT(__d1(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','appended_adl',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d2(__NL(Social_))),COUNT(__d2(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d2(__NL(Addr_Date_First_Seen_))),COUNT(__d2(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d2(__NL(Run_Date_))),COUNT(__d2(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d3(__NL(Social_))),COUNT(__d3(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d3(__NL(Addr_Date_First_Seen_))),COUNT(__d3(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d3(__NL(Run_Date_))),COUNT(__d3(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d4(__NL(Social_))),COUNT(__d4(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d4(__NL(Addr_Date_First_Seen_))),COUNT(__d4(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d4(__NL(Run_Date_))),COUNT(__d4(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(Date_Vendor_First_Reported_=0)),COUNT(__d4(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(Date_Vendor_Last_Reported_=0)),COUNT(__d4(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','appended_lexid',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d5(__NL(Social_))),COUNT(__d5(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddrDateFirstSeen',COUNT(__d5(__NL(Addr_Date_First_Seen_))),COUNT(__d5(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RunDate',COUNT(__d5(__NL(Run_Date_))),COUNT(__d5(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(Date_Vendor_First_Reported_=0)),COUNT(__d5(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(Date_Vendor_Last_Reported_=0)),COUNT(__d5(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.did',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.ssn',COUNT(__d6(__NL(Social_))),COUNT(__d6(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.addr_dt_first_seen',COUNT(__d6(__NL(Addr_Date_First_Seen_))),COUNT(__d6(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.run_date',COUNT(__d6(__NL(Run_Date_))),COUNT(__d6(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d6(Date_Vendor_First_Reported_=0)),COUNT(__d6(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d6(Date_Vendor_Last_Reported_=0)),COUNT(__d6(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d7(__NL(Subject_))),COUNT(__d7(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d7(__NL(Social_))),COUNT(__d7(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_dt_first_seen',COUNT(__d7(__NL(Addr_Date_First_Seen_))),COUNT(__d7(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','run_date',COUNT(__d7(__NL(Run_Date_))),COUNT(__d7(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d7(Date_Vendor_First_Reported_=0)),COUNT(__d7(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d7(Date_Vendor_Last_Reported_=0)),COUNT(__d7(Date_Vendor_Last_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d8(__NL(Subject_))),COUNT(__d8(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d8(__NL(Social_))),COUNT(__d8(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_dt_first_seen',COUNT(__d8(__NL(Addr_Date_First_Seen_))),COUNT(__d8(__NN(Addr_Date_First_Seen_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','run_date',COUNT(__d8(__NL(Run_Date_))),COUNT(__d8(__NN(Run_Date_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d8(Date_Vendor_First_Reported_=0)),COUNT(__d8(Date_Vendor_First_Reported_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d8(Date_Vendor_Last_Reported_=0)),COUNT(__d8(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
