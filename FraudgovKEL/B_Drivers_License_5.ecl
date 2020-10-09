//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE138886 := __E_Drivers_License;
  SHARED __EE138950 := __E_Drivers_License_Event;
  SHARED __EE139565 := __EE138950(__NN(__EE138950.Licence_) AND __NN(__EE138950.Transaction_));
  SHARED __EE138952 := __ENH_Event_6;
  SHARED __EE139092 := __EE138952(__EE138952.T20___Dl_Is_Kr_Flag_ = 1);
  __JC139583(E_Drivers_License_Event.Layout __EE139565, B_Event_6.__ST99302_Layout __EE139092) := __EEQP(__EE139565.Transaction_,__EE139092.UID);
  SHARED __EE139584 := JOIN(__EE139565,__EE139092,__JC139583(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST139018_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST139018_Layout __ND139594__Project(E_Drivers_License_Event.Layout __PP139585) := TRANSFORM
    SELF.UID := __PP139585.Licence_;
    SELF.U_I_D__1_ := __PP139585.Transaction_;
    SELF := __PP139585;
  END;
  SHARED __EE139619 := PROJECT(__EE139584,__ND139594__Project(LEFT));
  SHARED __ST139044_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE139632 := PROJECT(__CLEANANDDO(__EE139619,TABLE(__EE139619,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST139044_Layout);
  SHARED __ST139282_Layout := RECORD
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
  __JC139638(E_Drivers_License.Layout __EE138886, __ST139044_Layout __EE139632) := __EEQP(__EE138886.UID,__EE139632.UID);
  __ST139282_Layout __JT139638(E_Drivers_License.Layout __l, __ST139044_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE139639 := JOIN(__EE138886,__EE139632,__JC139638(LEFT,RIGHT),__JT139638(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95146_Layout := RECORD
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
  SHARED __ST95146_Layout __ND139657__Project(__ST139282_Layout __PP139640) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP139640.C_O_U_N_T___Exp1_,9999);
    SELF := __PP139640;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE139639,__ND139657__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
