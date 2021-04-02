//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE141317 := __E_Drivers_License;
  SHARED __EE141381 := __E_Drivers_License_Event;
  SHARED __EE141992 := __EE141381(__NN(__EE141381.Licence_) AND __NN(__EE141381.Transaction_));
  SHARED __EE141383 := __ENH_Event_6;
  SHARED __EE141522 := __EE141383(__EE141383.T20___Dl_Is_Kr_Flag_ = 1);
  __JC142010(E_Drivers_License_Event.Layout __EE141992, B_Event_6.__ST101563_Layout __EE141522) := __EEQP(__EE141992.Transaction_,__EE141522.UID);
  SHARED __EE142011 := JOIN(__EE141992,__EE141522,__JC142010(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST141449_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST141449_Layout __ND142021__Project(E_Drivers_License_Event.Layout __PP142012) := TRANSFORM
    SELF.UID := __PP142012.Licence_;
    SELF.U_I_D__1_ := __PP142012.Transaction_;
    SELF := __PP142012;
  END;
  SHARED __EE142046 := PROJECT(__EE142011,__ND142021__Project(LEFT));
  SHARED __ST141475_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE142059 := PROJECT(__CLEANANDDO(__EE142046,TABLE(__EE142046,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST141475_Layout);
  SHARED __ST141711_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC142065(E_Drivers_License.Layout __EE141317, __ST141475_Layout __EE142059) := __EEQP(__EE141317.UID,__EE142059.UID);
  __ST141711_Layout __JT142065(E_Drivers_License.Layout __l, __ST141475_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE142066 := JOIN(__EE141317,__EE142059,__JC142065(LEFT,RIGHT),__JT142065(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST97431_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.int Aot_Dl_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE142066,TRANSFORM(__ST97431_Layout,SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := LEFT.C_O_U_N_T___Exp1_,SELF := LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
