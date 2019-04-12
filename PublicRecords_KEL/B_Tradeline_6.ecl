//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_7,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7;
  SHARED __EE43808 := __ENH_Tradeline_7;
  EXPORT __ST39982_Layout := RECORD
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
    KEL.typ.nbool Is1_Y_Record_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST39975_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST39982_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39975_Layout __ND44005__Project(B_Tradeline_7(__in,__cfg).__ST40126_Layout __PP43628) := TRANSFORM
    __EE43673 := __PP43628.Records_;
    __ST39982_Layout __ND43987__Project(B_Tradeline_7(__in,__cfg).__ST40133_Layout __PP43915) := TRANSFORM
      __CC10531 := 365;
      SELF.Is1_Y_Record_ := __OP2(__PP43915.Record_Age_In_Days_,>=,__CN(__CC10531));
      SELF := __PP43915;
    END;
    SELF.Records_ := __PROJECT(__EE43673,__ND43987__Project(LEFT));
    SELF := __PP43628;
  END;
  EXPORT __ENH_Tradeline_6 := PROJECT(__EE43808,__ND44005__Project(LEFT));
END;
