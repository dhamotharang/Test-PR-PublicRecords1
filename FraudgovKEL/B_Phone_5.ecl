//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE199176 := __E_Phone;
  SHARED __EE199263 := __E_Phone_Event;
  SHARED __EE199883 := __EE199263(__NN(__EE199263.Phone_Number_) AND __NN(__EE199263.Transaction_));
  SHARED __EE199265 := __ENH_Event_6;
  SHARED __EE199410 := __EE199265(__EE199265.T___In_Agency_Flag_ = 1 AND __EE199265.T16___Phn_Is_Kr_Flag_ = 1);
  __JC199901(E_Phone_Event.Layout __EE199883, B_Event_6.__ST101034_Layout __EE199410) := __EEQP(__EE199883.Transaction_,__EE199410.UID);
  SHARED __EE199902 := JOIN(__EE199883,__EE199410,__JC199901(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST199336_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST199336_Layout __ND199912__Project(E_Phone_Event.Layout __PP199903) := TRANSFORM
    SELF.UID := __PP199903.Phone_Number_;
    SELF.U_I_D__1_ := __PP199903.Transaction_;
    SELF := __PP199903;
  END;
  SHARED __EE199937 := PROJECT(__EE199902,__ND199912__Project(LEFT));
  SHARED __ST199362_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE199950 := PROJECT(__CLEANANDDO(__EE199937,TABLE(__EE199937,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST199362_Layout);
  SHARED __ST199600_Layout := RECORD
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
  __JC199956(E_Phone.Layout __EE199176, __ST199362_Layout __EE199950) := __EEQP(__EE199176.UID,__EE199950.UID);
  __ST199600_Layout __JT199956(E_Phone.Layout __l, __ST199362_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE199957 := JOIN(__EE199176,__EE199950,__JC199956(LEFT,RIGHT),__JT199956(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST99332_Layout := RECORD
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
  SHARED __ST99332_Layout __ND199975__Project(__ST199600_Layout __PP199958) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP199958.C_O_U_N_T___Exp1_,9999);
    SELF := __PP199958;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE199957,__ND199975__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
