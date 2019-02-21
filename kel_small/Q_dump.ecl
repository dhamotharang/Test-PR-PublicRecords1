//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT E_Co_Transacts,E_Per_Veh,E_Person,E_Vehicle FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT Q_Dump := MODULE
  SHARED TYPEOF(E_Co_Transacts.__Result) __E_Co_Transacts := E_Co_Transacts.__Result;
  SHARED TYPEOF(E_Per_Veh.__Result) __E_Per_Veh := E_Per_Veh.__Result;
  SHARED TYPEOF(E_Person.__Result) __E_Person := E_Person.__Result;
  SHARED __EE150 := __E_Per_Veh;
  SHARED __EE152 := __EE150;
  EXPORT Res0 := __UNWRAP(__EE152);
  SHARED __EE154 := __E_Co_Transacts;
  SHARED __EE156 := __EE154;
  EXPORT Res1 := __UNWRAP(__EE156);
  SHARED __EE158 := __E_Person;
  SHARED __EE355 := __E_Co_Transacts;
  SHARED __EE481 := __EE355(__NN(__EE355._whoelse_) AND __NN(__EE355._who_));
  SHARED __EE567 := __EE158;
  SHARED __ST246_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) _who_;
    KEL.typ.ntyp(E_Person.Typ) _whoelse_;
    KEL.typ.ndataset(E_Co_Transacts._whence_Layout) _whence_;
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC575(E_Co_Transacts.Layout __EE481, E_Person.Layout __EE567) := __EEQP(__EE481._whoelse_,__EE567.UID);
  __ST246_Layout __JT575(E_Co_Transacts.Layout __l, E_Person.Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE576 := JOIN(__EE481,__EE567,__JC575(LEFT,RIGHT),__JT575(LEFT,RIGHT),INNER,HASH);
  SHARED __ST303_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(__ST246_Layout) Co_Transacts_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC591(E_Person.Layout __EE158, __ST246_Layout __EE576) := __EEQP(__EE158.UID,__EE576._who_);
  __ST303_Layout __Join__ST303_Layout(E_Person.Layout __r, DATASET(__ST246_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Co_Transacts_ := __CN(__recs);
  END;
  SHARED __EE592 := DENORMALIZE(DISTRIBUTE(__EE158,HASH(UID)),DISTRIBUTE(__EE576,HASH(_who_)),__JC591(LEFT,RIGHT),GROUP,__Join__ST303_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST139_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST144_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk Name_;
    KEL.typ.ndataset(__ST139_Layout) _whoelse_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST144_Layout __ND611__Project(__ST303_Layout __PP593) := TRANSFORM
    __EE620 := __PP593.Co_Transacts_;
    SELF._whoelse_ := __PROJECT(__EE620,__ST139_Layout);
    SELF := __PP593;
  END;
  EXPORT Res2 := __UNWRAP(PROJECT(__EE592,__ND611__Project(LEFT)));
END;
