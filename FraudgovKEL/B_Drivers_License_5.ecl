//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE140112 := __E_Drivers_License;
  SHARED __EE140199 := __E_Drivers_License_Event;
  SHARED __EE140819 := __EE140199(__NN(__EE140199.Licence_) AND __NN(__EE140199.Transaction_));
  SHARED __EE140201 := __ENH_Event_6;
  SHARED __EE140346 := __EE140201(__EE140201.T___In_Agency_Flag_ = 1 AND __EE140201.T20___Dl_Is_Kr_Flag_ = 1);
  __JC140837(E_Drivers_License_Event.Layout __EE140819, B_Event_6.__ST100342_Layout __EE140346) := __EEQP(__EE140819.Transaction_,__EE140346.UID);
  SHARED __EE140838 := JOIN(__EE140819,__EE140346,__JC140837(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST140272_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST140272_Layout __ND140848__Project(E_Drivers_License_Event.Layout __PP140839) := TRANSFORM
    SELF.UID := __PP140839.Licence_;
    SELF.U_I_D__1_ := __PP140839.Transaction_;
    SELF := __PP140839;
  END;
  SHARED __EE140873 := PROJECT(__EE140838,__ND140848__Project(LEFT));
  SHARED __ST140298_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140886 := PROJECT(__CLEANANDDO(__EE140873,TABLE(__EE140873,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST140298_Layout);
  SHARED __ST140536_Layout := RECORD
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
  __JC140892(E_Drivers_License.Layout __EE140112, __ST140298_Layout __EE140886) := __EEQP(__EE140112.UID,__EE140886.UID);
  __ST140536_Layout __JT140892(E_Drivers_License.Layout __l, __ST140298_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140893 := JOIN(__EE140112,__EE140886,__JC140892(LEFT,RIGHT),__JT140892(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95791_Layout := RECORD
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
  SHARED __ST95791_Layout __ND140911__Project(__ST140536_Layout __PP140894) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP140894.C_O_U_N_T___Exp1_,9999);
    SELF := __PP140894;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE140893,__ND140911__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
