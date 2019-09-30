﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_5,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Tradeline_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5;
  SHARED __EE209286 := __ENH_Tradeline_5;
  EXPORT __ST85771_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85764_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST85771_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST85764_Layout __ND209218__Project(B_Tradeline_5(__in,__cfg).__ST86997_Layout __PP208934) := TRANSFORM
    __EE209289 := __PP208934.Records_;
    __ST85771_Layout __ND209154__Project(B_Tradeline_5(__in,__cfg).__ST87004_Layout __PP208936) := TRANSFORM
      SELF.A_R_Date_Group_ := __FN3(KEL.Routines.DateFromParts,__FN1(KEL.Routines.Year,__PP208936.A_R_Date_),__FN1(KEL.Routines.Month,__PP208936.A_R_Date_),__CN(0));
      __EE209141 := __PP208934.Records_;
      __BS209142 := __T(__EE209141);
      __EE209147 := __BS209142(__T(__T(__EE209141).Is1_Y_Record_));
      SELF.Is_Most_Recent_Active_Record1_Y_ := __AND(__PP208934.Is_Active1_Y_,__OP2(__PP208936.A_R_Date_,=,KEL.Aggregates.MaxN(__EE209147,__EE209147.A_R_Date_)));
      SELF.Total_A_R_L_N_ := __OP2(__OP2(__OP2(__OP2(__PP208936.Current_A_R_L_N_,+,__PP208936.Aging1_To30_L_N_),+,__PP208936.Aging31_To60_L_N_),+,__PP208936.Aging61_To90_L_N_),+,__PP208936.Aging91_Plus_L_N_);
      SELF := __PP208936;
    END;
    SELF.Records_ := __PROJECT(__EE209289,__ND209154__Project(LEFT));
    __CC16986 := 90;
    SELF.Is_Active_ := __OP2(__PP208934.Newest_Record_Age_In_Days_,<=,__CN(__CC16986));
    SELF := __PP208934;
  END;
  EXPORT __ENH_Tradeline_4 := PROJECT(__EE209286,__ND209218__Project(LEFT));
END;
