//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Education,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Edu_(DEFAULT:Edu_:0),did(DEFAULT:D_I_D_:\'\'),processdate(DEFAULT:Process_Date_:DATE),historicalflag(DEFAULT:Historical_Flag_:\'\'),class(DEFAULT:Class_:\'\'),collegeclass(DEFAULT:College_Class_:\'\'),collegemajor(DEFAULT:College_Major_:\'\'),newcollegemajor(DEFAULT:New_College_Major_:\'\'),headofhouseholdfirstname(DEFAULT:Head_Of_Household_First_Name_:\'\'),headofhouseholdgendercode(DEFAULT:Head_Of_Household_Gender_Code_:\'\'),headofhouseholdgender(DEFAULT:Head_Of_Household_Gender_:\'\'),rawaid(DEFAULT:Raw_A_I_D_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __d0_Edu__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Edu_;
  END;
  SHARED __d0_Edu__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__in,'Sequence,Key,RawAID','__in'),E_Education(__in,__cfg).Lookup,TRIM((STRING)LEFT.Sequence) + '|' + TRIM((STRING)LEFT.Key) + '|' + TRIM((STRING)LEFT.RawAID) = RIGHT.KeyVal,TRANSFORM(__d0_Edu__Layout,SELF.Edu_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Edu__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Edu_,Subject_,D_I_D_,Process_Date_,Historical_Flag_,Class_,College_Class_,College_Major_,New_College_Major_,Head_Of_Household_First_Name_,Head_Of_Household_Gender_Code_,Head_Of_Household_Gender_,Raw_A_I_D_,ALL));
  Person_Education_Group := __PostFilter;
  Layout Person_Education__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Education__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Education_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Education__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Education_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Education__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Edu__Orphan := JOIN(InData(__NN(Edu_)),E_Education(__in,__cfg).__Result,__EEQP(LEFT.Edu_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Edu__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Edu__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Edu',COUNT(__d0(__NL(Edu_))),COUNT(__d0(__NN(Edu_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DID',COUNT(__d0(__NL(D_I_D_))),COUNT(__d0(__NN(D_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistoricalFlag',COUNT(__d0(__NL(Historical_Flag_))),COUNT(__d0(__NN(Historical_Flag_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Class',COUNT(__d0(__NL(Class_))),COUNT(__d0(__NN(Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeClass',COUNT(__d0(__NL(College_Class_))),COUNT(__d0(__NN(College_Class_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeMajor',COUNT(__d0(__NL(College_Major_))),COUNT(__d0(__NN(College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NewCollegeMajor',COUNT(__d0(__NL(New_College_Major_))),COUNT(__d0(__NN(New_College_Major_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeadOfHouseholdFirstName',COUNT(__d0(__NL(Head_Of_Household_First_Name_))),COUNT(__d0(__NN(Head_Of_Household_First_Name_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeadOfHouseholdGenderCode',COUNT(__d0(__NL(Head_Of_Household_Gender_Code_))),COUNT(__d0(__NN(Head_Of_Household_Gender_Code_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeadOfHouseholdGender',COUNT(__d0(__NL(Head_Of_Household_Gender_))),COUNT(__d0(__NN(Head_Of_Household_Gender_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RawAID',COUNT(__d0(__NL(Raw_A_I_D_))),COUNT(__d0(__NN(Raw_A_I_D_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonEducation','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
