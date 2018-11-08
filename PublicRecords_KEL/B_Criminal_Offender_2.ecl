//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Criminal_Offender_3,CFG_Compile,E_Criminal_Offender,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Criminal_Offender_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Criminal_Offender_3(__in,__cfg).__ENH_Criminal_Offender_3) __ENH_Criminal_Offender_3 := B_Criminal_Offender_3(__in,__cfg).__ENH_Criminal_Offender_3;
  SHARED __EE22213 := __ENH_Criminal_Offender_3;
  EXPORT __ST17228_Layout := RECORD
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
  EXPORT __ST17224_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(__ST17228_Layout) Sources_;
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
  SHARED __ST17224_Layout __ND22431__Project(B_Criminal_Offender_3(__in,__cfg).__ST17779_Layout __PP22036) := TRANSFORM
    __EE22091 := __PP22036.Sources_;
    __ST17228_Layout __ND22422__Project(B_Criminal_Offender_3(__in,__cfg).__ST17783_Layout __PP22310) := TRANSFORM
      SELF.Arrest_Age_In_Days_ := FN_Compile.FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP22310.Criminal_Date_Arrest_),__ECAST(KEL.typ.nkdate,__PP22036.Current_Date_));
      SELF.Is_Arrest_ := __OP2(__PP22310.Data_Type_,=,__CN(5));
      SELF := __PP22310;
    END;
    SELF.Sources_ := __PROJECT(__EE22091,__ND22422__Project(LEFT));
    SELF := __PP22036;
  END;
  EXPORT __ENH_Criminal_Offender_2 := PROJECT(__EE22213,__ND22431__Project(LEFT));
END;
