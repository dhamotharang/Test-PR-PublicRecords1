//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,B_Phone_4,B_Phone_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(B_Phone_4.__ENH_Phone_4) __ENH_Phone_4 := B_Phone_4.__ENH_Phone_4;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE233930 := __ENH_Phone_4;
  SHARED __ST234072_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.bool Phone_Event_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE233822 := __E_Phone_Event;
  SHARED __EE234261 := __EE233822(__NN(__EE233822.Transaction_) AND __NN(__EE233822.Phone_Number_));
  SHARED __EE233837 := __ENH_Event_4;
  SHARED __EE233961 := __EE233837(__EE233837.Safe_Flag_ = 1);
  __JC234273(E_Phone_Event.Layout __EE234261, B_Event_4.__ST61185_Layout __EE233961) := __EEQP(__EE234261.Transaction_,__EE233961.UID);
  SHARED __EE234274 := JOIN(__EE234261,__EE233961,__JC234273(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC234291(B_Phone_5.__ST63195_Layout __EE233930, E_Phone_Event.Layout __EE234274) := __EEQP(__EE233930.UID,__EE234274.Phone_Number_);
  __JF234291(E_Phone_Event.Layout __EE234274) := __NN(__EE234274.Phone_Number_);
  SHARED __EE234292 := JOIN(__EE233930,__EE234274,__JC234291(LEFT,RIGHT),TRANSFORM(__ST234072_Layout,SELF:=LEFT,SELF.Phone_Event_:=__JF234291(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST60263_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60263_Layout __ND234308__Project(__ST234072_Layout __PP234293) := TRANSFORM
    SELF.Safe_Flag_ := MAP(__PP234293.Phone_Event_=>1,0);
    SELF := __PP234293;
  END;
  EXPORT __ENH_Phone_3 := PROJECT(__EE234292,__ND234308__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Phone::Annotated_3',EXPIRE(7));
END;
