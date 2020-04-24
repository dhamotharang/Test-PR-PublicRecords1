﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Property,E_Property_Event,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Property_Event_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Property_Event().__Result) __E_Property_Event := E_Property_Event(__in,__cfg).__Result;
  SHARED __EE479546 := __E_Property_Event;
  EXPORT __ST160280_Layout := RECORD
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
    KEL.typ.nbool Is_Additional_Fares_Deed_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Vendor_Source_Code_;
    KEL.typ.nbool Current_Record_;
    KEL.typ.nstr F_I_P_S_Code_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_Name_;
    KEL.typ.nstr Old_A_P_N_;
    KEL.typ.nstr A_P_N_Number_;
    KEL.typ.nstr Fares_Unformatted_A_P_N_;
    KEL.typ.nstr Duplicate_Apn_With_Different_Address_Counter_;
    KEL.typ.nstr Assessee_Name_;
    KEL.typ.nstr Second_Assessee_Name_;
    KEL.typ.nstr Ownership_Method_Code_;
    KEL.typ.nstr Owners_Relationship_Code_;
    KEL.typ.nstr Owner_Phone_Number_;
    KEL.typ.nstr Tax_Account_Number_;
    KEL.typ.nstr Name1_I_D_Code_;
    KEL.typ.nstr Name2_I_D_Code_;
    KEL.typ.nstr Mailing_Care_Of_Name_Type_Code_;
    KEL.typ.nstr Mailing_Care_Of_Name_;
    KEL.typ.nstr Mailing_Full_Street_Address_;
    KEL.typ.nstr Mailing_Unit_Number_;
    KEL.typ.nstr Mailing_City_State_Zip_;
    KEL.typ.nstr Property_Full_Street_Address_;
    KEL.typ.nstr Property_Address_Unit_Number_;
    KEL.typ.nstr Property_Address_City_State_Zip_;
    KEL.typ.nstr Property_Address_Country_Code_;
    KEL.typ.nstr Property_Address_Code_;
    KEL.typ.nstr Legal_Lot_Code_;
    KEL.typ.nstr Legal_Lot_Number_;
    KEL.typ.nint Legal_Land_Lot_;
    KEL.typ.nstr Legal_Block_;
    KEL.typ.nstr Legal_Section_;
    KEL.typ.nstr Legal_District_;
    KEL.typ.nstr Legal_Unit_;
    KEL.typ.nstr Legal_City_Municipality_Township_;
    KEL.typ.nstr Legal_Subdivision_Name_;
    KEL.typ.nstr Legal_Phase_Number_;
    KEL.typ.nint Legal_Tract_Number_;
    KEL.typ.nstr Legal_Section_Township_Range_Meridian_;
    KEL.typ.nstr Legal_Brief_Description_;
    KEL.typ.nstr Map_Reference_;
    KEL.typ.nstr Census_Tract_;
    KEL.typ.nstr Record_Type_Code_;
    KEL.typ.nstr Ownership_Type_Code_;
    KEL.typ.nstr New_Record_Type_Code_;
    KEL.typ.nstr State_Land_Use_Code_;
    KEL.typ.nstr County_Land_Use_Code_;
    KEL.typ.nstr County_Land_Use_Description_;
    KEL.typ.nstr Standardized_Land_Use_Code_;
    KEL.typ.nstr Timeshare_Code_;
    KEL.typ.nstr Zoning_;
    KEL.typ.nbool Occupant_Owned_;
    KEL.typ.nint Document_Number_;
    KEL.typ.nint Recorder_Book_Number_;
    KEL.typ.nint Recorder_Page_Number_;
    KEL.typ.nkdate Transfer_Date_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nkdate Sale_Date_;
    KEL.typ.nstr Document_Type_Code_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nstr Sale_Price_Code_;
    KEL.typ.nint Mortgage_Amount_;
    KEL.typ.nstr Mortgage_Type_;
    KEL.typ.nstr Mortgage_Lender_Name_;
    KEL.typ.nstr Lender_I_D_Code_;
    KEL.typ.nkdate Prior_Transfer_Date_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nstr Previous_Sale_Price_Code_;
    KEL.typ.nint Assessed_Land_Value_;
    KEL.typ.nint Assessed_Improvement_Value_;
    KEL.typ.nint Assessed_Total_Value_;
    KEL.typ.nkdate Assessed_Value_Year_;
    KEL.typ.nint Market_Land_Value_;
    KEL.typ.nint Market_Improvement_Value_;
    KEL.typ.nint Market_Total_Value_;
    KEL.typ.nkdate Market_Value_Year_;
    KEL.typ.nstr Tax_Exemption_Code1_;
    KEL.typ.nstr Tax_Exemption_Code2_;
    KEL.typ.nstr Tax_Exemption_Code3_;
    KEL.typ.nstr Tax_Exemption_Code4_;
    KEL.typ.nstr Tax_Rate_Code_Area_;
    KEL.typ.nint Tax_Amount_;
    KEL.typ.nkdate Tax_Year_;
    KEL.typ.nkdate Tax_Delinquent_Year_;
    KEL.typ.nstr School_Tax_District1_;
    KEL.typ.nstr School_Tax_District2_;
    KEL.typ.nstr School_Tax_District3_;
    KEL.typ.nstr School_Tax_District_Indicator1_;
    KEL.typ.nstr School_Tax_District_Indicator2_;
    KEL.typ.nstr School_Tax_District_Indicator3_;
    KEL.typ.nint Lot_Size_;
    KEL.typ.nint Lot_Size_Acres_;
    KEL.typ.nint Lot_Size_Frontage_Feet_;
    KEL.typ.nint Lot_Size_Depth_Feet_;
    KEL.typ.nfloat Land_Acres_;
    KEL.typ.nfloat Land_Square_Footage_;
    KEL.typ.nstr Land_Dimensions_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nint Building_Area1_;
    KEL.typ.nint Building_Area2_;
    KEL.typ.nint Building_Area3_;
    KEL.typ.nint Building_Area4_;
    KEL.typ.nint Building_Area5_;
    KEL.typ.nint Building_Area6_;
    KEL.typ.nint Building_Area7_;
    KEL.typ.nstr Building_Area_Indicator_;
    KEL.typ.nstr Building_Area_Indicator1_;
    KEL.typ.nstr Building_Area_Indicator2_;
    KEL.typ.nstr Building_Area_Indicator3_;
    KEL.typ.nstr Building_Area_Indicator4_;
    KEL.typ.nstr Building_Area_Indicator5_;
    KEL.typ.nstr Building_Area_Indicator6_;
    KEL.typ.nstr Building_Area_Indicator7_;
    KEL.typ.nkdate Year_Built_;
    KEL.typ.nkdate Effective_Year_Built_;
    KEL.typ.nint Number_Of_Buildings_;
    KEL.typ.nstr Number_Of_Stories_;
    KEL.typ.nint Number_Of_Units_;
    KEL.typ.nint Number_Of_Rooms_;
    KEL.typ.nstr Number_Of_Bedrooms_;
    KEL.typ.nfloat Number_Of_Baths_;
    KEL.typ.nstr Number_Of_Partial_Baths_;
    KEL.typ.nint Number_Of_Plumbing_Fixtures_;
    KEL.typ.nstr Garage_Type_Code_;
    KEL.typ.nint Parking_Number_Of_Cars_;
    KEL.typ.nstr Pool_Code_;
    KEL.typ.nstr Style_Code_;
    KEL.typ.nstr Type_Construction_Code_;
    KEL.typ.nstr Foundation_Code_;
    KEL.typ.nstr Building_Quality_Code_;
    KEL.typ.nstr Building_Condition_Code_;
    KEL.typ.nstr Exterior_Walls_Code_;
    KEL.typ.nstr Interior_Walls_Code_;
    KEL.typ.nstr Roof_Cover_Code_;
    KEL.typ.nstr Roof_Type_Code_;
    KEL.typ.nstr Floor_Cover_Code_;
    KEL.typ.nstr Water_Code_;
    KEL.typ.nstr Sewer_Code_;
    KEL.typ.nstr Heating_Code_;
    KEL.typ.nstr Heating_Fuel_Type_Code_;
    KEL.typ.nstr Air_Conditioning_Code_;
    KEL.typ.nstr Air_Conditioning_Type_Code_;
    KEL.typ.nstr Elevator_;
    KEL.typ.nbool Fireplace_Indicator_;
    KEL.typ.nint Fireplace_Number_;
    KEL.typ.nstr Basement_Code_;
    KEL.typ.nstr Building_Class_Code_;
    KEL.typ.nstr Site_Influence_Code1_;
    KEL.typ.nstr Site_Influence_Code2_;
    KEL.typ.nstr Site_Influence_Code3_;
    KEL.typ.nstr Site_Influence_Code4_;
    KEL.typ.nstr Site_Influence_Code5_;
    KEL.typ.nstr Amenity_Code1_;
    KEL.typ.nstr Amenity_Code2_;
    KEL.typ.nstr Amenity_Code3_;
    KEL.typ.nstr Amenity_Code4_;
    KEL.typ.nstr Amenity_Code5_;
    KEL.typ.nstr Amenity_Code6_;
    KEL.typ.nstr Amenity_Code7_;
    KEL.typ.nstr Amenity_Code8_;
    KEL.typ.nstr Amenity_Code9_;
    KEL.typ.nstr Amenity_Code10_;
    KEL.typ.nstr Extra_Feature_Area1_;
    KEL.typ.nstr Extra_Feature_Area2_;
    KEL.typ.nstr Extra_Feature_Area3_;
    KEL.typ.nstr Extra_Feature_Area4_;
    KEL.typ.nstr Extra_Feature_Indicator1_;
    KEL.typ.nstr Extra_Feature_Indicator2_;
    KEL.typ.nstr Extra_Feature_Indicator3_;
    KEL.typ.nstr Extra_Feature_Indicator4_;
    KEL.typ.nstr Other_Building_Code1_;
    KEL.typ.nstr Other_Building_Code2_;
    KEL.typ.nstr Other_Building_Code3_;
    KEL.typ.nstr Other_Building_Code4_;
    KEL.typ.nstr Other_Building_Code5_;
    KEL.typ.nstr Other_Important_Building_Indicator1_;
    KEL.typ.nstr Other_Important_Building_Indicator2_;
    KEL.typ.nstr Other_Important_Building_Indicator3_;
    KEL.typ.nstr Other_Important_Building_Indicator4_;
    KEL.typ.nstr Other_Important_Building_Indicator5_;
    KEL.typ.nstr Other_Important_Building_Area1_;
    KEL.typ.nstr Other_Important_Building_Area2_;
    KEL.typ.nstr Other_Important_Building_Area3_;
    KEL.typ.nstr Other_Important_Building_Area4_;
    KEL.typ.nstr Other_Important_Building_Area5_;
    KEL.typ.nstr Topography_Code_;
    KEL.typ.nstr Neighborhood_Code_;
    KEL.typ.nstr Condo_Project_Or_Building_Name_;
    KEL.typ.nstr Assessee_Name_Indicator_;
    KEL.typ.nstr Second_Assessee_Name_Indicator_;
    KEL.typ.nstr Other_Rooms_Indicator_;
    KEL.typ.nstr Mail_Care_Of_Name_Indicator_;
    KEL.typ.nstr Comments_;
    KEL.typ.nkdate Tape_Cut_Date_;
    KEL.typ.nkdate Certification_Date_;
    KEL.typ.nint Edition_Number_;
    KEL.typ.nstr Property_Address_Propegated_Indicator_;
    KEL.typ.nstr L_N_Ownership_Rights_;
    KEL.typ.nstr L_N_Relationship_Type_;
    KEL.typ.nstr L_N_Mailing_Country_Code_;
    KEL.typ.nstr L_N_Property_Name_;
    KEL.typ.nstr L_N_Property_Name_Type_;
    KEL.typ.nstr L_N_Land_Use_Category_;
    KEL.typ.nstr L_N_Lot_Number_;
    KEL.typ.nstr L_N_Block_Number_;
    KEL.typ.nstr L_N_Unit_Number_;
    KEL.typ.nstr L_N_Subfloor_;
    KEL.typ.nbool L_N_Mobile_Home_Indicator_;
    KEL.typ.nbool L_N_Condo_Indicator_;
    KEL.typ.nbool L_N_Property_Tax_Exemption_Indicator_;
    KEL.typ.nint L_N_Veteran_Status_;
    KEL.typ.nstr Source_File_;
    KEL.typ.nstr Multi_A_P_N_Flag_;
    KEL.typ.nint Tax_Number_;
    KEL.typ.nstr Buyer_Or_Borrower_Or_Assessee_;
    KEL.typ.nstr Name1_;
    KEL.typ.nstr Name1_Code_;
    KEL.typ.nstr Name2_;
    KEL.typ.nstr Name2_Code_;
    KEL.typ.nstr Buyer_Borrower_Vesting_Code_;
    KEL.typ.nstr Buyer_Borrower_Addendum_Flag_;
    KEL.typ.nstr Mailing_Care_Of_;
    KEL.typ.nstr Mailing_Street_;
    KEL.typ.nstr Seller1_;
    KEL.typ.nstr Seller1_I_D_Code_;
    KEL.typ.nstr Seller2_;
    KEL.typ.nstr Seller2_I_D_Code_;
    KEL.typ.nstr Seller_Addendum_Flag_;
    KEL.typ.nstr Seller_Mailing_Full_Street_Address_;
    KEL.typ.nstr Seller_Mailing_Address_Unit_Number_;
    KEL.typ.nstr Seller_Mailing_Address_City_State_Zip_;
    KEL.typ.nstr Legal_Complete_Description_Code_;
    KEL.typ.nkdate Contract_Date_;
    KEL.typ.nkdate Adjustable_Rate_Mortgage_Reset_Date_;
    KEL.typ.nstr Loan_Number_;
    KEL.typ.nstr Concurrent_Mortgage_Book_Page_Document_Number_;
    KEL.typ.nfloat City_Transfer_Tax_;
    KEL.typ.nfloat County_Transfer_Tax_;
    KEL.typ.nfloat Total_Transfer_Tax_;
    KEL.typ.nint Primary_Loan_Amount_;
    KEL.typ.nint Secondary_Loan_Amount_;
    KEL.typ.nstr Primary_Loan_Lender_Type_Code_;
    KEL.typ.nstr Secondary_Loan_Lender_Type_Code_;
    KEL.typ.nstr Primary_Loan_Type_Code_;
    KEL.typ.nstr Type_Financing_;
    KEL.typ.nfloat Primary_Loan_Interest_Rate_;
    KEL.typ.nkdate Primary_Loan_Due_Date_;
    KEL.typ.nstr Title_Company_Name_;
    KEL.typ.nint Partial_Interest_Transferred_;
    KEL.typ.nint Loan_Term_Months_;
    KEL.typ.nint Loan_Term_Years_;
    KEL.typ.nstr Lender_Name_;
    KEL.typ.nstr Lender_D_B_A_Name_;
    KEL.typ.nstr Lender_Full_Street_Address_;
    KEL.typ.nstr Lender_Address_Unit_Number_;
    KEL.typ.nstr Lender_Address_City_State_Zip_;
    KEL.typ.nstr Property_Use_Code_;
    KEL.typ.nstr Condo_Code_;
    KEL.typ.nbool Timeshare_Flag_;
    KEL.typ.nstr Land_Lot_Size_;
    KEL.typ.nstr Rate_Change_Frequency_;
    KEL.typ.nfloat Change_Index_;
    KEL.typ.nstr Adjustable_Rate_Index_;
    KEL.typ.nstr Adjustable_Rate_Rider_;
    KEL.typ.nstr Graduated_Payment_Rider_;
    KEL.typ.nstr Balloon_Rider_;
    KEL.typ.nstr Fixed_Step_Rate_Rider_;
    KEL.typ.nstr Condominium_Rider_;
    KEL.typ.nstr Planned_Unit_Development_Rider_;
    KEL.typ.nstr Assumability_Rider_;
    KEL.typ.nstr Prepayment_Rider_;
    KEL.typ.nstr One_Four_Family_Rider_;
    KEL.typ.nstr Biweekly_Payment_Rider_;
    KEL.typ.nstr Second_Home_Rider_;
    KEL.typ.nstr Data_Source_Code_;
    KEL.typ.nstr Type_Of_Deed_Code_;
    KEL.typ.nbool Additional_Name_Flag_;
    KEL.typ.nstr L_N_Buyer_Mailing_Country_Code_;
    KEL.typ.nstr L_N_Seller_Mailing_Country_Code_;
    KEL.typ.nstr Fares_Owner_Et_Al_Indicator_;
    KEL.typ.nstr Fares_Owner_Relationship_Code_;
    KEL.typ.nstr Fares_Owner_Relationship_Type_;
    KEL.typ.nstr Fares_Match_Code_;
    KEL.typ.nkdate Fares_Document_Year_;
    KEL.typ.nbool Fares_Corporate_Indicator_;
    KEL.typ.nstr Fares_Transaction_Type_;
    KEL.typ.nstr Fares_Lender_Address_;
    KEL.typ.nstr Fares_Sales_Transaction_Code_;
    KEL.typ.nbool Fares_Residential_Model_Ind_;
    KEL.typ.nstr Fares_Mortgage_Deed_Type_;
    KEL.typ.nstr Fares_Mortgage_Term_Code_;
    KEL.typ.nint Fares_Mortgage_Term_;
    KEL.typ.nint Fares_Mortgage_Assumption_Amount_;
    KEL.typ.nstr Fares_Second_Mortgage_Loan_Type_Code_;
    KEL.typ.nstr Fares_Second_Deed_Type_;
    KEL.typ.nstr Fares_Absentee_Indicator_;
    KEL.typ.nbool Fares_Partial_Interest_Indicator_;
    KEL.typ.nstr Fares_Primary_Category_Code_;
    KEL.typ.nstr Fares_Private_Party_Lender_;
    KEL.typ.nstr Fares_Construction_Loan_;
    KEL.typ.nstr Fares_Resale_New_Construction_;
    KEL.typ.nstr Fares_Inter_Family_;
    KEL.typ.nstr Fares_Cash_Mortgage_Purchase_;
    KEL.typ.nint Fares_Building_Square_Feet_;
    KEL.typ.nstr Fares_Foreclosure_;
    KEL.typ.nstr Fares_Refincance_Flag_;
    KEL.typ.nstr Fares_Equity_Flag_;
    KEL.typ.nstr Fares_Iris_A_P_N_;
    KEL.typ.ndataset(E_Property_Event(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Is_Current_Assessment_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST160280_Layout __ND480209__Project(E_Property_Event(__in,__cfg).Layout __PP477894) := TRANSFORM
    __CC9528 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('property_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Is_Current_Assessment_Record_ := __AND(__PP477894.Is_Assessment_,__OP2(FN_Compile(__cfg).FN_A_B_S_Y_E_A_R_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP477894.Date_First_Seen_)),__ECAST(KEL.typ.nkdate,__CC9528)),<=,__CN(1)));
    SELF := __PP477894;
  END;
  EXPORT __ENH_Property_Event_5 := PROJECT(__EE479546,__ND480209__Project(LEFT));
END;
