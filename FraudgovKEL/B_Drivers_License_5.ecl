//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE134633 := __E_Drivers_License;
  SHARED __EE134720 := __E_Drivers_License_Event;
  SHARED __EE135340 := __EE134720(__NN(__EE134720.Licence_) AND __NN(__EE134720.Transaction_));
  SHARED __EE134722 := __ENH_Event_6;
  SHARED __EE134867 := __EE134722(__EE134722.T___In_Agency_Flag_ = 1 AND __EE134722.T20___Dl_Is_Kr_Flag_ = 1);
  __JC135358(E_Drivers_License_Event.Layout __EE135340, B_Event_6.__ST95508_Layout __EE134867) := __EEQP(__EE135340.Transaction_,__EE134867.UID);
  SHARED __EE135359 := JOIN(__EE135340,__EE134867,__JC135358(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST134793_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST134793_Layout __ND135369__Project(E_Drivers_License_Event.Layout __PP135360) := TRANSFORM
    SELF.UID := __PP135360.Licence_;
    SELF.U_I_D__1_ := __PP135360.Transaction_;
    SELF := __PP135360;
  END;
  SHARED __EE135394 := PROJECT(__EE135359,__ND135369__Project(LEFT));
  SHARED __ST134819_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE135407 := PROJECT(__CLEANANDDO(__EE135394,TABLE(__EE135394,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST134819_Layout);
  SHARED __ST135057_Layout := RECORD
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
  __JC135413(E_Drivers_License.Layout __EE134633, __ST134819_Layout __EE135407) := __EEQP(__EE134633.UID,__EE135407.UID);
  __ST135057_Layout __JT135413(E_Drivers_License.Layout __l, __ST134819_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE135414 := JOIN(__EE134633,__EE135407,__JC135413(LEFT,RIGHT),__JT135413(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST91186_Layout := RECORD
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
  SHARED __ST91186_Layout __ND135432__Project(__ST135057_Layout __PP135415) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP135415.C_O_U_N_T___Exp1_,9999);
    SELF := __PP135415;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE135414,__ND135432__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
