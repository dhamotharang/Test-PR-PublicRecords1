//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Property_5,B_Person_Property_7,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_5(__in,__cfg).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5(__in,__cfg).__ENH_Person_Property_5;
  SHARED __EE5823485 := __ENH_Person_Property_5;
  EXPORT __ST250118_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    B_Person_Property_7(__in,__cfg).__ST96118_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Purchase_Date_Last_Seen_;
    KEL.typ.nkdate Property_Purchase_Date_Last_Seen_Capped_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.ndataset(B_Person_Property_7(__in,__cfg).__ST96118_Layout) Property_Sale_Info_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST250118_Layout __ND5823490__Project(B_Person_Property_5(__in,__cfg).__ST256994_Layout __PP5823486) := TRANSFORM
    SELF.Is_Currently_Owned_ := (__PP5823486.Property_Is_Owned_Assessment_ OR __PP5823486.Property_Is_Owned_Deed_) AND NOT (__PP5823486.Property_Is_Sold_);
    __CC13307 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('property_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Property_Purchase_Date_Last_Seen_ := KEL.Routines.MinN(__PP5823486.Property_Purchase_Date_Last_Seen_Capped_,__CC13307);
    SELF := __PP5823486;
  END;
  EXPORT __ENH_Person_Property_4 := PROJECT(__EE5823485,__ND5823490__Project(LEFT));
END;
