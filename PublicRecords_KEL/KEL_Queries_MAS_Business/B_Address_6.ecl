﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address(__in,__cfg).__Result) __E_Address := E_Address(__in,__cfg).__Result;
  SHARED __EE331934 := __E_Address;
  EXPORT __ST218181_Layout := RECORD
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST218181_Layout __ND334838__Project(E_Address(__in,__cfg).Layout __PP331295) := TRANSFORM
    __EE331739 := __PP331295.A_D_V_O_Summary_;
    __BS332065 := __T(__EE331739);
    __EE332085 := __BN(TOPN(__BS332065(__NN(__T(__EE331739).A_D_V_O_Date_First_Seen_)),1, -__T(__T(__EE331739).A_D_V_O_Date_First_Seen_),__T(Vacancy_Indicator_),__T(Throw_Back_Indicator_),__T(Seasonal_Delivery_Indicator_),__T(Style_Code_),__T(Drop_Indicator_),__T(College_Indicator_),__T(Only_Way_To_Get_Mail_Indicator_),__T(Residential_Or_Business_Indicator_),__T(Do_Not_Deliver_Indicator_),__T(A_D_V_O_Date_Last_Seen_)),__NL(__EE331739));
    SELF.Bestchild_Advo_ := __EE332085;
    SELF := __PP331295;
  END;
  EXPORT __ENH_Address_6 := PROJECT(__EE331934,__ND334838__Project(LEFT));
END;
