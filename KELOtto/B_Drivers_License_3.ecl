//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_4,B_Drivers_License_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_4.__ENH_Drivers_License_4) __ENH_Drivers_License_4 := B_Drivers_License_4.__ENH_Drivers_License_4;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE179120 := __ENH_Drivers_License_4;
  SHARED __ST179262_Layout := RECORD
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
  SHARED __EE179012 := __E_Drivers_License_Event;
  SHARED __EE179451 := __EE179012(__NN(__EE179012.Transaction_) AND __NN(__EE179012.Licence_));
  SHARED __EE179027 := __ENH_Event_4;
  SHARED __EE179151 := __EE179027(__EE179027.Safe_Flag_ = 1);
  __JC179463(E_Drivers_License_Event.Layout __EE179451, B_Event_4.__ST53186_Layout __EE179151) := __EEQP(__EE179451.Transaction_,__EE179151.UID);
  SHARED __EE179464 := JOIN(__EE179451,__EE179151,__JC179463(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC179481(B_Drivers_License_5.__ST53975_Layout __EE179120, E_Drivers_License_Event.Layout __EE179464) := __EEQP(__EE179120.UID,__EE179464.Licence_);
  __JF179481(E_Drivers_License_Event.Layout __EE179464) := __NN(__EE179464.Licence_);
  SHARED __EE179482 := JOIN(__EE179120,__EE179464,__JC179481(LEFT,RIGHT),TRANSFORM(__ST179262_Layout,SELF:=LEFT,SELF.Drivers_License_Event_:=__JF179481(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST51021_Layout := RECORD
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
  SHARED __ST51021_Layout __ND179498__Project(__ST179262_Layout __PP179483) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP179483.Drivers_License_Event_=>1,0);
    SELF := __PP179483;
  END;
  EXPORT __ENH_Drivers_License_3 := PROJECT(__EE179482,__ND179498__Project(LEFT));
END;
