//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_U_C_C_6,B_U_C_C_7,CFG_Compile,E_U_C_C,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_U_C_C_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6;
  SHARED __EE262879 := __ENH_U_C_C_6;
  EXPORT __ST143878_Layout := RECORD
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
  EXPORT __ST262517_Layout := RECORD
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
    KEL.typ.nkdate Max_Filing_Date_Sub_;
    KEL.typ.nstr Filing_Number_Non_Null_;
    KEL.typ.nstr Filing_Time_Non_Null_;
    KEL.typ.nint Vendor_Entry_Date_Non_Null_;
    KEL.typ.nint Filing_Date_Non_Null_;
    KEL.typ.str Filing_Type_Filtered_ := '';
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST143874_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST143878_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST262517_Layout) Best_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST143874_Layout __ND263140__Project(B_U_C_C_6(__in,__cfg).__ST145901_Layout __PP262548) := TRANSFORM
    __EE262581 := __PP262548.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE262581),__ST143878_Layout),__NL(__EE262581));
    __EE262729 := __PP262548.Best_Child_Record_;
    __ST262517_Layout __ND262996__Project(B_U_C_C_7(__in,__cfg).__ST147342_Layout __PP262992) := TRANSFORM
      SELF.Filing_Type_Filtered_ := FN_Compile(__cfg).FN__map_Filing_Type(__ECAST(KEL.typ.nstr,__PP262992.Filing_Type_));
      SELF.Max_Filing_Date_ := KEL.Routines.MaxN(__PP262992.Filing_Date_,__PP262992.Original_Filing_Date_);
      SELF := __PP262992;
    END;
    SELF.Best_Child_Record_ := __PROJECT(__EE262729,__ND262996__Project(LEFT));
    SELF := __PP262548;
  END;
  EXPORT __ENH_U_C_C_5 := PROJECT(__EE262879,__ND263140__Project(LEFT));
END;
