//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT ProfileBooster;
IMPORT CFG_Compile FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Person(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Purch_Process_Date_;
    KEL.typ.nstr Purch_History_Flag_;
    KEL.typ.nint Purch_New_Amt_;
    KEL.typ.nint Purch_Total_;
    KEL.typ.nint Purch_Count_;
    KEL.typ.nint Purch_New_Age_Months_;
    KEL.typ.nint Purch_Old_Age_Months_;
    KEL.typ.nint Purch_Item_Count_;
    KEL.typ.nint Purch_Amt_Avg_;
    KEL.typ.nint Purch_Age_;
    KEL.typ.nkdate Purch_D_O_B_;
    KEL.typ.nstr Purch_Marital_Status_;
    KEL.typ.nstr Purch_Gender_;
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
  SHARED __Mapping := 'lexid(DEFAULT:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),purchage(DEFAULT:Purch_Age_:0),purchdob(DEFAULT:Purch_D_O_B_:DATE),purchmaritalstatus(DEFAULT:Purch_Marital_Status_:\'\'),purchgender(DEFAULT:Purch_Gender_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),purchage(DEFAULT:Purch_Age_:0),purchdob(DEFAULT:Purch_D_O_B_:DATE),purchmaritalstatus(DEFAULT:Purch_Marital_Status_:\'\'),purchgender(DEFAULT:Purch_Gender_:\'\'),addr_dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),run_date(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d0_KELfiltered := ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog((UNSIGNED)did != 0);
  EXPORT ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Invalid := __d0_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d0 := PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog'),__Mapping0_Transform(LEFT));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),process_date(OVERRIDE:Purch_Process_Date_:DATE),history_flag(OVERRIDE:Purch_History_Flag_:\'\'),cpi_lastdlr(OVERRIDE:Purch_New_Amt_:0),cpi_totdlr(OVERRIDE:Purch_Total_:0),cpi_totords(OVERRIDE:Purch_Count_:0),lmos(OVERRIDE:Purch_New_Age_Months_:0),omos(OVERRIDE:Purch_Old_Age_Months_:0),ms_totitems(OVERRIDE:Purch_Item_Count_:0),ms_avgdlrs(OVERRIDE:Purch_Amt_Avg_:0),age(OVERRIDE:Purch_Age_:0),dob(OVERRIDE:Purch_D_O_B_:DATE),marital_status(OVERRIDE:Purch_Marital_Status_:\'\'),gen(OVERRIDE:Purch_Gender_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d1_KELfiltered := ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did((UNSIGNED)did != 0);
  EXPORT ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_DunnData_Consumer__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d1 := PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did'),__Mapping1_Transform(LEFT));
  EXPORT InData := __d0 + __d1;
  SHARED InDataDist(KEL.typ.bool sortpe) := IF(sortpe,SORT(InData,UID),DISTRIBUTE(InData,HASH(UID)));
  SHARED InDataDeduped(KEL.typ.bool sortpe) := TABLE(InDataDist(sortpe),{KEL.typ.int __RecordCount := COUNT(GROUP),UID,Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Lex_I_D_Segment_,Date_Of_Birth_,Date_Of_Death_,Gender_,Race_,Race_Description_,Header_Hit_Flag_,Source_,Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_,Purch_Age_,Purch_D_O_B_,Purch_Marital_Status_,Purch_Gender_,Date_First_Seen_,Date_Last_Seen_,__Permits},UID,Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Lex_I_D_Segment_,Date_Of_Birth_,Date_Of_Death_,Gender_,Race_,Race_Description_,Header_Hit_Flag_,Source_,Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_,Purch_Age_,Purch_D_O_B_,Purch_Marital_Status_,Purch_Gender_,Date_First_Seen_,Date_Last_Seen_,__Permits,LOCAL);
  EXPORT PreEntityInternal(KEL.typ.bool sortpe) := ROLLUP(GROUP(InDataDeduped(sortpe),UID,LOCAL),GROUP,TRANSFORM(PreEntityLayout,SELF.__Payload:=PROJECT(ROWS(LEFT),PreEntityPayloadLayout),SELF:=LEFT));
  EXPORT PreEntity := PreEntityInternal(false);
  EXPORT Full_Name_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Birth_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Death_Layout := RECORD
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Dunn_Data_Layout := RECORD
    KEL.typ.nkdate Purch_Process_Date_;
    KEL.typ.nstr Purch_History_Flag_;
    KEL.typ.nint Purch_New_Amt_;
    KEL.typ.nint Purch_Total_;
    KEL.typ.nint Purch_Count_;
    KEL.typ.nint Purch_New_Age_Months_;
    KEL.typ.nint Purch_Old_Age_Months_;
    KEL.typ.nint Purch_Item_Count_;
    KEL.typ.nint Purch_Amt_Avg_;
    KEL.typ.nint Purch_Age_;
    KEL.typ.nkdate Purch_D_O_B_;
    KEL.typ.nstr Purch_Marital_Status_;
    KEL.typ.nstr Purch_Gender_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(Dunn_Data_Layout) Dunn_Data_;
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
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs, ExpandedPreEntityLayout __other) := TRANSFORM
    SELF.Gender_ := KEL.Intake.SingleValue(__recs,Gender_);
    SELF.Lex_I_D_Segment_ := KEL.Intake.SingleValue(__recs,Lex_I_D_Segment_);
    SELF.Full_Name_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Header_Hit_Flag_},Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Header_Hit_Flag_),Full_Name_Layout)(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Of_Birth_,Header_Hit_Flag_},Date_Of_Birth_,Header_Hit_Flag_),Reported_Dates_Of_Birth_Layout)(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Of_Death_},Date_Of_Death_),Reported_Dates_Of_Death_Layout)(__NN(Date_Of_Death_)));
    SELF.Race_ := KEL.Intake.SingleValue(__recs,Race_);
    SELF.Race_Description_ := KEL.Intake.SingleValue(__recs,Race_Description_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Dunn_Data_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_,Purch_Age_,Purch_D_O_B_,Purch_Marital_Status_,Purch_Gender_},Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_,Purch_Age_,Purch_D_O_B_,Purch_Marital_Status_,Purch_Gender_),Dunn_Data_Layout)(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_) OR __NN(Purch_Age_) OR __NN(Purch_D_O_B_) OR __NN(Purch_Marital_Status_) OR __NN(Purch_Gender_)));
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.__Part := __other.__Part;
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r, ExpandedPreEntityLayout __other) := TRANSFORM
    SELF.Full_Name_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Full_Name_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Birth_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Death_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Of_Death_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Dunn_Data_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dunn_Data_Layout,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_) OR __NN(Purch_Age_) OR __NN(Purch_D_O_B_) OR __NN(Purch_Marital_Status_) OR __NN(Purch_Gender_)));
    SELF.__RecordCount := __r.__RecordCount;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.__Part := __other.__Part;
    SELF := __r;
  END;
  SHARED __PreResult := PROJECT(Person_Group(COUNT(__Payload) = 1),Person__Single_Rollup(LEFT.__Payload[1],LEFT)) + PROJECT(Person_Group(COUNT(__Payload) > 1),Person__Rollup(LEFT.__Payload[1],LEFT.__Payload,LEFT));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::ProfileBooster.ProfileBoosterV2_KEL::Person::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(28));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Gender__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Gender_);
  EXPORT Lex_I_D_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_I_D_Segment_);
  EXPORT Race__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Race_);
  EXPORT Race_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Race_Description_);
  EXPORT SanityCheck := DATASET([{COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Invalid),COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_DunnData_Consumer__Key_Did_Invalid),COUNT(Gender__SingleValue_Invalid),COUNT(Lex_I_D_Segment__SingleValue_Invalid),COUNT(Race__SingleValue_Invalid),COUNT(Race_Description__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Invalid,KEL.typ.int ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_DunnData_Consumer__Key_Did_Invalid,KEL.typ.int Gender__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment__SingleValue_Invalid,KEL.typ.int Race__SingleValue_Invalid,KEL.typ.int Race_Description__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','UID',COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Invalid),COUNT(__d0)},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','LexIDSegment',COUNT(__d0(__NL(Lex_I_D_Segment_))),COUNT(__d0(__NN(Lex_I_D_Segment_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','Gender',COUNT(__d0(__NL(Gender_))),COUNT(__d0(__NN(Gender_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','Race',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','RaceDescription',COUNT(__d0(__NL(Race_Description_))),COUNT(__d0(__NN(Race_Description_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchProcessDate',COUNT(__d0(__NL(Purch_Process_Date_))),COUNT(__d0(__NN(Purch_Process_Date_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchHistoryFlag',COUNT(__d0(__NL(Purch_History_Flag_))),COUNT(__d0(__NN(Purch_History_Flag_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchNewAmt',COUNT(__d0(__NL(Purch_New_Amt_))),COUNT(__d0(__NN(Purch_New_Amt_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchTotal',COUNT(__d0(__NL(Purch_Total_))),COUNT(__d0(__NN(Purch_Total_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchCount',COUNT(__d0(__NL(Purch_Count_))),COUNT(__d0(__NN(Purch_Count_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchNewAgeMonths',COUNT(__d0(__NL(Purch_New_Age_Months_))),COUNT(__d0(__NN(Purch_New_Age_Months_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchOldAgeMonths',COUNT(__d0(__NL(Purch_Old_Age_Months_))),COUNT(__d0(__NN(Purch_Old_Age_Months_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchItemCount',COUNT(__d0(__NL(Purch_Item_Count_))),COUNT(__d0(__NN(Purch_Item_Count_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchAmtAvg',COUNT(__d0(__NL(Purch_Amt_Avg_))),COUNT(__d0(__NN(Purch_Amt_Avg_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchAge',COUNT(__d0(__NL(Purch_Age_))),COUNT(__d0(__NN(Purch_Age_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchDOB',COUNT(__d0(__NL(Purch_D_O_B_))),COUNT(__d0(__NN(Purch_D_O_B_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchMaritalStatus',COUNT(__d0(__NL(Purch_Marital_Status_))),COUNT(__d0(__NN(Purch_Marital_Status_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','PurchGender',COUNT(__d0(__NL(Purch_Gender_))),COUNT(__d0(__NN(Purch_Gender_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.Watchdog__Key_Watchdog','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','UID',COUNT(ProfileBooster_ProfileBoosterV2_KEL_Files_NonFCRA_DunnData_Consumer__Key_Did_Invalid),COUNT(__d1)},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','Title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','FirstName',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','MiddleName',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','LastName',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','NameSuffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','LexIDSegment',COUNT(__d1(__NL(Lex_I_D_Segment_))),COUNT(__d1(__NN(Lex_I_D_Segment_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','Gender',COUNT(__d1(__NL(Gender_))),COUNT(__d1(__NN(Gender_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','Race',COUNT(__d1(__NL(Race_))),COUNT(__d1(__NN(Race_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','RaceDescription',COUNT(__d1(__NL(Race_Description_))),COUNT(__d1(__NN(Race_Description_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','process_date',COUNT(__d1(__NL(Purch_Process_Date_))),COUNT(__d1(__NN(Purch_Process_Date_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','history_flag',COUNT(__d1(__NL(Purch_History_Flag_))),COUNT(__d1(__NN(Purch_History_Flag_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','cpi_lastdlr',COUNT(__d1(__NL(Purch_New_Amt_))),COUNT(__d1(__NN(Purch_New_Amt_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','cpi_totdlr',COUNT(__d1(__NL(Purch_Total_))),COUNT(__d1(__NN(Purch_Total_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','cpi_totords',COUNT(__d1(__NL(Purch_Count_))),COUNT(__d1(__NN(Purch_Count_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','lmos',COUNT(__d1(__NL(Purch_New_Age_Months_))),COUNT(__d1(__NN(Purch_New_Age_Months_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','omos',COUNT(__d1(__NL(Purch_Old_Age_Months_))),COUNT(__d1(__NN(Purch_Old_Age_Months_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','ms_totitems',COUNT(__d1(__NL(Purch_Item_Count_))),COUNT(__d1(__NN(Purch_Item_Count_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','ms_avgdlrs',COUNT(__d1(__NL(Purch_Amt_Avg_))),COUNT(__d1(__NN(Purch_Amt_Avg_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','age',COUNT(__d1(__NL(Purch_Age_))),COUNT(__d1(__NN(Purch_Age_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','dob',COUNT(__d1(__NL(Purch_D_O_B_))),COUNT(__d1(__NN(Purch_D_O_B_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','marital_status',COUNT(__d1(__NL(Purch_Marital_Status_))),COUNT(__d1(__NN(Purch_Marital_Status_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','gen',COUNT(__d1(__NL(Purch_Gender_))),COUNT(__d1(__NN(Purch_Gender_)))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Person','ProfileBooster.ProfileBoosterV2_KEL.Files.NonFCRA.DunnData_Consumer__Key_Did','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
