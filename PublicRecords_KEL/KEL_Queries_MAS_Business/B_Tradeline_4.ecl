//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Tradeline_5,CFG_Compile,E_Tradeline FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Tradeline_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5;
  SHARED __EE2124464 := __ENH_Tradeline_5;
  EXPORT __ST207798_Layout := RECORD
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
    KEL.typ.nkdate A_R_Date_Group_;
    KEL.typ.nint Aging1_To30_L_N_;
    KEL.typ.nint Aging31_To60_L_N_;
    KEL.typ.nint Aging61_To90_L_N_;
    KEL.typ.nint Aging91_Plus_L_N_;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nint Current_A_R_L_N_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Is_Most_Recent_Active_Record1_Y_;
    KEL.typ.nbool Is_Two_Year_Full_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nint Months_From_First_Of_Current_Month_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nint Total_A_R_L_N_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST207791_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST207798_Layout) Records_;
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
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST207791_Layout __ND2124399__Project(B_Tradeline_5(__in,__cfg).__ST212024_Layout __PP2123720) := TRANSFORM
    __EE2124467 := __PP2123720.Records_;
    __ST207798_Layout __ND2124335__Project(B_Tradeline_5(__in,__cfg).__ST212031_Layout __PP2123763) := TRANSFORM
      SELF.A_R_Date_Group_ := __FN3(KEL.Routines.DateFromParts,__FN1(KEL.Routines.Year,__PP2123763.A_R_Date_),__FN1(KEL.Routines.Month,__PP2123763.A_R_Date_),__CN(0));
      __EE2124322 := __PP2123720.Records_;
      __BS2124323 := __T(__EE2124322);
      __EE2124328 := __BS2124323(__T(__T(__EE2124322).Is1_Y_Record_));
      SELF.Is_Most_Recent_Active_Record1_Y_ := __AND(__PP2123720.Is_Active1_Y_,__OP2(__PP2123763.A_R_Date_,=,KEL.Aggregates.MaxN(__EE2124328,__EE2124328.A_R_Date_)));
      SELF.Total_A_R_L_N_ := __OP2(__OP2(__OP2(__OP2(__PP2123763.Current_A_R_L_N_,+,__PP2123763.Aging1_To30_L_N_),+,__PP2123763.Aging31_To60_L_N_),+,__PP2123763.Aging61_To90_L_N_),+,__PP2123763.Aging91_Plus_L_N_);
      SELF := __PP2123763;
    END;
    SELF.Records_ := __PROJECT(__EE2124467,__ND2124335__Project(LEFT));
    __CC48809 := 90;
    SELF.Is_Active_ := __OP2(__PP2123720.Newest_Record_Age_In_Days_,<=,__CN(__CC48809));
    SELF := __PP2123720;
  END;
  EXPORT __ENH_Tradeline_4 := PROJECT(__EE2124464,__ND2124399__Project(LEFT));
END;
