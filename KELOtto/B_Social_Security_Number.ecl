//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Social_Security_Number := MODULE
  SHARED __EE627568 := E_Social_Security_Number.__Result;
  SHARED IDX_Social_Security_Number_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE627568.Date_First_Seen_;
    __EE627568.Date_Last_Seen_;
    __EE627568.__RecordCount;
  END;
  SHARED IDX_Social_Security_Number_UID_Projected := PROJECT(__EE627568,TRANSFORM(IDX_Social_Security_Number_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Social_Security_Number_UID := INDEX(IDX_Social_Security_Number_UID_Projected,{UID},{IDX_Social_Security_Number_UID_Projected},'~key::KEL::KELOtto::Social_Security_Number::UID');
  EXPORT IDX_Social_Security_Number_UID_Build := BUILD(IDX_Social_Security_Number_UID,OVERWRITE);
  EXPORT __ST627570_Layout := RECORDOF(IDX_Social_Security_Number_UID);
  EXPORT IDX_Social_Security_Number_UID_Wrapped := PROJECT(IDX_Social_Security_Number_UID,TRANSFORM(E_Social_Security_Number.Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Social_Security_Number_UID_Build);
END;
