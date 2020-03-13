//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE261871 := __ENH_Tradeline_6;
  SHARED __EE261903 := __EE261871;
  SHARED __ST260776_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST145790_Layout) Records_;
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
  __ST260776_Layout __JT261914(B_Tradeline_6(__in,__cfg).__ST145783_Layout __l, B_Tradeline_6(__in,__cfg).__ST145790_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE261981 := NORMALIZE(__EE261903,__T(LEFT.Records_),__JT261914(LEFT,RIGHT));
  SHARED __ST260514_Layout := RECORD
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
  SHARED __EE262011 := PROJECT(__EE261981,__ST260514_Layout);
  SHARED __ST260556_Layout := RECORD
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
  SHARED __EE261901 := PROJECT(__EE262011,__ST260556_Layout);
  SHARED __ST260591_Layout := RECORD
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
  SHARED __EE262057 := PROJECT(__CLEANANDDO(__EE261901,TABLE(__EE261901,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.int C_O_U_N_T___Records_ := COUNT(GROUP,__T(__EE261901.Carrier_Segment_)),KEL.typ.int C_O_U_N_T___Records__1_ := COUNT(GROUP,__T(__EE261901.Fleet_Segment_)),KEL.typ.int C_O_U_N_T___Records__2_ := COUNT(GROUP,__T(__EE261901.Materials_Segment_)),KEL.typ.int C_O_U_N_T___Records__3_ := COUNT(GROUP,__T(__EE261901.Operations_Segment_)),KEL.typ.int C_O_U_N_T___Records__4_ := COUNT(GROUP,__T(__EE261901.Other_Segment_)),UID},UID,MERGE)),__ST260591_Layout);
  SHARED __ST260895_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST145790_Layout) Records_;
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
  __JC262066(B_Tradeline_6(__in,__cfg).__ST145783_Layout __EE261871, __ST260591_Layout __EE262057) := __EEQP(__EE261871.UID,__EE262057.UID);
  __ST260895_Layout __JT262066(B_Tradeline_6(__in,__cfg).__ST145783_Layout __l, __ST260591_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE262118 := JOIN(__EE261871,__EE262057,__JC262066(LEFT,RIGHT),__JT262066(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST143738_Layout := RECORD
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
  EXPORT __ST143731_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST143738_Layout) Records_;
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
  SHARED __ST143731_Layout __ND261836__Project(__ST260895_Layout __PP261539) := TRANSFORM
    __EE262121 := __PP261539.Records_;
    __ST143738_Layout __ND261584__Project(B_Tradeline_6(__in,__cfg).__ST145790_Layout __PP261580) := TRANSFORM
      SELF.Aging1_To30_L_N_ := IF(__T(__OR(__NT(__PP261580.Aging1_To30_),__OP2(__PP261580.Aging1_To30_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP261580.Aging1_To30_));
      SELF.Aging31_To60_L_N_ := IF(__T(__OR(__NT(__PP261580.Aging31_To60_),__OP2(__PP261580.Aging31_To60_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP261580.Aging31_To60_));
      SELF.Aging61_To90_L_N_ := IF(__T(__OR(__NT(__PP261580.Aging61_To90_),__OP2(__PP261580.Aging61_To90_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP261580.Aging61_To90_));
      SELF.Aging91_Plus_L_N_ := IF(__T(__OR(__NT(__PP261580.Aging91_Plus_),__OP2(__PP261580.Aging91_Plus_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP261580.Aging91_Plus_));
      SELF.Current_A_R_L_N_ := IF(__T(__OR(__NT(__PP261580.Current_A_R_),__OP2(__PP261580.Current_A_R_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP261580.Current_A_R_));
      SELF.Months_From_First_Of_Current_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP261580.Record_Date_,__PP261539.Current_Date_First_Of_Month_),+,__CN(1));
      SELF := __PP261580;
    END;
    SELF.Records_ := __PROJECT(__EE262121,__ND261584__Project(LEFT));
    __CC22103 := 90;
    SELF.Is_Active1_Y_ := __OP2(__PP261539.Newest_Record_Age_In_Days1_Y_,<=,__CN(__CC22103));
    SELF.Is_Carrier_Segment_ := __PP261539.C_O_U_N_T___Records_ <> 0;
    SELF.Is_Fleet_Segment_ := __PP261539.C_O_U_N_T___Records__1_ <> 0;
    SELF.Is_Materials_Segment_ := __PP261539.C_O_U_N_T___Records__2_ <> 0;
    SELF.Is_Operations_Segment_ := __PP261539.C_O_U_N_T___Records__3_ <> 0;
    SELF.Is_Other_Segment_ := __PP261539.C_O_U_N_T___Records__4_ <> 0;
    __EE261832 := __PP261539.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE261832,__T(__EE261832).Record_Age_In_Days_);
    SELF := __PP261539;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE262118,__ND261836__Project(LEFT));
END;
