//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Property_3,B_Person_Property_7,B_Property_3,B_Property_Event_3,CFG_Compile,E_Person,E_Person_Property,E_Person_Property_Event,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Property_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Property_3(__in,__cfg).__ENH_Person_Property_3) __ENH_Person_Property_3 := B_Person_Property_3(__in,__cfg).__ENH_Person_Property_3;
  SHARED VIRTUAL TYPEOF(E_Person_Property_Event(__in,__cfg).__Result) __E_Person_Property_Event := E_Person_Property_Event(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Property_3(__in,__cfg).__ENH_Property_3) __ENH_Property_3 := B_Property_3(__in,__cfg).__ENH_Property_3;
  SHARED VIRTUAL TYPEOF(B_Property_Event_3(__in,__cfg).__ENH_Property_Event_3) __ENH_Property_Event_3 := B_Property_Event_3(__in,__cfg).__ENH_Property_Event_3;
  SHARED __EE2556689 := __ENH_Person_Property_3;
  SHARED __EE2556740 := __ENH_Property_Event_3;
  SHARED __EE2562304 := __EE2556740(__T(__AND(__OR(__EE2556740.Is_Deed_,__EE2556740.Is_Assessment_),__CN(__NN(__EE2556740.Prop_)))));
  SHARED __EE2556709 := __EE2556689;
  SHARED __EE2556747 := __EE2556709;
  SHARED __EE2560742 := __EE2556747(__NN(__EE2556747.Prop_) AND __NN(__EE2556747.Subject_));
  SHARED __ST794597_Layout := RECORD
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
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.nbool Property_Purchase_Record_;
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
    KEL.typ.nint Age_In_Days_;
    B_Person_Property_7(__in,__cfg).__ST96379_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Purchased_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Previous_Recording_Date_;
    KEL.typ.nint Property_Previous_Sale_Price_;
    KEL.typ.nkdate Property_Purchase_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2562310(B_Property_Event_3(__in,__cfg).__ST172034_Layout __EE2562304, B_Person_Property_3(__in,__cfg).__ST171420_Layout __EE2560742) := __EEQP(__EE2560742.Prop_,__EE2562304.Prop_);
  __ST794597_Layout __JT2562310(B_Property_Event_3(__in,__cfg).__ST172034_Layout __l, B_Person_Property_3(__in,__cfg).__ST171420_Layout __r) := TRANSFORM
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
  SHARED __EE2562442 := JOIN(__EE2560742,__EE2562304,__JC2562310(RIGHT,LEFT),__JT2562310(RIGHT,LEFT),INNER,HASH);
  SHARED __EE2556742 := __E_Person_Property_Event;
  SHARED __EE2560950 := __EE2556742(__NN(__EE2556742.Subject_) AND __NN(__EE2556742.Event_));
  SHARED __EE2560958 := __EE2560950.Party_Details_;
  __JC2560964(E_Person_Property_Event(__in,__cfg).Party_Details_Layout __EE2560958) := __T(__EE2560958.Party_Is_Buyer_Or_Owner_);
  SHARED __EE2560965 := __EE2560950(EXISTS(__CHILDJOINFILTER(__EE2560958,__JC2560964)));
  __JC2562452(__ST794597_Layout __EE2562442, E_Person_Property_Event(__in,__cfg).Layout __EE2560965) := __EEQP(__EE2562442.UID,__EE2560965.Event_) AND __NNEQ(__EE2560965.Subject_,__EE2562442.Subject_) AND __T(__AND(__EEQ(__EE2562442.UID,__EE2560965.Event_),__OP2(__EE2560965.Subject_,=,__EE2562442.Subject_)));
  SHARED __EE2562566 := JOIN(__EE2562442,__EE2560965,__JC2562452(LEFT,RIGHT),TRANSFORM(__ST794597_Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST792908_Layout := RECORD
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
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.nbool Property_Purchase_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST792908_Layout __ND2562571__Project(__ST794597_Layout __PP2562567) := TRANSFORM
    SELF.____grp___Prop_ := __PP2562567.Prop__1_;
    SELF.____grp___Subject_ := __PP2562567.Subject_;
    SELF := __PP2562567;
  END;
  SHARED __ST792908_Layout __ND2562571__Rollup(__ST792908_Layout __r, DATASET(__ST792908_Layout) __recs) := TRANSFORM
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  SHARED __EE2562844 := ROLLUP(GROUP(DISTRIBUTE(PROJECT(__EE2562566,__ND2562571__Project(LEFT)),HASH(UID)),____grp___Prop_,____grp___Subject_,UID,Prop_,LOCAL,ALL),GROUP,__ND2562571__Rollup(LEFT, ROWS(LEFT)));
  SHARED __EE2562855 := GROUP(KEL.Routines.SortChildren(__EE2562844,'Data_Sources_'),____grp___Prop_,____grp___Subject_,ALL);
  SHARED __EE2562869 := UNGROUP(TOPN(__EE2562855(__NN(__OP2(__EE2562855.Vendor_Source_Code_,IN,__CN(['F','S']))) AND __NN(__EE2562855.Dt_First_Seen_)),1,__T(__OP2(__EE2562855.Vendor_Source_Code_,IN,__CN(['F','S']))), -__T(__EE2562855.Dt_First_Seen_),__T(UID),__T(____grp___Subject_),__T(____grp___Prop_)));
  SHARED __ST792191_Layout := RECORD
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
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.nbool Property_Purchase_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST792191_Layout __ND2562874__Project(__ST792908_Layout __PP2562870) := TRANSFORM
    SELF.Prop_ := __PP2562870.____grp___Prop_;
    SELF.Subject_ := __PP2562870.____grp___Subject_;
    SELF.Prop__1_ := __PP2562870.Prop_;
    SELF := __PP2562870;
  END;
  SHARED __EE2563147 := PROJECT(__EE2562869,__ND2562874__Project(LEFT));
  SHARED __ST792346_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nuid UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2563165 := PROJECT(__EE2563147,__ST792346_Layout);
  SHARED __ST792382_Layout := RECORD
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Property_Event().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2563184 := PROJECT(__EE2563165,TRANSFORM(__ST792382_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.UID,SELF := LEFT));
  SHARED __ST795700_Layout := RECORD
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
    KEL.typ.nint Age_In_Days_;
    B_Person_Property_7(__in,__cfg).__ST96379_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Purchased_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Previous_Recording_Date_;
    KEL.typ.nint Property_Previous_Sale_Price_;
    KEL.typ.nkdate Property_Purchase_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
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
  __JC2563194(B_Person_Property_3(__in,__cfg).__ST171420_Layout __EE2556689, __ST792382_Layout __EE2563184) := __EEQP(__EE2556689.Subject_,__EE2563184.Subject_) AND __EEQP(__EE2556689.Prop_,__EE2563184.Prop_);
  __ST795700_Layout __JT2563194(B_Person_Property_3(__in,__cfg).__ST171420_Layout __l, __ST792382_Layout __r) := TRANSFORM
    SELF.Prop__1_ := __r.Prop_;
    SELF.Subject__1_ := __r.Subject_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2563248 := JOIN(__EE2556689,__EE2563184,__JC2563194(LEFT,RIGHT),__JT2563194(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  SHARED __EE2557627 := __ENH_Property_3;
  SHARED __ST794000_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(B_Property_3(__in,__cfg).__ST171929_Layout) Automated_Valuation_Model_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST794000_Layout __JT2557638(B_Property_3(__in,__cfg).__ST171911_Layout __l, B_Property_3(__in,__cfg).__ST171929_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2557689 := NORMALIZE(__EE2557627,__T(LEFT.Automated_Valuation_Model_),__JT2557638(LEFT,RIGHT));
  SHARED __ST796238_Layout := RECORD
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
    KEL.typ.nint Age_In_Days_;
    B_Person_Property_7(__in,__cfg).__ST96379_Layout Best_Property_Sale_Info_;
    KEL.typ.bool Is_Currently_Owned_ := FALSE;
    KEL.typ.bool Is_Currently_Owned_Business_Address_ := FALSE;
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Purchased_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_;
    KEL.typ.nkdate Property_Max_Date_Last_Seen_Uncapped_;
    KEL.typ.nkdate Property_Min_Date_First_Seen_;
    KEL.typ.nkdate Property_Previous_Recording_Date_;
    KEL.typ.nint Property_Previous_Sale_Price_;
    KEL.typ.nkdate Property_Purchase_Date_First_Seen_;
    KEL.typ.nkdate Property_Sale_Date_;
    KEL.typ.nint Property_Sale_Price_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Property_Event().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ndataset(__ST794000_Layout) Property_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2563254(__ST795700_Layout __EE2563248, __ST794000_Layout __EE2557689) := __EEQP(__EE2563248.Prop_,__EE2557689.UID);
  __ST796238_Layout __Join__ST796238_Layout(__ST795700_Layout __r, DATASET(__ST794000_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Property_ := __CN(__recs);
  END;
  SHARED __EE2563355 := DENORMALIZE(DISTRIBUTE(__EE2563248,HASH(Prop_)),DISTRIBUTE(__EE2557689,HASH(UID)),__JC2563254(LEFT,RIGHT),GROUP,__Join__ST796238_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST166956_Layout := RECORD
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
    B_Property_3(__in,__cfg).__ST171929_Layout Best_Most_Recent_Property_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST166956_Layout __ND2563364__Project(__ST796238_Layout __PP2563360) := TRANSFORM
    __EE2563358 := __PP2563360.Property_;
    __EE2563491 := PROJECT(TABLE(PROJECT(__T(__EE2563358),B_Property_3(__in,__cfg).__ST171929_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_,A_V_M_Value_Date_},A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_,A_V_M_Value_Date_,MERGE),B_Property_3(__in,__cfg).__ST171929_Layout);
    __EE2563501 := TOPN(__EE2563491(__NN(__EE2563491.A_V_M_Value_Date_)),1, -__T(__EE2563491.A_V_M_Value_Date_),__T(A_V_M_Unformatted_A_P_N_),__T(A_V_M_Land_Use_Code_),__T(A_V_M_Recording_Date_),__T(A_V_M_Assessed_Value_Year_),__T(A_V_M_Sales_Price_),__T(A_V_M_Assessed_Total_Value_),__T(A_V_M_Market_Total_Value_),__T(A_V_M_Tax_Assessment_Valuation_),__T(A_V_M_Price_Index_Valuation_),__T(A_V_M_Hedonic_Valuation_),__T(A_V_M_Automated_Valuation_),__T(A_V_M_Confidence_Score_),__T(A_V_M_Current_Flag_));
    __EE2563503 := __EE2563501;
    SELF.Best_Most_Recent_Property_ := (__EE2563503)[1];
    SELF.Best_Most_Recent_Property_Event_ := __PP2563360.O_N_L_Y___U_I_D_;
    __CC72772 := 1826;
    SELF.Seen___In___Five___Years_ := __OP2(__PP2563360.Age_In_Days_,<=,__CN(__CC72772));
    __CC72770 := 365;
    SELF.Seen___In___One___Year_ := __OP2(__PP2563360.Age_In_Days_,<=,__CN(__CC72770));
    SELF := __PP2563360;
  END;
  EXPORT __ENH_Person_Property_2 := PROJECT(__EE2563355,__ND2563364__Project(LEFT));
END;
