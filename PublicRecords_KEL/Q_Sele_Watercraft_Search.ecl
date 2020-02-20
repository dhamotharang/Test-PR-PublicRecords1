//HPCC Systems KEL Compiler Version 1.0.1
IMPORT KEL10 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Sele_Watercraft,E_Tradeline,E_Watercraft FROM PublicRecords_KEL;
IMPORT * FROM KEL10.Null;
EXPORT Q_Sele_Watercraft_Search(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Business_Sele_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Watercraft_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Watercraft(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Legal_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Sele_Filtered := E_Business_Sele_Filtered_1;
  SHARED E_Sele_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED TYPEOF(E_Business_Sele(__in,__cfg_Local).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Sele_Watercraft(__in,__cfg_Local).__Result) __E_Sele_Watercraft := E_Sele_Watercraft_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE1343829 := __E_Business_Sele;
  SHARED __EE1346893 := __EE1343829(__T(__AND(__OP2(__EE1343829.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE1343829.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE1343829.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __EE1343828 := __E_Sele_Watercraft;
  SHARED __EE1344690 := __EE1343828(__NN(__EE1343828.Legal_));
  SHARED __ST1345243_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.ndataset(E_Sele_Watercraft(__in,__cfg_Local).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1345243_Layout __ND1345224__Project(E_Sele_Watercraft(__in,__cfg_Local).Layout __PP1345223) := TRANSFORM
    SELF.Ult_I_D__1_ := __PP1345223.Ult_I_D_;
    SELF.Org_I_D__1_ := __PP1345223.Org_I_D_;
    SELF.Sele_I_D__1_ := __PP1345223.Sele_I_D_;
    SELF.Data_Sources__1_ := __PP1345223.Data_Sources_;
    SELF := __PP1345223;
  END;
  SHARED __EE1345259 := PROJECT(__EE1344690,__ND1345224__Project(LEFT));
  SHARED __ST1345267_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
    KEL.typ.nbool Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nbool Is_Corporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Business_Structure_Layout) Business_Structure_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Ownership_Layout) Ownership_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Industry_Layout) Industry_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Company_Statuses_Layout) Company_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Age_Layout) Age_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nbool For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Incorporation_Layout) S_O_S_Incorporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Foreign_Information_Layout) S_O_S_Foreign_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.ndataset(E_Sele_Watercraft(__in,__cfg_Local).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1346897(E_Business_Sele(__in,__cfg_Local).Layout __EE1346893, __ST1345243_Layout __EE1345259) := __EEQP(__EE1346893.UID,__EE1345259.Legal_);
  __ST1345267_Layout __JT1346897(E_Business_Sele(__in,__cfg_Local).Layout __l, __ST1345243_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1347086 := JOIN(__EE1345259,__EE1346893,__JC1346897(RIGHT,LEFT),__JT1346897(RIGHT,LEFT),RIGHT OUTER,HASH);
  SHARED __ST1346015_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1346558 := PROJECT(TABLE(PROJECT(__EE1347086,__ST1346015_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Ult_I_D_,Org_I_D_,Sele_I_D_,W_Craft_},UID,Ult_I_D_,Org_I_D_,Sele_I_D_,W_Craft_,MERGE),__ST1346015_Layout);
  SHARED __EE1344701 := __EE1344690;
  __JC1346768(E_Sele_Watercraft(__in,__cfg_Local).Layout __EE1344701, __ST1345267_Layout __EE1347086) := __EEQP(__EE1347086.UID,__EE1344701.Legal_);
  SHARED __EE1346783 := JOIN(__EE1344701,__EE1347086,__JC1346768(LEFT,RIGHT),TRANSFORM(E_Sele_Watercraft(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __ST1346050_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ndataset(E_Sele_Watercraft(__in,__cfg_Local).Layout) Sele_Watercraft_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1346791(__ST1346015_Layout __EE1346558, E_Sele_Watercraft(__in,__cfg_Local).Layout __EE1346783) := __EEQP(__EE1346558.UID,__EE1346783.Legal_);
  __ST1346050_Layout __Join__ST1346050_Layout(__ST1346015_Layout __r, DATASET(E_Sele_Watercraft(__in,__cfg_Local).Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Sele_Watercraft_ := __CN(__recs);
  END;
  SHARED __EE1346813 := DENORMALIZE(DISTRIBUTE(__EE1346558,HASH(UID)),DISTRIBUTE(__EE1346783,HASH(Legal_)),__JC1346791(LEFT,RIGHT),GROUP,__Join__ST1346050_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST25989_Layout := RECORD
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Watercraft(__in,__cfg_Local).Layout) Sele_Watercraft_;
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST25989_Layout __ND1346822__Project(__ST1346050_Layout __PP1346818) := TRANSFORM
    SELF := __PP1346818;
  END;
  SHARED __ST25989_Layout __ND1346822__Rollup(__ST25989_Layout __r, DATASET(__ST25989_Layout) __recs) := TRANSFORM
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  EXPORT Res0 := __UNWRAP(ROLLUP(GROUP(PROJECT(__EE1346813,__ND1346822__Project(LEFT)),Ult_I_D_,Org_I_D_,Sele_I_D_,W_Craft_,ALL),GROUP,__ND1346822__Rollup(LEFT, ROWS(LEFT))));
END;
