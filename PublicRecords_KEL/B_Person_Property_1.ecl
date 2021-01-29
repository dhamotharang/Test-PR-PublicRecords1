﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Property_2,B_Person_Property_7,B_Property_2,B_Property_3,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Property_1(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_2(__cfg).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2(__cfg).__ENH_Person_Property_2;
  SHARED VIRTUAL TYPEOF(B_Property_2(__cfg).__ENH_Property_2) __ENH_Property_2 := B_Property_2(__cfg).__ENH_Property_2;
  SHARED __EE8515158 := __ENH_Person_Property_2;
  SHARED __EE8515161 := __ENH_Property_2;
  SHARED __ST3109795_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Data_Sources_Layout) Data_Sources_;
    B_Property_3(__cfg).__ST231930_Layout Best_Most_Recent_Property_;
    KEL.typ.ntyp(E_Property_Event().Typ) Best_Most_Recent_Property_Event_;
    B_Person_Property_7(__cfg).__ST93544_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Property(__cfg).Address_Components_Layout) Address_Components__1_;
    KEL.typ.ndataset(B_Property_2(__cfg).__ST217185_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.bool Is_Business_Address_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC8515169(B_Person_Property_2(__cfg).__ST216533_Layout __EE8515158, B_Property_2(__cfg).__ST217167_Layout __EE8515161) := __EEQP(__EE8515158.Prop_,__EE8515161.UID);
  __ST3109795_Layout __JT8515169(B_Person_Property_2(__cfg).__ST216533_Layout __l, B_Property_2(__cfg).__ST217167_Layout __r) := TRANSFORM
    SELF.Primary_Range__1_ := __r.Primary_Range_;
    SELF.Predirectional__1_ := __r.Predirectional_;
    SELF.Primary_Name__1_ := __r.Primary_Name_;
    SELF.Suffix__1_ := __r.Suffix_;
    SELF.Postdirectional__1_ := __r.Postdirectional_;
    SELF.Secondary_Range__1_ := __r.Secondary_Range_;
    SELF.Z_I_P5__1_ := __r.Z_I_P5_;
    SELF.Address_Components__1_ := __r.Address_Components_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE8515170 := JOIN(__EE8515158,__EE8515161,__JC8515169(LEFT,RIGHT),__JT8515169(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST197755_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Person_Property(__cfg).Data_Sources_Layout) Data_Sources_;
    B_Property_3(__cfg).__ST231930_Layout Best_Most_Recent_Property_;
    KEL.typ.ntyp(E_Property_Event().Typ) Best_Most_Recent_Property_Event_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST197755_Layout __ND8515286__Project(__ST3109795_Layout __PP8515171) := TRANSFORM
    SELF.Is_Ever_Owned_Business_Address_ := __PP8515171.Is_Business_Address_ AND __PP8515171.Is_Ever_Owned_;
    SELF := __PP8515171;
  END;
  EXPORT __ENH_Person_Property_1 := PROJECT(__EE8515170,__ND8515286__Project(LEFT));
END;
