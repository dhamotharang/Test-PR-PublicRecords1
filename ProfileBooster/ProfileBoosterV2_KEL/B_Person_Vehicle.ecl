//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED __EE467867 := E_Person_Vehicle(__cfg).PreEntityInternal(true);
  SHARED __IDX_Person_Vehicle_Subject__Filtered := __EE467867(__NN(__EE467867.Subject_));
  SHARED IDX_Person_Vehicle_Subject__Layout := RECORD
    E_Person().Typ Subject_;
    __IDX_Person_Vehicle_Subject__Filtered.Automobile_;
    TYPEOF(__IDX_Person_Vehicle_Subject__Filtered.__Payload) __Payload{BLOB} := __IDX_Person_Vehicle_Subject__Filtered.__Payload;
  END;
  EXPORT IDX_Person_Vehicle_Subject__BaseFile := PROJECT(__IDX_Person_Vehicle_Subject__Filtered,TRANSFORM(IDX_Person_Vehicle_Subject__Layout,SELF.Subject_:=__T(LEFT.Subject_),SELF:=LEFT));
  EXPORT IDX_Person_Vehicle_Subject__SuperName := '~key::kel::publicrecords_kel::' + IF(__cfg.SuperFileFragment = '','',__cfg.SuperFileFragment + '::') + 'Person_Vehicle::Subject_';
  EXPORT IDX_Person_Vehicle_Subject__From(TYPEOF(IDX_Person_Vehicle_Subject__BaseFile) source) := INDEX(source,{Subject_},{source},IDX_Person_Vehicle_Subject__SuperName,SORTED);
  EXPORT IDX_Person_Vehicle_Subject_ := IDX_Person_Vehicle_Subject__From(IDX_Person_Vehicle_Subject__BaseFile);
  EXPORT IDX_Person_Vehicle_Subject__LogicalName := '~key::kel::publicrecords_kel::' + IF(__cfg.LogicalFileFragment = '','',__cfg.LogicalFileFragment + '::') + 'Person_Vehicle::Subject_';
  EXPORT IDX_Person_Vehicle_Subject__Build_From(TYPEOF(IDX_Person_Vehicle_Subject__BaseFile) source) := BUILD(source,{Subject_},{source},IDX_Person_Vehicle_Subject__LogicalName,SORTED,OVERWRITE);
  EXPORT IDX_Person_Vehicle_Subject__Build := IDX_Person_Vehicle_Subject__Build_From(IDX_Person_Vehicle_Subject__BaseFile);
  EXPORT __ST469118_Layout := RECORDOF(IDX_Person_Vehicle_Subject_);
  EXPORT IDX_Person_Vehicle_Subject__Wrapped := PROJECT(IDX_Person_Vehicle_Subject_,TRANSFORM(E_Person_Vehicle(__cfg).PreEntityLayout,SELF.Subject_ := __CN(LEFT.Subject_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Vehicle_Subject__Build);
END;
