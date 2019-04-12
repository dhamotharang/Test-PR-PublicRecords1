//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_6,CFG_Compile,E_Tradeline,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE46334 := __ENH_Tradeline_6;
  EXPORT __ST39671_Layout := RECORD
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
    KEL.typ.nint Current___A_R___L_N_;
    KEL.typ.nbool Fleet_Segment_;
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nbool Materials_Segment_;
    KEL.typ.nbool Operations_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST39664_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST39671_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39664_Layout __ND46591__Project(B_Tradeline_6(__in,__cfg).__ST39975_Layout __PP46112) := TRANSFORM
    __EE46157 := __PP46112.Records_;
    __ST39671_Layout __ND46554__Project(B_Tradeline_6(__in,__cfg).__ST39982_Layout __PP46476) := TRANSFORM
      SELF.Carrier_Segment_ := __OP2(__PP46476.Segment_I_D_,IN,__CN([1,4,5,6,8]));
      SELF.Current___A_R___L_N_ := IF(__T(__OP2(__PP46476.Current_A_R_,>=,__CN(0))),__ECAST(KEL.typ.nint,__PP46476.Current_A_R_),__ECAST(KEL.typ.nint,__CN(0)));
      SELF.Fleet_Segment_ := __OP2(__PP46476.Segment_I_D_,IN,__CN([2,3,9]));
      SELF.Materials_Segment_ := __OP2(__PP46476.Segment_I_D_,IN,__CN([10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]));
      SELF.Operations_Segment_ := __OP2(__PP46476.Segment_I_D_,IN,__CN([26,27,28,29,30,31,32,33,34,35]));
      SELF.Record_Age_In_Days1_Y_ := IF(__T(__PP46476.Is1_Y_Record_),__ECAST(KEL.typ.nint,FN_Compile.FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP46476.Record_Date_),__ECAST(KEL.typ.nkdate,__CN(KEL.Routines.AdjustCalendar(__cfg.CurrentDate, -1,0,0))))),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
      SELF := __PP46476;
    END;
    SELF.Records_ := __PROJECT(__EE46157,__ND46554__Project(LEFT));
    SELF := __PP46112;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE46334,__ND46591__Project(LEFT));
END;
