//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email := MODULE
  SHARED __EE627733 := E_Email.__Result;
  SHARED IDX_Email_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE627733.Email_Address_;
    __EE627733.Details_;
    __EE627733.Date_First_Seen_;
    __EE627733.Date_Last_Seen_;
    __EE627733.__RecordCount;
  END;
  SHARED IDX_Email_UID_Projected := PROJECT(__EE627733,TRANSFORM(IDX_Email_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Email_UID := INDEX(IDX_Email_UID_Projected,{UID},{IDX_Email_UID_Projected},'~key::KEL::KELOtto::Email::UID');
  EXPORT IDX_Email_UID_Build := BUILD(IDX_Email_UID,OVERWRITE);
  EXPORT __ST627735_Layout := RECORDOF(IDX_Email_UID);
  EXPORT IDX_Email_UID_Wrapped := PROJECT(IDX_Email_UID,TRANSFORM(E_Email.Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Email_UID_Build);
END;
