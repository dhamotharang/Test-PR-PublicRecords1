//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_4,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_4.__ENH_Email_4) __ENH_Email_4 := B_Email_4.__ENH_Email_4;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE198165 := __ENH_Email_4;
  SHARED __ST198360_Layout := RECORD
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
  SHARED __EE198049 := __E_Email_Event;
  SHARED __EE198624 := __EE198049(__NN(__EE198049.Transaction_) AND __NN(__EE198049.Emailof_));
  SHARED __EE198064 := __ENH_Event_4;
  SHARED __EE198212 := __EE198064(__EE198064.Safe_Flag_ = 1);
  __JC198636(E_Email_Event.Layout __EE198624, B_Event_4.__ST61185_Layout __EE198212) := __EEQP(__EE198624.Transaction_,__EE198212.UID);
  SHARED __EE198637 := JOIN(__EE198624,__EE198212,__JC198636(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC198654(B_Email_4.__ST60553_Layout __EE198165, E_Email_Event.Layout __EE198637) := __EEQP(__EE198165.UID,__EE198637.Emailof_);
  __JF198654(E_Email_Event.Layout __EE198637) := __NN(__EE198637.Emailof_);
  SHARED __EE198655 := JOIN(__EE198165,__EE198637,__JC198654(LEFT,RIGHT),TRANSFORM(__ST198360_Layout,SELF:=LEFT,SELF.Email_Event_:=__JF198654(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58713_Layout := RECORD
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
  SHARED __ST58713_Layout __ND198678__Project(__ST198360_Layout __PP198656) := TRANSFORM
    SELF.Identity_Count_Gt2_ := MAP(__PP198656.Identity_Count_ > 2=>1,0);
    SELF.Safe_Flag_ := MAP(__PP198656.Email_Event_=>1,0);
    SELF := __PP198656;
  END;
  EXPORT __ENH_Email_3 := PROJECT(__EE198655,__ND198678__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated_3',EXPIRE(7));
END;
