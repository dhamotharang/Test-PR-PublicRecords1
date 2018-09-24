//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_Person_5,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_Person_5.__ENH_Customer_Person_5) __ENH_Customer_Person_5 := B_Customer_Person_5.__ENH_Customer_Person_5;
  SHARED __EE21458 := __ENH_Customer_Person_5;
  EXPORT __ST4206_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST4206_Layout __ND21517__Project(B_Customer_Person_5.__ST4463_Layout __PP21461) := TRANSFORM
    SELF.High_Risk_Death_Prior_To_All_Events_ := MAP(__T(__AND(__CN(__PP21461.Death_Prior_To_All_Events_ = 1),__OP2(__PP21461.Max_Deceased_To_Event_Diff_,<,__CN(-4))))=>1,0);
    SELF := __PP21461;
  END;
  EXPORT __ENH_Customer_Person_4 := PROJECT(__EE21458,__ND21517__Project(LEFT));
END;
