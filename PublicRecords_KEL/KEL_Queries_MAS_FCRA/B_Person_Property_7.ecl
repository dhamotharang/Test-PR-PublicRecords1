//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Property_8,B_Property_Event_8,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Property_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_8(__in,__cfg).__ENH_Person_Property_8) __ENH_Person_Property_8 := B_Person_Property_8(__in,__cfg).__ENH_Person_Property_8;
  SHARED VIRTUAL TYPEOF(E_Person_Property_Event(__in,__cfg).__Result) __E_Person_Property_Event := E_Person_Property_Event(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Property_Event_8(__in,__cfg).__ENH_Property_Event_8) __ENH_Property_Event_8 := B_Property_Event_8(__in,__cfg).__ENH_Property_Event_8;
  SHARED __EE1091107 := __ENH_Person_Property_8;
  SHARED __EE1091109 := __ENH_Property_Event_8;
  SHARED __EE1091111 := __E_Person_Property_Event;
  SHARED __EE1091965 := __EE1091111(__NN(__EE1091111.Event_) AND __NN(__EE1091111.Subject_));
  SHARED __EE1091979 := __EE1091965.Party_Details_;
  __JC1091982(E_Person_Property_Event(__in,__cfg).Party_Details_Layout __EE1091979) := __T(__EE1091979.Party_Is_Seller_);
  SHARED __EE1091983 := __EE1091965(EXISTS(__CHILDJOINFILTER(__EE1091979,__JC1091982)));
  SHARED __ST224517_Layout := RECORD
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
    KEL.typ.nstr Document_Type_Code_;
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
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nstr L_N_Fares_I_D__1_;
    KEL.typ.ndataset(E_Person_Property_Event(__in,__cfg).Party_Details_Layout) Party_Details_;
    KEL.typ.ndataset(E_Person_Property_Event(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Person_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1092015(B_Property_Event_8(__in,__cfg).__ST175392_Layout __EE1091109, E_Person_Property_Event(__in,__cfg).Layout __EE1091983) := __EEQP(__EE1091109.UID,__EE1091983.Event_);
  __ST224517_Layout __JT1092015(B_Property_Event_8(__in,__cfg).__ST175392_Layout __l, E_Person_Property_Event(__in,__cfg).Layout __r) := TRANSFORM
    SELF.L_N_Fares_I_D__1_ := __r.L_N_Fares_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1092016 := JOIN(__EE1091983,__EE1091109,__JC1092015(RIGHT,LEFT),__JT1092015(RIGHT,LEFT),INNER,HASH);
  SHARED __ST224906_Layout := RECORD
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
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.ndataset(__ST224517_Layout) Property_Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1092596(B_Person_Property_8(__in,__cfg).__ST175297_Layout __EE1091107, __ST224517_Layout __EE1092016) := __EEQP(__EE1091107.Prop_,__EE1092016.Prop_) AND __NNEQ(__EE1092016.Subject_,__EE1091107.Subject_) AND __T(__AND(__EEQ(__EE1091107.Prop_,__EE1092016.Prop_),__AND(__OP2(__EE1092016.Subject_,=,__EE1091107.Subject_),__CN(__NN(__EE1091107.Prop_)))));
  __ST224906_Layout __Join__ST224906_Layout(B_Person_Property_8(__in,__cfg).__ST175297_Layout __r, DATASET(__ST224517_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Property_Event_ := __CN(__recs);
  END;
  SHARED __EE1092707 := DENORMALIZE(DISTRIBUTE(__EE1091107,HASH(Prop_)),DISTRIBUTE(__EE1092016,HASH(Prop_)),__JC1092596(LEFT,RIGHT),GROUP,__Join__ST224906_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST94256_Layout := RECORD
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST174462_Layout := RECORD
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
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.ndataset(__ST94256_Layout) Property_Sale_Info_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST174462_Layout __ND1092716__Project(__ST224906_Layout __PP1092712) := TRANSFORM
    __EE1092710 := __PP1092712.Property_Event_;
    __EE1092803 := IF(__PP1092712.Property_Is_Sold_,__CN(PROJECT(TABLE(PROJECT(__T(__EE1092710),__ST94256_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),L_N_Fares_I_D_,Dt_First_Seen_,Sale_Price_,Previous_Sale_Price_,Previous_Recording_Date_},L_N_Fares_I_D_,Dt_First_Seen_,Sale_Price_,Previous_Sale_Price_,Previous_Recording_Date_,MERGE),__ST94256_Layout)),__N(DATASET(__ST94256_Layout)));
    SELF.Property_Sale_Info_ := __FILTER(__EE1092803,__NN(L_N_Fares_I_D_) OR __NN(Dt_First_Seen_) OR __NN(Sale_Price_) OR __NN(Previous_Sale_Price_) OR __NN(Previous_Recording_Date_));
    SELF := __PP1092712;
  END;
  EXPORT __ENH_Person_Property_7 := PROJECT(__EE1092707,__ND1092716__Project(LEFT));
END;
