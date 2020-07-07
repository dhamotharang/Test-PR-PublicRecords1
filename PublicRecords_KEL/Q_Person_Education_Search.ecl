//HPCC Systems KEL Compiler Version 1.0.1
IMPORT KEL10 AS KEL;
IMPORT CFG_Compile,E_Education,E_Person,E_Person_Education FROM PublicRecords_KEL;
IMPORT * FROM KEL10.Null;
EXPORT Q_Person_Education_Search(KEL.typ.uid __PLexid_in, KEL.typ.kdate __PArchiveDate, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PLexid_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Education_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Education(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_1;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE11770 := __E_Person;
  SHARED __EE12262 := __EE11770(__T(__OP2(__EE11770.UID,=,__CN(__PLexid_in))));
  SHARED __EE11427 := __E_Person_Education;
  SHARED __EE12104 := __EE11427(__NN(__EE11427.Subject_));
  __JC12119(E_Person_Education(__in,__cfg_Local).Layout __EE12104, E_Person(__in,__cfg_Local).Layout __EE12262) := __EEQP(__EE12262.UID,__EE12104.Subject_);
  SHARED __EE12137 := JOIN(__EE12104,__EE12262,__JC12119(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __ST11639_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg_Local).Layout) Person_Education_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC12145(E_Person(__in,__cfg_Local).Layout __EE12262, E_Person_Education(__in,__cfg_Local).Layout __EE12137) := __EEQP(__EE12262.UID,__EE12137.Subject_);
  __ST11639_Layout __Join__ST11639_Layout(E_Person(__in,__cfg_Local).Layout __r, DATASET(E_Person_Education(__in,__cfg_Local).Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Education_ := __CN(__recs);
  END;
  SHARED __EE12200 := DENORMALIZE(DISTRIBUTE(__EE12262,HASH(UID)),DISTRIBUTE(__EE12137,HASH(Subject_)),__JC12145(LEFT,RIGHT),GROUP,__Join__ST11639_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST7300_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg_Local).Layout) Person_Education_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST7300_Layout __ND12209__Project(__ST11639_Layout __PP12205) := TRANSFORM
    SELF := __PP12205;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE12200,__ND12209__Project(LEFT)));
END;
