//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Property_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Property,E_Sele_Property,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Property_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Property_4(__in,__cfg).__ENH_Sele_Property_4) __ENH_Sele_Property_4 := B_Sele_Property_4(__in,__cfg).__ENH_Sele_Property_4;
  SHARED __EE2505226 := __ENH_Sele_Property_4;
  EXPORT __ST199398_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST199398_Layout __ND2505231__Project(B_Sele_Property_4(__in,__cfg).__ST207211_Layout __PP2505227) := TRANSFORM
    SELF.Is_Currently_Owned_ := (__PP2505227.Property_Is_Owned_Assessment_ OR __PP2505227.Property_Is_Owned_Deed_) AND NOT (__PP2505227.Property_Is_Sold_);
    SELF := __PP2505227;
  END;
  EXPORT __ENH_Sele_Property_3 := PROJECT(__EE2505226,__ND2505231__Project(LEFT));
END;
