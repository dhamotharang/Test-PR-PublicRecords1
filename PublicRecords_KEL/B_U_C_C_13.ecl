//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_U_C_C_13(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_U_C_C(__cfg).__Result) __E_U_C_C := E_U_C_C(__cfg).__Result;
  SHARED __EE329116 := __E_U_C_C;
  EXPORT __ST265316_Layout := RECORD
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
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST265312_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST265316_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST265312_Layout __ND329345__Project(E_U_C_C(__cfg).Layout __PP328944) := TRANSFORM
    __EE328975 := __PP328944.Sub_Filing_;
    __ST265316_Layout __ND329243__Project(E_U_C_C(__cfg).Sub_Filing_Layout __PP329239) := TRANSFORM
      SELF.Max_Filing_Date_ := KEL.Routines.MaxN(__PP329239.Filing_Date_,__PP329239.Original_Filing_Date_);
      SELF := __PP329239;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE328975,__ND329243__Project(LEFT));
    SELF := __PP328944;
  END;
  EXPORT __ENH_U_C_C_13 := PROJECT(__EE329116,__ND329345__Project(LEFT));
END;
