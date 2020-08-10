﻿//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_graph,E_Business_Owner FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_Owner_3(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Owner(__in,__cfg).__Result) __E_Business_Owner := E_Business_Owner(__in,__cfg).__Result;
  SHARED __EE466924 := __E_Business_Owner;
  EXPORT __ST234826_Layout := RECORD
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
    KEL.typ.nstr _business__name_;
    KEL.typ.nstr _web__address_;
    KEL.typ.nint _guarantor__owner__indicator_;
    KEL.typ.nunk _relationship__to__business__indicator_;
    KEL.typ.nint _percent__of__liability_;
    KEL.typ.nint _percent__of__ownership__if__owner__principal_;
    KEL.typ.nstr Name_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST234826_Layout __ND466922__Project(E_Business_Owner(__in,__cfg).Layout __PP466830) := TRANSFORM
    SELF.Name_ := __FN1(TRIM,__PP466830._business__name_);
    SELF := __PP466830;
  END;
  EXPORT __ENH_Business_Owner_3 := PROJECT(__EE466924,__ND466922__Project(LEFT));
END;
