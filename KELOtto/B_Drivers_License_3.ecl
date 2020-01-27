//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_4,B_Drivers_License_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_4.__ENH_Drivers_License_4) __ENH_Drivers_License_4 := B_Drivers_License_4.__ENH_Drivers_License_4;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE190989 := __ENH_Drivers_License_4;
  SHARED __ST191131_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.bool Drivers_License_Event_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE190881 := __E_Drivers_License_Event;
  SHARED __EE191320 := __EE190881(__NN(__EE190881.Transaction_) AND __NN(__EE190881.Licence_));
  SHARED __EE190896 := __ENH_Event_4;
  SHARED __EE191020 := __EE190896(__EE190896.Safe_Flag_ = 1);
  __JC191332(E_Drivers_License_Event.Layout __EE191320, B_Event_4.__ST60665_Layout __EE191020) := __EEQP(__EE191320.Transaction_,__EE191020.UID);
  SHARED __EE191333 := JOIN(__EE191320,__EE191020,__JC191332(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC191350(B_Drivers_License_5.__ST61484_Layout __EE190989, E_Drivers_License_Event.Layout __EE191333) := __EEQP(__EE190989.UID,__EE191333.Licence_);
  __JF191350(E_Drivers_License_Event.Layout __EE191333) := __NN(__EE191333.Licence_);
  SHARED __EE191351 := JOIN(__EE190989,__EE191333,__JC191350(LEFT,RIGHT),TRANSFORM(__ST191131_Layout,SELF:=LEFT,SELF.Drivers_License_Event_:=__JF191350(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58421_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST58421_Layout __ND191367__Project(__ST191131_Layout __PP191352) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP191352.Drivers_License_Event_=>1,0);
    SELF := __PP191352;
  END;
  EXPORT __ENH_Drivers_License_3 := PROJECT(__EE191351,__ND191367__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Drivers_License::Annotated_3',EXPIRE(7));
END;
