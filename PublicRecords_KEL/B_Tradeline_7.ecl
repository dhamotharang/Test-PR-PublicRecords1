//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_8,CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8;
  SHARED __EE42084 := __ENH_Tradeline_8;
  EXPORT __ST40133_Layout := RECORD
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST40126_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST40133_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST40126_Layout __ND42256__Project(B_Tradeline_8(__in,__cfg).__ST40192_Layout __PP41907) := TRANSFORM
    __EE41952 := __PP41907.Records_;
    __ST40133_Layout __ND42205__Project(B_Tradeline_8(__in,__cfg).__ST40199_Layout __PP42204) := TRANSFORM
      SELF.Record_Age_In_Days_ := FN_Compile.FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP42204.Record_Date_),__ECAST(KEL.typ.nkdate,__PP41907.Current_Date_));
      SELF := __PP42204;
    END;
    SELF.Records_ := __PROJECT(__EE41952,__ND42205__Project(LEFT));
    SELF := __PP41907;
  END;
  EXPORT __ENH_Tradeline_7 := PROJECT(__EE42084,__ND42256__Project(LEFT));
END;
