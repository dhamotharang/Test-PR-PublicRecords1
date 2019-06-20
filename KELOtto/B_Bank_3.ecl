﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_3 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank.__Result) __E_Bank := E_Bank.__Result;
  SHARED __EE59819 := __E_Bank;
  EXPORT __ST21346_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21346_Layout __ND59931__Project(E_Bank.Layout __PP59822) := TRANSFORM
    SELF.High_Risk_Routing_ := MAP(__T(__OP2(__PP59822.Routing_Number_,IN,__CN(['031101169','124071889','124303120','073972181','084003997','114924742','031101169','063115194'])))=>1,0);
    SELF := __PP59822;
  END;
  EXPORT __ENH_Bank_3 := PROJECT(__EE59819,__ND59931__Project(LEFT));
END;
