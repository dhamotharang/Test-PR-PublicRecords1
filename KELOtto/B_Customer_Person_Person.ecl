//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Customer,E_Customer_Person_Person,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_Person_Person := MODULE
  SHARED __EE627475 := E_Customer_Person_Person.__Result;
  SHARED __IDX_Customer_Person_Person_From_Person__Filtered := __EE627475(__NN(__EE627475.From_Person_));
  SHARED IDX_Customer_Person_Person_From_Person__Layout := RECORD
    E_Person.Typ From_Person_;
    __IDX_Customer_Person_Person_From_Person__Filtered.Source_Customer_;
    __IDX_Customer_Person_Person_From_Person__Filtered.To_Person_;
    __IDX_Customer_Person_Person_From_Person__Filtered.Date_First_Seen_;
    __IDX_Customer_Person_Person_From_Person__Filtered.Date_Last_Seen_;
    __IDX_Customer_Person_Person_From_Person__Filtered.__RecordCount;
  END;
  SHARED IDX_Customer_Person_Person_From_Person__Projected := PROJECT(__IDX_Customer_Person_Person_From_Person__Filtered,TRANSFORM(IDX_Customer_Person_Person_From_Person__Layout,SELF.From_Person_:=__T(LEFT.From_Person_),SELF:=LEFT));
  EXPORT IDX_Customer_Person_Person_From_Person_ := INDEX(IDX_Customer_Person_Person_From_Person__Projected,{From_Person_},{IDX_Customer_Person_Person_From_Person__Projected},'~key::KEL::KELOtto::Customer_Person_Person::From_Person_');
  EXPORT IDX_Customer_Person_Person_From_Person__Build := BUILD(IDX_Customer_Person_Person_From_Person_,OVERWRITE);
  EXPORT __ST627477_Layout := RECORDOF(IDX_Customer_Person_Person_From_Person_);
  EXPORT IDX_Customer_Person_Person_From_Person__Wrapped := PROJECT(IDX_Customer_Person_Person_From_Person_,TRANSFORM(E_Customer_Person_Person.Layout,SELF.From_Person_ := __CN(LEFT.From_Person_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_Person_Person_From_Person__Build);
END;
