//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Person,E_Person_Phone,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Phone := MODULE
  SHARED __EE627574 := E_Person_Phone.__Result;
  SHARED __IDX_Person_Phone_Location__Filtered := __EE627574(__NN(__EE627574.Location_));
  SHARED IDX_Person_Phone_Location__Layout := RECORD
    E_Address.Typ Location_;
    __IDX_Person_Phone_Location__Filtered.Subject_;
    __IDX_Person_Phone_Location__Filtered.Phone_Number_;
    __IDX_Person_Phone_Location__Filtered.Date_First_Seen_;
    __IDX_Person_Phone_Location__Filtered.Date_Last_Seen_;
    __IDX_Person_Phone_Location__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Phone_Location__Projected := PROJECT(__IDX_Person_Phone_Location__Filtered,TRANSFORM(IDX_Person_Phone_Location__Layout,SELF.Location_:=__T(LEFT.Location_),SELF:=LEFT));
  EXPORT IDX_Person_Phone_Location_ := INDEX(IDX_Person_Phone_Location__Projected,{Location_},{IDX_Person_Phone_Location__Projected},'~key::KEL::KELOtto::Person_Phone::Location_');
  EXPORT IDX_Person_Phone_Location__Build := BUILD(IDX_Person_Phone_Location_,OVERWRITE);
  EXPORT __ST627576_Layout := RECORDOF(IDX_Person_Phone_Location_);
  EXPORT IDX_Person_Phone_Location__Wrapped := PROJECT(IDX_Person_Phone_Location_,TRANSFORM(E_Person_Phone.Layout,SELF.Location_ := __CN(LEFT.Location_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Phone_Location__Build);
END;
