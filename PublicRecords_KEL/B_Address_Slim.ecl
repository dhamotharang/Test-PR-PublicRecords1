//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Slim_1,B_Address_Slim_3,B_Address_Slim_4,CFG_Compile,E_Address_Slim,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Slim(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Slim_1(__in,__cfg).__ENH_Address_Slim_1) __ENH_Address_Slim_1 := B_Address_Slim_1(__in,__cfg).__ENH_Address_Slim_1;
  SHARED __EE8444647 := __ENH_Address_Slim_1;
  EXPORT __ST130811_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout) High_Risk_Address_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).Address_Type_Layout) Address_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.str P_I___Inp_Addr_Is_H_R_Correct_Fac_Flag_ := '';
    KEL.typ.nstr P_I___Inp_Addr_N_A_I_C_S_Code_H_R_List_;
    KEL.typ.nstr P_I___Inp_Addr_S_I_C_Code_H_R_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST130811_Layout __ND8444596__Project(B_Address_Slim_1(__in,__cfg).__ST175128_Layout __PP8444406) := TRANSFORM
    __CC13785 := '-99999';
    SELF.P_I___Inp_Addr_Is_H_R_Correct_Fac_Flag_ := MAP(__T(__OP2(__PP8444406.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__CC13785,__T(__OR(__OR(__PP8444406.Address_S_I_C_Not_Contains_,__PP8444406.Address_N_A_I_C_S_Not_Contains_),__AND(__PP8444406.S_I_C_List_Not_Found_,__PP8444406.N_A_I_C_S_List_Not_Foind_)))=>'0','1');
    __CC13790 := '-99998';
    __EE8444589 := __PP8444406.Address_N_A_I_C_S_Sorted_List_;
    SELF.P_I___Inp_Addr_N_A_I_C_S_Code_H_R_List_ := MAP(__T(__OP2(__PP8444406.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN(__CC13785)),__T(__PP8444406.N_A_I_C_S_List_Not_Foind_)=>__ECAST(KEL.typ.nstr,__CN(__CC13790)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8444589,LEFT.High_Risk_N_A_I_C_S_,__CN('|'))));
    __EE8444618 := __PP8444406.Address_S_I_C_Sorted_List_;
    SELF.P_I___Inp_Addr_S_I_C_Code_H_R_List_ := MAP(__T(__OP2(__PP8444406.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN(__CC13785)),__T(__PP8444406.S_I_C_List_Not_Found_)=>__ECAST(KEL.typ.nstr,__CN(__CC13790)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8444618,LEFT.High_Risk_S_I_C_,__CN('|'))));
    SELF := __PP8444406;
  END;
  EXPORT __ENH_Address_Slim := PROJECT(__EE8444647,__ND8444596__Project(LEFT));
END;
