//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE146201 := __E_Drivers_License;
  SHARED __EE146265 := __E_Drivers_License_Event;
  SHARED __EE146880 := __EE146265(__NN(__EE146265.Licence_) AND __NN(__EE146265.Transaction_));
  SHARED __EE146267 := __ENH_Event_6;
  SHARED __EE146407 := __EE146267(__EE146267.T20___Dl_Is_Kr_Flag_ = 1);
  __JC146898(E_Drivers_License_Event.Layout __EE146880, B_Event_6.__ST106570_Layout __EE146407) := __EEQP(__EE146880.Transaction_,__EE146407.UID);
  SHARED __EE146899 := JOIN(__EE146880,__EE146407,__JC146898(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST146333_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST146333_Layout __ND146909__Project(E_Drivers_License_Event.Layout __PP146900) := TRANSFORM
    SELF.UID := __PP146900.Licence_;
    SELF.U_I_D__1_ := __PP146900.Transaction_;
    SELF := __PP146900;
  END;
  SHARED __EE146934 := PROJECT(__EE146899,__ND146909__Project(LEFT));
  SHARED __ST146359_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE146947 := PROJECT(__CLEANANDDO(__EE146934,TABLE(__EE146934,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST146359_Layout);
  SHARED __ST146597_Layout := RECORD
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
  __JC146953(E_Drivers_License.Layout __EE146201, __ST146359_Layout __EE146947) := __EEQP(__EE146201.UID,__EE146947.UID);
  __ST146597_Layout __JT146953(E_Drivers_License.Layout __l, __ST146359_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE146954 := JOIN(__EE146201,__EE146947,__JC146953(LEFT,RIGHT),__JT146953(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST102040_Layout := RECORD
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
  SHARED __ST102040_Layout __ND146972__Project(__ST146597_Layout __PP146955) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP146955.C_O_U_N_T___Exp1_,9999);
    SELF := __PP146955;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE146954,__ND146972__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
