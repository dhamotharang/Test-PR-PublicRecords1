//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE147256 := __E_Email;
  SHARED __EE147326 := __E_Email_Event;
  SHARED __EE148049 := __EE147326(__NN(__EE147326.Emailof_) AND __NN(__EE147326.Transaction_));
  SHARED __EE147328 := __ENH_Event_6;
  SHARED __EE147474 := __EE147328(__EE147328.T17___Email_Is_Kr_Flag_ = 1);
  __JC148067(E_Email_Event.Layout __EE148049, B_Event_6.__ST106570_Layout __EE147474) := __EEQP(__EE148049.Transaction_,__EE147474.UID);
  SHARED __EE148068 := JOIN(__EE148049,__EE147474,__JC148067(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST147394_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST147394_Layout __ND148078__Project(E_Email_Event.Layout __PP148069) := TRANSFORM
    SELF.UID := __PP148069.Emailof_;
    SELF.U_I_D__1_ := __PP148069.Transaction_;
    SELF := __PP148069;
  END;
  SHARED __EE148103 := PROJECT(__EE148068,__ND148078__Project(LEFT));
  SHARED __ST147420_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE148116 := PROJECT(__CLEANANDDO(__EE148103,TABLE(__EE148103,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST147420_Layout);
  SHARED __ST147676_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC148122(E_Email.Layout __EE147256, __ST147420_Layout __EE148116) := __EEQP(__EE147256.UID,__EE148116.UID);
  __ST147676_Layout __JT148122(E_Email.Layout __l, __ST147420_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE148123 := JOIN(__EE147256,__EE148116,__JC148122(LEFT,RIGHT),__JT148122(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST102071_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int Aot_Email_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST102071_Layout __ND148147__Project(__ST147676_Layout __PP148124) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP148124.C_O_U_N_T___Exp1_,9999);
    SELF := __PP148124;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE148123,__ND148147__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
