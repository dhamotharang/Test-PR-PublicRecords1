//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE135726 := __E_Email;
  SHARED __EE135825 := __E_Email_Event;
  SHARED __EE136553 := __EE135825(__NN(__EE135825.Emailof_) AND __NN(__EE135825.Transaction_));
  SHARED __EE135827 := __ENH_Event_6;
  SHARED __EE135978 := __EE135827(__EE135827.T___In_Agency_Flag_ = 1 AND __EE135827.T17___Email_Is_Kr_Flag_ = 1);
  __JC136571(E_Email_Event.Layout __EE136553, B_Event_6.__ST95508_Layout __EE135978) := __EEQP(__EE136553.Transaction_,__EE135978.UID);
  SHARED __EE136572 := JOIN(__EE136553,__EE135978,__JC136571(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST135898_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST135898_Layout __ND136582__Project(E_Email_Event.Layout __PP136573) := TRANSFORM
    SELF.UID := __PP136573.Emailof_;
    SELF.U_I_D__1_ := __PP136573.Transaction_;
    SELF := __PP136573;
  END;
  SHARED __EE136607 := PROJECT(__EE136572,__ND136582__Project(LEFT));
  SHARED __ST135924_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE136620 := PROJECT(__CLEANANDDO(__EE136607,TABLE(__EE136607,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST135924_Layout);
  SHARED __ST136180_Layout := RECORD
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
  __JC136626(E_Email.Layout __EE135726, __ST135924_Layout __EE136620) := __EEQP(__EE135726.UID,__EE136620.UID);
  __ST136180_Layout __JT136626(E_Email.Layout __l, __ST135924_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE136627 := JOIN(__EE135726,__EE136620,__JC136626(LEFT,RIGHT),__JT136626(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST91221_Layout := RECORD
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
  SHARED __ST91221_Layout __ND136651__Project(__ST136180_Layout __PP136628) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP136628.C_O_U_N_T___Exp1_,9999);
    SELF := __PP136628;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE136627,__ND136651__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
