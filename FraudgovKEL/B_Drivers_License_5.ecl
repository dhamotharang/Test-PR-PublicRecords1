//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE140866 := __E_Drivers_License;
  SHARED __EE140953 := __E_Drivers_License_Event;
  SHARED __EE141573 := __EE140953(__NN(__EE140953.Licence_) AND __NN(__EE140953.Transaction_));
  SHARED __EE140955 := __ENH_Event_6;
  SHARED __EE141100 := __EE140955(__EE140955.T___In_Agency_Flag_ = 1 AND __EE140955.T20___Dl_Is_Kr_Flag_ = 1);
  __JC141591(E_Drivers_License_Event.Layout __EE141573, B_Event_6.__ST101096_Layout __EE141100) := __EEQP(__EE141573.Transaction_,__EE141100.UID);
  SHARED __EE141592 := JOIN(__EE141573,__EE141100,__JC141591(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST141026_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST141026_Layout __ND141602__Project(E_Drivers_License_Event.Layout __PP141593) := TRANSFORM
    SELF.UID := __PP141593.Licence_;
    SELF.U_I_D__1_ := __PP141593.Transaction_;
    SELF := __PP141593;
  END;
  SHARED __EE141627 := PROJECT(__EE141592,__ND141602__Project(LEFT));
  SHARED __ST141052_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE141640 := PROJECT(__CLEANANDDO(__EE141627,TABLE(__EE141627,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST141052_Layout);
  SHARED __ST141290_Layout := RECORD
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
  __JC141646(E_Drivers_License.Layout __EE140866, __ST141052_Layout __EE141640) := __EEQP(__EE140866.UID,__EE141640.UID);
  __ST141290_Layout __JT141646(E_Drivers_License.Layout __l, __ST141052_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE141647 := JOIN(__EE140866,__EE141640,__JC141646(LEFT,RIGHT),__JT141646(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST96533_Layout := RECORD
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
  SHARED __ST96533_Layout __ND141665__Project(__ST141290_Layout __PP141648) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP141648.C_O_U_N_T___Exp1_,9999);
    SELF := __PP141648;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE141647,__ND141665__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
