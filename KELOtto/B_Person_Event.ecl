//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Event := MODULE
  SHARED __EE720670 := E_Person_Event.__Result;
  SHARED __IDX_Person_Event_Account__Filtered := __EE720670(__NN(__EE720670.Account_));
  SHARED IDX_Person_Event_Account__Layout := RECORD
    E_Bank_Account.Typ Account_;
    __IDX_Person_Event_Account__Filtered._r_Customer_;
    __IDX_Person_Event_Account__Filtered.Subject_;
    __IDX_Person_Event_Account__Filtered.Social_;
    __IDX_Person_Event_Account__Filtered.Phone_Number_;
    __IDX_Person_Event_Account__Filtered.Emailof_;
    __IDX_Person_Event_Account__Filtered.Location_;
    __IDX_Person_Event_Account__Filtered.Ip_;
    __IDX_Person_Event_Account__Filtered.Routing_Bank_;
    __IDX_Person_Event_Account__Filtered.Licence_;
    __IDX_Person_Event_Account__Filtered.Event_Date_;
    __IDX_Person_Event_Account__Filtered.Transaction_;
    __IDX_Person_Event_Account__Filtered.Date_First_Seen_;
    __IDX_Person_Event_Account__Filtered.Date_Last_Seen_;
    __IDX_Person_Event_Account__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Event_Account__Projected := PROJECT(__IDX_Person_Event_Account__Filtered,TRANSFORM(IDX_Person_Event_Account__Layout,SELF.Account_:=__T(LEFT.Account_),SELF:=LEFT));
  EXPORT IDX_Person_Event_Account_ := INDEX(IDX_Person_Event_Account__Projected,{Account_},{IDX_Person_Event_Account__Projected},'~key::KEL::KELOtto::Person_Event::Account_');
  EXPORT IDX_Person_Event_Account__Build := BUILD(IDX_Person_Event_Account_,OVERWRITE);
  EXPORT __ST720672_Layout := RECORDOF(IDX_Person_Event_Account_);
  EXPORT IDX_Person_Event_Account__Wrapped := PROJECT(IDX_Person_Event_Account_,TRANSFORM(E_Person_Event.Layout,SELF.Account_ := __CN(LEFT.Account_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Event_Account__Build);
END;
