//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE142366 := __E_Email;
  SHARED __EE142436 := __E_Email_Event;
  SHARED __EE143155 := __EE142436(__NN(__EE142436.Emailof_) AND __NN(__EE142436.Transaction_));
  SHARED __EE142438 := __ENH_Event_6;
  SHARED __EE142583 := __EE142438(__EE142438.T17___Email_Is_Kr_Flag_ = 1);
  __JC143173(E_Email_Event.Layout __EE143155, B_Event_6.__ST101563_Layout __EE142583) := __EEQP(__EE143155.Transaction_,__EE142583.UID);
  SHARED __EE143174 := JOIN(__EE143155,__EE142583,__JC143173(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST142504_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142504_Layout __ND143184__Project(E_Email_Event.Layout __PP143175) := TRANSFORM
    SELF.UID := __PP143175.Emailof_;
    SELF.U_I_D__1_ := __PP143175.Transaction_;
    SELF := __PP143175;
  END;
  SHARED __EE143209 := PROJECT(__EE143174,__ND143184__Project(LEFT));
  SHARED __ST142530_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE143222 := PROJECT(__CLEANANDDO(__EE143209,TABLE(__EE143209,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST142530_Layout);
  SHARED __ST142784_Layout := RECORD
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
  __JC143228(E_Email.Layout __EE142366, __ST142530_Layout __EE143222) := __EEQP(__EE142366.UID,__EE143222.UID);
  __ST142784_Layout __JT143228(E_Email.Layout __l, __ST142530_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE143229 := JOIN(__EE142366,__EE143222,__JC143228(LEFT,RIGHT),__JT143228(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST97460_Layout := RECORD
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
  EXPORT __ENH_Email_5 := PROJECT(__EE143229,TRANSFORM(__ST97460_Layout,SELF.Aot_Email_Kr_Act_Cnt_Ev_ := LEFT.C_O_U_N_T___Exp1_,SELF := LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
