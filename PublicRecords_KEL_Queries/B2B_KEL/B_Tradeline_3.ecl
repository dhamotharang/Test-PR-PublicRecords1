﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE477624 := __ENH_Tradeline_4;
  EXPORT __ST131205_Layout := RECORD
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
    KEL.typ.nint Aging1_To30_L_N_;
    KEL.typ.nint Aging31_To60_L_N_;
    KEL.typ.nint Aging61_To90_L_N_;
    KEL.typ.nint Aging91_Plus_L_N_;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nint Current_A_R_L_N_;
    KEL.typ.nint D_P_D1_Total_;
    KEL.typ.nint D_P_D31_Total_;
    KEL.typ.nint D_P_D61_Total_;
    KEL.typ.nint D_P_D91_Total_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Is_Most_Recent_Active_Record1_Y_;
    KEL.typ.nbool Is_Two_Year_Full_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nint Months_From_First_Of_Current_Month_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nint Total_A_R_L_N_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST131198_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST131205_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nbool Is_Active1_Y_;
    KEL.typ.bool Is_Carrier_Segment_ := FALSE;
    KEL.typ.bool Is_Fleet_Segment_ := FALSE;
    KEL.typ.bool Is_Materials_Segment_ := FALSE;
    KEL.typ.bool Is_Operations_Segment_ := FALSE;
    KEL.typ.bool Is_Other_Segment_ := FALSE;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nint Total_A_R_L_N_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST131198_Layout __ND477589__Project(B_Tradeline_4(__in,__cfg).__ST134187_Layout __PP477228) := TRANSFORM
    __EE477627 := __PP477228.Records_;
    __ST131205_Layout __ND477276__Project(B_Tradeline_4(__in,__cfg).__ST134194_Layout __PP477272) := TRANSFORM
      SELF.D_P_D1_Total_ := __OP2(__OP2(__OP2(__PP477272.Aging1_To30_L_N_,+,__PP477272.Aging31_To60_L_N_),+,__PP477272.Aging61_To90_L_N_),+,__PP477272.Aging91_Plus_L_N_);
      SELF.D_P_D31_Total_ := __OP2(__OP2(__PP477272.Aging31_To60_L_N_,+,__PP477272.Aging61_To90_L_N_),+,__PP477272.Aging91_Plus_L_N_);
      SELF.D_P_D61_Total_ := __OP2(__PP477272.Aging61_To90_L_N_,+,__PP477272.Aging91_Plus_L_N_);
      SELF.D_P_D91_Total_ := __PP477272.Aging91_Plus_L_N_;
      SELF := __PP477272;
    END;
    SELF.Records_ := __PROJECT(__EE477627,__ND477276__Project(LEFT));
    __EE477563 := __PP477228.Records_;
    __EE477578 := __PP477228.Records_;
    __BS477564 := __T(__EE477563);
    __EE477584 := __BS477564(__T(__OP2(__T(__EE477563).Record_Age_In_Days_,=,KEL.Aggregates.MinNN(__EE477578,__T(__EE477578).Record_Age_In_Days_))));
    SELF.Total_A_R_L_N_ := (__EE477584)[1].Total_A_R_L_N_;
    SELF := __PP477228;
  END;
  EXPORT __ENH_Tradeline_3 := PROJECT(__EE477624,__ND477589__Project(LEFT));
END;
