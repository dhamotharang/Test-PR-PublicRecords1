//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Business,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Business(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED __EE222071 := __E_Business;
  EXPORT __ST20884_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20884_Layout __ND222135__Project(E_Business(__in,__cfg).Layout __PP221996) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bheader_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP221996;
  END;
  EXPORT __ENH_Business := PROJECT(__EE222071,__ND222135__Project(LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Business::Annotated' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
END;
