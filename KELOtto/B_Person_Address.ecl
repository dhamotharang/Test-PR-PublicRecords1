//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Address := MODULE
  SHARED __EE526184 := E_Person_Address.__Result;
  SHARED __IDX_Person_Address_Location__Filtered := __EE526184(__NN(__EE526184.Location_));
  SHARED IDX_Person_Address_Location__Layout := RECORD
    E_Address.Typ Location_;
    __IDX_Person_Address_Location__Filtered._r_Customer_;
    __IDX_Person_Address_Location__Filtered.Subject_;
    __IDX_Person_Address_Location__Filtered.Date_First_Seen_;
    __IDX_Person_Address_Location__Filtered.Date_Last_Seen_;
    __IDX_Person_Address_Location__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Address_Location__Projected := PROJECT(__IDX_Person_Address_Location__Filtered,TRANSFORM(IDX_Person_Address_Location__Layout,SELF.Location_:=__T(LEFT.Location_),SELF:=LEFT));
  EXPORT IDX_Person_Address_Location_ := INDEX(IDX_Person_Address_Location__Projected,{Location_},{IDX_Person_Address_Location__Projected},'~key::KEL::KELOtto::Person_Address::Location_');
  EXPORT IDX_Person_Address_Location__Build := BUILD(IDX_Person_Address_Location_,OVERWRITE);
  EXPORT __ST526186_Layout := RECORDOF(IDX_Person_Address_Location_);
  EXPORT IDX_Person_Address_Location__Wrapped := PROJECT(IDX_Person_Address_Location_,TRANSFORM(E_Person_Address.Layout,SELF.Location_ := __CN(LEFT.Location_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Address_Location__Build);
END;
