//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE3627068 := __ENH_Tradeline_6;
  SHARED __EE3627100 := __EE3627068;
  SHARED __ST480569_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST203856_Layout) Records_;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST480569_Layout __JT3627111(B_Tradeline_6(__in,__cfg).__ST203849_Layout __l, B_Tradeline_6(__in,__cfg).__ST203856_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Date_Vendor_First_Reported_ := __r.Date_Vendor_First_Reported_;
    SELF.Date_Vendor_Last_Reported_ := __r.Date_Vendor_Last_Reported_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_First_Seen_ := __r.Vault_Date_First_Seen_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3627178 := NORMALIZE(__EE3627100,__T(LEFT.Records_),__JT3627111(LEFT,RIGHT));
  SHARED __ST480307_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE3627208 := PROJECT(__EE3627178,__ST480307_Layout);
  SHARED __ST480349_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE3627098 := PROJECT(__EE3627208,__ST480349_Layout);
  SHARED __ST480384_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE3627254 := PROJECT(__CLEANANDDO(__EE3627098,TABLE(__EE3627098,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),KEL.typ.int C_O_U_N_T___Records_ := COUNT(GROUP,__T(__EE3627098.Carrier_Segment_)),KEL.typ.int C_O_U_N_T___Records__1_ := COUNT(GROUP,__T(__EE3627098.Fleet_Segment_)),KEL.typ.int C_O_U_N_T___Records__2_ := COUNT(GROUP,__T(__EE3627098.Materials_Segment_)),KEL.typ.int C_O_U_N_T___Records__3_ := COUNT(GROUP,__T(__EE3627098.Operations_Segment_)),KEL.typ.int C_O_U_N_T___Records__4_ := COUNT(GROUP,__T(__EE3627098.Other_Segment_)),UID},UID,MERGE)),__ST480384_Layout);
  SHARED __ST480688_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_6(__in,__cfg).__ST203856_Layout) Records_;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3627263(B_Tradeline_6(__in,__cfg).__ST203849_Layout __EE3627068, __ST480384_Layout __EE3627254) := __EEQP(__EE3627068.UID,__EE3627254.UID);
  __ST480688_Layout __JT3627263(B_Tradeline_6(__in,__cfg).__ST203849_Layout __l, __ST480384_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3627315 := JOIN(__EE3627068,__EE3627254,__JC3627263(LEFT,RIGHT),__JT3627263(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST200116_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST200109_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST200116_Layout) Records_;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST200109_Layout __ND3627033__Project(__ST480688_Layout __PP3626736) := TRANSFORM
    __EE3627318 := __PP3626736.Records_;
    __ST200116_Layout __ND3626781__Project(B_Tradeline_6(__in,__cfg).__ST203856_Layout __PP3626777) := TRANSFORM
      SELF.Aging1_To30_L_N_ := IF(__T(__OR(__NT(__PP3626777.Aging1_To30_),__OP2(__PP3626777.Aging1_To30_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP3626777.Aging1_To30_));
      SELF.Aging31_To60_L_N_ := IF(__T(__OR(__NT(__PP3626777.Aging31_To60_),__OP2(__PP3626777.Aging31_To60_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP3626777.Aging31_To60_));
      SELF.Aging61_To90_L_N_ := IF(__T(__OR(__NT(__PP3626777.Aging61_To90_),__OP2(__PP3626777.Aging61_To90_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP3626777.Aging61_To90_));
      SELF.Aging91_Plus_L_N_ := IF(__T(__OR(__NT(__PP3626777.Aging91_Plus_),__OP2(__PP3626777.Aging91_Plus_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP3626777.Aging91_Plus_));
      SELF.Current_A_R_L_N_ := IF(__T(__OR(__NT(__PP3626777.Current_A_R_),__OP2(__PP3626777.Current_A_R_,<,__CN(0)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP3626777.Current_A_R_));
      SELF.Months_From_First_Of_Current_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP3626777.Record_Date_,__PP3626736.Current_Date_First_Of_Month_),+,__CN(1));
      SELF := __PP3626777;
    END;
    SELF.Records_ := __PROJECT(__EE3627318,__ND3626781__Project(LEFT));
    __CC30175 := 90;
    SELF.Is_Active1_Y_ := __OP2(__PP3626736.Newest_Record_Age_In_Days1_Y_,<=,__CN(__CC30175));
    SELF.Is_Carrier_Segment_ := __PP3626736.C_O_U_N_T___Records_ <> 0;
    SELF.Is_Fleet_Segment_ := __PP3626736.C_O_U_N_T___Records__1_ <> 0;
    SELF.Is_Materials_Segment_ := __PP3626736.C_O_U_N_T___Records__2_ <> 0;
    SELF.Is_Operations_Segment_ := __PP3626736.C_O_U_N_T___Records__3_ <> 0;
    SELF.Is_Other_Segment_ := __PP3626736.C_O_U_N_T___Records__4_ <> 0;
    __EE3627029 := __PP3626736.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE3627029,__T(__EE3627029).Record_Age_In_Days_);
    SELF := __PP3626736;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE3627315,__ND3627033__Project(LEFT));
END;
