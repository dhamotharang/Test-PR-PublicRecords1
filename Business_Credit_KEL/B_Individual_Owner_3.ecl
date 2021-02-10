//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT CFG_graph,E_Individual_Owner FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Individual_Owner_3(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Individual_Owner(__in,__cfg).__Result) __E_Individual_Owner := E_Individual_Owner(__in,__cfg).__Result;
  SHARED __EE521236 := __E_Individual_Owner;
  EXPORT __ST242795_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nstr _first__name_;
    KEL.typ.nstr _middle__name_;
    KEL.typ.nstr _last__name_;
    KEL.typ.nstr _suffix_;
    KEL.typ.nstr _e__mail__address_;
    KEL.typ.nint _guarantor__owner__indicator_;
    KEL.typ.nunk _relationship__to__business__indicator_;
    KEL.typ.nstr _business__title_;
    KEL.typ.nint _percent__of__liability_;
    KEL.typ.nint _percent__of__ownership_;
    KEL.typ.nstr _source_;
    KEL.typ.nbool _active_;
    KEL.typ.nstr Name_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242795_Layout __ND10029957__Project(E_Individual_Owner(__in,__cfg).Layout __PP521107) := TRANSFORM
    SELF.Name_ := __OP2(__OP2(__FN1(TRIM,__PP521107._first__name_),+,__CN(' ')),+,__FN1(TRIM,__PP521107._last__name_));
    SELF := __PP521107;
  END;
  EXPORT __ENH_Individual_Owner_3 := PROJECT(__EE521236,__ND10029957__Project(LEFT));
END;
