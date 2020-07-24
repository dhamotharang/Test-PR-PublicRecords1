//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE140804 := __E_Drivers_License;
  SHARED __EE140891 := __E_Drivers_License_Event;
  SHARED __EE141511 := __EE140891(__NN(__EE140891.Licence_) AND __NN(__EE140891.Transaction_));
  SHARED __EE140893 := __ENH_Event_6;
  SHARED __EE141038 := __EE140893(__EE140893.T___In_Agency_Flag_ = 1 AND __EE140893.T20___Dl_Is_Kr_Flag_ = 1);
  __JC141529(E_Drivers_License_Event.Layout __EE141511, B_Event_6.__ST101034_Layout __EE141038) := __EEQP(__EE141511.Transaction_,__EE141038.UID);
  SHARED __EE141530 := JOIN(__EE141511,__EE141038,__JC141529(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST140964_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST140964_Layout __ND141540__Project(E_Drivers_License_Event.Layout __PP141531) := TRANSFORM
    SELF.UID := __PP141531.Licence_;
    SELF.U_I_D__1_ := __PP141531.Transaction_;
    SELF := __PP141531;
  END;
  SHARED __EE141565 := PROJECT(__EE141530,__ND141540__Project(LEFT));
  SHARED __ST140990_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE141578 := PROJECT(__CLEANANDDO(__EE141565,TABLE(__EE141565,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST140990_Layout);
  SHARED __ST141228_Layout := RECORD
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
  __JC141584(E_Drivers_License.Layout __EE140804, __ST140990_Layout __EE141578) := __EEQP(__EE140804.UID,__EE141578.UID);
  __ST141228_Layout __JT141584(E_Drivers_License.Layout __l, __ST140990_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE141585 := JOIN(__EE140804,__EE141578,__JC141584(LEFT,RIGHT),__JT141584(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST96471_Layout := RECORD
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
  SHARED __ST96471_Layout __ND141603__Project(__ST141228_Layout __PP141586) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP141586.C_O_U_N_T___Exp1_,9999);
    SELF := __PP141586;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE141585,__ND141603__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
