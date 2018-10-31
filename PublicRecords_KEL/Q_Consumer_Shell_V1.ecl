//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Criminal_Offense_1,B_Criminal_Offense_2,B_First_Degree_Relative_1,B_Person,B_Person_1,B_Person_2,CFG_Compile,E_Bankruptcy,E_Criminal_Offense,E_First_Degree_Associations,E_First_Degree_Relative,E_Person,E_Person_Bankruptcy,E_Person_Offenses FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Consumer_Shell_V1(KEL.typ.uid __PLexID, KEL.typ.kdate __PArchiveDate, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED E_First_Degree_Associations_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Associations(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SimpleFilter(DATASET(InLayout) __ds) := __ds(__T(__OP2(__ds.Title_,>=,__CN(1))) AND __T(__OP2(__ds.Title_,<=,__CN(45))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __SimpleFilter(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_First_Degree_Relative(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED E_Person_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED E_Person_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED E_Person_Offenses_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __AsofFitler(__ds);
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Bankruptcy_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_First_Degree_Relative_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_First_Degree_Relative_1(__in,__cfg))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_First_Degree_Relative(__in,__cfg).__Result) __E_First_Degree_Relative := E_First_Degree_Relative_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_First_Degree_Relative_1(__in,__cfg).__ENH_First_Degree_Relative_1) __ENH_First_Degree_Relative_1 := B_First_Degree_Relative_1_Local(__in,__cfg).__ENH_First_Degree_Relative_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED __EE110483 := __ENH_Person;
  SHARED __EE110858 := __EE110483(__T(__OP2(__EE110483.UID,=,__CN(__PLexID))));
  SHARED __ST6163_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.int Bankruptcy_Count_In_Last1_Month_ := 0;
    KEL.typ.int Bankruptcy_Count_In_Last3_Months_ := 0;
    KEL.typ.int Bankruptcy_Count_In_Last6_Months_ := 0;
    KEL.typ.int Bankruptcy_Count_In_Last1_Year_ := 0;
    KEL.typ.int Bankruptcy_Count_In_Last2_Years_ := 0;
    KEL.typ.int Bankruptcy_Count_In_Last5_Years_ := 0;
    KEL.typ.int Bankruptcy_Count_ := 0;
    KEL.typ.nkdate Last_Bankruptcy_Date_;
    KEL.typ.nstr Bankruptcy_Filing_Type_;
    KEL.typ.nstr Bankruptcy_Disposition_;
    KEL.typ.nint Bankruptcy_Age_;
    KEL.typ.int Felony_Count_In_Last1_Month_ := 0;
    KEL.typ.int Felony_Count_In_Last3_Months_ := 0;
    KEL.typ.int Felony_Count_In_Last6_Months_ := 0;
    KEL.typ.int Felony_Count_In_Last1_Year_ := 0;
    KEL.typ.int Felony_Count_In_Last2_Years_ := 0;
    KEL.typ.int Felony_Count_In_Last5_Years_ := 0;
    KEL.typ.int Felony_Count_ := 0;
    KEL.typ.nkdate First_Deceased_Date_;
    KEL.typ.int Suspect_First_Degree_Relatives_And_Associates_Count_ := 0;
    KEL.typ.int Suspect_First_Degree_Relatives_And_Associates_Bankruptcy_Count_ := 0;
    KEL.typ.int Suspect_First_Degree_Relatives_And_Associates_Felony_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST6163_Layout __ND110863__Project(B_Person(__in,__cfg_Local).__ST11902_Layout __PP110859) := TRANSFORM
    SELF.Lex_I_D_ := __PP110859.UID;
    SELF.Bankruptcy_Count_In_Last1_Month_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last1_Month_, -1,255);
    SELF.Bankruptcy_Count_In_Last3_Months_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last3_Months_, -1,255);
    SELF.Bankruptcy_Count_In_Last6_Months_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last6_Months_, -1,255);
    SELF.Bankruptcy_Count_In_Last1_Year_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last1_Year_, -1,255);
    SELF.Bankruptcy_Count_In_Last2_Years_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last2_Years_, -1,255);
    SELF.Bankruptcy_Count_In_Last5_Years_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_In_Last5_Years_, -1,255);
    SELF.Bankruptcy_Count_ := KEL.Routines.BoundsFold(__PP110859.Bankruptcy_Count_, -1,255);
    SELF.Felony_Count_In_Last1_Month_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last1_Month_, -1,255);
    SELF.Felony_Count_In_Last3_Months_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last3_Months_, -1,255);
    SELF.Felony_Count_In_Last6_Months_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last6_Months_, -1,255);
    SELF.Felony_Count_In_Last1_Year_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last1_Year_, -1,255);
    SELF.Felony_Count_In_Last2_Years_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last2_Years_, -1,255);
    SELF.Felony_Count_In_Last5_Years_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_In_Last5_Years_, -1,255);
    SELF.Felony_Count_ := KEL.Routines.BoundsFold(__PP110859.Felony_Count_, -1,255);
    SELF := __PP110859;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE110858,__ND110863__Project(LEFT)));
END;
