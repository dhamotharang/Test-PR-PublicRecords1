//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Address_S_S_N,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Address_S_S_N := MODULE
  SHARED __EE627561 := E_Address_S_S_N.__Result;
  SHARED __IDX_Address_S_S_N_Location__Filtered := __EE627561(__NN(__EE627561.Location_));
  SHARED IDX_Address_S_S_N_Location__Layout := RECORD
    E_Address.Typ Location_;
    __IDX_Address_S_S_N_Location__Filtered.Social_;
    __IDX_Address_S_S_N_Location__Filtered.Date_First_Seen_;
    __IDX_Address_S_S_N_Location__Filtered.Date_Last_Seen_;
    __IDX_Address_S_S_N_Location__Filtered.__RecordCount;
  END;
  SHARED IDX_Address_S_S_N_Location__Projected := PROJECT(__IDX_Address_S_S_N_Location__Filtered,TRANSFORM(IDX_Address_S_S_N_Location__Layout,SELF.Location_:=__T(LEFT.Location_),SELF:=LEFT));
  EXPORT IDX_Address_S_S_N_Location_ := INDEX(IDX_Address_S_S_N_Location__Projected,{Location_},{IDX_Address_S_S_N_Location__Projected},'~key::KEL::KELOtto::Address_S_S_N::Location_');
  EXPORT IDX_Address_S_S_N_Location__Build := BUILD(IDX_Address_S_S_N_Location_,OVERWRITE);
  EXPORT __ST627563_Layout := RECORDOF(IDX_Address_S_S_N_Location_);
  EXPORT IDX_Address_S_S_N_Location__Wrapped := PROJECT(IDX_Address_S_S_N_Location_,TRANSFORM(E_Address_S_S_N.Layout,SELF.Location_ := __CN(LEFT.Location_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Address_S_S_N_Location__Build);
END;
