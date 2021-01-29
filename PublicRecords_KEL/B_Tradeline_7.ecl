﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_8,CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Tradeline_7(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_8(__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8(__cfg).__ENH_Tradeline_8;
  SHARED __EE5268083 := __ENH_Tradeline_8;
  EXPORT __ST258573_Layout := RECORD
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
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Is_Two_Year_Full_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST258566_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST258573_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST258566_Layout __ND5268335__Project(B_Tradeline_8(__cfg).__ST261173_Layout __PP5268084) := TRANSFORM
    __EE5268117 := __PP5268084.Records_;
    __ST258573_Layout __ND5268310__Project(B_Tradeline_8(__cfg).__ST261180_Layout __PP5268118) := TRANSFORM
      SELF.Is_Two_Year_Full_Record_ := __AND(__OP2(__PP5268118.Record_Date_,<,__PP5268084.Current_Date_First_Of_Month_),__OP2(__PP5268118.Record_Date_,>=,__PP5268084.Two_Year_Full_Date_));
      SELF.Other_Segment_ := __NOT(__OR(__OR(__OR(__PP5268118.Carrier_Segment_,__PP5268118.Fleet_Segment_),__PP5268118.Materials_Segment_),__PP5268118.Operations_Segment_));
      __CC14490 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('cortera_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Record_Age_In_Days1_Y_ := IF(__T(__PP5268118.Is1_Y_Record_),__ECAST(KEL.typ.nint,FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP5268118.Record_Date_),__ECAST(KEL.typ.nkdate,__FN4(KEL.Routines.AdjustCalendar,__CC14490,__CN(-1),__CN(0),__CN(0))))),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
      SELF := __PP5268118;
    END;
    SELF.Records_ := __PROJECT(__EE5268117,__ND5268310__Project(LEFT));
    SELF := __PP5268084;
  END;
  EXPORT __ENH_Tradeline_7 := PROJECT(__EE5268083,__ND5268335__Project(LEFT));
END;
