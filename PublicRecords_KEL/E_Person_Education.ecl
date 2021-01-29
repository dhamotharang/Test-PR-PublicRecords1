//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Education,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person_Education(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Edu_(DEFAULT:Edu_:0),did(DEFAULT:D_I_D_:\'\'),processdate(DEFAULT:Process_Date_:DATE),historicalflag(DEFAULT:Historical_Flag_:\'\'),class(DEFAULT:Class_:\'\'),collegeclass(DEFAULT:College_Class_:\'\'),collegemajor(DEFAULT:College_Major_:\'\'),newcollegemajor(DEFAULT:New_College_Major_:\'\'),headofhouseholdfirstname(DEFAULT:Head_Of_Household_First_Name_:\'\'),headofhouseholdgendercode(DEFAULT:Head_Of_Household_Gender_Code_:\'\'),headofhouseholdgender(DEFAULT:Head_Of_Household_Gender_:\'\'),rawaid(DEFAULT:Raw_A_I_D_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historical_flag(OVERRIDE:Historical_Flag_:\'\'),class(OVERRIDE:Class_:\'\'),college_class(OVERRIDE:College_Class_:\'\'),college_major(OVERRIDE:College_Major_:\'\'),new_college_major(OVERRIDE:New_College_Major_:\'\'),head_of_household_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),head_of_household_gender_code(OVERRIDE:Head_Of_Household_Gender_Code_:\'\'),head_of_household_gender(OVERRIDE:Head_Of_Household_Gender_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Raw_A_I_D_ := __CN('');
    SELF := __r;
  END;
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault((UNSIGNED)key != 0);
  SHARED __d0_Edu__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d0_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'Key','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault');
  SHARED __d0_Edu__Mapped := IF(__d0_Missing_Edu__UIDComponents = 'Key',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Edu__UIDComponents),E_Education(__cfg).Lookup,'' + '|' + TRIM((STRING)LEFT.Key) + '|' + '' = RIGHT.KeyVal,TRANSFORM(__d0_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Edu__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault'),__Mapping0_Transform(LEFT)));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historicalflag(DEFAULT:Historical_Flag_:\'\'),class_rank(OVERRIDE:Class_:\'\'),collegeclass(DEFAULT:College_Class_:\'\'),major_code(OVERRIDE:College_Major_:\'\'),newcollegemajor(DEFAULT:New_College_Major_:\'\'),student_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),headofhouseholdgendercode(DEFAULT:Head_Of_Household_Gender_Code_:\'\'),gender_code(OVERRIDE:Head_Of_Household_Gender_:\'\'),rawaid(OVERRIDE:Raw_A_I_D_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault((UNSIGNED)did != 0 AND (UNSIGNED)Sequence_Number != 0 AND (UNSIGNED)key_code != 0 AND (UNSIGNED)rawaid != 0);
  SHARED __d1_Edu__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d1_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'Sequence_Number,key_code,rawaid','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault');
  SHARED __d1_Edu__Mapped := IF(__d1_Missing_Edu__UIDComponents = 'Sequence_Number,key_code,rawaid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Edu__UIDComponents),E_Education(__cfg).Lookup,TRIM((STRING)LEFT.Sequence_Number) + '|' + TRIM((STRING)LEFT.key_code) + '|' + TRIM((STRING)LEFT.rawaid) = RIGHT.KeyVal,TRANSFORM(__d1_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Edu__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault'));
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historical_flag(OVERRIDE:Historical_Flag_:\'\'),class(OVERRIDE:Class_:\'\'),college_class(OVERRIDE:College_Class_:\'\'),college_major(OVERRIDE:College_Major_:\'\'),new_college_major(OVERRIDE:New_College_Major_:\'\'),head_of_household_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),head_of_household_gender_code(OVERRIDE:Head_Of_Household_Gender_Code_:\'\'),head_of_household_gender(OVERRIDE:Head_Of_Household_Gender_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Raw_A_I_D_ := __CN('');
    SELF := __r;
  END;
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault((UNSIGNED)key != 0);
  SHARED __d2_Edu__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d2_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'Key','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault');
  SHARED __d2_Edu__Mapped := IF(__d2_Missing_Edu__UIDComponents = 'Key',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Edu__UIDComponents),E_Education(__cfg).Lookup,'' + '|' + TRIM((STRING)LEFT.Key) + '|' + '' = RIGHT.KeyVal,TRANSFORM(__d2_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Edu__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault'),__Mapping2_Transform(LEFT)));
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historicalflag(DEFAULT:Historical_Flag_:\'\'),class_rank(OVERRIDE:Class_:\'\'),collegeclass(DEFAULT:College_Class_:\'\'),major_code(OVERRIDE:College_Major_:\'\'),newcollegemajor(DEFAULT:New_College_Major_:\'\'),student_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),headofhouseholdgendercode(DEFAULT:Head_Of_Household_Gender_Code_:\'\'),gender_code(OVERRIDE:Head_Of_Household_Gender_:\'\'),rawaid(OVERRIDE:Raw_A_I_D_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault((UNSIGNED)did != 0 AND (UNSIGNED)Sequence_Number != 0 AND (UNSIGNED)key_code != 0 AND (UNSIGNED)rawaid != 0);
  SHARED __d3_Edu__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d3_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'Sequence_Number,key_code,rawaid','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault');
  SHARED __d3_Edu__Mapped := IF(__d3_Missing_Edu__UIDComponents = 'Sequence_Number,key_code,rawaid',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Edu__UIDComponents),E_Education(__cfg).Lookup,TRIM((STRING)LEFT.Sequence_Number) + '|' + TRIM((STRING)LEFT.key_code) + '|' + TRIM((STRING)LEFT.rawaid) = RIGHT.KeyVal,TRANSFORM(__d3_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Edu__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Edu_,Subject_,D_I_D_,Process_Date_,Historical_Flag_,Class_,College_Class_,College_Major_,New_College_Major_,Head_Of_Household_First_Name_,Head_Of_Household_Gender_Code_,Head_Of_Household_Gender_,Raw_A_I_D_,ALL));
  Person_Education_Group := __PostFilter;
  Layout Person_Education__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_Education__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Education_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Education__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Education_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Education__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Edu__Orphan := JOIN(InData(__NN(Edu_)),E_Education(__cfg).__Result,__EEQP(LEFT.Edu_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Edu__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Edu__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','Edu',COUNT(__d0(__NL(Edu_))),COUNT(__d0(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','DID',COUNT(__d0(__NL(D_I_D_))),COUNT(__d0(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','historical_flag',COUNT(__d0(__NL(Historical_Flag_))),COUNT(__d0(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','class',COUNT(__d0(__NL(Class_))),COUNT(__d0(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','college_class',COUNT(__d0(__NL(College_Class_))),COUNT(__d0(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','college_major',COUNT(__d0(__NL(College_Major_))),COUNT(__d0(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','new_college_major',COUNT(__d0(__NL(New_College_Major_))),COUNT(__d0(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','head_of_household_first_name',COUNT(__d0(__NL(Head_Of_Household_First_Name_))),COUNT(__d0(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','head_of_household_gender_code',COUNT(__d0(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d0(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','head_of_household_gender',COUNT(__d0(__NL(Head_Of_Household_Gender_))),COUNT(__d0(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.American_Student_List__Key_DID_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','Edu',COUNT(__d1(__NL(Edu_))),COUNT(__d1(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','DID',COUNT(__d1(__NL(D_I_D_))),COUNT(__d1(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','process_date',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','HistoricalFlag',COUNT(__d1(__NL(Historical_Flag_))),COUNT(__d1(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','class_rank',COUNT(__d1(__NL(Class_))),COUNT(__d1(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','CollegeClass',COUNT(__d1(__NL(College_Class_))),COUNT(__d1(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','major_code',COUNT(__d1(__NL(College_Major_))),COUNT(__d1(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','NewCollegeMajor',COUNT(__d1(__NL(New_College_Major_))),COUNT(__d1(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','student_first_name',COUNT(__d1(__NL(Head_Of_Household_First_Name_))),COUNT(__d1(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','HeadOfHouseholdGenderCode',COUNT(__d1(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d1(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','gender_code',COUNT(__d1(__NL(Head_Of_Household_Gender_))),COUNT(__d1(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','rawaid',COUNT(__d1(__NL(Raw_A_I_D_))),COUNT(__d1(__NN(Raw_A_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.NonFCRA.AlloyMedia_Student_List__Key_DID_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','Edu',COUNT(__d2(__NL(Edu_))),COUNT(__d2(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','DID',COUNT(__d2(__NL(D_I_D_))),COUNT(__d2(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','process_date',COUNT(__d2(__NL(Process_Date_))),COUNT(__d2(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','historical_flag',COUNT(__d2(__NL(Historical_Flag_))),COUNT(__d2(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','class',COUNT(__d2(__NL(Class_))),COUNT(__d2(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','college_class',COUNT(__d2(__NL(College_Class_))),COUNT(__d2(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','college_major',COUNT(__d2(__NL(College_Major_))),COUNT(__d2(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','new_college_major',COUNT(__d2(__NL(New_College_Major_))),COUNT(__d2(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','head_of_household_first_name',COUNT(__d2(__NL(Head_Of_Household_First_Name_))),COUNT(__d2(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','head_of_household_gender_code',COUNT(__d2(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d2(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','head_of_household_gender',COUNT(__d2(__NL(Head_Of_Household_Gender_))),COUNT(__d2(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.American_Student_List__Key_DID_FCRA_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','Edu',COUNT(__d3(__NL(Edu_))),COUNT(__d3(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','DID',COUNT(__d3(__NL(D_I_D_))),COUNT(__d3(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','process_date',COUNT(__d3(__NL(Process_Date_))),COUNT(__d3(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','HistoricalFlag',COUNT(__d3(__NL(Historical_Flag_))),COUNT(__d3(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','class_rank',COUNT(__d3(__NL(Class_))),COUNT(__d3(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','CollegeClass',COUNT(__d3(__NL(College_Class_))),COUNT(__d3(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','major_code',COUNT(__d3(__NL(College_Major_))),COUNT(__d3(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','NewCollegeMajor',COUNT(__d3(__NL(New_College_Major_))),COUNT(__d3(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','student_first_name',COUNT(__d3(__NL(Head_Of_Household_First_Name_))),COUNT(__d3(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','HeadOfHouseholdGenderCode',COUNT(__d3(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d3(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','gender_code',COUNT(__d3(__NL(Head_Of_Household_Gender_))),COUNT(__d3(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','rawaid',COUNT(__d3(__NL(Raw_A_I_D_))),COUNT(__d3(__NN(Raw_A_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.Files.FCRA.AlloyMedia_Student_List__Key_DID_FCRA_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
