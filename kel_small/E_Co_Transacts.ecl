//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT KEL_Small;
IMPORT E_Person FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT E_Co_Transacts := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person.Typ) _who_;
    KEL.typ.ntyp(E_Person.Typ) _whoelse_;
    KEL.typ.nkdate _whence_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'who(_who_:0),whoelse(_whoelse_:0),when(_whence_:DATE)';
  SHARED __Mapping0 := 'owner1_did(_who_:0),owner2_did(_whoelse_:0),when(_whence_:DATE)';
  SHARED __d0_Prefiltered := KEL_Small.File_Buys;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'owner2_did(_who_:0),owner1_did(_whoelse_:0),when(_whence_:DATE)';
  SHARED __d1_Prefiltered := KEL_Small.File_Buys;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'seller1_did(_who_:0),seller2_did(_whoelse_:0),when(_whence_:DATE)';
  SHARED __d2_Prefiltered := KEL_Small.File_Buys;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2));
  SHARED __Mapping3 := 'seller2_did(_who_:0),seller1_did(_whoelse_:0),when(_whence_:DATE)';
  SHARED __d3_Prefiltered := KEL_Small.File_Buys;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT _whence_Layout := RECORD
    KEL.typ.nkdate _whence_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) _who_;
    KEL.typ.ntyp(E_Person.Typ) _whoelse_;
    KEL.typ.ndataset(_whence_Layout) _whence_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,_who_,_whoelse_,ALL));
  Co_Transacts_Group := __PostFilter;
  Layout Co_Transacts__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._whence_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),_whence_},_whence_),_whence_Layout)(__NN(_whence_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Co_Transacts__Single_Rollup(InLayout __r) := TRANSFORM
    SELF._whence_ := __CN(PROJECT(DATASET(__r),TRANSFORM(_whence_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_whence_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Co_Transacts_Group,COUNT(ROWS(LEFT))=1),GROUP,Co_Transacts__Single_Rollup(LEFT)) + ROLLUP(HAVING(Co_Transacts_Group,COUNT(ROWS(LEFT))>1),GROUP,Co_Transacts__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::Co_Transacts::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _who__Orphan := JOIN(InData(__NN(_who_)),E_Person.__Result,__EEQP(LEFT._who_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _whoelse__Orphan := JOIN(InData(__NN(_whoelse_)),E_Person.__Result,__EEQP(LEFT._whoelse_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_who__Orphan),COUNT(_whoelse__Orphan)}],{KEL.typ.int _who__Orphan,KEL.typ.int _whoelse__Orphan});
  EXPORT NullCounts := DATASET([
    {'CoTransacts','KEL_Small.File_Buys','owner1_did',COUNT(__d0(__NL(_who_))),COUNT(__d0(__NN(_who_)))},
    {'CoTransacts','KEL_Small.File_Buys','owner2_did',COUNT(__d0(__NL(_whoelse_))),COUNT(__d0(__NN(_whoelse_)))},
    {'CoTransacts','KEL_Small.File_Buys','when',COUNT(__d0(__NL(_whence_))),COUNT(__d0(__NN(_whence_)))},
    {'CoTransacts','KEL_Small.File_Buys','owner2_did',COUNT(__d1(__NL(_who_))),COUNT(__d1(__NN(_who_)))},
    {'CoTransacts','KEL_Small.File_Buys','owner1_did',COUNT(__d1(__NL(_whoelse_))),COUNT(__d1(__NN(_whoelse_)))},
    {'CoTransacts','KEL_Small.File_Buys','when',COUNT(__d1(__NL(_whence_))),COUNT(__d1(__NN(_whence_)))},
    {'CoTransacts','KEL_Small.File_Buys','seller1_did',COUNT(__d2(__NL(_who_))),COUNT(__d2(__NN(_who_)))},
    {'CoTransacts','KEL_Small.File_Buys','seller2_did',COUNT(__d2(__NL(_whoelse_))),COUNT(__d2(__NN(_whoelse_)))},
    {'CoTransacts','KEL_Small.File_Buys','when',COUNT(__d2(__NL(_whence_))),COUNT(__d2(__NN(_whence_)))},
    {'CoTransacts','KEL_Small.File_Buys','seller2_did',COUNT(__d3(__NL(_who_))),COUNT(__d3(__NN(_who_)))},
    {'CoTransacts','KEL_Small.File_Buys','seller1_did',COUNT(__d3(__NL(_whoelse_))),COUNT(__d3(__NN(_whoelse_)))},
    {'CoTransacts','KEL_Small.File_Buys','when',COUNT(__d3(__NL(_whence_))),COUNT(__d3(__NN(_whence_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
