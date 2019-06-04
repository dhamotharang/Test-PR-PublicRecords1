﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE88764 := __ENH_Tradeline_6;
  SHARED __EE88796 := __EE88764;
  SHARED __ST87640_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST71544_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Two_Year_Full_Date_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST87640_Layout __JT88807(B_Tradeline_6(__in,__cfg).__ST71537_Layout __l, B_Tradeline_6(__in,__cfg).__ST71544_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE88808 := NORMALIZE(__EE88796,__T(LEFT.Records_),__JT88807(LEFT,RIGHT));
  SHARED __ST87325_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST71544_Layout) Records_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE88890 := PROJECT(__EE88808,__ST87325_Layout);
  SHARED __ST87417_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE88794 := PROJECT(__EE88890,__ST87417_Layout);
  SHARED __ST87452_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Records_ := 0;
    KEL.typ.int C_O_U_N_T___Records__1_ := 0;
    KEL.typ.int C_O_U_N_T___Records__2_ := 0;
    KEL.typ.int C_O_U_N_T___Records__3_ := 0;
    KEL.typ.int C_O_U_N_T___Records__4_ := 0;
    KEL.typ.nuid UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE88936 := PROJECT(__CLEANANDDO(__EE88794,TABLE(__EE88794,{KEL.typ.int C_O_U_N_T___Records_ := COUNT(GROUP,__T(__EE88794.Carrier_Segment_)),KEL.typ.int C_O_U_N_T___Records__1_ := COUNT(GROUP,__T(__EE88794.Fleet_Segment_)),KEL.typ.int C_O_U_N_T___Records__2_ := COUNT(GROUP,__T(__EE88794.Materials_Segment_)),KEL.typ.int C_O_U_N_T___Records__3_ := COUNT(GROUP,__T(__EE88794.Operations_Segment_)),KEL.typ.int C_O_U_N_T___Records__4_ := COUNT(GROUP,__T(__EE88794.Other_Segment_)),UID},UID,MERGE)),__ST87452_Layout);
  SHARED __ST87803_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST71544_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.int C_O_U_N_T___Records_ := 0;
    KEL.typ.int C_O_U_N_T___Records__1_ := 0;
    KEL.typ.int C_O_U_N_T___Records__2_ := 0;
    KEL.typ.int C_O_U_N_T___Records__3_ := 0;
    KEL.typ.int C_O_U_N_T___Records__4_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC88945(B_Tradeline_6(__in,__cfg).__ST71537_Layout __EE88764, __ST87452_Layout __EE88936) := __EEQP(__EE88764.UID,__EE88936.UID);
  __ST87803_Layout __JT88945(B_Tradeline_6(__in,__cfg).__ST71537_Layout __l, __ST87452_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE88946 := JOIN(__EE88764,__EE88936,__JC88945(LEFT,RIGHT),__JT88945(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST71016_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST71009_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST71016_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST71009_Layout __ND88728__Project(__ST87803_Layout __PP88427) := TRANSFORM
    __EE88949 := __PP88427.Records_;
    __ST71016_Layout __ND88473__Project(B_Tradeline_6(__in,__cfg).__ST71544_Layout __PP88469) := TRANSFORM
      SELF.Aging1_To30_L_N_ := IF(__T(__OR(__NT(__PP88469.Aging1_To30_),__OP2(__PP88469.Aging1_To30_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP88469.Aging1_To30_));
      SELF.Aging31_To60_L_N_ := IF(__T(__OR(__NT(__PP88469.Aging31_To60_),__OP2(__PP88469.Aging31_To60_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP88469.Aging31_To60_));
      SELF.Aging61_To90_L_N_ := IF(__T(__OR(__NT(__PP88469.Aging61_To90_),__OP2(__PP88469.Aging61_To90_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP88469.Aging61_To90_));
      SELF.Aging91_Plus_L_N_ := IF(__T(__OR(__NT(__PP88469.Aging91_Plus_),__OP2(__PP88469.Aging91_Plus_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP88469.Aging91_Plus_));
      SELF.Current_A_R_L_N_ := IF(__T(__OR(__NT(__PP88469.Current_A_R_),__OP2(__PP88469.Current_A_R_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP88469.Current_A_R_));
      SELF.Months_From_First_Of_Current_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP88469.Record_Date_,__PP88427.Current_Date_First_Of_Month_),+,__CN(1));
      SELF := __PP88469;
    END;
    SELF.Records_ := __PROJECT(__EE88949,__ND88473__Project(LEFT));
    __CC11231 := 90;
    SELF.Is_Active1_Y_ := __OP2(__PP88427.Newest_Record_Age_In_Days1_Y_,<=,__CN(__CC11231));
    SELF.Is_Carrier_Segment_ := __PP88427.C_O_U_N_T___Records_ <> 0;
    SELF.Is_Fleet_Segment_ := __PP88427.C_O_U_N_T___Records__1_ <> 0;
    SELF.Is_Materials_Segment_ := __PP88427.C_O_U_N_T___Records__2_ <> 0;
    SELF.Is_Operations_Segment_ := __PP88427.C_O_U_N_T___Records__3_ <> 0;
    SELF.Is_Other_Segment_ := __PP88427.C_O_U_N_T___Records__4_ <> 0;
    __EE88724 := __PP88427.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE88724,__T(__EE88724).Record_Age_In_Days_);
    SELF := __PP88427;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE88946,__ND88728__Project(LEFT));
END;
