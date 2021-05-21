//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_3,CFG_Compile,E_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Inquiry_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_3(__in,__cfg).__ENH_Inquiry_3) __ENH_Inquiry_3 := B_Inquiry_3(__in,__cfg).__ENH_Inquiry_3;
  SHARED __EE2010348 := __ENH_Inquiry_3;
  EXPORT __ST160274_Layout := RECORD
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nstr Appended_S_S_N_;
    KEL.typ.nint Personal_Phone_Number_;
    KEL.typ.nint Work_Phone_Number_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST160247_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Search_Info_Layout) Search_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Permissions_Layout) Permissions_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Bus_Intel_Layout) Bus_Intel_;
    KEL.typ.ndataset(__ST160274_Layout) Person_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Business_Info_Layout) Business_Info_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Is_Valid_Velocity_Inquiry_Non_F_C_R_A_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST160247_Layout __ND2010353__Project(B_Inquiry_3(__in,__cfg).__ST184470_Layout __PP2010349) := TRANSFORM
    __EE2010410 := __PP2010349.Person_Info_;
    SELF.Person_Info_ := __BN(PROJECT(__T(__EE2010410),__ST160274_Layout),__NL(__EE2010410));
    SELF := __PP2010349;
  END;
  EXPORT __ENH_Inquiry_2 := PROJECT(__EE2010348,__ND2010353__Project(LEFT));
END;
