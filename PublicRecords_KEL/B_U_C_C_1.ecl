//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_U_C_C_2,CFG_Compile,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_U_C_C_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2;
  SHARED __EE1765337 := __ENH_U_C_C_2;
  EXPORT __ST116268_Layout := RECORD
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
  EXPORT __ST116264_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST116268_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_U_C_C_2(__in,__cfg).__ST1222272_Layout) Best_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST116264_Layout __ND1765654__Project(B_U_C_C_2(__in,__cfg).__ST127126_Layout __PP1765050) := TRANSFORM
    __EE1765143 := __PP1765050.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1765143),__ST116268_Layout),__NL(__EE1765143));
    SELF := __PP1765050;
  END;
  EXPORT __ENH_U_C_C_1 := PROJECT(__EE1765337,__ND1765654__Project(LEFT));
END;
