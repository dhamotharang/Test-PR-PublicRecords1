//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Person,E_Person_Phone,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Phone := MODULE
  SHARED __EE823978 := E_Person_Phone.__Result;
  SHARED __IDX_Person_Phone_Phone_Number__Filtered := __EE823978(__NN(__EE823978.Phone_Number_));
  SHARED IDX_Person_Phone_Phone_Number__Layout := RECORD
    E_Phone.Typ Phone_Number_;
    __IDX_Person_Phone_Phone_Number__Filtered._r_Customer_;
    __IDX_Person_Phone_Phone_Number__Filtered.Subject_;
    __IDX_Person_Phone_Phone_Number__Filtered.Date_First_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.Date_Last_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Phone_Phone_Number__Projected := PROJECT(__IDX_Person_Phone_Phone_Number__Filtered,TRANSFORM(IDX_Person_Phone_Phone_Number__Layout,SELF.Phone_Number_:=__T(LEFT.Phone_Number_),SELF:=LEFT));
  EXPORT IDX_Person_Phone_Phone_Number_ := INDEX(IDX_Person_Phone_Phone_Number__Projected,{Phone_Number_},{IDX_Person_Phone_Phone_Number__Projected},'~key::KEL::KELOtto::Person_Phone::Phone_Number_');
  EXPORT IDX_Person_Phone_Phone_Number__Build := BUILD(IDX_Person_Phone_Phone_Number_,OVERWRITE);
  EXPORT __ST823980_Layout := RECORDOF(IDX_Person_Phone_Phone_Number_);
  EXPORT IDX_Person_Phone_Phone_Number__Wrapped := PROJECT(IDX_Person_Phone_Phone_Number_,TRANSFORM(E_Person_Phone.Layout,SELF.Phone_Number_ := __CN(LEFT.Phone_Number_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Phone_Phone_Number__Build);
END;
