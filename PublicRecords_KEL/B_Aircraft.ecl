//HPCC Systems KEL Compiler Version 1.2.0beta2
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Aircraft,FN_Compile FROM $;
IMPORT * FROM KEL12.Null;
EXPORT B_Aircraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Aircraft(__in,__cfg).__Result) __E_Aircraft := E_Aircraft(__in,__cfg).__Result;
  SHARED __EE1167160 := __E_Aircraft;
  EXPORT __ST60322_Layout := RECORD
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60322_Layout __ND1167264__Project(E_Aircraft(__in,__cfg).Layout __PP1167037) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('faa_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP1167037;
  END;
  EXPORT __ENH_Aircraft := PROJECT(__EE1167160,__ND1167264__Project(LEFT));
END;
