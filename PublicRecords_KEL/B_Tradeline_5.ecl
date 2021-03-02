//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE5656376 := __ENH_Tradeline_6;
  EXPORT __ST263715_Layout := RECORD
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
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Is_Two_Year_Full_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nint Months_From_First_Of_Current_Month_;
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
  EXPORT __ST263708_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST263715_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
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
  SHARED __ST263708_Layout __ND5656341__Project(B_Tradeline_6(__in,__cfg).__ST268558_Layout __PP5655414) := TRANSFORM
    __EE5656379 := __PP5655414.Records_;
    __ST263715_Layout __ND5656247__Project(B_Tradeline_6(__in,__cfg).__ST268565_Layout __PP5655456) := TRANSFORM
      SELF.Aging1_To30_L_N_ := IF(__T(__OR(__NT(__PP5655456.Aging1_To30_),__OP2(__PP5655456.Aging1_To30_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP5655456.Aging1_To30_));
      SELF.Aging31_To60_L_N_ := IF(__T(__OR(__NT(__PP5655456.Aging31_To60_),__OP2(__PP5655456.Aging31_To60_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP5655456.Aging31_To60_));
      SELF.Aging61_To90_L_N_ := IF(__T(__OR(__NT(__PP5655456.Aging61_To90_),__OP2(__PP5655456.Aging61_To90_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP5655456.Aging61_To90_));
      SELF.Aging91_Plus_L_N_ := IF(__T(__OR(__NT(__PP5655456.Aging91_Plus_),__OP2(__PP5655456.Aging91_Plus_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP5655456.Aging91_Plus_));
      SELF.Current_A_R_L_N_ := IF(__T(__OR(__NT(__PP5655456.Current_A_R_),__OP2(__PP5655456.Current_A_R_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP5655456.Current_A_R_));
      SELF.Months_From_First_Of_Current_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP5655456.Record_Date_,__PP5655414.Current_Date_First_Of_Month_),+,__CN(1));
      SELF := __PP5655456;
    END;
    SELF.Records_ := __PROJECT(__EE5656379,__ND5656247__Project(LEFT));
    __CC42700 := 90;
    SELF.Is_Active1_Y_ := __OP2(__PP5655414.Newest_Record_Age_In_Days1_Y_,<=,__CN(__CC42700));
    __BS5655635 := __T(__PP5655414.Records_);
    SELF.Is_Carrier_Segment_ := EXISTS(__BS5655635(__T(__T(__PP5655414.Records_).Carrier_Segment_)));
    __BS5655644 := __T(__PP5655414.Records_);
    SELF.Is_Fleet_Segment_ := EXISTS(__BS5655644(__T(__T(__PP5655414.Records_).Fleet_Segment_)));
    __BS5655653 := __T(__PP5655414.Records_);
    SELF.Is_Materials_Segment_ := EXISTS(__BS5655653(__T(__T(__PP5655414.Records_).Materials_Segment_)));
    __BS5655662 := __T(__PP5655414.Records_);
    SELF.Is_Operations_Segment_ := EXISTS(__BS5655662(__T(__T(__PP5655414.Records_).Operations_Segment_)));
    __BS5655671 := __T(__PP5655414.Records_);
    SELF.Is_Other_Segment_ := EXISTS(__BS5655671(__T(__T(__PP5655414.Records_).Other_Segment_)));
    __EE5656336 := __PP5655414.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE5656336,__T(__EE5656336).Record_Age_In_Days_);
    SELF := __PP5655414;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE5656376,__ND5656341__Project(LEFT));
END;
