IMPORT KEL05 AS KEL;
IMPORT $.E_Person;
IMPORT * FROM KEL05.Null;
EXPORT E_CoTransacts := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person.Typ) who;
    KEL.typ.ntyp(E_Person.Typ) whoelse;
    KEL.typ.nkdate whence;
  END;
  SHARED __Mapping := 'who:who:0,whoelse:whoelse:0,whence:when:0';
  SHARED __Mapping0 := 'who:owner1_did:0,whoelse:owner2_did:0,whence:when:0';
  SHARED __d0_Prefiltered := File_Buys;
  SHARED __d0 := KEL.FromFlat(__d0_Prefiltered,InLayout,__Mapping0);
  SHARED __Mapping1 := 'who:owner2_did:0,whoelse:owner1_did:0,whence:when:0';
  SHARED __d1_Prefiltered := File_Buys;
  SHARED __d1 := KEL.FromFlat(__d1_Prefiltered,InLayout,__Mapping1);
  SHARED __Mapping2 := 'who:seller1_did:0,whoelse:seller2_did:0,whence:when:0';
  SHARED __d2_Prefiltered := File_Buys;
  SHARED __d2 := KEL.FromFlat(__d2_Prefiltered,InLayout,__Mapping2);
  SHARED __Mapping3 := 'who:seller2_did:0,whoelse:seller1_did:0,whence:when:0';
  SHARED __d3_Prefiltered := File_Buys;
  SHARED __d3 := KEL.FromFlat(__d3_Prefiltered,InLayout,__Mapping3);
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT __ST22_Layout := RECORD
    KEL.typ.nkdate whence;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) who;
    KEL.typ.ntyp(E_Person.Typ) whoelse;
    KEL.typ.ndataset(__ST22_Layout) __ST22;
    KEL.typ.int __RecordCount := 0;
  END;
  Layout CoTransacts__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.__ST22 := __CN(PROJECT(TABLE(__recs,{whence,KEL.typ.int __RecordCount := COUNT(GROUP)},whence),__ST22_Layout));
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(GROUP(InData,who,whoelse,ALL),GROUP,CoTransacts__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::E_CoTransacts::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
END;
