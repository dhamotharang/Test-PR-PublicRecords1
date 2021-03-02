//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE179170 := __E_Phone;
  SHARED __EE179234 := __E_Phone_Event;
  SHARED __EE179845 := __EE179234(__NN(__EE179234.Phone_Number_) AND __NN(__EE179234.Transaction_));
  SHARED __EE179236 := __ENH_Event_6;
  SHARED __EE179375 := __EE179236(__EE179236.T16___Phn_Is_Kr_Flag_ = 1);
  __JC179863(E_Phone_Event.Layout __EE179845, B_Event_6.__ST101563_Layout __EE179375) := __EEQP(__EE179845.Transaction_,__EE179375.UID);
  SHARED __EE179864 := JOIN(__EE179845,__EE179375,__JC179863(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST179302_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST179302_Layout __ND179874__Project(E_Phone_Event.Layout __PP179865) := TRANSFORM
    SELF.UID := __PP179865.Phone_Number_;
    SELF.U_I_D__1_ := __PP179865.Transaction_;
    SELF := __PP179865;
  END;
  SHARED __EE179899 := PROJECT(__EE179864,__ND179874__Project(LEFT));
  SHARED __ST179328_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE179912 := PROJECT(__CLEANANDDO(__EE179899,TABLE(__EE179899,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST179328_Layout);
  SHARED __ST179564_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC179918(E_Phone.Layout __EE179170, __ST179328_Layout __EE179912) := __EEQP(__EE179170.UID,__EE179912.UID);
  __ST179564_Layout __JT179918(E_Phone.Layout __l, __ST179328_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE179919 := JOIN(__EE179170,__EE179912,__JC179918(LEFT,RIGHT),__JT179918(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST99887_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Aot_Phn_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE179919,TRANSFORM(__ST99887_Layout,SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := LEFT.C_O_U_N_T___Exp1_,SELF := LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
