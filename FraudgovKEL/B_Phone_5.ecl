//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE191204 := __E_Phone;
  SHARED __EE191291 := __E_Phone_Event;
  SHARED __EE191911 := __EE191291(__NN(__EE191291.Phone_Number_) AND __NN(__EE191291.Transaction_));
  SHARED __EE191293 := __ENH_Event_6;
  SHARED __EE191438 := __EE191293(__EE191293.T___In_Agency_Flag_ = 1 AND __EE191293.T16___Phn_Is_Kr_Flag_ = 1);
  __JC191929(E_Phone_Event.Layout __EE191911, B_Event_6.__ST98838_Layout __EE191438) := __EEQP(__EE191911.Transaction_,__EE191438.UID);
  SHARED __EE191930 := JOIN(__EE191911,__EE191438,__JC191929(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST191364_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST191364_Layout __ND191940__Project(E_Phone_Event.Layout __PP191931) := TRANSFORM
    SELF.UID := __PP191931.Phone_Number_;
    SELF.U_I_D__1_ := __PP191931.Transaction_;
    SELF := __PP191931;
  END;
  SHARED __EE191965 := PROJECT(__EE191930,__ND191940__Project(LEFT));
  SHARED __ST191390_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE191978 := PROJECT(__CLEANANDDO(__EE191965,TABLE(__EE191965,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST191390_Layout);
  SHARED __ST191628_Layout := RECORD
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
  __JC191984(E_Phone.Layout __EE191204, __ST191390_Layout __EE191978) := __EEQP(__EE191204.UID,__EE191978.UID);
  __ST191628_Layout __JT191984(E_Phone.Layout __l, __ST191390_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE191985 := JOIN(__EE191204,__EE191978,__JC191984(LEFT,RIGHT),__JT191984(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST97235_Layout := RECORD
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
  SHARED __ST97235_Layout __ND192003__Project(__ST191628_Layout __PP191986) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP191986.C_O_U_N_T___Exp1_,9999);
    SELF := __PP191986;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE191985,__ND192003__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
