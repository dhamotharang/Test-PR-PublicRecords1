//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Phone FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Person_Score_;
    KEL.typ.nint Name_Score_;
    KEL.typ.nint Best_Name_Match_Flag_;
    KEL.typ.nint Latest_Phone_Owner_Flag_;
    KEL.typ.nint Active_Phone_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),phonenumber(Phone_Number_:0),confidencescore(Confidence_Score_:0),personscore(Person_Score_:0),namescore(Name_Score_:0),bestnamematchflag(Best_Name_Match_Flag_:0),latestphoneownerflag(Latest_Phone_Owner_Flag_:0),activephoneflag(Active_Phone_Flag_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(Subject_:0),phone(Phone_Number_:0),confidencescore(Confidence_Score_:0),personscore(Person_Score_:0),namescore(Name_Score_:0),bestnamematchflag(Best_Name_Match_Flag_:0),latestphoneownerflag(Latest_Phone_Owner_Flag_:0),activephoneflag(Active_Phone_Flag_:0),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(Subject_:0),phone(Phone_Number_:0),confidencescore(Confidence_Score_:0),personscore(Person_Score_:0),namescore(Name_Score_:0),bestnamematchflag(Best_Name_Match_Flag_:0),latestphoneownerflag(Latest_Phone_Owner_Flag_:0),activephoneflag(Active_Phone_Flag_:0),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0 AND (UNSIGNED)phone != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Person_Score_;
    KEL.typ.nint Name_Score_;
    KEL.typ.nint Best_Name_Match_Flag_;
    KEL.typ.nint Latest_Phone_Owner_Flag_;
    KEL.typ.nint Active_Phone_Flag_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Phone_Number_,Confidence_Score_,Person_Score_,Name_Score_,Best_Name_Match_Flag_,Latest_Phone_Owner_Flag_,Active_Phone_Flag_,ALL));
  Person_Phone_Group := __PostFilter;
  Layout Person_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Person_Phone::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonScore',COUNT(__d0(__NL(Person_Score_))),COUNT(__d0(__NN(Person_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d0(__NL(Name_Score_))),COUNT(__d0(__NN(Name_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNameMatchFlag',COUNT(__d0(__NL(Best_Name_Match_Flag_))),COUNT(__d0(__NN(Best_Name_Match_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LatestPhoneOwnerFlag',COUNT(__d0(__NL(Latest_Phone_Owner_Flag_))),COUNT(__d0(__NN(Latest_Phone_Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivePhoneFlag',COUNT(__d0(__NL(Active_Phone_Flag_))),COUNT(__d0(__NN(Active_Phone_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonScore',COUNT(__d1(__NL(Person_Score_))),COUNT(__d1(__NN(Person_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d1(__NL(Name_Score_))),COUNT(__d1(__NN(Name_Score_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestNameMatchFlag',COUNT(__d1(__NL(Best_Name_Match_Flag_))),COUNT(__d1(__NN(Best_Name_Match_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LatestPhoneOwnerFlag',COUNT(__d1(__NL(Latest_Phone_Owner_Flag_))),COUNT(__d1(__NN(Latest_Phone_Owner_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivePhoneFlag',COUNT(__d1(__NL(Active_Phone_Flag_))),COUNT(__d1(__NN(Active_Phone_Flag_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonPhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
