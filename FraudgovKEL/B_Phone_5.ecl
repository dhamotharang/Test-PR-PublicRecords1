//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE199238 := __E_Phone;
  SHARED __EE199325 := __E_Phone_Event;
  SHARED __EE199945 := __EE199325(__NN(__EE199325.Phone_Number_) AND __NN(__EE199325.Transaction_));
  SHARED __EE199327 := __ENH_Event_6;
  SHARED __EE199472 := __EE199327(__EE199327.T___In_Agency_Flag_ = 1 AND __EE199327.T16___Phn_Is_Kr_Flag_ = 1);
  __JC199963(E_Phone_Event.Layout __EE199945, B_Event_6.__ST101096_Layout __EE199472) := __EEQP(__EE199945.Transaction_,__EE199472.UID);
  SHARED __EE199964 := JOIN(__EE199945,__EE199472,__JC199963(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST199398_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST199398_Layout __ND199974__Project(E_Phone_Event.Layout __PP199965) := TRANSFORM
    SELF.UID := __PP199965.Phone_Number_;
    SELF.U_I_D__1_ := __PP199965.Transaction_;
    SELF := __PP199965;
  END;
  SHARED __EE199999 := PROJECT(__EE199964,__ND199974__Project(LEFT));
  SHARED __ST199424_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE200012 := PROJECT(__CLEANANDDO(__EE199999,TABLE(__EE199999,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST199424_Layout);
  SHARED __ST199662_Layout := RECORD
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
  __JC200018(E_Phone.Layout __EE199238, __ST199424_Layout __EE200012) := __EEQP(__EE199238.UID,__EE200012.UID);
  __ST199662_Layout __JT200018(E_Phone.Layout __l, __ST199424_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE200019 := JOIN(__EE199238,__EE200012,__JC200018(LEFT,RIGHT),__JT200018(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST99394_Layout := RECORD
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
  SHARED __ST99394_Layout __ND200037__Project(__ST199662_Layout __PP200020) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP200020.C_O_U_N_T___Exp1_,9999);
    SELF := __PP200020;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE200019,__ND200037__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
