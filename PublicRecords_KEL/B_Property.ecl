﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Property,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Property(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Property(__in,__cfg).__Result) __E_Property := E_Property(__in,__cfg).__Result;
  SHARED __EE427769 := __E_Property;
  EXPORT __ST26820_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Ln_Fares_Id_;
    KEL.typ.nint Has_L_N_Owner_;
    KEL.typ.nint Has_Owner_;
    KEL.typ.nint Has_No_Fares_Owner_;
    KEL.typ.nstr Old_A_P_N_;
    KEL.typ.nstr Apn_Or_Pin_Number_;
    KEL.typ.nstr Tax_I_D_Number_;
    KEL.typ.nstr Excise_Tax_Number_;
    KEL.typ.nbool Applicant_Owned_;
    KEL.typ.nbool Occupant_Owned_;
    KEL.typ.nbool Applicant_Sold_;
    KEL.typ.nint Duplicate_Apn_With_Different_Address_Counter_;
    KEL.typ.nbool Is_Assessment_;
    KEL.typ.nbool Is_Deed_;
    KEL.typ.nkdate Purchase_Date_;
    KEL.typ.nfloat Purchase_Amount_;
    KEL.typ.nint Previous_Purchase_Price1_;
    KEL.typ.nint Previous_Purchase_Price2_;
    KEL.typ.nkdate Previous_Purchase_Date1_;
    KEL.typ.nkdate Previous_Purchase_Date2_;
    KEL.typ.nint Sale_Price_;
    KEL.typ.nstr Sale_Price_Code_;
    KEL.typ.nint Previous_Sale_Price_;
    KEL.typ.nstr Previous_Sale_Price_Code_;
    KEL.typ.nint Sale_Price1_;
    KEL.typ.nint Sale_Price2_;
    KEL.typ.nkdate Sale_Date1_;
    KEL.typ.nkdate Sale_Date2_;
    KEL.typ.nint Year_Built_;
    KEL.typ.nint Effective_Year_Built_;
    KEL.typ.nstr Current_Record_;
    KEL.typ.nfloat Mortgage_Amount_;
    KEL.typ.nkdate Mortgage_Date_;
    KEL.typ.nstr Mortgage_Type_;
    KEL.typ.nstr Type_Financing_;
    KEL.typ.nkdate Primary_Loan_Due_Date_;
    KEL.typ.nint Primary_Loan_Amount_;
    KEL.typ.nint Secondary_Loan_Amount_;
    KEL.typ.nstr Primary_Loan_Lender_Type_Code_;
    KEL.typ.nstr Secondary_Loan_Lender_Type_Code_;
    KEL.typ.nstr Primary_Loan_Type_Code_;
    KEL.typ.nfloat Primary_Loan_Interest_Rate_;
    KEL.typ.nstr Ownership_Method_Code_;
    KEL.typ.nstr Ownership_Type_Code_;
    KEL.typ.nstr Owners_Relationship_Code_;
    KEL.typ.nstr Multi_Apn_Flag_;
    KEL.typ.nkdate Contract_Date_;
    KEL.typ.nkdate Adjustable_Rate_Mortgage_Reset_Date_;
    KEL.typ.nstr Rate_Change_Frequency_;
    KEL.typ.nfloat Change_Index_;
    KEL.typ.nint Adjustable_Rate_Index_;
    KEL.typ.nint Adjustable_Rate_Rider_;
    KEL.typ.nint Fixed_Step_Rate_Rider_;
    KEL.typ.nstr Condominium_Rider_;
    KEL.typ.nstr Planned_Unit_Development_Rider_;
    KEL.typ.nstr Assumability_Rider_;
    KEL.typ.nstr One_Four_Family_Rider_;
    KEL.typ.nstr Second_Home_Rider_;
    KEL.typ.nstr Type_Of_Deed_Code_;
    KEL.typ.nstr Loan_Number_;
    KEL.typ.nint Partial_Interest_Transferred_;
    KEL.typ.nint Loan_Term_Months_;
    KEL.typ.nint Loan_Term_Years_;
    KEL.typ.nstr Lender_Id_Code_;
    KEL.typ.nstr Buyer_Or_Borrower_Or_Assessee_;
    KEL.typ.nstr Name1_Id_Code_;
    KEL.typ.nstr Name2_Id_Code_;
    KEL.typ.nstr Buyer_Borrower_Vesting_Code_;
    KEL.typ.nint Buyer_Borrower_Addendum_Flag_;
    KEL.typ.nstr Seller1_Id_Code_;
    KEL.typ.nstr Seller2_Id_Code_;
    KEL.typ.nint Seller_Addendum_Flag_;
    KEL.typ.nfloat Assessed_Amount_;
    KEL.typ.nint Assessed_Land_Value_;
    KEL.typ.nint Assessed_Improvement_Value_;
    KEL.typ.nfloat Assessed_Total_Value_;
    KEL.typ.nint Assessed_Value_Year_;
    KEL.typ.nint Market_Land_Value_;
    KEL.typ.nint Market_Improvement_Value_;
    KEL.typ.nfloat Market_Total_Value_;
    KEL.typ.nint Market_Value_Year_;
    KEL.typ.nint Standardized_Land_Use_Code_;
    KEL.typ.nstr Property_Use_Code_;
    KEL.typ.nstr State_Land_Use_Code_;
    KEL.typ.nstr County_Land_Use_Code_;
    KEL.typ.nstr County_Land_Use_Description_;
    KEL.typ.nstr Timeshare_Code_;
    KEL.typ.nstr Zoning_;
    KEL.typ.nstr Condo_Code_;
    KEL.typ.nint Number_Of_Buildings_;
    KEL.typ.nint Number_Of_Stories_;
    KEL.typ.nint Number_Of_Units_;
    KEL.typ.nint Number_Of_Rooms_;
    KEL.typ.nint Number_Of_Bedrooms_;
    KEL.typ.nint Number_Of_Baths_;
    KEL.typ.nint Number_Of_Partial_Baths_;
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
    KEL.typ.nstr Fireplace_Indicator_;
    KEL.typ.nint Fireplace_Number_;
    KEL.typ.nstr Basement_Code_;
    KEL.typ.nstr Building_Class_Code_;
    KEL.typ.nstr Topograpy_Code_;
    KEL.typ.nstr Neighborhood_Code_;
    KEL.typ.nstr Condo_Project_Or_Building_Name_;
    KEL.typ.nstr Other_Rooms_Indicator_;
    KEL.typ.nstr Comments_;
    KEL.typ.nkdate Certification_Date_;
    KEL.typ.nstr Hawaii_Transfer_Certificate_Of_Title_;
    KEL.typ.nint Lot_Size_;
    KEL.typ.nfloat Lot_Size_Acres_;
    KEL.typ.nfloat Lot_Size_Frontage_Feet_;
    KEL.typ.nfloat Lot_Size_Depth_Feet_;
    KEL.typ.nstr Land_Acres_;
    KEL.typ.nstr Land_Square_Footage_;
    KEL.typ.nstr Land_Dimensions_;
    KEL.typ.nstr Legal_Lot_Code_;
    KEL.typ.nint Legal_Lot_Number_;
    KEL.typ.nstr Legal_Block_;
    KEL.typ.nstr Legal_Section_;
    KEL.typ.nstr Legal_District_;
    KEL.typ.nstr Legal_Land_Lot_;
    KEL.typ.nstr Legal_Unit_;
    KEL.typ.nstr Legal_City_Municipality_Township_;
    KEL.typ.nstr Legal_Subdivision_Name_;
    KEL.typ.nstr Legal_Phase_Number_;
    KEL.typ.nstr Legal_Tract_Number_;
    KEL.typ.nstr Legal_Section_Township_Range_Meridian_;
    KEL.typ.nstr Legal_Brief_Description_;
    KEL.typ.nstr Legal_Complete_Description_Code_;
    KEL.typ.nfloat Census_Tract_;
    KEL.typ.nstr Map_Reference_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nint Document_Number_;
    KEL.typ.nstr Document_Type_Code_;
    KEL.typ.nint Recorder_Book_Number_;
    KEL.typ.nint Recorder_Page_Number_;
    KEL.typ.nstr Concurrent_Mortgage_Book_Page_Document_Number_;
    KEL.typ.nkdate Transfer_Date_;
    KEL.typ.nkdate Previous_Recording_Date_;
    KEL.typ.nfloat City_Transfer_Tax_;
    KEL.typ.nfloat County_Transfer_Tax_;
    KEL.typ.nfloat Total_Transfer_Tax_;
    KEL.typ.nstr Homestead_Home_Owner_Exemption_;
    KEL.typ.nstr Tax_Rate_Code_Area_;
    KEL.typ.nfloat Tax_Amount_;
    KEL.typ.nint Tax_Year_;
    KEL.typ.nint Tax_Delinquent_Year_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Tax_Exemption_Layout) Tax_Exemption_;
    KEL.typ.ndataset(E_Property(__in,__cfg).School_Tax_Districts_Layout) School_Tax_Districts_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Building_Areas_Layout) Building_Areas_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Site_Influences_Layout) Site_Influences_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Amenity_Details_Layout) Amenity_Details_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Extra_Features_Layout) Extra_Features_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Other_Buildings_Layout) Other_Buildings_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Other_Important_Buildings_Layout) Other_Important_Buildings_;
    KEL.typ.ndataset(E_Property(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Current_Date_F_C_R_A_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST26820_Layout __ND429893__Project(E_Property(__in,__cfg).Layout __PP426717) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('property_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Current_Date_F_C_R_A_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('fcra_property_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP426717;
  END;
  EXPORT __ENH_Property := PROJECT(__EE427769,__ND429893__Project(LEFT));
END;
