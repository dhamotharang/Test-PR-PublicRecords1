﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Tradeline_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline(__in,__cfg).__Result;
  SHARED __EE136247 := __E_Tradeline;
  EXPORT __ST135652_Layout := RECORD
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST135645_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST135652_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST135645_Layout __ND136465__Project(E_Tradeline(__in,__cfg).Layout __PP136076) := TRANSFORM
    __EE136123 := __PP136076.Records_;
    __ST135652_Layout __ND136371__Project(E_Tradeline(__in,__cfg).Records_Layout __PP136367) := TRANSFORM
      SELF.Record_Date_ := KEL.era.ToDate(__PP136367.Date_First_Seen_);
      SELF := __PP136367;
    END;
    SELF.Records_ := __PROJECT(__EE136123,__ND136371__Project(LEFT));
    __CC13054 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('cortera_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Current_Month_ := __FN1(KEL.Routines.Month,__CC13054);
    SELF.Current_Year_ := __FN1(KEL.Routines.Year,__CC13054);
    SELF := __PP136076;
  END;
  EXPORT __ENH_Tradeline_10 := PROJECT(__EE136247,__ND136465__Project(LEFT));
END;
