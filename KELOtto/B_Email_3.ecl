//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_4,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_4.__ENH_Email_4) __ENH_Email_4 := B_Email_4.__ENH_Email_4;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE191666 := __ENH_Email_4;
  SHARED __ST191861_Layout := RECORD
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
  SHARED __EE191550 := __E_Email_Event;
  SHARED __EE192125 := __EE191550(__NN(__EE191550.Transaction_) AND __NN(__EE191550.Emailof_));
  SHARED __EE191565 := __ENH_Event_4;
  SHARED __EE191713 := __EE191565(__EE191565.Safe_Flag_ = 1);
  __JC192137(E_Email_Event.Layout __EE192125, B_Event_4.__ST60665_Layout __EE191713) := __EEQP(__EE192125.Transaction_,__EE191713.UID);
  SHARED __EE192138 := JOIN(__EE192125,__EE191713,__JC192137(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC192155(B_Email_4.__ST60140_Layout __EE191666, E_Email_Event.Layout __EE192138) := __EEQP(__EE191666.UID,__EE192138.Emailof_);
  __JF192155(E_Email_Event.Layout __EE192138) := __NN(__EE192138.Emailof_);
  SHARED __EE192156 := JOIN(__EE191666,__EE192138,__JC192155(LEFT,RIGHT),TRANSFORM(__ST191861_Layout,SELF:=LEFT,SELF.Email_Event_:=__JF192155(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58474_Layout := RECORD
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
  SHARED __ST58474_Layout __ND192179__Project(__ST191861_Layout __PP192157) := TRANSFORM
    SELF.Identity_Count_Gt2_ := MAP(__PP192157.Identity_Count_ > 2=>1,0);
    SELF.Safe_Flag_ := MAP(__PP192157.Email_Event_=>1,0);
    SELF := __PP192157;
  END;
  EXPORT __ENH_Email_3 := PROJECT(__EE192156,__ND192179__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated_3',EXPIRE(7));
END;
