//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT E_Vehicle := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Make_;
    KEL.typ.nunk Colour_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'uid(UID),make(Make_:\'\'),color(Colour_:\'\')';
  SHARED __Mapping0 := 'veh_uid(UID),make(Make_:\'\'),color(Colour_:\'\')';
  EXPORT KEL_Small_File_Buys_Invalid := KEL_Small.File_Buys((KEL.typ.uid)veh_uid = 0);
  SHARED __d0_Prefiltered := KEL_Small.File_Buys((KEL.typ.uid)veh_uid <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Make_;
    KEL.typ.nunk Colour_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Vehicle_Group := __PostFilter;
  Layout Vehicle__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Make_ := KEL.Intake.SingleValue(__recs,Make_);
    SELF.Colour_ := KEL.Intake.SingleValue(__recs,Colour_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Vehicle__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Vehicle_Group,COUNT(ROWS(LEFT))=1),GROUP,Vehicle__Single_Rollup(LEFT)) + ROLLUP(HAVING(Vehicle_Group,COUNT(ROWS(LEFT))>1),GROUP,Vehicle__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::Vehicle::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Make__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Make_);
  EXPORT Colour__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Colour_);
  EXPORT SanityCheck := DATASET([{COUNT(KEL_Small_File_Buys_Invalid),COUNT(Make__SingleValue_Invalid),COUNT(Colour__SingleValue_Invalid)}],{KEL.typ.int KEL_Small_File_Buys_Invalid,KEL.typ.int Make__SingleValue_Invalid,KEL.typ.int Colour__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Vehicle','KEL_Small.File_Buys','UID',COUNT(KEL_Small_File_Buys_Invalid),COUNT(__d0)},
    {'Vehicle','KEL_Small.File_Buys','Make',COUNT(__d0(__NL(Make_))),COUNT(__d0(__NN(Make_)))},
    {'Vehicle','KEL_Small.File_Buys','Color',COUNT(__d0(__NL(Colour_))),COUNT(__d0(__NN(Colour_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
