//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Tradeline_5,CFG_Compile,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Tradeline_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5;
  SHARED __EE51361 := __ENH_Tradeline_5;
  EXPORT __ST39102_Layout := RECORD
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
    KEL.typ.nbool Other_Segment_;
    KEL.typ.nint Record_Age_In_Days_;
    KEL.typ.nint Record_Age_In_Days1_Y_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nint Total___A_R___L_N_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST39095_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(__ST39102_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nint Newest_Record_Age_In_Days_;
    KEL.typ.nint Newest_Record_Age_In_Days1_Y_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39095_Layout __ND51621__Project(B_Tradeline_5(__in,__cfg).__ST39664_Layout __PP51056) := TRANSFORM
    __EE51105 := __PP51056.Records_;
    __ST39102_Layout __ND51557__Project(B_Tradeline_5(__in,__cfg).__ST39671_Layout __PP51556) := TRANSFORM
      SELF.Other_Segment_ := __NOT(__OR(__OR(__OR(__PP51556.Carrier_Segment_,__PP51556.Fleet_Segment_),__PP51556.Materials_Segment_),__PP51556.Operations_Segment_));
      SELF.Total___A_R___L_N_ := __OP2(__OP2(__OP2(__OP2(__PP51556.Current___A_R___L_N_,+,__PP51556.Aging1_To30_),+,__PP51556.Aging31_To60_),+,__PP51556.Aging61_To90_),+,__PP51556.Aging91_Plus_);
      SELF := __PP51556;
    END;
    SELF.Records_ := __PROJECT(__EE51105,__ND51557__Project(LEFT));
    __EE51286 := __PP51056.Records_;
    SELF.Newest_Record_Age_In_Days_ := KEL.Aggregates.MinNN(__EE51286,__T(__EE51286).Record_Age_In_Days_);
    __EE51315 := __PP51056.Records_;
    SELF.Newest_Record_Age_In_Days1_Y_ := KEL.Aggregates.MinNN(__EE51315,__T(__EE51315).Record_Age_In_Days1_Y_);
    SELF := __PP51056;
  END;
  EXPORT __ENH_Tradeline_4 := PROJECT(__EE51361,__ND51621__Project(LEFT));
END;
