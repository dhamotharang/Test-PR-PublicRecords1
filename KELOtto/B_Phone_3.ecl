//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,B_Phone_4,B_Phone_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(B_Phone_4.__ENH_Phone_4) __ENH_Phone_4 := B_Phone_4.__ENH_Phone_4;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE222785 := __ENH_Phone_4;
  SHARED __ST222927_Layout := RECORD
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
  SHARED __EE222677 := __E_Phone_Event;
  SHARED __EE223116 := __EE222677(__NN(__EE222677.Transaction_) AND __NN(__EE222677.Phone_Number_));
  SHARED __EE222692 := __ENH_Event_4;
  SHARED __EE222816 := __EE222692(__EE222692.Safe_Flag_ = 1);
  __JC223128(E_Phone_Event.Layout __EE223116, B_Event_4.__ST57011_Layout __EE222816) := __EEQP(__EE223116.Transaction_,__EE222816.UID);
  SHARED __EE223129 := JOIN(__EE223116,__EE222816,__JC223128(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC223146(B_Phone_5.__ST58856_Layout __EE222785, E_Phone_Event.Layout __EE223129) := __EEQP(__EE222785.UID,__EE223129.Phone_Number_);
  __JF223146(E_Phone_Event.Layout __EE223129) := __NN(__EE223129.Phone_Number_);
  SHARED __EE223147 := JOIN(__EE222785,__EE223129,__JC223146(LEFT,RIGHT),TRANSFORM(__ST222927_Layout,SELF:=LEFT,SELF.Phone_Event_:=__JF223146(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST56220_Layout := RECORD
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
  SHARED __ST56220_Layout __ND223163__Project(__ST222927_Layout __PP223148) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP223148.Phone_Event_=>1,0);
    SELF := __PP223148;
  END;
  EXPORT __ENH_Phone_3 := PROJECT(__EE223147,__ND223163__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Phone::Annotated_3',EXPIRE(7));
END;
