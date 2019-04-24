﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Business_2,B_Tradeline_2,B_Tradeline_Business_2,B_Tradeline_Business_3,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Business_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_2(__in,__cfg).__ENH_Business_2) __ENH_Business_2 := B_Business_2(__in,__cfg).__ENH_Business_2;
  SHARED VIRTUAL TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2;
  SHARED VIRTUAL TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2;
  SHARED __EE179906 := __ENH_Business_2;
  SHARED __EE180568 := __ENH_Tradeline_2;
  SHARED __EE180566 := __ENH_Tradeline_Business_2;
  SHARED __EE189121 := __EE180566(__NN(__EE180566.Company_) AND __NN(__EE180566.Account_));
  SHARED __ST184793_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_2(__in,__cfg).__ST36592_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nbool Is_Active1_Y_;
    KEL.typ.bool Is_Carrier_Segment_ := FALSE;
    KEL.typ.bool Is_Fleet_Segment_ := FALSE;
    KEL.typ.bool Is_Materials_Segment_ := FALSE;
    KEL.typ.bool Is_Operations_Segment_ := FALSE;
    KEL.typ.bool Is_Other_Segment_ := FALSE;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nint Total___A_R___L_N_;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Tradeline_Business_3(__in,__cfg).__ST19919_Layout) Trade_Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC189139(B_Tradeline_2(__in,__cfg).__ST36585_Layout __EE180568, B_Tradeline_Business_3(__in,__cfg).__ST38133_Layout __EE189121) := __EEQP(__EE189121.Account_,__EE180568.UID);
  __ST184793_Layout __JT189139(B_Tradeline_2(__in,__cfg).__ST36585_Layout __l, B_Tradeline_Business_3(__in,__cfg).__ST38133_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE189140 := JOIN(__EE189121,__EE180568,__JC189139(RIGHT,LEFT),__JT189139(RIGHT,LEFT),INNER,HASH);
  SHARED __EE189872 := __EE189140;
  SHARED __ST185296_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_2(__in,__cfg).__ST36592_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nbool Is_Active1_Y_;
    KEL.typ.bool Is_Carrier_Segment_ := FALSE;
    KEL.typ.bool Is_Fleet_Segment_ := FALSE;
    KEL.typ.bool Is_Materials_Segment_ := FALSE;
    KEL.typ.bool Is_Operations_Segment_ := FALSE;
    KEL.typ.bool Is_Other_Segment_ := FALSE;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nint Total___A_R___L_N_;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Tradeline_Business_3(__in,__cfg).__ST19919_Layout) Trade_Account_;
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
    KEL.typ.nint Current___A_R___L_N_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nint Total___A_R___L_N__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST185296_Layout __JT189885(__ST184793_Layout __l, B_Tradeline_2(__in,__cfg).__ST36592_Layout __r) := TRANSFORM
    SELF.Total___A_R___L_N__1_ := __r.Total___A_R___L_N_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE189886 := NORMALIZE(__EE189872,__T(LEFT.Records_),__JT189885(LEFT,RIGHT));
  SHARED __ST184045_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_Business_3(__in,__cfg).__ST19919_Layout) Trade_Account_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_2(__in,__cfg).__ST36592_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nbool Is_Active1_Y_;
    KEL.typ.bool Is_Carrier_Segment_ := FALSE;
    KEL.typ.bool Is_Fleet_Segment_ := FALSE;
    KEL.typ.bool Is_Materials_Segment_ := FALSE;
    KEL.typ.bool Is_Operations_Segment_ := FALSE;
    KEL.typ.bool Is_Other_Segment_ := FALSE;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nint Total___A_R___L_N_;
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
    KEL.typ.nint Current___A_R___L_N_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nint Total___A_R___L_N__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST184045_Layout __ND189975__Project(__ST185296_Layout __PP189887) := TRANSFORM
    SELF.UID := __PP189887.Company_;
    SELF.Data_Sources_ := __PP189887.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP189887.UID;
    SELF.Data_Sources__1_ := __PP189887.Data_Sources_;
    SELF := __PP189887;
  END;
  SHARED __EE190236 := PROJECT(__EE189886,__ND189975__Project(LEFT));
  SHARED __ST184239_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST184239_Layout __ND190654__Project(__ST184045_Layout __PP190237) := TRANSFORM
    __CC10533 := 730;
    SELF.Exp1_ := IF(__T(__OP2(__PP190237.Record_Age_In_Days_,<=,__CN(__CC10533))),__ECAST(KEL.typ.nkdate,__PP190237.A_R_Date_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP190237;
  END;
  SHARED __EE190659 := PROJECT(__EE190236,__ND190654__Project(LEFT));
  SHARED __ST184262_Layout := RECORD
    KEL.typ.nkdate M_A_X___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE190685 := PROJECT(__CLEANANDDO(__EE190659,TABLE(__EE190659,{KEL.Aggregates.MaxNG(__EE190659.Exp1_) M_A_X___A_R_Date_,KEL.Aggregates.MinNG(__EE190659.Exp1_) M_I_N___A_R_Date_,KEL.Aggregates.MinNG(__EE190659.A_R_Date_) M_I_N___A_R_Date__1_,UID},UID,MERGE)),__ST184262_Layout);
  SHARED __ST185664_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(B_Business_2(__in,__cfg).__ST34627_Layout) Data_Sources_;
    KEL.typ.int B2b_Actv_T_L_Bal_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.nint B2b_T_L_Cnt_Ev_;
    KEL.typ.nkdate M_A_X___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC190691(B_Business_2(__in,__cfg).__ST34613_Layout __EE179906, __ST184262_Layout __EE190685) := __EEQP(__EE179906.UID,__EE190685.UID);
  __ST185664_Layout __JT190691(B_Business_2(__in,__cfg).__ST34613_Layout __l, __ST184262_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE190729 := JOIN(__EE179906,__EE190685,__JC190691(LEFT,RIGHT),__JT190691(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST182214_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Tradeline_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Tradeline_Business_3(__in,__cfg).__ST19919_Layout) Trade_Account_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_2(__in,__cfg).__ST36592_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nbool Is_Active1_Y_;
    KEL.typ.bool Is_Carrier_Segment_ := FALSE;
    KEL.typ.bool Is_Fleet_Segment_ := FALSE;
    KEL.typ.bool Is_Materials_Segment_ := FALSE;
    KEL.typ.bool Is_Operations_Segment_ := FALSE;
    KEL.typ.bool Is_Other_Segment_ := FALSE;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.nint Total___A_R___L_N_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST182214_Layout __ND189205__Project(__ST184793_Layout __PP189141) := TRANSFORM
    SELF.UID := __PP189141.Company_;
    SELF.Data_Sources_ := __PP189141.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP189141.UID;
    SELF.Data_Sources__1_ := __PP189141.Data_Sources_;
    SELF := __PP189141;
  END;
  SHARED __EE189370 := PROJECT(__EE189140,__ND189205__Project(LEFT));
  SHARED __ST182414_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
    KEL.typ.nint Exp3_;
    KEL.typ.nint Exp4_;
    KEL.typ.nint Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.nbool Exp7_;
    KEL.typ.nbool Exp8_;
    KEL.typ.nbool Exp9_;
    KEL.typ.nbool Exp10_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST182414_Layout __ND190734__Project(__ST182214_Layout __PP189371) := TRANSFORM
    SELF.Exp1_ := IF(__T(__AND(__CN(__PP189371.Is_Carrier_Segment_),__PP189371.Is_Active_)),__ECAST(KEL.typ.nint,__PP189371.Total___A_R___L_N_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp2_ := IF(__T(__AND(__CN(__PP189371.Is_Fleet_Segment_),__PP189371.Is_Active_)),__ECAST(KEL.typ.nint,__PP189371.Total___A_R___L_N_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp3_ := IF(__T(__AND(__CN(__PP189371.Is_Materials_Segment_),__PP189371.Is_Active_)),__ECAST(KEL.typ.nint,__PP189371.Total___A_R___L_N_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp4_ := IF(__T(__AND(__CN(__PP189371.Is_Operations_Segment_),__PP189371.Is_Active_)),__ECAST(KEL.typ.nint,__PP189371.Total___A_R___L_N_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp5_ := IF(__T(__AND(__CN(__PP189371.Is_Other_Segment_),__PP189371.Is_Active_)),__ECAST(KEL.typ.nint,__PP189371.Total___A_R___L_N_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    __CC10533 := 730;
    SELF.Exp6_ := __AND(__CN(__PP189371.Is_Carrier_Segment_),__OP2(__PP189371.Newest_Record_Age_In_Days_,<=,__CN(__CC10533)));
    SELF.Exp7_ := __AND(__CN(__PP189371.Is_Fleet_Segment_),__OP2(__PP189371.Newest_Record_Age_In_Days_,<=,__CN(__CC10533)));
    SELF.Exp8_ := __AND(__CN(__PP189371.Is_Materials_Segment_),__OP2(__PP189371.Newest_Record_Age_In_Days_,<=,__CN(__CC10533)));
    SELF.Exp9_ := __AND(__CN(__PP189371.Is_Operations_Segment_),__OP2(__PP189371.Newest_Record_Age_In_Days_,<=,__CN(__CC10533)));
    SELF.Exp10_ := __AND(__CN(__PP189371.Is_Other_Segment_),__OP2(__PP189371.Newest_Record_Age_In_Days_,<=,__CN(__CC10533)));
    SELF := __PP189371;
  END;
  SHARED __EE190779 := PROJECT(__EE189370,__ND190734__Project(LEFT));
  SHARED __ST182474_Layout := RECORD
    KEL.typ.int S_U_M___Total___A_R___L_N_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__1_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__2_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__3_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE190845 := PROJECT(__CLEANANDDO(__EE190779,TABLE(__EE190779,{KEL.typ.int S_U_M___Total___A_R___L_N_ := KEL.Aggregates.SumNG(__EE190779.Exp1_),KEL.typ.int S_U_M___Total___A_R___L_N__1_ := KEL.Aggregates.SumNG(__EE190779.Exp2_),KEL.typ.int S_U_M___Total___A_R___L_N__2_ := KEL.Aggregates.SumNG(__EE190779.Exp3_),KEL.typ.int S_U_M___Total___A_R___L_N__3_ := KEL.Aggregates.SumNG(__EE190779.Exp4_),KEL.typ.int S_U_M___Total___A_R___L_N__4_ := KEL.Aggregates.SumNG(__EE190779.Exp5_),KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE190779.Exp6_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE190779.Exp7_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE190779.Exp8_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE190779.Exp9_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE190779.Exp10_)),UID},UID,MERGE)),__ST182474_Layout);
  SHARED __ST185993_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(B_Business_2(__in,__cfg).__ST34627_Layout) Data_Sources_;
    KEL.typ.int B2b_Actv_T_L_Bal_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.nint B2b_T_L_Cnt_Ev_;
    KEL.typ.nkdate M_A_X___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date_;
    KEL.typ.nkdate M_I_N___A_R_Date__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Total___A_R___L_N_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__1_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__2_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__3_ := 0;
    KEL.typ.int S_U_M___Total___A_R___L_N__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC190853(__ST185664_Layout __EE190729, __ST182474_Layout __EE190845) := __EEQP(__EE190729.UID,__EE190845.UID);
  __ST185993_Layout __JT190853(__ST185664_Layout __l, __ST182474_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE190902 := JOIN(__EE190729,__EE190845,__JC190853(LEFT,RIGHT),__JT190853(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST31402_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST19808_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST31388_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(__ST31402_Layout) Data_Sources_;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Carr_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Flt_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Mat_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Ops_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Oth_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_Tot_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_No_Cap_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_No_Cap_ := 0;
    KEL.typ.nstr B2b_Newest_T_L_Dt2_Y_;
    KEL.typ.nstr B2b_Oldest_T_L_Dt2_Y_;
    KEL.typ.nstr B2b_Oldest_T_L_Dt_Ev_;
    KEL.typ.int B2b_T_L_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.nint B2b_T_L_Cnt_Ev_;
    KEL.typ.int B2b_T_L_In_Carr_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Flt_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Mat_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Ops_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Oth_Cnt2_Y_No_Cap_ := 0;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.ndataset(__ST19808_Layout) Translated_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST31388_Layout __ND190915__Project(__ST185993_Layout __PP190911) := TRANSFORM
    __EE190905 := __PP190911.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE190905),__ST31402_Layout),__NL(__EE190905));
    SELF.B2b_Actv_T_L_Bal_In_Carr_Tot_No_Cap_ := __PP190911.S_U_M___Total___A_R___L_N_;
    SELF.B2b_Actv_T_L_Bal_In_Flt_Tot_No_Cap_ := __PP190911.S_U_M___Total___A_R___L_N__1_;
    SELF.B2b_Actv_T_L_Bal_In_Mat_Tot_No_Cap_ := __PP190911.S_U_M___Total___A_R___L_N__2_;
    SELF.B2b_Actv_T_L_Bal_In_Ops_Tot_No_Cap_ := __PP190911.S_U_M___Total___A_R___L_N__3_;
    SELF.B2b_Actv_T_L_Bal_In_Oth_Tot_No_Cap_ := __PP190911.S_U_M___Total___A_R___L_N__4_;
    __CC3234 := -99998;
    SELF.B2b_Actv_T_L_Bal_Tot_ := IF(__PP190911.B2b_Actv_T_L_Cnt_No_Cap_ = 0,__CC3234,KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_Bal_Tot_No_Cap_,0,99999999));
    SELF.B2b_Actv_T_L_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Carr_Cnt_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Carr_Cnt_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Flt_Cnt_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Flt_Cnt_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Mat_Cnt_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Mat_Cnt_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Ops_Cnt_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Ops_Cnt_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Oth_Cnt_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Oth_Cnt_No_Cap_,0,999);
    SELF.B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_ := KEL.Routines.BoundsFold(__PP190911.B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_No_Cap_,0,999);
    SELF.B2b_Newest_T_L_Dt2_Y_ := IF(__PP190911.B2b_T_L_Cnt2_Y_ = 0,__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC3234))),__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP190911.M_A_X___A_R_Date_)));
    SELF.B2b_Oldest_T_L_Dt2_Y_ := IF(__PP190911.B2b_T_L_Cnt2_Y_ = 0,__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(__CC3234))),__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP190911.M_I_N___A_R_Date_)));
    __CC3231 := '-99998';
    SELF.B2b_Oldest_T_L_Dt_Ev_ := IF(__T(__OP2(__PP190911.B2b_T_L_Cnt_Ev_,=,__CN(0))),__ECAST(KEL.typ.nstr,__CN(__CC3231)),__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP190911.M_I_N___A_R_Date__1_)));
    SELF.B2b_T_L_In_Carr_Cnt2_Y_No_Cap_ := __PP190911.C_O_U_N_T___Exp1_;
    SELF.B2b_T_L_In_Flt_Cnt2_Y_No_Cap_ := __PP190911.C_O_U_N_T___Exp1__1_;
    SELF.B2b_T_L_In_Mat_Cnt2_Y_No_Cap_ := __PP190911.C_O_U_N_T___Exp1__2_;
    SELF.B2b_T_L_In_Ops_Cnt2_Y_No_Cap_ := __PP190911.C_O_U_N_T___Exp1__3_;
    SELF.B2b_T_L_In_Oth_Cnt2_Y_No_Cap_ := __PP190911.C_O_U_N_T___Exp1__4_;
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
    __EE190909 := __PP190911.Data_Sources_;
    SELF.Translated_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE190909),__ST19808_Layout)(__NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Translated_Source_Code_},Translated_Source_Code_,MERGE),__ST19808_Layout),__NL(__EE190909));
    SELF := __PP190911;
  END;
  EXPORT __ENH_Business_1 := PROJECT(PROJECT(__EE190902,__ND190915__Project(LEFT)),__ST31388_Layout);
END;
