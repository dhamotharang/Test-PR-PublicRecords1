//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE138621 := __E_Drivers_License;
  SHARED __EE138708 := __E_Drivers_License_Event;
  SHARED __EE139328 := __EE138708(__NN(__EE138708.Licence_) AND __NN(__EE138708.Transaction_));
  SHARED __EE138710 := __ENH_Event_6;
  SHARED __EE138855 := __EE138710(__EE138710.T___In_Agency_Flag_ = 1 AND __EE138710.T20___Dl_Is_Kr_Flag_ = 1);
  __JC139346(E_Drivers_License_Event.Layout __EE139328, B_Event_6.__ST98838_Layout __EE138855) := __EEQP(__EE139328.Transaction_,__EE138855.UID);
  SHARED __EE139347 := JOIN(__EE139328,__EE138855,__JC139346(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST138781_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST138781_Layout __ND139357__Project(E_Drivers_License_Event.Layout __PP139348) := TRANSFORM
    SELF.UID := __PP139348.Licence_;
    SELF.U_I_D__1_ := __PP139348.Transaction_;
    SELF := __PP139348;
  END;
  SHARED __EE139382 := PROJECT(__EE139347,__ND139357__Project(LEFT));
  SHARED __ST138807_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE139395 := PROJECT(__CLEANANDDO(__EE139382,TABLE(__EE139382,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST138807_Layout);
  SHARED __ST139045_Layout := RECORD
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
  __JC139401(E_Drivers_License.Layout __EE138621, __ST138807_Layout __EE139395) := __EEQP(__EE138621.UID,__EE139395.UID);
  __ST139045_Layout __JT139401(E_Drivers_License.Layout __l, __ST138807_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE139402 := JOIN(__EE138621,__EE139395,__JC139401(LEFT,RIGHT),__JT139401(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST94495_Layout := RECORD
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
  SHARED __ST94495_Layout __ND139420__Project(__ST139045_Layout __PP139403) := TRANSFORM
    SELF.Aot_Dl_Kr_Act_Cnt_Ev_ := MIN(__PP139403.C_O_U_N_T___Exp1_,9999);
    SELF := __PP139403;
  END;
  EXPORT __ENH_Drivers_License_5 := PROJECT(__EE139402,__ND139420__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Drivers_License::Annotated_5',EXPIRE(7));
END;
