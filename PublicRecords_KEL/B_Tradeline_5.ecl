﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6().__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE516704 := __ENH_Tradeline_6;
  SHARED __EE516736 := __EE516704;
  SHARED __ST515609_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST164928_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST515609_Layout __JT516747(B_Tradeline_6(__in,__cfg).__ST164921_Layout __l, B_Tradeline_6(__in,__cfg).__ST164928_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE516814 := NORMALIZE(__EE516736,__T(LEFT.Records_),__JT516747(LEFT,RIGHT));
  SHARED __ST515347_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE516844 := PROJECT(__EE516814,__ST515347_Layout);
  SHARED __ST515389_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE516734 := PROJECT(__EE516844,__ST515389_Layout);
  SHARED __ST515424_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Records_ := 0;
    KEL.typ.int C_O_U_N_T___Records__1_ := 0;
    KEL.typ.int C_O_U_N_T___Records__2_ := 0;
    KEL.typ.int C_O_U_N_T___Records__3_ := 0;
    KEL.typ.int C_O_U_N_T___Records__4_ := 0;
    KEL.typ.nuid UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE516890 := PROJECT(__CLEANANDDO(__EE516734,TABLE(__EE516734,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.int C_O_U_N_T___Records_ := COUNT(GROUP,__T(__EE516734.Carrier_Segment_)),KEL.typ.int C_O_U_N_T___Records__1_ := COUNT(GROUP,__T(__EE516734.Fleet_Segment_)),KEL.typ.int C_O_U_N_T___Records__2_ := COUNT(GROUP,__T(__EE516734.Materials_Segment_)),KEL.typ.int C_O_U_N_T___Records__3_ := COUNT(GROUP,__T(__EE516734.Operations_Segment_)),KEL.typ.int C_O_U_N_T___Records__4_ := COUNT(GROUP,__T(__EE516734.Other_Segment_)),UID},UID,MERGE)),__ST515424_Layout);
  SHARED __ST515728_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST164928_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC516899(B_Tradeline_6(__in,__cfg).__ST164921_Layout __EE516704, __ST515424_Layout __EE516890) := __EEQP(__EE516704.UID,__EE516890.UID);
  __ST515728_Layout __JT516899(B_Tradeline_6(__in,__cfg).__ST164921_Layout __l, __ST515424_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE516951 := JOIN(__EE516704,__EE516890,__JC516899(LEFT,RIGHT),__JT516899(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST161674_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST161667_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST161674_Layout) Records_;
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161667_Layout __ND516669__Project(__ST515728_Layout __PP516372) := TRANSFORM
    __EE516954 := __PP516372.Records_;
    __ST161674_Layout __ND516417__Project(B_Tradeline_6(__in,__cfg).__ST164928_Layout __PP516413) := TRANSFORM
      SELF.Aging1_To30_L_N_ := IF(__T(__OR(__NT(__PP516413.Aging1_To30_),__OP2(__PP516413.Aging1_To30_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP516413.Aging1_To30_));
      SELF.Aging31_To60_L_N_ := IF(__T(__OR(__NT(__PP516413.Aging31_To60_),__OP2(__PP516413.Aging31_To60_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP516413.Aging31_To60_));
      SELF.Aging61_To90_L_N_ := IF(__T(__OR(__NT(__PP516413.Aging61_To90_),__OP2(__PP516413.Aging61_To90_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP516413.Aging61_To90_));
      SELF.Aging91_Plus_L_N_ := IF(__T(__OR(__NT(__PP516413.Aging91_Plus_),__OP2(__PP516413.Aging91_Plus_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP516413.Aging91_Plus_));
      SELF.Current_A_R_L_N_ := IF(__T(__OR(__NT(__PP516413.Current_A_R_),__OP2(__PP516413.Current_A_R_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP516413.Current_A_R_));
      SELF.Months_From_First_Of_Current_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP516413.Record_Date_,__PP516372.Current_Date_First_Of_Month_),+,__CN(1));
      SELF := __PP516413;
    END;
    SELF.Records_ := __PROJECT(__EE516954,__ND516417__Project(LEFT));
    __CC24672 := 90;
    SELF.Is_Active1_Y_ := __OP2(__PP516372.Newest_Record_Age_In_Days1_Y_,<=,__CN(__CC24672));
    SELF.Is_Carrier_Segment_ := __PP516372.C_O_U_N_T___Records_ <> 0;
    SELF.Is_Fleet_Segment_ := __PP516372.C_O_U_N_T___Records__1_ <> 0;
    SELF.Is_Materials_Segment_ := __PP516372.C_O_U_N_T___Records__2_ <> 0;
    SELF.Is_Operations_Segment_ := __PP516372.C_O_U_N_T___Records__3_ <> 0;
    SELF.Is_Other_Segment_ := __PP516372.C_O_U_N_T___Records__4_ <> 0;
    __EE516665 := __PP516372.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE516665,__T(__EE516665).Record_Age_In_Days_);
    SELF := __PP516372;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE516951,__ND516669__Project(LEFT));
END;
