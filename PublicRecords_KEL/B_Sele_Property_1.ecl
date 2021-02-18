//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Property_Event_2,B_Property_Event_6,B_Sele_Property_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Property,E_Property_Event,E_Sele_Property,E_Sele_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Property_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Property_Event_2(__in,__cfg).__ENH_Property_Event_2) __ENH_Property_Event_2 := B_Property_Event_2(__in,__cfg).__ENH_Property_Event_2;
  SHARED VIRTUAL TYPEOF(B_Sele_Property_2(__in,__cfg).__ENH_Sele_Property_2) __ENH_Sele_Property_2 := B_Sele_Property_2(__in,__cfg).__ENH_Sele_Property_2;
  SHARED VIRTUAL TYPEOF(E_Sele_Property_Event(__in,__cfg).__Result) __E_Sele_Property_Event := E_Sele_Property_Event(__in,__cfg).__Result;
  SHARED __EE8376399 := __ENH_Sele_Property_2;
  SHARED __EE8377669 := __ENH_Property_Event_2;
  SHARED __EE8381611 := __EE8377669(__T(__AND(__EE8377669.Is_Current_Assessment_Record_,__AND(__NOT(__NT(__EE8377669.Building_Area_)),__CN(__NN(__EE8377669.Prop_))))));
  SHARED __EE8376416 := __EE8376399;
  SHARED __EE8377676 := __EE8376416;
  SHARED __EE8380438 := __EE8377676(__NN(__EE8377676.Prop_) AND __NN(__EE8377676.Legal_));
  SHARED __ST2998995_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nbool Is_Deed_;
    KEL.typ.nbool Is_Assessment_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nbool Current_Record_;
    KEL.typ.nstr Mailing_City_State_Zip_;
    KEL.typ.nstr Property_Full_Street_Address_;
    KEL.typ.nstr Property_Address_City_State_Zip_;
    KEL.typ.nstr Standardized_Land_Use_Code_;
    KEL.typ.nbool Occupant_Owned_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nkdate Sale_Date_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nint Mortgage_Amount_;
    KEL.typ.nstr Mortgage_Type_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nint Assessed_Total_Value_;
    KEL.typ.nkdate Assessed_Value_Year_;
    KEL.typ.nint Market_Total_Value_;
    KEL.typ.nkdate Market_Value_Year_;
    KEL.typ.nkdate Tax_Year_;
    KEL.typ.nint Lot_Size_;
    KEL.typ.nfloat Land_Square_Footage_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nkdate Year_Built_;
    KEL.typ.nkdate Effective_Year_Built_;
    KEL.typ.nint Number_Of_Buildings_;
    KEL.typ.nstr Number_Of_Stories_;
    KEL.typ.nint Number_Of_Units_;
    KEL.typ.nint Number_Of_Rooms_;
    KEL.typ.nstr Number_Of_Bedrooms_;
    KEL.typ.nfloat Number_Of_Baths_;
    KEL.typ.nstr Number_Of_Partial_Baths_;
    KEL.typ.nstr Garage_Type_Code_;
    KEL.typ.nint Parking_Number_Of_Cars_;
    KEL.typ.nstr Style_Code_;
    KEL.typ.nbool Fireplace_Indicator_;
    KEL.typ.nkdate Tape_Cut_Date_;
    KEL.typ.nkdate Certification_Date_;
    KEL.typ.nbool L_N_Mobile_Home_Indicator_;
    KEL.typ.nbool L_N_Condo_Indicator_;
    KEL.typ.nbool L_N_Property_Tax_Exemption_Indicator_;
    KEL.typ.nstr Buyer_Or_Borrower_Or_Assessee_;
    KEL.typ.nstr Name1_;
    KEL.typ.nstr Name2_;
    KEL.typ.nkdate Contract_Date_;
    KEL.typ.nbool Timeshare_Flag_;
    KEL.typ.nstr Land_Lot_Size_;
    KEL.typ.nbool Additional_Name_Flag_;
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nint Current_Lot_Size_Assessments_;
    KEL.typ.nfloat Current_Lot_Size_Deeds_;
    KEL.typ.nint Current_Market_Value_;
    KEL.typ.nint Current_Tax_Value_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_First_Seen_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC8381617(B_Property_Event_6(__in,__cfg).__ST254054_Layout __EE8381611, B_Sele_Property_2(__in,__cfg).__ST217930_Layout __EE8380438) := __EEQP(__EE8380438.Prop_,__EE8381611.Prop_);
  __ST2998995_Layout __JT8381617(B_Property_Event_6(__in,__cfg).__ST254054_Layout __l, B_Sele_Property_2(__in,__cfg).__ST217930_Layout __r) := TRANSFORM
    SELF.Prop__1_ := __r.Prop_;
    SELF.Primary_Range__1_ := __r.Primary_Range_;
    SELF.Predirectional__1_ := __r.Predirectional_;
    SELF.Primary_Name__1_ := __r.Primary_Name_;
    SELF.Suffix__1_ := __r.Suffix_;
    SELF.Postdirectional__1_ := __r.Postdirectional_;
    SELF.Secondary_Range__1_ := __r.Secondary_Range_;
    SELF.Z_I_P5__1_ := __r.Z_I_P5_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE8381739 := JOIN(__EE8380438,__EE8381611,__JC8381617(RIGHT,LEFT),__JT8381617(RIGHT,LEFT),INNER,HASH);
  SHARED __EE8377671 := __E_Sele_Property_Event;
  SHARED __EE8380641 := __EE8377671(__NN(__EE8377671.Legal_) AND __NN(__EE8377671.Event_));
  SHARED __EE8380649 := __EE8380641.Party_Details_;
  __JC8380655(E_Sele_Property_Event(__in,__cfg).Party_Details_Layout __EE8380649) := __T(__EE8380649.Party_Is_Buyer_Or_Owner_);
  SHARED __EE8380656 := __EE8380641(EXISTS(__CHILDJOINFILTER(__EE8380649,__JC8380655)));
  __JC8381749(__ST2998995_Layout __EE8381739, E_Sele_Property_Event(__in,__cfg).Layout __EE8380656) := __EEQP(__EE8381739.UID,__EE8380656.Event_) AND __NNEQ(__EE8380656.Legal_,__EE8381739.Legal_) AND __T(__AND(__EEQ(__EE8381739.UID,__EE8380656.Event_),__OP2(__EE8380656.Legal_,=,__EE8381739.Legal_)));
  SHARED __EE8381853 := JOIN(__EE8381739,__EE8380656,__JC8381749(LEFT,RIGHT),TRANSFORM(__ST2998995_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST2997472_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) ____grp___Prop_;
    KEL.typ.ntyp(E_Business_Sele().Typ) ____grp___Legal_;
    KEL.typ.nuid UID;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nbool Is_Deed_;
    KEL.typ.nbool Is_Assessment_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nbool Current_Record_;
    KEL.typ.nstr Mailing_City_State_Zip_;
    KEL.typ.nstr Property_Full_Street_Address_;
    KEL.typ.nstr Property_Address_City_State_Zip_;
    KEL.typ.nstr Standardized_Land_Use_Code_;
    KEL.typ.nbool Occupant_Owned_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nkdate Sale_Date_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nint Mortgage_Amount_;
    KEL.typ.nstr Mortgage_Type_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nint Assessed_Total_Value_;
    KEL.typ.nkdate Assessed_Value_Year_;
    KEL.typ.nint Market_Total_Value_;
    KEL.typ.nkdate Market_Value_Year_;
    KEL.typ.nkdate Tax_Year_;
    KEL.typ.nint Lot_Size_;
    KEL.typ.nfloat Land_Square_Footage_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nkdate Year_Built_;
    KEL.typ.nkdate Effective_Year_Built_;
    KEL.typ.nint Number_Of_Buildings_;
    KEL.typ.nstr Number_Of_Stories_;
    KEL.typ.nint Number_Of_Units_;
    KEL.typ.nint Number_Of_Rooms_;
    KEL.typ.nstr Number_Of_Bedrooms_;
    KEL.typ.nfloat Number_Of_Baths_;
    KEL.typ.nstr Number_Of_Partial_Baths_;
    KEL.typ.nstr Garage_Type_Code_;
    KEL.typ.nint Parking_Number_Of_Cars_;
    KEL.typ.nstr Style_Code_;
    KEL.typ.nbool Fireplace_Indicator_;
    KEL.typ.nkdate Tape_Cut_Date_;
    KEL.typ.nkdate Certification_Date_;
    KEL.typ.nbool L_N_Mobile_Home_Indicator_;
    KEL.typ.nbool L_N_Condo_Indicator_;
    KEL.typ.nbool L_N_Property_Tax_Exemption_Indicator_;
    KEL.typ.nstr Buyer_Or_Borrower_Or_Assessee_;
    KEL.typ.nstr Name1_;
    KEL.typ.nstr Name2_;
    KEL.typ.nkdate Contract_Date_;
    KEL.typ.nbool Timeshare_Flag_;
    KEL.typ.nstr Land_Lot_Size_;
    KEL.typ.nbool Additional_Name_Flag_;
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST2997472_Layout __ND8381858__Project(__ST2998995_Layout __PP8381854) := TRANSFORM
    SELF.____grp___Prop_ := __PP8381854.Prop__1_;
    SELF.____grp___Legal_ := __PP8381854.Legal_;
    SELF := __PP8381854;
  END;
  SHARED __ST2997472_Layout __ND8381858__Rollup(__ST2997472_Layout __r, DATASET(__ST2997472_Layout) __recs) := TRANSFORM
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  SHARED __EE8382127 := ROLLUP(GROUP(DISTRIBUTE(PROJECT(__EE8381853,__ND8381858__Project(LEFT)),HASH(UID)),____grp___Prop_,____grp___Legal_,UID,Prop_,LOCAL,ALL),GROUP,__ND8381858__Rollup(LEFT, ROWS(LEFT)));
  SHARED __EE8382138 := GROUP(KEL.Routines.SortChildren(__EE8382127,'Data_Sources_'),____grp___Prop_,____grp___Legal_,ALL);
  SHARED __EE8382151 := UNGROUP(TOPN(__EE8382138(__NN(__EE8382138.Dt_First_Seen_) AND __NN(__EE8382138.Building_Area_)),1, -__T(__EE8382138.Dt_First_Seen_), -__T(__EE8382138.Building_Area_),__T(UID),__T(____grp___Legal_),__T(____grp___Prop_)));
  SHARED __ST2996768_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nuid UID;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.nbool Is_Deed_;
    KEL.typ.nbool Is_Assessment_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nbool Current_Record_;
    KEL.typ.nstr Mailing_City_State_Zip_;
    KEL.typ.nstr Property_Full_Street_Address_;
    KEL.typ.nstr Property_Address_City_State_Zip_;
    KEL.typ.nstr Standardized_Land_Use_Code_;
    KEL.typ.nbool Occupant_Owned_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nkdate Sale_Date_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nint Mortgage_Amount_;
    KEL.typ.nstr Mortgage_Type_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nint Assessed_Total_Value_;
    KEL.typ.nkdate Assessed_Value_Year_;
    KEL.typ.nint Market_Total_Value_;
    KEL.typ.nkdate Market_Value_Year_;
    KEL.typ.nkdate Tax_Year_;
    KEL.typ.nint Lot_Size_;
    KEL.typ.nfloat Land_Square_Footage_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nkdate Year_Built_;
    KEL.typ.nkdate Effective_Year_Built_;
    KEL.typ.nint Number_Of_Buildings_;
    KEL.typ.nstr Number_Of_Stories_;
    KEL.typ.nint Number_Of_Units_;
    KEL.typ.nint Number_Of_Rooms_;
    KEL.typ.nstr Number_Of_Bedrooms_;
    KEL.typ.nfloat Number_Of_Baths_;
    KEL.typ.nstr Number_Of_Partial_Baths_;
    KEL.typ.nstr Garage_Type_Code_;
    KEL.typ.nint Parking_Number_Of_Cars_;
    KEL.typ.nstr Style_Code_;
    KEL.typ.nbool Fireplace_Indicator_;
    KEL.typ.nkdate Tape_Cut_Date_;
    KEL.typ.nkdate Certification_Date_;
    KEL.typ.nbool L_N_Mobile_Home_Indicator_;
    KEL.typ.nbool L_N_Condo_Indicator_;
    KEL.typ.nbool L_N_Property_Tax_Exemption_Indicator_;
    KEL.typ.nstr Buyer_Or_Borrower_Or_Assessee_;
    KEL.typ.nstr Name1_;
    KEL.typ.nstr Name2_;
    KEL.typ.nkdate Contract_Date_;
    KEL.typ.nbool Timeshare_Flag_;
    KEL.typ.nstr Land_Lot_Size_;
    KEL.typ.nbool Additional_Name_Flag_;
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST2996768_Layout __ND8382156__Project(__ST2997472_Layout __PP8382152) := TRANSFORM
    SELF.Legal_ := __PP8382152.____grp___Legal_;
    SELF.Prop_ := __PP8382152.____grp___Prop_;
    SELF.Prop__1_ := __PP8382152.Prop_;
    SELF := __PP8382152;
  END;
  SHARED __EE8382425 := PROJECT(__EE8382151,__ND8382156__Project(LEFT));
  SHARED __ST2996921_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nint Building_Area_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE8382443 := PROJECT(__EE8382425,__ST2996921_Layout);
  SHARED __ST2996958_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nint O_N_L_Y___Building_Area_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE8382461 := PROJECT(__EE8382443,TRANSFORM(__ST2996958_Layout,SELF.O_N_L_Y___Building_Area_ := LEFT.Building_Area_,SELF := LEFT));
  SHARED __ST3000066_Layout := RECORD
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
    KEL.typ.nint Current_Lot_Size_Assessments_;
    KEL.typ.nfloat Current_Lot_Size_Deeds_;
    KEL.typ.nint Current_Market_Value_;
    KEL.typ.nint Current_Tax_Value_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_First_Seen_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.nint O_N_L_Y___Building_Area_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC8382471(B_Sele_Property_2(__in,__cfg).__ST217930_Layout __EE8376399, __ST2996958_Layout __EE8382461) := __EEQP(__EE8376399.Prop_,__EE8382461.Prop_) AND __EEQP(__EE8376399.Legal_,__EE8382461.Legal_);
  __ST3000066_Layout __JT8382471(B_Sele_Property_2(__in,__cfg).__ST217930_Layout __l, __ST2996958_Layout __r) := TRANSFORM
    SELF.Legal__1_ := __r.Legal_;
    SELF.Prop__1_ := __r.Prop_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE8382516 := JOIN(__EE8376399,__EE8382461,__JC8382471(LEFT,RIGHT),__JT8382471(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  EXPORT __ST199343_Layout := RECORD
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
    KEL.typ.nint Current_Building_Size_;
    KEL.typ.nfloat Current_Lot_Size_;
    KEL.typ.nint Current_Market_Value_;
    KEL.typ.nint Current_Overall_Value_;
    KEL.typ.nint Current_Tax_Value_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_First_Seen_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST199343_Layout __ND8382521__Project(__ST3000066_Layout __PP8382517) := TRANSFORM
    SELF.Current_Building_Size_ := __PP8382517.O_N_L_Y___Building_Area_;
    SELF.Current_Lot_Size_ := KEL.Routines.MaxN(__CAST(KEL.typ.float,__PP8382517.Current_Lot_Size_Assessments_),__PP8382517.Current_Lot_Size_Deeds_);
    SELF.Current_Overall_Value_ := KEL.Routines.MaxN(__PP8382517.Current_Tax_Value_,__PP8382517.Current_Market_Value_);
    SELF := __PP8382517;
  END;
  EXPORT __ENH_Sele_Property_1 := PROJECT(__EE8382516,__ND8382521__Project(LEFT));
END;
