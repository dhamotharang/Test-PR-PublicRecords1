//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,B_Phone_4,B_Phone_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(B_Phone_4.__ENH_Phone_4) __ENH_Phone_4 := B_Phone_4.__ENH_Phone_4;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE198471 := __ENH_Phone_4;
  SHARED __ST198613_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.bool Phone_Event_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE198363 := __E_Phone_Event;
  SHARED __EE198802 := __EE198363(__NN(__EE198363.Transaction_) AND __NN(__EE198363.Phone_Number_));
  SHARED __EE198378 := __ENH_Event_4;
  SHARED __EE198502 := __EE198378(__EE198378.Safe_Flag_ = 1);
  __JC198814(E_Phone_Event.Layout __EE198802, B_Event_4.__ST53186_Layout __EE198502) := __EEQP(__EE198802.Transaction_,__EE198502.UID);
  SHARED __EE198815 := JOIN(__EE198802,__EE198502,__JC198814(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC198832(B_Phone_5.__ST54970_Layout __EE198471, E_Phone_Event.Layout __EE198815) := __EEQP(__EE198471.UID,__EE198815.Phone_Number_);
  __JF198832(E_Phone_Event.Layout __EE198815) := __NN(__EE198815.Phone_Number_);
  SHARED __EE198833 := JOIN(__EE198471,__EE198815,__JC198832(LEFT,RIGHT),TRANSFORM(__ST198613_Layout,SELF:=LEFT,SELF.Phone_Event_:=__JF198832(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST52396_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST52396_Layout __ND198849__Project(__ST198613_Layout __PP198834) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP198834.Phone_Event_=>1,0);
    SELF := __PP198834;
  END;
  EXPORT __ENH_Phone_3 := PROJECT(__EE198833,__ND198849__Project(LEFT));
END;
