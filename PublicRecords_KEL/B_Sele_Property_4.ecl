//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Property_Event_5,B_Property_Event_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Property,E_Property_Event,E_Sele_Property,E_Sele_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Property_Event_5(__in,__cfg).__ENH_Property_Event_5) __ENH_Property_Event_5 := B_Property_Event_5(__in,__cfg).__ENH_Property_Event_5;
  SHARED VIRTUAL TYPEOF(E_Sele_Property(__in,__cfg).__Result) __E_Sele_Property := E_Sele_Property(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Sele_Property_Event(__in,__cfg).__Result) __E_Sele_Property_Event := E_Sele_Property_Event(__in,__cfg).__Result;
  SHARED __EE806618 := __E_Sele_Property;
  SHARED __EE807181 := __E_Sele_Property_Event;
  SHARED __EE5920348 := __EE807181(__NN(__EE807181.Legal_) AND __NN(__EE807181.Event_));
  SHARED __EE807080 := __EE806618;
  SHARED __EE5921881 := __EE807080(__NN(__EE807080.Prop_) AND __NN(__EE807080.Legal_));
  SHARED __EE5919194 := __ENH_Property_Event_5;
  SHARED __EE5919201 := __EE5919194(__NN(__EE5919194.Prop_));
  SHARED __ST808181_Layout := RECORD
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
    KEL.typ.nuid UID;
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
    KEL.typ.nbool Property_Purchase_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5921960(E_Sele_Property(__in,__cfg).Layout __EE5921881, B_Property_Event_6(__in,__cfg).__ST269805_Layout __EE5919201) := __EEQP(__EE5921881.Prop_,__EE5919201.Prop_);
  __ST808181_Layout __JT5921960(E_Sele_Property(__in,__cfg).Layout __l, B_Property_Event_6(__in,__cfg).__ST269805_Layout __r) := TRANSFORM
    SELF.Primary_Range__1_ := __r.Primary_Range_;
    SELF.Predirectional__1_ := __r.Predirectional_;
    SELF.Primary_Name__1_ := __r.Primary_Name_;
    SELF.Suffix__1_ := __r.Suffix_;
    SELF.Postdirectional__1_ := __r.Postdirectional_;
    SELF.Z_I_P5__1_ := __r.Z_I_P5_;
    SELF.Secondary_Range__1_ := __r.Secondary_Range_;
    SELF.Prop__1_ := __r.Prop_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5921961 := JOIN(__EE5921881,__EE5919201,__JC5921960(LEFT,RIGHT),__JT5921960(LEFT,RIGHT),INNER,HASH);
  SHARED __ST808335_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property_Event().Typ) Event_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr L_N_Fares_I_D_;
    KEL.typ.ndataset(E_Sele_Property_Event(__in,__cfg).Party_Details_Layout) Party_Details_;
    KEL.typ.ndataset(E_Sele_Property_Event(__in,__cfg).Reported_Dates_Layout) Reported_Dates_;
    KEL.typ.ndataset(E_Sele_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Reported_Dates_Layout) Reported_Dates__1_;
    KEL.typ.ndataset(E_Sele_Property(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nuid UID;
    KEL.typ.nstr L_N_Fares_I_D__1_;
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
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources__2_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.nbool Property_Purchase_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5922089(E_Sele_Property_Event(__in,__cfg).Layout __EE5920348, __ST808181_Layout __EE5921961) := __EEQP(__EE5921961.UID,__EE5920348.Event_) AND __NNEQ(__EE5920348.Legal_,__EE5921961.Legal_) AND __T(__AND(__EEQ(__EE5921961.UID,__EE5920348.Event_),__OP2(__EE5920348.Legal_,=,__EE5921961.Legal_)));
  __ST808335_Layout __JT5922089(E_Sele_Property_Event(__in,__cfg).Layout __l, __ST808181_Layout __r) := TRANSFORM
    SELF.Legal__1_ := __r.Legal_;
    SELF.Ult_I_D__1_ := __r.Ult_I_D_;
    SELF.Org_I_D__1_ := __r.Org_I_D_;
    SELF.Sele_I_D__1_ := __r.Sele_I_D_;
    SELF.Reported_Dates__1_ := __r.Reported_Dates_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF.L_N_Fares_I_D__1_ := __r.L_N_Fares_I_D_;
    SELF.Data_Sources__2_ := __r.Data_Sources__1_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5922090 := JOIN(__EE5920348,__EE5921961,__JC5922089(LEFT,RIGHT),__JT5922089(LEFT,RIGHT),INNER,HASH);
  SHARED __ST807617_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ndataset(E_Sele_Property_Event(__in,__cfg).Party_Details_Layout) Party_Details_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.nbool Is_Deed_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5922260 := PROJECT(__EE5922090,TRANSFORM(__ST807617_Layout,SELF.Legal_ := LEFT.Legal__1_,SELF := LEFT));
  SHARED __ST807704_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.bool Exp3_ := FALSE;
    KEL.typ.bool Exp4_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST807704_Layout __ND5922265__Project(__ST807617_Layout __PP5922261) := TRANSFORM
    __BS5922282 := __T(__PP5922261.Party_Details_);
    SELF.Exp1_ := EXISTS(__BS5922282(__T(__OR(__T(__PP5922261.Party_Details_).Party_Is_Buyer_Or_Owner_,__T(__PP5922261.Party_Details_).Party_Is_Seller_))));
    __BS5922301 := __T(__PP5922261.Party_Details_);
    SELF.Exp2_ := EXISTS(__BS5922301(__T(__AND(__PP5922261.Is_Current_Assessment_Record_,__T(__PP5922261.Party_Details_).Party_Is_Buyer_Or_Owner_))));
    __BS5922319 := __T(__PP5922261.Party_Details_);
    SELF.Exp3_ := EXISTS(__BS5922319(__T(__AND(__PP5922261.Is_Deed_,__T(__PP5922261.Party_Details_).Party_Is_Buyer_Or_Owner_))));
    __BS5922337 := __T(__PP5922261.Party_Details_);
    SELF.Exp4_ := EXISTS(__BS5922337(__T(__T(__PP5922261.Party_Details_).Party_Is_Seller_)));
    SELF := __PP5922261;
  END;
  SHARED __EE5922352 := PROJECT(__EE5922260,__ND5922265__Project(LEFT));
  SHARED __ST807738_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Sele_Property_Event_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__1_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__2_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__3_ := 0;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5922387 := PROJECT(__CLEANANDDO(__EE5922352,TABLE(__EE5922352,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Sele_Property_Event_ := COUNT(GROUP,__EE5922352.Exp1_),KEL.typ.int C_O_U_N_T___Sele_Property_Event__1_ := COUNT(GROUP,__EE5922352.Exp2_),KEL.typ.int C_O_U_N_T___Sele_Property_Event__2_ := COUNT(GROUP,__EE5922352.Exp3_),KEL.typ.int C_O_U_N_T___Sele_Property_Event__3_ := COUNT(GROUP,__EE5922352.Exp4_),Legal_,Prop_},Legal_,Prop_,MERGE)),__ST807738_Layout);
  SHARED __ST808538_Layout := RECORD
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
    KEL.typ.int C_O_U_N_T___Sele_Property_Event_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__1_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__2_ := 0;
    KEL.typ.int C_O_U_N_T___Sele_Property_Event__3_ := 0;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal__1_;
    KEL.typ.ntyp(E_Property().Typ) Prop__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5922397(E_Sele_Property(__in,__cfg).Layout __EE806618, __ST807738_Layout __EE5922387) := __EEQP(__EE806618.Prop_,__EE5922387.Prop_) AND __EEQP(__EE806618.Legal_,__EE5922387.Legal_);
  __ST808538_Layout __JT5922397(E_Sele_Property(__in,__cfg).Layout __l, __ST807738_Layout __r) := TRANSFORM
    SELF.Legal__1_ := __r.Legal_;
    SELF.Prop__1_ := __r.Prop_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5922398 := JOIN(__EE806618,__EE5922387,__JC5922397(LEFT,RIGHT),__JT5922397(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST258408_Layout := RECORD
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
    KEL.typ.bool Is_Ever_Owned_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Assessment_ := FALSE;
    KEL.typ.bool Property_Is_Owned_Deed_ := FALSE;
    KEL.typ.bool Property_Is_Sold_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST258408_Layout __ND5922439__Project(__ST808538_Layout __PP5922399) := TRANSFORM
    SELF.Is_Ever_Owned_ := __PP5922399.C_O_U_N_T___Sele_Property_Event_ <> 0;
    SELF.Property_Is_Owned_Assessment_ := __PP5922399.C_O_U_N_T___Sele_Property_Event__1_ <> 0;
    SELF.Property_Is_Owned_Deed_ := __PP5922399.C_O_U_N_T___Sele_Property_Event__2_ <> 0;
    SELF.Property_Is_Sold_ := __PP5922399.C_O_U_N_T___Sele_Property_Event__3_ <> 0;
    SELF := __PP5922399;
  END;
  EXPORT __ENH_Sele_Property_4 := PROJECT(__EE5922398,__ND5922439__Project(LEFT));
END;
