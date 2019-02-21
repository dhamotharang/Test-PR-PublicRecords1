//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT E_Per_Veh,E_Person,E_Vehicle FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT B_Per_Veh := MODULE
  SHARED __EE892 := E_Per_Veh.__Result;
  SHARED __IDX_Per_Veh_Per__Filtered := __EE892(__NN(__EE892.Per_));
  SHARED IDX_Per_Veh_Per__Layout := RECORD
    E_Person.Typ Per_;
    __IDX_Per_Veh_Per__Filtered.Veh_;
    __IDX_Per_Veh_Per__Filtered.Transaction_;
    __IDX_Per_Veh_Per__Filtered.__RecordCount;
  END;
  SHARED IDX_Per_Veh_Per__Projected := PROJECT(__IDX_Per_Veh_Per__Filtered,TRANSFORM(IDX_Per_Veh_Per__Layout,SELF.Per_:=__T(LEFT.Per_),SELF:=LEFT));
  EXPORT IDX_Per_Veh_Per_ := INDEX(IDX_Per_Veh_Per__Projected,{Per_},{IDX_Per_Veh_Per__Projected},'~key::KEL::KEL_Small::Per_Veh::Per_');
  EXPORT IDX_Per_Veh_Per__Build := BUILD(IDX_Per_Veh_Per_,OVERWRITE);
  EXPORT __ST894_Layout := RECORDOF(IDX_Per_Veh_Per_);
  EXPORT IDX_Per_Veh_Per__Wrapped := PROJECT(IDX_Per_Veh_Per_,TRANSFORM(E_Per_Veh.Layout,SELF.Per_ := __CN(LEFT.Per_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Per_Veh_Per__Build);
END;
