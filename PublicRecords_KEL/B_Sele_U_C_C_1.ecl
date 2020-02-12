﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_U_C_C_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_U_C_C_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_2(__in,__cfg).__ENH_Sele_U_C_C_2) __ENH_Sele_U_C_C_2 := B_Sele_U_C_C_2(__in,__cfg).__ENH_Sele_U_C_C_2;
  SHARED __EE1221800 := __ENH_Sele_U_C_C_2;
  EXPORT __ST88972_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.bool Creditor_ := FALSE;
    KEL.typ.bool Debtor_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST88964_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST88972_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88964_Layout __ND1221864__Project(B_Sele_U_C_C_2(__in,__cfg).__ST97403_Layout __PP1221702) := TRANSFORM
    __EE1221741 := __PP1221702.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1221741),__ST88972_Layout),__NL(__EE1221741));
    SELF := __PP1221702;
  END;
  EXPORT __ENH_Sele_U_C_C_1 := PROJECT(__EE1221800,__ND1221864__Project(LEFT));
END;
