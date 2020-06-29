//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE139714 := __E_Email;
  SHARED __EE139813 := __E_Email_Event;
  SHARED __EE140541 := __EE139813(__NN(__EE139813.Emailof_) AND __NN(__EE139813.Transaction_));
  SHARED __EE139815 := __ENH_Event_6;
  SHARED __EE139966 := __EE139815(__EE139815.T___In_Agency_Flag_ = 1 AND __EE139815.T17___Email_Is_Kr_Flag_ = 1);
  __JC140559(E_Email_Event.Layout __EE140541, B_Event_6.__ST98838_Layout __EE139966) := __EEQP(__EE140541.Transaction_,__EE139966.UID);
  SHARED __EE140560 := JOIN(__EE140541,__EE139966,__JC140559(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST139886_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST139886_Layout __ND140570__Project(E_Email_Event.Layout __PP140561) := TRANSFORM
    SELF.UID := __PP140561.Emailof_;
    SELF.U_I_D__1_ := __PP140561.Transaction_;
    SELF := __PP140561;
  END;
  SHARED __EE140595 := PROJECT(__EE140560,__ND140570__Project(LEFT));
  SHARED __ST139912_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140608 := PROJECT(__CLEANANDDO(__EE140595,TABLE(__EE140595,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST139912_Layout);
  SHARED __ST140168_Layout := RECORD
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
  __JC140614(E_Email.Layout __EE139714, __ST139912_Layout __EE140608) := __EEQP(__EE139714.UID,__EE140608.UID);
  __ST140168_Layout __JT140614(E_Email.Layout __l, __ST139912_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140615 := JOIN(__EE139714,__EE140608,__JC140614(LEFT,RIGHT),__JT140614(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST94530_Layout := RECORD
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
  SHARED __ST94530_Layout __ND140639__Project(__ST140168_Layout __PP140616) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP140616.C_O_U_N_T___Exp1_,9999);
    SELF := __PP140616;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE140615,__ND140639__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
