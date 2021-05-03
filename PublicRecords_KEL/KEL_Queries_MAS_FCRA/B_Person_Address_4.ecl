//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Address_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Address_5(__in,__cfg).__ENH_Person_Address_5) __ENH_Person_Address_5 := B_Person_Address_5(__in,__cfg).__ENH_Person_Address_5;
  SHARED __EE4874173 := __ENH_Person_Address_5;
  EXPORT __ST232912_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nkdate Address_Source_Date_First_Seen_;
    KEL.typ.nkdate Address_Source_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST232856_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(__ST232912_Layout) Data_Sources_;
    KEL.typ.int Address_Similarity_Match_ := 0;
    KEL.typ.nstr Grouped_Address_;
    KEL.typ.nstr Grouped_Input_Address_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST232856_Layout __ND4874178__Project(B_Person_Address_5(__in,__cfg).__ST232636_Layout __PP4874174) := TRANSFORM
    __EE4874279 := __PP4874174.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE4874279),__ST232912_Layout),__NL(__EE4874279));
    SELF := __PP4874174;
  END;
  EXPORT __ENH_Person_Address_4 := PROJECT(__EE4874173,__ND4874178__Project(LEFT));
END;
