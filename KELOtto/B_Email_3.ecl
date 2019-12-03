//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_4,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_4.__ENH_Email_4) __ENH_Email_4 := B_Email_4.__ENH_Email_4;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE188000 := __ENH_Email_4;
  SHARED __ST188195_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.bool Email_Event_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE187884 := __E_Email_Event;
  SHARED __EE188459 := __EE187884(__NN(__EE187884.Transaction_) AND __NN(__EE187884.Emailof_));
  SHARED __EE187899 := __ENH_Event_4;
  SHARED __EE188047 := __EE187899(__EE187899.Safe_Flag_ = 1);
  __JC188471(E_Email_Event.Layout __EE188459, B_Event_4.__ST57011_Layout __EE188047) := __EEQP(__EE188459.Transaction_,__EE188047.UID);
  SHARED __EE188472 := JOIN(__EE188459,__EE188047,__JC188471(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC188489(B_Email_4.__ST56494_Layout __EE188000, E_Email_Event.Layout __EE188472) := __EEQP(__EE188000.UID,__EE188472.Emailof_);
  __JF188489(E_Email_Event.Layout __EE188472) := __NN(__EE188472.Emailof_);
  SHARED __EE188490 := JOIN(__EE188000,__EE188472,__JC188489(LEFT,RIGHT),TRANSFORM(__ST188195_Layout,SELF:=LEFT,SELF.Email_Event_:=__JF188489(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST54836_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Identity_Count_Gt2_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST54836_Layout __ND188513__Project(__ST188195_Layout __PP188491) := TRANSFORM
    SELF.Identity_Count_Gt2_ := MAP(__PP188491.Identity_Count_ > 2=>1,0);
    SELF.Safe_Flag_ := MAP(__PP188491.Email_Event_=>1,0);
    SELF := __PP188491;
  END;
  EXPORT __ENH_Email_3 := PROJECT(__EE188490,__ND188513__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated_3',EXPIRE(7));
END;
