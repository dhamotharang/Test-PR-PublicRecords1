﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Inquiry,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Inquiry(__in,__cfg).__Result) __E_Inquiry := E_Inquiry(__in,__cfg).__Result;
  SHARED __EE960466 := __E_Inquiry;
  EXPORT __ST55561_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.nkdate Date_Of_Inquiry_;
    KEL.typ.nstr Time_Of_Inquiry_;
    KEL.typ.nstr Inquiry_Source_;
    KEL.typ.nstr Method_;
    KEL.typ.nint Product_Code_;
    KEL.typ.nstr Function_Description_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint F_C_R_A_Purpose_;
    KEL.typ.nstr Sub_Market_;
    KEL.typ.nstr Vertical_;
    KEL.typ.nstr Use_;
    KEL.typ.nstr Industry_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST55561_Layout __ND960516__Project(E_Inquiry(__in,__cfg).Layout __PP960357) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('inquiry_update_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP960357;
  END;
  EXPORT __ENH_Inquiry := PROJECT(__EE960466,__ND960516__Project(LEFT));
END;
