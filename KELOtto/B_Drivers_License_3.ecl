//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_4,B_Drivers_License_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_4.__ENH_Drivers_License_4) __ENH_Drivers_License_4 := B_Drivers_License_4.__ENH_Drivers_License_4;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED __EE187323 := __ENH_Drivers_License_4;
  SHARED __ST187465_Layout := RECORD
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
  SHARED __EE187215 := __E_Drivers_License_Event;
  SHARED __EE187654 := __EE187215(__NN(__EE187215.Transaction_) AND __NN(__EE187215.Licence_));
  SHARED __EE187230 := __ENH_Event_4;
  SHARED __EE187354 := __EE187230(__EE187230.Safe_Flag_ = 1);
  __JC187666(E_Drivers_License_Event.Layout __EE187654, B_Event_4.__ST57011_Layout __EE187354) := __EEQP(__EE187654.Transaction_,__EE187354.UID);
  SHARED __EE187667 := JOIN(__EE187654,__EE187354,__JC187666(LEFT,RIGHT),TRANSFORM(E_Drivers_License_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC187684(B_Drivers_License_5.__ST57830_Layout __EE187323, E_Drivers_License_Event.Layout __EE187667) := __EEQP(__EE187323.UID,__EE187667.Licence_);
  __JF187684(E_Drivers_License_Event.Layout __EE187667) := __NN(__EE187667.Licence_);
  SHARED __EE187685 := JOIN(__EE187323,__EE187667,__JC187684(LEFT,RIGHT),TRANSFORM(__ST187465_Layout,SELF:=LEFT,SELF.Drivers_License_Event_:=__JF187684(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST54783_Layout := RECORD
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
  SHARED __ST54783_Layout __ND187701__Project(__ST187465_Layout __PP187686) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP187686.Drivers_License_Event_=>1,0);
    SELF := __PP187686;
  END;
  EXPORT __ENH_Drivers_License_3 := PROJECT(__EE187685,__ND187701__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Drivers_License::Annotated_3',EXPIRE(7));
END;
