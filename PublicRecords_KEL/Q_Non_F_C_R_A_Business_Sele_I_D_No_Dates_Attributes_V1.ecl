//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Business,B_Business_1,B_Business_2,B_Business_3,B_Business_4,B_Business_5,B_Business_6,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_Tradeline_Business_1,B_Tradeline_Business_2,B_Tradeline_Business_3,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Business_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Tradeline_Business_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline_Business(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Company_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Tradeline_Business_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Filtered := E_Business_Filtered_2;
  SHARED E_Tradeline_Business_Filtered := E_Tradeline_Business_Filtered_1;
  SHARED B_Tradeline_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_11(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_10(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_11(__in,__cfg).__ENH_Tradeline_11) __ENH_Tradeline_11 := B_Tradeline_11_Local(__in,__cfg).__ENH_Tradeline_11;
  END;
  SHARED B_Tradeline_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_9(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local(__in,__cfg).__ENH_Tradeline_10;
  END;
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local(__in,__cfg).__ENH_Tradeline_9;
  END;
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_Business_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_6(__in,__cfg))
    SHARED TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Business_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_5(__in,__cfg))
    SHARED TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6_Local(__in,__cfg).__ENH_Business_6;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_Business_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_4(__in,__cfg))
    SHARED TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5_Local(__in,__cfg).__ENH_Business_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Business_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_3(__in,__cfg))
    SHARED TYPEOF(B_Business_4(__in,__cfg).__ENH_Business_4) __ENH_Business_4 := B_Business_4_Local(__in,__cfg).__ENH_Business_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Tradeline_Business_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_2(__in,__cfg))
    SHARED TYPEOF(B_Business_3(__in,__cfg).__ENH_Business_3) __ENH_Business_3 := B_Business_3_Local(__in,__cfg).__ENH_Business_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
    SHARED TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3_Local(__in,__cfg).__ENH_Tradeline_Business_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Tradeline_Business_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3_Local(__in,__cfg).__ENH_Tradeline_Business_3;
  END;
  SHARED B_Business_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_1(__in,__cfg))
    SHARED TYPEOF(B_Business_2(__in,__cfg).__ENH_Business_2) __ENH_Business_2 := B_Business_2_Local(__in,__cfg).__ENH_Business_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
    SHARED TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2_Local(__in,__cfg).__ENH_Tradeline_Business_2;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Tradeline_Business_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2_Local(__in,__cfg).__ENH_Tradeline_Business_2;
  END;
  SHARED B_Business_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business(__in,__cfg))
    SHARED TYPEOF(B_Business_1(__in,__cfg).__ENH_Business_1) __ENH_Business_1 := B_Business_1_Local(__in,__cfg).__ENH_Business_1;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
    SHARED TYPEOF(B_Tradeline_Business_1(__in,__cfg).__ENH_Tradeline_Business_1) __ENH_Tradeline_Business_1 := B_Tradeline_Business_1_Local(__in,__cfg).__ENH_Tradeline_Business_1;
  END;
  SHARED TYPEOF(B_Business(__in).__ENH_Business) __ENH_Business := B_Business_Local(__in).__ENH_Business;
  SHARED __EE818672 := __ENH_Business;
  SHARED __EE818769 := __EE818672(__T(__AND(__OP2(__EE818672.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE818672.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE818672.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST32257_Layout := RECORD
    KEL.typ.nint Lex_I_D_Bus_Extended_Family_Append_;
    KEL.typ.nint Lex_I_D_Bus_Legal_Family_Append_;
    KEL.typ.nint Lex_I_D_Bus_Legal_Entity_Append_;
    KEL.typ.str Lex_I_D_Bus_Legal_Entity_Restricted_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32257_Layout __ND818774__Project(B_Business(__in).__ST41142_Layout __PP818770) := TRANSFORM
    SELF.Lex_I_D_Bus_Extended_Family_Append_ := __PP818770.Ult_I_D_;
    SELF.Lex_I_D_Bus_Legal_Family_Append_ := __PP818770.Org_I_D_;
    SELF.Lex_I_D_Bus_Legal_Entity_Append_ := __PP818770.Sele_I_D_;
    SELF := __PP818770;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE818769,__ND818774__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Lex_I_D_Bus_Extended_Family_Append_,Lex_I_D_Bus_Legal_Family_Append_,Lex_I_D_Bus_Legal_Entity_Append_,Lex_I_D_Bus_Legal_Entity_Restricted_},Lex_I_D_Bus_Extended_Family_Append_,Lex_I_D_Bus_Legal_Family_Append_,Lex_I_D_Bus_Legal_Entity_Append_,Lex_I_D_Bus_Legal_Entity_Restricted_,MERGE),__ST32257_Layout));
END;
