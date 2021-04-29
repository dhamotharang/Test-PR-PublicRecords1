﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Bankruptcy_7,B_Bankruptcy_9,CFG_Compile,E_Bankruptcy FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Bankruptcy_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7;
  SHARED __EE3929167 := __ENH_Bankruptcy_7;
  EXPORT __ST291065_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko1_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST192638_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_9(__in,__cfg).__ST196963_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST291065_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST192638_Layout __ND3929124__Project(B_Bankruptcy_7(__in,__cfg).__ST194463_Layout __PP3928797) := TRANSFORM
    __EE3929122 := __PP3928797.Best_Child_Record_;
    __ST291065_Layout __ND3929055__Project(B_Bankruptcy_7(__in,__cfg).__ST275336_Layout __PP3928855) := TRANSFORM
      __CC29639 := 365;
      SELF.Banko1_Year_ := __AND(__AND(__PP3928855.Is_Bankruptcy_,__OP2(__PP3928855.Filing_Age_In_Days_,<=,__CN(__CC29639))),__NOT(__NT(__PP3928855.Filing_Age_In_Days_)));
      SELF.Bankruptcy_Date_ := KEL.era.ToDate(__PP3928797.Date_First_Seen_);
      SELF := __PP3928855;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE3929122,__ND3929055__Project(LEFT));
    SELF := __PP3928797;
  END;
  EXPORT __ENH_Bankruptcy_6 := PROJECT(__EE3929167,__ND3929124__Project(LEFT));
END;
