//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT E_Person FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT B_Person := MODULE
  SHARED __EE915 := E_Person.__Result;
  SHARED IDX_Person_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE915.Name_;
    __EE915.Age_;
    __EE915.__RecordCount;
  END;
  SHARED IDX_Person_UID_Projected := PROJECT(__EE915,TRANSFORM(IDX_Person_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Person_UID := INDEX(IDX_Person_UID_Projected,{UID},{IDX_Person_UID_Projected},'~key::KEL::KEL_Small::Person::UID');
  EXPORT IDX_Person_UID_Build := BUILD(IDX_Person_UID,OVERWRITE);
  EXPORT __ST917_Layout := RECORDOF(IDX_Person_UID);
  EXPORT IDX_Person_UID_Wrapped := PROJECT(IDX_Person_UID,TRANSFORM(E_Person.Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_UID_Build);
END;
