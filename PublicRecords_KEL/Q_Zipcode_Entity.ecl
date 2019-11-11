//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Zipcode_Entity(KEL.typ.uid __PZip5_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Zip_Code_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PZip5_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE44799 := __E_Zip_Code;
  SHARED __EE44811 := __EE44799(__T(__OP2(__EE44799.UID,=,__CN(__PZip5_in))));
  EXPORT Res0 := __UNWRAP(__EE44811);
END;
