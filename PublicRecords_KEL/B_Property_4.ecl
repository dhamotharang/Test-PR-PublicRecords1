//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_5,B_Property_5,CFG_Compile,E_Address,E_Address_Property,E_Geo_Link,E_Property,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_5(__in,__cfg).__ENH_Address_5) __ENH_Address_5 := B_Address_5(__in,__cfg).__ENH_Address_5;
  SHARED VIRTUAL TYPEOF(E_Address_Property(__in,__cfg).__Result) __E_Address_Property := E_Address_Property(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Property_5(__in,__cfg).__ENH_Property_5) __ENH_Property_5 := B_Property_5(__in,__cfg).__ENH_Property_5;
  SHARED __EE5424541 := __ENH_Property_5;
  SHARED __ST725707_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(B_Property_5(__in,__cfg).__ST251096_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Address_Property_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE725046 := __E_Address_Property;
  SHARED __EE5425382 := __EE725046(__NN(__EE725046.Location_) AND __NN(__EE725046.Prop_));
  SHARED __EE5424544 := __ENH_Address_5;
  SHARED __EE5424552 := __EE5424544.A_D_V_O_Summary_;
  __JC5425767(E_Address(__in,__cfg).A_D_V_O_Summary_Layout __EE5424552) := __T(__OP2(__EE5424552.Residential_Or_Business_Indicator_,IN,__CN(['B','D'])));
  SHARED __EE5425768 := __EE5424544(EXISTS(__CHILDJOINFILTER(__EE5424552,__JC5425767)));
  __JC5425921(E_Address_Property(__in,__cfg).Layout __EE5425382, B_Address_5(__in,__cfg).__ST245912_Layout __EE5425768) := __EEQP(__EE5425382.Location_,__EE5425768.UID);
  SHARED __EE5425945 := JOIN(__EE5425382,__EE5425768,__JC5425921(LEFT,RIGHT),TRANSFORM(E_Address_Property(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC5425951(B_Property_5(__in,__cfg).__ST251078_Layout __EE5424541, E_Address_Property(__in,__cfg).Layout __EE5425945) := __EEQP(__EE5424541.UID,__EE5425945.Prop_);
  __JF5425951(E_Address_Property(__in,__cfg).Layout __EE5425945) := __NN(__EE5425945.Prop_);
  SHARED __EE5425988 := JOIN(__EE5424541,__EE5425945,__JC5425951(LEFT,RIGHT),TRANSFORM(__ST725707_Layout,SELF:=LEFT,SELF.Address_Property_:=__JF5425951(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST244457_Layout := RECORD
    KEL.typ.nstr A_V_M_Unformatted_A_P_N_;
    KEL.typ.nint A_V_M_Land_Use_Code_;
    KEL.typ.nkdate A_V_M_Recording_Date_;
    KEL.typ.nkdate A_V_M_Assessed_Value_Year_;
    KEL.typ.nint A_V_M_Sales_Price_;
    KEL.typ.nint A_V_M_Assessed_Total_Value_;
    KEL.typ.nint A_V_M_Market_Total_Value_;
    KEL.typ.nint A_V_M_Tax_Assessment_Valuation_;
    KEL.typ.nint A_V_M_Price_Index_Valuation_;
    KEL.typ.nint A_V_M_Hedonic_Valuation_;
    KEL.typ.nint A_V_M_Automated_Valuation_;
    KEL.typ.nint A_V_M_Confidence_Score_;
    KEL.typ.nbool A_V_M_Current_Flag_;
    KEL.typ.nkdate A_V_M_Value_Date_;
    KEL.typ.nint A_V_M_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST244439_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(__ST244457_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Business_Address_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST244439_Layout __ND5425997__Project(__ST725707_Layout __PP5425993) := TRANSFORM
    __EE5425991 := __PP5425993.Automated_Valuation_Model_;
    __ST244457_Layout __ND5426041__Project(B_Property_5(__in,__cfg).__ST251096_Layout __PP5426037) := TRANSFORM
      __CC13175 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('property_build_version'))),__CN(__cfg.CurrentDate));
      SELF.A_V_M_Years_ := FN_Compile(__cfg).FN_A_B_S_Y_E_A_R_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP5426037.A_V_M_Value_Date_),__ECAST(KEL.typ.nkdate,__CC13175));
      SELF := __PP5426037;
    END;
    SELF.Automated_Valuation_Model_ := __PROJECT(__EE5425991,__ND5426041__Project(LEFT));
    SELF.Is_Business_Address_ := __PP5425993.Address_Property_;
    SELF := __PP5425993;
  END;
  EXPORT __ENH_Property_4 := PROJECT(__EE5425988,__ND5425997__Project(LEFT));
END;
