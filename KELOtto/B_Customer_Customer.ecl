//HPCC Systems KEL Compiler Version 0.10.0
IMPORT KEL010 AS KEL;
IMPORT E_Customer,E_Customer_Customer FROM KELOtto;
IMPORT * FROM KEL010.Null;
EXPORT B_Customer_Customer := MODULE
  SHARED __EE675 := E_Customer_Customer.__Result;
  SHARED __IDX_Customer_Customer_Associated_Customer__Filtered := __EE675(__NN(__EE675.Associated_Customer_));
  SHARED IDX_Customer_Customer_Associated_Customer__Layout := RECORD
    E_Customer.Typ Associated_Customer_;
    __IDX_Customer_Customer_Associated_Customer__Filtered.Source_Customer_;
    __IDX_Customer_Customer_Associated_Customer__Filtered.Date_First_Seen_;
    __IDX_Customer_Customer_Associated_Customer__Filtered.Date_Last_Seen_;
    __IDX_Customer_Customer_Associated_Customer__Filtered.__RecordCount;
  END;
  SHARED IDX_Customer_Customer_Associated_Customer__Projected := PROJECT(__IDX_Customer_Customer_Associated_Customer__Filtered,TRANSFORM(IDX_Customer_Customer_Associated_Customer__Layout,SELF.Associated_Customer_:=__T(LEFT.Associated_Customer_),SELF:=LEFT));
  EXPORT IDX_Customer_Customer_Associated_Customer_ := INDEX(IDX_Customer_Customer_Associated_Customer__Projected,{Associated_Customer_},{IDX_Customer_Customer_Associated_Customer__Projected},'~key::KEL::KELOtto::Customer_Customer::Associated_Customer_');
  EXPORT IDX_Customer_Customer_Associated_Customer__Build := BUILD(IDX_Customer_Customer_Associated_Customer_,OVERWRITE);
  EXPORT __ST677_Layout := RECORDOF(IDX_Customer_Customer_Associated_Customer_);
  EXPORT IDX_Customer_Customer_Associated_Customer__Wrapped := PROJECT(IDX_Customer_Customer_Associated_Customer_,TRANSFORM(E_Customer_Customer.Layout,SELF.Associated_Customer_ := __CN(LEFT.Associated_Customer_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_Customer_Associated_Customer__Build);
END;
