//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_U_C_C_6,CFG_Compile,E_U_C_C,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_U_C_C_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6) __ENH_U_C_C_6 := B_U_C_C_6(__in,__cfg).__ENH_U_C_C_6;
  SHARED __EE157582 := __ENH_U_C_C_6;
  EXPORT __ST110630_Layout := RECORD
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
    KEL.typ.bool Initial_Filing_ := FALSE;
    KEL.typ.nkdate Recent_Filing_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST110626_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST110630_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Most_Recent_Filing_Date_;
    KEL.typ.nstr Most_Recent_Filing_Type_;
    KEL.typ.nstr Most_Recent_Non_Blank_Filing_Type_;
    B_U_C_C_6(__in,__cfg).__NS138302_Layout Most_Recent_Non_Blank_Sub_Filing_;
    B_U_C_C_6(__in,__cfg).__NS138339_Layout Most_Recent_Sub_Filing_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST110626_Layout __ND157510__Project(B_U_C_C_6(__in,__cfg).__ST111703_Layout __PP156629) := TRANSFORM
    __EE157585 := __PP156629.Sub_Filing_;
    __ST110630_Layout __ND157414__Project(B_U_C_C_6(__in,__cfg).__ST111707_Layout __PP156980) := TRANSFORM
      SELF.Initial_Filing_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP156980.Filing_Type_)),=,__CN('INITIAL FILING'))),TRUE,FALSE);
      SELF := __PP156980;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE157585,__ND157414__Project(LEFT));
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('ucc_build_version'))),__CN(__cfg.CurrentDate));
    __EE157505 := __PP156629.Sub_Filing_;
    SELF.Most_Recent_Filing_Date_ := KEL.Aggregates.MaxNN(__EE157505,__T(__EE157505).Recent_Filing_Date_);
    SELF.Most_Recent_Filing_Type_ := __FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP156629.Most_Recent_Sub_Filing_.Filing_Type_));
    SELF.Most_Recent_Non_Blank_Filing_Type_ := __FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP156629.Most_Recent_Non_Blank_Sub_Filing_.Filing_Type_));
    SELF := __PP156629;
  END;
  EXPORT __ENH_U_C_C_5 := PROJECT(__EE157582,__ND157510__Project(LEFT));
END;
