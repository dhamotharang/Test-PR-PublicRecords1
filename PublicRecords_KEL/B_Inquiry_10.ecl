//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_11,CFG_Compile,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_11(__in,__cfg).__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11(__in,__cfg).__ENH_Inquiry_11;
  SHARED __EE4787174 := __ENH_Inquiry_11;
  EXPORT __ST255272_Layout := RECORD
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
  SHARED __ST255272_Layout __ND4787047__Project(B_Inquiry_11(__in,__cfg).__ST256158_Layout __PP4786675) := TRANSFORM
    __EE4787040 := __PP4786675.Search_Info_;
    SELF.Inquiry_Function_Description_ := __DEFAULT((__T(__EE4787040))[1].Function_Description_,'');
    __EE4787057 := __PP4786675.Bus_Intel_;
    SELF.Inquiry_Industry_ := __DEFAULT((__T(__EE4787057))[1].Industry_,'');
    __EE4787073 := __PP4786675.Search_Info_;
    SELF.Inquiry_Method_ := __DEFAULT((__T(__EE4787073))[1].Method_,'');
    __EE4787091 := __PP4786675.Bus_Intel_;
    SELF.Inquiry_Vertical_ := __DEFAULT((__T(__EE4787091))[1].Vertical_,'');
    SELF.Is_Length_Sub_Market_ := KEL.Routines.StartsWith(KEL.Routines.ToUpperCase(TRIM(__PP4786675.Inquiry_Sub_Market_)),'FIRST PARTY');
    SELF := __PP4786675;
  END;
  EXPORT __ENH_Inquiry_10 := PROJECT(__EE4787174,__ND4787047__Project(LEFT));
END;
