//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_U_C_C_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_U_C_C_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4) __ENH_Sele_U_C_C_4 := B_Sele_U_C_C_4(__in,__cfg).__ENH_Sele_U_C_C_4;
  SHARED __EE457330 := __ENH_Sele_U_C_C_4;
  EXPORT __ST103640_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.bool Debtor_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST103632_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST103640_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST103632_Layout __ND457390__Project(B_Sele_U_C_C_4(__in,__cfg).__ST108647_Layout __PP457237) := TRANSFORM
    __EE457276 := __PP457237.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE457276),__ST103640_Layout),__NL(__EE457276));
    SELF := __PP457237;
  END;
  EXPORT __ENH_Sele_U_C_C_3 := PROJECT(__EE457330,__ND457390__Project(LEFT));
END;
