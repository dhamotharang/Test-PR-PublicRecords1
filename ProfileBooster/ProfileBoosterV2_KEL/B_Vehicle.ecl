//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Vehicle(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED __EE467826 := E_Vehicle(__cfg).PreEntityInternal(true);
  SHARED IDX_Vehicle_UID_Layout := RECORD
    KEL.typ.uid UID;
    TYPEOF(__EE467826.__Payload) __Payload{BLOB} := __EE467826.__Payload;
  END;
  EXPORT IDX_Vehicle_UID_BaseFile := PROJECT(__EE467826,TRANSFORM(IDX_Vehicle_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Vehicle_UID_SuperName := '~key::kel::publicrecords_kel::' + IF(__cfg.SuperFileFragment = '','',__cfg.SuperFileFragment + '::') + 'Vehicle::UID';
  EXPORT IDX_Vehicle_UID_From(TYPEOF(IDX_Vehicle_UID_BaseFile) source) := INDEX(source,{UID},{source},IDX_Vehicle_UID_SuperName,SORTED);
  EXPORT IDX_Vehicle_UID := IDX_Vehicle_UID_From(IDX_Vehicle_UID_BaseFile);
  EXPORT IDX_Vehicle_UID_LogicalName := '~key::kel::publicrecords_kel::' + IF(__cfg.LogicalFileFragment = '','',__cfg.LogicalFileFragment + '::') + 'Vehicle::UID';
  EXPORT IDX_Vehicle_UID_Build_From(TYPEOF(IDX_Vehicle_UID_BaseFile) source) := BUILD(source,{UID},{source},IDX_Vehicle_UID_LogicalName,SORTED,OVERWRITE);
  EXPORT IDX_Vehicle_UID_Build := IDX_Vehicle_UID_Build_From(IDX_Vehicle_UID_BaseFile);
  EXPORT __ST469004_Layout := RECORDOF(IDX_Vehicle_UID);
  EXPORT IDX_Vehicle_UID_Wrapped := PROJECT(IDX_Vehicle_UID,TRANSFORM(E_Vehicle(__cfg).PreEntityLayout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Vehicle_UID_Build);
END;
