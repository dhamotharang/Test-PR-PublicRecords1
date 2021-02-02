//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_U_C_C_12,CFG_Compile,E_U_C_C,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_U_C_C_11(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_12(__in,__cfg).__ENH_U_C_C_12) __ENH_U_C_C_12 := B_U_C_C_12(__in,__cfg).__ENH_U_C_C_12;
  SHARED __EE5205338 := __ENH_U_C_C_12;
  EXPORT __ST263593_Layout := RECORD
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
    KEL.typ.nint Age_In_Days_;
    KEL.typ.str Filing_Type_Filtered_ := '';
    KEL.typ.str Inferred_Status_ := '';
    KEL.typ.bool Initial_Filing_ := FALSE;
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.str Status_Type_Filtered_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST263589_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST263593_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST263589_Layout __ND5205555__Project(B_U_C_C_12(__in,__cfg).__ST263789_Layout __PP5205339) := TRANSFORM
    __EE5205359 := __PP5205339.Sub_Filing_;
    __ST263593_Layout __ND5205530__Project(B_U_C_C_12(__in,__cfg).__ST263793_Layout __PP5205360) := TRANSFORM
      __CC52235 := 2191;
      SELF.Inferred_Status_ := MAP(__PP5205360.Filing_Type_Filtered_ = '1'=>'3',__T(__AND(__OP2(__PP5205360.Status_Type_,=,__CN('ACTIVE')),__OP2(__PP5205360.Age_In_Days_,>,__CN(__CC52235))))=>'8',__T(__OP2(__PP5205360.Status_Type_,<>,__CN('')))=>__PP5205360.Status_Type_Filtered_,FN_Compile(__cfg).FN__map_Inferred_Status(__ECAST(KEL.typ.nstr,__CN(__PP5205360.Filing_Type_Filtered_))));
      SELF.Initial_Filing_ := __PP5205360.Filing_Type_Filtered_ = '7';
      SELF := __PP5205360;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE5205359,__ND5205530__Project(LEFT));
    SELF := __PP5205339;
  END;
  EXPORT __ENH_U_C_C_11 := PROJECT(__EE5205338,__ND5205555__Project(LEFT));
END;
