//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_7,CFG_Compile,E_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Inquiry_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_7(__in,__cfg).__ENH_Inquiry_7) __ENH_Inquiry_7 := B_Inquiry_7(__in,__cfg).__ENH_Inquiry_7;
  SHARED __EE1094427 := __ENH_Inquiry_7;
  EXPORT __ST176869_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Search_Info_Layout) Search_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Permissions_Layout) Permissions_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Bus_Intel_Layout) Bus_Intel_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Person_Info_Layout) Person_Info_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Business_Info_Layout) Business_Info_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.ndataset(E_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.str Inquiry_Function_Description_ := '';
    KEL.typ.str Inquiry_Industry_ := '';
    KEL.typ.str Inquiry_Method_ := '';
    KEL.typ.nint Inquiry_Product_Code_;
    KEL.typ.str Inquiry_Sub_Market_ := '';
    KEL.typ.str Inquiry_Vertical_ := '';
    KEL.typ.bool Is_Length_Sub_Market_ := FALSE;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST176869_Layout __ND1094284__Project(B_Inquiry_7(__in,__cfg).__ST173836_Layout __PP1093890) := TRANSFORM
    __EE1094277 := __PP1093890.Search_Info_;
    SELF.Inquiry_Function_Description_ := __DEFAULT((__T(__EE1094277))[1].Function_Description_,'');
    __EE1094294 := __PP1093890.Bus_Intel_;
    SELF.Inquiry_Industry_ := __DEFAULT((__T(__EE1094294))[1].Industry_,'');
    __EE1094310 := __PP1093890.Search_Info_;
    SELF.Inquiry_Method_ := __DEFAULT((__T(__EE1094310))[1].Method_,'');
    __EE1094326 := __PP1093890.Search_Info_;
    SELF.Inquiry_Product_Code_ := (__T(__EE1094326))[1].Product_Code_;
    __EE1094342 := __PP1093890.Bus_Intel_;
    SELF.Inquiry_Vertical_ := __DEFAULT((__T(__EE1094342))[1].Vertical_,'');
    SELF.Is_Length_Sub_Market_ := KEL.Routines.StartsWith(KEL.Routines.ToUpperCase(TRIM(__PP1093890.Inquiry_Sub_Market_)),'FIRST PARTY');
    SELF := __PP1093890;
  END;
  EXPORT __ENH_Inquiry_6 := PROJECT(__EE1094427,__ND1094284__Project(LEFT));
END;
