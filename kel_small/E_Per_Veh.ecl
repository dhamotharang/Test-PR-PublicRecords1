//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT KEL_Small;
IMPORT E_Person,E_Vehicle FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT E_Per_Veh := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nstr Type_;
    KEL.typ.ntyp(E_Person.Typ) Per_;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh_;
    KEL.typ.nkdate _whence_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'type(Type_:\'\'),per(Per_:0),veh(Veh_:0),when(_whence_:DATE)';
  SHARED __Mapping0 := 'owner1_did(Per_:0),veh_uid(Veh_:0),when(_whence_:DATE)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Type_ := __CN('BUYS');
    SELF := __r;
  END;
  SHARED __d0_Prefiltered := KEL_Small.File_Buys;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'owner2_did(Per_:0),veh_uid(Veh_:0),when(_whence_:DATE)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Type_ := __CN('BUYS');
    SELF := __r;
  END;
  SHARED __d1_Prefiltered := KEL_Small.File_Buys;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'seller1_did(Per_:0),veh_uid(Veh_:0),when(_whence_:DATE)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Type_ := __CN('SELLS');
    SELF := __r;
  END;
  SHARED __d2_Prefiltered := KEL_Small.File_Buys;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'seller2_did(Per_:0),veh_uid(Veh_:0),when(_whence_:DATE)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Type_ := __CN('SELLS');
    SELF := __r;
  END;
  SHARED __d3_Prefiltered := KEL_Small.File_Buys;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Transaction_Layout := RECORD
    KEL.typ.nstr Type_;
    KEL.typ.nkdate _whence_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Per_;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh_;
    KEL.typ.ndataset(Transaction_Layout) Transaction_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Per_,Veh_,ALL));
  Per_Veh_Group := __PostFilter;
  Layout Per_Veh__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Transaction_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),Type_,_whence_},Type_,_whence_),Transaction_Layout)(__NN(Type_) OR __NN(_whence_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Per_Veh__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Transaction_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Transaction_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Type_) OR __NN(_whence_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Per_Veh_Group,COUNT(ROWS(LEFT))=1),GROUP,Per_Veh__Single_Rollup(LEFT)) + ROLLUP(HAVING(Per_Veh_Group,COUNT(ROWS(LEFT))>1),GROUP,Per_Veh__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::Per_Veh::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Per__Orphan := JOIN(InData(__NN(Per_)),E_Person.__Result,__EEQP(LEFT.Per_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Veh__Orphan := JOIN(InData(__NN(Veh_)),E_Vehicle.__Result,__EEQP(LEFT.Veh_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Per__Orphan),COUNT(Veh__Orphan)}],{KEL.typ.int Per__Orphan,KEL.typ.int Veh__Orphan});
  EXPORT NullCounts := DATASET([
    {'PerVeh','KEL_Small.File_Buys','owner1_did',COUNT(__d0(__NL(Per_))),COUNT(__d0(__NN(Per_)))},
    {'PerVeh','KEL_Small.File_Buys','veh_uid',COUNT(__d0(__NL(Veh_))),COUNT(__d0(__NN(Veh_)))},
    {'PerVeh','KEL_Small.File_Buys','when',COUNT(__d0(__NL(_whence_))),COUNT(__d0(__NN(_whence_)))},
    {'PerVeh','KEL_Small.File_Buys','owner2_did',COUNT(__d1(__NL(Per_))),COUNT(__d1(__NN(Per_)))},
    {'PerVeh','KEL_Small.File_Buys','veh_uid',COUNT(__d1(__NL(Veh_))),COUNT(__d1(__NN(Veh_)))},
    {'PerVeh','KEL_Small.File_Buys','when',COUNT(__d1(__NL(_whence_))),COUNT(__d1(__NN(_whence_)))},
    {'PerVeh','KEL_Small.File_Buys','seller1_did',COUNT(__d2(__NL(Per_))),COUNT(__d2(__NN(Per_)))},
    {'PerVeh','KEL_Small.File_Buys','veh_uid',COUNT(__d2(__NL(Veh_))),COUNT(__d2(__NN(Veh_)))},
    {'PerVeh','KEL_Small.File_Buys','when',COUNT(__d2(__NL(_whence_))),COUNT(__d2(__NN(_whence_)))},
    {'PerVeh','KEL_Small.File_Buys','seller2_did',COUNT(__d3(__NL(Per_))),COUNT(__d3(__NN(Per_)))},
    {'PerVeh','KEL_Small.File_Buys','veh_uid',COUNT(__d3(__NL(Veh_))),COUNT(__d3(__NN(Veh_)))},
    {'PerVeh','KEL_Small.File_Buys','when',COUNT(__d3(__NL(_whence_))),COUNT(__d3(__NN(_whence_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
