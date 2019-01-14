//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT E_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'did(UID),name(Name_:\'\'),age(Age_:0)';
  SHARED __Mapping0 := 'owner1_did(UID),owner1_name(Name_:\'\'),owner1_age(Age_:0)';
  EXPORT KEL_Small_File_Buys_1_Invalid := KEL_Small.File_Buys((KEL.typ.uid)owner1_did = 0);
  SHARED __d0_Prefiltered := KEL_Small.File_Buys((KEL.typ.uid)owner1_did <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'owner2_did(UID),owner2_name(Name_:\'\'),owner2_age(Age_:0)';
  EXPORT KEL_Small_File_Buys_2_Invalid := KEL_Small.File_Buys((KEL.typ.uid)owner2_did = 0);
  SHARED __d1_Prefiltered := KEL_Small.File_Buys((KEL.typ.uid)owner2_did <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'seller1_did(UID),seller1_name(Name_:\'\'),seller1_age(Age_:0)';
  EXPORT KEL_Small_File_Buys_3_Invalid := KEL_Small.File_Buys((KEL.typ.uid)seller1_did = 0);
  SHARED __d2_Prefiltered := KEL_Small.File_Buys((KEL.typ.uid)seller1_did <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2));
  SHARED __Mapping3 := 'seller2_did(UID),seller2_name(Name_:\'\'),seller2_age(Age_:0)';
  EXPORT KEL_Small_File_Buys_4_Invalid := KEL_Small.File_Buys((KEL.typ.uid)seller2_did = 0);
  SHARED __d3_Prefiltered := KEL_Small.File_Buys((KEL.typ.uid)seller2_did <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Name_ := KEL.Intake.SingleValue(__recs,Name_);
    SELF.Age_ := KEL.Intake.SingleValue(__recs,Age_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::Person::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name_);
  EXPORT Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Age_);
  EXPORT SanityCheck := DATASET([{COUNT(KEL_Small_File_Buys_1_Invalid),COUNT(KEL_Small_File_Buys_2_Invalid),COUNT(KEL_Small_File_Buys_3_Invalid),COUNT(KEL_Small_File_Buys_4_Invalid),COUNT(Name__SingleValue_Invalid),COUNT(Age__SingleValue_Invalid)}],{KEL.typ.int KEL_Small_File_Buys_1_Invalid,KEL.typ.int KEL_Small_File_Buys_2_Invalid,KEL.typ.int KEL_Small_File_Buys_3_Invalid,KEL.typ.int KEL_Small_File_Buys_4_Invalid,KEL.typ.int Name__SingleValue_Invalid,KEL.typ.int Age__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Person','KEL_Small.File_Buys','UID',COUNT(KEL_Small_File_Buys_1_Invalid),COUNT(__d0)},
    {'Person','KEL_Small.File_Buys','owner1_name',COUNT(__d0(__NL(Name_))),COUNT(__d0(__NN(Name_)))},
    {'Person','KEL_Small.File_Buys','owner1_age',COUNT(__d0(__NL(Age_))),COUNT(__d0(__NN(Age_)))},
    {'Person','KEL_Small.File_Buys','UID',COUNT(KEL_Small_File_Buys_2_Invalid),COUNT(__d1)},
    {'Person','KEL_Small.File_Buys','owner2_Name',COUNT(__d1(__NL(Name_))),COUNT(__d1(__NN(Name_)))},
    {'Person','KEL_Small.File_Buys','owner2_Age',COUNT(__d1(__NL(Age_))),COUNT(__d1(__NN(Age_)))},
    {'Person','KEL_Small.File_Buys','UID',COUNT(KEL_Small_File_Buys_3_Invalid),COUNT(__d2)},
    {'Person','KEL_Small.File_Buys','seller1_Name',COUNT(__d2(__NL(Name_))),COUNT(__d2(__NN(Name_)))},
    {'Person','KEL_Small.File_Buys','seller1_Age',COUNT(__d2(__NL(Age_))),COUNT(__d2(__NN(Age_)))},
    {'Person','KEL_Small.File_Buys','UID',COUNT(KEL_Small_File_Buys_4_Invalid),COUNT(__d3)},
    {'Person','KEL_Small.File_Buys','seller2_Name',COUNT(__d3(__NL(Name_))),COUNT(__d3(__NN(Name_)))},
    {'Person','KEL_Small.File_Buys','seller2_Age',COUNT(__d3(__NL(Age_))),COUNT(__d3(__NN(Age_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
