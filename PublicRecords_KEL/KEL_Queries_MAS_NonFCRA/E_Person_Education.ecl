//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Education,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Person_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
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
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historical_flag(OVERRIDE:Historical_Flag_:\'\'),class(OVERRIDE:Class_:\'\'),college_class(OVERRIDE:College_Class_:\'\'),college_major(OVERRIDE:College_Major_:\'\'),new_college_major(OVERRIDE:New_College_Major_:\'\'),head_of_household_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),head_of_household_gender_code(OVERRIDE:Head_Of_Household_Gender_Code_:\'\'),head_of_household_gender(OVERRIDE:Head_Of_Household_Gender_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Raw_A_I_D_ := __CN('');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_American_student_list__key_DID,TRANSFORM(RECORDOF(__in.Dataset_American_student_list__key_DID),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)key != 0);
  SHARED __d0_Edu__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d0_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'Key','__in');
  SHARED __d0_Edu__Mapped := IF(__d0_Missing_Edu__UIDComponents = 'Key',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Edu__UIDComponents),E_Education(__in,__cfg).Lookup,'' + '|' + TRIM((STRING)LEFT.Key) + '|' + '' = RIGHT.KeyVal,TRANSFORM(__d0_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Edu__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0|DEFAULT:D_I_D_:\'\'),Edu_(DEFAULT:Edu_:0),process_date(OVERRIDE:Process_Date_:DATE),historicalflag(DEFAULT:Historical_Flag_:\'\'),class_rank(OVERRIDE:Class_:\'\'),collegeclass(DEFAULT:College_Class_:\'\'),major_code(OVERRIDE:College_Major_:\'\'),newcollegemajor(DEFAULT:New_College_Major_:\'\'),student_first_name(OVERRIDE:Head_Of_Household_First_Name_:\'\'),headofhouseholdgendercode(DEFAULT:Head_Of_Household_Gender_Code_:\'\'),gender_code(OVERRIDE:Head_Of_Household_Gender_:\'\'),rawaid(OVERRIDE:Raw_A_I_D_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_vendor_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),date_vendor_last_reported(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_AlloyMedia_student_list__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_AlloyMedia_student_list__Key_DID),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0 AND (UNSIGNED)Sequence_Number != 0 AND (UNSIGNED)key_code != 0 AND (UNSIGNED)rawaid != 0);
  SHARED __d1_Edu__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Edu_;
  END;
  SHARED __d1_Missing_Edu__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'Sequence_Number,key_code,rawaid','__in');
  SHARED __d1_Edu__Mapped := IF(__d1_Missing_Edu__UIDComponents = 'Sequence_Number,key_code,rawaid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Edu__Layout,SELF.Edu_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Edu__UIDComponents),E_Education(__in,__cfg).Lookup,TRIM((STRING)LEFT.Sequence_Number) + '|' + TRIM((STRING)LEFT.key_code) + '|' + TRIM((STRING)LEFT.rawaid) = RIGHT.KeyVal,TRANSFORM(__d1_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Edu__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
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
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Edu__Orphan := JOIN(InData(__NN(Edu_)),E_Education(__in,__cfg).__Result,__EEQP(LEFT.Edu_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Edu__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Edu__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Edu',COUNT(__d0(__NL(Edu_))),COUNT(__d0(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DID',COUNT(__d0(__NL(D_I_D_))),COUNT(__d0(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','historical_flag',COUNT(__d0(__NL(Historical_Flag_))),COUNT(__d0(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','class',COUNT(__d0(__NL(Class_))),COUNT(__d0(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_class',COUNT(__d0(__NL(College_Class_))),COUNT(__d0(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_major',COUNT(__d0(__NL(College_Major_))),COUNT(__d0(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','new_college_major',COUNT(__d0(__NL(New_College_Major_))),COUNT(__d0(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','head_of_household_first_name',COUNT(__d0(__NL(Head_Of_Household_First_Name_))),COUNT(__d0(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','head_of_household_gender_code',COUNT(__d0(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d0(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','head_of_household_gender',COUNT(__d0(__NL(Head_Of_Household_Gender_))),COUNT(__d0(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Edu',COUNT(__d1(__NL(Edu_))),COUNT(__d1(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DID',COUNT(__d1(__NL(D_I_D_))),COUNT(__d1(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistoricalFlag',COUNT(__d1(__NL(Historical_Flag_))),COUNT(__d1(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','class_rank',COUNT(__d1(__NL(Class_))),COUNT(__d1(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeClass',COUNT(__d1(__NL(College_Class_))),COUNT(__d1(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','major_code',COUNT(__d1(__NL(College_Major_))),COUNT(__d1(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NewCollegeMajor',COUNT(__d1(__NL(New_College_Major_))),COUNT(__d1(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','student_first_name',COUNT(__d1(__NL(Head_Of_Household_First_Name_))),COUNT(__d1(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeadOfHouseholdGenderCode',COUNT(__d1(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d1(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','gender_code',COUNT(__d1(__NL(Head_Of_Household_Gender_))),COUNT(__d1(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rawaid',COUNT(__d1(__NL(Raw_A_I_D_))),COUNT(__d1(__NN(Raw_A_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
