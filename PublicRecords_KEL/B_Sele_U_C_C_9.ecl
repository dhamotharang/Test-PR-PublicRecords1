//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_U_C_C_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_U_C_C().__Result) __E_Sele_U_C_C := E_Sele_U_C_C(__in,__cfg).__Result;
  SHARED __EE256248 := __E_Sele_U_C_C;
  EXPORT __ST169927_Layout := RECORD
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
  EXPORT __ST169919_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST169927_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST169919_Layout __ND256340__Project(E_Sele_U_C_C(__in,__cfg).Layout __PP256146) := TRANSFORM
    __EE256185 := __PP256146.Sub_Filing_;
    __ST169927_Layout __ND256335__Project(E_Sele_U_C_C(__in,__cfg).Sub_Filing_Layout __PP256252) := TRANSFORM
      SELF.Party_Sort_List_ := MAP(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP256252.Party_Type_)),=,__CN('D')))=>1,__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP256252.Party_Type_)),IN,__CN(['S','C','A'])))=>2,3);
      SELF := __PP256252;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE256185,__ND256335__Project(LEFT));
    SELF := __PP256146;
  END;
  EXPORT __ENH_Sele_U_C_C_9 := PROJECT(__EE256248,__ND256340__Project(LEFT));
END;
