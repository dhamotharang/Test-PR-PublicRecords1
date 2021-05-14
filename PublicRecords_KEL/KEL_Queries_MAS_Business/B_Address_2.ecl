//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Address_3,B_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_3(__in,__cfg).__ENH_Address_3) __ENH_Address_3 := B_Address_3(__in,__cfg).__ENH_Address_3;
  SHARED VIRTUAL TYPEOF(E_Zip_Code(__in,__cfg).__Result) __E_Zip_Code := E_Zip_Code(__in,__cfg).__Result;
  SHARED __EE2508148 := __ENH_Address_3;
  SHARED __EE802967 := __E_Zip_Code;
  SHARED __ST803620_Layout := RECORD
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
    KEL.typ.ndataset(E_Address(__in,__cfg).A_D_V_O_Summary_Layout) Bestchild_Advo_;
    KEL.typ.nstr Res_Bus_Flag_;
    KEL.typ.nstr Vacant_Flag_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr Zip_Class_;
    KEL.typ.nstr City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr City_Name_;
    KEL.typ.ndataset(E_Zip_Code(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2508619(B_Address_5(__in,__cfg).__ST208650_Layout __EE2508148, E_Zip_Code(__in,__cfg).Layout __EE802967) := __EEQP(__EE2508148.Z_I_P5_,__EE802967.UID);
  __ST803620_Layout __JT2508619(B_Address_5(__in,__cfg).__ST208650_Layout __l, E_Zip_Code(__in,__cfg).Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2508620 := JOIN(__EE2508148,__EE802967,__JC2508619(LEFT,RIGHT),__JT2508619(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST180871_Layout := RECORD
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
    KEL.typ.bool Is_P_O_Box_A_D_V_O_ := FALSE;
    KEL.typ.nbool Is_P_O_Box_Zip_;
    KEL.typ.nstr Res_Bus_Flag_;
    KEL.typ.nstr Vacant_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST180871_Layout __ND2509175__Project(__ST803620_Layout __PP2508156) := TRANSFORM
    __BS2508482 := __T(__PP2508156.Address_Type_);
    SELF.Is_P_O_Box_A_D_V_O_ := EXISTS(__BS2508482(__T(__OP2(__T(__PP2508156.Address_Type_).Address_Type_Code_,=,__CN('9')))));
    SELF.Is_P_O_Box_Zip_ := __OP2(__PP2508156.Zip_Class_,=,__CN('P'));
    SELF := __PP2508156;
  END;
  EXPORT __ENH_Address_2 := PROJECT(__EE2508620,__ND2509175__Project(LEFT));
END;
