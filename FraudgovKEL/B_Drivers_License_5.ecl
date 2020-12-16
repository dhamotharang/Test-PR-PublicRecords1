//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE142574 := __E_Drivers_License;
  SHARED __EE142638 := __E_Drivers_License_Event;
  SHARED __EE143253 := __EE142638(__NN(__EE142638.Licence_) AND __NN(__EE142638.Transaction_));
  SHARED __EE142640 := __ENH_Event_6;
  SHARED __EE142780 := __EE142640(__EE142640.T20___Dl_Is_Kr_Flag_ = 1);
  __JC143271(E_Drivers_License_Event.Layout __EE143253, B_Event_6.__ST102807_Layout __EE142780) := __EEQP(__EE143253.Transaction_,__EE142780.UID);
  SHARED __EE143272 := JOIN(__EE143253,__EE142780,__JC143271(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST142706_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142706_Layout __ND143282__Project(E_Drivers_License_Event.Layout __PP143273) := TRANSFORM
    SELF.UID := __PP143273.Licence_;
    SELF.U_I_D__1_ := __PP143273.Transaction_;
    SELF := __PP143273;
  END;
  SHARED __EE143307 := PROJECT(__EE143272,__ND143282__Project(LEFT));
  SHARED __ST142732_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE143320 := PROJECT(__CLEANANDDO(__EE143307,TABLE(__EE143307,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST142732_Layout);
  SHARED __ST142970_Layout := RECORD
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
  __JC143326(E_Drivers_License.Layout __EE142574, __ST142732_Layout __EE143320) := __EEQP(__EE142574.UID,__EE143320.UID);
  __ST142970_Layout __JT143326(E_Drivers_License.Layout __l, __ST142732_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE143327 := JOIN(__EE142574,__EE143320,__JC143326(LEFT,RIGHT),__JT143326(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST98651_Layout := RECORD
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
  SHARED __ST98651_Layout __ND143345__Project(__ST142970_Layout __PP143328) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP143328.C_O_U_N_T___Exp1_,9999);
    SELF := __PP143328;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE143327,__ND143345__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
