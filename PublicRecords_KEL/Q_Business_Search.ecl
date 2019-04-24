//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Business,CFG_Compile,E_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Business_Search(KEL.typ.int __PsearchforUltid, KEL.typ.int __PsearchforOrgID, KEL.typ.int __PsearchforSeleID, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED TYPEOF(B_Business(__in).__ENH_Business) __ENH_Business := B_Business(__in).__ENH_Business;
  SHARED __EE458398 := __ENH_Business;
  SHARED __EE458419 := __EE458398(__T(__AND(__OP2(__CN(__PsearchforUltid),=,__EE458398.Ult_I_D_),__AND(__OP2(__CN(__PsearchforOrgID),=,__EE458398.Org_I_D_),__OP2(__CN(__PsearchforSeleID),=,__EE458398.Sele_I_D_)))));
  EXPORT Res0 := __UNWRAP(__EE458419);
END;
