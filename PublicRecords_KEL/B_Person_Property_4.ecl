﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Property_5,B_Property_5,B_Property_Event_5,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_5(__in,__cfg).__ENH_Person_Property_5) __ENH_Person_Property_5 := B_Person_Property_5(__in,__cfg).__ENH_Person_Property_5;
  SHARED VIRTUAL TYPEOF(E_Person_Property_Event(__in,__cfg).__Result) __E_Person_Property_Event := E_Person_Property_Event(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Property_5(__in,__cfg).__ENH_Property_5) __ENH_Property_5 := B_Property_5(__in,__cfg).__ENH_Property_5;
  SHARED VIRTUAL TYPEOF(B_Property_Event_5(__in,__cfg).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5(__in,__cfg).__ENH_Property_Event_5;
  SHARED __EE4952542 := __ENH_Person_Property_5;
  SHARED __EE4952544 := __EE4952542;
  SHARED __EE4952859 := __EE4952544(__NN(__EE4952544.Subject_) AND __NN(__EE4952544.Prop_));
  SHARED __EE4952546 := __ENH_Property_5;
  SHARED __EE4952548 := __ENH_Property_Event_5;
  SHARED __EE4954551 := __EE4952548(__NN(__EE4952548.Prop_));
  SHARED __EE4952550 := __E_Person_Property_Event;
  SHARED __EE4954603 := __EE4952550(__NN(__EE4952550.Event_) AND __NN(__EE4952550.Subject_));
  SHARED __EE4954614 := __EE4954603.Party_Details_;
  __JC4954623(E_Person_Property_Event(__in,__cfg).Party_Details_Layout __EE4954614) := __T(__OR(__EE4954614.Party_Is_Buyer_Or_Owner_,__EE4954614.Party_Is_Seller_));
  SHARED __EE4954624 := __EE4954603(EXISTS(__CHILDJOINFILTER(__EE4954614,__JC4954623)));
  SHARED __ST4955715_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4955719 := PROJECT(TABLE(PROJECT(__EE4954624,__ST4955715_Layout),{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Subject_,Event_},Subject_,Event_,MERGE),__ST4955715_Layout);
  SHARED __ST4955805_Layout := RECORD
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
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4955730(B_Property_Event_5(__in,__cfg).__ST245943_Layout __EE4954551, __ST4955715_Layout __EE4955719) := __EEQP(__EE4954551.UID,__EE4955719.Event_);
  __ST4955805_Layout __JT4955730(B_Property_Event_5(__in,__cfg).__ST245943_Layout __l, __ST4955715_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4955803 := JOIN(__EE4955719,__EE4954551,__JC4955730(RIGHT,LEFT),__JT4955730(RIGHT,LEFT),INNER,HASH);
  SHARED __ST688170_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(B_Property_5(__in,__cfg).__ST245843_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.nstr Secondary_Range__1_;
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
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4955881(B_Property_5(__in,__cfg).__ST245825_Layout __EE4952546, __ST4955805_Layout __EE4955803) := __EEQP(__EE4952546.UID,__EE4955803.Prop_);
  __ST688170_Layout __JT4955881(B_Property_5(__in,__cfg).__ST245825_Layout __l, __ST4955805_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Primary_Range__1_ := __r.Primary_Range_;
    SELF.Predirectional__1_ := __r.Predirectional_;
    SELF.Primary_Name__1_ := __r.Primary_Name_;
    SELF.Suffix__1_ := __r.Suffix_;
    SELF.Postdirectional__1_ := __r.Postdirectional_;
    SELF.Z_I_P5__1_ := __r.Z_I_P5_;
    SELF.Secondary_Range__1_ := __r.Secondary_Range_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4956004 := JOIN(__EE4955803,__EE4952546,__JC4955881(RIGHT,LEFT),__JT4955881(RIGHT,LEFT),INNER,HASH);
  SHARED __ST4956871_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components__1_;
    KEL.typ.ndataset(B_Property_5(__in,__cfg).__ST245843_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range__2_;
    KEL.typ.nstr Predirectional__2_;
    KEL.typ.nstr Primary_Name__2_;
    KEL.typ.nstr Suffix__2_;
    KEL.typ.nstr Postdirectional__2_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__2_;
    KEL.typ.nstr Secondary_Range__2_;
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
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__2_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST4956871_Layout __ND4956714__Project(__ST688170_Layout __PP4956713) := TRANSFORM
    SELF.Primary_Range__1_ := __PP4956713.Primary_Range_;
    SELF.Predirectional__1_ := __PP4956713.Predirectional_;
    SELF.Primary_Name__1_ := __PP4956713.Primary_Name_;
    SELF.Suffix__1_ := __PP4956713.Suffix_;
    SELF.Postdirectional__1_ := __PP4956713.Postdirectional_;
    SELF.Secondary_Range__1_ := __PP4956713.Secondary_Range_;
    SELF.Z_I_P5__1_ := __PP4956713.Z_I_P5_;
    SELF.Address_Components__1_ := __PP4956713.Address_Components_;
    SELF.Data_Sources__1_ := __PP4956713.Data_Sources_;
    SELF.Primary_Range__2_ := __PP4956713.Primary_Range__1_;
    SELF.Predirectional__2_ := __PP4956713.Predirectional__1_;
    SELF.Primary_Name__2_ := __PP4956713.Primary_Name__1_;
    SELF.Suffix__2_ := __PP4956713.Suffix__1_;
    SELF.Postdirectional__2_ := __PP4956713.Postdirectional__1_;
    SELF.Z_I_P5__2_ := __PP4956713.Z_I_P5__1_;
    SELF.Secondary_Range__2_ := __PP4956713.Secondary_Range__1_;
    SELF.Prop__1_ := __PP4956713.Prop_;
    SELF.Data_Sources__2_ := __PP4956713.Data_Sources__1_;
    SELF.Subject__1_ := __PP4956713.Subject_;
    SELF := __PP4956713;
  END;
  SHARED __EE4956980 := PROJECT(__EE4956004,__ND4956714__Project(LEFT));
  SHARED __ST4956992_Layout := RECORD
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
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.ndataset(B_Person_Property_5(__in,__cfg).__ST93477_Layout) Property_Sale_Info_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.nstr Secondary_Range__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components__1_;
    KEL.typ.ndataset(B_Property_5(__in,__cfg).__ST245843_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range__2_;
    KEL.typ.nstr Predirectional__2_;
    KEL.typ.nstr Primary_Name__2_;
    KEL.typ.nstr Suffix__2_;
    KEL.typ.nstr Postdirectional__2_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__2_;
    KEL.typ.nstr Secondary_Range__2_;
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
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__2_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4956989(B_Person_Property_5(__in,__cfg).__ST245585_Layout __EE4952859, __ST4956871_Layout __EE4956980) := __EEQP(__EE4952859.Prop_,__EE4956980.UID) AND __NNEQ(__EE4956980.Subject__1_,__EE4952859.Subject_) AND __T(__AND(__EEQ(__EE4952859.Prop_,__EE4956980.UID),__OP2(__EE4956980.Subject__1_,=,__EE4952859.Subject_)));
  __ST4956992_Layout __JT4956989(B_Person_Property_5(__in,__cfg).__ST245585_Layout __l, __ST4956871_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4956990 := JOIN(__EE4952859,__EE4956980,__JC4956989(LEFT,RIGHT),__JT4956989(LEFT,RIGHT),INNER,HASH);
  SHARED __ST687249_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(B_Property_5(__in,__cfg).__ST245843_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.nstr Primary_Range__1_;
    KEL.typ.nstr Predirectional__1_;
    KEL.typ.nstr Primary_Name__1_;
    KEL.typ.nstr Suffix__1_;
    KEL.typ.nstr Postdirectional__1_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5__1_;
    KEL.typ.nstr Secondary_Range__1_;
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
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST687249_Layout __ND4957138__Project(__ST4956992_Layout __PP4956991) := TRANSFORM
    SELF.Primary_Range_ := __PP4956991.Primary_Range__1_;
    SELF.Predirectional_ := __PP4956991.Predirectional__1_;
    SELF.Primary_Name_ := __PP4956991.Primary_Name__1_;
    SELF.Suffix_ := __PP4956991.Suffix__1_;
    SELF.Postdirectional_ := __PP4956991.Postdirectional__1_;
    SELF.Secondary_Range_ := __PP4956991.Secondary_Range__1_;
    SELF.Z_I_P5_ := __PP4956991.Z_I_P5__1_;
    SELF.Address_Components_ := __PP4956991.Address_Components__1_;
    SELF.Data_Sources_ := __PP4956991.Data_Sources__1_;
    SELF.Primary_Range__1_ := __PP4956991.Primary_Range__2_;
    SELF.Predirectional__1_ := __PP4956991.Predirectional__2_;
    SELF.Primary_Name__1_ := __PP4956991.Primary_Name__2_;
    SELF.Suffix__1_ := __PP4956991.Suffix__2_;
    SELF.Postdirectional__1_ := __PP4956991.Postdirectional__2_;
    SELF.Z_I_P5__1_ := __PP4956991.Z_I_P5__2_;
    SELF.Secondary_Range__1_ := __PP4956991.Secondary_Range__2_;
    SELF.Data_Sources__1_ := __PP4956991.Data_Sources__2_;
    SELF := __PP4956991;
  END;
  SHARED __ST687249_Layout __ND4957138__Rollup(__ST687249_Layout __r, DATASET(__ST687249_Layout) __recs) := TRANSFORM
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  SHARED __EE4957501 := ROLLUP(GROUP(DISTRIBUTE(PROJECT(__EE4956990,__ND4957138__Project(LEFT)),HASH(UID)),Prop_,Subject_,UID,U_I_D__1_,Prop__1_,LOCAL,ALL),GROUP,__ND4957138__Rollup(LEFT, ROWS(LEFT)));
  SHARED __ST687475_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4957519 := PROJECT(__EE4957501,__ST687475_Layout);
  SHARED __ST687494_Layout := RECORD
    KEL.typ.nkdate M_A_X___Dt_Last_Seen_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE4957539 := PROJECT(__CLEANANDDO(__EE4957519,TABLE(__EE4957519,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.Aggregates.MaxNG(__EE4957519.Dt_Last_Seen_) M_A_X___Dt_Last_Seen_,Prop_,Subject_},Prop_,Subject_,MERGE)),__ST687494_Layout);
  SHARED __ST689382_Layout := RECORD
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
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.ndataset(B_Person_Property_5(__in,__cfg).__ST93477_Layout) Property_Sale_Info_;
    KEL.typ.nkdate M_A_X___Dt_Last_Seen_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4957549(B_Person_Property_5(__in,__cfg).__ST245585_Layout __EE4952542, __ST687494_Layout __EE4957539) := __EEQP(__EE4952542.Subject_,__EE4957539.Subject_) AND __EEQP(__EE4952542.Prop_,__EE4957539.Prop_);
  __ST689382_Layout __JT4957549(B_Person_Property_5(__in,__cfg).__ST245585_Layout __l, __ST687494_Layout __r) := TRANSFORM
    SELF.Prop__1_ := __r.Prop_;
    SELF.Subject__1_ := __r.Subject_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4957588 := JOIN(__EE4952542,__EE4957539,__JC4957549(LEFT,RIGHT),__JT4957549(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST239053_Layout := RECORD
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
    B_Person_Property_5(__in,__cfg).__ST93477_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.ndataset(B_Person_Property_5(__in,__cfg).__ST93477_Layout) Property_Sale_Info_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST239053_Layout __ND4957631__Project(__ST689382_Layout __PP4957589) := TRANSFORM
    __EE4957697 := __PP4957589.Property_Sale_Info_;
    __BS4957701 := __T(__EE4957697);
    __EE4957712 := __BN(TOPN(__BS4957701(__NN(__T(__EE4957697).Dt_First_Seen_) AND __NN(__T(__EE4957697).Sale_Price_)),1, -__T(__T(__EE4957697).Dt_First_Seen_), -__T(__T(__EE4957697).Sale_Price_),__T(L_N_Fares_I_D_)),__NL(__EE4957697));
    __EE4957714 := __EE4957712;
    SELF.Best_Property_Sale_Info_ := IF(__PP4957589.Property_Is_Sold_,(__T(__EE4957714))[1],ROW([],B_Person_Property_5(__in,__cfg).__ST93477_Layout));
    SELF.Is_Currently_Owned_ := (__PP4957589.Property_Is_Owned_Assessment_ OR __PP4957589.Property_Is_Owned_Deed_) AND NOT (__PP4957589.Property_Is_Sold_);
    SELF.Property_Max_Date_Last_Seen_Uncapped_ := __PP4957589.M_A_X___Dt_Last_Seen_;
    SELF := __PP4957589;
  END;
  EXPORT __ENH_Person_Property_4 := PROJECT(__EE4957588,__ND4957631__Project(LEFT));
END;
