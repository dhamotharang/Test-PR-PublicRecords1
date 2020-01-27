//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,B_Phone_4,B_Phone_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(B_Phone_4.__ENH_Phone_4) __ENH_Phone_4 := B_Phone_4.__ENH_Phone_4;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE226451 := __ENH_Phone_4;
  SHARED __ST226593_Layout := RECORD
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
  SHARED __EE226343 := __E_Phone_Event;
  SHARED __EE226782 := __EE226343(__NN(__EE226343.Transaction_) AND __NN(__EE226343.Phone_Number_));
  SHARED __EE226358 := __ENH_Event_4;
  SHARED __EE226482 := __EE226358(__EE226358.Safe_Flag_ = 1);
  __JC226794(E_Phone_Event.Layout __EE226782, B_Event_4.__ST60665_Layout __EE226482) := __EEQP(__EE226782.Transaction_,__EE226482.UID);
  SHARED __EE226795 := JOIN(__EE226782,__EE226482,__JC226794(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC226812(B_Phone_5.__ST62516_Layout __EE226451, E_Phone_Event.Layout __EE226795) := __EEQP(__EE226451.UID,__EE226795.Phone_Number_);
  __JF226812(E_Phone_Event.Layout __EE226795) := __NN(__EE226795.Phone_Number_);
  SHARED __EE226813 := JOIN(__EE226451,__EE226795,__JC226812(LEFT,RIGHT),TRANSFORM(__ST226593_Layout,SELF:=LEFT,SELF.Phone_Event_:=__JF226812(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST59866_Layout := RECORD
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
  SHARED __ST59866_Layout __ND226829__Project(__ST226593_Layout __PP226814) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP226814.Phone_Event_=>1,0);
    SELF := __PP226814;
  END;
  EXPORT __ENH_Phone_3 := PROJECT(__EE226813,__ND226829__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Phone::Annotated_3',EXPIRE(7));
END;
