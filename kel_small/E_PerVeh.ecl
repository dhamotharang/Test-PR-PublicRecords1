IMPORT KEL05 AS KEL;
IMPORT $.E_Person,$.E_Vehicle;
IMPORT * FROM KEL05.Null;
EXPORT E_PerVeh := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nstr Type;
    KEL.typ.ntyp(E_Person.Typ) Per;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh;
    KEL.typ.nkdate whence;
  END;
  SHARED __Mapping := 'Type:Type:\'\',Per:Per:0,Veh:Veh:0,whence:when:0';
  SHARED __Mapping0 := 'Per:owner1_did:0,Veh:veh_uid:0,whence:when:0';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Type := __CN('BUYS');
    SELF := __r;
  END;
  SHARED __d0_Prefiltered := File_Buys;
  SHARED __d0 := PROJECT(KEL.FromFlat(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT));
  SHARED __Mapping1 := 'Per:owner2_did:0,Veh:veh_uid:0,whence:when:0';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Type := __CN('BUYS');
    SELF := __r;
  END;
  SHARED __d1_Prefiltered := File_Buys;
  SHARED __d1 := PROJECT(KEL.FromFlat(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT));
  SHARED __Mapping2 := 'Per:seller1_did:0,Veh:veh_uid:0,whence:when:0';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Type := __CN('SELLS');
    SELF := __r;
  END;
  SHARED __d2_Prefiltered := File_Buys;
  SHARED __d2 := PROJECT(KEL.FromFlat(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT));
  SHARED __Mapping3 := 'Per:seller2_did:0,Veh:veh_uid:0,whence:when:0';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Type := __CN('SELLS');
    SELF := __r;
  END;
  SHARED __d3_Prefiltered := File_Buys;
  SHARED __d3 := PROJECT(KEL.FromFlat(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Transaction_Layout := RECORD
    KEL.typ.nstr Type;
    KEL.typ.nkdate whence;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Per;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh;
    KEL.typ.ndataset(Transaction_Layout) Transaction;
    KEL.typ.int __RecordCount := 0;
  END;
  Layout PerVeh__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Transaction := __CN(PROJECT(TABLE(__recs,{Type,whence,KEL.typ.int __RecordCount := COUNT(GROUP)},Type,whence),Transaction_Layout));
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(GROUP(InData,Per,Veh,ALL),GROUP,PerVeh__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KEL_Small::E_PerVeh::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
END;
