//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Internet_Protocol,E_Person,E_Person_Ip_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Ip_Address := MODULE
  SHARED __EE721140 := E_Person_Ip_Address.__Result;
  SHARED __IDX_Person_Ip_Address_Ip__Filtered := __EE721140(__NN(__EE721140.Ip_));
  SHARED IDX_Person_Ip_Address_Ip__Layout := RECORD
    E_Internet_Protocol.Typ Ip_;
    __IDX_Person_Ip_Address_Ip__Filtered._r_Customer_;
    __IDX_Person_Ip_Address_Ip__Filtered.Subject_;
    __IDX_Person_Ip_Address_Ip__Filtered.Date_First_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.Date_Last_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Ip_Address_Ip__Projected := PROJECT(__IDX_Person_Ip_Address_Ip__Filtered,TRANSFORM(IDX_Person_Ip_Address_Ip__Layout,SELF.Ip_:=__T(LEFT.Ip_),SELF:=LEFT));
  EXPORT IDX_Person_Ip_Address_Ip_ := INDEX(IDX_Person_Ip_Address_Ip__Projected,{Ip_},{IDX_Person_Ip_Address_Ip__Projected},'~key::KEL::KELOtto::Person_Ip_Address::Ip_');
  EXPORT IDX_Person_Ip_Address_Ip__Build := BUILD(IDX_Person_Ip_Address_Ip_,OVERWRITE);
  EXPORT __ST721142_Layout := RECORDOF(IDX_Person_Ip_Address_Ip_);
  EXPORT IDX_Person_Ip_Address_Ip__Wrapped := PROJECT(IDX_Person_Ip_Address_Ip_,TRANSFORM(E_Person_Ip_Address.Layout,SELF.Ip_ := __CN(LEFT.Ip_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Ip_Address_Ip__Build);
END;
