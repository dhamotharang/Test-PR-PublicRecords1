//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_11,CFG_Compile,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_11(__in,__cfg).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11(__in,__cfg).__ENH_Inquiry_11;
  SHARED __EE5240296 := __ENH_Inquiry_11;
  EXPORT __ST263692_Layout := RECORD
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
  SHARED __ST263692_Layout __ND5240169__Project(B_Inquiry_11(__in,__cfg).__ST264579_Layout __PP5239797) := TRANSFORM
    __EE5240162 := __PP5239797.Search_Info_;
    SELF.Inquiry_Function_Description_ := __DEFAULT((__T(__EE5240162))[1].Function_Description_,'');
    __EE5240179 := __PP5239797.Bus_Intel_;
    SELF.Inquiry_Industry_ := __DEFAULT((__T(__EE5240179))[1].Industry_,'');
    __EE5240195 := __PP5239797.Search_Info_;
    SELF.Inquiry_Method_ := __DEFAULT((__T(__EE5240195))[1].Method_,'');
    __EE5240213 := __PP5239797.Bus_Intel_;
    SELF.Inquiry_Vertical_ := __DEFAULT((__T(__EE5240213))[1].Vertical_,'');
    SELF.Is_Length_Sub_Market_ := KEL.Routines.StartsWith(KEL.Routines.ToUpperCase(TRIM(__PP5239797.Inquiry_Sub_Market_)),'FIRST PARTY');
    SELF := __PP5239797;
  END;
  EXPORT __ENH_Inquiry_10 := PROJECT(__EE5240296,__ND5240169__Project(LEFT));
END;
