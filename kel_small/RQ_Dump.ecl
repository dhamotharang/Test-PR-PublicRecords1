//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT B_Co_Transacts,B_Per_Veh,B_Person,E_Co_Transacts,E_Per_Veh,E_Person,E_Vehicle FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT RQ_Dump := MODULE
  SHARED __EE924 := B_Per_Veh.IDX_Per_Veh_Per__Wrapped;
  SHARED __EE926 := __EE924;
  EXPORT Res0 := __UNWRAP(__EE926);
  SHARED __EE929 := B_Co_Transacts.IDX_Co_Transacts__who__Wrapped;
  SHARED __EE931 := __EE929;
  EXPORT Res1 := __UNWRAP(__EE931);
  SHARED __EE934 := B_Person.IDX_Person_UID_Wrapped;
  SHARED __EE937 := B_Co_Transacts.IDX_Co_Transacts__who__Wrapped;
  SHARED __EE1140 := __EE937(__NN(__EE937._whoelse_) AND __NN(__EE937._who_));
  SHARED __EE1226 := __EE934;
  SHARED __ST780_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) _who_;
    KEL.typ.ntyp(E_Person.Typ) _whoelse_;
    KEL.typ.ndataset(E_Co_Transacts._whence_Layout) _whence_;
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1234(E_Co_Transacts.Layout __EE1140, E_Person.Layout __EE1226) := __EEQP(__EE1140._whoelse_,__EE1226.UID);
  __ST780_Layout __JT1234(E_Co_Transacts.Layout __l, E_Person.Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1235 := JOIN(__EE1140,__EE1226,__JC1234(LEFT,RIGHT),__JT1234(LEFT,RIGHT),INNER,HASH);
  SHARED __ST837_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(__ST780_Layout) Co_Transacts_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1250(E_Person.Layout __EE934, __ST780_Layout __EE1235) := __EEQP(__EE934.UID,__EE1235._who_);
  __ST837_Layout __Join__ST837_Layout(E_Person.Layout __r, DATASET(__ST780_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Co_Transacts_ := __CN(__recs);
  END;
  SHARED __EE1251 := DENORMALIZE(DISTRIBUTE(__EE934,HASH(UID)),DISTRIBUTE(__EE1235,HASH(_who_)),__JC1250(LEFT,RIGHT),GROUP,__Join__ST837_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST676_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST680_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.ndataset(__ST676_Layout) _whoelse_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST680_Layout __ND1270__Project(__ST837_Layout __PP1252) := TRANSFORM
    __EE1279 := __PP1252.Co_Transacts_;
    SELF._whoelse_ := __PROJECT(__EE1279,__ST676_Layout);
    SELF := __PP1252;
  END;
  EXPORT Res2 := __UNWRAP(PROJECT(__EE1251,__ND1270__Project(LEFT)));
END;
