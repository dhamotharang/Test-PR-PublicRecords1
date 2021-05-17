//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Property_2,B_Property_2,B_Property_3,CFG_Compile,E_Person,E_Person_Property,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Property_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_2(__in,__cfg).__ENH_Person_Property_2) __ENH_Person_Property_2 := B_Person_Property_2(__in,__cfg).__ENH_Person_Property_2;
  SHARED VIRTUAL TYPEOF(B_Property_2(__in,__cfg).__ENH_Property_2) __ENH_Property_2 := B_Property_2(__in,__cfg).__ENH_Property_2;
  SHARED __EE3274555 := __ENH_Person_Property_2;
  SHARED __EE3274558 := __ENH_Property_2;
  SHARED __ST1315514_Layout := RECORD
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
    B_Property_3(__in,__cfg).__ST171740_Layout Best_Most_Recent_Property_;
    KEL.typ.ntyp(E_Property_Event().Typ) Best_Most_Recent_Property_Event_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Purchased_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Previous_Recording_Date_;
    KEL.typ.nint Property_Previous_Sale_Price_;
    KEL.typ.nkdate Property_Purchase_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.nbool Seen___In___Five___Years_;
    KEL.typ.nbool Seen___In___One___Year_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components__1_;
    KEL.typ.ndataset(B_Property_2(__in,__cfg).__ST167359_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.bool Is_Business_Address_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3274566(B_Person_Property_2(__in,__cfg).__ST166777_Layout __EE3274555, B_Property_2(__in,__cfg).__ST167341_Layout __EE3274558) := __EEQP(__EE3274555.Prop_,__EE3274558.UID);
  __ST1315514_Layout __JT3274566(B_Person_Property_2(__in,__cfg).__ST166777_Layout __l, B_Property_2(__in,__cfg).__ST167341_Layout __r) := TRANSFORM
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
  SHARED __EE3274567 := JOIN(__EE3274555,__EE3274558,__JC3274566(LEFT,RIGHT),__JT3274566(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST161622_Layout := RECORD
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
    B_Property_3(__in,__cfg).__ST171740_Layout Best_Most_Recent_Property_;
    KEL.typ.ntyp(E_Property_Event().Typ) Best_Most_Recent_Property_Event_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161622_Layout __ND3274681__Project(__ST1315514_Layout __PP3274568) := TRANSFORM
    SELF.Is_Ever_Owned_Business_Address_ := __PP3274568.Is_Business_Address_ AND __PP3274568.Is_Ever_Owned_;
    SELF := __PP3274568;
  END;
  EXPORT __ENH_Person_Property_1 := PROJECT(__EE3274567,__ND3274681__Project(LEFT));
END;
