//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Property_3,B_Person_Property_7,B_Property_3,B_Property_Event_3,B_Property_Event_6,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Property_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_3(__in,__cfg).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3(__in,__cfg).__ENH_Person_Property_3;
  SHARED VIRTUAL TYPEOF(E_Person_Property_Event(__in,__cfg).__Result) __E_Person_Property_Event := E_Person_Property_Event(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Property_3(__in,__cfg).__ENH_Property_3) __ENH_Property_3 := B_Property_3(__in,__cfg).__ENH_Property_3;
  SHARED VIRTUAL TYPEOF(B_Property_Event_3(__in,__cfg).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3(__in,__cfg).__ENH_Property_Event_3;
  SHARED __EE7704692 := __ENH_Person_Property_3;
  SHARED __EE7704743 := __ENH_Property_Event_3;
  SHARED __EE7710197 := __EE7704743(__T(__AND(__OR(__EE7704743.Is_Deed_,__EE7704743.Is_Assessment_),__CN(__NN(__EE7704743.Prop_)))));
  SHARED __EE7704712 := __EE7704692;
  SHARED __EE7704750 := __EE7704712;
  SHARED __EE7708658 := __EE7704750(__NN(__EE7704750.Prop_) AND __NN(__EE7704750.Subject_));
  SHARED __ST1980904_Layout := RECORD
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
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Person_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    B_Person_Property_7(__in,__cfg).__ST92214_Layout Best_Property_Sale_Info_;
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
    KEL.typ.ndataset(B_Person_Property_7(__in,__cfg).__ST92214_Layout) Property_Sale_Info_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7710203(B_Property_Event_6(__in,__cfg).__ST253400_Layout __EE7710197, B_Person_Property_3(__in,__cfg).__ST230040_Layout __EE7708658) := __EEQP(__EE7708658.Prop_,__EE7710197.Prop_);
  __ST1980904_Layout __JT7710203(B_Property_Event_6(__in,__cfg).__ST253400_Layout __l, B_Person_Property_3(__in,__cfg).__ST230040_Layout __r) := TRANSFORM
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
  SHARED __EE7710332 := JOIN(__EE7708658,__EE7710197,__JC7710203(RIGHT,LEFT),__JT7710203(RIGHT,LEFT),INNER,HASH);
  SHARED __EE7704745 := __E_Person_Property_Event;
  SHARED __EE7708859 := __EE7704745(__NN(__EE7704745.Subject_) AND __NN(__EE7704745.Event_));
  SHARED __EE7708867 := __EE7708859.Party_Details_;
  __JC7708873(E_Person_Property_Event(__in,__cfg).Party_Details_Layout __EE7708867) := __T(__EE7708867.Party_Is_Buyer_Or_Owner_);
  SHARED __EE7708874 := __EE7708859(EXISTS(__CHILDJOINFILTER(__EE7708867,__JC7708873)));
  __JC7710342(__ST1980904_Layout __EE7710332, E_Person_Property_Event(__in,__cfg).Layout __EE7708874) := __EEQP(__EE7710332.UID,__EE7708874.Event_) AND __NNEQ(__EE7708874.Subject_,__EE7710332.Subject_) AND __T(__AND(__EEQ(__EE7710332.UID,__EE7708874.Event_),__OP2(__EE7708874.Subject_,=,__EE7710332.Subject_)));
  SHARED __EE7710453 := JOIN(__EE7710332,__EE7708874,__JC7710342(LEFT,RIGHT),TRANSFORM(__ST1980904_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST1979230_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) ____grp___Prop_;
    KEL.typ.ntyp(E_Person().Typ) ____grp___Subject_;
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
  SHARED __ST1979230_Layout __ND7710458__Project(__ST1980904_Layout __PP7710454) := TRANSFORM
    SELF.____grp___Prop_ := __PP7710454.Prop__1_;
    SELF.____grp___Subject_ := __PP7710454.Subject_;
    SELF := __PP7710454;
  END;
  SHARED __ST1979230_Layout __ND7710458__Rollup(__ST1979230_Layout __r, DATASET(__ST1979230_Layout) __recs) := TRANSFORM
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  SHARED __EE7710727 := ROLLUP(GROUP(DISTRIBUTE(PROJECT(__EE7710453,__ND7710458__Project(LEFT)),HASH(UID)),____grp___Prop_,____grp___Subject_,UID,Prop_,LOCAL,ALL),GROUP,__ND7710458__Rollup(LEFT, ROWS(LEFT)));
  SHARED __EE7710738 := GROUP(KEL.Routines.SortChildren(__EE7710727,'Data_Sources_'),____grp___Prop_,____grp___Subject_,ALL);
  SHARED __EE7710752 := UNGROUP(TOPN(__EE7710738(__NN(__OP2(__EE7710738.Vendor_Source_Code_,IN,__CN(['F','S']))) AND __NN(__EE7710738.Dt_First_Seen_)),1,__T(__OP2(__EE7710738.Vendor_Source_Code_,IN,__CN(['F','S']))), -__T(__EE7710738.Dt_First_Seen_),__T(UID),__T(____grp___Subject_),__T(____grp___Prop_)));
  SHARED __ST1978521_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
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
  SHARED __ST1978521_Layout __ND7710757__Project(__ST1979230_Layout __PP7710753) := TRANSFORM
    SELF.Prop_ := __PP7710753.____grp___Prop_;
    SELF.Subject_ := __PP7710753.____grp___Subject_;
    SELF.Prop__1_ := __PP7710753.Prop_;
    SELF := __PP7710753;
  END;
  SHARED __EE7711026 := PROJECT(__EE7710752,__ND7710757__Project(LEFT));
  SHARED __ST1978674_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nuid UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE7711044 := PROJECT(__EE7711026,__ST1978674_Layout);
  SHARED __ST1978710_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE7711063 := PROJECT(__EE7711044,TRANSFORM(__ST1978710_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.UID,SELF := LEFT));
  SHARED __ST1981990_Layout := RECORD
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
    B_Person_Property_7(__in,__cfg).__ST92214_Layout Best_Property_Sale_Info_;
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
    KEL.typ.ndataset(B_Person_Property_7(__in,__cfg).__ST92214_Layout) Property_Sale_Info_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Property_Event().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7711073(B_Person_Property_3(__in,__cfg).__ST230040_Layout __EE7704692, __ST1978710_Layout __EE7711063) := __EEQP(__EE7704692.Subject_,__EE7711063.Subject_) AND __EEQP(__EE7704692.Prop_,__EE7711063.Prop_);
  __ST1981990_Layout __JT7711073(B_Person_Property_3(__in,__cfg).__ST230040_Layout __l, __ST1978710_Layout __r) := TRANSFORM
    SELF.Prop__1_ := __r.Prop_;
    SELF.Subject__1_ := __r.Subject_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7711125 := JOIN(__EE7704692,__EE7711063,__JC7711073(LEFT,RIGHT),__JT7711073(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE7705614 := __ENH_Property_3;
  SHARED __ST1980309_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(B_Property_3(__in,__cfg).__ST230574_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Is_Business_Address_ := FALSE;
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
  __ST1980309_Layout __JT7705625(B_Property_3(__in,__cfg).__ST230556_Layout __l, B_Property_3(__in,__cfg).__ST230574_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7705678 := NORMALIZE(__EE7705614,__T(LEFT.Automated_Valuation_Model_),__JT7705625(LEFT,RIGHT));
  SHARED __ST1982518_Layout := RECORD
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
    B_Person_Property_7(__in,__cfg).__ST92214_Layout Best_Property_Sale_Info_;
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
    KEL.typ.ndataset(B_Person_Property_7(__in,__cfg).__ST92214_Layout) Property_Sale_Info_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Property_Event().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ndataset(__ST1980309_Layout) Property_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7711131(__ST1981990_Layout __EE7711125, __ST1980309_Layout __EE7705678) := __EEQP(__EE7711125.Prop_,__EE7705678.UID);
  __ST1982518_Layout __Join__ST1982518_Layout(__ST1981990_Layout __r, DATASET(__ST1980309_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Property_ := __CN(__recs);
  END;
  SHARED __EE7711232 := DENORMALIZE(DISTRIBUTE(__EE7711125,HASH(Prop_)),DISTRIBUTE(__EE7705678,HASH(UID)),__JC7711131(LEFT,RIGHT),GROUP,__Join__ST1982518_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST215203_Layout := RECORD
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
    B_Property_3(__in,__cfg).__ST230574_Layout Best_Most_Recent_Property_;
    KEL.typ.ntyp(E_Property_Event().Typ) Best_Most_Recent_Property_Event_;
    B_Person_Property_7(__in,__cfg).__ST92214_Layout Best_Property_Sale_Info_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST215203_Layout __ND7711241__Project(__ST1982518_Layout __PP7711237) := TRANSFORM
    __EE7711235 := __PP7711237.Property_;
    __EE7711372 := PROJECT(TABLE(PROJECT(__T(__EE7711235),B_Property_3(__in,__cfg).__ST230574_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_,A_V_M_Value_Date_,A_V_M_Years_},A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_,A_V_M_Value_Date_,A_V_M_Years_,MERGE),B_Property_3(__in,__cfg).__ST230574_Layout);
    __EE7711382 := TOPN(__EE7711372(__NN(__EE7711372.A_V_M_Value_Date_)),1, -__T(__EE7711372.A_V_M_Value_Date_),__T(A_V_M_Unformatted_A_P_N_),__T(A_V_M_Land_Use_Code_),__T(A_V_M_Recording_Date_),__T(A_V_M_Assessed_Value_Year_),__T(A_V_M_Sales_Price_),__T(A_V_M_Assessed_Total_Value_),__T(A_V_M_Market_Total_Value_),__T(A_V_M_Tax_Assessment_Valuation_),__T(A_V_M_Price_Index_Valuation_),__T(A_V_M_Hedonic_Valuation_),__T(A_V_M_Automated_Valuation_),__T(A_V_M_Confidence_Score_),__T(A_V_M_Current_Flag_));
    __EE7711384 := __EE7711382;
    SELF.Best_Most_Recent_Property_ := (__EE7711384)[1];
    SELF.Best_Most_Recent_Property_Event_ := __PP7711237.O_N_L_Y___U_I_D_;
    SELF := __PP7711237;
  END;
  EXPORT __ENH_Person_Property_2 := PROJECT(__EE7711232,__ND7711241__Project(LEFT));
END;
