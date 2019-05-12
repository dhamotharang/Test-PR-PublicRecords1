﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_11,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_11(__in,__cfg).__ENH_Tradeline_11) __ENH_Tradeline_11 := B_Tradeline_11(__in,__cfg).__ENH_Tradeline_11;
  SHARED __EE73025 := __ENH_Tradeline_11;
  EXPORT __ST71745_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST71738_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST71745_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST71738_Layout __ND73183__Project(B_Tradeline_11(__in,__cfg).__ST71788_Layout __PP72843) := TRANSFORM
    __EE72892 := __PP72843.Records_;
    __ST71745_Layout __ND73129__Project(E_Tradeline(__in,__cfg).Records_Layout __PP73128) := TRANSFORM
      SELF.Record_Date_ := KEL.era.ToDate(__PP73128.Date_First_Seen_);
      SELF := __PP73128;
    END;
    SELF.Records_ := __PROJECT(__EE72892,__ND73129__Project(LEFT));
    SELF.Current_Month_ := __FN1(KEL.Routines.Month,__PP72843.Current_Date_);
    SELF.Current_Year_ := __FN1(KEL.Routines.Year,__PP72843.Current_Date_);
    SELF := __PP72843;
  END;
  EXPORT __ENH_Tradeline_10 := PROJECT(__EE73025,__ND73183__Project(LEFT));
END;
