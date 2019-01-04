//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Criminal_Offender_2,CFG_Compile,E_Criminal_Offender FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Criminal_Offender_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Criminal_Offender_2(__in,__cfg).__ENH_Criminal_Offender_2) __ENH_Criminal_Offender_2 := B_Criminal_Offender_2(__in,__cfg).__ENH_Criminal_Offender_2;
  SHARED __EE33904 := __ENH_Criminal_Offender_2;
  EXPORT __ST16056_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nint Arrest_Age_In_Days_;
    KEL.typ.nkdate Criminal_Date_Arrest_;
    KEL.typ.nbool Is_Arrest_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST16052_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(__ST16056_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Current_Status_Layout) Current_Status_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Number_Of_Offense_Counts_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST16052_Layout __ND34070__Project(B_Criminal_Offender_2(__in,__cfg).__ST17224_Layout __PP33736) := TRANSFORM
    __EE33789 := __PP33736.Sources_;
    SELF.Sources_ := __BN(PROJECT(__T(__EE33789),__ST16056_Layout),__NL(__EE33789));
    SELF := __PP33736;
  END;
  EXPORT __ENH_Criminal_Offender_1 := PROJECT(__EE33904,__ND34070__Project(LEFT));
END;
