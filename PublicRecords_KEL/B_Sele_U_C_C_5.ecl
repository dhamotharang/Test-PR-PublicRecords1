//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_U_C_C_6,B_Sele_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_U_C_C_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_6().__ENH_Sele_U_C_C_6) __ENH_Sele_U_C_C_6 := B_Sele_U_C_C_6(__in,__cfg).__ENH_Sele_U_C_C_6;
  SHARED __EE513731 := __ENH_Sele_U_C_C_6;
  EXPORT __ST161447_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST161439_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST161447_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST169927_Layout) Best_Party_Types_;
    KEL.typ.nstr Filtered_Party_Type_;
    KEL.typ.bool Is_Creditor_ := FALSE;
    KEL.typ.bool Is_Debtor_ := FALSE;
    KEL.typ.bool Is_Filing_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161439_Layout __ND513865__Project(B_Sele_U_C_C_6(__in,__cfg).__ST164776_Layout __PP513590) := TRANSFORM
    __EE513647 := __PP513590.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE513647),__ST161447_Layout),__NL(__EE513647));
    SELF.Is_Creditor_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP513590.Filtered_Party_Type_)),IN,__CN(['S','C','A']))),TRUE,FALSE);
    SELF.Is_Debtor_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP513590.Filtered_Party_Type_)),=,__CN('D'))),TRUE,FALSE);
    SELF := __PP513590;
  END;
  EXPORT __ENH_Sele_U_C_C_5 := PROJECT(__EE513731,__ND513865__Project(LEFT));
END;
