//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Email,E_Person,E_Person_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Email := MODULE
  SHARED __EE489702 := E_Person_Email.__Result;
  SHARED __IDX_Person_Email_Emailof__Filtered := __EE489702(__NN(__EE489702.Emailof_));
  SHARED IDX_Person_Email_Emailof__Layout := RECORD
    E_Email.Typ Emailof_;
    __IDX_Person_Email_Emailof__Filtered._r_Customer_;
    __IDX_Person_Email_Emailof__Filtered.Subject_;
    __IDX_Person_Email_Emailof__Filtered.Date_First_Seen_;
    __IDX_Person_Email_Emailof__Filtered.Date_Last_Seen_;
    __IDX_Person_Email_Emailof__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Email_Emailof__Projected := PROJECT(__IDX_Person_Email_Emailof__Filtered,TRANSFORM(IDX_Person_Email_Emailof__Layout,SELF.Emailof_:=__T(LEFT.Emailof_),SELF:=LEFT));
  EXPORT IDX_Person_Email_Emailof_ := INDEX(IDX_Person_Email_Emailof__Projected,{Emailof_},{IDX_Person_Email_Emailof__Projected},'~key::KEL::KELOtto::Person_Email::Emailof_');
  EXPORT IDX_Person_Email_Emailof__Build := BUILD(IDX_Person_Email_Emailof_,OVERWRITE);
  EXPORT __ST489704_Layout := RECORDOF(IDX_Person_Email_Emailof_);
  EXPORT IDX_Person_Email_Emailof__Wrapped := PROJECT(IDX_Person_Email_Emailof_,TRANSFORM(E_Person_Email.Layout,SELF.Emailof_ := __CN(LEFT.Emailof_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Email_Emailof__Build);
END;
