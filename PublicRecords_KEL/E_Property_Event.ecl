//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Property,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Property_Event(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
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
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isassessment(DEFAULT:Is_Assessment_),isadditionalfaresdeed(DEFAULT:Is_Additional_Fares_Deed_),processdate(DEFAULT:Process_Date_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),currentrecord(DEFAULT:Current_Record_),fipscode(DEFAULT:F_I_P_S_Code_:\'\'),state(DEFAULT:State_:\'\'),countyname(DEFAULT:County_Name_:\'\'),oldapn(DEFAULT:Old_A_P_N_:\'\'),apnnumber(DEFAULT:A_P_N_Number_:\'\'),faresunformattedapn(DEFAULT:Fares_Unformatted_A_P_N_:\'\'),duplicateapnwithdifferentaddresscounter(DEFAULT:Duplicate_Apn_With_Different_Address_Counter_:\'\'),assesseename(DEFAULT:Assessee_Name_:\'\'),secondassesseename(DEFAULT:Second_Assessee_Name_:\'\'),ownershipmethodcode(DEFAULT:Ownership_Method_Code_:\'\'),ownersrelationshipcode(DEFAULT:Owners_Relationship_Code_:\'\'),ownerphonenumber(DEFAULT:Owner_Phone_Number_:\'\'),taxaccountnumber(DEFAULT:Tax_Account_Number_:\'\'),name1idcode(DEFAULT:Name1_I_D_Code_:\'\'),name2idcode(DEFAULT:Name2_I_D_Code_:\'\'),mailingcareofnametypecode(DEFAULT:Mailing_Care_Of_Name_Type_Code_:\'\'),mailingcareofname(DEFAULT:Mailing_Care_Of_Name_:\'\'),mailingfullstreetaddress(DEFAULT:Mailing_Full_Street_Address_:\'\'),mailingunitnumber(DEFAULT:Mailing_Unit_Number_:\'\'),mailingcitystatezip(DEFAULT:Mailing_City_State_Zip_:\'\'),propertyfullstreetaddress(DEFAULT:Property_Full_Street_Address_:\'\'),propertyaddressunitnumber(DEFAULT:Property_Address_Unit_Number_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),propertyaddresscountrycode(DEFAULT:Property_Address_Country_Code_:\'\'),propertyaddresscode(DEFAULT:Property_Address_Code_:\'\'),legallotcode(DEFAULT:Legal_Lot_Code_:\'\'),legallotnumber(DEFAULT:Legal_Lot_Number_:\'\'),legallandlot(DEFAULT:Legal_Land_Lot_:0),legalblock(DEFAULT:Legal_Block_:\'\'),legalsection(DEFAULT:Legal_Section_:\'\'),legaldistrict(DEFAULT:Legal_District_:\'\'),legalunit(DEFAULT:Legal_Unit_:\'\'),legalcitymunicipalitytownship(DEFAULT:Legal_City_Municipality_Township_:\'\'),legalsubdivisionname(DEFAULT:Legal_Subdivision_Name_:\'\'),legalphasenumber(DEFAULT:Legal_Phase_Number_:\'\'),legaltractnumber(DEFAULT:Legal_Tract_Number_:0),legalsectiontownshiprangemeridian(DEFAULT:Legal_Section_Township_Range_Meridian_:\'\'),legalbriefdescription(DEFAULT:Legal_Brief_Description_:\'\'),mapreference(DEFAULT:Map_Reference_:\'\'),censustract(DEFAULT:Census_Tract_:\'\'),recordtypecode(DEFAULT:Record_Type_Code_:\'\'),ownershiptypecode(DEFAULT:Ownership_Type_Code_:\'\'),newrecordtypecode(DEFAULT:New_Record_Type_Code_:\'\'),statelandusecode(DEFAULT:State_Land_Use_Code_:\'\'),countylandusecode(DEFAULT:County_Land_Use_Code_:\'\'),countylandusedescription(DEFAULT:County_Land_Use_Description_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),timesharecode(DEFAULT:Timeshare_Code_:\'\'),zoning(DEFAULT:Zoning_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),documentnumber(DEFAULT:Document_Number_:0),recorderbooknumber(DEFAULT:Recorder_Book_Number_:0),recorderpagenumber(DEFAULT:Recorder_Page_Number_:0),transferdate(DEFAULT:Transfer_Date_:DATE),recordingdate(DEFAULT:Recording_Date_:DATE),saledate(DEFAULT:Sale_Date_:DATE),documenttypecode(DEFAULT:Document_Type_Code_:\'\'),saleprice(DEFAULT:Sale_Price_:0),salepricecode(DEFAULT:Sale_Price_Code_:\'\'),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),mortgagelendername(DEFAULT:Mortgage_Lender_Name_:\'\'),lenderidcode(DEFAULT:Lender_I_D_Code_:\'\'),priortransferdate(DEFAULT:Prior_Transfer_Date_:DATE),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),previoussalepricecode(DEFAULT:Previous_Sale_Price_Code_:\'\'),assessedlandvalue(DEFAULT:Assessed_Land_Value_:0),assessedimprovementvalue(DEFAULT:Assessed_Improvement_Value_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),marketlandvalue(DEFAULT:Market_Land_Value_:0),marketimprovementvalue(DEFAULT:Market_Improvement_Value_:0),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxexemptioncode1(DEFAULT:Tax_Exemption_Code1_:\'\'),taxexemptioncode2(DEFAULT:Tax_Exemption_Code2_:\'\'),taxexemptioncode3(DEFAULT:Tax_Exemption_Code3_:\'\'),taxexemptioncode4(DEFAULT:Tax_Exemption_Code4_:\'\'),taxratecodearea(DEFAULT:Tax_Rate_Code_Area_:\'\'),taxamount(DEFAULT:Tax_Amount_:0),taxyear(DEFAULT:Tax_Year_:DATE),taxdelinquentyear(DEFAULT:Tax_Delinquent_Year_:DATE),schooltaxdistrict1(DEFAULT:School_Tax_District1_:\'\'),schooltaxdistrict2(DEFAULT:School_Tax_District2_:\'\'),schooltaxdistrict3(DEFAULT:School_Tax_District3_:\'\'),schooltaxdistrictindicator1(DEFAULT:School_Tax_District_Indicator1_:\'\'),schooltaxdistrictindicator2(DEFAULT:School_Tax_District_Indicator2_:\'\'),schooltaxdistrictindicator3(DEFAULT:School_Tax_District_Indicator3_:\'\'),lotsize(DEFAULT:Lot_Size_:0),lotsizeacres(DEFAULT:Lot_Size_Acres_:0),lotsizefrontagefeet(DEFAULT:Lot_Size_Frontage_Feet_:0),lotsizedepthfeet(DEFAULT:Lot_Size_Depth_Feet_:0),landacres(DEFAULT:Land_Acres_:0.0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),landdimensions(DEFAULT:Land_Dimensions_:\'\'),buildingarea(DEFAULT:Building_Area_:0),buildingarea1(DEFAULT:Building_Area1_:0),buildingarea2(DEFAULT:Building_Area2_:0),buildingarea3(DEFAULT:Building_Area3_:0),buildingarea4(DEFAULT:Building_Area4_:0),buildingarea5(DEFAULT:Building_Area5_:0),buildingarea6(DEFAULT:Building_Area6_:0),buildingarea7(DEFAULT:Building_Area7_:0),buildingareaindicator(DEFAULT:Building_Area_Indicator_:\'\'),buildingareaindicator1(DEFAULT:Building_Area_Indicator1_:\'\'),buildingareaindicator2(DEFAULT:Building_Area_Indicator2_:\'\'),buildingareaindicator3(DEFAULT:Building_Area_Indicator3_:\'\'),buildingareaindicator4(DEFAULT:Building_Area_Indicator4_:\'\'),buildingareaindicator5(DEFAULT:Building_Area_Indicator5_:\'\'),buildingareaindicator6(DEFAULT:Building_Area_Indicator6_:\'\'),buildingareaindicator7(DEFAULT:Building_Area_Indicator7_:\'\'),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),numberofplumbingfixtures(DEFAULT:Number_Of_Plumbing_Fixtures_:0),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),poolcode(DEFAULT:Pool_Code_:\'\'),stylecode(DEFAULT:Style_Code_:\'\'),typeconstructioncode(DEFAULT:Type_Construction_Code_:\'\'),foundationcode(DEFAULT:Foundation_Code_:\'\'),buildingqualitycode(DEFAULT:Building_Quality_Code_:\'\'),buildingconditioncode(DEFAULT:Building_Condition_Code_:\'\'),exteriorwallscode(DEFAULT:Exterior_Walls_Code_:\'\'),interiorwallscode(DEFAULT:Interior_Walls_Code_:\'\'),roofcovercode(DEFAULT:Roof_Cover_Code_:\'\'),rooftypecode(DEFAULT:Roof_Type_Code_:\'\'),floorcovercode(DEFAULT:Floor_Cover_Code_:\'\'),watercode(DEFAULT:Water_Code_:\'\'),sewercode(DEFAULT:Sewer_Code_:\'\'),heatingcode(DEFAULT:Heating_Code_:\'\'),heatingfueltypecode(DEFAULT:Heating_Fuel_Type_Code_:\'\'),airconditioningcode(DEFAULT:Air_Conditioning_Code_:\'\'),airconditioningtypecode(DEFAULT:Air_Conditioning_Type_Code_:\'\'),elevator(DEFAULT:Elevator_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),fireplacenumber(DEFAULT:Fireplace_Number_:0),basementcode(DEFAULT:Basement_Code_:\'\'),buildingclasscode(DEFAULT:Building_Class_Code_:\'\'),siteinfluencecode1(DEFAULT:Site_Influence_Code1_:\'\'),siteinfluencecode2(DEFAULT:Site_Influence_Code2_:\'\'),siteinfluencecode3(DEFAULT:Site_Influence_Code3_:\'\'),siteinfluencecode4(DEFAULT:Site_Influence_Code4_:\'\'),siteinfluencecode5(DEFAULT:Site_Influence_Code5_:\'\'),amenitycode1(DEFAULT:Amenity_Code1_:\'\'),amenitycode2(DEFAULT:Amenity_Code2_:\'\'),amenitycode3(DEFAULT:Amenity_Code3_:\'\'),amenitycode4(DEFAULT:Amenity_Code4_:\'\'),amenitycode5(DEFAULT:Amenity_Code5_:\'\'),amenitycode6(DEFAULT:Amenity_Code6_:\'\'),amenitycode7(DEFAULT:Amenity_Code7_:\'\'),amenitycode8(DEFAULT:Amenity_Code8_:\'\'),amenitycode9(DEFAULT:Amenity_Code9_:\'\'),amenitycode10(DEFAULT:Amenity_Code10_:\'\'),extrafeaturearea1(DEFAULT:Extra_Feature_Area1_:\'\'),extrafeaturearea2(DEFAULT:Extra_Feature_Area2_:\'\'),extrafeaturearea3(DEFAULT:Extra_Feature_Area3_:\'\'),extrafeaturearea4(DEFAULT:Extra_Feature_Area4_:\'\'),extrafeatureindicator1(DEFAULT:Extra_Feature_Indicator1_:\'\'),extrafeatureindicator2(DEFAULT:Extra_Feature_Indicator2_:\'\'),extrafeatureindicator3(DEFAULT:Extra_Feature_Indicator3_:\'\'),extrafeatureindicator4(DEFAULT:Extra_Feature_Indicator4_:\'\'),otherbuildingcode1(DEFAULT:Other_Building_Code1_:\'\'),otherbuildingcode2(DEFAULT:Other_Building_Code2_:\'\'),otherbuildingcode3(DEFAULT:Other_Building_Code3_:\'\'),otherbuildingcode4(DEFAULT:Other_Building_Code4_:\'\'),otherbuildingcode5(DEFAULT:Other_Building_Code5_:\'\'),otherimportantbuildingindicator1(DEFAULT:Other_Important_Building_Indicator1_:\'\'),otherimportantbuildingindicator2(DEFAULT:Other_Important_Building_Indicator2_:\'\'),otherimportantbuildingindicator3(DEFAULT:Other_Important_Building_Indicator3_:\'\'),otherimportantbuildingindicator4(DEFAULT:Other_Important_Building_Indicator4_:\'\'),otherimportantbuildingindicator5(DEFAULT:Other_Important_Building_Indicator5_:\'\'),otherimportantbuildingarea1(DEFAULT:Other_Important_Building_Area1_:\'\'),otherimportantbuildingarea2(DEFAULT:Other_Important_Building_Area2_:\'\'),otherimportantbuildingarea3(DEFAULT:Other_Important_Building_Area3_:\'\'),otherimportantbuildingarea4(DEFAULT:Other_Important_Building_Area4_:\'\'),otherimportantbuildingarea5(DEFAULT:Other_Important_Building_Area5_:\'\'),topographycode(DEFAULT:Topography_Code_:\'\'),neighborhoodcode(DEFAULT:Neighborhood_Code_:\'\'),condoprojectorbuildingname(DEFAULT:Condo_Project_Or_Building_Name_:\'\'),assesseenameindicator(DEFAULT:Assessee_Name_Indicator_:\'\'),secondassesseenameindicator(DEFAULT:Second_Assessee_Name_Indicator_:\'\'),otherroomsindicator(DEFAULT:Other_Rooms_Indicator_:\'\'),mailcareofnameindicator(DEFAULT:Mail_Care_Of_Name_Indicator_:\'\'),comments(DEFAULT:Comments_:\'\'),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),editionnumber(DEFAULT:Edition_Number_:0),propertyaddresspropegatedindicator(DEFAULT:Property_Address_Propegated_Indicator_:\'\'),lnownershiprights(DEFAULT:L_N_Ownership_Rights_:\'\'),lnrelationshiptype(DEFAULT:L_N_Relationship_Type_:\'\'),lnmailingcountrycode(DEFAULT:L_N_Mailing_Country_Code_:\'\'),lnpropertyname(DEFAULT:L_N_Property_Name_:\'\'),lnpropertynametype(DEFAULT:L_N_Property_Name_Type_:\'\'),lnlandusecategory(DEFAULT:L_N_Land_Use_Category_:\'\'),lnlotnumber(DEFAULT:L_N_Lot_Number_:\'\'),lnblocknumber(DEFAULT:L_N_Block_Number_:\'\'),lnunitnumber(DEFAULT:L_N_Unit_Number_:\'\'),lnsubfloor(DEFAULT:L_N_Subfloor_:\'\'),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),lnveteranstatus(DEFAULT:L_N_Veteran_Status_:0),sourcefile(DEFAULT:Source_File_:\'\'),multiapnflag(DEFAULT:Multi_A_P_N_Flag_:\'\'),taxnumber(DEFAULT:Tax_Number_:0),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name1code(DEFAULT:Name1_Code_:\'\'),name2(DEFAULT:Name2_:\'\'),name2code(DEFAULT:Name2_Code_:\'\'),buyerborrowervestingcode(DEFAULT:Buyer_Borrower_Vesting_Code_:\'\'),buyerborroweraddendumflag(DEFAULT:Buyer_Borrower_Addendum_Flag_:\'\'),mailingcareof(DEFAULT:Mailing_Care_Of_:\'\'),mailingstreet(DEFAULT:Mailing_Street_:\'\'),seller1(DEFAULT:Seller1_:\'\'),seller1idcode(DEFAULT:Seller1_I_D_Code_:\'\'),seller2(DEFAULT:Seller2_:\'\'),seller2idcode(DEFAULT:Seller2_I_D_Code_:\'\'),selleraddendumflag(DEFAULT:Seller_Addendum_Flag_:\'\'),sellermailingfullstreetaddress(DEFAULT:Seller_Mailing_Full_Street_Address_:\'\'),sellermailingaddressunitnumber(DEFAULT:Seller_Mailing_Address_Unit_Number_:\'\'),sellermailingaddresscitystatezip(DEFAULT:Seller_Mailing_Address_City_State_Zip_:\'\'),legalcompletedescriptioncode(DEFAULT:Legal_Complete_Description_Code_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),adjustableratemortgageresetdate(DEFAULT:Adjustable_Rate_Mortgage_Reset_Date_:DATE),loannumber(DEFAULT:Loan_Number_:\'\'),concurrentmortgagebookpagedocumentnumber(DEFAULT:Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),citytransfertax(DEFAULT:City_Transfer_Tax_:0.0),countytransfertax(DEFAULT:County_Transfer_Tax_:0.0),totaltransfertax(DEFAULT:Total_Transfer_Tax_:0.0),primaryloanamount(DEFAULT:Primary_Loan_Amount_:0),secondaryloanamount(DEFAULT:Secondary_Loan_Amount_:0),primaryloanlendertypecode(DEFAULT:Primary_Loan_Lender_Type_Code_:\'\'),secondaryloanlendertypecode(DEFAULT:Secondary_Loan_Lender_Type_Code_:\'\'),primaryloantypecode(DEFAULT:Primary_Loan_Type_Code_:\'\'),typefinancing(DEFAULT:Type_Financing_:\'\'),primaryloaninterestrate(DEFAULT:Primary_Loan_Interest_Rate_:0.0),primaryloanduedate(DEFAULT:Primary_Loan_Due_Date_:DATE),titlecompanyname(DEFAULT:Title_Company_Name_:\'\'),partialinteresttransferred(DEFAULT:Partial_Interest_Transferred_:0),loantermmonths(DEFAULT:Loan_Term_Months_:0),loantermyears(DEFAULT:Loan_Term_Years_:0),lendername(DEFAULT:Lender_Name_:\'\'),lenderdbaname(DEFAULT:Lender_D_B_A_Name_:\'\'),lenderfullstreetaddress(DEFAULT:Lender_Full_Street_Address_:\'\'),lenderaddressunitnumber(DEFAULT:Lender_Address_Unit_Number_:\'\'),lenderaddresscitystatezip(DEFAULT:Lender_Address_City_State_Zip_:\'\'),propertyusecode(DEFAULT:Property_Use_Code_:\'\'),condocode(DEFAULT:Condo_Code_:\'\'),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),ratechangefrequency(DEFAULT:Rate_Change_Frequency_:\'\'),changeindex(DEFAULT:Change_Index_:0.0),adjustablerateindex(DEFAULT:Adjustable_Rate_Index_:\'\'),adjustableraterider(DEFAULT:Adjustable_Rate_Rider_:\'\'),graduatedpaymentrider(DEFAULT:Graduated_Payment_Rider_:\'\'),balloonrider(DEFAULT:Balloon_Rider_:\'\'),fixedstepraterider(DEFAULT:Fixed_Step_Rate_Rider_:\'\'),condominiumrider(DEFAULT:Condominium_Rider_:\'\'),plannedunitdevelopmentrider(DEFAULT:Planned_Unit_Development_Rider_:\'\'),assumabilityrider(DEFAULT:Assumability_Rider_:\'\'),prepaymentrider(DEFAULT:Prepayment_Rider_:\'\'),onefourfamilyrider(DEFAULT:One_Four_Family_Rider_:\'\'),biweeklypaymentrider(DEFAULT:Biweekly_Payment_Rider_:\'\'),secondhomerider(DEFAULT:Second_Home_Rider_:\'\'),datasourcecode(DEFAULT:Data_Source_Code_:\'\'),typeofdeedcode(DEFAULT:Type_Of_Deed_Code_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),lnbuyermailingcountrycode(DEFAULT:L_N_Buyer_Mailing_Country_Code_:\'\'),lnsellermailingcountrycode(DEFAULT:L_N_Seller_Mailing_Country_Code_:\'\'),faresowneretalindicator(DEFAULT:Fares_Owner_Et_Al_Indicator_:\'\'),faresownerrelationshipcode(DEFAULT:Fares_Owner_Relationship_Code_:\'\'),faresownerrelationshiptype(DEFAULT:Fares_Owner_Relationship_Type_:\'\'),faresmatchcode(DEFAULT:Fares_Match_Code_:\'\'),faresdocumentyear(DEFAULT:Fares_Document_Year_:DATE),farescorporateindicator(DEFAULT:Fares_Corporate_Indicator_),farestransactiontype(DEFAULT:Fares_Transaction_Type_:\'\'),fareslenderaddress(DEFAULT:Fares_Lender_Address_:\'\'),faressalestransactioncode(DEFAULT:Fares_Sales_Transaction_Code_:\'\'),faresresidentialmodelind(DEFAULT:Fares_Residential_Model_Ind_),faresmortgagedeedtype(DEFAULT:Fares_Mortgage_Deed_Type_:\'\'),faresmortgagetermcode(DEFAULT:Fares_Mortgage_Term_Code_:\'\'),faresmortgageterm(DEFAULT:Fares_Mortgage_Term_:0),faresmortgageassumptionamount(DEFAULT:Fares_Mortgage_Assumption_Amount_:0),faressecondmortgageloantypecode(DEFAULT:Fares_Second_Mortgage_Loan_Type_Code_:\'\'),faresseconddeedtype(DEFAULT:Fares_Second_Deed_Type_:\'\'),faresabsenteeindicator(DEFAULT:Fares_Absentee_Indicator_:\'\'),farespartialinterestindicator(DEFAULT:Fares_Partial_Interest_Indicator_),faresprimarycategorycode(DEFAULT:Fares_Primary_Category_Code_:\'\'),faresprivatepartylender(DEFAULT:Fares_Private_Party_Lender_:\'\'),faresconstructionloan(DEFAULT:Fares_Construction_Loan_:\'\'),faresresalenewconstruction(DEFAULT:Fares_Resale_New_Construction_:\'\'),faresinterfamily(DEFAULT:Fares_Inter_Family_:\'\'),farescashmortgagepurchase(DEFAULT:Fares_Cash_Mortgage_Purchase_:\'\'),faresbuildingsquarefeet(DEFAULT:Fares_Building_Square_Feet_:0),faresforeclosure(DEFAULT:Fares_Foreclosure_:\'\'),faresrefincanceflag(DEFAULT:Fares_Refincance_Flag_:\'\'),faresequityflag(DEFAULT:Fares_Equity_Flag_:\'\'),faresirisapn(DEFAULT:Fares_Iris_A_P_N_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid(ln_fares_id != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  SHARED __d1_KELfiltered := __in.Dataset_PropertyV2__Key_Assessor_Fid(ln_fares_id != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  SHARED __d2_KELfiltered := __in.Dataset_PropertyV2__Key_Deed_Fid_Fid(ln_fares_id != '');
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  SHARED __d3_KELfiltered := __in.Dataset_PropertyV2__Key_Search_Fid(ln_fares_id != '' AND propertyaddress);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Fares_Document_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isassessment(DEFAULT:Is_Assessment_),processdate(DEFAULT:Process_Date_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),currentrecord(DEFAULT:Current_Record_),fipscode(DEFAULT:F_I_P_S_Code_:\'\'),state(DEFAULT:State_:\'\'),countyname(DEFAULT:County_Name_:\'\'),oldapn(DEFAULT:Old_A_P_N_:\'\'),apnnumber(DEFAULT:A_P_N_Number_:\'\'),faresunformattedapn(DEFAULT:Fares_Unformatted_A_P_N_:\'\'),duplicateapnwithdifferentaddresscounter(DEFAULT:Duplicate_Apn_With_Different_Address_Counter_:\'\'),assesseename(DEFAULT:Assessee_Name_:\'\'),secondassesseename(DEFAULT:Second_Assessee_Name_:\'\'),ownershipmethodcode(DEFAULT:Ownership_Method_Code_:\'\'),ownersrelationshipcode(DEFAULT:Owners_Relationship_Code_:\'\'),ownerphonenumber(DEFAULT:Owner_Phone_Number_:\'\'),taxaccountnumber(DEFAULT:Tax_Account_Number_:\'\'),name1idcode(DEFAULT:Name1_I_D_Code_:\'\'),name2idcode(DEFAULT:Name2_I_D_Code_:\'\'),mailingcareofnametypecode(DEFAULT:Mailing_Care_Of_Name_Type_Code_:\'\'),mailingcareofname(DEFAULT:Mailing_Care_Of_Name_:\'\'),mailingfullstreetaddress(DEFAULT:Mailing_Full_Street_Address_:\'\'),mailingunitnumber(DEFAULT:Mailing_Unit_Number_:\'\'),mailingcitystatezip(DEFAULT:Mailing_City_State_Zip_:\'\'),propertyfullstreetaddress(DEFAULT:Property_Full_Street_Address_:\'\'),propertyaddressunitnumber(DEFAULT:Property_Address_Unit_Number_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),propertyaddresscountrycode(DEFAULT:Property_Address_Country_Code_:\'\'),propertyaddresscode(DEFAULT:Property_Address_Code_:\'\'),legallotcode(DEFAULT:Legal_Lot_Code_:\'\'),legallotnumber(DEFAULT:Legal_Lot_Number_:\'\'),legallandlot(DEFAULT:Legal_Land_Lot_:0),legalblock(DEFAULT:Legal_Block_:\'\'),legalsection(DEFAULT:Legal_Section_:\'\'),legaldistrict(DEFAULT:Legal_District_:\'\'),legalunit(DEFAULT:Legal_Unit_:\'\'),legalcitymunicipalitytownship(DEFAULT:Legal_City_Municipality_Township_:\'\'),legalsubdivisionname(DEFAULT:Legal_Subdivision_Name_:\'\'),legalphasenumber(DEFAULT:Legal_Phase_Number_:\'\'),legaltractnumber(DEFAULT:Legal_Tract_Number_:0),legalsectiontownshiprangemeridian(DEFAULT:Legal_Section_Township_Range_Meridian_:\'\'),legalbriefdescription(DEFAULT:Legal_Brief_Description_:\'\'),mapreference(DEFAULT:Map_Reference_:\'\'),censustract(DEFAULT:Census_Tract_:\'\'),recordtypecode(DEFAULT:Record_Type_Code_:\'\'),ownershiptypecode(DEFAULT:Ownership_Type_Code_:\'\'),newrecordtypecode(DEFAULT:New_Record_Type_Code_:\'\'),statelandusecode(DEFAULT:State_Land_Use_Code_:\'\'),countylandusecode(DEFAULT:County_Land_Use_Code_:\'\'),countylandusedescription(DEFAULT:County_Land_Use_Description_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),timesharecode(DEFAULT:Timeshare_Code_:\'\'),zoning(DEFAULT:Zoning_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),documentnumber(DEFAULT:Document_Number_:0),recorderbooknumber(DEFAULT:Recorder_Book_Number_:0),recorderpagenumber(DEFAULT:Recorder_Page_Number_:0),transferdate(DEFAULT:Transfer_Date_:DATE),recordingdate(DEFAULT:Recording_Date_:DATE),saledate(DEFAULT:Sale_Date_:DATE),documenttypecode(DEFAULT:Document_Type_Code_:\'\'),saleprice(DEFAULT:Sale_Price_:0),salepricecode(DEFAULT:Sale_Price_Code_:\'\'),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),mortgagelendername(DEFAULT:Mortgage_Lender_Name_:\'\'),lenderidcode(DEFAULT:Lender_I_D_Code_:\'\'),priortransferdate(DEFAULT:Prior_Transfer_Date_:DATE),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),previoussalepricecode(DEFAULT:Previous_Sale_Price_Code_:\'\'),assessedlandvalue(DEFAULT:Assessed_Land_Value_:0),assessedimprovementvalue(DEFAULT:Assessed_Improvement_Value_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),marketlandvalue(DEFAULT:Market_Land_Value_:0),marketimprovementvalue(DEFAULT:Market_Improvement_Value_:0),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxexemptioncode1(DEFAULT:Tax_Exemption_Code1_:\'\'),taxexemptioncode2(DEFAULT:Tax_Exemption_Code2_:\'\'),taxexemptioncode3(DEFAULT:Tax_Exemption_Code3_:\'\'),taxexemptioncode4(DEFAULT:Tax_Exemption_Code4_:\'\'),taxratecodearea(DEFAULT:Tax_Rate_Code_Area_:\'\'),taxamount(DEFAULT:Tax_Amount_:0),taxyear(DEFAULT:Tax_Year_:DATE),taxdelinquentyear(DEFAULT:Tax_Delinquent_Year_:DATE),schooltaxdistrict1(DEFAULT:School_Tax_District1_:\'\'),schooltaxdistrict2(DEFAULT:School_Tax_District2_:\'\'),schooltaxdistrict3(DEFAULT:School_Tax_District3_:\'\'),schooltaxdistrictindicator1(DEFAULT:School_Tax_District_Indicator1_:\'\'),schooltaxdistrictindicator2(DEFAULT:School_Tax_District_Indicator2_:\'\'),schooltaxdistrictindicator3(DEFAULT:School_Tax_District_Indicator3_:\'\'),lotsize(DEFAULT:Lot_Size_:0),lotsizeacres(DEFAULT:Lot_Size_Acres_:0),lotsizefrontagefeet(DEFAULT:Lot_Size_Frontage_Feet_:0),lotsizedepthfeet(DEFAULT:Lot_Size_Depth_Feet_:0),landacres(DEFAULT:Land_Acres_:0.0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),landdimensions(DEFAULT:Land_Dimensions_:\'\'),buildingarea(DEFAULT:Building_Area_:0),buildingarea1(DEFAULT:Building_Area1_:0),buildingarea2(DEFAULT:Building_Area2_:0),buildingarea3(DEFAULT:Building_Area3_:0),buildingarea4(DEFAULT:Building_Area4_:0),buildingarea5(DEFAULT:Building_Area5_:0),buildingarea6(DEFAULT:Building_Area6_:0),buildingarea7(DEFAULT:Building_Area7_:0),buildingareaindicator(DEFAULT:Building_Area_Indicator_:\'\'),buildingareaindicator1(DEFAULT:Building_Area_Indicator1_:\'\'),buildingareaindicator2(DEFAULT:Building_Area_Indicator2_:\'\'),buildingareaindicator3(DEFAULT:Building_Area_Indicator3_:\'\'),buildingareaindicator4(DEFAULT:Building_Area_Indicator4_:\'\'),buildingareaindicator5(DEFAULT:Building_Area_Indicator5_:\'\'),buildingareaindicator6(DEFAULT:Building_Area_Indicator6_:\'\'),buildingareaindicator7(DEFAULT:Building_Area_Indicator7_:\'\'),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),numberofplumbingfixtures(DEFAULT:Number_Of_Plumbing_Fixtures_:0),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),poolcode(DEFAULT:Pool_Code_:\'\'),stylecode(DEFAULT:Style_Code_:\'\'),typeconstructioncode(DEFAULT:Type_Construction_Code_:\'\'),foundationcode(DEFAULT:Foundation_Code_:\'\'),buildingqualitycode(DEFAULT:Building_Quality_Code_:\'\'),buildingconditioncode(DEFAULT:Building_Condition_Code_:\'\'),exteriorwallscode(DEFAULT:Exterior_Walls_Code_:\'\'),interiorwallscode(DEFAULT:Interior_Walls_Code_:\'\'),roofcovercode(DEFAULT:Roof_Cover_Code_:\'\'),rooftypecode(DEFAULT:Roof_Type_Code_:\'\'),floorcovercode(DEFAULT:Floor_Cover_Code_:\'\'),watercode(DEFAULT:Water_Code_:\'\'),sewercode(DEFAULT:Sewer_Code_:\'\'),heatingcode(DEFAULT:Heating_Code_:\'\'),heatingfueltypecode(DEFAULT:Heating_Fuel_Type_Code_:\'\'),airconditioningcode(DEFAULT:Air_Conditioning_Code_:\'\'),airconditioningtypecode(DEFAULT:Air_Conditioning_Type_Code_:\'\'),elevator(DEFAULT:Elevator_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),fireplacenumber(DEFAULT:Fireplace_Number_:0),basementcode(DEFAULT:Basement_Code_:\'\'),buildingclasscode(DEFAULT:Building_Class_Code_:\'\'),siteinfluencecode1(DEFAULT:Site_Influence_Code1_:\'\'),siteinfluencecode2(DEFAULT:Site_Influence_Code2_:\'\'),siteinfluencecode3(DEFAULT:Site_Influence_Code3_:\'\'),siteinfluencecode4(DEFAULT:Site_Influence_Code4_:\'\'),siteinfluencecode5(DEFAULT:Site_Influence_Code5_:\'\'),amenitycode1(DEFAULT:Amenity_Code1_:\'\'),amenitycode2(DEFAULT:Amenity_Code2_:\'\'),amenitycode3(DEFAULT:Amenity_Code3_:\'\'),amenitycode4(DEFAULT:Amenity_Code4_:\'\'),amenitycode5(DEFAULT:Amenity_Code5_:\'\'),amenitycode6(DEFAULT:Amenity_Code6_:\'\'),amenitycode7(DEFAULT:Amenity_Code7_:\'\'),amenitycode8(DEFAULT:Amenity_Code8_:\'\'),amenitycode9(DEFAULT:Amenity_Code9_:\'\'),amenitycode10(DEFAULT:Amenity_Code10_:\'\'),extrafeaturearea1(DEFAULT:Extra_Feature_Area1_:\'\'),extrafeaturearea2(DEFAULT:Extra_Feature_Area2_:\'\'),extrafeaturearea3(DEFAULT:Extra_Feature_Area3_:\'\'),extrafeaturearea4(DEFAULT:Extra_Feature_Area4_:\'\'),extrafeatureindicator1(DEFAULT:Extra_Feature_Indicator1_:\'\'),extrafeatureindicator2(DEFAULT:Extra_Feature_Indicator2_:\'\'),extrafeatureindicator3(DEFAULT:Extra_Feature_Indicator3_:\'\'),extrafeatureindicator4(DEFAULT:Extra_Feature_Indicator4_:\'\'),otherbuildingcode1(DEFAULT:Other_Building_Code1_:\'\'),otherbuildingcode2(DEFAULT:Other_Building_Code2_:\'\'),otherbuildingcode3(DEFAULT:Other_Building_Code3_:\'\'),otherbuildingcode4(DEFAULT:Other_Building_Code4_:\'\'),otherbuildingcode5(DEFAULT:Other_Building_Code5_:\'\'),otherimportantbuildingindicator1(DEFAULT:Other_Important_Building_Indicator1_:\'\'),otherimportantbuildingindicator2(DEFAULT:Other_Important_Building_Indicator2_:\'\'),otherimportantbuildingindicator3(DEFAULT:Other_Important_Building_Indicator3_:\'\'),otherimportantbuildingindicator4(DEFAULT:Other_Important_Building_Indicator4_:\'\'),otherimportantbuildingindicator5(DEFAULT:Other_Important_Building_Indicator5_:\'\'),otherimportantbuildingarea1(DEFAULT:Other_Important_Building_Area1_:\'\'),otherimportantbuildingarea2(DEFAULT:Other_Important_Building_Area2_:\'\'),otherimportantbuildingarea3(DEFAULT:Other_Important_Building_Area3_:\'\'),otherimportantbuildingarea4(DEFAULT:Other_Important_Building_Area4_:\'\'),otherimportantbuildingarea5(DEFAULT:Other_Important_Building_Area5_:\'\'),topographycode(DEFAULT:Topography_Code_:\'\'),neighborhoodcode(DEFAULT:Neighborhood_Code_:\'\'),condoprojectorbuildingname(DEFAULT:Condo_Project_Or_Building_Name_:\'\'),assesseenameindicator(DEFAULT:Assessee_Name_Indicator_:\'\'),secondassesseenameindicator(DEFAULT:Second_Assessee_Name_Indicator_:\'\'),otherroomsindicator(DEFAULT:Other_Rooms_Indicator_:\'\'),mailcareofnameindicator(DEFAULT:Mail_Care_Of_Name_Indicator_:\'\'),comments(DEFAULT:Comments_:\'\'),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),editionnumber(DEFAULT:Edition_Number_:0),propertyaddresspropegatedindicator(DEFAULT:Property_Address_Propegated_Indicator_:\'\'),lnownershiprights(DEFAULT:L_N_Ownership_Rights_:\'\'),lnrelationshiptype(DEFAULT:L_N_Relationship_Type_:\'\'),lnmailingcountrycode(DEFAULT:L_N_Mailing_Country_Code_:\'\'),lnpropertyname(DEFAULT:L_N_Property_Name_:\'\'),lnpropertynametype(DEFAULT:L_N_Property_Name_Type_:\'\'),lnlandusecategory(DEFAULT:L_N_Land_Use_Category_:\'\'),lnlotnumber(DEFAULT:L_N_Lot_Number_:\'\'),lnblocknumber(DEFAULT:L_N_Block_Number_:\'\'),lnunitnumber(DEFAULT:L_N_Unit_Number_:\'\'),lnsubfloor(DEFAULT:L_N_Subfloor_:\'\'),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),lnveteranstatus(DEFAULT:L_N_Veteran_Status_:0),sourcefile(DEFAULT:Source_File_:\'\'),multiapnflag(DEFAULT:Multi_A_P_N_Flag_:\'\'),taxnumber(DEFAULT:Tax_Number_:0),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name1code(DEFAULT:Name1_Code_:\'\'),name2(DEFAULT:Name2_:\'\'),name2code(DEFAULT:Name2_Code_:\'\'),buyerborrowervestingcode(DEFAULT:Buyer_Borrower_Vesting_Code_:\'\'),buyerborroweraddendumflag(DEFAULT:Buyer_Borrower_Addendum_Flag_:\'\'),mailingcareof(DEFAULT:Mailing_Care_Of_:\'\'),mailingstreet(DEFAULT:Mailing_Street_:\'\'),seller1(DEFAULT:Seller1_:\'\'),seller1idcode(DEFAULT:Seller1_I_D_Code_:\'\'),seller2(DEFAULT:Seller2_:\'\'),seller2idcode(DEFAULT:Seller2_I_D_Code_:\'\'),selleraddendumflag(DEFAULT:Seller_Addendum_Flag_:\'\'),sellermailingfullstreetaddress(DEFAULT:Seller_Mailing_Full_Street_Address_:\'\'),sellermailingaddressunitnumber(DEFAULT:Seller_Mailing_Address_Unit_Number_:\'\'),sellermailingaddresscitystatezip(DEFAULT:Seller_Mailing_Address_City_State_Zip_:\'\'),legalcompletedescriptioncode(DEFAULT:Legal_Complete_Description_Code_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),adjustableratemortgageresetdate(DEFAULT:Adjustable_Rate_Mortgage_Reset_Date_:DATE),loannumber(DEFAULT:Loan_Number_:\'\'),concurrentmortgagebookpagedocumentnumber(DEFAULT:Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),citytransfertax(DEFAULT:City_Transfer_Tax_:0.0),countytransfertax(DEFAULT:County_Transfer_Tax_:0.0),totaltransfertax(DEFAULT:Total_Transfer_Tax_:0.0),primaryloanamount(DEFAULT:Primary_Loan_Amount_:0),secondaryloanamount(DEFAULT:Secondary_Loan_Amount_:0),primaryloanlendertypecode(DEFAULT:Primary_Loan_Lender_Type_Code_:\'\'),secondaryloanlendertypecode(DEFAULT:Secondary_Loan_Lender_Type_Code_:\'\'),primaryloantypecode(DEFAULT:Primary_Loan_Type_Code_:\'\'),typefinancing(DEFAULT:Type_Financing_:\'\'),primaryloaninterestrate(DEFAULT:Primary_Loan_Interest_Rate_:0.0),primaryloanduedate(DEFAULT:Primary_Loan_Due_Date_:DATE),titlecompanyname(DEFAULT:Title_Company_Name_:\'\'),partialinteresttransferred(DEFAULT:Partial_Interest_Transferred_:0),loantermmonths(DEFAULT:Loan_Term_Months_:0),loantermyears(DEFAULT:Loan_Term_Years_:0),lendername(DEFAULT:Lender_Name_:\'\'),lenderdbaname(DEFAULT:Lender_D_B_A_Name_:\'\'),lenderfullstreetaddress(DEFAULT:Lender_Full_Street_Address_:\'\'),lenderaddressunitnumber(DEFAULT:Lender_Address_Unit_Number_:\'\'),lenderaddresscitystatezip(DEFAULT:Lender_Address_City_State_Zip_:\'\'),propertyusecode(DEFAULT:Property_Use_Code_:\'\'),condocode(DEFAULT:Condo_Code_:\'\'),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),ratechangefrequency(DEFAULT:Rate_Change_Frequency_:\'\'),changeindex(DEFAULT:Change_Index_:0.0),adjustablerateindex(DEFAULT:Adjustable_Rate_Index_:\'\'),adjustableraterider(DEFAULT:Adjustable_Rate_Rider_:\'\'),graduatedpaymentrider(DEFAULT:Graduated_Payment_Rider_:\'\'),balloonrider(DEFAULT:Balloon_Rider_:\'\'),fixedstepraterider(DEFAULT:Fixed_Step_Rate_Rider_:\'\'),condominiumrider(DEFAULT:Condominium_Rider_:\'\'),plannedunitdevelopmentrider(DEFAULT:Planned_Unit_Development_Rider_:\'\'),assumabilityrider(DEFAULT:Assumability_Rider_:\'\'),prepaymentrider(DEFAULT:Prepayment_Rider_:\'\'),onefourfamilyrider(DEFAULT:One_Four_Family_Rider_:\'\'),biweeklypaymentrider(DEFAULT:Biweekly_Payment_Rider_:\'\'),secondhomerider(DEFAULT:Second_Home_Rider_:\'\'),datasourcecode(DEFAULT:Data_Source_Code_:\'\'),typeofdeedcode(DEFAULT:Type_Of_Deed_Code_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),lnbuyermailingcountrycode(DEFAULT:L_N_Buyer_Mailing_Country_Code_:\'\'),lnsellermailingcountrycode(DEFAULT:L_N_Seller_Mailing_Country_Code_:\'\'),fares_owner_etal_indicator(OVERRIDE:Fares_Owner_Et_Al_Indicator_:\'\'),fares_owner_relationship_code(OVERRIDE:Fares_Owner_Relationship_Code_:\'\'),fares_owner_relationship_type(OVERRIDE:Fares_Owner_Relationship_Type_:\'\'),fares_match_code(OVERRIDE:Fares_Match_Code_:\'\'),fares_document_year(OVERRIDE:Fares_Document_Year_:DATE:Fares_Document_Year_0Rule),fares_corporate_indicator(OVERRIDE:Fares_Corporate_Indicator_),fares_transaction_type(OVERRIDE:Fares_Transaction_Type_:\'\'),fares_lender_address(OVERRIDE:Fares_Lender_Address_:\'\'),fares_sales_transaction_code(OVERRIDE:Fares_Sales_Transaction_Code_:\'\'),fares_residential_model_ind(OVERRIDE:Fares_Residential_Model_Ind_),fares_mortgage_deed_type(OVERRIDE:Fares_Mortgage_Deed_Type_:\'\'),fares_mortgage_term_code(OVERRIDE:Fares_Mortgage_Term_Code_:\'\'),fares_mortgage_term(OVERRIDE:Fares_Mortgage_Term_:0),fares_mortgage_assumption_amt(OVERRIDE:Fares_Mortgage_Assumption_Amount_:0),fares_second_mortgage_loan_type_code(OVERRIDE:Fares_Second_Mortgage_Loan_Type_Code_:\'\'),fares_second_deed_type(OVERRIDE:Fares_Second_Deed_Type_:\'\'),fares_absentee_indicator(OVERRIDE:Fares_Absentee_Indicator_:\'\'),fares_partial_interest_ind(OVERRIDE:Fares_Partial_Interest_Indicator_),fares_pri_cat_code(OVERRIDE:Fares_Primary_Category_Code_:\'\'),fares_private_party_lender(OVERRIDE:Fares_Private_Party_Lender_:\'\'),fares_construction_loan(OVERRIDE:Fares_Construction_Loan_:\'\'),fares_resale_new_construction(OVERRIDE:Fares_Resale_New_Construction_:\'\'),fares_inter_family(OVERRIDE:Fares_Inter_Family_:\'\'),fares_cash_mortgage_purchase(OVERRIDE:Fares_Cash_Mortgage_Purchase_:\'\'),fares_building_square_feet(OVERRIDE:Fares_Building_Square_Feet_:0),fares_foreclosure(OVERRIDE:Fares_Foreclosure_:\'\'),fares_refi_flag(OVERRIDE:Fares_Refincance_Flag_:\'\'),fares_equity_flag(OVERRIDE:Fares_Equity_Flag_:\'\'),fares_iris_apn(OVERRIDE:Fares_Iris_A_P_N_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),fares_mortgage_date(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Additional_Fares_Deed_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d0_Prop__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d0_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_UID_Mapped,'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange','__in');
  SHARED __d0_Prop__Mapped := IF(__d0_Missing_Prop__UIDComponents = 'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange',PROJECT(__d0_UID_Mapped,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_UID_Mapped,__d0_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid_Invalid := __d0_Prop__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Prop__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Transfer_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Recording_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Prior_Transfer_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Previous_Recording_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Assessed_Value_Year_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Market_Value_Year_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Tax_Year_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Tax_Delinquent_Year_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Year_Built_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Effective_Year_Built_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Tape_Cut_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isadditionalfaresdeed(DEFAULT:Is_Additional_Fares_Deed_),process_date(OVERRIDE:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),current_record(OVERRIDE:Current_Record_),fips_code(OVERRIDE:F_I_P_S_Code_:\'\'),state_code(OVERRIDE:State_:\'\'),county_name(OVERRIDE:County_Name_:\'\'),old_apn(OVERRIDE:Old_A_P_N_:\'\'),apna_or_pin_number(OVERRIDE:A_P_N_Number_:\'\'),fares_unformatted_apn(OVERRIDE:Fares_Unformatted_A_P_N_:\'\'),duplicate_apn_multiple_address_id(OVERRIDE:Duplicate_Apn_With_Different_Address_Counter_:\'\'),assessee_name(OVERRIDE:Assessee_Name_:\'\'),second_assessee_name(OVERRIDE:Second_Assessee_Name_:\'\'),assessee_ownership_rights_code(OVERRIDE:Ownership_Method_Code_:\'\'),assessee_relationship_code(OVERRIDE:Owners_Relationship_Code_:\'\'),assessee_phone_number(OVERRIDE:Owner_Phone_Number_:\'\'),tax_account_number(OVERRIDE:Tax_Account_Number_:\'\'),assessee_name_type_code(OVERRIDE:Name1_I_D_Code_:\'\'),second_assessee_name_type_code(OVERRIDE:Name2_I_D_Code_:\'\'),mail_care_of_name_type_code(OVERRIDE:Mailing_Care_Of_Name_Type_Code_:\'\'),mailing_care_of_name(OVERRIDE:Mailing_Care_Of_Name_:\'\'),mailing_full_street_address(OVERRIDE:Mailing_Full_Street_Address_:\'\'),mailing_unit_number(OVERRIDE:Mailing_Unit_Number_:\'\'),mailing_city_state_zip(OVERRIDE:Mailing_City_State_Zip_:\'\'),property_full_street_address(OVERRIDE:Property_Full_Street_Address_:\'\'),property_unit_number(OVERRIDE:Property_Address_Unit_Number_:\'\'),property_city_state_zip(OVERRIDE:Property_Address_City_State_Zip_:\'\'),property_country_code(OVERRIDE:Property_Address_Country_Code_:\'\'),property_address_code(OVERRIDE:Property_Address_Code_:\'\'),legal_lot_code(OVERRIDE:Legal_Lot_Code_:\'\'),legal_lot_number(OVERRIDE:Legal_Lot_Number_:\'\'),legal_land_lot(OVERRIDE:Legal_Land_Lot_:0),legal_block(OVERRIDE:Legal_Block_:\'\'),legal_section(OVERRIDE:Legal_Section_:\'\'),legal_district(OVERRIDE:Legal_District_:\'\'),legal_unit(OVERRIDE:Legal_Unit_:\'\'),legal_city_municipality_township(OVERRIDE:Legal_City_Municipality_Township_:\'\'),legal_subdivision_name(OVERRIDE:Legal_Subdivision_Name_:\'\'),legal_phase_number(OVERRIDE:Legal_Phase_Number_:\'\'),legal_tract_number(OVERRIDE:Legal_Tract_Number_:0),legal_sec_twn_rng_mer(OVERRIDE:Legal_Section_Township_Range_Meridian_:\'\'),legal_brief_description(OVERRIDE:Legal_Brief_Description_:\'\'),legal_assessor_map_ref(OVERRIDE:Map_Reference_:\'\'),census_tract(OVERRIDE:Census_Tract_:\'\'),record_type_code(OVERRIDE:Record_Type_Code_:\'\'),ownership_type_code(OVERRIDE:Ownership_Type_Code_:\'\'),new_record_type_code(OVERRIDE:New_Record_Type_Code_:\'\'),state_land_use_code(OVERRIDE:State_Land_Use_Code_:\'\'),county_land_use_code(OVERRIDE:County_Land_Use_Code_:\'\'),county_land_use_description(OVERRIDE:County_Land_Use_Description_:\'\'),standardized_land_use_code(OVERRIDE:Standardized_Land_Use_Code_:\'\'),timeshare_code(OVERRIDE:Timeshare_Code_:\'\'),zoning(OVERRIDE:Zoning_:\'\'),owner_occupied(OVERRIDE:Occupant_Owned_),recorder_document_number(OVERRIDE:Document_Number_:0),recorder_book_number(OVERRIDE:Recorder_Book_Number_:0),recorder_page_number(OVERRIDE:Recorder_Page_Number_:0),transfer_date(OVERRIDE:Transfer_Date_:DATE:Transfer_Date_1Rule),recording_date(OVERRIDE:Recording_Date_:DATE:Recording_Date_1Rule),sale_date(OVERRIDE:Sale_Date_:DATE),document_type(OVERRIDE:Document_Type_Code_:\'\'),sales_price(OVERRIDE:Sale_Price_:0),sales_price_code(OVERRIDE:Sale_Price_Code_:\'\'),mortgage_loan_amount(OVERRIDE:Mortgage_Amount_:0),mortgage_loan_type_code(OVERRIDE:Mortgage_Type_:\'\'),mortgage_lender_name(OVERRIDE:Mortgage_Lender_Name_:\'\'),mortgage_lender_type_code(OVERRIDE:Lender_I_D_Code_:\'\'),prior_transfer_date(OVERRIDE:Prior_Transfer_Date_:DATE:Prior_Transfer_Date_1Rule),prior_recording_date(OVERRIDE:Previous_Recording_Date_:DATE:Previous_Recording_Date_1Rule),prior_sales_price(OVERRIDE:Previous_Sale_Price_:0),prior_sales_price_code(OVERRIDE:Previous_Sale_Price_Code_:\'\'),assessed_land_value(OVERRIDE:Assessed_Land_Value_:0),assessed_improvement_value(OVERRIDE:Assessed_Improvement_Value_:0),assessed_total_value(OVERRIDE:Assessed_Total_Value_:0),assessed_value_year(OVERRIDE:Assessed_Value_Year_:DATE:Assessed_Value_Year_1Rule),market_land_value(OVERRIDE:Market_Land_Value_:0),market_improvement_value(OVERRIDE:Market_Improvement_Value_:0),market_total_value(OVERRIDE:Market_Total_Value_:0),market_value_year(OVERRIDE:Market_Value_Year_:DATE:Market_Value_Year_1Rule),tax_exemption1_code(OVERRIDE:Tax_Exemption_Code1_:\'\'),tax_exemption2_code(OVERRIDE:Tax_Exemption_Code2_:\'\'),tax_exemption3_code(OVERRIDE:Tax_Exemption_Code3_:\'\'),tax_exemption4_code(OVERRIDE:Tax_Exemption_Code4_:\'\'),tax_rate_code_area(OVERRIDE:Tax_Rate_Code_Area_:\'\'),tax_amount(OVERRIDE:Tax_Amount_:0),tax_year(OVERRIDE:Tax_Year_:DATE:Tax_Year_1Rule),tax_delinquent_year(OVERRIDE:Tax_Delinquent_Year_:DATE:Tax_Delinquent_Year_1Rule),school_tax_district1(OVERRIDE:School_Tax_District1_:\'\'),school_tax_district2(OVERRIDE:School_Tax_District2_:\'\'),school_tax_district3(OVERRIDE:School_Tax_District3_:\'\'),school_tax_district1_indicator(OVERRIDE:School_Tax_District_Indicator1_:\'\'),school_tax_district2_indicator(OVERRIDE:School_Tax_District_Indicator2_:\'\'),school_tax_district3_indicator(OVERRIDE:School_Tax_District_Indicator3_:\'\'),lot_size(OVERRIDE:Lot_Size_:0),lot_size_acres(OVERRIDE:Lot_Size_Acres_:0),lot_size_frontage_feet(OVERRIDE:Lot_Size_Frontage_Feet_:0),lot_size_depth_feet(OVERRIDE:Lot_Size_Depth_Feet_:0),land_acres(OVERRIDE:Land_Acres_:0.0),land_square_footage(OVERRIDE:Land_Square_Footage_:0.0),land_dimensions(OVERRIDE:Land_Dimensions_:\'\'),building_area(OVERRIDE:Building_Area_:0),building_area1(OVERRIDE:Building_Area1_:0),building_area2(OVERRIDE:Building_Area2_:0),building_area3(OVERRIDE:Building_Area3_:0),building_area4(OVERRIDE:Building_Area4_:0),building_area5(OVERRIDE:Building_Area5_:0),building_area6(OVERRIDE:Building_Area6_:0),building_area7(OVERRIDE:Building_Area7_:0),building_area_indicator(OVERRIDE:Building_Area_Indicator_:\'\'),building_area1_indicator(OVERRIDE:Building_Area_Indicator1_:\'\'),building_area2_indicator(OVERRIDE:Building_Area_Indicator2_:\'\'),building_area3_indicator(OVERRIDE:Building_Area_Indicator3_:\'\'),building_area4_indicator(OVERRIDE:Building_Area_Indicator4_:\'\'),building_area5_indicator(OVERRIDE:Building_Area_Indicator5_:\'\'),building_area6_indicator(OVERRIDE:Building_Area_Indicator6_:\'\'),building_area7_indicator(OVERRIDE:Building_Area_Indicator7_:\'\'),year_built(OVERRIDE:Year_Built_:DATE:Year_Built_1Rule),effective_year_built(OVERRIDE:Effective_Year_Built_:DATE:Effective_Year_Built_1Rule),no_of_buildings(OVERRIDE:Number_Of_Buildings_:0),no_of_stories(OVERRIDE:Number_Of_Stories_:\'\'),no_of_units(OVERRIDE:Number_Of_Units_:0),no_of_rooms(OVERRIDE:Number_Of_Rooms_:0),no_of_bedrooms(OVERRIDE:Number_Of_Bedrooms_:\'\'),no_of_baths(OVERRIDE:Number_Of_Baths_:0.0),no_of_partial_baths(OVERRIDE:Number_Of_Partial_Baths_:\'\'),no_of_plumbing_fixtures(OVERRIDE:Number_Of_Plumbing_Fixtures_:0),garage_type_code(OVERRIDE:Garage_Type_Code_:\'\'),parking_no_of_cars(OVERRIDE:Parking_Number_Of_Cars_:0),pool_code(OVERRIDE:Pool_Code_:\'\'),style_code(OVERRIDE:Style_Code_:\'\'),type_construction_code(OVERRIDE:Type_Construction_Code_:\'\'),foundation_code(OVERRIDE:Foundation_Code_:\'\'),building_quality_code(OVERRIDE:Building_Quality_Code_:\'\'),building_condition_code(OVERRIDE:Building_Condition_Code_:\'\'),exterior_walls_code(OVERRIDE:Exterior_Walls_Code_:\'\'),interior_walls_code(OVERRIDE:Interior_Walls_Code_:\'\'),roof_cover_code(OVERRIDE:Roof_Cover_Code_:\'\'),roof_type_code(OVERRIDE:Roof_Type_Code_:\'\'),floor_cover_code(OVERRIDE:Floor_Cover_Code_:\'\'),water_code(OVERRIDE:Water_Code_:\'\'),sewer_code(OVERRIDE:Sewer_Code_:\'\'),heating_code(OVERRIDE:Heating_Code_:\'\'),heating_fuel_type_code(OVERRIDE:Heating_Fuel_Type_Code_:\'\'),air_conditioning_code(OVERRIDE:Air_Conditioning_Code_:\'\'),air_conditioning_type_code(OVERRIDE:Air_Conditioning_Type_Code_:\'\'),elevator(OVERRIDE:Elevator_:\'\'),fireplace_indicator(OVERRIDE:Fireplace_Indicator_),fireplace_number(OVERRIDE:Fireplace_Number_:0),basement_code(OVERRIDE:Basement_Code_:\'\'),building_class_code(OVERRIDE:Building_Class_Code_:\'\'),site_influence1_code(OVERRIDE:Site_Influence_Code1_:\'\'),site_influence2_code(OVERRIDE:Site_Influence_Code2_:\'\'),site_influence3_code(OVERRIDE:Site_Influence_Code3_:\'\'),site_influence4_code(OVERRIDE:Site_Influence_Code4_:\'\'),site_influence5_code(OVERRIDE:Site_Influence_Code5_:\'\'),amenities1_code(OVERRIDE:Amenity_Code1_:\'\'),amenities2_code(OVERRIDE:Amenity_Code2_:\'\'),amenities3_code(OVERRIDE:Amenity_Code3_:\'\'),amenities4_code(OVERRIDE:Amenity_Code4_:\'\'),amenities5_code(OVERRIDE:Amenity_Code5_:\'\'),amenities2_code1(OVERRIDE:Amenity_Code6_:\'\'),amenities2_code2(OVERRIDE:Amenity_Code7_:\'\'),amenities2_code3(OVERRIDE:Amenity_Code8_:\'\'),amenities2_code4(OVERRIDE:Amenity_Code9_:\'\'),amenities2_code5(OVERRIDE:Amenity_Code10_:\'\'),extra_features1_area(OVERRIDE:Extra_Feature_Area1_:\'\'),extra_features2_area(OVERRIDE:Extra_Feature_Area2_:\'\'),extra_features3_area(OVERRIDE:Extra_Feature_Area3_:\'\'),extra_features4_area(OVERRIDE:Extra_Feature_Area4_:\'\'),extra_features1_indicator(OVERRIDE:Extra_Feature_Indicator1_:\'\'),extra_features2_indicator(OVERRIDE:Extra_Feature_Indicator2_:\'\'),extra_features3_indicator(OVERRIDE:Extra_Feature_Indicator3_:\'\'),extra_features4_indicator(OVERRIDE:Extra_Feature_Indicator4_:\'\'),other_buildings1_code(OVERRIDE:Other_Building_Code1_:\'\'),other_buildings2_code(OVERRIDE:Other_Building_Code2_:\'\'),other_buildings3_code(OVERRIDE:Other_Building_Code3_:\'\'),other_buildings4_code(OVERRIDE:Other_Building_Code4_:\'\'),other_buildings5_code(OVERRIDE:Other_Building_Code5_:\'\'),other_impr_building1_indicator(OVERRIDE:Other_Important_Building_Indicator1_:\'\'),other_impr_building2_indicator(OVERRIDE:Other_Important_Building_Indicator2_:\'\'),other_impr_building3_indicator(OVERRIDE:Other_Important_Building_Indicator3_:\'\'),other_impr_building4_indicator(OVERRIDE:Other_Important_Building_Indicator4_:\'\'),other_impr_building5_indicator(OVERRIDE:Other_Important_Building_Indicator5_:\'\'),other_impr_building_area1(OVERRIDE:Other_Important_Building_Area1_:\'\'),other_impr_building_area2(OVERRIDE:Other_Important_Building_Area2_:\'\'),other_impr_building_area3(OVERRIDE:Other_Important_Building_Area3_:\'\'),other_impr_building_area4(OVERRIDE:Other_Important_Building_Area4_:\'\'),other_impr_building_area5(OVERRIDE:Other_Important_Building_Area5_:\'\'),topograpy_code(OVERRIDE:Topography_Code_:\'\'),neighborhood_code(OVERRIDE:Neighborhood_Code_:\'\'),condo_project_or_building_name(OVERRIDE:Condo_Project_Or_Building_Name_:\'\'),assessee_name_indicator(OVERRIDE:Assessee_Name_Indicator_:\'\'),second_assessee_name_indicator(OVERRIDE:Second_Assessee_Name_Indicator_:\'\'),other_rooms_indicator(OVERRIDE:Other_Rooms_Indicator_:\'\'),mail_care_of_name_indicator(OVERRIDE:Mail_Care_Of_Name_Indicator_:\'\'),comments(OVERRIDE:Comments_:\'\'),tape_cut_date(OVERRIDE:Tape_Cut_Date_:DATE:Tape_Cut_Date_1Rule),certification_date(OVERRIDE:Certification_Date_:DATE),edition_number(OVERRIDE:Edition_Number_:0),prop_addr_propagated_ind(OVERRIDE:Property_Address_Propegated_Indicator_:\'\'),ln_ownership_rights(OVERRIDE:L_N_Ownership_Rights_:\'\'),ln_relationship_type(OVERRIDE:L_N_Relationship_Type_:\'\'),ln_mailing_country_code(OVERRIDE:L_N_Mailing_Country_Code_:\'\'),ln_property_name(OVERRIDE:L_N_Property_Name_:\'\'),ln_property_name_type(OVERRIDE:L_N_Property_Name_Type_:\'\'),ln_land_use_category(OVERRIDE:L_N_Land_Use_Category_:\'\'),ln_lot(OVERRIDE:L_N_Lot_Number_:\'\'),ln_block(OVERRIDE:L_N_Block_Number_:\'\'),ln_unit(OVERRIDE:L_N_Unit_Number_:\'\'),ln_subfloor(OVERRIDE:L_N_Subfloor_:\'\'),ln_mobile_home_indicator(OVERRIDE:L_N_Mobile_Home_Indicator_),ln_condo_indicator(OVERRIDE:L_N_Condo_Indicator_),ln_property_tax_exemption(OVERRIDE:L_N_Property_Tax_Exemption_Indicator_),ln_veteran_status(OVERRIDE:L_N_Veteran_Status_:0),sourcefile(DEFAULT:Source_File_:\'\'),multiapnflag(DEFAULT:Multi_A_P_N_Flag_:\'\'),taxnumber(DEFAULT:Tax_Number_:0),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name1code(DEFAULT:Name1_Code_:\'\'),name2(DEFAULT:Name2_:\'\'),name2code(DEFAULT:Name2_Code_:\'\'),buyerborrowervestingcode(DEFAULT:Buyer_Borrower_Vesting_Code_:\'\'),buyerborroweraddendumflag(DEFAULT:Buyer_Borrower_Addendum_Flag_:\'\'),mailingcareof(DEFAULT:Mailing_Care_Of_:\'\'),mailingstreet(DEFAULT:Mailing_Street_:\'\'),seller1(DEFAULT:Seller1_:\'\'),seller1idcode(DEFAULT:Seller1_I_D_Code_:\'\'),seller2(DEFAULT:Seller2_:\'\'),seller2idcode(DEFAULT:Seller2_I_D_Code_:\'\'),selleraddendumflag(DEFAULT:Seller_Addendum_Flag_:\'\'),sellermailingfullstreetaddress(DEFAULT:Seller_Mailing_Full_Street_Address_:\'\'),sellermailingaddressunitnumber(DEFAULT:Seller_Mailing_Address_Unit_Number_:\'\'),sellermailingaddresscitystatezip(DEFAULT:Seller_Mailing_Address_City_State_Zip_:\'\'),legalcompletedescriptioncode(DEFAULT:Legal_Complete_Description_Code_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),adjustableratemortgageresetdate(DEFAULT:Adjustable_Rate_Mortgage_Reset_Date_:DATE),loannumber(DEFAULT:Loan_Number_:\'\'),concurrentmortgagebookpagedocumentnumber(DEFAULT:Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),citytransfertax(DEFAULT:City_Transfer_Tax_:0.0),countytransfertax(DEFAULT:County_Transfer_Tax_:0.0),totaltransfertax(DEFAULT:Total_Transfer_Tax_:0.0),primaryloanamount(DEFAULT:Primary_Loan_Amount_:0),secondaryloanamount(DEFAULT:Secondary_Loan_Amount_:0),primaryloanlendertypecode(DEFAULT:Primary_Loan_Lender_Type_Code_:\'\'),secondaryloanlendertypecode(DEFAULT:Secondary_Loan_Lender_Type_Code_:\'\'),primaryloantypecode(DEFAULT:Primary_Loan_Type_Code_:\'\'),typefinancing(DEFAULT:Type_Financing_:\'\'),primaryloaninterestrate(DEFAULT:Primary_Loan_Interest_Rate_:0.0),primaryloanduedate(DEFAULT:Primary_Loan_Due_Date_:DATE),titlecompanyname(DEFAULT:Title_Company_Name_:\'\'),partialinteresttransferred(DEFAULT:Partial_Interest_Transferred_:0),loantermmonths(DEFAULT:Loan_Term_Months_:0),loantermyears(DEFAULT:Loan_Term_Years_:0),lendername(DEFAULT:Lender_Name_:\'\'),lenderdbaname(DEFAULT:Lender_D_B_A_Name_:\'\'),lenderfullstreetaddress(DEFAULT:Lender_Full_Street_Address_:\'\'),lenderaddressunitnumber(DEFAULT:Lender_Address_Unit_Number_:\'\'),lenderaddresscitystatezip(DEFAULT:Lender_Address_City_State_Zip_:\'\'),propertyusecode(DEFAULT:Property_Use_Code_:\'\'),condocode(DEFAULT:Condo_Code_:\'\'),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),ratechangefrequency(DEFAULT:Rate_Change_Frequency_:\'\'),changeindex(DEFAULT:Change_Index_:0.0),adjustablerateindex(DEFAULT:Adjustable_Rate_Index_:\'\'),adjustableraterider(DEFAULT:Adjustable_Rate_Rider_:\'\'),graduatedpaymentrider(DEFAULT:Graduated_Payment_Rider_:\'\'),balloonrider(DEFAULT:Balloon_Rider_:\'\'),fixedstepraterider(DEFAULT:Fixed_Step_Rate_Rider_:\'\'),condominiumrider(DEFAULT:Condominium_Rider_:\'\'),plannedunitdevelopmentrider(DEFAULT:Planned_Unit_Development_Rider_:\'\'),assumabilityrider(DEFAULT:Assumability_Rider_:\'\'),prepaymentrider(DEFAULT:Prepayment_Rider_:\'\'),onefourfamilyrider(DEFAULT:One_Four_Family_Rider_:\'\'),biweeklypaymentrider(DEFAULT:Biweekly_Payment_Rider_:\'\'),secondhomerider(DEFAULT:Second_Home_Rider_:\'\'),datasourcecode(DEFAULT:Data_Source_Code_:\'\'),typeofdeedcode(DEFAULT:Type_Of_Deed_Code_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),lnbuyermailingcountrycode(DEFAULT:L_N_Buyer_Mailing_Country_Code_:\'\'),lnsellermailingcountrycode(DEFAULT:L_N_Seller_Mailing_Country_Code_:\'\'),faresowneretalindicator(DEFAULT:Fares_Owner_Et_Al_Indicator_:\'\'),faresownerrelationshipcode(DEFAULT:Fares_Owner_Relationship_Code_:\'\'),faresownerrelationshiptype(DEFAULT:Fares_Owner_Relationship_Type_:\'\'),faresmatchcode(DEFAULT:Fares_Match_Code_:\'\'),faresdocumentyear(DEFAULT:Fares_Document_Year_:DATE),farescorporateindicator(DEFAULT:Fares_Corporate_Indicator_),farestransactiontype(DEFAULT:Fares_Transaction_Type_:\'\'),fareslenderaddress(DEFAULT:Fares_Lender_Address_:\'\'),faressalestransactioncode(DEFAULT:Fares_Sales_Transaction_Code_:\'\'),faresresidentialmodelind(DEFAULT:Fares_Residential_Model_Ind_),faresmortgagedeedtype(DEFAULT:Fares_Mortgage_Deed_Type_:\'\'),faresmortgagetermcode(DEFAULT:Fares_Mortgage_Term_Code_:\'\'),faresmortgageterm(DEFAULT:Fares_Mortgage_Term_:0),faresmortgageassumptionamount(DEFAULT:Fares_Mortgage_Assumption_Amount_:0),faressecondmortgageloantypecode(DEFAULT:Fares_Second_Mortgage_Loan_Type_Code_:\'\'),faresseconddeedtype(DEFAULT:Fares_Second_Deed_Type_:\'\'),faresabsenteeindicator(DEFAULT:Fares_Absentee_Indicator_:\'\'),farespartialinterestindicator(DEFAULT:Fares_Partial_Interest_Indicator_),faresprimarycategorycode(DEFAULT:Fares_Primary_Category_Code_:\'\'),faresprivatepartylender(DEFAULT:Fares_Private_Party_Lender_:\'\'),faresconstructionloan(DEFAULT:Fares_Construction_Loan_:\'\'),faresresalenewconstruction(DEFAULT:Fares_Resale_New_Construction_:\'\'),faresinterfamily(DEFAULT:Fares_Inter_Family_:\'\'),farescashmortgagepurchase(DEFAULT:Fares_Cash_Mortgage_Purchase_:\'\'),faresbuildingsquarefeet(DEFAULT:Fares_Building_Square_Feet_:0),faresforeclosure(DEFAULT:Fares_Foreclosure_:\'\'),faresrefincanceflag(DEFAULT:Fares_Refincance_Flag_:\'\'),faresequityflag(DEFAULT:Fares_Equity_Flag_:\'\'),faresirisapn(DEFAULT:Fares_Iris_A_P_N_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Assessment_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Assessor_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Assessor_Fid),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Assessor_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d1_Prop__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d1_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_UID_Mapped,'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange','__in');
  SHARED __d1_Prop__Mapped := IF(__d1_Missing_Prop__UIDComponents = 'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange',PROJECT(__d1_UID_Mapped,TRANSFORM(__d1_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_UID_Mapped,__d1_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d1_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid := __d1_Prop__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Prop__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Recording_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Contract_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Adjustable_Rate_Mortgage_Reset_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Primary_Loan_Due_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Vendor_First_Reported_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_),Prop_(DEFAULT:Prop_:0),isassessment(DEFAULT:Is_Assessment_),isadditionalfaresdeed(DEFAULT:Is_Additional_Fares_Deed_),process_date(OVERRIDE:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),current_record(OVERRIDE:Current_Record_),fips_code(OVERRIDE:F_I_P_S_Code_:\'\'),state(OVERRIDE:State_:\'\'),county_name(OVERRIDE:County_Name_:\'\'),oldapn(DEFAULT:Old_A_P_N_:\'\'),apnt_or_pin_number(OVERRIDE:A_P_N_Number_:\'\'),fares_unformatted_apn(OVERRIDE:Fares_Unformatted_A_P_N_:\'\'),duplicateapnwithdifferentaddresscounter(DEFAULT:Duplicate_Apn_With_Different_Address_Counter_:\'\'),assesseename(DEFAULT:Assessee_Name_:\'\'),secondassesseename(DEFAULT:Second_Assessee_Name_:\'\'),ownershipmethodcode(DEFAULT:Ownership_Method_Code_:\'\'),ownersrelationshipcode(DEFAULT:Owners_Relationship_Code_:\'\'),phone_number(OVERRIDE:Owner_Phone_Number_:\'\'),taxaccountnumber(DEFAULT:Tax_Account_Number_:\'\'),name1idcode(DEFAULT:Name1_I_D_Code_:\'\'),name2idcode(DEFAULT:Name2_I_D_Code_:\'\'),mailingcareofnametypecode(DEFAULT:Mailing_Care_Of_Name_Type_Code_:\'\'),mailingcareofname(DEFAULT:Mailing_Care_Of_Name_:\'\'),mailingfullstreetaddress(DEFAULT:Mailing_Full_Street_Address_:\'\'),mailing_unit_number(OVERRIDE:Mailing_Unit_Number_:\'\'),mailing_csz(OVERRIDE:Mailing_City_State_Zip_:\'\'),property_full_street_address(OVERRIDE:Property_Full_Street_Address_:\'\'),property_address_unit_number(OVERRIDE:Property_Address_Unit_Number_:\'\'),property_address_citystatezip(OVERRIDE:Property_Address_City_State_Zip_:\'\'),propertyaddresscountrycode(DEFAULT:Property_Address_Country_Code_:\'\'),property_address_code(OVERRIDE:Property_Address_Code_:\'\'),legal_lot_code(OVERRIDE:Legal_Lot_Code_:\'\'),legal_lot_number(OVERRIDE:Legal_Lot_Number_:\'\'),legal_land_lot(OVERRIDE:Legal_Land_Lot_:0),legal_block(OVERRIDE:Legal_Block_:\'\'),legal_section(OVERRIDE:Legal_Section_:\'\'),legal_district(OVERRIDE:Legal_District_:\'\'),legal_unit(OVERRIDE:Legal_Unit_:\'\'),legal_city_municipality_township(OVERRIDE:Legal_City_Municipality_Township_:\'\'),legal_subdivision_name(OVERRIDE:Legal_Subdivision_Name_:\'\'),legal_phase_number(OVERRIDE:Legal_Phase_Number_:\'\'),legal_tract_number(OVERRIDE:Legal_Tract_Number_:0),legal_sec_twn_rng_mer(OVERRIDE:Legal_Section_Township_Range_Meridian_:\'\'),legal_brief_description(OVERRIDE:Legal_Brief_Description_:\'\'),recorder_map_reference(OVERRIDE:Map_Reference_:\'\'),censustract(DEFAULT:Census_Tract_:\'\'),recordtypecode(DEFAULT:Record_Type_Code_:\'\'),record_type(OVERRIDE:Ownership_Type_Code_:\'\'),newrecordtypecode(DEFAULT:New_Record_Type_Code_:\'\'),statelandusecode(DEFAULT:State_Land_Use_Code_:\'\'),countylandusecode(DEFAULT:County_Land_Use_Code_:\'\'),countylandusedescription(DEFAULT:County_Land_Use_Description_:\'\'),assessment_match_land_use_code(OVERRIDE:Standardized_Land_Use_Code_:\'\'),timesharecode(DEFAULT:Timeshare_Code_:\'\'),zoning(DEFAULT:Zoning_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),document_number(OVERRIDE:Document_Number_:0),recorder_book_number(OVERRIDE:Recorder_Book_Number_:0),recorder_page_number(OVERRIDE:Recorder_Page_Number_:0),transferdate(DEFAULT:Transfer_Date_:DATE),recording_date(OVERRIDE:Recording_Date_:DATE:Recording_Date_2Rule),saledate(DEFAULT:Sale_Date_:DATE),document_type_code(OVERRIDE:Document_Type_Code_:\'\'),sales_price(OVERRIDE:Sale_Price_:0),sales_price_code(OVERRIDE:Sale_Price_Code_:\'\'),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),mortgagelendername(DEFAULT:Mortgage_Lender_Name_:\'\'),lender_name_id(OVERRIDE:Lender_I_D_Code_:\'\'),priortransferdate(DEFAULT:Prior_Transfer_Date_:DATE),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),previoussalepricecode(DEFAULT:Previous_Sale_Price_Code_:\'\'),assessedlandvalue(DEFAULT:Assessed_Land_Value_:0),assessedimprovementvalue(DEFAULT:Assessed_Improvement_Value_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),marketlandvalue(DEFAULT:Market_Land_Value_:0),marketimprovementvalue(DEFAULT:Market_Improvement_Value_:0),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxexemptioncode1(DEFAULT:Tax_Exemption_Code1_:\'\'),taxexemptioncode2(DEFAULT:Tax_Exemption_Code2_:\'\'),taxexemptioncode3(DEFAULT:Tax_Exemption_Code3_:\'\'),taxexemptioncode4(DEFAULT:Tax_Exemption_Code4_:\'\'),taxratecodearea(DEFAULT:Tax_Rate_Code_Area_:\'\'),taxamount(DEFAULT:Tax_Amount_:0),taxyear(DEFAULT:Tax_Year_:DATE),taxdelinquentyear(DEFAULT:Tax_Delinquent_Year_:DATE),schooltaxdistrict1(DEFAULT:School_Tax_District1_:\'\'),schooltaxdistrict2(DEFAULT:School_Tax_District2_:\'\'),schooltaxdistrict3(DEFAULT:School_Tax_District3_:\'\'),schooltaxdistrictindicator1(DEFAULT:School_Tax_District_Indicator1_:\'\'),schooltaxdistrictindicator2(DEFAULT:School_Tax_District_Indicator2_:\'\'),schooltaxdistrictindicator3(DEFAULT:School_Tax_District_Indicator3_:\'\'),lotsize(DEFAULT:Lot_Size_:0),lotsizeacres(DEFAULT:Lot_Size_Acres_:0),lotsizefrontagefeet(DEFAULT:Lot_Size_Frontage_Feet_:0),lotsizedepthfeet(DEFAULT:Lot_Size_Depth_Feet_:0),landacres(DEFAULT:Land_Acres_:0.0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),landdimensions(DEFAULT:Land_Dimensions_:\'\'),buildingarea(DEFAULT:Building_Area_:0),buildingarea1(DEFAULT:Building_Area1_:0),buildingarea2(DEFAULT:Building_Area2_:0),buildingarea3(DEFAULT:Building_Area3_:0),buildingarea4(DEFAULT:Building_Area4_:0),buildingarea5(DEFAULT:Building_Area5_:0),buildingarea6(DEFAULT:Building_Area6_:0),buildingarea7(DEFAULT:Building_Area7_:0),buildingareaindicator(DEFAULT:Building_Area_Indicator_:\'\'),buildingareaindicator1(DEFAULT:Building_Area_Indicator1_:\'\'),buildingareaindicator2(DEFAULT:Building_Area_Indicator2_:\'\'),buildingareaindicator3(DEFAULT:Building_Area_Indicator3_:\'\'),buildingareaindicator4(DEFAULT:Building_Area_Indicator4_:\'\'),buildingareaindicator5(DEFAULT:Building_Area_Indicator5_:\'\'),buildingareaindicator6(DEFAULT:Building_Area_Indicator6_:\'\'),buildingareaindicator7(DEFAULT:Building_Area_Indicator7_:\'\'),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),numberofplumbingfixtures(DEFAULT:Number_Of_Plumbing_Fixtures_:0),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),poolcode(DEFAULT:Pool_Code_:\'\'),stylecode(DEFAULT:Style_Code_:\'\'),typeconstructioncode(DEFAULT:Type_Construction_Code_:\'\'),foundationcode(DEFAULT:Foundation_Code_:\'\'),buildingqualitycode(DEFAULT:Building_Quality_Code_:\'\'),buildingconditioncode(DEFAULT:Building_Condition_Code_:\'\'),exteriorwallscode(DEFAULT:Exterior_Walls_Code_:\'\'),interiorwallscode(DEFAULT:Interior_Walls_Code_:\'\'),roofcovercode(DEFAULT:Roof_Cover_Code_:\'\'),rooftypecode(DEFAULT:Roof_Type_Code_:\'\'),floorcovercode(DEFAULT:Floor_Cover_Code_:\'\'),watercode(DEFAULT:Water_Code_:\'\'),sewercode(DEFAULT:Sewer_Code_:\'\'),heatingcode(DEFAULT:Heating_Code_:\'\'),heatingfueltypecode(DEFAULT:Heating_Fuel_Type_Code_:\'\'),airconditioningcode(DEFAULT:Air_Conditioning_Code_:\'\'),airconditioningtypecode(DEFAULT:Air_Conditioning_Type_Code_:\'\'),elevator(DEFAULT:Elevator_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),fireplacenumber(DEFAULT:Fireplace_Number_:0),basementcode(DEFAULT:Basement_Code_:\'\'),buildingclasscode(DEFAULT:Building_Class_Code_:\'\'),siteinfluencecode1(DEFAULT:Site_Influence_Code1_:\'\'),siteinfluencecode2(DEFAULT:Site_Influence_Code2_:\'\'),siteinfluencecode3(DEFAULT:Site_Influence_Code3_:\'\'),siteinfluencecode4(DEFAULT:Site_Influence_Code4_:\'\'),siteinfluencecode5(DEFAULT:Site_Influence_Code5_:\'\'),amenitycode1(DEFAULT:Amenity_Code1_:\'\'),amenitycode2(DEFAULT:Amenity_Code2_:\'\'),amenitycode3(DEFAULT:Amenity_Code3_:\'\'),amenitycode4(DEFAULT:Amenity_Code4_:\'\'),amenitycode5(DEFAULT:Amenity_Code5_:\'\'),amenitycode6(DEFAULT:Amenity_Code6_:\'\'),amenitycode7(DEFAULT:Amenity_Code7_:\'\'),amenitycode8(DEFAULT:Amenity_Code8_:\'\'),amenitycode9(DEFAULT:Amenity_Code9_:\'\'),amenitycode10(DEFAULT:Amenity_Code10_:\'\'),extrafeaturearea1(DEFAULT:Extra_Feature_Area1_:\'\'),extrafeaturearea2(DEFAULT:Extra_Feature_Area2_:\'\'),extrafeaturearea3(DEFAULT:Extra_Feature_Area3_:\'\'),extrafeaturearea4(DEFAULT:Extra_Feature_Area4_:\'\'),extrafeatureindicator1(DEFAULT:Extra_Feature_Indicator1_:\'\'),extrafeatureindicator2(DEFAULT:Extra_Feature_Indicator2_:\'\'),extrafeatureindicator3(DEFAULT:Extra_Feature_Indicator3_:\'\'),extrafeatureindicator4(DEFAULT:Extra_Feature_Indicator4_:\'\'),otherbuildingcode1(DEFAULT:Other_Building_Code1_:\'\'),otherbuildingcode2(DEFAULT:Other_Building_Code2_:\'\'),otherbuildingcode3(DEFAULT:Other_Building_Code3_:\'\'),otherbuildingcode4(DEFAULT:Other_Building_Code4_:\'\'),otherbuildingcode5(DEFAULT:Other_Building_Code5_:\'\'),otherimportantbuildingindicator1(DEFAULT:Other_Important_Building_Indicator1_:\'\'),otherimportantbuildingindicator2(DEFAULT:Other_Important_Building_Indicator2_:\'\'),otherimportantbuildingindicator3(DEFAULT:Other_Important_Building_Indicator3_:\'\'),otherimportantbuildingindicator4(DEFAULT:Other_Important_Building_Indicator4_:\'\'),otherimportantbuildingindicator5(DEFAULT:Other_Important_Building_Indicator5_:\'\'),otherimportantbuildingarea1(DEFAULT:Other_Important_Building_Area1_:\'\'),otherimportantbuildingarea2(DEFAULT:Other_Important_Building_Area2_:\'\'),otherimportantbuildingarea3(DEFAULT:Other_Important_Building_Area3_:\'\'),otherimportantbuildingarea4(DEFAULT:Other_Important_Building_Area4_:\'\'),otherimportantbuildingarea5(DEFAULT:Other_Important_Building_Area5_:\'\'),topographycode(DEFAULT:Topography_Code_:\'\'),neighborhoodcode(DEFAULT:Neighborhood_Code_:\'\'),condoprojectorbuildingname(DEFAULT:Condo_Project_Or_Building_Name_:\'\'),assesseenameindicator(DEFAULT:Assessee_Name_Indicator_:\'\'),secondassesseenameindicator(DEFAULT:Second_Assessee_Name_Indicator_:\'\'),otherroomsindicator(DEFAULT:Other_Rooms_Indicator_:\'\'),mailcareofnameindicator(DEFAULT:Mail_Care_Of_Name_Indicator_:\'\'),comments(DEFAULT:Comments_:\'\'),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),editionnumber(DEFAULT:Edition_Number_:0),prop_addr_propagated_ind(OVERRIDE:Property_Address_Propegated_Indicator_:\'\'),ln_ownership_rights(OVERRIDE:L_N_Ownership_Rights_:\'\'),ln_relationship_type(OVERRIDE:L_N_Relationship_Type_:\'\'),lnmailingcountrycode(DEFAULT:L_N_Mailing_Country_Code_:\'\'),lnpropertyname(DEFAULT:L_N_Property_Name_:\'\'),lnpropertynametype(DEFAULT:L_N_Property_Name_Type_:\'\'),lnlandusecategory(DEFAULT:L_N_Land_Use_Category_:\'\'),lnlotnumber(DEFAULT:L_N_Lot_Number_:\'\'),lnblocknumber(DEFAULT:L_N_Block_Number_:\'\'),lnunitnumber(DEFAULT:L_N_Unit_Number_:\'\'),lnsubfloor(DEFAULT:L_N_Subfloor_:\'\'),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),lnveteranstatus(DEFAULT:L_N_Veteran_Status_:0),from_file(OVERRIDE:Source_File_:\'\'),multi_apn_flag(OVERRIDE:Multi_A_P_N_Flag_:\'\'),tax_id_number(OVERRIDE:Tax_Number_:0),buyer_or_borrower_ind(OVERRIDE:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(OVERRIDE:Name1_:\'\'),name1_id_code(OVERRIDE:Name1_Code_:\'\'),name2(OVERRIDE:Name2_:\'\'),name2_id_code(OVERRIDE:Name2_Code_:\'\'),vesting_code(OVERRIDE:Buyer_Borrower_Vesting_Code_:\'\'),addendum_flag(OVERRIDE:Buyer_Borrower_Addendum_Flag_:\'\'),mailing_care_of(OVERRIDE:Mailing_Care_Of_:\'\'),mailing_street(OVERRIDE:Mailing_Street_:\'\'),seller1(OVERRIDE:Seller1_:\'\'),seller1_id_code(OVERRIDE:Seller1_I_D_Code_:\'\'),seller2(OVERRIDE:Seller2_:\'\'),seller2_id_code(OVERRIDE:Seller2_I_D_Code_:\'\'),seller_addendum_flag(OVERRIDE:Seller_Addendum_Flag_:\'\'),seller_mailing_full_street_address(OVERRIDE:Seller_Mailing_Full_Street_Address_:\'\'),seller_mailing_address_unit_number(OVERRIDE:Seller_Mailing_Address_Unit_Number_:\'\'),seller_mailing_address_citystatezip(OVERRIDE:Seller_Mailing_Address_City_State_Zip_:\'\'),complete_legal_description_code(OVERRIDE:Legal_Complete_Description_Code_:\'\'),contract_date(OVERRIDE:Contract_Date_:DATE:Contract_Date_2Rule),arm_reset_date(OVERRIDE:Adjustable_Rate_Mortgage_Reset_Date_:DATE:Adjustable_Rate_Mortgage_Reset_Date_2Rule),loan_number(OVERRIDE:Loan_Number_:\'\'),concurrent_mortgage_book_page_document_number(OVERRIDE:Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),city_transfer_tax(OVERRIDE:City_Transfer_Tax_:0.0),county_transfer_tax(OVERRIDE:County_Transfer_Tax_:0.0),total_transfer_tax(OVERRIDE:Total_Transfer_Tax_:0.0),first_td_loan_amount(OVERRIDE:Primary_Loan_Amount_:0),second_td_loan_amount(OVERRIDE:Secondary_Loan_Amount_:0),first_td_lender_type_code(OVERRIDE:Primary_Loan_Lender_Type_Code_:\'\'),second_td_lender_type_code(OVERRIDE:Secondary_Loan_Lender_Type_Code_:\'\'),first_td_loan_type_code(OVERRIDE:Primary_Loan_Type_Code_:\'\'),type_financing(OVERRIDE:Type_Financing_:\'\'),first_td_interest_rate(OVERRIDE:Primary_Loan_Interest_Rate_:0.0),first_td_due_date(OVERRIDE:Primary_Loan_Due_Date_:DATE:Primary_Loan_Due_Date_2Rule),title_company_name(OVERRIDE:Title_Company_Name_:\'\'),partial_interest_transferred(OVERRIDE:Partial_Interest_Transferred_:0),loan_term_months(OVERRIDE:Loan_Term_Months_:0),loan_term_years(OVERRIDE:Loan_Term_Years_:0),lender_name(OVERRIDE:Lender_Name_:\'\'),lender_dba_aka_name(OVERRIDE:Lender_D_B_A_Name_:\'\'),lender_full_street_address(OVERRIDE:Lender_Full_Street_Address_:\'\'),lender_address_unit_number(OVERRIDE:Lender_Address_Unit_Number_:\'\'),lender_address_citystatezip(OVERRIDE:Lender_Address_City_State_Zip_:\'\'),property_use_code(OVERRIDE:Property_Use_Code_:\'\'),condo_code(OVERRIDE:Condo_Code_:\'\'),timeshare_flag(OVERRIDE:Timeshare_Flag_),land_lot_size(OVERRIDE:Land_Lot_Size_:\'\'),rate_change_frequency(OVERRIDE:Rate_Change_Frequency_:\'\'),change_index(OVERRIDE:Change_Index_:0.0),adjustable_rate_index(OVERRIDE:Adjustable_Rate_Index_:\'\'),adjustable_rate_rider(OVERRIDE:Adjustable_Rate_Rider_:\'\'),graduated_payment_rider(OVERRIDE:Graduated_Payment_Rider_:\'\'),balloon_rider(OVERRIDE:Balloon_Rider_:\'\'),fixed_step_rate_rider(OVERRIDE:Fixed_Step_Rate_Rider_:\'\'),condominium_rider(OVERRIDE:Condominium_Rider_:\'\'),planned_unit_development_rider(OVERRIDE:Planned_Unit_Development_Rider_:\'\'),assumability_rider(OVERRIDE:Assumability_Rider_:\'\'),prepayment_rider(OVERRIDE:Prepayment_Rider_:\'\'),one_four_family_rider(OVERRIDE:One_Four_Family_Rider_:\'\'),biweekly_payment_rider(OVERRIDE:Biweekly_Payment_Rider_:\'\'),second_home_rider(OVERRIDE:Second_Home_Rider_:\'\'),data_source_code(OVERRIDE:Data_Source_Code_:\'\'),main_record_id_code(OVERRIDE:Type_Of_Deed_Code_:\'\'),addl_name_flag(OVERRIDE:Additional_Name_Flag_),ln_buyer_mailing_country_code(OVERRIDE:L_N_Buyer_Mailing_Country_Code_:\'\'),ln_seller_mailing_country_code(OVERRIDE:L_N_Seller_Mailing_Country_Code_:\'\'),faresowneretalindicator(DEFAULT:Fares_Owner_Et_Al_Indicator_:\'\'),faresownerrelationshipcode(DEFAULT:Fares_Owner_Relationship_Code_:\'\'),faresownerrelationshiptype(DEFAULT:Fares_Owner_Relationship_Type_:\'\'),faresmatchcode(DEFAULT:Fares_Match_Code_:\'\'),faresdocumentyear(DEFAULT:Fares_Document_Year_:DATE),farescorporateindicator(DEFAULT:Fares_Corporate_Indicator_),farestransactiontype(DEFAULT:Fares_Transaction_Type_:\'\'),fareslenderaddress(DEFAULT:Fares_Lender_Address_:\'\'),faressalestransactioncode(DEFAULT:Fares_Sales_Transaction_Code_:\'\'),faresresidentialmodelind(DEFAULT:Fares_Residential_Model_Ind_),faresmortgagedeedtype(DEFAULT:Fares_Mortgage_Deed_Type_:\'\'),faresmortgagetermcode(DEFAULT:Fares_Mortgage_Term_Code_:\'\'),faresmortgageterm(DEFAULT:Fares_Mortgage_Term_:0),faresmortgageassumptionamount(DEFAULT:Fares_Mortgage_Assumption_Amount_:0),faressecondmortgageloantypecode(DEFAULT:Fares_Second_Mortgage_Loan_Type_Code_:\'\'),faresseconddeedtype(DEFAULT:Fares_Second_Deed_Type_:\'\'),faresabsenteeindicator(DEFAULT:Fares_Absentee_Indicator_:\'\'),farespartialinterestindicator(DEFAULT:Fares_Partial_Interest_Indicator_),faresprimarycategorycode(DEFAULT:Fares_Primary_Category_Code_:\'\'),faresprivatepartylender(DEFAULT:Fares_Private_Party_Lender_:\'\'),faresconstructionloan(DEFAULT:Fares_Construction_Loan_:\'\'),faresresalenewconstruction(DEFAULT:Fares_Resale_New_Construction_:\'\'),faresinterfamily(DEFAULT:Fares_Inter_Family_:\'\'),farescashmortgagepurchase(DEFAULT:Fares_Cash_Mortgage_Purchase_:\'\'),faresbuildingsquarefeet(DEFAULT:Fares_Building_Square_Feet_:0),faresforeclosure(DEFAULT:Fares_Foreclosure_:\'\'),faresrefincanceflag(DEFAULT:Fares_Refincance_Flag_:\'\'),faresequityflag(DEFAULT:Fares_Equity_Flag_:\'\'),faresirisapn(DEFAULT:Fares_Iris_A_P_N_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_2Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_2Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Deed_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Deed_Fid_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Deed_Fid_Fid),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Deed_Fid_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d2_Prop__Layout := RECORD
    RECORDOF(__d2_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d2_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_UID_Mapped,'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange','__in');
  SHARED __d2_Prop__Mapped := IF(__d2_Missing_Prop__UIDComponents = 'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange',PROJECT(__d2_UID_Mapped,TRANSFORM(__d2_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_UID_Mapped,__d2_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d2_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid := __d2_Prop__Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_Prop__Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  SHARED Date_Vendor_First_Reported_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),zip(OVERRIDE:Z_I_P5_:0),sec_range(OVERRIDE:Secondary_Range_),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isassessment(DEFAULT:Is_Assessment_),isadditionalfaresdeed(DEFAULT:Is_Additional_Fares_Deed_),processdate(DEFAULT:Process_Date_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),currentrecord(DEFAULT:Current_Record_),fipscode(DEFAULT:F_I_P_S_Code_:\'\'),state(DEFAULT:State_:\'\'),countyname(DEFAULT:County_Name_:\'\'),oldapn(DEFAULT:Old_A_P_N_:\'\'),apnnumber(DEFAULT:A_P_N_Number_:\'\'),faresunformattedapn(DEFAULT:Fares_Unformatted_A_P_N_:\'\'),duplicateapnwithdifferentaddresscounter(DEFAULT:Duplicate_Apn_With_Different_Address_Counter_:\'\'),assesseename(DEFAULT:Assessee_Name_:\'\'),secondassesseename(DEFAULT:Second_Assessee_Name_:\'\'),ownershipmethodcode(DEFAULT:Ownership_Method_Code_:\'\'),ownersrelationshipcode(DEFAULT:Owners_Relationship_Code_:\'\'),ownerphonenumber(DEFAULT:Owner_Phone_Number_:\'\'),taxaccountnumber(DEFAULT:Tax_Account_Number_:\'\'),name1idcode(DEFAULT:Name1_I_D_Code_:\'\'),name2idcode(DEFAULT:Name2_I_D_Code_:\'\'),mailingcareofnametypecode(DEFAULT:Mailing_Care_Of_Name_Type_Code_:\'\'),mailingcareofname(DEFAULT:Mailing_Care_Of_Name_:\'\'),mailingfullstreetaddress(DEFAULT:Mailing_Full_Street_Address_:\'\'),mailingunitnumber(DEFAULT:Mailing_Unit_Number_:\'\'),mailingcitystatezip(DEFAULT:Mailing_City_State_Zip_:\'\'),propertyfullstreetaddress(DEFAULT:Property_Full_Street_Address_:\'\'),propertyaddressunitnumber(DEFAULT:Property_Address_Unit_Number_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),propertyaddresscountrycode(DEFAULT:Property_Address_Country_Code_:\'\'),propertyaddresscode(DEFAULT:Property_Address_Code_:\'\'),legallotcode(DEFAULT:Legal_Lot_Code_:\'\'),legallotnumber(DEFAULT:Legal_Lot_Number_:\'\'),legallandlot(DEFAULT:Legal_Land_Lot_:0),legalblock(DEFAULT:Legal_Block_:\'\'),legalsection(DEFAULT:Legal_Section_:\'\'),legaldistrict(DEFAULT:Legal_District_:\'\'),legalunit(DEFAULT:Legal_Unit_:\'\'),legalcitymunicipalitytownship(DEFAULT:Legal_City_Municipality_Township_:\'\'),legalsubdivisionname(DEFAULT:Legal_Subdivision_Name_:\'\'),legalphasenumber(DEFAULT:Legal_Phase_Number_:\'\'),legaltractnumber(DEFAULT:Legal_Tract_Number_:0),legalsectiontownshiprangemeridian(DEFAULT:Legal_Section_Township_Range_Meridian_:\'\'),legalbriefdescription(DEFAULT:Legal_Brief_Description_:\'\'),mapreference(DEFAULT:Map_Reference_:\'\'),censustract(DEFAULT:Census_Tract_:\'\'),recordtypecode(DEFAULT:Record_Type_Code_:\'\'),ownershiptypecode(DEFAULT:Ownership_Type_Code_:\'\'),newrecordtypecode(DEFAULT:New_Record_Type_Code_:\'\'),statelandusecode(DEFAULT:State_Land_Use_Code_:\'\'),countylandusecode(DEFAULT:County_Land_Use_Code_:\'\'),countylandusedescription(DEFAULT:County_Land_Use_Description_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),timesharecode(DEFAULT:Timeshare_Code_:\'\'),zoning(DEFAULT:Zoning_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),documentnumber(DEFAULT:Document_Number_:0),recorderbooknumber(DEFAULT:Recorder_Book_Number_:0),recorderpagenumber(DEFAULT:Recorder_Page_Number_:0),transferdate(DEFAULT:Transfer_Date_:DATE),recordingdate(DEFAULT:Recording_Date_:DATE),saledate(DEFAULT:Sale_Date_:DATE),documenttypecode(DEFAULT:Document_Type_Code_:\'\'),saleprice(DEFAULT:Sale_Price_:0),salepricecode(DEFAULT:Sale_Price_Code_:\'\'),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),mortgagelendername(DEFAULT:Mortgage_Lender_Name_:\'\'),lenderidcode(DEFAULT:Lender_I_D_Code_:\'\'),priortransferdate(DEFAULT:Prior_Transfer_Date_:DATE),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),previoussalepricecode(DEFAULT:Previous_Sale_Price_Code_:\'\'),assessedlandvalue(DEFAULT:Assessed_Land_Value_:0),assessedimprovementvalue(DEFAULT:Assessed_Improvement_Value_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),marketlandvalue(DEFAULT:Market_Land_Value_:0),marketimprovementvalue(DEFAULT:Market_Improvement_Value_:0),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxexemptioncode1(DEFAULT:Tax_Exemption_Code1_:\'\'),taxexemptioncode2(DEFAULT:Tax_Exemption_Code2_:\'\'),taxexemptioncode3(DEFAULT:Tax_Exemption_Code3_:\'\'),taxexemptioncode4(DEFAULT:Tax_Exemption_Code4_:\'\'),taxratecodearea(DEFAULT:Tax_Rate_Code_Area_:\'\'),taxamount(DEFAULT:Tax_Amount_:0),taxyear(DEFAULT:Tax_Year_:DATE),taxdelinquentyear(DEFAULT:Tax_Delinquent_Year_:DATE),schooltaxdistrict1(DEFAULT:School_Tax_District1_:\'\'),schooltaxdistrict2(DEFAULT:School_Tax_District2_:\'\'),schooltaxdistrict3(DEFAULT:School_Tax_District3_:\'\'),schooltaxdistrictindicator1(DEFAULT:School_Tax_District_Indicator1_:\'\'),schooltaxdistrictindicator2(DEFAULT:School_Tax_District_Indicator2_:\'\'),schooltaxdistrictindicator3(DEFAULT:School_Tax_District_Indicator3_:\'\'),lotsize(DEFAULT:Lot_Size_:0),lotsizeacres(DEFAULT:Lot_Size_Acres_:0),lotsizefrontagefeet(DEFAULT:Lot_Size_Frontage_Feet_:0),lotsizedepthfeet(DEFAULT:Lot_Size_Depth_Feet_:0),landacres(DEFAULT:Land_Acres_:0.0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),landdimensions(DEFAULT:Land_Dimensions_:\'\'),buildingarea(DEFAULT:Building_Area_:0),buildingarea1(DEFAULT:Building_Area1_:0),buildingarea2(DEFAULT:Building_Area2_:0),buildingarea3(DEFAULT:Building_Area3_:0),buildingarea4(DEFAULT:Building_Area4_:0),buildingarea5(DEFAULT:Building_Area5_:0),buildingarea6(DEFAULT:Building_Area6_:0),buildingarea7(DEFAULT:Building_Area7_:0),buildingareaindicator(DEFAULT:Building_Area_Indicator_:\'\'),buildingareaindicator1(DEFAULT:Building_Area_Indicator1_:\'\'),buildingareaindicator2(DEFAULT:Building_Area_Indicator2_:\'\'),buildingareaindicator3(DEFAULT:Building_Area_Indicator3_:\'\'),buildingareaindicator4(DEFAULT:Building_Area_Indicator4_:\'\'),buildingareaindicator5(DEFAULT:Building_Area_Indicator5_:\'\'),buildingareaindicator6(DEFAULT:Building_Area_Indicator6_:\'\'),buildingareaindicator7(DEFAULT:Building_Area_Indicator7_:\'\'),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),numberofplumbingfixtures(DEFAULT:Number_Of_Plumbing_Fixtures_:0),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),poolcode(DEFAULT:Pool_Code_:\'\'),stylecode(DEFAULT:Style_Code_:\'\'),typeconstructioncode(DEFAULT:Type_Construction_Code_:\'\'),foundationcode(DEFAULT:Foundation_Code_:\'\'),buildingqualitycode(DEFAULT:Building_Quality_Code_:\'\'),buildingconditioncode(DEFAULT:Building_Condition_Code_:\'\'),exteriorwallscode(DEFAULT:Exterior_Walls_Code_:\'\'),interiorwallscode(DEFAULT:Interior_Walls_Code_:\'\'),roofcovercode(DEFAULT:Roof_Cover_Code_:\'\'),rooftypecode(DEFAULT:Roof_Type_Code_:\'\'),floorcovercode(DEFAULT:Floor_Cover_Code_:\'\'),watercode(DEFAULT:Water_Code_:\'\'),sewercode(DEFAULT:Sewer_Code_:\'\'),heatingcode(DEFAULT:Heating_Code_:\'\'),heatingfueltypecode(DEFAULT:Heating_Fuel_Type_Code_:\'\'),airconditioningcode(DEFAULT:Air_Conditioning_Code_:\'\'),airconditioningtypecode(DEFAULT:Air_Conditioning_Type_Code_:\'\'),elevator(DEFAULT:Elevator_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),fireplacenumber(DEFAULT:Fireplace_Number_:0),basementcode(DEFAULT:Basement_Code_:\'\'),buildingclasscode(DEFAULT:Building_Class_Code_:\'\'),siteinfluencecode1(DEFAULT:Site_Influence_Code1_:\'\'),siteinfluencecode2(DEFAULT:Site_Influence_Code2_:\'\'),siteinfluencecode3(DEFAULT:Site_Influence_Code3_:\'\'),siteinfluencecode4(DEFAULT:Site_Influence_Code4_:\'\'),siteinfluencecode5(DEFAULT:Site_Influence_Code5_:\'\'),amenitycode1(DEFAULT:Amenity_Code1_:\'\'),amenitycode2(DEFAULT:Amenity_Code2_:\'\'),amenitycode3(DEFAULT:Amenity_Code3_:\'\'),amenitycode4(DEFAULT:Amenity_Code4_:\'\'),amenitycode5(DEFAULT:Amenity_Code5_:\'\'),amenitycode6(DEFAULT:Amenity_Code6_:\'\'),amenitycode7(DEFAULT:Amenity_Code7_:\'\'),amenitycode8(DEFAULT:Amenity_Code8_:\'\'),amenitycode9(DEFAULT:Amenity_Code9_:\'\'),amenitycode10(DEFAULT:Amenity_Code10_:\'\'),extrafeaturearea1(DEFAULT:Extra_Feature_Area1_:\'\'),extrafeaturearea2(DEFAULT:Extra_Feature_Area2_:\'\'),extrafeaturearea3(DEFAULT:Extra_Feature_Area3_:\'\'),extrafeaturearea4(DEFAULT:Extra_Feature_Area4_:\'\'),extrafeatureindicator1(DEFAULT:Extra_Feature_Indicator1_:\'\'),extrafeatureindicator2(DEFAULT:Extra_Feature_Indicator2_:\'\'),extrafeatureindicator3(DEFAULT:Extra_Feature_Indicator3_:\'\'),extrafeatureindicator4(DEFAULT:Extra_Feature_Indicator4_:\'\'),otherbuildingcode1(DEFAULT:Other_Building_Code1_:\'\'),otherbuildingcode2(DEFAULT:Other_Building_Code2_:\'\'),otherbuildingcode3(DEFAULT:Other_Building_Code3_:\'\'),otherbuildingcode4(DEFAULT:Other_Building_Code4_:\'\'),otherbuildingcode5(DEFAULT:Other_Building_Code5_:\'\'),otherimportantbuildingindicator1(DEFAULT:Other_Important_Building_Indicator1_:\'\'),otherimportantbuildingindicator2(DEFAULT:Other_Important_Building_Indicator2_:\'\'),otherimportantbuildingindicator3(DEFAULT:Other_Important_Building_Indicator3_:\'\'),otherimportantbuildingindicator4(DEFAULT:Other_Important_Building_Indicator4_:\'\'),otherimportantbuildingindicator5(DEFAULT:Other_Important_Building_Indicator5_:\'\'),otherimportantbuildingarea1(DEFAULT:Other_Important_Building_Area1_:\'\'),otherimportantbuildingarea2(DEFAULT:Other_Important_Building_Area2_:\'\'),otherimportantbuildingarea3(DEFAULT:Other_Important_Building_Area3_:\'\'),otherimportantbuildingarea4(DEFAULT:Other_Important_Building_Area4_:\'\'),otherimportantbuildingarea5(DEFAULT:Other_Important_Building_Area5_:\'\'),topographycode(DEFAULT:Topography_Code_:\'\'),neighborhoodcode(DEFAULT:Neighborhood_Code_:\'\'),condoprojectorbuildingname(DEFAULT:Condo_Project_Or_Building_Name_:\'\'),assesseenameindicator(DEFAULT:Assessee_Name_Indicator_:\'\'),secondassesseenameindicator(DEFAULT:Second_Assessee_Name_Indicator_:\'\'),otherroomsindicator(DEFAULT:Other_Rooms_Indicator_:\'\'),mailcareofnameindicator(DEFAULT:Mail_Care_Of_Name_Indicator_:\'\'),comments(DEFAULT:Comments_:\'\'),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),editionnumber(DEFAULT:Edition_Number_:0),propertyaddresspropegatedindicator(DEFAULT:Property_Address_Propegated_Indicator_:\'\'),lnownershiprights(DEFAULT:L_N_Ownership_Rights_:\'\'),lnrelationshiptype(DEFAULT:L_N_Relationship_Type_:\'\'),lnmailingcountrycode(DEFAULT:L_N_Mailing_Country_Code_:\'\'),lnpropertyname(DEFAULT:L_N_Property_Name_:\'\'),lnpropertynametype(DEFAULT:L_N_Property_Name_Type_:\'\'),lnlandusecategory(DEFAULT:L_N_Land_Use_Category_:\'\'),lnlotnumber(DEFAULT:L_N_Lot_Number_:\'\'),lnblocknumber(DEFAULT:L_N_Block_Number_:\'\'),lnunitnumber(DEFAULT:L_N_Unit_Number_:\'\'),lnsubfloor(DEFAULT:L_N_Subfloor_:\'\'),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),lnveteranstatus(DEFAULT:L_N_Veteran_Status_:0),sourcefile(DEFAULT:Source_File_:\'\'),multiapnflag(DEFAULT:Multi_A_P_N_Flag_:\'\'),taxnumber(DEFAULT:Tax_Number_:0),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name1code(DEFAULT:Name1_Code_:\'\'),name2(DEFAULT:Name2_:\'\'),name2code(DEFAULT:Name2_Code_:\'\'),buyerborrowervestingcode(DEFAULT:Buyer_Borrower_Vesting_Code_:\'\'),buyerborroweraddendumflag(DEFAULT:Buyer_Borrower_Addendum_Flag_:\'\'),mailingcareof(DEFAULT:Mailing_Care_Of_:\'\'),mailingstreet(DEFAULT:Mailing_Street_:\'\'),seller1(DEFAULT:Seller1_:\'\'),seller1idcode(DEFAULT:Seller1_I_D_Code_:\'\'),seller2(DEFAULT:Seller2_:\'\'),seller2idcode(DEFAULT:Seller2_I_D_Code_:\'\'),selleraddendumflag(DEFAULT:Seller_Addendum_Flag_:\'\'),sellermailingfullstreetaddress(DEFAULT:Seller_Mailing_Full_Street_Address_:\'\'),sellermailingaddressunitnumber(DEFAULT:Seller_Mailing_Address_Unit_Number_:\'\'),sellermailingaddresscitystatezip(DEFAULT:Seller_Mailing_Address_City_State_Zip_:\'\'),legalcompletedescriptioncode(DEFAULT:Legal_Complete_Description_Code_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),adjustableratemortgageresetdate(DEFAULT:Adjustable_Rate_Mortgage_Reset_Date_:DATE),loannumber(DEFAULT:Loan_Number_:\'\'),concurrentmortgagebookpagedocumentnumber(DEFAULT:Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),citytransfertax(DEFAULT:City_Transfer_Tax_:0.0),countytransfertax(DEFAULT:County_Transfer_Tax_:0.0),totaltransfertax(DEFAULT:Total_Transfer_Tax_:0.0),primaryloanamount(DEFAULT:Primary_Loan_Amount_:0),secondaryloanamount(DEFAULT:Secondary_Loan_Amount_:0),primaryloanlendertypecode(DEFAULT:Primary_Loan_Lender_Type_Code_:\'\'),secondaryloanlendertypecode(DEFAULT:Secondary_Loan_Lender_Type_Code_:\'\'),primaryloantypecode(DEFAULT:Primary_Loan_Type_Code_:\'\'),typefinancing(DEFAULT:Type_Financing_:\'\'),primaryloaninterestrate(DEFAULT:Primary_Loan_Interest_Rate_:0.0),primaryloanduedate(DEFAULT:Primary_Loan_Due_Date_:DATE),titlecompanyname(DEFAULT:Title_Company_Name_:\'\'),partialinteresttransferred(DEFAULT:Partial_Interest_Transferred_:0),loantermmonths(DEFAULT:Loan_Term_Months_:0),loantermyears(DEFAULT:Loan_Term_Years_:0),lendername(DEFAULT:Lender_Name_:\'\'),lenderdbaname(DEFAULT:Lender_D_B_A_Name_:\'\'),lenderfullstreetaddress(DEFAULT:Lender_Full_Street_Address_:\'\'),lenderaddressunitnumber(DEFAULT:Lender_Address_Unit_Number_:\'\'),lenderaddresscitystatezip(DEFAULT:Lender_Address_City_State_Zip_:\'\'),propertyusecode(DEFAULT:Property_Use_Code_:\'\'),condocode(DEFAULT:Condo_Code_:\'\'),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),ratechangefrequency(DEFAULT:Rate_Change_Frequency_:\'\'),changeindex(DEFAULT:Change_Index_:0.0),adjustablerateindex(DEFAULT:Adjustable_Rate_Index_:\'\'),adjustableraterider(DEFAULT:Adjustable_Rate_Rider_:\'\'),graduatedpaymentrider(DEFAULT:Graduated_Payment_Rider_:\'\'),balloonrider(DEFAULT:Balloon_Rider_:\'\'),fixedstepraterider(DEFAULT:Fixed_Step_Rate_Rider_:\'\'),condominiumrider(DEFAULT:Condominium_Rider_:\'\'),plannedunitdevelopmentrider(DEFAULT:Planned_Unit_Development_Rider_:\'\'),assumabilityrider(DEFAULT:Assumability_Rider_:\'\'),prepaymentrider(DEFAULT:Prepayment_Rider_:\'\'),onefourfamilyrider(DEFAULT:One_Four_Family_Rider_:\'\'),biweeklypaymentrider(DEFAULT:Biweekly_Payment_Rider_:\'\'),secondhomerider(DEFAULT:Second_Home_Rider_:\'\'),datasourcecode(DEFAULT:Data_Source_Code_:\'\'),typeofdeedcode(DEFAULT:Type_Of_Deed_Code_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),lnbuyermailingcountrycode(DEFAULT:L_N_Buyer_Mailing_Country_Code_:\'\'),lnsellermailingcountrycode(DEFAULT:L_N_Seller_Mailing_Country_Code_:\'\'),faresowneretalindicator(DEFAULT:Fares_Owner_Et_Al_Indicator_:\'\'),faresownerrelationshipcode(DEFAULT:Fares_Owner_Relationship_Code_:\'\'),faresownerrelationshiptype(DEFAULT:Fares_Owner_Relationship_Type_:\'\'),faresmatchcode(DEFAULT:Fares_Match_Code_:\'\'),faresdocumentyear(DEFAULT:Fares_Document_Year_:DATE),farescorporateindicator(DEFAULT:Fares_Corporate_Indicator_),farestransactiontype(DEFAULT:Fares_Transaction_Type_:\'\'),fareslenderaddress(DEFAULT:Fares_Lender_Address_:\'\'),faressalestransactioncode(DEFAULT:Fares_Sales_Transaction_Code_:\'\'),faresresidentialmodelind(DEFAULT:Fares_Residential_Model_Ind_),faresmortgagedeedtype(DEFAULT:Fares_Mortgage_Deed_Type_:\'\'),faresmortgagetermcode(DEFAULT:Fares_Mortgage_Term_Code_:\'\'),faresmortgageterm(DEFAULT:Fares_Mortgage_Term_:0),faresmortgageassumptionamount(DEFAULT:Fares_Mortgage_Assumption_Amount_:0),faressecondmortgageloantypecode(DEFAULT:Fares_Second_Mortgage_Loan_Type_Code_:\'\'),faresseconddeedtype(DEFAULT:Fares_Second_Deed_Type_:\'\'),faresabsenteeindicator(DEFAULT:Fares_Absentee_Indicator_:\'\'),farespartialinterestindicator(DEFAULT:Fares_Partial_Interest_Indicator_),faresprimarycategorycode(DEFAULT:Fares_Primary_Category_Code_:\'\'),faresprivatepartylender(DEFAULT:Fares_Private_Party_Lender_:\'\'),faresconstructionloan(DEFAULT:Fares_Construction_Loan_:\'\'),faresresalenewconstruction(DEFAULT:Fares_Resale_New_Construction_:\'\'),faresinterfamily(DEFAULT:Fares_Inter_Family_:\'\'),farescashmortgagepurchase(DEFAULT:Fares_Cash_Mortgage_Purchase_:\'\'),faresbuildingsquarefeet(DEFAULT:Fares_Building_Square_Feet_:0),faresforeclosure(DEFAULT:Fares_Foreclosure_:\'\'),faresrefincanceflag(DEFAULT:Fares_Refincance_Flag_:\'\'),faresequityflag(DEFAULT:Fares_Equity_Flag_:\'\'),faresirisapn(DEFAULT:Fares_Iris_A_P_N_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_3Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_3Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Search_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Search_Fid),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Search_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d3_Prop__Layout := RECORD
    RECORDOF(__d3_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d3_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_UID_Mapped,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d3_Prop__Mapped := IF(__d3_Missing_Prop__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d3_UID_Mapped,TRANSFORM(__d3_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_UID_Mapped,__d3_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid := __d3_Prop__Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_Prop__Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Property_Event_Group := __PostFilter;
  Layout Property_Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.L_N_Fares_I_D_ := KEL.Intake.SingleValue(__recs,L_N_Fares_I_D_);
    SELF.Primary_Range_ := KEL.Intake.SingleValue(__recs,Primary_Range_);
    SELF.Predirectional_ := KEL.Intake.SingleValue(__recs,Predirectional_);
    SELF.Primary_Name_ := KEL.Intake.SingleValue(__recs,Primary_Name_);
    SELF.Suffix_ := KEL.Intake.SingleValue(__recs,Suffix_);
    SELF.Postdirectional_ := KEL.Intake.SingleValue(__recs,Postdirectional_);
    SELF.Z_I_P5_ := KEL.Intake.SingleValue(__recs,Z_I_P5_);
    SELF.Secondary_Range_ := KEL.Intake.SingleValue(__recs,Secondary_Range_);
    SELF.Prop_ := KEL.Intake.SingleValue(__recs,Prop_);
    SELF.Is_Deed_ := KEL.Intake.SingleValue(__recs,Is_Deed_);
    SELF.Is_Assessment_ := KEL.Intake.SingleValue(__recs,Is_Assessment_);
    SELF.Is_Additional_Fares_Deed_ := KEL.Intake.SingleValue(__recs,Is_Additional_Fares_Deed_);
    SELF.Process_Date_ := KEL.Intake.SingleValue(__recs,Process_Date_);
    SELF.Vendor_Source_Code_ := KEL.Intake.SingleValue(__recs,Vendor_Source_Code_);
    SELF.Current_Record_ := KEL.Intake.SingleValue(__recs,Current_Record_);
    SELF.F_I_P_S_Code_ := KEL.Intake.SingleValue(__recs,F_I_P_S_Code_);
    SELF.State_ := KEL.Intake.SingleValue(__recs,State_);
    SELF.County_Name_ := KEL.Intake.SingleValue(__recs,County_Name_);
    SELF.Old_A_P_N_ := KEL.Intake.SingleValue(__recs,Old_A_P_N_);
    SELF.A_P_N_Number_ := KEL.Intake.SingleValue(__recs,A_P_N_Number_);
    SELF.Fares_Unformatted_A_P_N_ := KEL.Intake.SingleValue(__recs,Fares_Unformatted_A_P_N_);
    SELF.Duplicate_Apn_With_Different_Address_Counter_ := KEL.Intake.SingleValue(__recs,Duplicate_Apn_With_Different_Address_Counter_);
    SELF.Assessee_Name_ := KEL.Intake.SingleValue(__recs,Assessee_Name_);
    SELF.Second_Assessee_Name_ := KEL.Intake.SingleValue(__recs,Second_Assessee_Name_);
    SELF.Ownership_Method_Code_ := KEL.Intake.SingleValue(__recs,Ownership_Method_Code_);
    SELF.Owners_Relationship_Code_ := KEL.Intake.SingleValue(__recs,Owners_Relationship_Code_);
    SELF.Owner_Phone_Number_ := KEL.Intake.SingleValue(__recs,Owner_Phone_Number_);
    SELF.Tax_Account_Number_ := KEL.Intake.SingleValue(__recs,Tax_Account_Number_);
    SELF.Name1_I_D_Code_ := KEL.Intake.SingleValue(__recs,Name1_I_D_Code_);
    SELF.Name2_I_D_Code_ := KEL.Intake.SingleValue(__recs,Name2_I_D_Code_);
    SELF.Mailing_Care_Of_Name_Type_Code_ := KEL.Intake.SingleValue(__recs,Mailing_Care_Of_Name_Type_Code_);
    SELF.Mailing_Care_Of_Name_ := KEL.Intake.SingleValue(__recs,Mailing_Care_Of_Name_);
    SELF.Mailing_Full_Street_Address_ := KEL.Intake.SingleValue(__recs,Mailing_Full_Street_Address_);
    SELF.Mailing_Unit_Number_ := KEL.Intake.SingleValue(__recs,Mailing_Unit_Number_);
    SELF.Mailing_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Mailing_City_State_Zip_);
    SELF.Property_Full_Street_Address_ := KEL.Intake.SingleValue(__recs,Property_Full_Street_Address_);
    SELF.Property_Address_Unit_Number_ := KEL.Intake.SingleValue(__recs,Property_Address_Unit_Number_);
    SELF.Property_Address_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Property_Address_City_State_Zip_);
    SELF.Property_Address_Country_Code_ := KEL.Intake.SingleValue(__recs,Property_Address_Country_Code_);
    SELF.Property_Address_Code_ := KEL.Intake.SingleValue(__recs,Property_Address_Code_);
    SELF.Legal_Lot_Code_ := KEL.Intake.SingleValue(__recs,Legal_Lot_Code_);
    SELF.Legal_Lot_Number_ := KEL.Intake.SingleValue(__recs,Legal_Lot_Number_);
    SELF.Legal_Land_Lot_ := KEL.Intake.SingleValue(__recs,Legal_Land_Lot_);
    SELF.Legal_Block_ := KEL.Intake.SingleValue(__recs,Legal_Block_);
    SELF.Legal_Section_ := KEL.Intake.SingleValue(__recs,Legal_Section_);
    SELF.Legal_District_ := KEL.Intake.SingleValue(__recs,Legal_District_);
    SELF.Legal_Unit_ := KEL.Intake.SingleValue(__recs,Legal_Unit_);
    SELF.Legal_City_Municipality_Township_ := KEL.Intake.SingleValue(__recs,Legal_City_Municipality_Township_);
    SELF.Legal_Subdivision_Name_ := KEL.Intake.SingleValue(__recs,Legal_Subdivision_Name_);
    SELF.Legal_Phase_Number_ := KEL.Intake.SingleValue(__recs,Legal_Phase_Number_);
    SELF.Legal_Tract_Number_ := KEL.Intake.SingleValue(__recs,Legal_Tract_Number_);
    SELF.Legal_Section_Township_Range_Meridian_ := KEL.Intake.SingleValue(__recs,Legal_Section_Township_Range_Meridian_);
    SELF.Legal_Brief_Description_ := KEL.Intake.SingleValue(__recs,Legal_Brief_Description_);
    SELF.Map_Reference_ := KEL.Intake.SingleValue(__recs,Map_Reference_);
    SELF.Census_Tract_ := KEL.Intake.SingleValue(__recs,Census_Tract_);
    SELF.Record_Type_Code_ := KEL.Intake.SingleValue(__recs,Record_Type_Code_);
    SELF.Ownership_Type_Code_ := KEL.Intake.SingleValue(__recs,Ownership_Type_Code_);
    SELF.New_Record_Type_Code_ := KEL.Intake.SingleValue(__recs,New_Record_Type_Code_);
    SELF.State_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,State_Land_Use_Code_);
    SELF.County_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,County_Land_Use_Code_);
    SELF.County_Land_Use_Description_ := KEL.Intake.SingleValue(__recs,County_Land_Use_Description_);
    SELF.Standardized_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,Standardized_Land_Use_Code_);
    SELF.Timeshare_Code_ := KEL.Intake.SingleValue(__recs,Timeshare_Code_);
    SELF.Zoning_ := KEL.Intake.SingleValue(__recs,Zoning_);
    SELF.Occupant_Owned_ := KEL.Intake.SingleValue(__recs,Occupant_Owned_);
    SELF.Document_Number_ := KEL.Intake.SingleValue(__recs,Document_Number_);
    SELF.Recorder_Book_Number_ := KEL.Intake.SingleValue(__recs,Recorder_Book_Number_);
    SELF.Recorder_Page_Number_ := KEL.Intake.SingleValue(__recs,Recorder_Page_Number_);
    SELF.Transfer_Date_ := KEL.Intake.SingleValue(__recs,Transfer_Date_);
    SELF.Recording_Date_ := KEL.Intake.SingleValue(__recs,Recording_Date_);
    SELF.Sale_Date_ := KEL.Intake.SingleValue(__recs,Sale_Date_);
    SELF.Document_Type_Code_ := KEL.Intake.SingleValue(__recs,Document_Type_Code_);
    SELF.Sale_Price_ := KEL.Intake.SingleValue(__recs,Sale_Price_);
    SELF.Sale_Price_Code_ := KEL.Intake.SingleValue(__recs,Sale_Price_Code_);
    SELF.Mortgage_Amount_ := KEL.Intake.SingleValue(__recs,Mortgage_Amount_);
    SELF.Mortgage_Type_ := KEL.Intake.SingleValue(__recs,Mortgage_Type_);
    SELF.Mortgage_Lender_Name_ := KEL.Intake.SingleValue(__recs,Mortgage_Lender_Name_);
    SELF.Lender_I_D_Code_ := KEL.Intake.SingleValue(__recs,Lender_I_D_Code_);
    SELF.Prior_Transfer_Date_ := KEL.Intake.SingleValue(__recs,Prior_Transfer_Date_);
    SELF.Previous_Recording_Date_ := KEL.Intake.SingleValue(__recs,Previous_Recording_Date_);
    SELF.Previous_Sale_Price_ := KEL.Intake.SingleValue(__recs,Previous_Sale_Price_);
    SELF.Previous_Sale_Price_Code_ := KEL.Intake.SingleValue(__recs,Previous_Sale_Price_Code_);
    SELF.Assessed_Land_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Land_Value_);
    SELF.Assessed_Improvement_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Improvement_Value_);
    SELF.Assessed_Total_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Total_Value_);
    SELF.Assessed_Value_Year_ := KEL.Intake.SingleValue(__recs,Assessed_Value_Year_);
    SELF.Market_Land_Value_ := KEL.Intake.SingleValue(__recs,Market_Land_Value_);
    SELF.Market_Improvement_Value_ := KEL.Intake.SingleValue(__recs,Market_Improvement_Value_);
    SELF.Market_Total_Value_ := KEL.Intake.SingleValue(__recs,Market_Total_Value_);
    SELF.Market_Value_Year_ := KEL.Intake.SingleValue(__recs,Market_Value_Year_);
    SELF.Tax_Exemption_Code1_ := KEL.Intake.SingleValue(__recs,Tax_Exemption_Code1_);
    SELF.Tax_Exemption_Code2_ := KEL.Intake.SingleValue(__recs,Tax_Exemption_Code2_);
    SELF.Tax_Exemption_Code3_ := KEL.Intake.SingleValue(__recs,Tax_Exemption_Code3_);
    SELF.Tax_Exemption_Code4_ := KEL.Intake.SingleValue(__recs,Tax_Exemption_Code4_);
    SELF.Tax_Rate_Code_Area_ := KEL.Intake.SingleValue(__recs,Tax_Rate_Code_Area_);
    SELF.Tax_Amount_ := KEL.Intake.SingleValue(__recs,Tax_Amount_);
    SELF.Tax_Year_ := KEL.Intake.SingleValue(__recs,Tax_Year_);
    SELF.Tax_Delinquent_Year_ := KEL.Intake.SingleValue(__recs,Tax_Delinquent_Year_);
    SELF.School_Tax_District1_ := KEL.Intake.SingleValue(__recs,School_Tax_District1_);
    SELF.School_Tax_District2_ := KEL.Intake.SingleValue(__recs,School_Tax_District2_);
    SELF.School_Tax_District3_ := KEL.Intake.SingleValue(__recs,School_Tax_District3_);
    SELF.School_Tax_District_Indicator1_ := KEL.Intake.SingleValue(__recs,School_Tax_District_Indicator1_);
    SELF.School_Tax_District_Indicator2_ := KEL.Intake.SingleValue(__recs,School_Tax_District_Indicator2_);
    SELF.School_Tax_District_Indicator3_ := KEL.Intake.SingleValue(__recs,School_Tax_District_Indicator3_);
    SELF.Lot_Size_ := KEL.Intake.SingleValue(__recs,Lot_Size_);
    SELF.Lot_Size_Acres_ := KEL.Intake.SingleValue(__recs,Lot_Size_Acres_);
    SELF.Lot_Size_Frontage_Feet_ := KEL.Intake.SingleValue(__recs,Lot_Size_Frontage_Feet_);
    SELF.Lot_Size_Depth_Feet_ := KEL.Intake.SingleValue(__recs,Lot_Size_Depth_Feet_);
    SELF.Land_Acres_ := KEL.Intake.SingleValue(__recs,Land_Acres_);
    SELF.Land_Square_Footage_ := KEL.Intake.SingleValue(__recs,Land_Square_Footage_);
    SELF.Land_Dimensions_ := KEL.Intake.SingleValue(__recs,Land_Dimensions_);
    SELF.Building_Area_ := KEL.Intake.SingleValue(__recs,Building_Area_);
    SELF.Building_Area1_ := KEL.Intake.SingleValue(__recs,Building_Area1_);
    SELF.Building_Area2_ := KEL.Intake.SingleValue(__recs,Building_Area2_);
    SELF.Building_Area3_ := KEL.Intake.SingleValue(__recs,Building_Area3_);
    SELF.Building_Area4_ := KEL.Intake.SingleValue(__recs,Building_Area4_);
    SELF.Building_Area5_ := KEL.Intake.SingleValue(__recs,Building_Area5_);
    SELF.Building_Area6_ := KEL.Intake.SingleValue(__recs,Building_Area6_);
    SELF.Building_Area7_ := KEL.Intake.SingleValue(__recs,Building_Area7_);
    SELF.Building_Area_Indicator_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator_);
    SELF.Building_Area_Indicator1_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator1_);
    SELF.Building_Area_Indicator2_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator2_);
    SELF.Building_Area_Indicator3_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator3_);
    SELF.Building_Area_Indicator4_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator4_);
    SELF.Building_Area_Indicator5_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator5_);
    SELF.Building_Area_Indicator6_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator6_);
    SELF.Building_Area_Indicator7_ := KEL.Intake.SingleValue(__recs,Building_Area_Indicator7_);
    SELF.Year_Built_ := KEL.Intake.SingleValue(__recs,Year_Built_);
    SELF.Effective_Year_Built_ := KEL.Intake.SingleValue(__recs,Effective_Year_Built_);
    SELF.Number_Of_Buildings_ := KEL.Intake.SingleValue(__recs,Number_Of_Buildings_);
    SELF.Number_Of_Stories_ := KEL.Intake.SingleValue(__recs,Number_Of_Stories_);
    SELF.Number_Of_Units_ := KEL.Intake.SingleValue(__recs,Number_Of_Units_);
    SELF.Number_Of_Rooms_ := KEL.Intake.SingleValue(__recs,Number_Of_Rooms_);
    SELF.Number_Of_Bedrooms_ := KEL.Intake.SingleValue(__recs,Number_Of_Bedrooms_);
    SELF.Number_Of_Baths_ := KEL.Intake.SingleValue(__recs,Number_Of_Baths_);
    SELF.Number_Of_Partial_Baths_ := KEL.Intake.SingleValue(__recs,Number_Of_Partial_Baths_);
    SELF.Number_Of_Plumbing_Fixtures_ := KEL.Intake.SingleValue(__recs,Number_Of_Plumbing_Fixtures_);
    SELF.Garage_Type_Code_ := KEL.Intake.SingleValue(__recs,Garage_Type_Code_);
    SELF.Parking_Number_Of_Cars_ := KEL.Intake.SingleValue(__recs,Parking_Number_Of_Cars_);
    SELF.Pool_Code_ := KEL.Intake.SingleValue(__recs,Pool_Code_);
    SELF.Style_Code_ := KEL.Intake.SingleValue(__recs,Style_Code_);
    SELF.Type_Construction_Code_ := KEL.Intake.SingleValue(__recs,Type_Construction_Code_);
    SELF.Foundation_Code_ := KEL.Intake.SingleValue(__recs,Foundation_Code_);
    SELF.Building_Quality_Code_ := KEL.Intake.SingleValue(__recs,Building_Quality_Code_);
    SELF.Building_Condition_Code_ := KEL.Intake.SingleValue(__recs,Building_Condition_Code_);
    SELF.Exterior_Walls_Code_ := KEL.Intake.SingleValue(__recs,Exterior_Walls_Code_);
    SELF.Interior_Walls_Code_ := KEL.Intake.SingleValue(__recs,Interior_Walls_Code_);
    SELF.Roof_Cover_Code_ := KEL.Intake.SingleValue(__recs,Roof_Cover_Code_);
    SELF.Roof_Type_Code_ := KEL.Intake.SingleValue(__recs,Roof_Type_Code_);
    SELF.Floor_Cover_Code_ := KEL.Intake.SingleValue(__recs,Floor_Cover_Code_);
    SELF.Water_Code_ := KEL.Intake.SingleValue(__recs,Water_Code_);
    SELF.Sewer_Code_ := KEL.Intake.SingleValue(__recs,Sewer_Code_);
    SELF.Heating_Code_ := KEL.Intake.SingleValue(__recs,Heating_Code_);
    SELF.Heating_Fuel_Type_Code_ := KEL.Intake.SingleValue(__recs,Heating_Fuel_Type_Code_);
    SELF.Air_Conditioning_Code_ := KEL.Intake.SingleValue(__recs,Air_Conditioning_Code_);
    SELF.Air_Conditioning_Type_Code_ := KEL.Intake.SingleValue(__recs,Air_Conditioning_Type_Code_);
    SELF.Elevator_ := KEL.Intake.SingleValue(__recs,Elevator_);
    SELF.Fireplace_Indicator_ := KEL.Intake.SingleValue(__recs,Fireplace_Indicator_);
    SELF.Fireplace_Number_ := KEL.Intake.SingleValue(__recs,Fireplace_Number_);
    SELF.Basement_Code_ := KEL.Intake.SingleValue(__recs,Basement_Code_);
    SELF.Building_Class_Code_ := KEL.Intake.SingleValue(__recs,Building_Class_Code_);
    SELF.Site_Influence_Code1_ := KEL.Intake.SingleValue(__recs,Site_Influence_Code1_);
    SELF.Site_Influence_Code2_ := KEL.Intake.SingleValue(__recs,Site_Influence_Code2_);
    SELF.Site_Influence_Code3_ := KEL.Intake.SingleValue(__recs,Site_Influence_Code3_);
    SELF.Site_Influence_Code4_ := KEL.Intake.SingleValue(__recs,Site_Influence_Code4_);
    SELF.Site_Influence_Code5_ := KEL.Intake.SingleValue(__recs,Site_Influence_Code5_);
    SELF.Amenity_Code1_ := KEL.Intake.SingleValue(__recs,Amenity_Code1_);
    SELF.Amenity_Code2_ := KEL.Intake.SingleValue(__recs,Amenity_Code2_);
    SELF.Amenity_Code3_ := KEL.Intake.SingleValue(__recs,Amenity_Code3_);
    SELF.Amenity_Code4_ := KEL.Intake.SingleValue(__recs,Amenity_Code4_);
    SELF.Amenity_Code5_ := KEL.Intake.SingleValue(__recs,Amenity_Code5_);
    SELF.Amenity_Code6_ := KEL.Intake.SingleValue(__recs,Amenity_Code6_);
    SELF.Amenity_Code7_ := KEL.Intake.SingleValue(__recs,Amenity_Code7_);
    SELF.Amenity_Code8_ := KEL.Intake.SingleValue(__recs,Amenity_Code8_);
    SELF.Amenity_Code9_ := KEL.Intake.SingleValue(__recs,Amenity_Code9_);
    SELF.Amenity_Code10_ := KEL.Intake.SingleValue(__recs,Amenity_Code10_);
    SELF.Extra_Feature_Area1_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Area1_);
    SELF.Extra_Feature_Area2_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Area2_);
    SELF.Extra_Feature_Area3_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Area3_);
    SELF.Extra_Feature_Area4_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Area4_);
    SELF.Extra_Feature_Indicator1_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Indicator1_);
    SELF.Extra_Feature_Indicator2_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Indicator2_);
    SELF.Extra_Feature_Indicator3_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Indicator3_);
    SELF.Extra_Feature_Indicator4_ := KEL.Intake.SingleValue(__recs,Extra_Feature_Indicator4_);
    SELF.Other_Building_Code1_ := KEL.Intake.SingleValue(__recs,Other_Building_Code1_);
    SELF.Other_Building_Code2_ := KEL.Intake.SingleValue(__recs,Other_Building_Code2_);
    SELF.Other_Building_Code3_ := KEL.Intake.SingleValue(__recs,Other_Building_Code3_);
    SELF.Other_Building_Code4_ := KEL.Intake.SingleValue(__recs,Other_Building_Code4_);
    SELF.Other_Building_Code5_ := KEL.Intake.SingleValue(__recs,Other_Building_Code5_);
    SELF.Other_Important_Building_Indicator1_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Indicator1_);
    SELF.Other_Important_Building_Indicator2_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Indicator2_);
    SELF.Other_Important_Building_Indicator3_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Indicator3_);
    SELF.Other_Important_Building_Indicator4_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Indicator4_);
    SELF.Other_Important_Building_Indicator5_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Indicator5_);
    SELF.Other_Important_Building_Area1_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Area1_);
    SELF.Other_Important_Building_Area2_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Area2_);
    SELF.Other_Important_Building_Area3_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Area3_);
    SELF.Other_Important_Building_Area4_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Area4_);
    SELF.Other_Important_Building_Area5_ := KEL.Intake.SingleValue(__recs,Other_Important_Building_Area5_);
    SELF.Topography_Code_ := KEL.Intake.SingleValue(__recs,Topography_Code_);
    SELF.Neighborhood_Code_ := KEL.Intake.SingleValue(__recs,Neighborhood_Code_);
    SELF.Condo_Project_Or_Building_Name_ := KEL.Intake.SingleValue(__recs,Condo_Project_Or_Building_Name_);
    SELF.Assessee_Name_Indicator_ := KEL.Intake.SingleValue(__recs,Assessee_Name_Indicator_);
    SELF.Second_Assessee_Name_Indicator_ := KEL.Intake.SingleValue(__recs,Second_Assessee_Name_Indicator_);
    SELF.Other_Rooms_Indicator_ := KEL.Intake.SingleValue(__recs,Other_Rooms_Indicator_);
    SELF.Mail_Care_Of_Name_Indicator_ := KEL.Intake.SingleValue(__recs,Mail_Care_Of_Name_Indicator_);
    SELF.Comments_ := KEL.Intake.SingleValue(__recs,Comments_);
    SELF.Tape_Cut_Date_ := KEL.Intake.SingleValue(__recs,Tape_Cut_Date_);
    SELF.Certification_Date_ := KEL.Intake.SingleValue(__recs,Certification_Date_);
    SELF.Edition_Number_ := KEL.Intake.SingleValue(__recs,Edition_Number_);
    SELF.Property_Address_Propegated_Indicator_ := KEL.Intake.SingleValue(__recs,Property_Address_Propegated_Indicator_);
    SELF.L_N_Ownership_Rights_ := KEL.Intake.SingleValue(__recs,L_N_Ownership_Rights_);
    SELF.L_N_Relationship_Type_ := KEL.Intake.SingleValue(__recs,L_N_Relationship_Type_);
    SELF.L_N_Mailing_Country_Code_ := KEL.Intake.SingleValue(__recs,L_N_Mailing_Country_Code_);
    SELF.L_N_Property_Name_ := KEL.Intake.SingleValue(__recs,L_N_Property_Name_);
    SELF.L_N_Property_Name_Type_ := KEL.Intake.SingleValue(__recs,L_N_Property_Name_Type_);
    SELF.L_N_Land_Use_Category_ := KEL.Intake.SingleValue(__recs,L_N_Land_Use_Category_);
    SELF.L_N_Lot_Number_ := KEL.Intake.SingleValue(__recs,L_N_Lot_Number_);
    SELF.L_N_Block_Number_ := KEL.Intake.SingleValue(__recs,L_N_Block_Number_);
    SELF.L_N_Unit_Number_ := KEL.Intake.SingleValue(__recs,L_N_Unit_Number_);
    SELF.L_N_Subfloor_ := KEL.Intake.SingleValue(__recs,L_N_Subfloor_);
    SELF.L_N_Mobile_Home_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Mobile_Home_Indicator_);
    SELF.L_N_Condo_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Condo_Indicator_);
    SELF.L_N_Property_Tax_Exemption_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Property_Tax_Exemption_Indicator_);
    SELF.L_N_Veteran_Status_ := KEL.Intake.SingleValue(__recs,L_N_Veteran_Status_);
    SELF.Source_File_ := KEL.Intake.SingleValue(__recs,Source_File_);
    SELF.Multi_A_P_N_Flag_ := KEL.Intake.SingleValue(__recs,Multi_A_P_N_Flag_);
    SELF.Tax_Number_ := KEL.Intake.SingleValue(__recs,Tax_Number_);
    SELF.Buyer_Or_Borrower_Or_Assessee_ := KEL.Intake.SingleValue(__recs,Buyer_Or_Borrower_Or_Assessee_);
    SELF.Name1_ := KEL.Intake.SingleValue(__recs,Name1_);
    SELF.Name1_Code_ := KEL.Intake.SingleValue(__recs,Name1_Code_);
    SELF.Name2_ := KEL.Intake.SingleValue(__recs,Name2_);
    SELF.Name2_Code_ := KEL.Intake.SingleValue(__recs,Name2_Code_);
    SELF.Buyer_Borrower_Vesting_Code_ := KEL.Intake.SingleValue(__recs,Buyer_Borrower_Vesting_Code_);
    SELF.Buyer_Borrower_Addendum_Flag_ := KEL.Intake.SingleValue(__recs,Buyer_Borrower_Addendum_Flag_);
    SELF.Mailing_Care_Of_ := KEL.Intake.SingleValue(__recs,Mailing_Care_Of_);
    SELF.Mailing_Street_ := KEL.Intake.SingleValue(__recs,Mailing_Street_);
    SELF.Seller1_ := KEL.Intake.SingleValue(__recs,Seller1_);
    SELF.Seller1_I_D_Code_ := KEL.Intake.SingleValue(__recs,Seller1_I_D_Code_);
    SELF.Seller2_ := KEL.Intake.SingleValue(__recs,Seller2_);
    SELF.Seller2_I_D_Code_ := KEL.Intake.SingleValue(__recs,Seller2_I_D_Code_);
    SELF.Seller_Addendum_Flag_ := KEL.Intake.SingleValue(__recs,Seller_Addendum_Flag_);
    SELF.Seller_Mailing_Full_Street_Address_ := KEL.Intake.SingleValue(__recs,Seller_Mailing_Full_Street_Address_);
    SELF.Seller_Mailing_Address_Unit_Number_ := KEL.Intake.SingleValue(__recs,Seller_Mailing_Address_Unit_Number_);
    SELF.Seller_Mailing_Address_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Seller_Mailing_Address_City_State_Zip_);
    SELF.Legal_Complete_Description_Code_ := KEL.Intake.SingleValue(__recs,Legal_Complete_Description_Code_);
    SELF.Contract_Date_ := KEL.Intake.SingleValue(__recs,Contract_Date_);
    SELF.Adjustable_Rate_Mortgage_Reset_Date_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Mortgage_Reset_Date_);
    SELF.Loan_Number_ := KEL.Intake.SingleValue(__recs,Loan_Number_);
    SELF.Concurrent_Mortgage_Book_Page_Document_Number_ := KEL.Intake.SingleValue(__recs,Concurrent_Mortgage_Book_Page_Document_Number_);
    SELF.City_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,City_Transfer_Tax_);
    SELF.County_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,County_Transfer_Tax_);
    SELF.Total_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,Total_Transfer_Tax_);
    SELF.Primary_Loan_Amount_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Amount_);
    SELF.Secondary_Loan_Amount_ := KEL.Intake.SingleValue(__recs,Secondary_Loan_Amount_);
    SELF.Primary_Loan_Lender_Type_Code_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Lender_Type_Code_);
    SELF.Secondary_Loan_Lender_Type_Code_ := KEL.Intake.SingleValue(__recs,Secondary_Loan_Lender_Type_Code_);
    SELF.Primary_Loan_Type_Code_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Type_Code_);
    SELF.Type_Financing_ := KEL.Intake.SingleValue(__recs,Type_Financing_);
    SELF.Primary_Loan_Interest_Rate_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Interest_Rate_);
    SELF.Primary_Loan_Due_Date_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Due_Date_);
    SELF.Title_Company_Name_ := KEL.Intake.SingleValue(__recs,Title_Company_Name_);
    SELF.Partial_Interest_Transferred_ := KEL.Intake.SingleValue(__recs,Partial_Interest_Transferred_);
    SELF.Loan_Term_Months_ := KEL.Intake.SingleValue(__recs,Loan_Term_Months_);
    SELF.Loan_Term_Years_ := KEL.Intake.SingleValue(__recs,Loan_Term_Years_);
    SELF.Lender_Name_ := KEL.Intake.SingleValue(__recs,Lender_Name_);
    SELF.Lender_D_B_A_Name_ := KEL.Intake.SingleValue(__recs,Lender_D_B_A_Name_);
    SELF.Lender_Full_Street_Address_ := KEL.Intake.SingleValue(__recs,Lender_Full_Street_Address_);
    SELF.Lender_Address_Unit_Number_ := KEL.Intake.SingleValue(__recs,Lender_Address_Unit_Number_);
    SELF.Lender_Address_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Lender_Address_City_State_Zip_);
    SELF.Property_Use_Code_ := KEL.Intake.SingleValue(__recs,Property_Use_Code_);
    SELF.Condo_Code_ := KEL.Intake.SingleValue(__recs,Condo_Code_);
    SELF.Timeshare_Flag_ := KEL.Intake.SingleValue(__recs,Timeshare_Flag_);
    SELF.Land_Lot_Size_ := KEL.Intake.SingleValue(__recs,Land_Lot_Size_);
    SELF.Rate_Change_Frequency_ := KEL.Intake.SingleValue(__recs,Rate_Change_Frequency_);
    SELF.Change_Index_ := KEL.Intake.SingleValue(__recs,Change_Index_);
    SELF.Adjustable_Rate_Index_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Index_);
    SELF.Adjustable_Rate_Rider_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Rider_);
    SELF.Graduated_Payment_Rider_ := KEL.Intake.SingleValue(__recs,Graduated_Payment_Rider_);
    SELF.Balloon_Rider_ := KEL.Intake.SingleValue(__recs,Balloon_Rider_);
    SELF.Fixed_Step_Rate_Rider_ := KEL.Intake.SingleValue(__recs,Fixed_Step_Rate_Rider_);
    SELF.Condominium_Rider_ := KEL.Intake.SingleValue(__recs,Condominium_Rider_);
    SELF.Planned_Unit_Development_Rider_ := KEL.Intake.SingleValue(__recs,Planned_Unit_Development_Rider_);
    SELF.Assumability_Rider_ := KEL.Intake.SingleValue(__recs,Assumability_Rider_);
    SELF.Prepayment_Rider_ := KEL.Intake.SingleValue(__recs,Prepayment_Rider_);
    SELF.One_Four_Family_Rider_ := KEL.Intake.SingleValue(__recs,One_Four_Family_Rider_);
    SELF.Biweekly_Payment_Rider_ := KEL.Intake.SingleValue(__recs,Biweekly_Payment_Rider_);
    SELF.Second_Home_Rider_ := KEL.Intake.SingleValue(__recs,Second_Home_Rider_);
    SELF.Data_Source_Code_ := KEL.Intake.SingleValue(__recs,Data_Source_Code_);
    SELF.Type_Of_Deed_Code_ := KEL.Intake.SingleValue(__recs,Type_Of_Deed_Code_);
    SELF.Additional_Name_Flag_ := KEL.Intake.SingleValue(__recs,Additional_Name_Flag_);
    SELF.L_N_Buyer_Mailing_Country_Code_ := KEL.Intake.SingleValue(__recs,L_N_Buyer_Mailing_Country_Code_);
    SELF.L_N_Seller_Mailing_Country_Code_ := KEL.Intake.SingleValue(__recs,L_N_Seller_Mailing_Country_Code_);
    SELF.Fares_Owner_Et_Al_Indicator_ := KEL.Intake.SingleValue(__recs,Fares_Owner_Et_Al_Indicator_);
    SELF.Fares_Owner_Relationship_Code_ := KEL.Intake.SingleValue(__recs,Fares_Owner_Relationship_Code_);
    SELF.Fares_Owner_Relationship_Type_ := KEL.Intake.SingleValue(__recs,Fares_Owner_Relationship_Type_);
    SELF.Fares_Match_Code_ := KEL.Intake.SingleValue(__recs,Fares_Match_Code_);
    SELF.Fares_Document_Year_ := KEL.Intake.SingleValue(__recs,Fares_Document_Year_);
    SELF.Fares_Corporate_Indicator_ := KEL.Intake.SingleValue(__recs,Fares_Corporate_Indicator_);
    SELF.Fares_Transaction_Type_ := KEL.Intake.SingleValue(__recs,Fares_Transaction_Type_);
    SELF.Fares_Lender_Address_ := KEL.Intake.SingleValue(__recs,Fares_Lender_Address_);
    SELF.Fares_Sales_Transaction_Code_ := KEL.Intake.SingleValue(__recs,Fares_Sales_Transaction_Code_);
    SELF.Fares_Residential_Model_Ind_ := KEL.Intake.SingleValue(__recs,Fares_Residential_Model_Ind_);
    SELF.Fares_Mortgage_Deed_Type_ := KEL.Intake.SingleValue(__recs,Fares_Mortgage_Deed_Type_);
    SELF.Fares_Mortgage_Term_Code_ := KEL.Intake.SingleValue(__recs,Fares_Mortgage_Term_Code_);
    SELF.Fares_Mortgage_Term_ := KEL.Intake.SingleValue(__recs,Fares_Mortgage_Term_);
    SELF.Fares_Mortgage_Assumption_Amount_ := KEL.Intake.SingleValue(__recs,Fares_Mortgage_Assumption_Amount_);
    SELF.Fares_Second_Mortgage_Loan_Type_Code_ := KEL.Intake.SingleValue(__recs,Fares_Second_Mortgage_Loan_Type_Code_);
    SELF.Fares_Second_Deed_Type_ := KEL.Intake.SingleValue(__recs,Fares_Second_Deed_Type_);
    SELF.Fares_Absentee_Indicator_ := KEL.Intake.SingleValue(__recs,Fares_Absentee_Indicator_);
    SELF.Fares_Partial_Interest_Indicator_ := KEL.Intake.SingleValue(__recs,Fares_Partial_Interest_Indicator_);
    SELF.Fares_Primary_Category_Code_ := KEL.Intake.SingleValue(__recs,Fares_Primary_Category_Code_);
    SELF.Fares_Private_Party_Lender_ := KEL.Intake.SingleValue(__recs,Fares_Private_Party_Lender_);
    SELF.Fares_Construction_Loan_ := KEL.Intake.SingleValue(__recs,Fares_Construction_Loan_);
    SELF.Fares_Resale_New_Construction_ := KEL.Intake.SingleValue(__recs,Fares_Resale_New_Construction_);
    SELF.Fares_Inter_Family_ := KEL.Intake.SingleValue(__recs,Fares_Inter_Family_);
    SELF.Fares_Cash_Mortgage_Purchase_ := KEL.Intake.SingleValue(__recs,Fares_Cash_Mortgage_Purchase_);
    SELF.Fares_Building_Square_Feet_ := KEL.Intake.SingleValue(__recs,Fares_Building_Square_Feet_);
    SELF.Fares_Foreclosure_ := KEL.Intake.SingleValue(__recs,Fares_Foreclosure_);
    SELF.Fares_Refincance_Flag_ := KEL.Intake.SingleValue(__recs,Fares_Refincance_Flag_);
    SELF.Fares_Equity_Flag_ := KEL.Intake.SingleValue(__recs,Fares_Equity_Flag_);
    SELF.Fares_Iris_A_P_N_ := KEL.Intake.SingleValue(__recs,Fares_Iris_A_P_N_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT L_N_Fares_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Fares_I_D_);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postdirectional_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Z_I_P5_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Range_);
  EXPORT Prop__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Prop_);
  EXPORT Is_Deed__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Deed_);
  EXPORT Is_Assessment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Assessment_);
  EXPORT Is_Additional_Fares_Deed__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Additional_Fares_Deed_);
  EXPORT Process_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Process_Date_);
  EXPORT Vendor_Source_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vendor_Source_Code_);
  EXPORT Current_Record__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Record_);
  EXPORT F_I_P_S_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,F_I_P_S_Code_);
  EXPORT State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_);
  EXPORT County_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Name_);
  EXPORT Old_A_P_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Old_A_P_N_);
  EXPORT A_P_N_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,A_P_N_Number_);
  EXPORT Fares_Unformatted_A_P_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Unformatted_A_P_N_);
  EXPORT Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Duplicate_Apn_With_Different_Address_Counter_);
  EXPORT Assessee_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessee_Name_);
  EXPORT Second_Assessee_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Second_Assessee_Name_);
  EXPORT Ownership_Method_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ownership_Method_Code_);
  EXPORT Owners_Relationship_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Owners_Relationship_Code_);
  EXPORT Owner_Phone_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Owner_Phone_Number_);
  EXPORT Tax_Account_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Account_Number_);
  EXPORT Name1_I_D_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name1_I_D_Code_);
  EXPORT Name2_I_D_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name2_I_D_Code_);
  EXPORT Mailing_Care_Of_Name_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Care_Of_Name_Type_Code_);
  EXPORT Mailing_Care_Of_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Care_Of_Name_);
  EXPORT Mailing_Full_Street_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Full_Street_Address_);
  EXPORT Mailing_Unit_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Unit_Number_);
  EXPORT Mailing_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_City_State_Zip_);
  EXPORT Property_Full_Street_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Full_Street_Address_);
  EXPORT Property_Address_Unit_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Address_Unit_Number_);
  EXPORT Property_Address_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Address_City_State_Zip_);
  EXPORT Property_Address_Country_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Address_Country_Code_);
  EXPORT Property_Address_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Address_Code_);
  EXPORT Legal_Lot_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Lot_Code_);
  EXPORT Legal_Lot_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Lot_Number_);
  EXPORT Legal_Land_Lot__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Land_Lot_);
  EXPORT Legal_Block__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Block_);
  EXPORT Legal_Section__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Section_);
  EXPORT Legal_District__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_District_);
  EXPORT Legal_Unit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Unit_);
  EXPORT Legal_City_Municipality_Township__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_City_Municipality_Township_);
  EXPORT Legal_Subdivision_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Subdivision_Name_);
  EXPORT Legal_Phase_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Phase_Number_);
  EXPORT Legal_Tract_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Tract_Number_);
  EXPORT Legal_Section_Township_Range_Meridian__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Section_Township_Range_Meridian_);
  EXPORT Legal_Brief_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Brief_Description_);
  EXPORT Map_Reference__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Map_Reference_);
  EXPORT Census_Tract__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Census_Tract_);
  EXPORT Record_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Type_Code_);
  EXPORT Ownership_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ownership_Type_Code_);
  EXPORT New_Record_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,New_Record_Type_Code_);
  EXPORT State_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Land_Use_Code_);
  EXPORT County_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Land_Use_Code_);
  EXPORT County_Land_Use_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Land_Use_Description_);
  EXPORT Standardized_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standardized_Land_Use_Code_);
  EXPORT Timeshare_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Timeshare_Code_);
  EXPORT Zoning__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Zoning_);
  EXPORT Occupant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupant_Owned_);
  EXPORT Document_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Document_Number_);
  EXPORT Recorder_Book_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recorder_Book_Number_);
  EXPORT Recorder_Page_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recorder_Page_Number_);
  EXPORT Transfer_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Transfer_Date_);
  EXPORT Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recording_Date_);
  EXPORT Sale_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Date_);
  EXPORT Document_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Document_Type_Code_);
  EXPORT Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price_);
  EXPORT Sale_Price_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price_Code_);
  EXPORT Mortgage_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Amount_);
  EXPORT Mortgage_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Type_);
  EXPORT Mortgage_Lender_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Lender_Name_);
  EXPORT Lender_I_D_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_I_D_Code_);
  EXPORT Prior_Transfer_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Prior_Transfer_Date_);
  EXPORT Previous_Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Recording_Date_);
  EXPORT Previous_Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Sale_Price_);
  EXPORT Previous_Sale_Price_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Sale_Price_Code_);
  EXPORT Assessed_Land_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Land_Value_);
  EXPORT Assessed_Improvement_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Improvement_Value_);
  EXPORT Assessed_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Total_Value_);
  EXPORT Assessed_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Value_Year_);
  EXPORT Market_Land_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Land_Value_);
  EXPORT Market_Improvement_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Improvement_Value_);
  EXPORT Market_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Total_Value_);
  EXPORT Market_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Value_Year_);
  EXPORT Tax_Exemption_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Exemption_Code1_);
  EXPORT Tax_Exemption_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Exemption_Code2_);
  EXPORT Tax_Exemption_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Exemption_Code3_);
  EXPORT Tax_Exemption_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Exemption_Code4_);
  EXPORT Tax_Rate_Code_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Rate_Code_Area_);
  EXPORT Tax_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Amount_);
  EXPORT Tax_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Year_);
  EXPORT Tax_Delinquent_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Delinquent_Year_);
  EXPORT School_Tax_District1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District1_);
  EXPORT School_Tax_District2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District2_);
  EXPORT School_Tax_District3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District3_);
  EXPORT School_Tax_District_Indicator1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District_Indicator1_);
  EXPORT School_Tax_District_Indicator2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District_Indicator2_);
  EXPORT School_Tax_District_Indicator3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Tax_District_Indicator3_);
  EXPORT Lot_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_);
  EXPORT Lot_Size_Acres__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Acres_);
  EXPORT Lot_Size_Frontage_Feet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Frontage_Feet_);
  EXPORT Lot_Size_Depth_Feet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Depth_Feet_);
  EXPORT Land_Acres__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Acres_);
  EXPORT Land_Square_Footage__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Square_Footage_);
  EXPORT Land_Dimensions__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Dimensions_);
  EXPORT Building_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_);
  EXPORT Building_Area1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area1_);
  EXPORT Building_Area2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area2_);
  EXPORT Building_Area3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area3_);
  EXPORT Building_Area4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area4_);
  EXPORT Building_Area5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area5_);
  EXPORT Building_Area6__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area6_);
  EXPORT Building_Area7__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area7_);
  EXPORT Building_Area_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator_);
  EXPORT Building_Area_Indicator1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator1_);
  EXPORT Building_Area_Indicator2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator2_);
  EXPORT Building_Area_Indicator3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator3_);
  EXPORT Building_Area_Indicator4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator4_);
  EXPORT Building_Area_Indicator5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator5_);
  EXPORT Building_Area_Indicator6__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator6_);
  EXPORT Building_Area_Indicator7__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Area_Indicator7_);
  EXPORT Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Year_Built_);
  EXPORT Effective_Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Effective_Year_Built_);
  EXPORT Number_Of_Buildings__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Buildings_);
  EXPORT Number_Of_Stories__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Stories_);
  EXPORT Number_Of_Units__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Units_);
  EXPORT Number_Of_Rooms__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Rooms_);
  EXPORT Number_Of_Bedrooms__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Bedrooms_);
  EXPORT Number_Of_Baths__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Baths_);
  EXPORT Number_Of_Partial_Baths__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Partial_Baths_);
  EXPORT Number_Of_Plumbing_Fixtures__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Number_Of_Plumbing_Fixtures_);
  EXPORT Garage_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Garage_Type_Code_);
  EXPORT Parking_Number_Of_Cars__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Parking_Number_Of_Cars_);
  EXPORT Pool_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Pool_Code_);
  EXPORT Style_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Style_Code_);
  EXPORT Type_Construction_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Construction_Code_);
  EXPORT Foundation_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foundation_Code_);
  EXPORT Building_Quality_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Quality_Code_);
  EXPORT Building_Condition_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Condition_Code_);
  EXPORT Exterior_Walls_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Exterior_Walls_Code_);
  EXPORT Interior_Walls_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Interior_Walls_Code_);
  EXPORT Roof_Cover_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Roof_Cover_Code_);
  EXPORT Roof_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Roof_Type_Code_);
  EXPORT Floor_Cover_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Floor_Cover_Code_);
  EXPORT Water_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Water_Code_);
  EXPORT Sewer_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sewer_Code_);
  EXPORT Heating_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Heating_Code_);
  EXPORT Heating_Fuel_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Heating_Fuel_Type_Code_);
  EXPORT Air_Conditioning_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Air_Conditioning_Code_);
  EXPORT Air_Conditioning_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Air_Conditioning_Type_Code_);
  EXPORT Elevator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Elevator_);
  EXPORT Fireplace_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fireplace_Indicator_);
  EXPORT Fireplace_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fireplace_Number_);
  EXPORT Basement_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Basement_Code_);
  EXPORT Building_Class_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Building_Class_Code_);
  EXPORT Site_Influence_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Site_Influence_Code1_);
  EXPORT Site_Influence_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Site_Influence_Code2_);
  EXPORT Site_Influence_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Site_Influence_Code3_);
  EXPORT Site_Influence_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Site_Influence_Code4_);
  EXPORT Site_Influence_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Site_Influence_Code5_);
  EXPORT Amenity_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code1_);
  EXPORT Amenity_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code2_);
  EXPORT Amenity_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code3_);
  EXPORT Amenity_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code4_);
  EXPORT Amenity_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code5_);
  EXPORT Amenity_Code6__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code6_);
  EXPORT Amenity_Code7__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code7_);
  EXPORT Amenity_Code8__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code8_);
  EXPORT Amenity_Code9__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code9_);
  EXPORT Amenity_Code10__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Amenity_Code10_);
  EXPORT Extra_Feature_Area1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Area1_);
  EXPORT Extra_Feature_Area2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Area2_);
  EXPORT Extra_Feature_Area3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Area3_);
  EXPORT Extra_Feature_Area4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Area4_);
  EXPORT Extra_Feature_Indicator1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Indicator1_);
  EXPORT Extra_Feature_Indicator2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Indicator2_);
  EXPORT Extra_Feature_Indicator3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Indicator3_);
  EXPORT Extra_Feature_Indicator4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extra_Feature_Indicator4_);
  EXPORT Other_Building_Code1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Building_Code1_);
  EXPORT Other_Building_Code2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Building_Code2_);
  EXPORT Other_Building_Code3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Building_Code3_);
  EXPORT Other_Building_Code4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Building_Code4_);
  EXPORT Other_Building_Code5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Building_Code5_);
  EXPORT Other_Important_Building_Indicator1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Indicator1_);
  EXPORT Other_Important_Building_Indicator2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Indicator2_);
  EXPORT Other_Important_Building_Indicator3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Indicator3_);
  EXPORT Other_Important_Building_Indicator4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Indicator4_);
  EXPORT Other_Important_Building_Indicator5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Indicator5_);
  EXPORT Other_Important_Building_Area1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Area1_);
  EXPORT Other_Important_Building_Area2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Area2_);
  EXPORT Other_Important_Building_Area3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Area3_);
  EXPORT Other_Important_Building_Area4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Area4_);
  EXPORT Other_Important_Building_Area5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Important_Building_Area5_);
  EXPORT Topography_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Topography_Code_);
  EXPORT Neighborhood_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Code_);
  EXPORT Condo_Project_Or_Building_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condo_Project_Or_Building_Name_);
  EXPORT Assessee_Name_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessee_Name_Indicator_);
  EXPORT Second_Assessee_Name_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Second_Assessee_Name_Indicator_);
  EXPORT Other_Rooms_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Rooms_Indicator_);
  EXPORT Mail_Care_Of_Name_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mail_Care_Of_Name_Indicator_);
  EXPORT Comments__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Comments_);
  EXPORT Tape_Cut_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tape_Cut_Date_);
  EXPORT Certification_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Certification_Date_);
  EXPORT Edition_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Edition_Number_);
  EXPORT Property_Address_Propegated_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Address_Propegated_Indicator_);
  EXPORT L_N_Ownership_Rights__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Ownership_Rights_);
  EXPORT L_N_Relationship_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Relationship_Type_);
  EXPORT L_N_Mailing_Country_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Mailing_Country_Code_);
  EXPORT L_N_Property_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Property_Name_);
  EXPORT L_N_Property_Name_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Property_Name_Type_);
  EXPORT L_N_Land_Use_Category__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Land_Use_Category_);
  EXPORT L_N_Lot_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Lot_Number_);
  EXPORT L_N_Block_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Block_Number_);
  EXPORT L_N_Unit_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Unit_Number_);
  EXPORT L_N_Subfloor__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Subfloor_);
  EXPORT L_N_Mobile_Home_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Mobile_Home_Indicator_);
  EXPORT L_N_Condo_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Condo_Indicator_);
  EXPORT L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Property_Tax_Exemption_Indicator_);
  EXPORT L_N_Veteran_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Veteran_Status_);
  EXPORT Source_File__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_File_);
  EXPORT Multi_A_P_N_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Multi_A_P_N_Flag_);
  EXPORT Tax_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Number_);
  EXPORT Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Or_Borrower_Or_Assessee_);
  EXPORT Name1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name1_);
  EXPORT Name1_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name1_Code_);
  EXPORT Name2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name2_);
  EXPORT Name2_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name2_Code_);
  EXPORT Buyer_Borrower_Vesting_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Borrower_Vesting_Code_);
  EXPORT Buyer_Borrower_Addendum_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Borrower_Addendum_Flag_);
  EXPORT Mailing_Care_Of__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Care_Of_);
  EXPORT Mailing_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mailing_Street_);
  EXPORT Seller1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller1_);
  EXPORT Seller1_I_D_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller1_I_D_Code_);
  EXPORT Seller2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller2_);
  EXPORT Seller2_I_D_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller2_I_D_Code_);
  EXPORT Seller_Addendum_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller_Addendum_Flag_);
  EXPORT Seller_Mailing_Full_Street_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller_Mailing_Full_Street_Address_);
  EXPORT Seller_Mailing_Address_Unit_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller_Mailing_Address_Unit_Number_);
  EXPORT Seller_Mailing_Address_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller_Mailing_Address_City_State_Zip_);
  EXPORT Legal_Complete_Description_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Complete_Description_Code_);
  EXPORT Contract_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Contract_Date_);
  EXPORT Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Mortgage_Reset_Date_);
  EXPORT Loan_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Number_);
  EXPORT Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Concurrent_Mortgage_Book_Page_Document_Number_);
  EXPORT City_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,City_Transfer_Tax_);
  EXPORT County_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Transfer_Tax_);
  EXPORT Total_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Total_Transfer_Tax_);
  EXPORT Primary_Loan_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Amount_);
  EXPORT Secondary_Loan_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Loan_Amount_);
  EXPORT Primary_Loan_Lender_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Lender_Type_Code_);
  EXPORT Secondary_Loan_Lender_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Loan_Lender_Type_Code_);
  EXPORT Primary_Loan_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Type_Code_);
  EXPORT Type_Financing__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Financing_);
  EXPORT Primary_Loan_Interest_Rate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Interest_Rate_);
  EXPORT Primary_Loan_Due_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Due_Date_);
  EXPORT Title_Company_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Title_Company_Name_);
  EXPORT Partial_Interest_Transferred__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Partial_Interest_Transferred_);
  EXPORT Loan_Term_Months__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Term_Months_);
  EXPORT Loan_Term_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Term_Years_);
  EXPORT Lender_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_Name_);
  EXPORT Lender_D_B_A_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_D_B_A_Name_);
  EXPORT Lender_Full_Street_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_Full_Street_Address_);
  EXPORT Lender_Address_Unit_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_Address_Unit_Number_);
  EXPORT Lender_Address_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_Address_City_State_Zip_);
  EXPORT Property_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Use_Code_);
  EXPORT Condo_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condo_Code_);
  EXPORT Timeshare_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Timeshare_Flag_);
  EXPORT Land_Lot_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Lot_Size_);
  EXPORT Rate_Change_Frequency__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Rate_Change_Frequency_);
  EXPORT Change_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Change_Index_);
  EXPORT Adjustable_Rate_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Index_);
  EXPORT Adjustable_Rate_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Rider_);
  EXPORT Graduated_Payment_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Graduated_Payment_Rider_);
  EXPORT Balloon_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Balloon_Rider_);
  EXPORT Fixed_Step_Rate_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fixed_Step_Rate_Rider_);
  EXPORT Condominium_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condominium_Rider_);
  EXPORT Planned_Unit_Development_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Planned_Unit_Development_Rider_);
  EXPORT Assumability_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assumability_Rider_);
  EXPORT Prepayment_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Prepayment_Rider_);
  EXPORT One_Four_Family_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,One_Four_Family_Rider_);
  EXPORT Biweekly_Payment_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Biweekly_Payment_Rider_);
  EXPORT Second_Home_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Second_Home_Rider_);
  EXPORT Data_Source_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Data_Source_Code_);
  EXPORT Type_Of_Deed_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Of_Deed_Code_);
  EXPORT Additional_Name_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Additional_Name_Flag_);
  EXPORT L_N_Buyer_Mailing_Country_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Buyer_Mailing_Country_Code_);
  EXPORT L_N_Seller_Mailing_Country_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_Seller_Mailing_Country_Code_);
  EXPORT Fares_Owner_Et_Al_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Owner_Et_Al_Indicator_);
  EXPORT Fares_Owner_Relationship_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Owner_Relationship_Code_);
  EXPORT Fares_Owner_Relationship_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Owner_Relationship_Type_);
  EXPORT Fares_Match_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Match_Code_);
  EXPORT Fares_Document_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Document_Year_);
  EXPORT Fares_Corporate_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Corporate_Indicator_);
  EXPORT Fares_Transaction_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Transaction_Type_);
  EXPORT Fares_Lender_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Lender_Address_);
  EXPORT Fares_Sales_Transaction_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Sales_Transaction_Code_);
  EXPORT Fares_Residential_Model_Ind__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Residential_Model_Ind_);
  EXPORT Fares_Mortgage_Deed_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Mortgage_Deed_Type_);
  EXPORT Fares_Mortgage_Term_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Mortgage_Term_Code_);
  EXPORT Fares_Mortgage_Term__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Mortgage_Term_);
  EXPORT Fares_Mortgage_Assumption_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Mortgage_Assumption_Amount_);
  EXPORT Fares_Second_Mortgage_Loan_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Second_Mortgage_Loan_Type_Code_);
  EXPORT Fares_Second_Deed_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Second_Deed_Type_);
  EXPORT Fares_Absentee_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Absentee_Indicator_);
  EXPORT Fares_Partial_Interest_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Partial_Interest_Indicator_);
  EXPORT Fares_Primary_Category_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Primary_Category_Code_);
  EXPORT Fares_Private_Party_Lender__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Private_Party_Lender_);
  EXPORT Fares_Construction_Loan__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Construction_Loan_);
  EXPORT Fares_Resale_New_Construction__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Resale_New_Construction_);
  EXPORT Fares_Inter_Family__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Inter_Family_);
  EXPORT Fares_Cash_Mortgage_Purchase__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Cash_Mortgage_Purchase_);
  EXPORT Fares_Building_Square_Feet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Building_Square_Feet_);
  EXPORT Fares_Foreclosure__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Foreclosure_);
  EXPORT Fares_Refincance_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Refincance_Flag_);
  EXPORT Fares_Equity_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Equity_Flag_);
  EXPORT Fares_Iris_A_P_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fares_Iris_A_P_N_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Prop__Orphan := JOIN(InData(__NN(Prop_)),E_Property(__in,__cfg).__Result,__EEQP(LEFT.Prop_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(Prop__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(L_N_Fares_I_D__SingleValue_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Prop__SingleValue_Invalid),COUNT(Is_Deed__SingleValue_Invalid),COUNT(Is_Assessment__SingleValue_Invalid),COUNT(Is_Additional_Fares_Deed__SingleValue_Invalid),COUNT(Process_Date__SingleValue_Invalid),COUNT(Vendor_Source_Code__SingleValue_Invalid),COUNT(Current_Record__SingleValue_Invalid),COUNT(F_I_P_S_Code__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(County_Name__SingleValue_Invalid),COUNT(Old_A_P_N__SingleValue_Invalid),COUNT(A_P_N_Number__SingleValue_Invalid),COUNT(Fares_Unformatted_A_P_N__SingleValue_Invalid),COUNT(Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid),COUNT(Assessee_Name__SingleValue_Invalid),COUNT(Second_Assessee_Name__SingleValue_Invalid),COUNT(Ownership_Method_Code__SingleValue_Invalid),COUNT(Owners_Relationship_Code__SingleValue_Invalid),COUNT(Owner_Phone_Number__SingleValue_Invalid),COUNT(Tax_Account_Number__SingleValue_Invalid),COUNT(Name1_I_D_Code__SingleValue_Invalid),COUNT(Name2_I_D_Code__SingleValue_Invalid),COUNT(Mailing_Care_Of_Name_Type_Code__SingleValue_Invalid),COUNT(Mailing_Care_Of_Name__SingleValue_Invalid),COUNT(Mailing_Full_Street_Address__SingleValue_Invalid),COUNT(Mailing_Unit_Number__SingleValue_Invalid),COUNT(Mailing_City_State_Zip__SingleValue_Invalid),COUNT(Property_Full_Street_Address__SingleValue_Invalid),COUNT(Property_Address_Unit_Number__SingleValue_Invalid),COUNT(Property_Address_City_State_Zip__SingleValue_Invalid),COUNT(Property_Address_Country_Code__SingleValue_Invalid),COUNT(Property_Address_Code__SingleValue_Invalid),COUNT(Legal_Lot_Code__SingleValue_Invalid),COUNT(Legal_Lot_Number__SingleValue_Invalid),COUNT(Legal_Land_Lot__SingleValue_Invalid),COUNT(Legal_Block__SingleValue_Invalid),COUNT(Legal_Section__SingleValue_Invalid),COUNT(Legal_District__SingleValue_Invalid),COUNT(Legal_Unit__SingleValue_Invalid),COUNT(Legal_City_Municipality_Township__SingleValue_Invalid),COUNT(Legal_Subdivision_Name__SingleValue_Invalid),COUNT(Legal_Phase_Number__SingleValue_Invalid),COUNT(Legal_Tract_Number__SingleValue_Invalid),COUNT(Legal_Section_Township_Range_Meridian__SingleValue_Invalid),COUNT(Legal_Brief_Description__SingleValue_Invalid),COUNT(Map_Reference__SingleValue_Invalid),COUNT(Census_Tract__SingleValue_Invalid),COUNT(Record_Type_Code__SingleValue_Invalid),COUNT(Ownership_Type_Code__SingleValue_Invalid),COUNT(New_Record_Type_Code__SingleValue_Invalid),COUNT(State_Land_Use_Code__SingleValue_Invalid),COUNT(County_Land_Use_Code__SingleValue_Invalid),COUNT(County_Land_Use_Description__SingleValue_Invalid),COUNT(Standardized_Land_Use_Code__SingleValue_Invalid),COUNT(Timeshare_Code__SingleValue_Invalid),COUNT(Zoning__SingleValue_Invalid),COUNT(Occupant_Owned__SingleValue_Invalid),COUNT(Document_Number__SingleValue_Invalid),COUNT(Recorder_Book_Number__SingleValue_Invalid),COUNT(Recorder_Page_Number__SingleValue_Invalid),COUNT(Transfer_Date__SingleValue_Invalid),COUNT(Recording_Date__SingleValue_Invalid),COUNT(Sale_Date__SingleValue_Invalid),COUNT(Document_Type_Code__SingleValue_Invalid),COUNT(Sale_Price__SingleValue_Invalid),COUNT(Sale_Price_Code__SingleValue_Invalid),COUNT(Mortgage_Amount__SingleValue_Invalid),COUNT(Mortgage_Type__SingleValue_Invalid),COUNT(Mortgage_Lender_Name__SingleValue_Invalid),COUNT(Lender_I_D_Code__SingleValue_Invalid),COUNT(Prior_Transfer_Date__SingleValue_Invalid),COUNT(Previous_Recording_Date__SingleValue_Invalid),COUNT(Previous_Sale_Price__SingleValue_Invalid),COUNT(Previous_Sale_Price_Code__SingleValue_Invalid),COUNT(Assessed_Land_Value__SingleValue_Invalid),COUNT(Assessed_Improvement_Value__SingleValue_Invalid),COUNT(Assessed_Total_Value__SingleValue_Invalid),COUNT(Assessed_Value_Year__SingleValue_Invalid),COUNT(Market_Land_Value__SingleValue_Invalid),COUNT(Market_Improvement_Value__SingleValue_Invalid),COUNT(Market_Total_Value__SingleValue_Invalid),COUNT(Market_Value_Year__SingleValue_Invalid),COUNT(Tax_Exemption_Code1__SingleValue_Invalid),COUNT(Tax_Exemption_Code2__SingleValue_Invalid),COUNT(Tax_Exemption_Code3__SingleValue_Invalid),COUNT(Tax_Exemption_Code4__SingleValue_Invalid),COUNT(Tax_Rate_Code_Area__SingleValue_Invalid),COUNT(Tax_Amount__SingleValue_Invalid),COUNT(Tax_Year__SingleValue_Invalid),COUNT(Tax_Delinquent_Year__SingleValue_Invalid),COUNT(School_Tax_District1__SingleValue_Invalid),COUNT(School_Tax_District2__SingleValue_Invalid),COUNT(School_Tax_District3__SingleValue_Invalid),COUNT(School_Tax_District_Indicator1__SingleValue_Invalid),COUNT(School_Tax_District_Indicator2__SingleValue_Invalid),COUNT(School_Tax_District_Indicator3__SingleValue_Invalid),COUNT(Lot_Size__SingleValue_Invalid),COUNT(Lot_Size_Acres__SingleValue_Invalid),COUNT(Lot_Size_Frontage_Feet__SingleValue_Invalid),COUNT(Lot_Size_Depth_Feet__SingleValue_Invalid),COUNT(Land_Acres__SingleValue_Invalid),COUNT(Land_Square_Footage__SingleValue_Invalid),COUNT(Land_Dimensions__SingleValue_Invalid),COUNT(Building_Area__SingleValue_Invalid),COUNT(Building_Area1__SingleValue_Invalid),COUNT(Building_Area2__SingleValue_Invalid),COUNT(Building_Area3__SingleValue_Invalid),COUNT(Building_Area4__SingleValue_Invalid),COUNT(Building_Area5__SingleValue_Invalid),COUNT(Building_Area6__SingleValue_Invalid),COUNT(Building_Area7__SingleValue_Invalid),COUNT(Building_Area_Indicator__SingleValue_Invalid),COUNT(Building_Area_Indicator1__SingleValue_Invalid),COUNT(Building_Area_Indicator2__SingleValue_Invalid),COUNT(Building_Area_Indicator3__SingleValue_Invalid),COUNT(Building_Area_Indicator4__SingleValue_Invalid),COUNT(Building_Area_Indicator5__SingleValue_Invalid),COUNT(Building_Area_Indicator6__SingleValue_Invalid),COUNT(Building_Area_Indicator7__SingleValue_Invalid),COUNT(Year_Built__SingleValue_Invalid),COUNT(Effective_Year_Built__SingleValue_Invalid),COUNT(Number_Of_Buildings__SingleValue_Invalid),COUNT(Number_Of_Stories__SingleValue_Invalid),COUNT(Number_Of_Units__SingleValue_Invalid),COUNT(Number_Of_Rooms__SingleValue_Invalid),COUNT(Number_Of_Bedrooms__SingleValue_Invalid),COUNT(Number_Of_Baths__SingleValue_Invalid),COUNT(Number_Of_Partial_Baths__SingleValue_Invalid),COUNT(Number_Of_Plumbing_Fixtures__SingleValue_Invalid),COUNT(Garage_Type_Code__SingleValue_Invalid),COUNT(Parking_Number_Of_Cars__SingleValue_Invalid),COUNT(Pool_Code__SingleValue_Invalid),COUNT(Style_Code__SingleValue_Invalid),COUNT(Type_Construction_Code__SingleValue_Invalid),COUNT(Foundation_Code__SingleValue_Invalid),COUNT(Building_Quality_Code__SingleValue_Invalid),COUNT(Building_Condition_Code__SingleValue_Invalid),COUNT(Exterior_Walls_Code__SingleValue_Invalid),COUNT(Interior_Walls_Code__SingleValue_Invalid),COUNT(Roof_Cover_Code__SingleValue_Invalid),COUNT(Roof_Type_Code__SingleValue_Invalid),COUNT(Floor_Cover_Code__SingleValue_Invalid),COUNT(Water_Code__SingleValue_Invalid),COUNT(Sewer_Code__SingleValue_Invalid),COUNT(Heating_Code__SingleValue_Invalid),COUNT(Heating_Fuel_Type_Code__SingleValue_Invalid),COUNT(Air_Conditioning_Code__SingleValue_Invalid),COUNT(Air_Conditioning_Type_Code__SingleValue_Invalid),COUNT(Elevator__SingleValue_Invalid),COUNT(Fireplace_Indicator__SingleValue_Invalid),COUNT(Fireplace_Number__SingleValue_Invalid),COUNT(Basement_Code__SingleValue_Invalid),COUNT(Building_Class_Code__SingleValue_Invalid),COUNT(Site_Influence_Code1__SingleValue_Invalid),COUNT(Site_Influence_Code2__SingleValue_Invalid),COUNT(Site_Influence_Code3__SingleValue_Invalid),COUNT(Site_Influence_Code4__SingleValue_Invalid),COUNT(Site_Influence_Code5__SingleValue_Invalid),COUNT(Amenity_Code1__SingleValue_Invalid),COUNT(Amenity_Code2__SingleValue_Invalid),COUNT(Amenity_Code3__SingleValue_Invalid),COUNT(Amenity_Code4__SingleValue_Invalid),COUNT(Amenity_Code5__SingleValue_Invalid),COUNT(Amenity_Code6__SingleValue_Invalid),COUNT(Amenity_Code7__SingleValue_Invalid),COUNT(Amenity_Code8__SingleValue_Invalid),COUNT(Amenity_Code9__SingleValue_Invalid),COUNT(Amenity_Code10__SingleValue_Invalid),COUNT(Extra_Feature_Area1__SingleValue_Invalid),COUNT(Extra_Feature_Area2__SingleValue_Invalid),COUNT(Extra_Feature_Area3__SingleValue_Invalid),COUNT(Extra_Feature_Area4__SingleValue_Invalid),COUNT(Extra_Feature_Indicator1__SingleValue_Invalid),COUNT(Extra_Feature_Indicator2__SingleValue_Invalid),COUNT(Extra_Feature_Indicator3__SingleValue_Invalid),COUNT(Extra_Feature_Indicator4__SingleValue_Invalid),COUNT(Other_Building_Code1__SingleValue_Invalid),COUNT(Other_Building_Code2__SingleValue_Invalid),COUNT(Other_Building_Code3__SingleValue_Invalid),COUNT(Other_Building_Code4__SingleValue_Invalid),COUNT(Other_Building_Code5__SingleValue_Invalid),COUNT(Other_Important_Building_Indicator1__SingleValue_Invalid),COUNT(Other_Important_Building_Indicator2__SingleValue_Invalid),COUNT(Other_Important_Building_Indicator3__SingleValue_Invalid),COUNT(Other_Important_Building_Indicator4__SingleValue_Invalid),COUNT(Other_Important_Building_Indicator5__SingleValue_Invalid),COUNT(Other_Important_Building_Area1__SingleValue_Invalid),COUNT(Other_Important_Building_Area2__SingleValue_Invalid),COUNT(Other_Important_Building_Area3__SingleValue_Invalid),COUNT(Other_Important_Building_Area4__SingleValue_Invalid),COUNT(Other_Important_Building_Area5__SingleValue_Invalid),COUNT(Topography_Code__SingleValue_Invalid),COUNT(Neighborhood_Code__SingleValue_Invalid),COUNT(Condo_Project_Or_Building_Name__SingleValue_Invalid),COUNT(Assessee_Name_Indicator__SingleValue_Invalid),COUNT(Second_Assessee_Name_Indicator__SingleValue_Invalid),COUNT(Other_Rooms_Indicator__SingleValue_Invalid),COUNT(Mail_Care_Of_Name_Indicator__SingleValue_Invalid),COUNT(Comments__SingleValue_Invalid),COUNT(Tape_Cut_Date__SingleValue_Invalid),COUNT(Certification_Date__SingleValue_Invalid),COUNT(Edition_Number__SingleValue_Invalid),COUNT(Property_Address_Propegated_Indicator__SingleValue_Invalid),COUNT(L_N_Ownership_Rights__SingleValue_Invalid),COUNT(L_N_Relationship_Type__SingleValue_Invalid),COUNT(L_N_Mailing_Country_Code__SingleValue_Invalid),COUNT(L_N_Property_Name__SingleValue_Invalid),COUNT(L_N_Property_Name_Type__SingleValue_Invalid),COUNT(L_N_Land_Use_Category__SingleValue_Invalid),COUNT(L_N_Lot_Number__SingleValue_Invalid),COUNT(L_N_Block_Number__SingleValue_Invalid),COUNT(L_N_Unit_Number__SingleValue_Invalid),COUNT(L_N_Subfloor__SingleValue_Invalid),COUNT(L_N_Mobile_Home_Indicator__SingleValue_Invalid),COUNT(L_N_Condo_Indicator__SingleValue_Invalid),COUNT(L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid),COUNT(L_N_Veteran_Status__SingleValue_Invalid),COUNT(Source_File__SingleValue_Invalid),COUNT(Multi_A_P_N_Flag__SingleValue_Invalid),COUNT(Tax_Number__SingleValue_Invalid),COUNT(Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid),COUNT(Name1__SingleValue_Invalid),COUNT(Name1_Code__SingleValue_Invalid),COUNT(Name2__SingleValue_Invalid),COUNT(Name2_Code__SingleValue_Invalid),COUNT(Buyer_Borrower_Vesting_Code__SingleValue_Invalid),COUNT(Buyer_Borrower_Addendum_Flag__SingleValue_Invalid),COUNT(Mailing_Care_Of__SingleValue_Invalid),COUNT(Mailing_Street__SingleValue_Invalid),COUNT(Seller1__SingleValue_Invalid),COUNT(Seller1_I_D_Code__SingleValue_Invalid),COUNT(Seller2__SingleValue_Invalid),COUNT(Seller2_I_D_Code__SingleValue_Invalid),COUNT(Seller_Addendum_Flag__SingleValue_Invalid),COUNT(Seller_Mailing_Full_Street_Address__SingleValue_Invalid),COUNT(Seller_Mailing_Address_Unit_Number__SingleValue_Invalid),COUNT(Seller_Mailing_Address_City_State_Zip__SingleValue_Invalid),COUNT(Legal_Complete_Description_Code__SingleValue_Invalid),COUNT(Contract_Date__SingleValue_Invalid),COUNT(Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid),COUNT(Loan_Number__SingleValue_Invalid),COUNT(Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid),COUNT(City_Transfer_Tax__SingleValue_Invalid),COUNT(County_Transfer_Tax__SingleValue_Invalid),COUNT(Total_Transfer_Tax__SingleValue_Invalid),COUNT(Primary_Loan_Amount__SingleValue_Invalid),COUNT(Secondary_Loan_Amount__SingleValue_Invalid),COUNT(Primary_Loan_Lender_Type_Code__SingleValue_Invalid),COUNT(Secondary_Loan_Lender_Type_Code__SingleValue_Invalid),COUNT(Primary_Loan_Type_Code__SingleValue_Invalid),COUNT(Type_Financing__SingleValue_Invalid),COUNT(Primary_Loan_Interest_Rate__SingleValue_Invalid),COUNT(Primary_Loan_Due_Date__SingleValue_Invalid),COUNT(Title_Company_Name__SingleValue_Invalid),COUNT(Partial_Interest_Transferred__SingleValue_Invalid),COUNT(Loan_Term_Months__SingleValue_Invalid),COUNT(Loan_Term_Years__SingleValue_Invalid),COUNT(Lender_Name__SingleValue_Invalid),COUNT(Lender_D_B_A_Name__SingleValue_Invalid),COUNT(Lender_Full_Street_Address__SingleValue_Invalid),COUNT(Lender_Address_Unit_Number__SingleValue_Invalid),COUNT(Lender_Address_City_State_Zip__SingleValue_Invalid),COUNT(Property_Use_Code__SingleValue_Invalid),COUNT(Condo_Code__SingleValue_Invalid),COUNT(Timeshare_Flag__SingleValue_Invalid),COUNT(Land_Lot_Size__SingleValue_Invalid),COUNT(Rate_Change_Frequency__SingleValue_Invalid),COUNT(Change_Index__SingleValue_Invalid),COUNT(Adjustable_Rate_Index__SingleValue_Invalid),COUNT(Adjustable_Rate_Rider__SingleValue_Invalid),COUNT(Graduated_Payment_Rider__SingleValue_Invalid),COUNT(Balloon_Rider__SingleValue_Invalid),COUNT(Fixed_Step_Rate_Rider__SingleValue_Invalid),COUNT(Condominium_Rider__SingleValue_Invalid),COUNT(Planned_Unit_Development_Rider__SingleValue_Invalid),COUNT(Assumability_Rider__SingleValue_Invalid),COUNT(Prepayment_Rider__SingleValue_Invalid),COUNT(One_Four_Family_Rider__SingleValue_Invalid),COUNT(Biweekly_Payment_Rider__SingleValue_Invalid),COUNT(Second_Home_Rider__SingleValue_Invalid),COUNT(Data_Source_Code__SingleValue_Invalid),COUNT(Type_Of_Deed_Code__SingleValue_Invalid),COUNT(Additional_Name_Flag__SingleValue_Invalid),COUNT(L_N_Buyer_Mailing_Country_Code__SingleValue_Invalid),COUNT(L_N_Seller_Mailing_Country_Code__SingleValue_Invalid),COUNT(Fares_Owner_Et_Al_Indicator__SingleValue_Invalid),COUNT(Fares_Owner_Relationship_Code__SingleValue_Invalid),COUNT(Fares_Owner_Relationship_Type__SingleValue_Invalid),COUNT(Fares_Match_Code__SingleValue_Invalid),COUNT(Fares_Document_Year__SingleValue_Invalid),COUNT(Fares_Corporate_Indicator__SingleValue_Invalid),COUNT(Fares_Transaction_Type__SingleValue_Invalid),COUNT(Fares_Lender_Address__SingleValue_Invalid),COUNT(Fares_Sales_Transaction_Code__SingleValue_Invalid),COUNT(Fares_Residential_Model_Ind__SingleValue_Invalid),COUNT(Fares_Mortgage_Deed_Type__SingleValue_Invalid),COUNT(Fares_Mortgage_Term_Code__SingleValue_Invalid),COUNT(Fares_Mortgage_Term__SingleValue_Invalid),COUNT(Fares_Mortgage_Assumption_Amount__SingleValue_Invalid),COUNT(Fares_Second_Mortgage_Loan_Type_Code__SingleValue_Invalid),COUNT(Fares_Second_Deed_Type__SingleValue_Invalid),COUNT(Fares_Absentee_Indicator__SingleValue_Invalid),COUNT(Fares_Partial_Interest_Indicator__SingleValue_Invalid),COUNT(Fares_Primary_Category_Code__SingleValue_Invalid),COUNT(Fares_Private_Party_Lender__SingleValue_Invalid),COUNT(Fares_Construction_Loan__SingleValue_Invalid),COUNT(Fares_Resale_New_Construction__SingleValue_Invalid),COUNT(Fares_Inter_Family__SingleValue_Invalid),COUNT(Fares_Cash_Mortgage_Purchase__SingleValue_Invalid),COUNT(Fares_Building_Square_Feet__SingleValue_Invalid),COUNT(Fares_Foreclosure__SingleValue_Invalid),COUNT(Fares_Refincance_Flag__SingleValue_Invalid),COUNT(Fares_Equity_Flag__SingleValue_Invalid),COUNT(Fares_Iris_A_P_N__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Prop__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid,KEL.typ.int L_N_Fares_I_D__SingleValue_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Prop__SingleValue_Invalid,KEL.typ.int Is_Deed__SingleValue_Invalid,KEL.typ.int Is_Assessment__SingleValue_Invalid,KEL.typ.int Is_Additional_Fares_Deed__SingleValue_Invalid,KEL.typ.int Process_Date__SingleValue_Invalid,KEL.typ.int Vendor_Source_Code__SingleValue_Invalid,KEL.typ.int Current_Record__SingleValue_Invalid,KEL.typ.int F_I_P_S_Code__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int County_Name__SingleValue_Invalid,KEL.typ.int Old_A_P_N__SingleValue_Invalid,KEL.typ.int A_P_N_Number__SingleValue_Invalid,KEL.typ.int Fares_Unformatted_A_P_N__SingleValue_Invalid,KEL.typ.int Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid,KEL.typ.int Assessee_Name__SingleValue_Invalid,KEL.typ.int Second_Assessee_Name__SingleValue_Invalid,KEL.typ.int Ownership_Method_Code__SingleValue_Invalid,KEL.typ.int Owners_Relationship_Code__SingleValue_Invalid,KEL.typ.int Owner_Phone_Number__SingleValue_Invalid,KEL.typ.int Tax_Account_Number__SingleValue_Invalid,KEL.typ.int Name1_I_D_Code__SingleValue_Invalid,KEL.typ.int Name2_I_D_Code__SingleValue_Invalid,KEL.typ.int Mailing_Care_Of_Name_Type_Code__SingleValue_Invalid,KEL.typ.int Mailing_Care_Of_Name__SingleValue_Invalid,KEL.typ.int Mailing_Full_Street_Address__SingleValue_Invalid,KEL.typ.int Mailing_Unit_Number__SingleValue_Invalid,KEL.typ.int Mailing_City_State_Zip__SingleValue_Invalid,KEL.typ.int Property_Full_Street_Address__SingleValue_Invalid,KEL.typ.int Property_Address_Unit_Number__SingleValue_Invalid,KEL.typ.int Property_Address_City_State_Zip__SingleValue_Invalid,KEL.typ.int Property_Address_Country_Code__SingleValue_Invalid,KEL.typ.int Property_Address_Code__SingleValue_Invalid,KEL.typ.int Legal_Lot_Code__SingleValue_Invalid,KEL.typ.int Legal_Lot_Number__SingleValue_Invalid,KEL.typ.int Legal_Land_Lot__SingleValue_Invalid,KEL.typ.int Legal_Block__SingleValue_Invalid,KEL.typ.int Legal_Section__SingleValue_Invalid,KEL.typ.int Legal_District__SingleValue_Invalid,KEL.typ.int Legal_Unit__SingleValue_Invalid,KEL.typ.int Legal_City_Municipality_Township__SingleValue_Invalid,KEL.typ.int Legal_Subdivision_Name__SingleValue_Invalid,KEL.typ.int Legal_Phase_Number__SingleValue_Invalid,KEL.typ.int Legal_Tract_Number__SingleValue_Invalid,KEL.typ.int Legal_Section_Township_Range_Meridian__SingleValue_Invalid,KEL.typ.int Legal_Brief_Description__SingleValue_Invalid,KEL.typ.int Map_Reference__SingleValue_Invalid,KEL.typ.int Census_Tract__SingleValue_Invalid,KEL.typ.int Record_Type_Code__SingleValue_Invalid,KEL.typ.int Ownership_Type_Code__SingleValue_Invalid,KEL.typ.int New_Record_Type_Code__SingleValue_Invalid,KEL.typ.int State_Land_Use_Code__SingleValue_Invalid,KEL.typ.int County_Land_Use_Code__SingleValue_Invalid,KEL.typ.int County_Land_Use_Description__SingleValue_Invalid,KEL.typ.int Standardized_Land_Use_Code__SingleValue_Invalid,KEL.typ.int Timeshare_Code__SingleValue_Invalid,KEL.typ.int Zoning__SingleValue_Invalid,KEL.typ.int Occupant_Owned__SingleValue_Invalid,KEL.typ.int Document_Number__SingleValue_Invalid,KEL.typ.int Recorder_Book_Number__SingleValue_Invalid,KEL.typ.int Recorder_Page_Number__SingleValue_Invalid,KEL.typ.int Transfer_Date__SingleValue_Invalid,KEL.typ.int Recording_Date__SingleValue_Invalid,KEL.typ.int Sale_Date__SingleValue_Invalid,KEL.typ.int Document_Type_Code__SingleValue_Invalid,KEL.typ.int Sale_Price__SingleValue_Invalid,KEL.typ.int Sale_Price_Code__SingleValue_Invalid,KEL.typ.int Mortgage_Amount__SingleValue_Invalid,KEL.typ.int Mortgage_Type__SingleValue_Invalid,KEL.typ.int Mortgage_Lender_Name__SingleValue_Invalid,KEL.typ.int Lender_I_D_Code__SingleValue_Invalid,KEL.typ.int Prior_Transfer_Date__SingleValue_Invalid,KEL.typ.int Previous_Recording_Date__SingleValue_Invalid,KEL.typ.int Previous_Sale_Price__SingleValue_Invalid,KEL.typ.int Previous_Sale_Price_Code__SingleValue_Invalid,KEL.typ.int Assessed_Land_Value__SingleValue_Invalid,KEL.typ.int Assessed_Improvement_Value__SingleValue_Invalid,KEL.typ.int Assessed_Total_Value__SingleValue_Invalid,KEL.typ.int Assessed_Value_Year__SingleValue_Invalid,KEL.typ.int Market_Land_Value__SingleValue_Invalid,KEL.typ.int Market_Improvement_Value__SingleValue_Invalid,KEL.typ.int Market_Total_Value__SingleValue_Invalid,KEL.typ.int Market_Value_Year__SingleValue_Invalid,KEL.typ.int Tax_Exemption_Code1__SingleValue_Invalid,KEL.typ.int Tax_Exemption_Code2__SingleValue_Invalid,KEL.typ.int Tax_Exemption_Code3__SingleValue_Invalid,KEL.typ.int Tax_Exemption_Code4__SingleValue_Invalid,KEL.typ.int Tax_Rate_Code_Area__SingleValue_Invalid,KEL.typ.int Tax_Amount__SingleValue_Invalid,KEL.typ.int Tax_Year__SingleValue_Invalid,KEL.typ.int Tax_Delinquent_Year__SingleValue_Invalid,KEL.typ.int School_Tax_District1__SingleValue_Invalid,KEL.typ.int School_Tax_District2__SingleValue_Invalid,KEL.typ.int School_Tax_District3__SingleValue_Invalid,KEL.typ.int School_Tax_District_Indicator1__SingleValue_Invalid,KEL.typ.int School_Tax_District_Indicator2__SingleValue_Invalid,KEL.typ.int School_Tax_District_Indicator3__SingleValue_Invalid,KEL.typ.int Lot_Size__SingleValue_Invalid,KEL.typ.int Lot_Size_Acres__SingleValue_Invalid,KEL.typ.int Lot_Size_Frontage_Feet__SingleValue_Invalid,KEL.typ.int Lot_Size_Depth_Feet__SingleValue_Invalid,KEL.typ.int Land_Acres__SingleValue_Invalid,KEL.typ.int Land_Square_Footage__SingleValue_Invalid,KEL.typ.int Land_Dimensions__SingleValue_Invalid,KEL.typ.int Building_Area__SingleValue_Invalid,KEL.typ.int Building_Area1__SingleValue_Invalid,KEL.typ.int Building_Area2__SingleValue_Invalid,KEL.typ.int Building_Area3__SingleValue_Invalid,KEL.typ.int Building_Area4__SingleValue_Invalid,KEL.typ.int Building_Area5__SingleValue_Invalid,KEL.typ.int Building_Area6__SingleValue_Invalid,KEL.typ.int Building_Area7__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator1__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator2__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator3__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator4__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator5__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator6__SingleValue_Invalid,KEL.typ.int Building_Area_Indicator7__SingleValue_Invalid,KEL.typ.int Year_Built__SingleValue_Invalid,KEL.typ.int Effective_Year_Built__SingleValue_Invalid,KEL.typ.int Number_Of_Buildings__SingleValue_Invalid,KEL.typ.int Number_Of_Stories__SingleValue_Invalid,KEL.typ.int Number_Of_Units__SingleValue_Invalid,KEL.typ.int Number_Of_Rooms__SingleValue_Invalid,KEL.typ.int Number_Of_Bedrooms__SingleValue_Invalid,KEL.typ.int Number_Of_Baths__SingleValue_Invalid,KEL.typ.int Number_Of_Partial_Baths__SingleValue_Invalid,KEL.typ.int Number_Of_Plumbing_Fixtures__SingleValue_Invalid,KEL.typ.int Garage_Type_Code__SingleValue_Invalid,KEL.typ.int Parking_Number_Of_Cars__SingleValue_Invalid,KEL.typ.int Pool_Code__SingleValue_Invalid,KEL.typ.int Style_Code__SingleValue_Invalid,KEL.typ.int Type_Construction_Code__SingleValue_Invalid,KEL.typ.int Foundation_Code__SingleValue_Invalid,KEL.typ.int Building_Quality_Code__SingleValue_Invalid,KEL.typ.int Building_Condition_Code__SingleValue_Invalid,KEL.typ.int Exterior_Walls_Code__SingleValue_Invalid,KEL.typ.int Interior_Walls_Code__SingleValue_Invalid,KEL.typ.int Roof_Cover_Code__SingleValue_Invalid,KEL.typ.int Roof_Type_Code__SingleValue_Invalid,KEL.typ.int Floor_Cover_Code__SingleValue_Invalid,KEL.typ.int Water_Code__SingleValue_Invalid,KEL.typ.int Sewer_Code__SingleValue_Invalid,KEL.typ.int Heating_Code__SingleValue_Invalid,KEL.typ.int Heating_Fuel_Type_Code__SingleValue_Invalid,KEL.typ.int Air_Conditioning_Code__SingleValue_Invalid,KEL.typ.int Air_Conditioning_Type_Code__SingleValue_Invalid,KEL.typ.int Elevator__SingleValue_Invalid,KEL.typ.int Fireplace_Indicator__SingleValue_Invalid,KEL.typ.int Fireplace_Number__SingleValue_Invalid,KEL.typ.int Basement_Code__SingleValue_Invalid,KEL.typ.int Building_Class_Code__SingleValue_Invalid,KEL.typ.int Site_Influence_Code1__SingleValue_Invalid,KEL.typ.int Site_Influence_Code2__SingleValue_Invalid,KEL.typ.int Site_Influence_Code3__SingleValue_Invalid,KEL.typ.int Site_Influence_Code4__SingleValue_Invalid,KEL.typ.int Site_Influence_Code5__SingleValue_Invalid,KEL.typ.int Amenity_Code1__SingleValue_Invalid,KEL.typ.int Amenity_Code2__SingleValue_Invalid,KEL.typ.int Amenity_Code3__SingleValue_Invalid,KEL.typ.int Amenity_Code4__SingleValue_Invalid,KEL.typ.int Amenity_Code5__SingleValue_Invalid,KEL.typ.int Amenity_Code6__SingleValue_Invalid,KEL.typ.int Amenity_Code7__SingleValue_Invalid,KEL.typ.int Amenity_Code8__SingleValue_Invalid,KEL.typ.int Amenity_Code9__SingleValue_Invalid,KEL.typ.int Amenity_Code10__SingleValue_Invalid,KEL.typ.int Extra_Feature_Area1__SingleValue_Invalid,KEL.typ.int Extra_Feature_Area2__SingleValue_Invalid,KEL.typ.int Extra_Feature_Area3__SingleValue_Invalid,KEL.typ.int Extra_Feature_Area4__SingleValue_Invalid,KEL.typ.int Extra_Feature_Indicator1__SingleValue_Invalid,KEL.typ.int Extra_Feature_Indicator2__SingleValue_Invalid,KEL.typ.int Extra_Feature_Indicator3__SingleValue_Invalid,KEL.typ.int Extra_Feature_Indicator4__SingleValue_Invalid,KEL.typ.int Other_Building_Code1__SingleValue_Invalid,KEL.typ.int Other_Building_Code2__SingleValue_Invalid,KEL.typ.int Other_Building_Code3__SingleValue_Invalid,KEL.typ.int Other_Building_Code4__SingleValue_Invalid,KEL.typ.int Other_Building_Code5__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Indicator1__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Indicator2__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Indicator3__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Indicator4__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Indicator5__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Area1__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Area2__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Area3__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Area4__SingleValue_Invalid,KEL.typ.int Other_Important_Building_Area5__SingleValue_Invalid,KEL.typ.int Topography_Code__SingleValue_Invalid,KEL.typ.int Neighborhood_Code__SingleValue_Invalid,KEL.typ.int Condo_Project_Or_Building_Name__SingleValue_Invalid,KEL.typ.int Assessee_Name_Indicator__SingleValue_Invalid,KEL.typ.int Second_Assessee_Name_Indicator__SingleValue_Invalid,KEL.typ.int Other_Rooms_Indicator__SingleValue_Invalid,KEL.typ.int Mail_Care_Of_Name_Indicator__SingleValue_Invalid,KEL.typ.int Comments__SingleValue_Invalid,KEL.typ.int Tape_Cut_Date__SingleValue_Invalid,KEL.typ.int Certification_Date__SingleValue_Invalid,KEL.typ.int Edition_Number__SingleValue_Invalid,KEL.typ.int Property_Address_Propegated_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Ownership_Rights__SingleValue_Invalid,KEL.typ.int L_N_Relationship_Type__SingleValue_Invalid,KEL.typ.int L_N_Mailing_Country_Code__SingleValue_Invalid,KEL.typ.int L_N_Property_Name__SingleValue_Invalid,KEL.typ.int L_N_Property_Name_Type__SingleValue_Invalid,KEL.typ.int L_N_Land_Use_Category__SingleValue_Invalid,KEL.typ.int L_N_Lot_Number__SingleValue_Invalid,KEL.typ.int L_N_Block_Number__SingleValue_Invalid,KEL.typ.int L_N_Unit_Number__SingleValue_Invalid,KEL.typ.int L_N_Subfloor__SingleValue_Invalid,KEL.typ.int L_N_Mobile_Home_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Condo_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Veteran_Status__SingleValue_Invalid,KEL.typ.int Source_File__SingleValue_Invalid,KEL.typ.int Multi_A_P_N_Flag__SingleValue_Invalid,KEL.typ.int Tax_Number__SingleValue_Invalid,KEL.typ.int Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid,KEL.typ.int Name1__SingleValue_Invalid,KEL.typ.int Name1_Code__SingleValue_Invalid,KEL.typ.int Name2__SingleValue_Invalid,KEL.typ.int Name2_Code__SingleValue_Invalid,KEL.typ.int Buyer_Borrower_Vesting_Code__SingleValue_Invalid,KEL.typ.int Buyer_Borrower_Addendum_Flag__SingleValue_Invalid,KEL.typ.int Mailing_Care_Of__SingleValue_Invalid,KEL.typ.int Mailing_Street__SingleValue_Invalid,KEL.typ.int Seller1__SingleValue_Invalid,KEL.typ.int Seller1_I_D_Code__SingleValue_Invalid,KEL.typ.int Seller2__SingleValue_Invalid,KEL.typ.int Seller2_I_D_Code__SingleValue_Invalid,KEL.typ.int Seller_Addendum_Flag__SingleValue_Invalid,KEL.typ.int Seller_Mailing_Full_Street_Address__SingleValue_Invalid,KEL.typ.int Seller_Mailing_Address_Unit_Number__SingleValue_Invalid,KEL.typ.int Seller_Mailing_Address_City_State_Zip__SingleValue_Invalid,KEL.typ.int Legal_Complete_Description_Code__SingleValue_Invalid,KEL.typ.int Contract_Date__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid,KEL.typ.int Loan_Number__SingleValue_Invalid,KEL.typ.int Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid,KEL.typ.int City_Transfer_Tax__SingleValue_Invalid,KEL.typ.int County_Transfer_Tax__SingleValue_Invalid,KEL.typ.int Total_Transfer_Tax__SingleValue_Invalid,KEL.typ.int Primary_Loan_Amount__SingleValue_Invalid,KEL.typ.int Secondary_Loan_Amount__SingleValue_Invalid,KEL.typ.int Primary_Loan_Lender_Type_Code__SingleValue_Invalid,KEL.typ.int Secondary_Loan_Lender_Type_Code__SingleValue_Invalid,KEL.typ.int Primary_Loan_Type_Code__SingleValue_Invalid,KEL.typ.int Type_Financing__SingleValue_Invalid,KEL.typ.int Primary_Loan_Interest_Rate__SingleValue_Invalid,KEL.typ.int Primary_Loan_Due_Date__SingleValue_Invalid,KEL.typ.int Title_Company_Name__SingleValue_Invalid,KEL.typ.int Partial_Interest_Transferred__SingleValue_Invalid,KEL.typ.int Loan_Term_Months__SingleValue_Invalid,KEL.typ.int Loan_Term_Years__SingleValue_Invalid,KEL.typ.int Lender_Name__SingleValue_Invalid,KEL.typ.int Lender_D_B_A_Name__SingleValue_Invalid,KEL.typ.int Lender_Full_Street_Address__SingleValue_Invalid,KEL.typ.int Lender_Address_Unit_Number__SingleValue_Invalid,KEL.typ.int Lender_Address_City_State_Zip__SingleValue_Invalid,KEL.typ.int Property_Use_Code__SingleValue_Invalid,KEL.typ.int Condo_Code__SingleValue_Invalid,KEL.typ.int Timeshare_Flag__SingleValue_Invalid,KEL.typ.int Land_Lot_Size__SingleValue_Invalid,KEL.typ.int Rate_Change_Frequency__SingleValue_Invalid,KEL.typ.int Change_Index__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Index__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Rider__SingleValue_Invalid,KEL.typ.int Graduated_Payment_Rider__SingleValue_Invalid,KEL.typ.int Balloon_Rider__SingleValue_Invalid,KEL.typ.int Fixed_Step_Rate_Rider__SingleValue_Invalid,KEL.typ.int Condominium_Rider__SingleValue_Invalid,KEL.typ.int Planned_Unit_Development_Rider__SingleValue_Invalid,KEL.typ.int Assumability_Rider__SingleValue_Invalid,KEL.typ.int Prepayment_Rider__SingleValue_Invalid,KEL.typ.int One_Four_Family_Rider__SingleValue_Invalid,KEL.typ.int Biweekly_Payment_Rider__SingleValue_Invalid,KEL.typ.int Second_Home_Rider__SingleValue_Invalid,KEL.typ.int Data_Source_Code__SingleValue_Invalid,KEL.typ.int Type_Of_Deed_Code__SingleValue_Invalid,KEL.typ.int Additional_Name_Flag__SingleValue_Invalid,KEL.typ.int L_N_Buyer_Mailing_Country_Code__SingleValue_Invalid,KEL.typ.int L_N_Seller_Mailing_Country_Code__SingleValue_Invalid,KEL.typ.int Fares_Owner_Et_Al_Indicator__SingleValue_Invalid,KEL.typ.int Fares_Owner_Relationship_Code__SingleValue_Invalid,KEL.typ.int Fares_Owner_Relationship_Type__SingleValue_Invalid,KEL.typ.int Fares_Match_Code__SingleValue_Invalid,KEL.typ.int Fares_Document_Year__SingleValue_Invalid,KEL.typ.int Fares_Corporate_Indicator__SingleValue_Invalid,KEL.typ.int Fares_Transaction_Type__SingleValue_Invalid,KEL.typ.int Fares_Lender_Address__SingleValue_Invalid,KEL.typ.int Fares_Sales_Transaction_Code__SingleValue_Invalid,KEL.typ.int Fares_Residential_Model_Ind__SingleValue_Invalid,KEL.typ.int Fares_Mortgage_Deed_Type__SingleValue_Invalid,KEL.typ.int Fares_Mortgage_Term_Code__SingleValue_Invalid,KEL.typ.int Fares_Mortgage_Term__SingleValue_Invalid,KEL.typ.int Fares_Mortgage_Assumption_Amount__SingleValue_Invalid,KEL.typ.int Fares_Second_Mortgage_Loan_Type_Code__SingleValue_Invalid,KEL.typ.int Fares_Second_Deed_Type__SingleValue_Invalid,KEL.typ.int Fares_Absentee_Indicator__SingleValue_Invalid,KEL.typ.int Fares_Partial_Interest_Indicator__SingleValue_Invalid,KEL.typ.int Fares_Primary_Category_Code__SingleValue_Invalid,KEL.typ.int Fares_Private_Party_Lender__SingleValue_Invalid,KEL.typ.int Fares_Construction_Loan__SingleValue_Invalid,KEL.typ.int Fares_Resale_New_Construction__SingleValue_Invalid,KEL.typ.int Fares_Inter_Family__SingleValue_Invalid,KEL.typ.int Fares_Cash_Mortgage_Purchase__SingleValue_Invalid,KEL.typ.int Fares_Building_Square_Feet__SingleValue_Invalid,KEL.typ.int Fares_Foreclosure__SingleValue_Invalid,KEL.typ.int Fares_Refincance_Flag__SingleValue_Invalid,KEL.typ.int Fares_Equity_Flag__SingleValue_Invalid,KEL.typ.int Fares_Iris_A_P_N__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Addl_Fares_Deed_Fid_Invalid),COUNT(__d0)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d0(__NL(L_N_Fares_I_D_))),COUNT(__d0(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Predirectional',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Postdirectional',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP5',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryRange',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d0(__NL(Prop_))),COUNT(__d0(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDeed',COUNT(__d0(__NL(Is_Deed_))),COUNT(__d0(__NN(Is_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d0(__NL(Is_Assessment_))),COUNT(__d0(__NN(Is_Assessment_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VendorSourceCode',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRecord',COUNT(__d0(__NL(Current_Record_))),COUNT(__d0(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FIPSCode',COUNT(__d0(__NL(F_I_P_S_Code_))),COUNT(__d0(__NN(F_I_P_S_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyName',COUNT(__d0(__NL(County_Name_))),COUNT(__d0(__NN(County_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OldAPN',COUNT(__d0(__NL(Old_A_P_N_))),COUNT(__d0(__NN(Old_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','APNNumber',COUNT(__d0(__NL(A_P_N_Number_))),COUNT(__d0(__NN(A_P_N_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresUnformattedAPN',COUNT(__d0(__NL(Fares_Unformatted_A_P_N_))),COUNT(__d0(__NN(Fares_Unformatted_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateApnWithDifferentAddressCounter',COUNT(__d0(__NL(Duplicate_Apn_With_Different_Address_Counter_))),COUNT(__d0(__NN(Duplicate_Apn_With_Different_Address_Counter_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeName',COUNT(__d0(__NL(Assessee_Name_))),COUNT(__d0(__NN(Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeName',COUNT(__d0(__NL(Second_Assessee_Name_))),COUNT(__d0(__NN(Second_Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipMethodCode',COUNT(__d0(__NL(Ownership_Method_Code_))),COUNT(__d0(__NN(Ownership_Method_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnersRelationshipCode',COUNT(__d0(__NL(Owners_Relationship_Code_))),COUNT(__d0(__NN(Owners_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerPhoneNumber',COUNT(__d0(__NL(Owner_Phone_Number_))),COUNT(__d0(__NN(Owner_Phone_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAccountNumber',COUNT(__d0(__NL(Tax_Account_Number_))),COUNT(__d0(__NN(Tax_Account_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1IDCode',COUNT(__d0(__NL(Name1_I_D_Code_))),COUNT(__d0(__NN(Name1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2IDCode',COUNT(__d0(__NL(Name2_I_D_Code_))),COUNT(__d0(__NN(Name2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfNameTypeCode',COUNT(__d0(__NL(Mailing_Care_Of_Name_Type_Code_))),COUNT(__d0(__NN(Mailing_Care_Of_Name_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfName',COUNT(__d0(__NL(Mailing_Care_Of_Name_))),COUNT(__d0(__NN(Mailing_Care_Of_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingFullStreetAddress',COUNT(__d0(__NL(Mailing_Full_Street_Address_))),COUNT(__d0(__NN(Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingUnitNumber',COUNT(__d0(__NL(Mailing_Unit_Number_))),COUNT(__d0(__NN(Mailing_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCityStateZip',COUNT(__d0(__NL(Mailing_City_State_Zip_))),COUNT(__d0(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyFullStreetAddress',COUNT(__d0(__NL(Property_Full_Street_Address_))),COUNT(__d0(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressUnitNumber',COUNT(__d0(__NL(Property_Address_Unit_Number_))),COUNT(__d0(__NN(Property_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCityStateZip',COUNT(__d0(__NL(Property_Address_City_State_Zip_))),COUNT(__d0(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCountryCode',COUNT(__d0(__NL(Property_Address_Country_Code_))),COUNT(__d0(__NN(Property_Address_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCode',COUNT(__d0(__NL(Property_Address_Code_))),COUNT(__d0(__NN(Property_Address_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotCode',COUNT(__d0(__NL(Legal_Lot_Code_))),COUNT(__d0(__NN(Legal_Lot_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotNumber',COUNT(__d0(__NL(Legal_Lot_Number_))),COUNT(__d0(__NN(Legal_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLandLot',COUNT(__d0(__NL(Legal_Land_Lot_))),COUNT(__d0(__NN(Legal_Land_Lot_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBlock',COUNT(__d0(__NL(Legal_Block_))),COUNT(__d0(__NN(Legal_Block_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSection',COUNT(__d0(__NL(Legal_Section_))),COUNT(__d0(__NN(Legal_Section_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalDistrict',COUNT(__d0(__NL(Legal_District_))),COUNT(__d0(__NN(Legal_District_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalUnit',COUNT(__d0(__NL(Legal_Unit_))),COUNT(__d0(__NN(Legal_Unit_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCityMunicipalityTownship',COUNT(__d0(__NL(Legal_City_Municipality_Township_))),COUNT(__d0(__NN(Legal_City_Municipality_Township_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSubdivisionName',COUNT(__d0(__NL(Legal_Subdivision_Name_))),COUNT(__d0(__NN(Legal_Subdivision_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalPhaseNumber',COUNT(__d0(__NL(Legal_Phase_Number_))),COUNT(__d0(__NN(Legal_Phase_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalTractNumber',COUNT(__d0(__NL(Legal_Tract_Number_))),COUNT(__d0(__NN(Legal_Tract_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSectionTownshipRangeMeridian',COUNT(__d0(__NL(Legal_Section_Township_Range_Meridian_))),COUNT(__d0(__NN(Legal_Section_Township_Range_Meridian_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBriefDescription',COUNT(__d0(__NL(Legal_Brief_Description_))),COUNT(__d0(__NN(Legal_Brief_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MapReference',COUNT(__d0(__NL(Map_Reference_))),COUNT(__d0(__NN(Map_Reference_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CensusTract',COUNT(__d0(__NL(Census_Tract_))),COUNT(__d0(__NN(Census_Tract_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d0(__NL(Record_Type_Code_))),COUNT(__d0(__NN(Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipTypeCode',COUNT(__d0(__NL(Ownership_Type_Code_))),COUNT(__d0(__NN(Ownership_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NewRecordTypeCode',COUNT(__d0(__NL(New_Record_Type_Code_))),COUNT(__d0(__NN(New_Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateLandUseCode',COUNT(__d0(__NL(State_Land_Use_Code_))),COUNT(__d0(__NN(State_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseCode',COUNT(__d0(__NL(County_Land_Use_Code_))),COUNT(__d0(__NN(County_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseDescription',COUNT(__d0(__NL(County_Land_Use_Description_))),COUNT(__d0(__NN(County_Land_Use_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardizedLandUseCode',COUNT(__d0(__NL(Standardized_Land_Use_Code_))),COUNT(__d0(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareCode',COUNT(__d0(__NL(Timeshare_Code_))),COUNT(__d0(__NN(Timeshare_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zoning',COUNT(__d0(__NL(Zoning_))),COUNT(__d0(__NN(Zoning_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d0(__NL(Occupant_Owned_))),COUNT(__d0(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentNumber',COUNT(__d0(__NL(Document_Number_))),COUNT(__d0(__NN(Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderBookNumber',COUNT(__d0(__NL(Recorder_Book_Number_))),COUNT(__d0(__NN(Recorder_Book_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderPageNumber',COUNT(__d0(__NL(Recorder_Page_Number_))),COUNT(__d0(__NN(Recorder_Page_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransferDate',COUNT(__d0(__NL(Transfer_Date_))),COUNT(__d0(__NN(Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordingDate',COUNT(__d0(__NL(Recording_Date_))),COUNT(__d0(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate',COUNT(__d0(__NL(Sale_Date_))),COUNT(__d0(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentTypeCode',COUNT(__d0(__NL(Document_Type_Code_))),COUNT(__d0(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice',COUNT(__d0(__NL(Sale_Price_))),COUNT(__d0(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePriceCode',COUNT(__d0(__NL(Sale_Price_Code_))),COUNT(__d0(__NN(Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d0(__NL(Mortgage_Amount_))),COUNT(__d0(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d0(__NL(Mortgage_Type_))),COUNT(__d0(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageLenderName',COUNT(__d0(__NL(Mortgage_Lender_Name_))),COUNT(__d0(__NN(Mortgage_Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderIDCode',COUNT(__d0(__NL(Lender_I_D_Code_))),COUNT(__d0(__NN(Lender_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorTransferDate',COUNT(__d0(__NL(Prior_Transfer_Date_))),COUNT(__d0(__NN(Prior_Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d0(__NL(Previous_Recording_Date_))),COUNT(__d0(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d0(__NL(Previous_Sale_Price_))),COUNT(__d0(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePriceCode',COUNT(__d0(__NL(Previous_Sale_Price_Code_))),COUNT(__d0(__NN(Previous_Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedLandValue',COUNT(__d0(__NL(Assessed_Land_Value_))),COUNT(__d0(__NN(Assessed_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedImprovementValue',COUNT(__d0(__NL(Assessed_Improvement_Value_))),COUNT(__d0(__NN(Assessed_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d0(__NL(Assessed_Total_Value_))),COUNT(__d0(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d0(__NL(Assessed_Value_Year_))),COUNT(__d0(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketLandValue',COUNT(__d0(__NL(Market_Land_Value_))),COUNT(__d0(__NN(Market_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketImprovementValue',COUNT(__d0(__NL(Market_Improvement_Value_))),COUNT(__d0(__NN(Market_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d0(__NL(Market_Total_Value_))),COUNT(__d0(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d0(__NL(Market_Value_Year_))),COUNT(__d0(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode1',COUNT(__d0(__NL(Tax_Exemption_Code1_))),COUNT(__d0(__NN(Tax_Exemption_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode2',COUNT(__d0(__NL(Tax_Exemption_Code2_))),COUNT(__d0(__NN(Tax_Exemption_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode3',COUNT(__d0(__NL(Tax_Exemption_Code3_))),COUNT(__d0(__NN(Tax_Exemption_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode4',COUNT(__d0(__NL(Tax_Exemption_Code4_))),COUNT(__d0(__NN(Tax_Exemption_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxRateCodeArea',COUNT(__d0(__NL(Tax_Rate_Code_Area_))),COUNT(__d0(__NN(Tax_Rate_Code_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAmount',COUNT(__d0(__NL(Tax_Amount_))),COUNT(__d0(__NN(Tax_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d0(__NL(Tax_Year_))),COUNT(__d0(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxDelinquentYear',COUNT(__d0(__NL(Tax_Delinquent_Year_))),COUNT(__d0(__NN(Tax_Delinquent_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict1',COUNT(__d0(__NL(School_Tax_District1_))),COUNT(__d0(__NN(School_Tax_District1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict2',COUNT(__d0(__NL(School_Tax_District2_))),COUNT(__d0(__NN(School_Tax_District2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict3',COUNT(__d0(__NL(School_Tax_District3_))),COUNT(__d0(__NN(School_Tax_District3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator1',COUNT(__d0(__NL(School_Tax_District_Indicator1_))),COUNT(__d0(__NN(School_Tax_District_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator2',COUNT(__d0(__NL(School_Tax_District_Indicator2_))),COUNT(__d0(__NN(School_Tax_District_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator3',COUNT(__d0(__NL(School_Tax_District_Indicator3_))),COUNT(__d0(__NN(School_Tax_District_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d0(__NL(Lot_Size_))),COUNT(__d0(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeAcres',COUNT(__d0(__NL(Lot_Size_Acres_))),COUNT(__d0(__NN(Lot_Size_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeFrontageFeet',COUNT(__d0(__NL(Lot_Size_Frontage_Feet_))),COUNT(__d0(__NN(Lot_Size_Frontage_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeDepthFeet',COUNT(__d0(__NL(Lot_Size_Depth_Feet_))),COUNT(__d0(__NN(Lot_Size_Depth_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandAcres',COUNT(__d0(__NL(Land_Acres_))),COUNT(__d0(__NN(Land_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d0(__NL(Land_Square_Footage_))),COUNT(__d0(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandDimensions',COUNT(__d0(__NL(Land_Dimensions_))),COUNT(__d0(__NN(Land_Dimensions_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d0(__NL(Building_Area_))),COUNT(__d0(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea1',COUNT(__d0(__NL(Building_Area1_))),COUNT(__d0(__NN(Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea2',COUNT(__d0(__NL(Building_Area2_))),COUNT(__d0(__NN(Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea3',COUNT(__d0(__NL(Building_Area3_))),COUNT(__d0(__NN(Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea4',COUNT(__d0(__NL(Building_Area4_))),COUNT(__d0(__NN(Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea5',COUNT(__d0(__NL(Building_Area5_))),COUNT(__d0(__NN(Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea6',COUNT(__d0(__NL(Building_Area6_))),COUNT(__d0(__NN(Building_Area6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea7',COUNT(__d0(__NL(Building_Area7_))),COUNT(__d0(__NN(Building_Area7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator',COUNT(__d0(__NL(Building_Area_Indicator_))),COUNT(__d0(__NN(Building_Area_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator1',COUNT(__d0(__NL(Building_Area_Indicator1_))),COUNT(__d0(__NN(Building_Area_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator2',COUNT(__d0(__NL(Building_Area_Indicator2_))),COUNT(__d0(__NN(Building_Area_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator3',COUNT(__d0(__NL(Building_Area_Indicator3_))),COUNT(__d0(__NN(Building_Area_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator4',COUNT(__d0(__NL(Building_Area_Indicator4_))),COUNT(__d0(__NN(Building_Area_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator5',COUNT(__d0(__NL(Building_Area_Indicator5_))),COUNT(__d0(__NN(Building_Area_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator6',COUNT(__d0(__NL(Building_Area_Indicator6_))),COUNT(__d0(__NN(Building_Area_Indicator6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator7',COUNT(__d0(__NL(Building_Area_Indicator7_))),COUNT(__d0(__NN(Building_Area_Indicator7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d0(__NL(Year_Built_))),COUNT(__d0(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d0(__NL(Effective_Year_Built_))),COUNT(__d0(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d0(__NL(Number_Of_Buildings_))),COUNT(__d0(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d0(__NL(Number_Of_Stories_))),COUNT(__d0(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d0(__NL(Number_Of_Units_))),COUNT(__d0(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d0(__NL(Number_Of_Rooms_))),COUNT(__d0(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d0(__NL(Number_Of_Bedrooms_))),COUNT(__d0(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d0(__NL(Number_Of_Baths_))),COUNT(__d0(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d0(__NL(Number_Of_Partial_Baths_))),COUNT(__d0(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPlumbingFixtures',COUNT(__d0(__NL(Number_Of_Plumbing_Fixtures_))),COUNT(__d0(__NN(Number_Of_Plumbing_Fixtures_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d0(__NL(Garage_Type_Code_))),COUNT(__d0(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d0(__NL(Parking_Number_Of_Cars_))),COUNT(__d0(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PoolCode',COUNT(__d0(__NL(Pool_Code_))),COUNT(__d0(__NN(Pool_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d0(__NL(Style_Code_))),COUNT(__d0(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeConstructionCode',COUNT(__d0(__NL(Type_Construction_Code_))),COUNT(__d0(__NN(Type_Construction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FoundationCode',COUNT(__d0(__NL(Foundation_Code_))),COUNT(__d0(__NN(Foundation_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingQualityCode',COUNT(__d0(__NL(Building_Quality_Code_))),COUNT(__d0(__NN(Building_Quality_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingConditionCode',COUNT(__d0(__NL(Building_Condition_Code_))),COUNT(__d0(__NN(Building_Condition_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExteriorWallsCode',COUNT(__d0(__NL(Exterior_Walls_Code_))),COUNT(__d0(__NN(Exterior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InteriorWallsCode',COUNT(__d0(__NL(Interior_Walls_Code_))),COUNT(__d0(__NN(Interior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofCoverCode',COUNT(__d0(__NL(Roof_Cover_Code_))),COUNT(__d0(__NN(Roof_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofTypeCode',COUNT(__d0(__NL(Roof_Type_Code_))),COUNT(__d0(__NN(Roof_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FloorCoverCode',COUNT(__d0(__NL(Floor_Cover_Code_))),COUNT(__d0(__NN(Floor_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WaterCode',COUNT(__d0(__NL(Water_Code_))),COUNT(__d0(__NN(Water_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SewerCode',COUNT(__d0(__NL(Sewer_Code_))),COUNT(__d0(__NN(Sewer_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingCode',COUNT(__d0(__NL(Heating_Code_))),COUNT(__d0(__NN(Heating_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingFuelTypeCode',COUNT(__d0(__NL(Heating_Fuel_Type_Code_))),COUNT(__d0(__NN(Heating_Fuel_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningCode',COUNT(__d0(__NL(Air_Conditioning_Code_))),COUNT(__d0(__NN(Air_Conditioning_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningTypeCode',COUNT(__d0(__NL(Air_Conditioning_Type_Code_))),COUNT(__d0(__NN(Air_Conditioning_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Elevator',COUNT(__d0(__NL(Elevator_))),COUNT(__d0(__NN(Elevator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d0(__NL(Fireplace_Indicator_))),COUNT(__d0(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceNumber',COUNT(__d0(__NL(Fireplace_Number_))),COUNT(__d0(__NN(Fireplace_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BasementCode',COUNT(__d0(__NL(Basement_Code_))),COUNT(__d0(__NN(Basement_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingClassCode',COUNT(__d0(__NL(Building_Class_Code_))),COUNT(__d0(__NN(Building_Class_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode1',COUNT(__d0(__NL(Site_Influence_Code1_))),COUNT(__d0(__NN(Site_Influence_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode2',COUNT(__d0(__NL(Site_Influence_Code2_))),COUNT(__d0(__NN(Site_Influence_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode3',COUNT(__d0(__NL(Site_Influence_Code3_))),COUNT(__d0(__NN(Site_Influence_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode4',COUNT(__d0(__NL(Site_Influence_Code4_))),COUNT(__d0(__NN(Site_Influence_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode5',COUNT(__d0(__NL(Site_Influence_Code5_))),COUNT(__d0(__NN(Site_Influence_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode1',COUNT(__d0(__NL(Amenity_Code1_))),COUNT(__d0(__NN(Amenity_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode2',COUNT(__d0(__NL(Amenity_Code2_))),COUNT(__d0(__NN(Amenity_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode3',COUNT(__d0(__NL(Amenity_Code3_))),COUNT(__d0(__NN(Amenity_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode4',COUNT(__d0(__NL(Amenity_Code4_))),COUNT(__d0(__NN(Amenity_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode5',COUNT(__d0(__NL(Amenity_Code5_))),COUNT(__d0(__NN(Amenity_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode6',COUNT(__d0(__NL(Amenity_Code6_))),COUNT(__d0(__NN(Amenity_Code6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode7',COUNT(__d0(__NL(Amenity_Code7_))),COUNT(__d0(__NN(Amenity_Code7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode8',COUNT(__d0(__NL(Amenity_Code8_))),COUNT(__d0(__NN(Amenity_Code8_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode9',COUNT(__d0(__NL(Amenity_Code9_))),COUNT(__d0(__NN(Amenity_Code9_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode10',COUNT(__d0(__NL(Amenity_Code10_))),COUNT(__d0(__NN(Amenity_Code10_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea1',COUNT(__d0(__NL(Extra_Feature_Area1_))),COUNT(__d0(__NN(Extra_Feature_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea2',COUNT(__d0(__NL(Extra_Feature_Area2_))),COUNT(__d0(__NN(Extra_Feature_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea3',COUNT(__d0(__NL(Extra_Feature_Area3_))),COUNT(__d0(__NN(Extra_Feature_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea4',COUNT(__d0(__NL(Extra_Feature_Area4_))),COUNT(__d0(__NN(Extra_Feature_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator1',COUNT(__d0(__NL(Extra_Feature_Indicator1_))),COUNT(__d0(__NN(Extra_Feature_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator2',COUNT(__d0(__NL(Extra_Feature_Indicator2_))),COUNT(__d0(__NN(Extra_Feature_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator3',COUNT(__d0(__NL(Extra_Feature_Indicator3_))),COUNT(__d0(__NN(Extra_Feature_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator4',COUNT(__d0(__NL(Extra_Feature_Indicator4_))),COUNT(__d0(__NN(Extra_Feature_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode1',COUNT(__d0(__NL(Other_Building_Code1_))),COUNT(__d0(__NN(Other_Building_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode2',COUNT(__d0(__NL(Other_Building_Code2_))),COUNT(__d0(__NN(Other_Building_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode3',COUNT(__d0(__NL(Other_Building_Code3_))),COUNT(__d0(__NN(Other_Building_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode4',COUNT(__d0(__NL(Other_Building_Code4_))),COUNT(__d0(__NN(Other_Building_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode5',COUNT(__d0(__NL(Other_Building_Code5_))),COUNT(__d0(__NN(Other_Building_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator1',COUNT(__d0(__NL(Other_Important_Building_Indicator1_))),COUNT(__d0(__NN(Other_Important_Building_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator2',COUNT(__d0(__NL(Other_Important_Building_Indicator2_))),COUNT(__d0(__NN(Other_Important_Building_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator3',COUNT(__d0(__NL(Other_Important_Building_Indicator3_))),COUNT(__d0(__NN(Other_Important_Building_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator4',COUNT(__d0(__NL(Other_Important_Building_Indicator4_))),COUNT(__d0(__NN(Other_Important_Building_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator5',COUNT(__d0(__NL(Other_Important_Building_Indicator5_))),COUNT(__d0(__NN(Other_Important_Building_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea1',COUNT(__d0(__NL(Other_Important_Building_Area1_))),COUNT(__d0(__NN(Other_Important_Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea2',COUNT(__d0(__NL(Other_Important_Building_Area2_))),COUNT(__d0(__NN(Other_Important_Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea3',COUNT(__d0(__NL(Other_Important_Building_Area3_))),COUNT(__d0(__NN(Other_Important_Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea4',COUNT(__d0(__NL(Other_Important_Building_Area4_))),COUNT(__d0(__NN(Other_Important_Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea5',COUNT(__d0(__NL(Other_Important_Building_Area5_))),COUNT(__d0(__NN(Other_Important_Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TopographyCode',COUNT(__d0(__NL(Topography_Code_))),COUNT(__d0(__NN(Topography_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodCode',COUNT(__d0(__NL(Neighborhood_Code_))),COUNT(__d0(__NN(Neighborhood_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoProjectOrBuildingName',COUNT(__d0(__NL(Condo_Project_Or_Building_Name_))),COUNT(__d0(__NN(Condo_Project_Or_Building_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeNameIndicator',COUNT(__d0(__NL(Assessee_Name_Indicator_))),COUNT(__d0(__NN(Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeNameIndicator',COUNT(__d0(__NL(Second_Assessee_Name_Indicator_))),COUNT(__d0(__NN(Second_Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherRoomsIndicator',COUNT(__d0(__NL(Other_Rooms_Indicator_))),COUNT(__d0(__NN(Other_Rooms_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailCareOfNameIndicator',COUNT(__d0(__NL(Mail_Care_Of_Name_Indicator_))),COUNT(__d0(__NN(Mail_Care_Of_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Comments',COUNT(__d0(__NL(Comments_))),COUNT(__d0(__NN(Comments_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TapeCutDate',COUNT(__d0(__NL(Tape_Cut_Date_))),COUNT(__d0(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d0(__NL(Certification_Date_))),COUNT(__d0(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EditionNumber',COUNT(__d0(__NL(Edition_Number_))),COUNT(__d0(__NN(Edition_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressPropegatedIndicator',COUNT(__d0(__NL(Property_Address_Propegated_Indicator_))),COUNT(__d0(__NN(Property_Address_Propegated_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNOwnershipRights',COUNT(__d0(__NL(L_N_Ownership_Rights_))),COUNT(__d0(__NN(L_N_Ownership_Rights_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNRelationshipType',COUNT(__d0(__NL(L_N_Relationship_Type_))),COUNT(__d0(__NN(L_N_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMailingCountryCode',COUNT(__d0(__NL(L_N_Mailing_Country_Code_))),COUNT(__d0(__NN(L_N_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyName',COUNT(__d0(__NL(L_N_Property_Name_))),COUNT(__d0(__NN(L_N_Property_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyNameType',COUNT(__d0(__NL(L_N_Property_Name_Type_))),COUNT(__d0(__NN(L_N_Property_Name_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLandUseCategory',COUNT(__d0(__NL(L_N_Land_Use_Category_))),COUNT(__d0(__NN(L_N_Land_Use_Category_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLotNumber',COUNT(__d0(__NL(L_N_Lot_Number_))),COUNT(__d0(__NN(L_N_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBlockNumber',COUNT(__d0(__NL(L_N_Block_Number_))),COUNT(__d0(__NN(L_N_Block_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNUnitNumber',COUNT(__d0(__NL(L_N_Unit_Number_))),COUNT(__d0(__NN(L_N_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSubfloor',COUNT(__d0(__NL(L_N_Subfloor_))),COUNT(__d0(__NN(L_N_Subfloor_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMobileHomeIndicator',COUNT(__d0(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d0(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCondoIndicator',COUNT(__d0(__NL(L_N_Condo_Indicator_))),COUNT(__d0(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyTaxExemptionIndicator',COUNT(__d0(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d0(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNVeteranStatus',COUNT(__d0(__NL(L_N_Veteran_Status_))),COUNT(__d0(__NN(L_N_Veteran_Status_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MultiAPNFlag',COUNT(__d0(__NL(Multi_A_P_N_Flag_))),COUNT(__d0(__NN(Multi_A_P_N_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxNumber',COUNT(__d0(__NL(Tax_Number_))),COUNT(__d0(__NN(Tax_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d0(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d0(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1',COUNT(__d0(__NL(Name1_))),COUNT(__d0(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1Code',COUNT(__d0(__NL(Name1_Code_))),COUNT(__d0(__NN(Name1_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2',COUNT(__d0(__NL(Name2_))),COUNT(__d0(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2Code',COUNT(__d0(__NL(Name2_Code_))),COUNT(__d0(__NN(Name2_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerVestingCode',COUNT(__d0(__NL(Buyer_Borrower_Vesting_Code_))),COUNT(__d0(__NN(Buyer_Borrower_Vesting_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerAddendumFlag',COUNT(__d0(__NL(Buyer_Borrower_Addendum_Flag_))),COUNT(__d0(__NN(Buyer_Borrower_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOf',COUNT(__d0(__NL(Mailing_Care_Of_))),COUNT(__d0(__NN(Mailing_Care_Of_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingStreet',COUNT(__d0(__NL(Mailing_Street_))),COUNT(__d0(__NN(Mailing_Street_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1',COUNT(__d0(__NL(Seller1_))),COUNT(__d0(__NN(Seller1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1IDCode',COUNT(__d0(__NL(Seller1_I_D_Code_))),COUNT(__d0(__NN(Seller1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2',COUNT(__d0(__NL(Seller2_))),COUNT(__d0(__NN(Seller2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2IDCode',COUNT(__d0(__NL(Seller2_I_D_Code_))),COUNT(__d0(__NN(Seller2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerAddendumFlag',COUNT(__d0(__NL(Seller_Addendum_Flag_))),COUNT(__d0(__NN(Seller_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingFullStreetAddress',COUNT(__d0(__NL(Seller_Mailing_Full_Street_Address_))),COUNT(__d0(__NN(Seller_Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressUnitNumber',COUNT(__d0(__NL(Seller_Mailing_Address_Unit_Number_))),COUNT(__d0(__NN(Seller_Mailing_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressCityStateZip',COUNT(__d0(__NL(Seller_Mailing_Address_City_State_Zip_))),COUNT(__d0(__NN(Seller_Mailing_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCompleteDescriptionCode',COUNT(__d0(__NL(Legal_Complete_Description_Code_))),COUNT(__d0(__NN(Legal_Complete_Description_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d0(__NL(Contract_Date_))),COUNT(__d0(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateMortgageResetDate',COUNT(__d0(__NL(Adjustable_Rate_Mortgage_Reset_Date_))),COUNT(__d0(__NN(Adjustable_Rate_Mortgage_Reset_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanNumber',COUNT(__d0(__NL(Loan_Number_))),COUNT(__d0(__NN(Loan_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConcurrentMortgageBookPageDocumentNumber',COUNT(__d0(__NL(Concurrent_Mortgage_Book_Page_Document_Number_))),COUNT(__d0(__NN(Concurrent_Mortgage_Book_Page_Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CityTransferTax',COUNT(__d0(__NL(City_Transfer_Tax_))),COUNT(__d0(__NN(City_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyTransferTax',COUNT(__d0(__NL(County_Transfer_Tax_))),COUNT(__d0(__NN(County_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalTransferTax',COUNT(__d0(__NL(Total_Transfer_Tax_))),COUNT(__d0(__NN(Total_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanAmount',COUNT(__d0(__NL(Primary_Loan_Amount_))),COUNT(__d0(__NN(Primary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanAmount',COUNT(__d0(__NL(Secondary_Loan_Amount_))),COUNT(__d0(__NN(Secondary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanLenderTypeCode',COUNT(__d0(__NL(Primary_Loan_Lender_Type_Code_))),COUNT(__d0(__NN(Primary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanLenderTypeCode',COUNT(__d0(__NL(Secondary_Loan_Lender_Type_Code_))),COUNT(__d0(__NN(Secondary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanTypeCode',COUNT(__d0(__NL(Primary_Loan_Type_Code_))),COUNT(__d0(__NN(Primary_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeFinancing',COUNT(__d0(__NL(Type_Financing_))),COUNT(__d0(__NN(Type_Financing_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanInterestRate',COUNT(__d0(__NL(Primary_Loan_Interest_Rate_))),COUNT(__d0(__NN(Primary_Loan_Interest_Rate_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanDueDate',COUNT(__d0(__NL(Primary_Loan_Due_Date_))),COUNT(__d0(__NN(Primary_Loan_Due_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleCompanyName',COUNT(__d0(__NL(Title_Company_Name_))),COUNT(__d0(__NN(Title_Company_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartialInterestTransferred',COUNT(__d0(__NL(Partial_Interest_Transferred_))),COUNT(__d0(__NN(Partial_Interest_Transferred_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermMonths',COUNT(__d0(__NL(Loan_Term_Months_))),COUNT(__d0(__NN(Loan_Term_Months_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermYears',COUNT(__d0(__NL(Loan_Term_Years_))),COUNT(__d0(__NN(Loan_Term_Years_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderName',COUNT(__d0(__NL(Lender_Name_))),COUNT(__d0(__NN(Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderDBAName',COUNT(__d0(__NL(Lender_D_B_A_Name_))),COUNT(__d0(__NN(Lender_D_B_A_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderFullStreetAddress',COUNT(__d0(__NL(Lender_Full_Street_Address_))),COUNT(__d0(__NN(Lender_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressUnitNumber',COUNT(__d0(__NL(Lender_Address_Unit_Number_))),COUNT(__d0(__NN(Lender_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressCityStateZip',COUNT(__d0(__NL(Lender_Address_City_State_Zip_))),COUNT(__d0(__NN(Lender_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyUseCode',COUNT(__d0(__NL(Property_Use_Code_))),COUNT(__d0(__NN(Property_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoCode',COUNT(__d0(__NL(Condo_Code_))),COUNT(__d0(__NN(Condo_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareFlag',COUNT(__d0(__NL(Timeshare_Flag_))),COUNT(__d0(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandLotSize',COUNT(__d0(__NL(Land_Lot_Size_))),COUNT(__d0(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RateChangeFrequency',COUNT(__d0(__NL(Rate_Change_Frequency_))),COUNT(__d0(__NN(Rate_Change_Frequency_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ChangeIndex',COUNT(__d0(__NL(Change_Index_))),COUNT(__d0(__NN(Change_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateIndex',COUNT(__d0(__NL(Adjustable_Rate_Index_))),COUNT(__d0(__NN(Adjustable_Rate_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateRider',COUNT(__d0(__NL(Adjustable_Rate_Rider_))),COUNT(__d0(__NN(Adjustable_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GraduatedPaymentRider',COUNT(__d0(__NL(Graduated_Payment_Rider_))),COUNT(__d0(__NN(Graduated_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BalloonRider',COUNT(__d0(__NL(Balloon_Rider_))),COUNT(__d0(__NN(Balloon_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FixedStepRateRider',COUNT(__d0(__NL(Fixed_Step_Rate_Rider_))),COUNT(__d0(__NN(Fixed_Step_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondominiumRider',COUNT(__d0(__NL(Condominium_Rider_))),COUNT(__d0(__NN(Condominium_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PlannedUnitDevelopmentRider',COUNT(__d0(__NL(Planned_Unit_Development_Rider_))),COUNT(__d0(__NN(Planned_Unit_Development_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssumabilityRider',COUNT(__d0(__NL(Assumability_Rider_))),COUNT(__d0(__NN(Assumability_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrepaymentRider',COUNT(__d0(__NL(Prepayment_Rider_))),COUNT(__d0(__NN(Prepayment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OneFourFamilyRider',COUNT(__d0(__NL(One_Four_Family_Rider_))),COUNT(__d0(__NN(One_Four_Family_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BiweeklyPaymentRider',COUNT(__d0(__NL(Biweekly_Payment_Rider_))),COUNT(__d0(__NN(Biweekly_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondHomeRider',COUNT(__d0(__NL(Second_Home_Rider_))),COUNT(__d0(__NN(Second_Home_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSourceCode',COUNT(__d0(__NL(Data_Source_Code_))),COUNT(__d0(__NN(Data_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeOfDeedCode',COUNT(__d0(__NL(Type_Of_Deed_Code_))),COUNT(__d0(__NN(Type_Of_Deed_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalNameFlag',COUNT(__d0(__NL(Additional_Name_Flag_))),COUNT(__d0(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBuyerMailingCountryCode',COUNT(__d0(__NL(L_N_Buyer_Mailing_Country_Code_))),COUNT(__d0(__NN(L_N_Buyer_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSellerMailingCountryCode',COUNT(__d0(__NL(L_N_Seller_Mailing_Country_Code_))),COUNT(__d0(__NN(L_N_Seller_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_owner_etal_indicator',COUNT(__d0(__NL(Fares_Owner_Et_Al_Indicator_))),COUNT(__d0(__NN(Fares_Owner_Et_Al_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_owner_relationship_code',COUNT(__d0(__NL(Fares_Owner_Relationship_Code_))),COUNT(__d0(__NN(Fares_Owner_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_owner_relationship_type',COUNT(__d0(__NL(Fares_Owner_Relationship_Type_))),COUNT(__d0(__NN(Fares_Owner_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_match_code',COUNT(__d0(__NL(Fares_Match_Code_))),COUNT(__d0(__NN(Fares_Match_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_document_year',COUNT(__d0(__NL(Fares_Document_Year_))),COUNT(__d0(__NN(Fares_Document_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_corporate_indicator',COUNT(__d0(__NL(Fares_Corporate_Indicator_))),COUNT(__d0(__NN(Fares_Corporate_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_transaction_type',COUNT(__d0(__NL(Fares_Transaction_Type_))),COUNT(__d0(__NN(Fares_Transaction_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_lender_address',COUNT(__d0(__NL(Fares_Lender_Address_))),COUNT(__d0(__NN(Fares_Lender_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_sales_transaction_code',COUNT(__d0(__NL(Fares_Sales_Transaction_Code_))),COUNT(__d0(__NN(Fares_Sales_Transaction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_residential_model_ind',COUNT(__d0(__NL(Fares_Residential_Model_Ind_))),COUNT(__d0(__NN(Fares_Residential_Model_Ind_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_mortgage_deed_type',COUNT(__d0(__NL(Fares_Mortgage_Deed_Type_))),COUNT(__d0(__NN(Fares_Mortgage_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_mortgage_term_code',COUNT(__d0(__NL(Fares_Mortgage_Term_Code_))),COUNT(__d0(__NN(Fares_Mortgage_Term_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_mortgage_term',COUNT(__d0(__NL(Fares_Mortgage_Term_))),COUNT(__d0(__NN(Fares_Mortgage_Term_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_mortgage_assumption_amt',COUNT(__d0(__NL(Fares_Mortgage_Assumption_Amount_))),COUNT(__d0(__NN(Fares_Mortgage_Assumption_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_second_mortgage_loan_type_code',COUNT(__d0(__NL(Fares_Second_Mortgage_Loan_Type_Code_))),COUNT(__d0(__NN(Fares_Second_Mortgage_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_second_deed_type',COUNT(__d0(__NL(Fares_Second_Deed_Type_))),COUNT(__d0(__NN(Fares_Second_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_absentee_indicator',COUNT(__d0(__NL(Fares_Absentee_Indicator_))),COUNT(__d0(__NN(Fares_Absentee_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_partial_interest_ind',COUNT(__d0(__NL(Fares_Partial_Interest_Indicator_))),COUNT(__d0(__NN(Fares_Partial_Interest_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_pri_cat_code',COUNT(__d0(__NL(Fares_Primary_Category_Code_))),COUNT(__d0(__NN(Fares_Primary_Category_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_private_party_lender',COUNT(__d0(__NL(Fares_Private_Party_Lender_))),COUNT(__d0(__NN(Fares_Private_Party_Lender_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_construction_loan',COUNT(__d0(__NL(Fares_Construction_Loan_))),COUNT(__d0(__NN(Fares_Construction_Loan_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_resale_new_construction',COUNT(__d0(__NL(Fares_Resale_New_Construction_))),COUNT(__d0(__NN(Fares_Resale_New_Construction_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_inter_family',COUNT(__d0(__NL(Fares_Inter_Family_))),COUNT(__d0(__NN(Fares_Inter_Family_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_cash_mortgage_purchase',COUNT(__d0(__NL(Fares_Cash_Mortgage_Purchase_))),COUNT(__d0(__NN(Fares_Cash_Mortgage_Purchase_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_building_square_feet',COUNT(__d0(__NL(Fares_Building_Square_Feet_))),COUNT(__d0(__NN(Fares_Building_Square_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_foreclosure',COUNT(__d0(__NL(Fares_Foreclosure_))),COUNT(__d0(__NN(Fares_Foreclosure_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_refi_flag',COUNT(__d0(__NL(Fares_Refincance_Flag_))),COUNT(__d0(__NN(Fares_Refincance_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_equity_flag',COUNT(__d0(__NL(Fares_Equity_Flag_))),COUNT(__d0(__NN(Fares_Equity_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_iris_apn',COUNT(__d0(__NL(Fares_Iris_A_P_N_))),COUNT(__d0(__NN(Fares_Iris_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid),COUNT(__d1)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d1(__NL(L_N_Fares_I_D_))),COUNT(__d1(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Predirectional',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Postdirectional',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP5',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryRange',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d1(__NL(Prop_))),COUNT(__d1(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDeed',COUNT(__d1(__NL(Is_Deed_))),COUNT(__d1(__NN(Is_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAdditionalFaresDeed',COUNT(__d1(__NL(Is_Additional_Fares_Deed_))),COUNT(__d1(__NN(Is_Additional_Fares_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d1(__NL(Vendor_Source_Code_))),COUNT(__d1(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record',COUNT(__d1(__NL(Current_Record_))),COUNT(__d1(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fips_code',COUNT(__d1(__NL(F_I_P_S_Code_))),COUNT(__d1(__NN(F_I_P_S_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_code',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_name',COUNT(__d1(__NL(County_Name_))),COUNT(__d1(__NN(County_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','old_apn',COUNT(__d1(__NL(Old_A_P_N_))),COUNT(__d1(__NN(Old_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','apna_or_pin_number',COUNT(__d1(__NL(A_P_N_Number_))),COUNT(__d1(__NN(A_P_N_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_unformatted_apn',COUNT(__d1(__NL(Fares_Unformatted_A_P_N_))),COUNT(__d1(__NN(Fares_Unformatted_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','duplicate_apn_multiple_address_id',COUNT(__d1(__NL(Duplicate_Apn_With_Different_Address_Counter_))),COUNT(__d1(__NN(Duplicate_Apn_With_Different_Address_Counter_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_name',COUNT(__d1(__NL(Assessee_Name_))),COUNT(__d1(__NN(Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_assessee_name',COUNT(__d1(__NL(Second_Assessee_Name_))),COUNT(__d1(__NN(Second_Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_ownership_rights_code',COUNT(__d1(__NL(Ownership_Method_Code_))),COUNT(__d1(__NN(Ownership_Method_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_relationship_code',COUNT(__d1(__NL(Owners_Relationship_Code_))),COUNT(__d1(__NN(Owners_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_phone_number',COUNT(__d1(__NL(Owner_Phone_Number_))),COUNT(__d1(__NN(Owner_Phone_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_account_number',COUNT(__d1(__NL(Tax_Account_Number_))),COUNT(__d1(__NN(Tax_Account_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_name_type_code',COUNT(__d1(__NL(Name1_I_D_Code_))),COUNT(__d1(__NN(Name1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_assessee_name_type_code',COUNT(__d1(__NL(Name2_I_D_Code_))),COUNT(__d1(__NN(Name2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mail_care_of_name_type_code',COUNT(__d1(__NL(Mailing_Care_Of_Name_Type_Code_))),COUNT(__d1(__NN(Mailing_Care_Of_Name_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_care_of_name',COUNT(__d1(__NL(Mailing_Care_Of_Name_))),COUNT(__d1(__NN(Mailing_Care_Of_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_full_street_address',COUNT(__d1(__NL(Mailing_Full_Street_Address_))),COUNT(__d1(__NN(Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_unit_number',COUNT(__d1(__NL(Mailing_Unit_Number_))),COUNT(__d1(__NN(Mailing_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_city_state_zip',COUNT(__d1(__NL(Mailing_City_State_Zip_))),COUNT(__d1(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_full_street_address',COUNT(__d1(__NL(Property_Full_Street_Address_))),COUNT(__d1(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_unit_number',COUNT(__d1(__NL(Property_Address_Unit_Number_))),COUNT(__d1(__NN(Property_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_city_state_zip',COUNT(__d1(__NL(Property_Address_City_State_Zip_))),COUNT(__d1(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_country_code',COUNT(__d1(__NL(Property_Address_Country_Code_))),COUNT(__d1(__NN(Property_Address_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_address_code',COUNT(__d1(__NL(Property_Address_Code_))),COUNT(__d1(__NN(Property_Address_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_lot_code',COUNT(__d1(__NL(Legal_Lot_Code_))),COUNT(__d1(__NN(Legal_Lot_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_lot_number',COUNT(__d1(__NL(Legal_Lot_Number_))),COUNT(__d1(__NN(Legal_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_land_lot',COUNT(__d1(__NL(Legal_Land_Lot_))),COUNT(__d1(__NN(Legal_Land_Lot_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_block',COUNT(__d1(__NL(Legal_Block_))),COUNT(__d1(__NN(Legal_Block_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_section',COUNT(__d1(__NL(Legal_Section_))),COUNT(__d1(__NN(Legal_Section_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_district',COUNT(__d1(__NL(Legal_District_))),COUNT(__d1(__NN(Legal_District_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_unit',COUNT(__d1(__NL(Legal_Unit_))),COUNT(__d1(__NN(Legal_Unit_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_city_municipality_township',COUNT(__d1(__NL(Legal_City_Municipality_Township_))),COUNT(__d1(__NN(Legal_City_Municipality_Township_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_subdivision_name',COUNT(__d1(__NL(Legal_Subdivision_Name_))),COUNT(__d1(__NN(Legal_Subdivision_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_phase_number',COUNT(__d1(__NL(Legal_Phase_Number_))),COUNT(__d1(__NN(Legal_Phase_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_tract_number',COUNT(__d1(__NL(Legal_Tract_Number_))),COUNT(__d1(__NN(Legal_Tract_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_sec_twn_rng_mer',COUNT(__d1(__NL(Legal_Section_Township_Range_Meridian_))),COUNT(__d1(__NN(Legal_Section_Township_Range_Meridian_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_brief_description',COUNT(__d1(__NL(Legal_Brief_Description_))),COUNT(__d1(__NN(Legal_Brief_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_assessor_map_ref',COUNT(__d1(__NL(Map_Reference_))),COUNT(__d1(__NN(Map_Reference_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','census_tract',COUNT(__d1(__NL(Census_Tract_))),COUNT(__d1(__NN(Census_Tract_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type_code',COUNT(__d1(__NL(Record_Type_Code_))),COUNT(__d1(__NN(Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ownership_type_code',COUNT(__d1(__NL(Ownership_Type_Code_))),COUNT(__d1(__NN(Ownership_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','new_record_type_code',COUNT(__d1(__NL(New_Record_Type_Code_))),COUNT(__d1(__NN(New_Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_land_use_code',COUNT(__d1(__NL(State_Land_Use_Code_))),COUNT(__d1(__NN(State_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_land_use_code',COUNT(__d1(__NL(County_Land_Use_Code_))),COUNT(__d1(__NN(County_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_land_use_description',COUNT(__d1(__NL(County_Land_Use_Description_))),COUNT(__d1(__NN(County_Land_Use_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','standardized_land_use_code',COUNT(__d1(__NL(Standardized_Land_Use_Code_))),COUNT(__d1(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','timeshare_code',COUNT(__d1(__NL(Timeshare_Code_))),COUNT(__d1(__NN(Timeshare_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zoning',COUNT(__d1(__NL(Zoning_))),COUNT(__d1(__NN(Zoning_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owner_occupied',COUNT(__d1(__NL(Occupant_Owned_))),COUNT(__d1(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_document_number',COUNT(__d1(__NL(Document_Number_))),COUNT(__d1(__NN(Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_book_number',COUNT(__d1(__NL(Recorder_Book_Number_))),COUNT(__d1(__NN(Recorder_Book_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_page_number',COUNT(__d1(__NL(Recorder_Page_Number_))),COUNT(__d1(__NN(Recorder_Page_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','transfer_date',COUNT(__d1(__NL(Transfer_Date_))),COUNT(__d1(__NN(Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d1(__NL(Recording_Date_))),COUNT(__d1(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sale_date',COUNT(__d1(__NL(Sale_Date_))),COUNT(__d1(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_type',COUNT(__d1(__NL(Document_Type_Code_))),COUNT(__d1(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price',COUNT(__d1(__NL(Sale_Price_))),COUNT(__d1(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price_code',COUNT(__d1(__NL(Sale_Price_Code_))),COUNT(__d1(__NN(Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_loan_amount',COUNT(__d1(__NL(Mortgage_Amount_))),COUNT(__d1(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_loan_type_code',COUNT(__d1(__NL(Mortgage_Type_))),COUNT(__d1(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_lender_name',COUNT(__d1(__NL(Mortgage_Lender_Name_))),COUNT(__d1(__NN(Mortgage_Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_lender_type_code',COUNT(__d1(__NL(Lender_I_D_Code_))),COUNT(__d1(__NN(Lender_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_transfer_date',COUNT(__d1(__NL(Prior_Transfer_Date_))),COUNT(__d1(__NN(Prior_Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_recording_date',COUNT(__d1(__NL(Previous_Recording_Date_))),COUNT(__d1(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_sales_price',COUNT(__d1(__NL(Previous_Sale_Price_))),COUNT(__d1(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_sales_price_code',COUNT(__d1(__NL(Previous_Sale_Price_Code_))),COUNT(__d1(__NN(Previous_Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_land_value',COUNT(__d1(__NL(Assessed_Land_Value_))),COUNT(__d1(__NN(Assessed_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_improvement_value',COUNT(__d1(__NL(Assessed_Improvement_Value_))),COUNT(__d1(__NN(Assessed_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_total_value',COUNT(__d1(__NL(Assessed_Total_Value_))),COUNT(__d1(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_value_year',COUNT(__d1(__NL(Assessed_Value_Year_))),COUNT(__d1(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_land_value',COUNT(__d1(__NL(Market_Land_Value_))),COUNT(__d1(__NN(Market_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_improvement_value',COUNT(__d1(__NL(Market_Improvement_Value_))),COUNT(__d1(__NN(Market_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_total_value',COUNT(__d1(__NL(Market_Total_Value_))),COUNT(__d1(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_value_year',COUNT(__d1(__NL(Market_Value_Year_))),COUNT(__d1(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_exemption1_code',COUNT(__d1(__NL(Tax_Exemption_Code1_))),COUNT(__d1(__NN(Tax_Exemption_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_exemption2_code',COUNT(__d1(__NL(Tax_Exemption_Code2_))),COUNT(__d1(__NN(Tax_Exemption_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_exemption3_code',COUNT(__d1(__NL(Tax_Exemption_Code3_))),COUNT(__d1(__NN(Tax_Exemption_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_exemption4_code',COUNT(__d1(__NL(Tax_Exemption_Code4_))),COUNT(__d1(__NN(Tax_Exemption_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_rate_code_area',COUNT(__d1(__NL(Tax_Rate_Code_Area_))),COUNT(__d1(__NN(Tax_Rate_Code_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_amount',COUNT(__d1(__NL(Tax_Amount_))),COUNT(__d1(__NN(Tax_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_year',COUNT(__d1(__NL(Tax_Year_))),COUNT(__d1(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_delinquent_year',COUNT(__d1(__NL(Tax_Delinquent_Year_))),COUNT(__d1(__NN(Tax_Delinquent_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district1',COUNT(__d1(__NL(School_Tax_District1_))),COUNT(__d1(__NN(School_Tax_District1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district2',COUNT(__d1(__NL(School_Tax_District2_))),COUNT(__d1(__NN(School_Tax_District2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district3',COUNT(__d1(__NL(School_Tax_District3_))),COUNT(__d1(__NN(School_Tax_District3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district1_indicator',COUNT(__d1(__NL(School_Tax_District_Indicator1_))),COUNT(__d1(__NN(School_Tax_District_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district2_indicator',COUNT(__d1(__NL(School_Tax_District_Indicator2_))),COUNT(__d1(__NN(School_Tax_District_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_tax_district3_indicator',COUNT(__d1(__NL(School_Tax_District_Indicator3_))),COUNT(__d1(__NN(School_Tax_District_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_size',COUNT(__d1(__NL(Lot_Size_))),COUNT(__d1(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_size_acres',COUNT(__d1(__NL(Lot_Size_Acres_))),COUNT(__d1(__NN(Lot_Size_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_size_frontage_feet',COUNT(__d1(__NL(Lot_Size_Frontage_Feet_))),COUNT(__d1(__NN(Lot_Size_Frontage_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_size_depth_feet',COUNT(__d1(__NL(Lot_Size_Depth_Feet_))),COUNT(__d1(__NN(Lot_Size_Depth_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_acres',COUNT(__d1(__NL(Land_Acres_))),COUNT(__d1(__NN(Land_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_square_footage',COUNT(__d1(__NL(Land_Square_Footage_))),COUNT(__d1(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_dimensions',COUNT(__d1(__NL(Land_Dimensions_))),COUNT(__d1(__NN(Land_Dimensions_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area',COUNT(__d1(__NL(Building_Area_))),COUNT(__d1(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area1',COUNT(__d1(__NL(Building_Area1_))),COUNT(__d1(__NN(Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area2',COUNT(__d1(__NL(Building_Area2_))),COUNT(__d1(__NN(Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area3',COUNT(__d1(__NL(Building_Area3_))),COUNT(__d1(__NN(Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area4',COUNT(__d1(__NL(Building_Area4_))),COUNT(__d1(__NN(Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area5',COUNT(__d1(__NL(Building_Area5_))),COUNT(__d1(__NN(Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area6',COUNT(__d1(__NL(Building_Area6_))),COUNT(__d1(__NN(Building_Area6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area7',COUNT(__d1(__NL(Building_Area7_))),COUNT(__d1(__NN(Building_Area7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area_indicator',COUNT(__d1(__NL(Building_Area_Indicator_))),COUNT(__d1(__NN(Building_Area_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area1_indicator',COUNT(__d1(__NL(Building_Area_Indicator1_))),COUNT(__d1(__NN(Building_Area_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area2_indicator',COUNT(__d1(__NL(Building_Area_Indicator2_))),COUNT(__d1(__NN(Building_Area_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area3_indicator',COUNT(__d1(__NL(Building_Area_Indicator3_))),COUNT(__d1(__NN(Building_Area_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area4_indicator',COUNT(__d1(__NL(Building_Area_Indicator4_))),COUNT(__d1(__NN(Building_Area_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area5_indicator',COUNT(__d1(__NL(Building_Area_Indicator5_))),COUNT(__d1(__NN(Building_Area_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area6_indicator',COUNT(__d1(__NL(Building_Area_Indicator6_))),COUNT(__d1(__NN(Building_Area_Indicator6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area7_indicator',COUNT(__d1(__NL(Building_Area_Indicator7_))),COUNT(__d1(__NN(Building_Area_Indicator7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','year_built',COUNT(__d1(__NL(Year_Built_))),COUNT(__d1(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','effective_year_built',COUNT(__d1(__NL(Effective_Year_Built_))),COUNT(__d1(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_buildings',COUNT(__d1(__NL(Number_Of_Buildings_))),COUNT(__d1(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_stories',COUNT(__d1(__NL(Number_Of_Stories_))),COUNT(__d1(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_units',COUNT(__d1(__NL(Number_Of_Units_))),COUNT(__d1(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_rooms',COUNT(__d1(__NL(Number_Of_Rooms_))),COUNT(__d1(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_bedrooms',COUNT(__d1(__NL(Number_Of_Bedrooms_))),COUNT(__d1(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_baths',COUNT(__d1(__NL(Number_Of_Baths_))),COUNT(__d1(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_partial_baths',COUNT(__d1(__NL(Number_Of_Partial_Baths_))),COUNT(__d1(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_plumbing_fixtures',COUNT(__d1(__NL(Number_Of_Plumbing_Fixtures_))),COUNT(__d1(__NN(Number_Of_Plumbing_Fixtures_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','garage_type_code',COUNT(__d1(__NL(Garage_Type_Code_))),COUNT(__d1(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','parking_no_of_cars',COUNT(__d1(__NL(Parking_Number_Of_Cars_))),COUNT(__d1(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pool_code',COUNT(__d1(__NL(Pool_Code_))),COUNT(__d1(__NN(Pool_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','style_code',COUNT(__d1(__NL(Style_Code_))),COUNT(__d1(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','type_construction_code',COUNT(__d1(__NL(Type_Construction_Code_))),COUNT(__d1(__NN(Type_Construction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','foundation_code',COUNT(__d1(__NL(Foundation_Code_))),COUNT(__d1(__NN(Foundation_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_quality_code',COUNT(__d1(__NL(Building_Quality_Code_))),COUNT(__d1(__NN(Building_Quality_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_condition_code',COUNT(__d1(__NL(Building_Condition_Code_))),COUNT(__d1(__NN(Building_Condition_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','exterior_walls_code',COUNT(__d1(__NL(Exterior_Walls_Code_))),COUNT(__d1(__NN(Exterior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','interior_walls_code',COUNT(__d1(__NL(Interior_Walls_Code_))),COUNT(__d1(__NN(Interior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','roof_cover_code',COUNT(__d1(__NL(Roof_Cover_Code_))),COUNT(__d1(__NN(Roof_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','roof_type_code',COUNT(__d1(__NL(Roof_Type_Code_))),COUNT(__d1(__NN(Roof_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','floor_cover_code',COUNT(__d1(__NL(Floor_Cover_Code_))),COUNT(__d1(__NN(Floor_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','water_code',COUNT(__d1(__NL(Water_Code_))),COUNT(__d1(__NN(Water_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sewer_code',COUNT(__d1(__NL(Sewer_Code_))),COUNT(__d1(__NN(Sewer_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','heating_code',COUNT(__d1(__NL(Heating_Code_))),COUNT(__d1(__NN(Heating_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','heating_fuel_type_code',COUNT(__d1(__NL(Heating_Fuel_Type_Code_))),COUNT(__d1(__NN(Heating_Fuel_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','air_conditioning_code',COUNT(__d1(__NL(Air_Conditioning_Code_))),COUNT(__d1(__NN(Air_Conditioning_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','air_conditioning_type_code',COUNT(__d1(__NL(Air_Conditioning_Type_Code_))),COUNT(__d1(__NN(Air_Conditioning_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','elevator',COUNT(__d1(__NL(Elevator_))),COUNT(__d1(__NN(Elevator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fireplace_indicator',COUNT(__d1(__NL(Fireplace_Indicator_))),COUNT(__d1(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fireplace_number',COUNT(__d1(__NL(Fireplace_Number_))),COUNT(__d1(__NN(Fireplace_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','basement_code',COUNT(__d1(__NL(Basement_Code_))),COUNT(__d1(__NN(Basement_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_class_code',COUNT(__d1(__NL(Building_Class_Code_))),COUNT(__d1(__NN(Building_Class_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','site_influence1_code',COUNT(__d1(__NL(Site_Influence_Code1_))),COUNT(__d1(__NN(Site_Influence_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','site_influence2_code',COUNT(__d1(__NL(Site_Influence_Code2_))),COUNT(__d1(__NN(Site_Influence_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','site_influence3_code',COUNT(__d1(__NL(Site_Influence_Code3_))),COUNT(__d1(__NN(Site_Influence_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','site_influence4_code',COUNT(__d1(__NL(Site_Influence_Code4_))),COUNT(__d1(__NN(Site_Influence_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','site_influence5_code',COUNT(__d1(__NL(Site_Influence_Code5_))),COUNT(__d1(__NN(Site_Influence_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities1_code',COUNT(__d1(__NL(Amenity_Code1_))),COUNT(__d1(__NN(Amenity_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code',COUNT(__d1(__NL(Amenity_Code2_))),COUNT(__d1(__NN(Amenity_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities3_code',COUNT(__d1(__NL(Amenity_Code3_))),COUNT(__d1(__NN(Amenity_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities4_code',COUNT(__d1(__NL(Amenity_Code4_))),COUNT(__d1(__NN(Amenity_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities5_code',COUNT(__d1(__NL(Amenity_Code5_))),COUNT(__d1(__NN(Amenity_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code1',COUNT(__d1(__NL(Amenity_Code6_))),COUNT(__d1(__NN(Amenity_Code6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code2',COUNT(__d1(__NL(Amenity_Code7_))),COUNT(__d1(__NN(Amenity_Code7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code3',COUNT(__d1(__NL(Amenity_Code8_))),COUNT(__d1(__NN(Amenity_Code8_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code4',COUNT(__d1(__NL(Amenity_Code9_))),COUNT(__d1(__NN(Amenity_Code9_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amenities2_code5',COUNT(__d1(__NL(Amenity_Code10_))),COUNT(__d1(__NN(Amenity_Code10_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features1_area',COUNT(__d1(__NL(Extra_Feature_Area1_))),COUNT(__d1(__NN(Extra_Feature_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features2_area',COUNT(__d1(__NL(Extra_Feature_Area2_))),COUNT(__d1(__NN(Extra_Feature_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features3_area',COUNT(__d1(__NL(Extra_Feature_Area3_))),COUNT(__d1(__NN(Extra_Feature_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features4_area',COUNT(__d1(__NL(Extra_Feature_Area4_))),COUNT(__d1(__NN(Extra_Feature_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features1_indicator',COUNT(__d1(__NL(Extra_Feature_Indicator1_))),COUNT(__d1(__NN(Extra_Feature_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features2_indicator',COUNT(__d1(__NL(Extra_Feature_Indicator2_))),COUNT(__d1(__NN(Extra_Feature_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features3_indicator',COUNT(__d1(__NL(Extra_Feature_Indicator3_))),COUNT(__d1(__NN(Extra_Feature_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','extra_features4_indicator',COUNT(__d1(__NL(Extra_Feature_Indicator4_))),COUNT(__d1(__NN(Extra_Feature_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_buildings1_code',COUNT(__d1(__NL(Other_Building_Code1_))),COUNT(__d1(__NN(Other_Building_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_buildings2_code',COUNT(__d1(__NL(Other_Building_Code2_))),COUNT(__d1(__NN(Other_Building_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_buildings3_code',COUNT(__d1(__NL(Other_Building_Code3_))),COUNT(__d1(__NN(Other_Building_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_buildings4_code',COUNT(__d1(__NL(Other_Building_Code4_))),COUNT(__d1(__NN(Other_Building_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_buildings5_code',COUNT(__d1(__NL(Other_Building_Code5_))),COUNT(__d1(__NN(Other_Building_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building1_indicator',COUNT(__d1(__NL(Other_Important_Building_Indicator1_))),COUNT(__d1(__NN(Other_Important_Building_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building2_indicator',COUNT(__d1(__NL(Other_Important_Building_Indicator2_))),COUNT(__d1(__NN(Other_Important_Building_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building3_indicator',COUNT(__d1(__NL(Other_Important_Building_Indicator3_))),COUNT(__d1(__NN(Other_Important_Building_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building4_indicator',COUNT(__d1(__NL(Other_Important_Building_Indicator4_))),COUNT(__d1(__NN(Other_Important_Building_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building5_indicator',COUNT(__d1(__NL(Other_Important_Building_Indicator5_))),COUNT(__d1(__NN(Other_Important_Building_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building_area1',COUNT(__d1(__NL(Other_Important_Building_Area1_))),COUNT(__d1(__NN(Other_Important_Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building_area2',COUNT(__d1(__NL(Other_Important_Building_Area2_))),COUNT(__d1(__NN(Other_Important_Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building_area3',COUNT(__d1(__NL(Other_Important_Building_Area3_))),COUNT(__d1(__NN(Other_Important_Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building_area4',COUNT(__d1(__NL(Other_Important_Building_Area4_))),COUNT(__d1(__NN(Other_Important_Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_impr_building_area5',COUNT(__d1(__NL(Other_Important_Building_Area5_))),COUNT(__d1(__NN(Other_Important_Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','topograpy_code',COUNT(__d1(__NL(Topography_Code_))),COUNT(__d1(__NN(Topography_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','neighborhood_code',COUNT(__d1(__NL(Neighborhood_Code_))),COUNT(__d1(__NN(Neighborhood_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','condo_project_or_building_name',COUNT(__d1(__NL(Condo_Project_Or_Building_Name_))),COUNT(__d1(__NN(Condo_Project_Or_Building_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessee_name_indicator',COUNT(__d1(__NL(Assessee_Name_Indicator_))),COUNT(__d1(__NN(Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_assessee_name_indicator',COUNT(__d1(__NL(Second_Assessee_Name_Indicator_))),COUNT(__d1(__NN(Second_Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','other_rooms_indicator',COUNT(__d1(__NL(Other_Rooms_Indicator_))),COUNT(__d1(__NN(Other_Rooms_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mail_care_of_name_indicator',COUNT(__d1(__NL(Mail_Care_Of_Name_Indicator_))),COUNT(__d1(__NN(Mail_Care_Of_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','comments',COUNT(__d1(__NL(Comments_))),COUNT(__d1(__NN(Comments_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tape_cut_date',COUNT(__d1(__NL(Tape_Cut_Date_))),COUNT(__d1(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','certification_date',COUNT(__d1(__NL(Certification_Date_))),COUNT(__d1(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','edition_number',COUNT(__d1(__NL(Edition_Number_))),COUNT(__d1(__NN(Edition_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prop_addr_propagated_ind',COUNT(__d1(__NL(Property_Address_Propegated_Indicator_))),COUNT(__d1(__NN(Property_Address_Propegated_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_ownership_rights',COUNT(__d1(__NL(L_N_Ownership_Rights_))),COUNT(__d1(__NN(L_N_Ownership_Rights_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_relationship_type',COUNT(__d1(__NL(L_N_Relationship_Type_))),COUNT(__d1(__NN(L_N_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_mailing_country_code',COUNT(__d1(__NL(L_N_Mailing_Country_Code_))),COUNT(__d1(__NN(L_N_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_property_name',COUNT(__d1(__NL(L_N_Property_Name_))),COUNT(__d1(__NN(L_N_Property_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_property_name_type',COUNT(__d1(__NL(L_N_Property_Name_Type_))),COUNT(__d1(__NN(L_N_Property_Name_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_land_use_category',COUNT(__d1(__NL(L_N_Land_Use_Category_))),COUNT(__d1(__NN(L_N_Land_Use_Category_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_lot',COUNT(__d1(__NL(L_N_Lot_Number_))),COUNT(__d1(__NN(L_N_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_block',COUNT(__d1(__NL(L_N_Block_Number_))),COUNT(__d1(__NN(L_N_Block_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_unit',COUNT(__d1(__NL(L_N_Unit_Number_))),COUNT(__d1(__NN(L_N_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_subfloor',COUNT(__d1(__NL(L_N_Subfloor_))),COUNT(__d1(__NN(L_N_Subfloor_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_mobile_home_indicator',COUNT(__d1(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d1(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_condo_indicator',COUNT(__d1(__NL(L_N_Condo_Indicator_))),COUNT(__d1(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_property_tax_exemption',COUNT(__d1(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d1(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_veteran_status',COUNT(__d1(__NL(L_N_Veteran_Status_))),COUNT(__d1(__NN(L_N_Veteran_Status_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MultiAPNFlag',COUNT(__d1(__NL(Multi_A_P_N_Flag_))),COUNT(__d1(__NN(Multi_A_P_N_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxNumber',COUNT(__d1(__NL(Tax_Number_))),COUNT(__d1(__NN(Tax_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d1(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d1(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1',COUNT(__d1(__NL(Name1_))),COUNT(__d1(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1Code',COUNT(__d1(__NL(Name1_Code_))),COUNT(__d1(__NN(Name1_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2',COUNT(__d1(__NL(Name2_))),COUNT(__d1(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2Code',COUNT(__d1(__NL(Name2_Code_))),COUNT(__d1(__NN(Name2_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerVestingCode',COUNT(__d1(__NL(Buyer_Borrower_Vesting_Code_))),COUNT(__d1(__NN(Buyer_Borrower_Vesting_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerAddendumFlag',COUNT(__d1(__NL(Buyer_Borrower_Addendum_Flag_))),COUNT(__d1(__NN(Buyer_Borrower_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOf',COUNT(__d1(__NL(Mailing_Care_Of_))),COUNT(__d1(__NN(Mailing_Care_Of_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingStreet',COUNT(__d1(__NL(Mailing_Street_))),COUNT(__d1(__NN(Mailing_Street_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1',COUNT(__d1(__NL(Seller1_))),COUNT(__d1(__NN(Seller1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1IDCode',COUNT(__d1(__NL(Seller1_I_D_Code_))),COUNT(__d1(__NN(Seller1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2',COUNT(__d1(__NL(Seller2_))),COUNT(__d1(__NN(Seller2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2IDCode',COUNT(__d1(__NL(Seller2_I_D_Code_))),COUNT(__d1(__NN(Seller2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerAddendumFlag',COUNT(__d1(__NL(Seller_Addendum_Flag_))),COUNT(__d1(__NN(Seller_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingFullStreetAddress',COUNT(__d1(__NL(Seller_Mailing_Full_Street_Address_))),COUNT(__d1(__NN(Seller_Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressUnitNumber',COUNT(__d1(__NL(Seller_Mailing_Address_Unit_Number_))),COUNT(__d1(__NN(Seller_Mailing_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressCityStateZip',COUNT(__d1(__NL(Seller_Mailing_Address_City_State_Zip_))),COUNT(__d1(__NN(Seller_Mailing_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCompleteDescriptionCode',COUNT(__d1(__NL(Legal_Complete_Description_Code_))),COUNT(__d1(__NN(Legal_Complete_Description_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d1(__NL(Contract_Date_))),COUNT(__d1(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateMortgageResetDate',COUNT(__d1(__NL(Adjustable_Rate_Mortgage_Reset_Date_))),COUNT(__d1(__NN(Adjustable_Rate_Mortgage_Reset_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanNumber',COUNT(__d1(__NL(Loan_Number_))),COUNT(__d1(__NN(Loan_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConcurrentMortgageBookPageDocumentNumber',COUNT(__d1(__NL(Concurrent_Mortgage_Book_Page_Document_Number_))),COUNT(__d1(__NN(Concurrent_Mortgage_Book_Page_Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CityTransferTax',COUNT(__d1(__NL(City_Transfer_Tax_))),COUNT(__d1(__NN(City_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyTransferTax',COUNT(__d1(__NL(County_Transfer_Tax_))),COUNT(__d1(__NN(County_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalTransferTax',COUNT(__d1(__NL(Total_Transfer_Tax_))),COUNT(__d1(__NN(Total_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanAmount',COUNT(__d1(__NL(Primary_Loan_Amount_))),COUNT(__d1(__NN(Primary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanAmount',COUNT(__d1(__NL(Secondary_Loan_Amount_))),COUNT(__d1(__NN(Secondary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanLenderTypeCode',COUNT(__d1(__NL(Primary_Loan_Lender_Type_Code_))),COUNT(__d1(__NN(Primary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanLenderTypeCode',COUNT(__d1(__NL(Secondary_Loan_Lender_Type_Code_))),COUNT(__d1(__NN(Secondary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanTypeCode',COUNT(__d1(__NL(Primary_Loan_Type_Code_))),COUNT(__d1(__NN(Primary_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeFinancing',COUNT(__d1(__NL(Type_Financing_))),COUNT(__d1(__NN(Type_Financing_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanInterestRate',COUNT(__d1(__NL(Primary_Loan_Interest_Rate_))),COUNT(__d1(__NN(Primary_Loan_Interest_Rate_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanDueDate',COUNT(__d1(__NL(Primary_Loan_Due_Date_))),COUNT(__d1(__NN(Primary_Loan_Due_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleCompanyName',COUNT(__d1(__NL(Title_Company_Name_))),COUNT(__d1(__NN(Title_Company_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartialInterestTransferred',COUNT(__d1(__NL(Partial_Interest_Transferred_))),COUNT(__d1(__NN(Partial_Interest_Transferred_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermMonths',COUNT(__d1(__NL(Loan_Term_Months_))),COUNT(__d1(__NN(Loan_Term_Months_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermYears',COUNT(__d1(__NL(Loan_Term_Years_))),COUNT(__d1(__NN(Loan_Term_Years_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderName',COUNT(__d1(__NL(Lender_Name_))),COUNT(__d1(__NN(Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderDBAName',COUNT(__d1(__NL(Lender_D_B_A_Name_))),COUNT(__d1(__NN(Lender_D_B_A_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderFullStreetAddress',COUNT(__d1(__NL(Lender_Full_Street_Address_))),COUNT(__d1(__NN(Lender_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressUnitNumber',COUNT(__d1(__NL(Lender_Address_Unit_Number_))),COUNT(__d1(__NN(Lender_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressCityStateZip',COUNT(__d1(__NL(Lender_Address_City_State_Zip_))),COUNT(__d1(__NN(Lender_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyUseCode',COUNT(__d1(__NL(Property_Use_Code_))),COUNT(__d1(__NN(Property_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoCode',COUNT(__d1(__NL(Condo_Code_))),COUNT(__d1(__NN(Condo_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareFlag',COUNT(__d1(__NL(Timeshare_Flag_))),COUNT(__d1(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandLotSize',COUNT(__d1(__NL(Land_Lot_Size_))),COUNT(__d1(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RateChangeFrequency',COUNT(__d1(__NL(Rate_Change_Frequency_))),COUNT(__d1(__NN(Rate_Change_Frequency_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ChangeIndex',COUNT(__d1(__NL(Change_Index_))),COUNT(__d1(__NN(Change_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateIndex',COUNT(__d1(__NL(Adjustable_Rate_Index_))),COUNT(__d1(__NN(Adjustable_Rate_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateRider',COUNT(__d1(__NL(Adjustable_Rate_Rider_))),COUNT(__d1(__NN(Adjustable_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GraduatedPaymentRider',COUNT(__d1(__NL(Graduated_Payment_Rider_))),COUNT(__d1(__NN(Graduated_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BalloonRider',COUNT(__d1(__NL(Balloon_Rider_))),COUNT(__d1(__NN(Balloon_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FixedStepRateRider',COUNT(__d1(__NL(Fixed_Step_Rate_Rider_))),COUNT(__d1(__NN(Fixed_Step_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondominiumRider',COUNT(__d1(__NL(Condominium_Rider_))),COUNT(__d1(__NN(Condominium_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PlannedUnitDevelopmentRider',COUNT(__d1(__NL(Planned_Unit_Development_Rider_))),COUNT(__d1(__NN(Planned_Unit_Development_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssumabilityRider',COUNT(__d1(__NL(Assumability_Rider_))),COUNT(__d1(__NN(Assumability_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrepaymentRider',COUNT(__d1(__NL(Prepayment_Rider_))),COUNT(__d1(__NN(Prepayment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OneFourFamilyRider',COUNT(__d1(__NL(One_Four_Family_Rider_))),COUNT(__d1(__NN(One_Four_Family_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BiweeklyPaymentRider',COUNT(__d1(__NL(Biweekly_Payment_Rider_))),COUNT(__d1(__NN(Biweekly_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondHomeRider',COUNT(__d1(__NL(Second_Home_Rider_))),COUNT(__d1(__NN(Second_Home_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSourceCode',COUNT(__d1(__NL(Data_Source_Code_))),COUNT(__d1(__NN(Data_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeOfDeedCode',COUNT(__d1(__NL(Type_Of_Deed_Code_))),COUNT(__d1(__NN(Type_Of_Deed_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalNameFlag',COUNT(__d1(__NL(Additional_Name_Flag_))),COUNT(__d1(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBuyerMailingCountryCode',COUNT(__d1(__NL(L_N_Buyer_Mailing_Country_Code_))),COUNT(__d1(__NN(L_N_Buyer_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSellerMailingCountryCode',COUNT(__d1(__NL(L_N_Seller_Mailing_Country_Code_))),COUNT(__d1(__NN(L_N_Seller_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerEtAlIndicator',COUNT(__d1(__NL(Fares_Owner_Et_Al_Indicator_))),COUNT(__d1(__NN(Fares_Owner_Et_Al_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipCode',COUNT(__d1(__NL(Fares_Owner_Relationship_Code_))),COUNT(__d1(__NN(Fares_Owner_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipType',COUNT(__d1(__NL(Fares_Owner_Relationship_Type_))),COUNT(__d1(__NN(Fares_Owner_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMatchCode',COUNT(__d1(__NL(Fares_Match_Code_))),COUNT(__d1(__NN(Fares_Match_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresDocumentYear',COUNT(__d1(__NL(Fares_Document_Year_))),COUNT(__d1(__NN(Fares_Document_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCorporateIndicator',COUNT(__d1(__NL(Fares_Corporate_Indicator_))),COUNT(__d1(__NN(Fares_Corporate_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresTransactionType',COUNT(__d1(__NL(Fares_Transaction_Type_))),COUNT(__d1(__NN(Fares_Transaction_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresLenderAddress',COUNT(__d1(__NL(Fares_Lender_Address_))),COUNT(__d1(__NN(Fares_Lender_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSalesTransactionCode',COUNT(__d1(__NL(Fares_Sales_Transaction_Code_))),COUNT(__d1(__NN(Fares_Sales_Transaction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResidentialModelInd',COUNT(__d1(__NL(Fares_Residential_Model_Ind_))),COUNT(__d1(__NN(Fares_Residential_Model_Ind_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageDeedType',COUNT(__d1(__NL(Fares_Mortgage_Deed_Type_))),COUNT(__d1(__NN(Fares_Mortgage_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTermCode',COUNT(__d1(__NL(Fares_Mortgage_Term_Code_))),COUNT(__d1(__NN(Fares_Mortgage_Term_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTerm',COUNT(__d1(__NL(Fares_Mortgage_Term_))),COUNT(__d1(__NN(Fares_Mortgage_Term_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageAssumptionAmount',COUNT(__d1(__NL(Fares_Mortgage_Assumption_Amount_))),COUNT(__d1(__NN(Fares_Mortgage_Assumption_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondMortgageLoanTypeCode',COUNT(__d1(__NL(Fares_Second_Mortgage_Loan_Type_Code_))),COUNT(__d1(__NN(Fares_Second_Mortgage_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondDeedType',COUNT(__d1(__NL(Fares_Second_Deed_Type_))),COUNT(__d1(__NN(Fares_Second_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresAbsenteeIndicator',COUNT(__d1(__NL(Fares_Absentee_Indicator_))),COUNT(__d1(__NN(Fares_Absentee_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPartialInterestIndicator',COUNT(__d1(__NL(Fares_Partial_Interest_Indicator_))),COUNT(__d1(__NN(Fares_Partial_Interest_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrimaryCategoryCode',COUNT(__d1(__NL(Fares_Primary_Category_Code_))),COUNT(__d1(__NN(Fares_Primary_Category_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrivatePartyLender',COUNT(__d1(__NL(Fares_Private_Party_Lender_))),COUNT(__d1(__NN(Fares_Private_Party_Lender_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresConstructionLoan',COUNT(__d1(__NL(Fares_Construction_Loan_))),COUNT(__d1(__NN(Fares_Construction_Loan_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResaleNewConstruction',COUNT(__d1(__NL(Fares_Resale_New_Construction_))),COUNT(__d1(__NN(Fares_Resale_New_Construction_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresInterFamily',COUNT(__d1(__NL(Fares_Inter_Family_))),COUNT(__d1(__NN(Fares_Inter_Family_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCashMortgagePurchase',COUNT(__d1(__NL(Fares_Cash_Mortgage_Purchase_))),COUNT(__d1(__NN(Fares_Cash_Mortgage_Purchase_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresBuildingSquareFeet',COUNT(__d1(__NL(Fares_Building_Square_Feet_))),COUNT(__d1(__NN(Fares_Building_Square_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresForeclosure',COUNT(__d1(__NL(Fares_Foreclosure_))),COUNT(__d1(__NN(Fares_Foreclosure_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresRefincanceFlag',COUNT(__d1(__NL(Fares_Refincance_Flag_))),COUNT(__d1(__NN(Fares_Refincance_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresEquityFlag',COUNT(__d1(__NL(Fares_Equity_Flag_))),COUNT(__d1(__NN(Fares_Equity_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresIrisAPN',COUNT(__d1(__NL(Fares_Iris_A_P_N_))),COUNT(__d1(__NN(Fares_Iris_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid),COUNT(__d2)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d2(__NL(L_N_Fares_I_D_))),COUNT(__d2(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Predirectional',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Postdirectional',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryRange',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d2(__NL(Prop_))),COUNT(__d2(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d2(__NL(Is_Assessment_))),COUNT(__d2(__NN(Is_Assessment_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAdditionalFaresDeed',COUNT(__d2(__NL(Is_Additional_Fares_Deed_))),COUNT(__d2(__NN(Is_Additional_Fares_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d2(__NL(Process_Date_))),COUNT(__d2(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d2(__NL(Vendor_Source_Code_))),COUNT(__d2(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record',COUNT(__d2(__NL(Current_Record_))),COUNT(__d2(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fips_code',COUNT(__d2(__NL(F_I_P_S_Code_))),COUNT(__d2(__NN(F_I_P_S_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_name',COUNT(__d2(__NL(County_Name_))),COUNT(__d2(__NN(County_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OldAPN',COUNT(__d2(__NL(Old_A_P_N_))),COUNT(__d2(__NN(Old_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','apnt_or_pin_number',COUNT(__d2(__NL(A_P_N_Number_))),COUNT(__d2(__NN(A_P_N_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fares_unformatted_apn',COUNT(__d2(__NL(Fares_Unformatted_A_P_N_))),COUNT(__d2(__NN(Fares_Unformatted_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateApnWithDifferentAddressCounter',COUNT(__d2(__NL(Duplicate_Apn_With_Different_Address_Counter_))),COUNT(__d2(__NN(Duplicate_Apn_With_Different_Address_Counter_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeName',COUNT(__d2(__NL(Assessee_Name_))),COUNT(__d2(__NN(Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeName',COUNT(__d2(__NL(Second_Assessee_Name_))),COUNT(__d2(__NN(Second_Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipMethodCode',COUNT(__d2(__NL(Ownership_Method_Code_))),COUNT(__d2(__NN(Ownership_Method_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnersRelationshipCode',COUNT(__d2(__NL(Owners_Relationship_Code_))),COUNT(__d2(__NN(Owners_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d2(__NL(Owner_Phone_Number_))),COUNT(__d2(__NN(Owner_Phone_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAccountNumber',COUNT(__d2(__NL(Tax_Account_Number_))),COUNT(__d2(__NN(Tax_Account_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1IDCode',COUNT(__d2(__NL(Name1_I_D_Code_))),COUNT(__d2(__NN(Name1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2IDCode',COUNT(__d2(__NL(Name2_I_D_Code_))),COUNT(__d2(__NN(Name2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfNameTypeCode',COUNT(__d2(__NL(Mailing_Care_Of_Name_Type_Code_))),COUNT(__d2(__NN(Mailing_Care_Of_Name_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfName',COUNT(__d2(__NL(Mailing_Care_Of_Name_))),COUNT(__d2(__NN(Mailing_Care_Of_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingFullStreetAddress',COUNT(__d2(__NL(Mailing_Full_Street_Address_))),COUNT(__d2(__NN(Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_unit_number',COUNT(__d2(__NL(Mailing_Unit_Number_))),COUNT(__d2(__NN(Mailing_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_csz',COUNT(__d2(__NL(Mailing_City_State_Zip_))),COUNT(__d2(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_full_street_address',COUNT(__d2(__NL(Property_Full_Street_Address_))),COUNT(__d2(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_address_unit_number',COUNT(__d2(__NL(Property_Address_Unit_Number_))),COUNT(__d2(__NN(Property_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_address_citystatezip',COUNT(__d2(__NL(Property_Address_City_State_Zip_))),COUNT(__d2(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCountryCode',COUNT(__d2(__NL(Property_Address_Country_Code_))),COUNT(__d2(__NN(Property_Address_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_address_code',COUNT(__d2(__NL(Property_Address_Code_))),COUNT(__d2(__NN(Property_Address_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_lot_code',COUNT(__d2(__NL(Legal_Lot_Code_))),COUNT(__d2(__NN(Legal_Lot_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_lot_number',COUNT(__d2(__NL(Legal_Lot_Number_))),COUNT(__d2(__NN(Legal_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_land_lot',COUNT(__d2(__NL(Legal_Land_Lot_))),COUNT(__d2(__NN(Legal_Land_Lot_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_block',COUNT(__d2(__NL(Legal_Block_))),COUNT(__d2(__NN(Legal_Block_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_section',COUNT(__d2(__NL(Legal_Section_))),COUNT(__d2(__NN(Legal_Section_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_district',COUNT(__d2(__NL(Legal_District_))),COUNT(__d2(__NN(Legal_District_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_unit',COUNT(__d2(__NL(Legal_Unit_))),COUNT(__d2(__NN(Legal_Unit_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_city_municipality_township',COUNT(__d2(__NL(Legal_City_Municipality_Township_))),COUNT(__d2(__NN(Legal_City_Municipality_Township_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_subdivision_name',COUNT(__d2(__NL(Legal_Subdivision_Name_))),COUNT(__d2(__NN(Legal_Subdivision_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_phase_number',COUNT(__d2(__NL(Legal_Phase_Number_))),COUNT(__d2(__NN(Legal_Phase_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_tract_number',COUNT(__d2(__NL(Legal_Tract_Number_))),COUNT(__d2(__NN(Legal_Tract_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_sec_twn_rng_mer',COUNT(__d2(__NL(Legal_Section_Township_Range_Meridian_))),COUNT(__d2(__NN(Legal_Section_Township_Range_Meridian_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','legal_brief_description',COUNT(__d2(__NL(Legal_Brief_Description_))),COUNT(__d2(__NN(Legal_Brief_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_map_reference',COUNT(__d2(__NL(Map_Reference_))),COUNT(__d2(__NN(Map_Reference_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CensusTract',COUNT(__d2(__NL(Census_Tract_))),COUNT(__d2(__NN(Census_Tract_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d2(__NL(Record_Type_Code_))),COUNT(__d2(__NN(Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d2(__NL(Ownership_Type_Code_))),COUNT(__d2(__NN(Ownership_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NewRecordTypeCode',COUNT(__d2(__NL(New_Record_Type_Code_))),COUNT(__d2(__NN(New_Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateLandUseCode',COUNT(__d2(__NL(State_Land_Use_Code_))),COUNT(__d2(__NN(State_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseCode',COUNT(__d2(__NL(County_Land_Use_Code_))),COUNT(__d2(__NN(County_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseDescription',COUNT(__d2(__NL(County_Land_Use_Description_))),COUNT(__d2(__NN(County_Land_Use_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessment_match_land_use_code',COUNT(__d2(__NL(Standardized_Land_Use_Code_))),COUNT(__d2(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareCode',COUNT(__d2(__NL(Timeshare_Code_))),COUNT(__d2(__NN(Timeshare_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zoning',COUNT(__d2(__NL(Zoning_))),COUNT(__d2(__NN(Zoning_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d2(__NL(Occupant_Owned_))),COUNT(__d2(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_number',COUNT(__d2(__NL(Document_Number_))),COUNT(__d2(__NN(Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_book_number',COUNT(__d2(__NL(Recorder_Book_Number_))),COUNT(__d2(__NN(Recorder_Book_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recorder_page_number',COUNT(__d2(__NL(Recorder_Page_Number_))),COUNT(__d2(__NN(Recorder_Page_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransferDate',COUNT(__d2(__NL(Transfer_Date_))),COUNT(__d2(__NN(Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d2(__NL(Recording_Date_))),COUNT(__d2(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate',COUNT(__d2(__NL(Sale_Date_))),COUNT(__d2(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_type_code',COUNT(__d2(__NL(Document_Type_Code_))),COUNT(__d2(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price',COUNT(__d2(__NL(Sale_Price_))),COUNT(__d2(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price_code',COUNT(__d2(__NL(Sale_Price_Code_))),COUNT(__d2(__NN(Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d2(__NL(Mortgage_Amount_))),COUNT(__d2(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d2(__NL(Mortgage_Type_))),COUNT(__d2(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageLenderName',COUNT(__d2(__NL(Mortgage_Lender_Name_))),COUNT(__d2(__NN(Mortgage_Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_name_id',COUNT(__d2(__NL(Lender_I_D_Code_))),COUNT(__d2(__NN(Lender_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorTransferDate',COUNT(__d2(__NL(Prior_Transfer_Date_))),COUNT(__d2(__NN(Prior_Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d2(__NL(Previous_Recording_Date_))),COUNT(__d2(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d2(__NL(Previous_Sale_Price_))),COUNT(__d2(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePriceCode',COUNT(__d2(__NL(Previous_Sale_Price_Code_))),COUNT(__d2(__NN(Previous_Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedLandValue',COUNT(__d2(__NL(Assessed_Land_Value_))),COUNT(__d2(__NN(Assessed_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedImprovementValue',COUNT(__d2(__NL(Assessed_Improvement_Value_))),COUNT(__d2(__NN(Assessed_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d2(__NL(Assessed_Total_Value_))),COUNT(__d2(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d2(__NL(Assessed_Value_Year_))),COUNT(__d2(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketLandValue',COUNT(__d2(__NL(Market_Land_Value_))),COUNT(__d2(__NN(Market_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketImprovementValue',COUNT(__d2(__NL(Market_Improvement_Value_))),COUNT(__d2(__NN(Market_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d2(__NL(Market_Total_Value_))),COUNT(__d2(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d2(__NL(Market_Value_Year_))),COUNT(__d2(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode1',COUNT(__d2(__NL(Tax_Exemption_Code1_))),COUNT(__d2(__NN(Tax_Exemption_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode2',COUNT(__d2(__NL(Tax_Exemption_Code2_))),COUNT(__d2(__NN(Tax_Exemption_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode3',COUNT(__d2(__NL(Tax_Exemption_Code3_))),COUNT(__d2(__NN(Tax_Exemption_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode4',COUNT(__d2(__NL(Tax_Exemption_Code4_))),COUNT(__d2(__NN(Tax_Exemption_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxRateCodeArea',COUNT(__d2(__NL(Tax_Rate_Code_Area_))),COUNT(__d2(__NN(Tax_Rate_Code_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAmount',COUNT(__d2(__NL(Tax_Amount_))),COUNT(__d2(__NN(Tax_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d2(__NL(Tax_Year_))),COUNT(__d2(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxDelinquentYear',COUNT(__d2(__NL(Tax_Delinquent_Year_))),COUNT(__d2(__NN(Tax_Delinquent_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict1',COUNT(__d2(__NL(School_Tax_District1_))),COUNT(__d2(__NN(School_Tax_District1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict2',COUNT(__d2(__NL(School_Tax_District2_))),COUNT(__d2(__NN(School_Tax_District2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict3',COUNT(__d2(__NL(School_Tax_District3_))),COUNT(__d2(__NN(School_Tax_District3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator1',COUNT(__d2(__NL(School_Tax_District_Indicator1_))),COUNT(__d2(__NN(School_Tax_District_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator2',COUNT(__d2(__NL(School_Tax_District_Indicator2_))),COUNT(__d2(__NN(School_Tax_District_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator3',COUNT(__d2(__NL(School_Tax_District_Indicator3_))),COUNT(__d2(__NN(School_Tax_District_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d2(__NL(Lot_Size_))),COUNT(__d2(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeAcres',COUNT(__d2(__NL(Lot_Size_Acres_))),COUNT(__d2(__NN(Lot_Size_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeFrontageFeet',COUNT(__d2(__NL(Lot_Size_Frontage_Feet_))),COUNT(__d2(__NN(Lot_Size_Frontage_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeDepthFeet',COUNT(__d2(__NL(Lot_Size_Depth_Feet_))),COUNT(__d2(__NN(Lot_Size_Depth_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandAcres',COUNT(__d2(__NL(Land_Acres_))),COUNT(__d2(__NN(Land_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d2(__NL(Land_Square_Footage_))),COUNT(__d2(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandDimensions',COUNT(__d2(__NL(Land_Dimensions_))),COUNT(__d2(__NN(Land_Dimensions_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d2(__NL(Building_Area_))),COUNT(__d2(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea1',COUNT(__d2(__NL(Building_Area1_))),COUNT(__d2(__NN(Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea2',COUNT(__d2(__NL(Building_Area2_))),COUNT(__d2(__NN(Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea3',COUNT(__d2(__NL(Building_Area3_))),COUNT(__d2(__NN(Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea4',COUNT(__d2(__NL(Building_Area4_))),COUNT(__d2(__NN(Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea5',COUNT(__d2(__NL(Building_Area5_))),COUNT(__d2(__NN(Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea6',COUNT(__d2(__NL(Building_Area6_))),COUNT(__d2(__NN(Building_Area6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea7',COUNT(__d2(__NL(Building_Area7_))),COUNT(__d2(__NN(Building_Area7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator',COUNT(__d2(__NL(Building_Area_Indicator_))),COUNT(__d2(__NN(Building_Area_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator1',COUNT(__d2(__NL(Building_Area_Indicator1_))),COUNT(__d2(__NN(Building_Area_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator2',COUNT(__d2(__NL(Building_Area_Indicator2_))),COUNT(__d2(__NN(Building_Area_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator3',COUNT(__d2(__NL(Building_Area_Indicator3_))),COUNT(__d2(__NN(Building_Area_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator4',COUNT(__d2(__NL(Building_Area_Indicator4_))),COUNT(__d2(__NN(Building_Area_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator5',COUNT(__d2(__NL(Building_Area_Indicator5_))),COUNT(__d2(__NN(Building_Area_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator6',COUNT(__d2(__NL(Building_Area_Indicator6_))),COUNT(__d2(__NN(Building_Area_Indicator6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator7',COUNT(__d2(__NL(Building_Area_Indicator7_))),COUNT(__d2(__NN(Building_Area_Indicator7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d2(__NL(Year_Built_))),COUNT(__d2(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d2(__NL(Effective_Year_Built_))),COUNT(__d2(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d2(__NL(Number_Of_Buildings_))),COUNT(__d2(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d2(__NL(Number_Of_Stories_))),COUNT(__d2(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d2(__NL(Number_Of_Units_))),COUNT(__d2(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d2(__NL(Number_Of_Rooms_))),COUNT(__d2(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d2(__NL(Number_Of_Bedrooms_))),COUNT(__d2(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d2(__NL(Number_Of_Baths_))),COUNT(__d2(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d2(__NL(Number_Of_Partial_Baths_))),COUNT(__d2(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPlumbingFixtures',COUNT(__d2(__NL(Number_Of_Plumbing_Fixtures_))),COUNT(__d2(__NN(Number_Of_Plumbing_Fixtures_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d2(__NL(Garage_Type_Code_))),COUNT(__d2(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d2(__NL(Parking_Number_Of_Cars_))),COUNT(__d2(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PoolCode',COUNT(__d2(__NL(Pool_Code_))),COUNT(__d2(__NN(Pool_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d2(__NL(Style_Code_))),COUNT(__d2(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeConstructionCode',COUNT(__d2(__NL(Type_Construction_Code_))),COUNT(__d2(__NN(Type_Construction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FoundationCode',COUNT(__d2(__NL(Foundation_Code_))),COUNT(__d2(__NN(Foundation_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingQualityCode',COUNT(__d2(__NL(Building_Quality_Code_))),COUNT(__d2(__NN(Building_Quality_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingConditionCode',COUNT(__d2(__NL(Building_Condition_Code_))),COUNT(__d2(__NN(Building_Condition_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExteriorWallsCode',COUNT(__d2(__NL(Exterior_Walls_Code_))),COUNT(__d2(__NN(Exterior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InteriorWallsCode',COUNT(__d2(__NL(Interior_Walls_Code_))),COUNT(__d2(__NN(Interior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofCoverCode',COUNT(__d2(__NL(Roof_Cover_Code_))),COUNT(__d2(__NN(Roof_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofTypeCode',COUNT(__d2(__NL(Roof_Type_Code_))),COUNT(__d2(__NN(Roof_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FloorCoverCode',COUNT(__d2(__NL(Floor_Cover_Code_))),COUNT(__d2(__NN(Floor_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WaterCode',COUNT(__d2(__NL(Water_Code_))),COUNT(__d2(__NN(Water_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SewerCode',COUNT(__d2(__NL(Sewer_Code_))),COUNT(__d2(__NN(Sewer_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingCode',COUNT(__d2(__NL(Heating_Code_))),COUNT(__d2(__NN(Heating_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingFuelTypeCode',COUNT(__d2(__NL(Heating_Fuel_Type_Code_))),COUNT(__d2(__NN(Heating_Fuel_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningCode',COUNT(__d2(__NL(Air_Conditioning_Code_))),COUNT(__d2(__NN(Air_Conditioning_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningTypeCode',COUNT(__d2(__NL(Air_Conditioning_Type_Code_))),COUNT(__d2(__NN(Air_Conditioning_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Elevator',COUNT(__d2(__NL(Elevator_))),COUNT(__d2(__NN(Elevator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d2(__NL(Fireplace_Indicator_))),COUNT(__d2(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceNumber',COUNT(__d2(__NL(Fireplace_Number_))),COUNT(__d2(__NN(Fireplace_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BasementCode',COUNT(__d2(__NL(Basement_Code_))),COUNT(__d2(__NN(Basement_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingClassCode',COUNT(__d2(__NL(Building_Class_Code_))),COUNT(__d2(__NN(Building_Class_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode1',COUNT(__d2(__NL(Site_Influence_Code1_))),COUNT(__d2(__NN(Site_Influence_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode2',COUNT(__d2(__NL(Site_Influence_Code2_))),COUNT(__d2(__NN(Site_Influence_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode3',COUNT(__d2(__NL(Site_Influence_Code3_))),COUNT(__d2(__NN(Site_Influence_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode4',COUNT(__d2(__NL(Site_Influence_Code4_))),COUNT(__d2(__NN(Site_Influence_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode5',COUNT(__d2(__NL(Site_Influence_Code5_))),COUNT(__d2(__NN(Site_Influence_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode1',COUNT(__d2(__NL(Amenity_Code1_))),COUNT(__d2(__NN(Amenity_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode2',COUNT(__d2(__NL(Amenity_Code2_))),COUNT(__d2(__NN(Amenity_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode3',COUNT(__d2(__NL(Amenity_Code3_))),COUNT(__d2(__NN(Amenity_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode4',COUNT(__d2(__NL(Amenity_Code4_))),COUNT(__d2(__NN(Amenity_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode5',COUNT(__d2(__NL(Amenity_Code5_))),COUNT(__d2(__NN(Amenity_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode6',COUNT(__d2(__NL(Amenity_Code6_))),COUNT(__d2(__NN(Amenity_Code6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode7',COUNT(__d2(__NL(Amenity_Code7_))),COUNT(__d2(__NN(Amenity_Code7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode8',COUNT(__d2(__NL(Amenity_Code8_))),COUNT(__d2(__NN(Amenity_Code8_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode9',COUNT(__d2(__NL(Amenity_Code9_))),COUNT(__d2(__NN(Amenity_Code9_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode10',COUNT(__d2(__NL(Amenity_Code10_))),COUNT(__d2(__NN(Amenity_Code10_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea1',COUNT(__d2(__NL(Extra_Feature_Area1_))),COUNT(__d2(__NN(Extra_Feature_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea2',COUNT(__d2(__NL(Extra_Feature_Area2_))),COUNT(__d2(__NN(Extra_Feature_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea3',COUNT(__d2(__NL(Extra_Feature_Area3_))),COUNT(__d2(__NN(Extra_Feature_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea4',COUNT(__d2(__NL(Extra_Feature_Area4_))),COUNT(__d2(__NN(Extra_Feature_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator1',COUNT(__d2(__NL(Extra_Feature_Indicator1_))),COUNT(__d2(__NN(Extra_Feature_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator2',COUNT(__d2(__NL(Extra_Feature_Indicator2_))),COUNT(__d2(__NN(Extra_Feature_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator3',COUNT(__d2(__NL(Extra_Feature_Indicator3_))),COUNT(__d2(__NN(Extra_Feature_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator4',COUNT(__d2(__NL(Extra_Feature_Indicator4_))),COUNT(__d2(__NN(Extra_Feature_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode1',COUNT(__d2(__NL(Other_Building_Code1_))),COUNT(__d2(__NN(Other_Building_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode2',COUNT(__d2(__NL(Other_Building_Code2_))),COUNT(__d2(__NN(Other_Building_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode3',COUNT(__d2(__NL(Other_Building_Code3_))),COUNT(__d2(__NN(Other_Building_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode4',COUNT(__d2(__NL(Other_Building_Code4_))),COUNT(__d2(__NN(Other_Building_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode5',COUNT(__d2(__NL(Other_Building_Code5_))),COUNT(__d2(__NN(Other_Building_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator1',COUNT(__d2(__NL(Other_Important_Building_Indicator1_))),COUNT(__d2(__NN(Other_Important_Building_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator2',COUNT(__d2(__NL(Other_Important_Building_Indicator2_))),COUNT(__d2(__NN(Other_Important_Building_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator3',COUNT(__d2(__NL(Other_Important_Building_Indicator3_))),COUNT(__d2(__NN(Other_Important_Building_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator4',COUNT(__d2(__NL(Other_Important_Building_Indicator4_))),COUNT(__d2(__NN(Other_Important_Building_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator5',COUNT(__d2(__NL(Other_Important_Building_Indicator5_))),COUNT(__d2(__NN(Other_Important_Building_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea1',COUNT(__d2(__NL(Other_Important_Building_Area1_))),COUNT(__d2(__NN(Other_Important_Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea2',COUNT(__d2(__NL(Other_Important_Building_Area2_))),COUNT(__d2(__NN(Other_Important_Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea3',COUNT(__d2(__NL(Other_Important_Building_Area3_))),COUNT(__d2(__NN(Other_Important_Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea4',COUNT(__d2(__NL(Other_Important_Building_Area4_))),COUNT(__d2(__NN(Other_Important_Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea5',COUNT(__d2(__NL(Other_Important_Building_Area5_))),COUNT(__d2(__NN(Other_Important_Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TopographyCode',COUNT(__d2(__NL(Topography_Code_))),COUNT(__d2(__NN(Topography_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodCode',COUNT(__d2(__NL(Neighborhood_Code_))),COUNT(__d2(__NN(Neighborhood_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoProjectOrBuildingName',COUNT(__d2(__NL(Condo_Project_Or_Building_Name_))),COUNT(__d2(__NN(Condo_Project_Or_Building_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeNameIndicator',COUNT(__d2(__NL(Assessee_Name_Indicator_))),COUNT(__d2(__NN(Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeNameIndicator',COUNT(__d2(__NL(Second_Assessee_Name_Indicator_))),COUNT(__d2(__NN(Second_Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherRoomsIndicator',COUNT(__d2(__NL(Other_Rooms_Indicator_))),COUNT(__d2(__NN(Other_Rooms_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailCareOfNameIndicator',COUNT(__d2(__NL(Mail_Care_Of_Name_Indicator_))),COUNT(__d2(__NN(Mail_Care_Of_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Comments',COUNT(__d2(__NL(Comments_))),COUNT(__d2(__NN(Comments_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TapeCutDate',COUNT(__d2(__NL(Tape_Cut_Date_))),COUNT(__d2(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d2(__NL(Certification_Date_))),COUNT(__d2(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EditionNumber',COUNT(__d2(__NL(Edition_Number_))),COUNT(__d2(__NN(Edition_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prop_addr_propagated_ind',COUNT(__d2(__NL(Property_Address_Propegated_Indicator_))),COUNT(__d2(__NN(Property_Address_Propegated_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_ownership_rights',COUNT(__d2(__NL(L_N_Ownership_Rights_))),COUNT(__d2(__NN(L_N_Ownership_Rights_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_relationship_type',COUNT(__d2(__NL(L_N_Relationship_Type_))),COUNT(__d2(__NN(L_N_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMailingCountryCode',COUNT(__d2(__NL(L_N_Mailing_Country_Code_))),COUNT(__d2(__NN(L_N_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyName',COUNT(__d2(__NL(L_N_Property_Name_))),COUNT(__d2(__NN(L_N_Property_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyNameType',COUNT(__d2(__NL(L_N_Property_Name_Type_))),COUNT(__d2(__NN(L_N_Property_Name_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLandUseCategory',COUNT(__d2(__NL(L_N_Land_Use_Category_))),COUNT(__d2(__NN(L_N_Land_Use_Category_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLotNumber',COUNT(__d2(__NL(L_N_Lot_Number_))),COUNT(__d2(__NN(L_N_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBlockNumber',COUNT(__d2(__NL(L_N_Block_Number_))),COUNT(__d2(__NN(L_N_Block_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNUnitNumber',COUNT(__d2(__NL(L_N_Unit_Number_))),COUNT(__d2(__NN(L_N_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSubfloor',COUNT(__d2(__NL(L_N_Subfloor_))),COUNT(__d2(__NN(L_N_Subfloor_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMobileHomeIndicator',COUNT(__d2(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d2(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCondoIndicator',COUNT(__d2(__NL(L_N_Condo_Indicator_))),COUNT(__d2(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyTaxExemptionIndicator',COUNT(__d2(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d2(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNVeteranStatus',COUNT(__d2(__NL(L_N_Veteran_Status_))),COUNT(__d2(__NN(L_N_Veteran_Status_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','from_file',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','multi_apn_flag',COUNT(__d2(__NL(Multi_A_P_N_Flag_))),COUNT(__d2(__NN(Multi_A_P_N_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_id_number',COUNT(__d2(__NL(Tax_Number_))),COUNT(__d2(__NN(Tax_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','buyer_or_borrower_ind',COUNT(__d2(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d2(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name1',COUNT(__d2(__NL(Name1_))),COUNT(__d2(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name1_id_code',COUNT(__d2(__NL(Name1_Code_))),COUNT(__d2(__NN(Name1_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name2',COUNT(__d2(__NL(Name2_))),COUNT(__d2(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name2_id_code',COUNT(__d2(__NL(Name2_Code_))),COUNT(__d2(__NN(Name2_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vesting_code',COUNT(__d2(__NL(Buyer_Borrower_Vesting_Code_))),COUNT(__d2(__NN(Buyer_Borrower_Vesting_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addendum_flag',COUNT(__d2(__NL(Buyer_Borrower_Addendum_Flag_))),COUNT(__d2(__NN(Buyer_Borrower_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_care_of',COUNT(__d2(__NL(Mailing_Care_Of_))),COUNT(__d2(__NN(Mailing_Care_Of_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_street',COUNT(__d2(__NL(Mailing_Street_))),COUNT(__d2(__NN(Mailing_Street_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller1',COUNT(__d2(__NL(Seller1_))),COUNT(__d2(__NN(Seller1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller1_id_code',COUNT(__d2(__NL(Seller1_I_D_Code_))),COUNT(__d2(__NN(Seller1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller2',COUNT(__d2(__NL(Seller2_))),COUNT(__d2(__NN(Seller2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller2_id_code',COUNT(__d2(__NL(Seller2_I_D_Code_))),COUNT(__d2(__NN(Seller2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller_addendum_flag',COUNT(__d2(__NL(Seller_Addendum_Flag_))),COUNT(__d2(__NN(Seller_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller_mailing_full_street_address',COUNT(__d2(__NL(Seller_Mailing_Full_Street_Address_))),COUNT(__d2(__NN(Seller_Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller_mailing_address_unit_number',COUNT(__d2(__NL(Seller_Mailing_Address_Unit_Number_))),COUNT(__d2(__NN(Seller_Mailing_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seller_mailing_address_citystatezip',COUNT(__d2(__NL(Seller_Mailing_Address_City_State_Zip_))),COUNT(__d2(__NN(Seller_Mailing_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','complete_legal_description_code',COUNT(__d2(__NL(Legal_Complete_Description_Code_))),COUNT(__d2(__NN(Legal_Complete_Description_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contract_date',COUNT(__d2(__NL(Contract_Date_))),COUNT(__d2(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','arm_reset_date',COUNT(__d2(__NL(Adjustable_Rate_Mortgage_Reset_Date_))),COUNT(__d2(__NN(Adjustable_Rate_Mortgage_Reset_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','loan_number',COUNT(__d2(__NL(Loan_Number_))),COUNT(__d2(__NN(Loan_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','concurrent_mortgage_book_page_document_number',COUNT(__d2(__NL(Concurrent_Mortgage_Book_Page_Document_Number_))),COUNT(__d2(__NN(Concurrent_Mortgage_Book_Page_Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','city_transfer_tax',COUNT(__d2(__NL(City_Transfer_Tax_))),COUNT(__d2(__NN(City_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_transfer_tax',COUNT(__d2(__NL(County_Transfer_Tax_))),COUNT(__d2(__NN(County_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','total_transfer_tax',COUNT(__d2(__NL(Total_Transfer_Tax_))),COUNT(__d2(__NN(Total_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_td_loan_amount',COUNT(__d2(__NL(Primary_Loan_Amount_))),COUNT(__d2(__NN(Primary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_td_loan_amount',COUNT(__d2(__NL(Secondary_Loan_Amount_))),COUNT(__d2(__NN(Secondary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_td_lender_type_code',COUNT(__d2(__NL(Primary_Loan_Lender_Type_Code_))),COUNT(__d2(__NN(Primary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_td_lender_type_code',COUNT(__d2(__NL(Secondary_Loan_Lender_Type_Code_))),COUNT(__d2(__NN(Secondary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_td_loan_type_code',COUNT(__d2(__NL(Primary_Loan_Type_Code_))),COUNT(__d2(__NN(Primary_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','type_financing',COUNT(__d2(__NL(Type_Financing_))),COUNT(__d2(__NN(Type_Financing_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_td_interest_rate',COUNT(__d2(__NL(Primary_Loan_Interest_Rate_))),COUNT(__d2(__NN(Primary_Loan_Interest_Rate_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_td_due_date',COUNT(__d2(__NL(Primary_Loan_Due_Date_))),COUNT(__d2(__NN(Primary_Loan_Due_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title_company_name',COUNT(__d2(__NL(Title_Company_Name_))),COUNT(__d2(__NN(Title_Company_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','partial_interest_transferred',COUNT(__d2(__NL(Partial_Interest_Transferred_))),COUNT(__d2(__NN(Partial_Interest_Transferred_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','loan_term_months',COUNT(__d2(__NL(Loan_Term_Months_))),COUNT(__d2(__NN(Loan_Term_Months_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','loan_term_years',COUNT(__d2(__NL(Loan_Term_Years_))),COUNT(__d2(__NN(Loan_Term_Years_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_name',COUNT(__d2(__NL(Lender_Name_))),COUNT(__d2(__NN(Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_dba_aka_name',COUNT(__d2(__NL(Lender_D_B_A_Name_))),COUNT(__d2(__NN(Lender_D_B_A_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_full_street_address',COUNT(__d2(__NL(Lender_Full_Street_Address_))),COUNT(__d2(__NN(Lender_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_address_unit_number',COUNT(__d2(__NL(Lender_Address_Unit_Number_))),COUNT(__d2(__NN(Lender_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lender_address_citystatezip',COUNT(__d2(__NL(Lender_Address_City_State_Zip_))),COUNT(__d2(__NN(Lender_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_use_code',COUNT(__d2(__NL(Property_Use_Code_))),COUNT(__d2(__NN(Property_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','condo_code',COUNT(__d2(__NL(Condo_Code_))),COUNT(__d2(__NN(Condo_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','timeshare_flag',COUNT(__d2(__NL(Timeshare_Flag_))),COUNT(__d2(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_lot_size',COUNT(__d2(__NL(Land_Lot_Size_))),COUNT(__d2(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rate_change_frequency',COUNT(__d2(__NL(Rate_Change_Frequency_))),COUNT(__d2(__NN(Rate_Change_Frequency_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','change_index',COUNT(__d2(__NL(Change_Index_))),COUNT(__d2(__NN(Change_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','adjustable_rate_index',COUNT(__d2(__NL(Adjustable_Rate_Index_))),COUNT(__d2(__NN(Adjustable_Rate_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','adjustable_rate_rider',COUNT(__d2(__NL(Adjustable_Rate_Rider_))),COUNT(__d2(__NN(Adjustable_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','graduated_payment_rider',COUNT(__d2(__NL(Graduated_Payment_Rider_))),COUNT(__d2(__NN(Graduated_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','balloon_rider',COUNT(__d2(__NL(Balloon_Rider_))),COUNT(__d2(__NN(Balloon_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fixed_step_rate_rider',COUNT(__d2(__NL(Fixed_Step_Rate_Rider_))),COUNT(__d2(__NN(Fixed_Step_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','condominium_rider',COUNT(__d2(__NL(Condominium_Rider_))),COUNT(__d2(__NN(Condominium_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','planned_unit_development_rider',COUNT(__d2(__NL(Planned_Unit_Development_Rider_))),COUNT(__d2(__NN(Planned_Unit_Development_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assumability_rider',COUNT(__d2(__NL(Assumability_Rider_))),COUNT(__d2(__NN(Assumability_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prepayment_rider',COUNT(__d2(__NL(Prepayment_Rider_))),COUNT(__d2(__NN(Prepayment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','one_four_family_rider',COUNT(__d2(__NL(One_Four_Family_Rider_))),COUNT(__d2(__NN(One_Four_Family_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','biweekly_payment_rider',COUNT(__d2(__NL(Biweekly_Payment_Rider_))),COUNT(__d2(__NN(Biweekly_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_home_rider',COUNT(__d2(__NL(Second_Home_Rider_))),COUNT(__d2(__NN(Second_Home_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','data_source_code',COUNT(__d2(__NL(Data_Source_Code_))),COUNT(__d2(__NN(Data_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','main_record_id_code',COUNT(__d2(__NL(Type_Of_Deed_Code_))),COUNT(__d2(__NN(Type_Of_Deed_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addl_name_flag',COUNT(__d2(__NL(Additional_Name_Flag_))),COUNT(__d2(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_buyer_mailing_country_code',COUNT(__d2(__NL(L_N_Buyer_Mailing_Country_Code_))),COUNT(__d2(__NN(L_N_Buyer_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_seller_mailing_country_code',COUNT(__d2(__NL(L_N_Seller_Mailing_Country_Code_))),COUNT(__d2(__NN(L_N_Seller_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerEtAlIndicator',COUNT(__d2(__NL(Fares_Owner_Et_Al_Indicator_))),COUNT(__d2(__NN(Fares_Owner_Et_Al_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipCode',COUNT(__d2(__NL(Fares_Owner_Relationship_Code_))),COUNT(__d2(__NN(Fares_Owner_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipType',COUNT(__d2(__NL(Fares_Owner_Relationship_Type_))),COUNT(__d2(__NN(Fares_Owner_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMatchCode',COUNT(__d2(__NL(Fares_Match_Code_))),COUNT(__d2(__NN(Fares_Match_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresDocumentYear',COUNT(__d2(__NL(Fares_Document_Year_))),COUNT(__d2(__NN(Fares_Document_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCorporateIndicator',COUNT(__d2(__NL(Fares_Corporate_Indicator_))),COUNT(__d2(__NN(Fares_Corporate_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresTransactionType',COUNT(__d2(__NL(Fares_Transaction_Type_))),COUNT(__d2(__NN(Fares_Transaction_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresLenderAddress',COUNT(__d2(__NL(Fares_Lender_Address_))),COUNT(__d2(__NN(Fares_Lender_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSalesTransactionCode',COUNT(__d2(__NL(Fares_Sales_Transaction_Code_))),COUNT(__d2(__NN(Fares_Sales_Transaction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResidentialModelInd',COUNT(__d2(__NL(Fares_Residential_Model_Ind_))),COUNT(__d2(__NN(Fares_Residential_Model_Ind_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageDeedType',COUNT(__d2(__NL(Fares_Mortgage_Deed_Type_))),COUNT(__d2(__NN(Fares_Mortgage_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTermCode',COUNT(__d2(__NL(Fares_Mortgage_Term_Code_))),COUNT(__d2(__NN(Fares_Mortgage_Term_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTerm',COUNT(__d2(__NL(Fares_Mortgage_Term_))),COUNT(__d2(__NN(Fares_Mortgage_Term_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageAssumptionAmount',COUNT(__d2(__NL(Fares_Mortgage_Assumption_Amount_))),COUNT(__d2(__NN(Fares_Mortgage_Assumption_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondMortgageLoanTypeCode',COUNT(__d2(__NL(Fares_Second_Mortgage_Loan_Type_Code_))),COUNT(__d2(__NN(Fares_Second_Mortgage_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondDeedType',COUNT(__d2(__NL(Fares_Second_Deed_Type_))),COUNT(__d2(__NN(Fares_Second_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresAbsenteeIndicator',COUNT(__d2(__NL(Fares_Absentee_Indicator_))),COUNT(__d2(__NN(Fares_Absentee_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPartialInterestIndicator',COUNT(__d2(__NL(Fares_Partial_Interest_Indicator_))),COUNT(__d2(__NN(Fares_Partial_Interest_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrimaryCategoryCode',COUNT(__d2(__NL(Fares_Primary_Category_Code_))),COUNT(__d2(__NN(Fares_Primary_Category_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrivatePartyLender',COUNT(__d2(__NL(Fares_Private_Party_Lender_))),COUNT(__d2(__NN(Fares_Private_Party_Lender_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresConstructionLoan',COUNT(__d2(__NL(Fares_Construction_Loan_))),COUNT(__d2(__NN(Fares_Construction_Loan_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResaleNewConstruction',COUNT(__d2(__NL(Fares_Resale_New_Construction_))),COUNT(__d2(__NN(Fares_Resale_New_Construction_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresInterFamily',COUNT(__d2(__NL(Fares_Inter_Family_))),COUNT(__d2(__NN(Fares_Inter_Family_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCashMortgagePurchase',COUNT(__d2(__NL(Fares_Cash_Mortgage_Purchase_))),COUNT(__d2(__NN(Fares_Cash_Mortgage_Purchase_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresBuildingSquareFeet',COUNT(__d2(__NL(Fares_Building_Square_Feet_))),COUNT(__d2(__NN(Fares_Building_Square_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresForeclosure',COUNT(__d2(__NL(Fares_Foreclosure_))),COUNT(__d2(__NN(Fares_Foreclosure_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresRefincanceFlag',COUNT(__d2(__NL(Fares_Refincance_Flag_))),COUNT(__d2(__NN(Fares_Refincance_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresEquityFlag',COUNT(__d2(__NL(Fares_Equity_Flag_))),COUNT(__d2(__NN(Fares_Equity_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresIrisAPN',COUNT(__d2(__NL(Fares_Iris_A_P_N_))),COUNT(__d2(__NN(Fares_Iris_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(__d3)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d3(__NL(L_N_Fares_I_D_))),COUNT(__d3(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d3(__NL(Prop_))),COUNT(__d3(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDeed',COUNT(__d3(__NL(Is_Deed_))),COUNT(__d3(__NN(Is_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d3(__NL(Is_Assessment_))),COUNT(__d3(__NN(Is_Assessment_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAdditionalFaresDeed',COUNT(__d3(__NL(Is_Additional_Fares_Deed_))),COUNT(__d3(__NN(Is_Additional_Fares_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d3(__NL(Process_Date_))),COUNT(__d3(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VendorSourceCode',COUNT(__d3(__NL(Vendor_Source_Code_))),COUNT(__d3(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRecord',COUNT(__d3(__NL(Current_Record_))),COUNT(__d3(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FIPSCode',COUNT(__d3(__NL(F_I_P_S_Code_))),COUNT(__d3(__NN(F_I_P_S_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyName',COUNT(__d3(__NL(County_Name_))),COUNT(__d3(__NN(County_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OldAPN',COUNT(__d3(__NL(Old_A_P_N_))),COUNT(__d3(__NN(Old_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','APNNumber',COUNT(__d3(__NL(A_P_N_Number_))),COUNT(__d3(__NN(A_P_N_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresUnformattedAPN',COUNT(__d3(__NL(Fares_Unformatted_A_P_N_))),COUNT(__d3(__NN(Fares_Unformatted_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateApnWithDifferentAddressCounter',COUNT(__d3(__NL(Duplicate_Apn_With_Different_Address_Counter_))),COUNT(__d3(__NN(Duplicate_Apn_With_Different_Address_Counter_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeName',COUNT(__d3(__NL(Assessee_Name_))),COUNT(__d3(__NN(Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeName',COUNT(__d3(__NL(Second_Assessee_Name_))),COUNT(__d3(__NN(Second_Assessee_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipMethodCode',COUNT(__d3(__NL(Ownership_Method_Code_))),COUNT(__d3(__NN(Ownership_Method_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnersRelationshipCode',COUNT(__d3(__NL(Owners_Relationship_Code_))),COUNT(__d3(__NN(Owners_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerPhoneNumber',COUNT(__d3(__NL(Owner_Phone_Number_))),COUNT(__d3(__NN(Owner_Phone_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAccountNumber',COUNT(__d3(__NL(Tax_Account_Number_))),COUNT(__d3(__NN(Tax_Account_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1IDCode',COUNT(__d3(__NL(Name1_I_D_Code_))),COUNT(__d3(__NN(Name1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2IDCode',COUNT(__d3(__NL(Name2_I_D_Code_))),COUNT(__d3(__NN(Name2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfNameTypeCode',COUNT(__d3(__NL(Mailing_Care_Of_Name_Type_Code_))),COUNT(__d3(__NN(Mailing_Care_Of_Name_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOfName',COUNT(__d3(__NL(Mailing_Care_Of_Name_))),COUNT(__d3(__NN(Mailing_Care_Of_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingFullStreetAddress',COUNT(__d3(__NL(Mailing_Full_Street_Address_))),COUNT(__d3(__NN(Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingUnitNumber',COUNT(__d3(__NL(Mailing_Unit_Number_))),COUNT(__d3(__NN(Mailing_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCityStateZip',COUNT(__d3(__NL(Mailing_City_State_Zip_))),COUNT(__d3(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyFullStreetAddress',COUNT(__d3(__NL(Property_Full_Street_Address_))),COUNT(__d3(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressUnitNumber',COUNT(__d3(__NL(Property_Address_Unit_Number_))),COUNT(__d3(__NN(Property_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCityStateZip',COUNT(__d3(__NL(Property_Address_City_State_Zip_))),COUNT(__d3(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCountryCode',COUNT(__d3(__NL(Property_Address_Country_Code_))),COUNT(__d3(__NN(Property_Address_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCode',COUNT(__d3(__NL(Property_Address_Code_))),COUNT(__d3(__NN(Property_Address_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotCode',COUNT(__d3(__NL(Legal_Lot_Code_))),COUNT(__d3(__NN(Legal_Lot_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotNumber',COUNT(__d3(__NL(Legal_Lot_Number_))),COUNT(__d3(__NN(Legal_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLandLot',COUNT(__d3(__NL(Legal_Land_Lot_))),COUNT(__d3(__NN(Legal_Land_Lot_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBlock',COUNT(__d3(__NL(Legal_Block_))),COUNT(__d3(__NN(Legal_Block_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSection',COUNT(__d3(__NL(Legal_Section_))),COUNT(__d3(__NN(Legal_Section_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalDistrict',COUNT(__d3(__NL(Legal_District_))),COUNT(__d3(__NN(Legal_District_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalUnit',COUNT(__d3(__NL(Legal_Unit_))),COUNT(__d3(__NN(Legal_Unit_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCityMunicipalityTownship',COUNT(__d3(__NL(Legal_City_Municipality_Township_))),COUNT(__d3(__NN(Legal_City_Municipality_Township_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSubdivisionName',COUNT(__d3(__NL(Legal_Subdivision_Name_))),COUNT(__d3(__NN(Legal_Subdivision_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalPhaseNumber',COUNT(__d3(__NL(Legal_Phase_Number_))),COUNT(__d3(__NN(Legal_Phase_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalTractNumber',COUNT(__d3(__NL(Legal_Tract_Number_))),COUNT(__d3(__NN(Legal_Tract_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSectionTownshipRangeMeridian',COUNT(__d3(__NL(Legal_Section_Township_Range_Meridian_))),COUNT(__d3(__NN(Legal_Section_Township_Range_Meridian_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBriefDescription',COUNT(__d3(__NL(Legal_Brief_Description_))),COUNT(__d3(__NN(Legal_Brief_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MapReference',COUNT(__d3(__NL(Map_Reference_))),COUNT(__d3(__NN(Map_Reference_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CensusTract',COUNT(__d3(__NL(Census_Tract_))),COUNT(__d3(__NN(Census_Tract_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d3(__NL(Record_Type_Code_))),COUNT(__d3(__NN(Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipTypeCode',COUNT(__d3(__NL(Ownership_Type_Code_))),COUNT(__d3(__NN(Ownership_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NewRecordTypeCode',COUNT(__d3(__NL(New_Record_Type_Code_))),COUNT(__d3(__NN(New_Record_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateLandUseCode',COUNT(__d3(__NL(State_Land_Use_Code_))),COUNT(__d3(__NN(State_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseCode',COUNT(__d3(__NL(County_Land_Use_Code_))),COUNT(__d3(__NN(County_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseDescription',COUNT(__d3(__NL(County_Land_Use_Description_))),COUNT(__d3(__NN(County_Land_Use_Description_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardizedLandUseCode',COUNT(__d3(__NL(Standardized_Land_Use_Code_))),COUNT(__d3(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareCode',COUNT(__d3(__NL(Timeshare_Code_))),COUNT(__d3(__NN(Timeshare_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zoning',COUNT(__d3(__NL(Zoning_))),COUNT(__d3(__NN(Zoning_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d3(__NL(Occupant_Owned_))),COUNT(__d3(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentNumber',COUNT(__d3(__NL(Document_Number_))),COUNT(__d3(__NN(Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderBookNumber',COUNT(__d3(__NL(Recorder_Book_Number_))),COUNT(__d3(__NN(Recorder_Book_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderPageNumber',COUNT(__d3(__NL(Recorder_Page_Number_))),COUNT(__d3(__NN(Recorder_Page_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransferDate',COUNT(__d3(__NL(Transfer_Date_))),COUNT(__d3(__NN(Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordingDate',COUNT(__d3(__NL(Recording_Date_))),COUNT(__d3(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate',COUNT(__d3(__NL(Sale_Date_))),COUNT(__d3(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentTypeCode',COUNT(__d3(__NL(Document_Type_Code_))),COUNT(__d3(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice',COUNT(__d3(__NL(Sale_Price_))),COUNT(__d3(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePriceCode',COUNT(__d3(__NL(Sale_Price_Code_))),COUNT(__d3(__NN(Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d3(__NL(Mortgage_Amount_))),COUNT(__d3(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d3(__NL(Mortgage_Type_))),COUNT(__d3(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageLenderName',COUNT(__d3(__NL(Mortgage_Lender_Name_))),COUNT(__d3(__NN(Mortgage_Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderIDCode',COUNT(__d3(__NL(Lender_I_D_Code_))),COUNT(__d3(__NN(Lender_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorTransferDate',COUNT(__d3(__NL(Prior_Transfer_Date_))),COUNT(__d3(__NN(Prior_Transfer_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d3(__NL(Previous_Recording_Date_))),COUNT(__d3(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d3(__NL(Previous_Sale_Price_))),COUNT(__d3(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePriceCode',COUNT(__d3(__NL(Previous_Sale_Price_Code_))),COUNT(__d3(__NN(Previous_Sale_Price_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedLandValue',COUNT(__d3(__NL(Assessed_Land_Value_))),COUNT(__d3(__NN(Assessed_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedImprovementValue',COUNT(__d3(__NL(Assessed_Improvement_Value_))),COUNT(__d3(__NN(Assessed_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d3(__NL(Assessed_Total_Value_))),COUNT(__d3(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d3(__NL(Assessed_Value_Year_))),COUNT(__d3(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketLandValue',COUNT(__d3(__NL(Market_Land_Value_))),COUNT(__d3(__NN(Market_Land_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketImprovementValue',COUNT(__d3(__NL(Market_Improvement_Value_))),COUNT(__d3(__NN(Market_Improvement_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d3(__NL(Market_Total_Value_))),COUNT(__d3(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d3(__NL(Market_Value_Year_))),COUNT(__d3(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode1',COUNT(__d3(__NL(Tax_Exemption_Code1_))),COUNT(__d3(__NN(Tax_Exemption_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode2',COUNT(__d3(__NL(Tax_Exemption_Code2_))),COUNT(__d3(__NN(Tax_Exemption_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode3',COUNT(__d3(__NL(Tax_Exemption_Code3_))),COUNT(__d3(__NN(Tax_Exemption_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode4',COUNT(__d3(__NL(Tax_Exemption_Code4_))),COUNT(__d3(__NN(Tax_Exemption_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxRateCodeArea',COUNT(__d3(__NL(Tax_Rate_Code_Area_))),COUNT(__d3(__NN(Tax_Rate_Code_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAmount',COUNT(__d3(__NL(Tax_Amount_))),COUNT(__d3(__NN(Tax_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d3(__NL(Tax_Year_))),COUNT(__d3(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxDelinquentYear',COUNT(__d3(__NL(Tax_Delinquent_Year_))),COUNT(__d3(__NN(Tax_Delinquent_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict1',COUNT(__d3(__NL(School_Tax_District1_))),COUNT(__d3(__NN(School_Tax_District1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict2',COUNT(__d3(__NL(School_Tax_District2_))),COUNT(__d3(__NN(School_Tax_District2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict3',COUNT(__d3(__NL(School_Tax_District3_))),COUNT(__d3(__NN(School_Tax_District3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator1',COUNT(__d3(__NL(School_Tax_District_Indicator1_))),COUNT(__d3(__NN(School_Tax_District_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator2',COUNT(__d3(__NL(School_Tax_District_Indicator2_))),COUNT(__d3(__NN(School_Tax_District_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator3',COUNT(__d3(__NL(School_Tax_District_Indicator3_))),COUNT(__d3(__NN(School_Tax_District_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d3(__NL(Lot_Size_))),COUNT(__d3(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeAcres',COUNT(__d3(__NL(Lot_Size_Acres_))),COUNT(__d3(__NN(Lot_Size_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeFrontageFeet',COUNT(__d3(__NL(Lot_Size_Frontage_Feet_))),COUNT(__d3(__NN(Lot_Size_Frontage_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeDepthFeet',COUNT(__d3(__NL(Lot_Size_Depth_Feet_))),COUNT(__d3(__NN(Lot_Size_Depth_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandAcres',COUNT(__d3(__NL(Land_Acres_))),COUNT(__d3(__NN(Land_Acres_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d3(__NL(Land_Square_Footage_))),COUNT(__d3(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandDimensions',COUNT(__d3(__NL(Land_Dimensions_))),COUNT(__d3(__NN(Land_Dimensions_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d3(__NL(Building_Area_))),COUNT(__d3(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea1',COUNT(__d3(__NL(Building_Area1_))),COUNT(__d3(__NN(Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea2',COUNT(__d3(__NL(Building_Area2_))),COUNT(__d3(__NN(Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea3',COUNT(__d3(__NL(Building_Area3_))),COUNT(__d3(__NN(Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea4',COUNT(__d3(__NL(Building_Area4_))),COUNT(__d3(__NN(Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea5',COUNT(__d3(__NL(Building_Area5_))),COUNT(__d3(__NN(Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea6',COUNT(__d3(__NL(Building_Area6_))),COUNT(__d3(__NN(Building_Area6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea7',COUNT(__d3(__NL(Building_Area7_))),COUNT(__d3(__NN(Building_Area7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator',COUNT(__d3(__NL(Building_Area_Indicator_))),COUNT(__d3(__NN(Building_Area_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator1',COUNT(__d3(__NL(Building_Area_Indicator1_))),COUNT(__d3(__NN(Building_Area_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator2',COUNT(__d3(__NL(Building_Area_Indicator2_))),COUNT(__d3(__NN(Building_Area_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator3',COUNT(__d3(__NL(Building_Area_Indicator3_))),COUNT(__d3(__NN(Building_Area_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator4',COUNT(__d3(__NL(Building_Area_Indicator4_))),COUNT(__d3(__NN(Building_Area_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator5',COUNT(__d3(__NL(Building_Area_Indicator5_))),COUNT(__d3(__NN(Building_Area_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator6',COUNT(__d3(__NL(Building_Area_Indicator6_))),COUNT(__d3(__NN(Building_Area_Indicator6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator7',COUNT(__d3(__NL(Building_Area_Indicator7_))),COUNT(__d3(__NN(Building_Area_Indicator7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d3(__NL(Year_Built_))),COUNT(__d3(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d3(__NL(Effective_Year_Built_))),COUNT(__d3(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d3(__NL(Number_Of_Buildings_))),COUNT(__d3(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d3(__NL(Number_Of_Stories_))),COUNT(__d3(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d3(__NL(Number_Of_Units_))),COUNT(__d3(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d3(__NL(Number_Of_Rooms_))),COUNT(__d3(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d3(__NL(Number_Of_Bedrooms_))),COUNT(__d3(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d3(__NL(Number_Of_Baths_))),COUNT(__d3(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d3(__NL(Number_Of_Partial_Baths_))),COUNT(__d3(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPlumbingFixtures',COUNT(__d3(__NL(Number_Of_Plumbing_Fixtures_))),COUNT(__d3(__NN(Number_Of_Plumbing_Fixtures_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d3(__NL(Garage_Type_Code_))),COUNT(__d3(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d3(__NL(Parking_Number_Of_Cars_))),COUNT(__d3(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PoolCode',COUNT(__d3(__NL(Pool_Code_))),COUNT(__d3(__NN(Pool_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d3(__NL(Style_Code_))),COUNT(__d3(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeConstructionCode',COUNT(__d3(__NL(Type_Construction_Code_))),COUNT(__d3(__NN(Type_Construction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FoundationCode',COUNT(__d3(__NL(Foundation_Code_))),COUNT(__d3(__NN(Foundation_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingQualityCode',COUNT(__d3(__NL(Building_Quality_Code_))),COUNT(__d3(__NN(Building_Quality_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingConditionCode',COUNT(__d3(__NL(Building_Condition_Code_))),COUNT(__d3(__NN(Building_Condition_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExteriorWallsCode',COUNT(__d3(__NL(Exterior_Walls_Code_))),COUNT(__d3(__NN(Exterior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InteriorWallsCode',COUNT(__d3(__NL(Interior_Walls_Code_))),COUNT(__d3(__NN(Interior_Walls_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofCoverCode',COUNT(__d3(__NL(Roof_Cover_Code_))),COUNT(__d3(__NN(Roof_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofTypeCode',COUNT(__d3(__NL(Roof_Type_Code_))),COUNT(__d3(__NN(Roof_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FloorCoverCode',COUNT(__d3(__NL(Floor_Cover_Code_))),COUNT(__d3(__NN(Floor_Cover_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WaterCode',COUNT(__d3(__NL(Water_Code_))),COUNT(__d3(__NN(Water_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SewerCode',COUNT(__d3(__NL(Sewer_Code_))),COUNT(__d3(__NN(Sewer_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingCode',COUNT(__d3(__NL(Heating_Code_))),COUNT(__d3(__NN(Heating_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingFuelTypeCode',COUNT(__d3(__NL(Heating_Fuel_Type_Code_))),COUNT(__d3(__NN(Heating_Fuel_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningCode',COUNT(__d3(__NL(Air_Conditioning_Code_))),COUNT(__d3(__NN(Air_Conditioning_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningTypeCode',COUNT(__d3(__NL(Air_Conditioning_Type_Code_))),COUNT(__d3(__NN(Air_Conditioning_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Elevator',COUNT(__d3(__NL(Elevator_))),COUNT(__d3(__NN(Elevator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d3(__NL(Fireplace_Indicator_))),COUNT(__d3(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceNumber',COUNT(__d3(__NL(Fireplace_Number_))),COUNT(__d3(__NN(Fireplace_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BasementCode',COUNT(__d3(__NL(Basement_Code_))),COUNT(__d3(__NN(Basement_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingClassCode',COUNT(__d3(__NL(Building_Class_Code_))),COUNT(__d3(__NN(Building_Class_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode1',COUNT(__d3(__NL(Site_Influence_Code1_))),COUNT(__d3(__NN(Site_Influence_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode2',COUNT(__d3(__NL(Site_Influence_Code2_))),COUNT(__d3(__NN(Site_Influence_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode3',COUNT(__d3(__NL(Site_Influence_Code3_))),COUNT(__d3(__NN(Site_Influence_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode4',COUNT(__d3(__NL(Site_Influence_Code4_))),COUNT(__d3(__NN(Site_Influence_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode5',COUNT(__d3(__NL(Site_Influence_Code5_))),COUNT(__d3(__NN(Site_Influence_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode1',COUNT(__d3(__NL(Amenity_Code1_))),COUNT(__d3(__NN(Amenity_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode2',COUNT(__d3(__NL(Amenity_Code2_))),COUNT(__d3(__NN(Amenity_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode3',COUNT(__d3(__NL(Amenity_Code3_))),COUNT(__d3(__NN(Amenity_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode4',COUNT(__d3(__NL(Amenity_Code4_))),COUNT(__d3(__NN(Amenity_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode5',COUNT(__d3(__NL(Amenity_Code5_))),COUNT(__d3(__NN(Amenity_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode6',COUNT(__d3(__NL(Amenity_Code6_))),COUNT(__d3(__NN(Amenity_Code6_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode7',COUNT(__d3(__NL(Amenity_Code7_))),COUNT(__d3(__NN(Amenity_Code7_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode8',COUNT(__d3(__NL(Amenity_Code8_))),COUNT(__d3(__NN(Amenity_Code8_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode9',COUNT(__d3(__NL(Amenity_Code9_))),COUNT(__d3(__NN(Amenity_Code9_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode10',COUNT(__d3(__NL(Amenity_Code10_))),COUNT(__d3(__NN(Amenity_Code10_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea1',COUNT(__d3(__NL(Extra_Feature_Area1_))),COUNT(__d3(__NN(Extra_Feature_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea2',COUNT(__d3(__NL(Extra_Feature_Area2_))),COUNT(__d3(__NN(Extra_Feature_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea3',COUNT(__d3(__NL(Extra_Feature_Area3_))),COUNT(__d3(__NN(Extra_Feature_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea4',COUNT(__d3(__NL(Extra_Feature_Area4_))),COUNT(__d3(__NN(Extra_Feature_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator1',COUNT(__d3(__NL(Extra_Feature_Indicator1_))),COUNT(__d3(__NN(Extra_Feature_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator2',COUNT(__d3(__NL(Extra_Feature_Indicator2_))),COUNT(__d3(__NN(Extra_Feature_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator3',COUNT(__d3(__NL(Extra_Feature_Indicator3_))),COUNT(__d3(__NN(Extra_Feature_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator4',COUNT(__d3(__NL(Extra_Feature_Indicator4_))),COUNT(__d3(__NN(Extra_Feature_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode1',COUNT(__d3(__NL(Other_Building_Code1_))),COUNT(__d3(__NN(Other_Building_Code1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode2',COUNT(__d3(__NL(Other_Building_Code2_))),COUNT(__d3(__NN(Other_Building_Code2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode3',COUNT(__d3(__NL(Other_Building_Code3_))),COUNT(__d3(__NN(Other_Building_Code3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode4',COUNT(__d3(__NL(Other_Building_Code4_))),COUNT(__d3(__NN(Other_Building_Code4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode5',COUNT(__d3(__NL(Other_Building_Code5_))),COUNT(__d3(__NN(Other_Building_Code5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator1',COUNT(__d3(__NL(Other_Important_Building_Indicator1_))),COUNT(__d3(__NN(Other_Important_Building_Indicator1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator2',COUNT(__d3(__NL(Other_Important_Building_Indicator2_))),COUNT(__d3(__NN(Other_Important_Building_Indicator2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator3',COUNT(__d3(__NL(Other_Important_Building_Indicator3_))),COUNT(__d3(__NN(Other_Important_Building_Indicator3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator4',COUNT(__d3(__NL(Other_Important_Building_Indicator4_))),COUNT(__d3(__NN(Other_Important_Building_Indicator4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator5',COUNT(__d3(__NL(Other_Important_Building_Indicator5_))),COUNT(__d3(__NN(Other_Important_Building_Indicator5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea1',COUNT(__d3(__NL(Other_Important_Building_Area1_))),COUNT(__d3(__NN(Other_Important_Building_Area1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea2',COUNT(__d3(__NL(Other_Important_Building_Area2_))),COUNT(__d3(__NN(Other_Important_Building_Area2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea3',COUNT(__d3(__NL(Other_Important_Building_Area3_))),COUNT(__d3(__NN(Other_Important_Building_Area3_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea4',COUNT(__d3(__NL(Other_Important_Building_Area4_))),COUNT(__d3(__NN(Other_Important_Building_Area4_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea5',COUNT(__d3(__NL(Other_Important_Building_Area5_))),COUNT(__d3(__NN(Other_Important_Building_Area5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TopographyCode',COUNT(__d3(__NL(Topography_Code_))),COUNT(__d3(__NN(Topography_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodCode',COUNT(__d3(__NL(Neighborhood_Code_))),COUNT(__d3(__NN(Neighborhood_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoProjectOrBuildingName',COUNT(__d3(__NL(Condo_Project_Or_Building_Name_))),COUNT(__d3(__NN(Condo_Project_Or_Building_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssesseeNameIndicator',COUNT(__d3(__NL(Assessee_Name_Indicator_))),COUNT(__d3(__NN(Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondAssesseeNameIndicator',COUNT(__d3(__NL(Second_Assessee_Name_Indicator_))),COUNT(__d3(__NN(Second_Assessee_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherRoomsIndicator',COUNT(__d3(__NL(Other_Rooms_Indicator_))),COUNT(__d3(__NN(Other_Rooms_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailCareOfNameIndicator',COUNT(__d3(__NL(Mail_Care_Of_Name_Indicator_))),COUNT(__d3(__NN(Mail_Care_Of_Name_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Comments',COUNT(__d3(__NL(Comments_))),COUNT(__d3(__NN(Comments_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TapeCutDate',COUNT(__d3(__NL(Tape_Cut_Date_))),COUNT(__d3(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d3(__NL(Certification_Date_))),COUNT(__d3(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EditionNumber',COUNT(__d3(__NL(Edition_Number_))),COUNT(__d3(__NN(Edition_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressPropegatedIndicator',COUNT(__d3(__NL(Property_Address_Propegated_Indicator_))),COUNT(__d3(__NN(Property_Address_Propegated_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNOwnershipRights',COUNT(__d3(__NL(L_N_Ownership_Rights_))),COUNT(__d3(__NN(L_N_Ownership_Rights_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNRelationshipType',COUNT(__d3(__NL(L_N_Relationship_Type_))),COUNT(__d3(__NN(L_N_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMailingCountryCode',COUNT(__d3(__NL(L_N_Mailing_Country_Code_))),COUNT(__d3(__NN(L_N_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyName',COUNT(__d3(__NL(L_N_Property_Name_))),COUNT(__d3(__NN(L_N_Property_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyNameType',COUNT(__d3(__NL(L_N_Property_Name_Type_))),COUNT(__d3(__NN(L_N_Property_Name_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLandUseCategory',COUNT(__d3(__NL(L_N_Land_Use_Category_))),COUNT(__d3(__NN(L_N_Land_Use_Category_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNLotNumber',COUNT(__d3(__NL(L_N_Lot_Number_))),COUNT(__d3(__NN(L_N_Lot_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBlockNumber',COUNT(__d3(__NL(L_N_Block_Number_))),COUNT(__d3(__NN(L_N_Block_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNUnitNumber',COUNT(__d3(__NL(L_N_Unit_Number_))),COUNT(__d3(__NN(L_N_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSubfloor',COUNT(__d3(__NL(L_N_Subfloor_))),COUNT(__d3(__NN(L_N_Subfloor_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMobileHomeIndicator',COUNT(__d3(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d3(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCondoIndicator',COUNT(__d3(__NL(L_N_Condo_Indicator_))),COUNT(__d3(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyTaxExemptionIndicator',COUNT(__d3(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d3(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNVeteranStatus',COUNT(__d3(__NL(L_N_Veteran_Status_))),COUNT(__d3(__NN(L_N_Veteran_Status_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MultiAPNFlag',COUNT(__d3(__NL(Multi_A_P_N_Flag_))),COUNT(__d3(__NN(Multi_A_P_N_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxNumber',COUNT(__d3(__NL(Tax_Number_))),COUNT(__d3(__NN(Tax_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d3(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d3(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1',COUNT(__d3(__NL(Name1_))),COUNT(__d3(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1Code',COUNT(__d3(__NL(Name1_Code_))),COUNT(__d3(__NN(Name1_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2',COUNT(__d3(__NL(Name2_))),COUNT(__d3(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2Code',COUNT(__d3(__NL(Name2_Code_))),COUNT(__d3(__NN(Name2_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerVestingCode',COUNT(__d3(__NL(Buyer_Borrower_Vesting_Code_))),COUNT(__d3(__NN(Buyer_Borrower_Vesting_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerAddendumFlag',COUNT(__d3(__NL(Buyer_Borrower_Addendum_Flag_))),COUNT(__d3(__NN(Buyer_Borrower_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCareOf',COUNT(__d3(__NL(Mailing_Care_Of_))),COUNT(__d3(__NN(Mailing_Care_Of_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingStreet',COUNT(__d3(__NL(Mailing_Street_))),COUNT(__d3(__NN(Mailing_Street_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1',COUNT(__d3(__NL(Seller1_))),COUNT(__d3(__NN(Seller1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1IDCode',COUNT(__d3(__NL(Seller1_I_D_Code_))),COUNT(__d3(__NN(Seller1_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2',COUNT(__d3(__NL(Seller2_))),COUNT(__d3(__NN(Seller2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2IDCode',COUNT(__d3(__NL(Seller2_I_D_Code_))),COUNT(__d3(__NN(Seller2_I_D_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerAddendumFlag',COUNT(__d3(__NL(Seller_Addendum_Flag_))),COUNT(__d3(__NN(Seller_Addendum_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingFullStreetAddress',COUNT(__d3(__NL(Seller_Mailing_Full_Street_Address_))),COUNT(__d3(__NN(Seller_Mailing_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressUnitNumber',COUNT(__d3(__NL(Seller_Mailing_Address_Unit_Number_))),COUNT(__d3(__NN(Seller_Mailing_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerMailingAddressCityStateZip',COUNT(__d3(__NL(Seller_Mailing_Address_City_State_Zip_))),COUNT(__d3(__NN(Seller_Mailing_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCompleteDescriptionCode',COUNT(__d3(__NL(Legal_Complete_Description_Code_))),COUNT(__d3(__NN(Legal_Complete_Description_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d3(__NL(Contract_Date_))),COUNT(__d3(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateMortgageResetDate',COUNT(__d3(__NL(Adjustable_Rate_Mortgage_Reset_Date_))),COUNT(__d3(__NN(Adjustable_Rate_Mortgage_Reset_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanNumber',COUNT(__d3(__NL(Loan_Number_))),COUNT(__d3(__NN(Loan_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConcurrentMortgageBookPageDocumentNumber',COUNT(__d3(__NL(Concurrent_Mortgage_Book_Page_Document_Number_))),COUNT(__d3(__NN(Concurrent_Mortgage_Book_Page_Document_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CityTransferTax',COUNT(__d3(__NL(City_Transfer_Tax_))),COUNT(__d3(__NN(City_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyTransferTax',COUNT(__d3(__NL(County_Transfer_Tax_))),COUNT(__d3(__NN(County_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalTransferTax',COUNT(__d3(__NL(Total_Transfer_Tax_))),COUNT(__d3(__NN(Total_Transfer_Tax_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanAmount',COUNT(__d3(__NL(Primary_Loan_Amount_))),COUNT(__d3(__NN(Primary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanAmount',COUNT(__d3(__NL(Secondary_Loan_Amount_))),COUNT(__d3(__NN(Secondary_Loan_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanLenderTypeCode',COUNT(__d3(__NL(Primary_Loan_Lender_Type_Code_))),COUNT(__d3(__NN(Primary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanLenderTypeCode',COUNT(__d3(__NL(Secondary_Loan_Lender_Type_Code_))),COUNT(__d3(__NN(Secondary_Loan_Lender_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanTypeCode',COUNT(__d3(__NL(Primary_Loan_Type_Code_))),COUNT(__d3(__NN(Primary_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeFinancing',COUNT(__d3(__NL(Type_Financing_))),COUNT(__d3(__NN(Type_Financing_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanInterestRate',COUNT(__d3(__NL(Primary_Loan_Interest_Rate_))),COUNT(__d3(__NN(Primary_Loan_Interest_Rate_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanDueDate',COUNT(__d3(__NL(Primary_Loan_Due_Date_))),COUNT(__d3(__NN(Primary_Loan_Due_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleCompanyName',COUNT(__d3(__NL(Title_Company_Name_))),COUNT(__d3(__NN(Title_Company_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartialInterestTransferred',COUNT(__d3(__NL(Partial_Interest_Transferred_))),COUNT(__d3(__NN(Partial_Interest_Transferred_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermMonths',COUNT(__d3(__NL(Loan_Term_Months_))),COUNT(__d3(__NN(Loan_Term_Months_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermYears',COUNT(__d3(__NL(Loan_Term_Years_))),COUNT(__d3(__NN(Loan_Term_Years_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderName',COUNT(__d3(__NL(Lender_Name_))),COUNT(__d3(__NN(Lender_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderDBAName',COUNT(__d3(__NL(Lender_D_B_A_Name_))),COUNT(__d3(__NN(Lender_D_B_A_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderFullStreetAddress',COUNT(__d3(__NL(Lender_Full_Street_Address_))),COUNT(__d3(__NN(Lender_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressUnitNumber',COUNT(__d3(__NL(Lender_Address_Unit_Number_))),COUNT(__d3(__NN(Lender_Address_Unit_Number_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderAddressCityStateZip',COUNT(__d3(__NL(Lender_Address_City_State_Zip_))),COUNT(__d3(__NN(Lender_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyUseCode',COUNT(__d3(__NL(Property_Use_Code_))),COUNT(__d3(__NN(Property_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoCode',COUNT(__d3(__NL(Condo_Code_))),COUNT(__d3(__NN(Condo_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareFlag',COUNT(__d3(__NL(Timeshare_Flag_))),COUNT(__d3(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandLotSize',COUNT(__d3(__NL(Land_Lot_Size_))),COUNT(__d3(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RateChangeFrequency',COUNT(__d3(__NL(Rate_Change_Frequency_))),COUNT(__d3(__NN(Rate_Change_Frequency_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ChangeIndex',COUNT(__d3(__NL(Change_Index_))),COUNT(__d3(__NN(Change_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateIndex',COUNT(__d3(__NL(Adjustable_Rate_Index_))),COUNT(__d3(__NN(Adjustable_Rate_Index_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateRider',COUNT(__d3(__NL(Adjustable_Rate_Rider_))),COUNT(__d3(__NN(Adjustable_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GraduatedPaymentRider',COUNT(__d3(__NL(Graduated_Payment_Rider_))),COUNT(__d3(__NN(Graduated_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BalloonRider',COUNT(__d3(__NL(Balloon_Rider_))),COUNT(__d3(__NN(Balloon_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FixedStepRateRider',COUNT(__d3(__NL(Fixed_Step_Rate_Rider_))),COUNT(__d3(__NN(Fixed_Step_Rate_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondominiumRider',COUNT(__d3(__NL(Condominium_Rider_))),COUNT(__d3(__NN(Condominium_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PlannedUnitDevelopmentRider',COUNT(__d3(__NL(Planned_Unit_Development_Rider_))),COUNT(__d3(__NN(Planned_Unit_Development_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssumabilityRider',COUNT(__d3(__NL(Assumability_Rider_))),COUNT(__d3(__NN(Assumability_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrepaymentRider',COUNT(__d3(__NL(Prepayment_Rider_))),COUNT(__d3(__NN(Prepayment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OneFourFamilyRider',COUNT(__d3(__NL(One_Four_Family_Rider_))),COUNT(__d3(__NN(One_Four_Family_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BiweeklyPaymentRider',COUNT(__d3(__NL(Biweekly_Payment_Rider_))),COUNT(__d3(__NN(Biweekly_Payment_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondHomeRider',COUNT(__d3(__NL(Second_Home_Rider_))),COUNT(__d3(__NN(Second_Home_Rider_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSourceCode',COUNT(__d3(__NL(Data_Source_Code_))),COUNT(__d3(__NN(Data_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeOfDeedCode',COUNT(__d3(__NL(Type_Of_Deed_Code_))),COUNT(__d3(__NN(Type_Of_Deed_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalNameFlag',COUNT(__d3(__NL(Additional_Name_Flag_))),COUNT(__d3(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNBuyerMailingCountryCode',COUNT(__d3(__NL(L_N_Buyer_Mailing_Country_Code_))),COUNT(__d3(__NN(L_N_Buyer_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNSellerMailingCountryCode',COUNT(__d3(__NL(L_N_Seller_Mailing_Country_Code_))),COUNT(__d3(__NN(L_N_Seller_Mailing_Country_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerEtAlIndicator',COUNT(__d3(__NL(Fares_Owner_Et_Al_Indicator_))),COUNT(__d3(__NN(Fares_Owner_Et_Al_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipCode',COUNT(__d3(__NL(Fares_Owner_Relationship_Code_))),COUNT(__d3(__NN(Fares_Owner_Relationship_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresOwnerRelationshipType',COUNT(__d3(__NL(Fares_Owner_Relationship_Type_))),COUNT(__d3(__NN(Fares_Owner_Relationship_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMatchCode',COUNT(__d3(__NL(Fares_Match_Code_))),COUNT(__d3(__NN(Fares_Match_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresDocumentYear',COUNT(__d3(__NL(Fares_Document_Year_))),COUNT(__d3(__NN(Fares_Document_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCorporateIndicator',COUNT(__d3(__NL(Fares_Corporate_Indicator_))),COUNT(__d3(__NN(Fares_Corporate_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresTransactionType',COUNT(__d3(__NL(Fares_Transaction_Type_))),COUNT(__d3(__NN(Fares_Transaction_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresLenderAddress',COUNT(__d3(__NL(Fares_Lender_Address_))),COUNT(__d3(__NN(Fares_Lender_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSalesTransactionCode',COUNT(__d3(__NL(Fares_Sales_Transaction_Code_))),COUNT(__d3(__NN(Fares_Sales_Transaction_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResidentialModelInd',COUNT(__d3(__NL(Fares_Residential_Model_Ind_))),COUNT(__d3(__NN(Fares_Residential_Model_Ind_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageDeedType',COUNT(__d3(__NL(Fares_Mortgage_Deed_Type_))),COUNT(__d3(__NN(Fares_Mortgage_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTermCode',COUNT(__d3(__NL(Fares_Mortgage_Term_Code_))),COUNT(__d3(__NN(Fares_Mortgage_Term_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageTerm',COUNT(__d3(__NL(Fares_Mortgage_Term_))),COUNT(__d3(__NN(Fares_Mortgage_Term_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresMortgageAssumptionAmount',COUNT(__d3(__NL(Fares_Mortgage_Assumption_Amount_))),COUNT(__d3(__NN(Fares_Mortgage_Assumption_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondMortgageLoanTypeCode',COUNT(__d3(__NL(Fares_Second_Mortgage_Loan_Type_Code_))),COUNT(__d3(__NN(Fares_Second_Mortgage_Loan_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresSecondDeedType',COUNT(__d3(__NL(Fares_Second_Deed_Type_))),COUNT(__d3(__NN(Fares_Second_Deed_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresAbsenteeIndicator',COUNT(__d3(__NL(Fares_Absentee_Indicator_))),COUNT(__d3(__NN(Fares_Absentee_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPartialInterestIndicator',COUNT(__d3(__NL(Fares_Partial_Interest_Indicator_))),COUNT(__d3(__NN(Fares_Partial_Interest_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrimaryCategoryCode',COUNT(__d3(__NL(Fares_Primary_Category_Code_))),COUNT(__d3(__NN(Fares_Primary_Category_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresPrivatePartyLender',COUNT(__d3(__NL(Fares_Private_Party_Lender_))),COUNT(__d3(__NN(Fares_Private_Party_Lender_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresConstructionLoan',COUNT(__d3(__NL(Fares_Construction_Loan_))),COUNT(__d3(__NN(Fares_Construction_Loan_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresResaleNewConstruction',COUNT(__d3(__NL(Fares_Resale_New_Construction_))),COUNT(__d3(__NN(Fares_Resale_New_Construction_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresInterFamily',COUNT(__d3(__NL(Fares_Inter_Family_))),COUNT(__d3(__NN(Fares_Inter_Family_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresCashMortgagePurchase',COUNT(__d3(__NL(Fares_Cash_Mortgage_Purchase_))),COUNT(__d3(__NN(Fares_Cash_Mortgage_Purchase_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresBuildingSquareFeet',COUNT(__d3(__NL(Fares_Building_Square_Feet_))),COUNT(__d3(__NN(Fares_Building_Square_Feet_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresForeclosure',COUNT(__d3(__NL(Fares_Foreclosure_))),COUNT(__d3(__NN(Fares_Foreclosure_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresRefincanceFlag',COUNT(__d3(__NL(Fares_Refincance_Flag_))),COUNT(__d3(__NN(Fares_Refincance_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresEquityFlag',COUNT(__d3(__NL(Fares_Equity_Flag_))),COUNT(__d3(__NN(Fares_Equity_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FaresIrisAPN',COUNT(__d3(__NL(Fares_Iris_A_P_N_))),COUNT(__d3(__NN(Fares_Iris_A_P_N_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
