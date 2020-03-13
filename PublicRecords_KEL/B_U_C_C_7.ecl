//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_U_C_C_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_U_C_C(__in,__cfg).__Result) __E_U_C_C := E_U_C_C(__in,__cfg).__Result;
  SHARED __EE211572 := __E_U_C_C;
  EXPORT __ST147342_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nstr Filing_Status_;
    KEL.typ.nstr Filing_Time_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.nstr Filing_Agency_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nstr Contract_Type_;
    KEL.typ.nkdate Vendor_Entry_Date_;
    KEL.typ.nkdate Vendor_Update_Date_;
    KEL.typ.nstr Statements_Filed_;
    KEL.typ.nstr Foreign_Flag_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nint Filing_Date_Non_Null_;
    KEL.typ.nstr Filing_Number_Non_Null_;
    KEL.typ.nstr Filing_Time_Non_Null_;
    KEL.typ.nkdate Max_Filing_Date_Sub_;
    KEL.typ.nint Vendor_Entry_Date_Non_Null_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST147338_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST147342_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST147338_Layout __ND211787__Project(E_U_C_C(__in,__cfg).Layout __PP211362) := TRANSFORM
    __EE211393 := __PP211362.Sub_Filing_;
    __ST147342_Layout __ND211757__Project(E_U_C_C(__in,__cfg).Sub_Filing_Layout __PP211576) := TRANSFORM
      SELF.Filing_Date_Non_Null_ := IF(__T(__NT(__PP211576.Filing_Date_)),__ECAST(KEL.typ.nint,__CN(-99999)),__ECAST(KEL.typ.nint,KEL.Routines.NIntegerFromNDate(__PP211576.Filing_Date_)));
      SELF.Filing_Number_Non_Null_ := IF(__T(__NT(__PP211576.Filing_Number_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__ECAST(KEL.typ.nstr,__PP211576.Filing_Number_));
      SELF.Filing_Time_Non_Null_ := IF(__T(__NT(__PP211576.Filing_Time_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__ECAST(KEL.typ.nstr,__PP211576.Filing_Time_));
      SELF.Max_Filing_Date_Sub_ := KEL.Routines.MaxN(__PP211576.Filing_Date_,__PP211576.Original_Filing_Date_);
      SELF.Vendor_Entry_Date_Non_Null_ := IF(__T(__NT(__PP211576.Vendor_Entry_Date_)),__ECAST(KEL.typ.nint,__CN(-99999)),__ECAST(KEL.typ.nint,KEL.Routines.NIntegerFromNDate(__PP211576.Vendor_Entry_Date_)));
      SELF := __PP211576;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE211393,__ND211757__Project(LEFT));
    SELF := __PP211362;
  END;
  EXPORT __ENH_U_C_C_7 := PROJECT(__EE211572,__ND211787__Project(LEFT));
END;
