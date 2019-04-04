//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_S_S_N := MODULE
  SHARED __EE826900 := E_Person_S_S_N.__Result;
  SHARED __IDX_Person_S_S_N_Social__Filtered := __EE826900(__NN(__EE826900.Social_));
  SHARED IDX_Person_S_S_N_Social__Layout := RECORD
    E_Social_Security_Number.Typ Social_;
    __IDX_Person_S_S_N_Social__Filtered._r_Customer_;
    __IDX_Person_S_S_N_Social__Filtered.Subject_;
    __IDX_Person_S_S_N_Social__Filtered.Date_First_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.Date_Last_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_S_S_N_Social__Projected := PROJECT(__IDX_Person_S_S_N_Social__Filtered,TRANSFORM(IDX_Person_S_S_N_Social__Layout,SELF.Social_:=__T(LEFT.Social_),SELF:=LEFT));
  EXPORT IDX_Person_S_S_N_Social_ := INDEX(IDX_Person_S_S_N_Social__Projected,{Social_},{IDX_Person_S_S_N_Social__Projected},'~key::KEL::KELOtto::Person_S_S_N::Social_');
  EXPORT IDX_Person_S_S_N_Social__Build := BUILD(IDX_Person_S_S_N_Social_,OVERWRITE);
  EXPORT __ST826902_Layout := RECORDOF(IDX_Person_S_S_N_Social_);
  EXPORT IDX_Person_S_S_N_Social__Wrapped := PROJECT(IDX_Person_S_S_N_Social_,TRANSFORM(E_Person_S_S_N.Layout,SELF.Social_ := __CN(LEFT.Social_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_S_S_N_Social__Build);
END;
