//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email_4,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Email_4.__ENH_Email_4) __ENH_Email_4 := B_Email_4.__ENH_Email_4;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE179797 := __ENH_Email_4;
  SHARED __ST179992_Layout := RECORD
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
  SHARED __EE179681 := __E_Email_Event;
  SHARED __EE180256 := __EE179681(__NN(__EE179681.Transaction_) AND __NN(__EE179681.Emailof_));
  SHARED __EE179696 := __ENH_Event_4;
  SHARED __EE179844 := __EE179696(__EE179696.Safe_Flag_ = 1);
  __JC180268(E_Email_Event.Layout __EE180256, B_Event_4.__ST53186_Layout __EE179844) := __EEQP(__EE180256.Transaction_,__EE179844.UID);
  SHARED __EE180269 := JOIN(__EE180256,__EE179844,__JC180268(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC180286(B_Email_4.__ST52670_Layout __EE179797, E_Email_Event.Layout __EE180269) := __EEQP(__EE179797.UID,__EE180269.Emailof_);
  __JF180286(E_Email_Event.Layout __EE180269) := __NN(__EE180269.Emailof_);
  SHARED __EE180287 := JOIN(__EE179797,__EE180269,__JC180286(LEFT,RIGHT),TRANSFORM(__ST179992_Layout,SELF:=LEFT,SELF.Email_Event_:=__JF180286(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST51074_Layout := RECORD
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
  SHARED __ST51074_Layout __ND180310__Project(__ST179992_Layout __PP180288) := TRANSFORM
    SELF.Identity_Count_Gt2_ := MAP(__PP180288.Identity_Count_ > 2=>1,0);
    SELF.Safe_Flag_ := MAP(__PP180288.Email_Event_=>1,0);
    SELF := __PP180288;
  END;
  EXPORT __ENH_Email_3 := PROJECT(__EE180287,__ND180310__Project(LEFT));
END;
