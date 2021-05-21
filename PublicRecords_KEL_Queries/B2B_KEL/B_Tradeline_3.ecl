﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Tradeline_4,CFG_Compile,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Tradeline_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4;
  SHARED __EE590670 := __ENH_Tradeline_4;
  EXPORT __ST158667_Layout := RECORD
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
  EXPORT __ST158660_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST158667_Layout) Records_;
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
  SHARED __ST158660_Layout __ND590635__Project(B_Tradeline_4(__in,__cfg).__ST161649_Layout __PP589994) := TRANSFORM
    __EE590673 := __PP589994.Records_;
    __ST158667_Layout __ND590042__Project(B_Tradeline_4(__in,__cfg).__ST161656_Layout __PP590038) := TRANSFORM
      SELF.D_P_D1_Total_ := __OP2(__OP2(__OP2(__PP590038.Aging1_To30_L_N_,+,__PP590038.Aging31_To60_L_N_),+,__PP590038.Aging61_To90_L_N_),+,__PP590038.Aging91_Plus_L_N_);
      SELF.D_P_D31_Total_ := __OP2(__OP2(__PP590038.Aging31_To60_L_N_,+,__PP590038.Aging61_To90_L_N_),+,__PP590038.Aging91_Plus_L_N_);
      SELF.D_P_D61_Total_ := __OP2(__PP590038.Aging61_To90_L_N_,+,__PP590038.Aging91_Plus_L_N_);
      SELF.D_P_D91_Total_ := __PP590038.Aging91_Plus_L_N_;
      SELF := __PP590038;
    END;
    SELF.Records_ := __PROJECT(__EE590673,__ND590042__Project(LEFT));
    __EE590609 := __PP589994.Records_;
    __EE590624 := __PP589994.Records_;
    __BS590610 := __T(__EE590609);
    __EE590630 := __BS590610(__T(__OP2(__T(__EE590609).Record_Age_In_Days_,=,KEL.Aggregates.MinNN(__EE590624,__T(__EE590624).Record_Age_In_Days_))));
    SELF.Total_A_R_L_N_ := (__EE590630)[1].Total_A_R_L_N_;
    SELF := __PP589994;
  END;
  EXPORT __ENH_Tradeline_3 := PROJECT(__EE590670,__ND590635__Project(LEFT));
END;
