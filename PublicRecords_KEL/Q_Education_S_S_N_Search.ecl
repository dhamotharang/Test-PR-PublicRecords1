//HPCC Systems KEL Compiler Version 1.0.1
IMPORT KEL10 AS KEL;
IMPORT CFG_Compile,E_Education,E_Education_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL10.Null;
EXPORT Q_Education_S_S_N_Search(KEL.typ.uid __PSSN_in, KEL.typ.kdate __PArchiveDate, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Social_Security_Number_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PSSN_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Education_S_S_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Education_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Social_Security_Number_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Social_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered := E_Social_Security_Number_Filtered_1;
  SHARED TYPEOF(E_Education_S_S_N(__in,__cfg_Local).__Result) __E_Education_S_S_N := E_Education_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE12727 := __E_Social_Security_Number;
  SHARED __EE12996 := __EE12727(__T(__OP2(__EE12727.UID,=,__CN(__PSSN_in))));
  SHARED __EE12546 := __E_Education_S_S_N;
  SHARED __EE12905 := __EE12546(__NN(__EE12546.Social_));
  __JC12920(E_Education_S_S_N(__in,__cfg_Local).Layout __EE12905, E_Social_Security_Number(__in,__cfg_Local).Layout __EE12996) := __EEQP(__EE12996.UID,__EE12905.Social_);
  SHARED __EE12927 := JOIN(__EE12905,__EE12996,__JC12920(LEFT,RIGHT),TRANSFORM(E_Education_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __ST12666_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nkdate Official_First_Seen_;
    KEL.typ.nkdate Official_Last_Seen_;
    KEL.typ.nstr Issue_State_;
    KEL.typ.nkdate Header_First_Seen_;
    KEL.typ.ndataset(E_Social_Security_Number(__in,__cfg_Local).Dates_Of_Death_Layout) Dates_Of_Death_;
    KEL.typ.ndataset(E_Social_Security_Number(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Education_S_S_N(__in,__cfg_Local).Layout) Education_S_S_N_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC12935(E_Social_Security_Number(__in,__cfg_Local).Layout __EE12996, E_Education_S_S_N(__in,__cfg_Local).Layout __EE12927) := __EEQP(__EE12996.UID,__EE12927.Social_);
  __ST12666_Layout __Join__ST12666_Layout(E_Social_Security_Number(__in,__cfg_Local).Layout __r, DATASET(E_Education_S_S_N(__in,__cfg_Local).Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Education_S_S_N_ := __CN(__recs);
  END;
  SHARED __EE12956 := DENORMALIZE(DISTRIBUTE(__EE12996,HASH(UID)),DISTRIBUTE(__EE12927,HASH(Social_)),__JC12935(LEFT,RIGHT),GROUP,__Join__ST12666_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST7373_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(E_Education_S_S_N(__in,__cfg_Local).Layout) Education_S_S_N_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST7373_Layout __ND12965__Project(__ST12666_Layout __PP12961) := TRANSFORM
    SELF := __PP12961;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE12956,__ND12965__Project(LEFT)));
END;
