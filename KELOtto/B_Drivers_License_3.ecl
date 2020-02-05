//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_4,B_Drivers_License_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_4.__ENH_Drivers_License_4) __ENH_Drivers_License_4 := B_Drivers_License_4.__ENH_Drivers_License_4;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE197488 := __ENH_Drivers_License_4;
  SHARED __ST197630_Layout := RECORD
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
  SHARED __EE197380 := __E_Drivers_License_Event;
  SHARED __EE197819 := __EE197380(__NN(__EE197380.Transaction_) AND __NN(__EE197380.Licence_));
  SHARED __EE197395 := __ENH_Event_4;
  SHARED __EE197519 := __EE197395(__EE197395.Safe_Flag_ = 1);
  __JC197831(E_Drivers_License_Event.Layout __EE197819, B_Event_4.__ST61185_Layout __EE197519) := __EEQP(__EE197819.Transaction_,__EE197519.UID);
  SHARED __EE197832 := JOIN(__EE197819,__EE197519,__JC197831(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC197849(B_Drivers_License_5.__ST62037_Layout __EE197488, E_Drivers_License_Event.Layout __EE197832) := __EEQP(__EE197488.UID,__EE197832.Licence_);
  __JF197849(E_Drivers_License_Event.Layout __EE197832) := __NN(__EE197832.Licence_);
  SHARED __EE197850 := JOIN(__EE197488,__EE197832,__JC197849(LEFT,RIGHT),TRANSFORM(__ST197630_Layout,SELF:=LEFT,SELF.Drivers_License_Event_:=__JF197849(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58652_Layout := RECORD
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
  SHARED __ST58652_Layout __ND197866__Project(__ST197630_Layout __PP197851) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP197851.Drivers_License_Event_=>1,0);
    SELF := __PP197851;
  END;
  EXPORT __ENH_Drivers_License_3 := PROJECT(__EE197850,__ND197866__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Drivers_License::Annotated_3',EXPIRE(7));
END;
