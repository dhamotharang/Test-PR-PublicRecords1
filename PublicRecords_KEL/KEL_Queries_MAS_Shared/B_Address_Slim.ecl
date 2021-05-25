//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Address_Slim_1,B_Address_Slim_3,B_Address_Slim_4,CFG_Compile,E_Address_Slim,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_Slim(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Slim_1(__in,__cfg).__ENH_Address_Slim_1) __ENH_Address_Slim_1 := B_Address_Slim_1(__in,__cfg).__ENH_Address_Slim_1;
  SHARED __EE228946 := __ENH_Address_Slim_1;
  EXPORT __ST153843_Layout := RECORD
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
  SHARED __ST153843_Layout __ND228895__Project(B_Address_Slim_1(__in,__cfg).__ST154497_Layout __PP228705) := TRANSFORM
    __CC14249 := '-99999';
    SELF.P_I___Inp_Addr_Is_H_R_Correct_Fac_Flag_ := MAP(__T(__OP2(__PP228705.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__CC14249,__T(__OR(__OR(__PP228705.Address_S_I_C_Not_Contains_,__PP228705.Address_N_A_I_C_S_Not_Contains_),__AND(__PP228705.S_I_C_List_Not_Found_,__PP228705.N_A_I_C_S_List_Not_Foind_)))=>'0','1');
    __CC14254 := '-99998';
    __EE228888 := __PP228705.Address_N_A_I_C_S_Sorted_List_;
    SELF.P_I___Inp_Addr_N_A_I_C_S_Code_H_R_List_ := MAP(__T(__OP2(__PP228705.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN(__CC14249)),__T(__PP228705.N_A_I_C_S_List_Not_Foind_)=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE228888,LEFT.High_Risk_N_A_I_C_S_,__CN('|'))));
    __EE228917 := __PP228705.Address_S_I_C_Sorted_List_;
    SELF.P_I___Inp_Addr_S_I_C_Code_H_R_List_ := MAP(__T(__OP2(__PP228705.P___Cln_Addr_Full_Flag_,<>,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN(__CC14249)),__T(__PP228705.S_I_C_List_Not_Found_)=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE228917,LEFT.High_Risk_S_I_C_,__CN('|'))));
    SELF := __PP228705;
  END;
  EXPORT __ENH_Address_Slim := PROJECT(__EE228946,__ND228895__Project(LEFT));
END;
