//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Address_3,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_3(__in,__cfg).__ENH_Address_3) __ENH_Address_3 := B_Address_3(__in,__cfg).__ENH_Address_3;
  SHARED __EE1907775 := __ENH_Address_3;
  EXPORT __ST162628_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Address(__in,__cfg).College_Layout) College_;
    KEL.typ.ndataset(E_Address(__in,__cfg).A_D_V_O_Date_Summary_Layout) A_D_V_O_Date_Summary_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Do_Not_Deliver_Layout) Do_Not_Deliver_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Do_Not_Mail_Layout) Do_Not_Mail_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Dead_C_O_Layout) Dead_C_O_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Hot_List_Layout) Hot_List_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Mail_Drop_Layout) Mail_Drop_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Mixed_Usage_Layout) Mixed_Usage_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Only_Way_To_Get_Mail_Layout) Only_Way_To_Get_Mail_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Record_Type_Layout) Record_Type_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Address_Type_Layout) Address_Type_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Residential_Or_Business_Layout) Residential_Or_Business_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Seasonal_Delivery_Layout) Seasonal_Delivery_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Simplify_Layout) Simplify_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Style_Layout) Style_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Throw_Back_Layout) Throw_Back_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Vacancy_Layout) Vacancy_;
    KEL.typ.ndataset(E_Address(__in,__cfg).A_D_V_O_Summary_Layout) A_D_V_O_Summary_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Vacation_Layout) Vacation_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr College_Flag_;
    KEL.typ.nstr Do_Not_Deliver_Flag_;
    KEL.typ.nstr Drop_Indicator_Flag_;
    KEL.typ.nstr Res_Bus_Flag_;
    KEL.typ.nstr Seasonal_Delivery_Flag_;
    KEL.typ.nstr Style_Flag_;
    KEL.typ.nstr Throw_Back_Flag_;
    KEL.typ.nstr Vacant_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST162628_Layout __ND1907548__Project(B_Address_3(__in,__cfg).__ST167921_Layout __PP1906813) := TRANSFORM
    __EE1907543 := __PP1906813.Bestchild_Advo_;
    SELF.College_Flag_ := (__T(__EE1907543))[1].College_Indicator_;
    __EE1907558 := __PP1906813.Bestchild_Advo_;
    SELF.Do_Not_Deliver_Flag_ := (__T(__EE1907558))[1].Do_Not_Deliver_Indicator_;
    __EE1907572 := __PP1906813.Bestchild_Advo_;
    SELF.Drop_Indicator_Flag_ := (__T(__EE1907572))[1].Drop_Indicator_;
    __EE1907586 := __PP1906813.Bestchild_Advo_;
    SELF.Res_Bus_Flag_ := (__T(__EE1907586))[1].Residential_Or_Business_Indicator_;
    __EE1907600 := __PP1906813.Bestchild_Advo_;
    SELF.Seasonal_Delivery_Flag_ := (__T(__EE1907600))[1].Seasonal_Delivery_Indicator_;
    __EE1907614 := __PP1906813.Bestchild_Advo_;
    SELF.Style_Flag_ := (__T(__EE1907614))[1].Style_Code_;
    __EE1907628 := __PP1906813.Bestchild_Advo_;
    SELF.Throw_Back_Flag_ := (__T(__EE1907628))[1].Throw_Back_Indicator_;
    __EE1907642 := __PP1906813.Bestchild_Advo_;
    SELF.Vacant_Flag_ := (__T(__EE1907642))[1].Vacancy_Indicator_;
    SELF := __PP1906813;
  END;
  EXPORT __ENH_Address_2 := PROJECT(__EE1907775,__ND1907548__Project(LEFT));
END;
