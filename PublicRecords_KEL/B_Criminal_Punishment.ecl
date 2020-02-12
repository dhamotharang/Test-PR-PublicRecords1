﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Criminal_Punishment,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Criminal_Punishment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Criminal_Punishment(__in,__cfg).__Result) __E_Criminal_Punishment := E_Criminal_Punishment(__in,__cfg).__Result;
  SHARED __EE1388448 := __E_Criminal_Punishment;
  EXPORT __ST66520_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(E_Criminal_Punishment(__in,__cfg).Sources_Layout) Sources_;
    KEL.typ.ndataset(E_Criminal_Punishment(__in,__cfg).Reported_Punishment_Persistent_I_Ds_Layout) Reported_Punishment_Persistent_I_Ds_;
    KEL.typ.ndataset(E_Criminal_Punishment(__in,__cfg).Reported_Punishment_Layout) Reported_Punishment_;
    KEL.typ.nstr Punishment_Type_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nstr Current_Known_Inmate_Status_;
    KEL.typ.nstr Sentence_County_;
    KEL.typ.nstr Current_Location_Of_Inmate_;
    KEL.typ.nstr Current_Location_Security_;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Current_Status_;
    KEL.typ.nstr Probation_Time_Period_;
    KEL.typ.nstr Consecutive_And_Concurrent_Information_;
    KEL.typ.nstr Instituiton_Name_;
    KEL.typ.nfloat Restitution_;
    KEL.typ.nstr Community_Service_;
    KEL.typ.ndataset(E_Criminal_Punishment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST66520_Layout __ND1388732__Project(E_Criminal_Punishment(__in,__cfg).Layout __PP1388217) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('doc_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP1388217;
  END;
  EXPORT __ENH_Criminal_Punishment := PROJECT(__EE1388448,__ND1388732__Project(LEFT));
END;
