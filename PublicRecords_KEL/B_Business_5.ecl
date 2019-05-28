//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Business_6,CFG_Compile,E_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Business_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED __EE83950 := __ENH_Business_6;
  EXPORT __ST70427_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(E_Business(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.int B2b_T_L_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Carr_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Carr_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Flt_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Flt_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Mat_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Mat_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Ops_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Ops_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.int B2b_T_L_In_Oth_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Oth_Cnt24_Mfull_No_Cap_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST70427_Layout __ND84034__Project(B_Business_6(__in,__cfg).__ST71241_Layout __PP83802) := TRANSFORM
    SELF.B2b_T_L_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_Cnt24_Mfull_No_Cap_,0,999);
    SELF.B2b_T_L_In_Carr_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_In_Carr_Cnt24_Mfull_No_Cap_,0,999);
    SELF.B2b_T_L_In_Flt_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_In_Flt_Cnt24_Mfull_No_Cap_,0,999);
    SELF.B2b_T_L_In_Mat_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_In_Mat_Cnt24_Mfull_No_Cap_,0,999);
    SELF.B2b_T_L_In_Ops_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_In_Ops_Cnt24_Mfull_No_Cap_,0,999);
    SELF.B2b_T_L_In_Oth_Cnt24_Mfull_ := KEL.Routines.BoundsFold(__PP83802.B2b_T_L_In_Oth_Cnt24_Mfull_No_Cap_,0,999);
    SELF := __PP83802;
  END;
  EXPORT __ENH_Business_5 := PROJECT(__EE83950,__ND84034__Project(LEFT));
END;
