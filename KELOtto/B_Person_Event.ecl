//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Event := MODULE
  SHARED __EE342743 := E_Person_Event.__Result;
  SHARED __IDX_Person_Event_Emailof__Filtered := __EE342743(__NN(__EE342743.Emailof_));
  SHARED IDX_Person_Event_Emailof__Layout := RECORD
    E_Email.Typ Emailof_;
    __IDX_Person_Event_Emailof__Filtered._r_Customer_;
    __IDX_Person_Event_Emailof__Filtered.Subject_;
    __IDX_Person_Event_Emailof__Filtered.Social_;
    __IDX_Person_Event_Emailof__Filtered.Phone_Number_;
    __IDX_Person_Event_Emailof__Filtered.Location_;
    __IDX_Person_Event_Emailof__Filtered.Ip_;
    __IDX_Person_Event_Emailof__Filtered.Event_Date_;
    __IDX_Person_Event_Emailof__Filtered.Transaction_;
    __IDX_Person_Event_Emailof__Filtered.Date_First_Seen_;
    __IDX_Person_Event_Emailof__Filtered.Date_Last_Seen_;
    __IDX_Person_Event_Emailof__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Event_Emailof__Projected := PROJECT(__IDX_Person_Event_Emailof__Filtered,TRANSFORM(IDX_Person_Event_Emailof__Layout,SELF.Emailof_:=__T(LEFT.Emailof_),SELF:=LEFT));
  EXPORT IDX_Person_Event_Emailof_ := INDEX(IDX_Person_Event_Emailof__Projected,{Emailof_},{IDX_Person_Event_Emailof__Projected},'~key::KEL::KELOtto::Person_Event::Emailof_');
  EXPORT IDX_Person_Event_Emailof__Build := BUILD(IDX_Person_Event_Emailof_,OVERWRITE);
  EXPORT __ST342745_Layout := RECORDOF(IDX_Person_Event_Emailof_);
  EXPORT IDX_Person_Event_Emailof__Wrapped := PROJECT(IDX_Person_Event_Emailof_,TRANSFORM(E_Person_Event.Layout,SELF.Emailof_ := __CN(LEFT.Emailof_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Event_Emailof__Build);
END;
