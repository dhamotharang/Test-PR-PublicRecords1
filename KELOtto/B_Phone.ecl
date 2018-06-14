//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone := MODULE
  SHARED __EE627778 := E_Phone.__Result;
  SHARED IDX_Phone_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE627778._is_Cell_Phone_;
    __EE627778.Date_First_Seen_;
    __EE627778.Date_Last_Seen_;
    __EE627778.__RecordCount;
  END;
  SHARED IDX_Phone_UID_Projected := PROJECT(__EE627778,TRANSFORM(IDX_Phone_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Phone_UID := INDEX(IDX_Phone_UID_Projected,{UID},{IDX_Phone_UID_Projected},'~key::KEL::KELOtto::Phone::UID');
  EXPORT IDX_Phone_UID_Build := BUILD(IDX_Phone_UID,OVERWRITE);
  EXPORT __ST627780_Layout := RECORDOF(IDX_Phone_UID);
  EXPORT IDX_Phone_UID_Wrapped := PROJECT(IDX_Phone_UID,TRANSFORM(E_Phone.Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Phone_UID_Build);
END;
