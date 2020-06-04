//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank.__Result) __E_Bank := E_Bank.__Result;
  SHARED __EE79931 := __E_Bank;
  EXPORT __ST52408_Layout := RECORD
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
  SHARED __ST52408_Layout __ND79966__Project(E_Bank.Layout __PP79853) := TRANSFORM
    SELF.High_Risk_Routing_ := MAP(__T(__OP2(__PP79853.Routing_Number_,IN,__CN(['031101169','124071889','124303120','073972181','084003997','114924742','031101169','063115194'])))=>1,0);
    SELF := __PP79853;
  END;
  EXPORT __ENH_Bank_4 := PROJECT(__EE79931,__ND79966__Project(LEFT));
END;
