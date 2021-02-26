//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_3,B_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_3(__in,__cfg).__ENH_Address_3) __ENH_Address_3 := B_Address_3(__in,__cfg).__ENH_Address_3;
  SHARED VIRTUAL TYPEOF(E_Zip_Code(__in,__cfg).__Result) __E_Zip_Code := E_Zip_Code(__in,__cfg).__Result;
  SHARED __EE6848411 := __ENH_Address_3;
  SHARED __EE6848413 := __E_Zip_Code;
  SHARED __ST1276539_Layout := RECORD
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
    KEL.typ.ndataset(E_Address(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Address(__in,__cfg).B_I_P_V2_Best_Layout) B_I_P_V2_Best_;
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
    KEL.typ.ndataset(E_Address(__in,__cfg).High_Risk_Address_Layout) High_Risk_Address_;
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
  __JC6848422(B_Address_5(__in,__cfg).__ST250782_Layout __EE6848411, E_Zip_Code(__in,__cfg).Layout __EE6848413) := __EEQP(__EE6848411.Z_I_P5_,__EE6848413.UID);
  __ST1276539_Layout __JT6848422(B_Address_5(__in,__cfg).__ST250782_Layout __l, E_Zip_Code(__in,__cfg).Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6848583 := JOIN(__EE6848411,__EE6848413,__JC6848422(LEFT,RIGHT),__JT6848422(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST206005_Layout := RECORD
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
    KEL.typ.ndataset(E_Address(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Address(__in,__cfg).B_I_P_V2_Best_Layout) B_I_P_V2_Best_;
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
    KEL.typ.ndataset(E_Address(__in,__cfg).High_Risk_Address_Layout) High_Risk_Address_;
    KEL.typ.ndataset(E_Address(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Address(__in,__cfg).A_D_V_O_Summary_Layout) Bestchild_Advo_;
    KEL.typ.nstr College_Flag_;
    KEL.typ.nstr Do_Not_Deliver_Flag_;
    KEL.typ.nstr Drop_Indicator_Flag_;
    KEL.typ.bool Is_P_O_Box_A_D_V_O_ := FALSE;
    KEL.typ.nbool Is_P_O_Box_Zip_;
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
  SHARED __ST206005_Layout __ND6848160__Project(__ST1276539_Layout __PP6846680) := TRANSFORM
    __EE6848155 := __PP6846680.Bestchild_Advo_;
    SELF.College_Flag_ := (__T(__EE6848155))[1].College_Indicator_;
    __EE6848170 := __PP6846680.Bestchild_Advo_;
    SELF.Do_Not_Deliver_Flag_ := (__T(__EE6848170))[1].Do_Not_Deliver_Indicator_;
    __EE6848184 := __PP6846680.Bestchild_Advo_;
    SELF.Drop_Indicator_Flag_ := (__T(__EE6848184))[1].Drop_Indicator_;
    __BS6848190 := __T(__PP6846680.Address_Type_);
    SELF.Is_P_O_Box_A_D_V_O_ := EXISTS(__BS6848190(__T(__OP2(__T(__PP6846680.Address_Type_).Address_Type_Code_,=,__CN('9')))));
    SELF.Is_P_O_Box_Zip_ := __OP2(__PP6846680.Zip_Class_,=,__CN('P'));
    __EE6848217 := __PP6846680.Bestchild_Advo_;
    SELF.Seasonal_Delivery_Flag_ := (__T(__EE6848217))[1].Seasonal_Delivery_Indicator_;
    __EE6848231 := __PP6846680.Bestchild_Advo_;
    SELF.Style_Flag_ := (__T(__EE6848231))[1].Style_Code_;
    __EE6848245 := __PP6846680.Bestchild_Advo_;
    SELF.Throw_Back_Flag_ := (__T(__EE6848245))[1].Throw_Back_Indicator_;
    SELF := __PP6846680;
  END;
  EXPORT __ENH_Address_2 := PROJECT(__EE6848583,__ND6848160__Project(LEFT));
END;
