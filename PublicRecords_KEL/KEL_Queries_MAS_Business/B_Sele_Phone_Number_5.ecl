//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Phone_Number_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Phone,E_Sele_Phone_Number FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Phone_Number_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Phone_Number_6(__in,__cfg).__ENH_Sele_Phone_Number_6) __ENH_Sele_Phone_Number_6 := B_Sele_Phone_Number_6(__in,__cfg).__ENH_Sele_Phone_Number_6;
  SHARED __EE1986808 := __ENH_Sele_Phone_Number_6;
  EXPORT __ST205596_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST205558_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST205596_Layout) Data_Sources_;
    KEL.typ.nbool Input_Phone_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST205558_Layout __ND1986813__Project(B_Sele_Phone_Number_6(__in,__cfg).__ST208944_Layout __PP1986809) := TRANSFORM
    __EE1986862 := __PP1986809.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1986862),__ST205596_Layout),__NL(__EE1986862));
    SELF := __PP1986809;
  END;
  EXPORT __ENH_Sele_Phone_Number_5 := PROJECT(__EE1986808,__ND1986813__Project(LEFT));
END;
