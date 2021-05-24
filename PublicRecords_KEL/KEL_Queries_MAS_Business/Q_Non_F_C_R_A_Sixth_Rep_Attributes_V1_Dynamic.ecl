//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT Q_Non_F_C_R_A_Sixth_Rep_Attributes_V1_Dynamic(KEL.typ.uid __PLexID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
  SHARED __EE1870363 := __E_Person;
  SHARED __EE3682886 := __EE1870363(__T(__OP2(__EE1870363.UID,=,__CN(__PLexID_in))));
  SHARED __ST109901_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE3682886,TRANSFORM(__ST109901_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Filtered.__Result);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Non_F_C_R_A_Sixth_Rep_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
