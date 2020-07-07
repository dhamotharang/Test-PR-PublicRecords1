//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Person,E_Zip_Code,E_Zip_Code_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Zip_Code_Person(KEL.typ.uid __PZip5_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Zip_Code_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PZip5_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Zip_Code_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Zip_Code_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Zip_Code_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Zip_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Zip_Code_Filtered := E_Zip_Code_Filtered_1;
  SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Zip_Code_Person(__in,__cfg_Local).__Result) __E_Zip_Code_Person := E_Zip_Code_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE45051 := __E_Zip_Code;
  SHARED __EE45325 := __EE45051(__T(__OP2(__EE45051.UID,=,__CN(__PZip5_in))));
  SHARED __EE44868 := __E_Zip_Code_Person;
  SHARED __EE45233 := __EE44868(__NN(__EE44868.Zip_));
  __JC45248(E_Zip_Code_Person(__in,__cfg_Local).Layout __EE45233, E_Zip_Code(__in,__cfg_Local).Layout __EE45325) := __EEQP(__EE45325.UID,__EE45233.Zip_);
  SHARED __EE45256 := JOIN(__EE45233,__EE45325,__JC45248(LEFT,RIGHT),TRANSFORM(E_Zip_Code_Person(__in,__cfg_Local).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __ST44990_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Zip_Class_;
    KEL.typ.nstr City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr City_Name_;
    KEL.typ.ndataset(E_Zip_Code(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Zip_Code_Person(__in,__cfg_Local).Layout) Zip_Code_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC45264(E_Zip_Code(__in,__cfg_Local).Layout __EE45325, E_Zip_Code_Person(__in,__cfg_Local).Layout __EE45256) := __EEQP(__EE45325.UID,__EE45256.Zip_);
  __ST44990_Layout __Join__ST44990_Layout(E_Zip_Code(__in,__cfg_Local).Layout __r, DATASET(E_Zip_Code_Person(__in,__cfg_Local).Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Zip_Code_Person_ := __CN(__recs);
  END;
  SHARED __EE45283 := DENORMALIZE(DISTRIBUTE(__EE45325,HASH(UID)),DISTRIBUTE(__EE45256,HASH(Zip_)),__JC45264(LEFT,RIGHT),GROUP,__Join__ST44990_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST26658_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(E_Zip_Code_Person(__in,__cfg_Local).Layout) Zip_Code_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST26658_Layout __ND45292__Project(__ST44990_Layout __PP45288) := TRANSFORM
    SELF := __PP45288;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE45283,__ND45292__Project(LEFT)));
END;
