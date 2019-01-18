//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Criminal_Offender,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Criminal_Offender_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Criminal_Offender(__in,__cfg).__Result) __E_Criminal_Offender := E_Criminal_Offender(__in,__cfg).__Result;
  SHARED __EE20179 := __E_Criminal_Offender;
  EXPORT __ST17783_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nkdate Criminal_Date_Arrest_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST17779_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(__ST17783_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Current_Status_Layout) Current_Status_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Number_Of_Offense_Counts_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST17779_Layout __ND20370__Project(E_Criminal_Offender(__in,__cfg).Layout __PP20017) := TRANSFORM
    __EE20072 := __PP20017.Sources_;
    __ST17783_Layout __ND20259__Project(E_Criminal_Offender(__in,__cfg).Sources_Layout __PP20258) := TRANSFORM
      SELF.Criminal_Date_Arrest_ := KEL.era.ToDate(__PP20258.Date_First_Seen_);
      SELF := __PP20258;
    END;
    SELF.Sources_ := __PROJECT(__EE20072,__ND20259__Project(LEFT));
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('doc_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP20017;
  END;
  EXPORT __ENH_Criminal_Offender_3 := PROJECT(__EE20179,__ND20370__Project(LEFT));
END;
