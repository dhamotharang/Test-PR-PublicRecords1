﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Aircraft,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Aircraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Aircraft(__in,__cfg).__Result) __E_Aircraft := E_Aircraft(__in,__cfg).__Result;
  SHARED __EE940752 := __E_Aircraft;
  EXPORT __ST48703_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg).Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg).Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(E_Aircraft(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST48703_Layout __ND940856__Project(E_Aircraft(__in,__cfg).Layout __PP940629) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('faa_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP940629;
  END;
  EXPORT __ENH_Aircraft := PROJECT(__EE940752,__ND940856__Project(LEFT));
END;
