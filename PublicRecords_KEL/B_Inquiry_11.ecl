﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Inquiry_11(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Inquiry(__in,__cfg).__Result) __E_Inquiry := E_Inquiry(__in,__cfg).__Result;
  SHARED __EE4615297 := __E_Inquiry;
  EXPORT __ST260097_Layout := RECORD
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
    KEL.typ.str Inquiry_Sub_Market_ := '';
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST260097_Layout __ND4615231__Project(E_Inquiry(__in,__cfg).Layout __PP295681) := TRANSFORM
    __EE4615224 := __PP295681.Bus_Intel_;
    SELF.Inquiry_Sub_Market_ := __DEFAULT((__T(__EE4615224))[1].Sub_Market_,'');
    SELF := __PP295681;
  END;
  EXPORT __ENH_Inquiry_11 := PROJECT(__EE4615297,__ND4615231__Project(LEFT));
END;
