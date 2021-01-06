﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Tradeline_9,CFG_Compile,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Tradeline_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9;
  SHARED __EE382703 := __ENH_Tradeline_9;
  EXPORT __ST135503_Layout := RECORD
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
    KEL.typ.nbool Carrier_Segment_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST135496_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST135503_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST135496_Layout __ND382892__Project(B_Tradeline_9(__in,__cfg).__ST135577_Layout __PP382704) := TRANSFORM
    __EE382737 := __PP382704.Records_;
    __ST135503_Layout __ND382862__Project(B_Tradeline_9(__in,__cfg).__ST135584_Layout __PP382738) := TRANSFORM
      SELF.Carrier_Segment_ := __OP2(__PP382738.Segment_I_D_,IN,__CN([1,4,5,6,8]));
      SELF.Fleet_Segment_ := __OP2(__PP382738.Segment_I_D_,IN,__CN([2,3,9]));
      __CC39974 := 365;
      SELF.Is1_Y_Record_ := __OP2(__PP382738.Record_Age_In_Days_,>=,__CN(__CC39974));
      SELF.Materials_Segment_ := __OP2(__PP382738.Segment_I_D_,IN,__CN([10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]));
      SELF.Operations_Segment_ := __OP2(__PP382738.Segment_I_D_,IN,__CN([26,27,28,29,30,31,32,33,34,35]));
      SELF := __PP382738;
    END;
    SELF.Records_ := __PROJECT(__EE382737,__ND382862__Project(LEFT));
    SELF.Two_Year_Full_Date_ := __FN4(KEL.Routines.AdjustCalendar,__PP382704.Current_Date_First_Of_Month_,__CN(-2),__CN(0),__CN(0));
    SELF := __PP382704;
  END;
  EXPORT __ENH_Tradeline_8 := PROJECT(__EE382703,__ND382892__Project(LEFT));
END;
