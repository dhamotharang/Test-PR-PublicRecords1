﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Tradeline_9,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Tradeline_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9;
  SHARED __EE96756 := __ENH_Tradeline_9;
  EXPORT __ST94917_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST94910_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST94917_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST94910_Layout __ND96987__Project(B_Tradeline_9(__in,__cfg).__ST94996_Layout __PP96531) := TRANSFORM
    __EE96584 := __PP96531.Records_;
    __ST94917_Layout __ND96957__Project(B_Tradeline_9(__in,__cfg).__ST95003_Layout __PP96760) := TRANSFORM
      SELF.Carrier_Segment_ := __OP2(__PP96760.Segment_I_D_,IN,__CN([1,4,5,6,8]));
      SELF.Fleet_Segment_ := __OP2(__PP96760.Segment_I_D_,IN,__CN([2,3,9]));
      __CC17669 := 365;
      SELF.Is1_Y_Record_ := __OP2(__PP96760.Record_Age_In_Days_,>=,__CN(__CC17669));
      SELF.Materials_Segment_ := __OP2(__PP96760.Segment_I_D_,IN,__CN([10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]));
      SELF.Operations_Segment_ := __OP2(__PP96760.Segment_I_D_,IN,__CN([26,27,28,29,30,31,32,33,34,35]));
      SELF := __PP96760;
    END;
    SELF.Records_ := __PROJECT(__EE96584,__ND96957__Project(LEFT));
    SELF.Two_Year_Full_Date_ := __FN4(KEL.Routines.AdjustCalendar,__PP96531.Current_Date_First_Of_Month_,__CN(-2),__CN(0),__CN(0));
    SELF := __PP96531;
  END;
  EXPORT __ENH_Tradeline_8 := PROJECT(__EE96756,__ND96987__Project(LEFT));
END;
