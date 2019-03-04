//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Social_Security_Number(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nkdate Official_First_Seen_;
    KEL.typ.nkdate Official_Last_Seen_;
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nstr Issue_State_;
    KEL.typ.nkdate Header_First_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),issuestate(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dod(Date_Of_Death_:DATE),st(Issue_State_:\'\'),dt_first_seen(Header_First_Seen_:DATE|Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),src(Source_:\'\'),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),st(Issue_State_:\'\'),dt_first_seen(Header_First_Seen_:DATE|Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),src(Source_:\'\'),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),st(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid := __d2_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),issuestate(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid := __d3_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),issuestate(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid := __d4_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4),__Mapping4_Transform(LEFT)));
  SHARED __Mapping5 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),st(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid := __d5_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'ssn(UID|S_S_N_:\'\'),officialfirstseen(Official_First_Seen_:DATE),officiallastseen(Official_Last_Seen_:DATE),dateofdeath(Date_Of_Death_:DATE),st(Issue_State_:\'\'),headerfirstseen(Header_First_Seen_:DATE),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid := __d6_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6),__Mapping6_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6;
  EXPORT Dates_Of_Death_Layout := RECORD
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nkdate Official_First_Seen_;
    KEL.typ.nkdate Official_Last_Seen_;
    KEL.typ.nstr Issue_State_;
    KEL.typ.nkdate Header_First_Seen_;
    KEL.typ.ndataset(Dates_Of_Death_Layout) Dates_Of_Death_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Social_Security_Number_Group := __PostFilter;
  Layout Social_Security_Number__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_S_N_ := KEL.Intake.SingleValue(__recs,S_S_N_);
    SELF.Official_First_Seen_ := KEL.Intake.SingleValue(__recs,Official_First_Seen_);
    SELF.Official_Last_Seen_ := KEL.Intake.SingleValue(__recs,Official_Last_Seen_);
    SELF.Issue_State_ := KEL.Intake.SingleValue(__recs,Issue_State_);
    SELF.Header_First_Seen_ := KEL.Intake.SingleValue(__recs,Header_First_Seen_);
    SELF.Dates_Of_Death_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Of_Death_},Date_Of_Death_),Dates_Of_Death_Layout)(__NN(Date_Of_Death_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Social_Security_Number__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Dates_Of_Death_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dates_Of_Death_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Of_Death_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Social_Security_Number_Group,COUNT(ROWS(LEFT))=1),GROUP,Social_Security_Number__Single_Rollup(LEFT)) + ROLLUP(HAVING(Social_Security_Number_Group,COUNT(ROWS(LEFT))>1),GROUP,Social_Security_Number__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT S_S_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,S_S_N_);
  EXPORT Official_First_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Official_First_Seen_);
  EXPORT Official_Last_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Official_Last_Seen_);
  EXPORT Issue_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Issue_State_);
  EXPORT Header_First_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Header_First_Seen_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid),COUNT(S_S_N__SingleValue_Invalid),COUNT(Official_First_Seen__SingleValue_Invalid),COUNT(Official_Last_Seen__SingleValue_Invalid),COUNT(Issue_State__SingleValue_Invalid),COUNT(Header_First_Seen__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid,KEL.typ.int S_S_N__SingleValue_Invalid,KEL.typ.int Official_First_Seen__SingleValue_Invalid,KEL.typ.int Official_Last_Seen__SingleValue_Invalid,KEL.typ.int Issue_State__SingleValue_Invalid,KEL.typ.int Header_First_Seen__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d0(__NL(S_S_N_))),COUNT(__d0(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d0(__NL(Official_First_Seen_))),COUNT(__d0(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d0(__NL(Official_Last_Seen_))),COUNT(__d0(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(Issue_State_))),COUNT(__d0(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d0(__NL(Header_First_Seen_))),COUNT(__d0(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d1(__NL(S_S_N_))),COUNT(__d1(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d1(__NL(Official_First_Seen_))),COUNT(__d1(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d1(__NL(Official_Last_Seen_))),COUNT(__d1(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d1(__NL(Issue_State_))),COUNT(__d1(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d1(__NL(Header_First_Seen_))),COUNT(__d1(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(__d2)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d2(__NL(S_S_N_))),COUNT(__d2(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d2(__NL(Official_First_Seen_))),COUNT(__d2(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d2(__NL(Official_Last_Seen_))),COUNT(__d2(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d2(__NL(Issue_State_))),COUNT(__d2(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d2(__NL(Header_First_Seen_))),COUNT(__d2(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(__d3)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d3(__NL(S_S_N_))),COUNT(__d3(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d3(__NL(Official_First_Seen_))),COUNT(__d3(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d3(__NL(Official_Last_Seen_))),COUNT(__d3(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d3(__NL(Date_Of_Death_))),COUNT(__d3(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IssueState',COUNT(__d3(__NL(Issue_State_))),COUNT(__d3(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d3(__NL(Header_First_Seen_))),COUNT(__d3(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(__d4)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d4(__NL(S_S_N_))),COUNT(__d4(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d4(__NL(Official_First_Seen_))),COUNT(__d4(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d4(__NL(Official_Last_Seen_))),COUNT(__d4(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d4(__NL(Date_Of_Death_))),COUNT(__d4(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IssueState',COUNT(__d4(__NL(Issue_State_))),COUNT(__d4(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d4(__NL(Header_First_Seen_))),COUNT(__d4(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid),COUNT(__d5)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d5(__NL(S_S_N_))),COUNT(__d5(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d5(__NL(Official_First_Seen_))),COUNT(__d5(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d5(__NL(Official_Last_Seen_))),COUNT(__d5(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d5(__NL(Date_Of_Death_))),COUNT(__d5(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d5(__NL(Issue_State_))),COUNT(__d5(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d5(__NL(Header_First_Seen_))),COUNT(__d5(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid),COUNT(__d6)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d6(__NL(S_S_N_))),COUNT(__d6(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d6(__NL(Official_First_Seen_))),COUNT(__d6(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d6(__NL(Official_Last_Seen_))),COUNT(__d6(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d6(__NL(Date_Of_Death_))),COUNT(__d6(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d6(__NL(Issue_State_))),COUNT(__d6(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d6(__NL(Header_First_Seen_))),COUNT(__d6(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
