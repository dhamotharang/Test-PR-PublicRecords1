//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Property(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
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
    KEL.typ.nint Building_Area_Counter_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nstr Building_Area_Indicator_;
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
    KEL.typ.nint Site_Influence_Counter_;
    KEL.typ.nstr Site_Influence_Code_;
    KEL.typ.nint Amenity_Counter_;
    KEL.typ.nstr Amenity_Code_;
    KEL.typ.nint Extra_Feature_Counter_;
    KEL.typ.nstr Extra_Feature_Area_;
    KEL.typ.nstr Extra_Feature_Indicator_;
    KEL.typ.nint Other_Building_Counter_;
    KEL.typ.nstr Other_Building_Code_;
    KEL.typ.nint Other_Important_Building_Counter_;
    KEL.typ.nstr Other_Important_Building_Indicator_;
    KEL.typ.nstr Other_Important_Building_Area_;
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
    KEL.typ.nint Tax_Exemption_Code_Counter_;
    KEL.typ.nstr Tax_Exemption_Code_;
    KEL.typ.nfloat Tax_Amount_;
    KEL.typ.nint Tax_Year_;
    KEL.typ.nint Tax_Delinquent_Year_;
    KEL.typ.nint School_Tax_District_Counter_;
    KEL.typ.nstr School_Tax_District_;
    KEL.typ.nstr School_Tax_District_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),lnfaresid(Ln_Fares_Id_),haslnowner(Has_L_N_Owner_:0),hasowner(Has_Owner_:0),hasnofaresowner(Has_No_Fares_Owner_:0),oldapn(Old_A_P_N_:\'\'),apnorpinnumber(Apn_Or_Pin_Number_:\'\'),taxidnumber(Tax_I_D_Number_:\'\'),excisetaxnumber(Excise_Tax_Number_:\'\'),applicantowned(Applicant_Owned_),occupantowned(Occupant_Owned_),applicantsold(Applicant_Sold_),duplicateapnwithdifferentaddresscounter(Duplicate_Apn_With_Different_Address_Counter_:0),isassessment(Is_Assessment_),isdeed(Is_Deed_),purchasedate(Purchase_Date_:DATE),purchaseamount(Purchase_Amount_:0.0),previouspurchaseprice1(Previous_Purchase_Price1_:0),previouspurchaseprice2(Previous_Purchase_Price2_:0),previouspurchasedate1(Previous_Purchase_Date1_:DATE),previouspurchasedate2(Previous_Purchase_Date2_:DATE),saleprice(Sale_Price_:0),salepricecode(Sale_Price_Code_:\'\'),previoussaleprice(Previous_Sale_Price_:0),previoussalepricecode(Previous_Sale_Price_Code_:\'\'),saleprice1(Sale_Price1_:0),saleprice2(Sale_Price2_:0),saledate1(Sale_Date1_:DATE),saledate2(Sale_Date2_:DATE),yearbuilt(Year_Built_:0),effectiveyearbuilt(Effective_Year_Built_:0),currentrecord(Current_Record_:\'\'),mortgageamount(Mortgage_Amount_:0.0),mortgagedate(Mortgage_Date_:DATE),mortgagetype(Mortgage_Type_:\'\'),typefinancing(Type_Financing_:\'\'),primaryloanduedate(Primary_Loan_Due_Date_:DATE),primaryloanamount(Primary_Loan_Amount_:0),secondaryloanamount(Secondary_Loan_Amount_:0),primaryloanlendertypecode(Primary_Loan_Lender_Type_Code_:\'\'),secondaryloanlendertypecode(Secondary_Loan_Lender_Type_Code_:\'\'),primaryloantypecode(Primary_Loan_Type_Code_:\'\'),primaryloaninterestrate(Primary_Loan_Interest_Rate_:0.0),ownershipmethodcode(Ownership_Method_Code_:\'\'),ownershiptypecode(Ownership_Type_Code_:\'\'),ownersrelationshipcode(Owners_Relationship_Code_:\'\'),multiapnflag(Multi_Apn_Flag_:\'\'),contractdate(Contract_Date_:DATE),adjustableratemortgageresetdate(Adjustable_Rate_Mortgage_Reset_Date_:DATE),ratechangefrequency(Rate_Change_Frequency_:\'\'),changeindex(Change_Index_:0.0),adjustablerateindex(Adjustable_Rate_Index_:0),adjustableraterider(Adjustable_Rate_Rider_:0),fixedstepraterider(Fixed_Step_Rate_Rider_:0),condominiumrider(Condominium_Rider_:\'\'),plannedunitdevelopmentrider(Planned_Unit_Development_Rider_:\'\'),assumabilityrider(Assumability_Rider_:\'\'),onefourfamilyrider(One_Four_Family_Rider_:\'\'),secondhomerider(Second_Home_Rider_:\'\'),typeofdeedcode(Type_Of_Deed_Code_:\'\'),loannumber(Loan_Number_:\'\'),partialinteresttransferred(Partial_Interest_Transferred_:0),loantermmonths(Loan_Term_Months_:0),loantermyears(Loan_Term_Years_:0),lenderidcode(Lender_Id_Code_:\'\'),buyerorborrowerorassessee(Buyer_Or_Borrower_Or_Assessee_:\'\'),name1idcode(Name1_Id_Code_:\'\'),name2idcode(Name2_Id_Code_:\'\'),buyerborrowervestingcode(Buyer_Borrower_Vesting_Code_:\'\'),buyerborroweraddendumflag(Buyer_Borrower_Addendum_Flag_:0),seller1idcode(Seller1_Id_Code_:\'\'),seller2idcode(Seller2_Id_Code_:\'\'),selleraddendumflag(Seller_Addendum_Flag_:0),assessedamount(Assessed_Amount_:0.0),assessedlandvalue(Assessed_Land_Value_:0),assessedimprovementvalue(Assessed_Improvement_Value_:0),assessedtotalvalue(Assessed_Total_Value_:0.0),assessedvalueyear(Assessed_Value_Year_:0),marketlandvalue(Market_Land_Value_:0),marketimprovementvalue(Market_Improvement_Value_:0),markettotalvalue(Market_Total_Value_:0.0),marketvalueyear(Market_Value_Year_:0),standardizedlandusecode(Standardized_Land_Use_Code_:0),propertyusecode(Property_Use_Code_:\'\'),statelandusecode(State_Land_Use_Code_:\'\'),countylandusecode(County_Land_Use_Code_:\'\'),countylandusedescription(County_Land_Use_Description_:\'\'),timesharecode(Timeshare_Code_:\'\'),zoning(Zoning_:\'\'),condocode(Condo_Code_:\'\'),buildingareacounter(Building_Area_Counter_:0),buildingarea(Building_Area_:0),buildingareaindicator(Building_Area_Indicator_:\'\'),numberofbuildings(Number_Of_Buildings_:0),numberofstories(Number_Of_Stories_:0),numberofunits(Number_Of_Units_:0),numberofrooms(Number_Of_Rooms_:0),numberofbedrooms(Number_Of_Bedrooms_:0),numberofbaths(Number_Of_Baths_:0),numberofpartialbaths(Number_Of_Partial_Baths_:0),numberofplumbingfixtures(Number_Of_Plumbing_Fixtures_:0),garagetypecode(Garage_Type_Code_:\'\'),parkingnumberofcars(Parking_Number_Of_Cars_:0),poolcode(Pool_Code_:\'\'),stylecode(Style_Code_:\'\'),typeconstructioncode(Type_Construction_Code_:\'\'),foundationcode(Foundation_Code_:\'\'),buildingqualitycode(Building_Quality_Code_:\'\'),buildingconditioncode(Building_Condition_Code_:\'\'),exteriorwallscode(Exterior_Walls_Code_:\'\'),interiorwallscode(Interior_Walls_Code_:\'\'),roofcovercode(Roof_Cover_Code_:\'\'),rooftypecode(Roof_Type_Code_:\'\'),floorcovercode(Floor_Cover_Code_:\'\'),watercode(Water_Code_:\'\'),sewercode(Sewer_Code_:\'\'),heatingcode(Heating_Code_:\'\'),heatingfueltypecode(Heating_Fuel_Type_Code_:\'\'),airconditioningcode(Air_Conditioning_Code_:\'\'),airconditioningtypecode(Air_Conditioning_Type_Code_:\'\'),elevator(Elevator_:\'\'),fireplaceindicator(Fireplace_Indicator_:\'\'),fireplacenumber(Fireplace_Number_:0),basementcode(Basement_Code_:\'\'),buildingclasscode(Building_Class_Code_:\'\'),siteinfluencecounter(Site_Influence_Counter_:0),siteinfluencecode(Site_Influence_Code_:\'\'),amenitycounter(Amenity_Counter_:0),amenitycode(Amenity_Code_:\'\'),extrafeaturecounter(Extra_Feature_Counter_:0),extrafeaturearea(Extra_Feature_Area_:\'\'),extrafeatureindicator(Extra_Feature_Indicator_:\'\'),otherbuildingcounter(Other_Building_Counter_:0),otherbuildingcode(Other_Building_Code_:\'\'),otherimportantbuildingcounter(Other_Important_Building_Counter_:0),otherimportantbuildingindicator(Other_Important_Building_Indicator_:\'\'),otherimportantbuildingarea(Other_Important_Building_Area_:\'\'),topograpycode(Topograpy_Code_:\'\'),neighborhoodcode(Neighborhood_Code_:\'\'),condoprojectorbuildingname(Condo_Project_Or_Building_Name_:\'\'),otherroomsindicator(Other_Rooms_Indicator_:\'\'),comments(Comments_:\'\'),certificationdate(Certification_Date_:DATE),hawaiitransfercertificateoftitle(Hawaii_Transfer_Certificate_Of_Title_:\'\'),lotsize(Lot_Size_:0),lotsizeacres(Lot_Size_Acres_:0.0),lotsizefrontagefeet(Lot_Size_Frontage_Feet_:0.0),lotsizedepthfeet(Lot_Size_Depth_Feet_:0.0),landacres(Land_Acres_:\'\'),landsquarefootage(Land_Square_Footage_:\'\'),landdimensions(Land_Dimensions_:\'\'),legallotcode(Legal_Lot_Code_:\'\'),legallotnumber(Legal_Lot_Number_:0),legalblock(Legal_Block_:\'\'),legalsection(Legal_Section_:\'\'),legaldistrict(Legal_District_:\'\'),legallandlot(Legal_Land_Lot_:\'\'),legalunit(Legal_Unit_:\'\'),legalcitymunicipalitytownship(Legal_City_Municipality_Township_:\'\'),legalsubdivisionname(Legal_Subdivision_Name_:\'\'),legalphasenumber(Legal_Phase_Number_:\'\'),legaltractnumber(Legal_Tract_Number_:\'\'),legalsectiontownshiprangemeridian(Legal_Section_Township_Range_Meridian_:\'\'),legalbriefdescription(Legal_Brief_Description_:\'\'),legalcompletedescriptioncode(Legal_Complete_Description_Code_:\'\'),censustract(Census_Tract_:0.0),mapreference(Map_Reference_:\'\'),recordingdate(Recording_Date_:DATE),documentnumber(Document_Number_:0),documenttypecode(Document_Type_Code_:\'\'),recorderbooknumber(Recorder_Book_Number_:0),recorderpagenumber(Recorder_Page_Number_:0),concurrentmortgagebookpagedocumentnumber(Concurrent_Mortgage_Book_Page_Document_Number_:\'\'),transferdate(Transfer_Date_:DATE),previousrecordingdate(Previous_Recording_Date_:DATE),citytransfertax(City_Transfer_Tax_:0.0),countytransfertax(County_Transfer_Tax_:0.0),totaltransfertax(Total_Transfer_Tax_:0.0),homesteadhomeownerexemption(Homestead_Home_Owner_Exemption_:\'\'),taxratecodearea(Tax_Rate_Code_Area_:\'\'),taxexemptioncodecounter(Tax_Exemption_Code_Counter_:0),taxexemptioncode(Tax_Exemption_Code_:\'\'),taxamount(Tax_Amount_:0.0),taxyear(Tax_Year_:0),taxdelinquentyear(Tax_Delinquent_Year_:0),schooltaxdistrictcounter(School_Tax_District_Counter_:0),schooltaxdistrict(School_Tax_District_:\'\'),schooltaxdistrictindicator(School_Tax_District_Indicator_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.LnFaresId)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.LnFaresId) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Tax_Exemption_Layout := RECORD
    KEL.typ.nint Tax_Exemption_Code_Counter_;
    KEL.typ.nstr Tax_Exemption_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT School_Tax_Districts_Layout := RECORD
    KEL.typ.nint School_Tax_District_Counter_;
    KEL.typ.nstr School_Tax_District_;
    KEL.typ.nstr School_Tax_District_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Building_Areas_Layout := RECORD
    KEL.typ.nint Building_Area_Counter_;
    KEL.typ.nint Building_Area_;
    KEL.typ.nstr Building_Area_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Site_Influences_Layout := RECORD
    KEL.typ.nint Site_Influence_Counter_;
    KEL.typ.nstr Site_Influence_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Amenity_Details_Layout := RECORD
    KEL.typ.nint Amenity_Counter_;
    KEL.typ.nstr Amenity_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Extra_Features_Layout := RECORD
    KEL.typ.nint Extra_Feature_Counter_;
    KEL.typ.nstr Extra_Feature_Area_;
    KEL.typ.nstr Extra_Feature_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Other_Buildings_Layout := RECORD
    KEL.typ.nint Other_Building_Counter_;
    KEL.typ.nstr Other_Building_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Other_Important_Buildings_Layout := RECORD
    KEL.typ.nint Other_Important_Building_Counter_;
    KEL.typ.nstr Other_Important_Building_Indicator_;
    KEL.typ.nstr Other_Important_Building_Area_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.ndataset(Tax_Exemption_Layout) Tax_Exemption_;
    KEL.typ.ndataset(School_Tax_Districts_Layout) School_Tax_Districts_;
    KEL.typ.ndataset(Building_Areas_Layout) Building_Areas_;
    KEL.typ.ndataset(Site_Influences_Layout) Site_Influences_;
    KEL.typ.ndataset(Amenity_Details_Layout) Amenity_Details_;
    KEL.typ.ndataset(Extra_Features_Layout) Extra_Features_;
    KEL.typ.ndataset(Other_Buildings_Layout) Other_Buildings_;
    KEL.typ.ndataset(Other_Important_Buildings_Layout) Other_Important_Buildings_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Property_Group := __PostFilter;
  Layout Property__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ln_Fares_Id_ := KEL.Intake.SingleValue(__recs,Ln_Fares_Id_);
    SELF.Has_L_N_Owner_ := KEL.Intake.SingleValue(__recs,Has_L_N_Owner_);
    SELF.Has_Owner_ := KEL.Intake.SingleValue(__recs,Has_Owner_);
    SELF.Has_No_Fares_Owner_ := KEL.Intake.SingleValue(__recs,Has_No_Fares_Owner_);
    SELF.Old_A_P_N_ := KEL.Intake.SingleValue(__recs,Old_A_P_N_);
    SELF.Apn_Or_Pin_Number_ := KEL.Intake.SingleValue(__recs,Apn_Or_Pin_Number_);
    SELF.Tax_I_D_Number_ := KEL.Intake.SingleValue(__recs,Tax_I_D_Number_);
    SELF.Excise_Tax_Number_ := KEL.Intake.SingleValue(__recs,Excise_Tax_Number_);
    SELF.Applicant_Owned_ := KEL.Intake.SingleValue(__recs,Applicant_Owned_);
    SELF.Occupant_Owned_ := KEL.Intake.SingleValue(__recs,Occupant_Owned_);
    SELF.Applicant_Sold_ := KEL.Intake.SingleValue(__recs,Applicant_Sold_);
    SELF.Duplicate_Apn_With_Different_Address_Counter_ := KEL.Intake.SingleValue(__recs,Duplicate_Apn_With_Different_Address_Counter_);
    SELF.Is_Assessment_ := KEL.Intake.SingleValue(__recs,Is_Assessment_);
    SELF.Is_Deed_ := KEL.Intake.SingleValue(__recs,Is_Deed_);
    SELF.Purchase_Date_ := KEL.Intake.SingleValue(__recs,Purchase_Date_);
    SELF.Purchase_Amount_ := KEL.Intake.SingleValue(__recs,Purchase_Amount_);
    SELF.Previous_Purchase_Price1_ := KEL.Intake.SingleValue(__recs,Previous_Purchase_Price1_);
    SELF.Previous_Purchase_Price2_ := KEL.Intake.SingleValue(__recs,Previous_Purchase_Price2_);
    SELF.Previous_Purchase_Date1_ := KEL.Intake.SingleValue(__recs,Previous_Purchase_Date1_);
    SELF.Previous_Purchase_Date2_ := KEL.Intake.SingleValue(__recs,Previous_Purchase_Date2_);
    SELF.Sale_Price_ := KEL.Intake.SingleValue(__recs,Sale_Price_);
    SELF.Sale_Price_Code_ := KEL.Intake.SingleValue(__recs,Sale_Price_Code_);
    SELF.Previous_Sale_Price_ := KEL.Intake.SingleValue(__recs,Previous_Sale_Price_);
    SELF.Previous_Sale_Price_Code_ := KEL.Intake.SingleValue(__recs,Previous_Sale_Price_Code_);
    SELF.Sale_Price1_ := KEL.Intake.SingleValue(__recs,Sale_Price1_);
    SELF.Sale_Price2_ := KEL.Intake.SingleValue(__recs,Sale_Price2_);
    SELF.Sale_Date1_ := KEL.Intake.SingleValue(__recs,Sale_Date1_);
    SELF.Sale_Date2_ := KEL.Intake.SingleValue(__recs,Sale_Date2_);
    SELF.Year_Built_ := KEL.Intake.SingleValue(__recs,Year_Built_);
    SELF.Effective_Year_Built_ := KEL.Intake.SingleValue(__recs,Effective_Year_Built_);
    SELF.Current_Record_ := KEL.Intake.SingleValue(__recs,Current_Record_);
    SELF.Mortgage_Amount_ := KEL.Intake.SingleValue(__recs,Mortgage_Amount_);
    SELF.Mortgage_Date_ := KEL.Intake.SingleValue(__recs,Mortgage_Date_);
    SELF.Mortgage_Type_ := KEL.Intake.SingleValue(__recs,Mortgage_Type_);
    SELF.Type_Financing_ := KEL.Intake.SingleValue(__recs,Type_Financing_);
    SELF.Primary_Loan_Due_Date_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Due_Date_);
    SELF.Primary_Loan_Amount_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Amount_);
    SELF.Secondary_Loan_Amount_ := KEL.Intake.SingleValue(__recs,Secondary_Loan_Amount_);
    SELF.Primary_Loan_Lender_Type_Code_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Lender_Type_Code_);
    SELF.Secondary_Loan_Lender_Type_Code_ := KEL.Intake.SingleValue(__recs,Secondary_Loan_Lender_Type_Code_);
    SELF.Primary_Loan_Type_Code_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Type_Code_);
    SELF.Primary_Loan_Interest_Rate_ := KEL.Intake.SingleValue(__recs,Primary_Loan_Interest_Rate_);
    SELF.Ownership_Method_Code_ := KEL.Intake.SingleValue(__recs,Ownership_Method_Code_);
    SELF.Ownership_Type_Code_ := KEL.Intake.SingleValue(__recs,Ownership_Type_Code_);
    SELF.Owners_Relationship_Code_ := KEL.Intake.SingleValue(__recs,Owners_Relationship_Code_);
    SELF.Multi_Apn_Flag_ := KEL.Intake.SingleValue(__recs,Multi_Apn_Flag_);
    SELF.Contract_Date_ := KEL.Intake.SingleValue(__recs,Contract_Date_);
    SELF.Adjustable_Rate_Mortgage_Reset_Date_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Mortgage_Reset_Date_);
    SELF.Rate_Change_Frequency_ := KEL.Intake.SingleValue(__recs,Rate_Change_Frequency_);
    SELF.Change_Index_ := KEL.Intake.SingleValue(__recs,Change_Index_);
    SELF.Adjustable_Rate_Index_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Index_);
    SELF.Adjustable_Rate_Rider_ := KEL.Intake.SingleValue(__recs,Adjustable_Rate_Rider_);
    SELF.Fixed_Step_Rate_Rider_ := KEL.Intake.SingleValue(__recs,Fixed_Step_Rate_Rider_);
    SELF.Condominium_Rider_ := KEL.Intake.SingleValue(__recs,Condominium_Rider_);
    SELF.Planned_Unit_Development_Rider_ := KEL.Intake.SingleValue(__recs,Planned_Unit_Development_Rider_);
    SELF.Assumability_Rider_ := KEL.Intake.SingleValue(__recs,Assumability_Rider_);
    SELF.One_Four_Family_Rider_ := KEL.Intake.SingleValue(__recs,One_Four_Family_Rider_);
    SELF.Second_Home_Rider_ := KEL.Intake.SingleValue(__recs,Second_Home_Rider_);
    SELF.Type_Of_Deed_Code_ := KEL.Intake.SingleValue(__recs,Type_Of_Deed_Code_);
    SELF.Loan_Number_ := KEL.Intake.SingleValue(__recs,Loan_Number_);
    SELF.Partial_Interest_Transferred_ := KEL.Intake.SingleValue(__recs,Partial_Interest_Transferred_);
    SELF.Loan_Term_Months_ := KEL.Intake.SingleValue(__recs,Loan_Term_Months_);
    SELF.Loan_Term_Years_ := KEL.Intake.SingleValue(__recs,Loan_Term_Years_);
    SELF.Lender_Id_Code_ := KEL.Intake.SingleValue(__recs,Lender_Id_Code_);
    SELF.Buyer_Or_Borrower_Or_Assessee_ := KEL.Intake.SingleValue(__recs,Buyer_Or_Borrower_Or_Assessee_);
    SELF.Name1_Id_Code_ := KEL.Intake.SingleValue(__recs,Name1_Id_Code_);
    SELF.Name2_Id_Code_ := KEL.Intake.SingleValue(__recs,Name2_Id_Code_);
    SELF.Buyer_Borrower_Vesting_Code_ := KEL.Intake.SingleValue(__recs,Buyer_Borrower_Vesting_Code_);
    SELF.Buyer_Borrower_Addendum_Flag_ := KEL.Intake.SingleValue(__recs,Buyer_Borrower_Addendum_Flag_);
    SELF.Seller1_Id_Code_ := KEL.Intake.SingleValue(__recs,Seller1_Id_Code_);
    SELF.Seller2_Id_Code_ := KEL.Intake.SingleValue(__recs,Seller2_Id_Code_);
    SELF.Seller_Addendum_Flag_ := KEL.Intake.SingleValue(__recs,Seller_Addendum_Flag_);
    SELF.Assessed_Amount_ := KEL.Intake.SingleValue(__recs,Assessed_Amount_);
    SELF.Assessed_Land_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Land_Value_);
    SELF.Assessed_Improvement_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Improvement_Value_);
    SELF.Assessed_Total_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Total_Value_);
    SELF.Assessed_Value_Year_ := KEL.Intake.SingleValue(__recs,Assessed_Value_Year_);
    SELF.Market_Land_Value_ := KEL.Intake.SingleValue(__recs,Market_Land_Value_);
    SELF.Market_Improvement_Value_ := KEL.Intake.SingleValue(__recs,Market_Improvement_Value_);
    SELF.Market_Total_Value_ := KEL.Intake.SingleValue(__recs,Market_Total_Value_);
    SELF.Market_Value_Year_ := KEL.Intake.SingleValue(__recs,Market_Value_Year_);
    SELF.Standardized_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,Standardized_Land_Use_Code_);
    SELF.Property_Use_Code_ := KEL.Intake.SingleValue(__recs,Property_Use_Code_);
    SELF.State_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,State_Land_Use_Code_);
    SELF.County_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,County_Land_Use_Code_);
    SELF.County_Land_Use_Description_ := KEL.Intake.SingleValue(__recs,County_Land_Use_Description_);
    SELF.Timeshare_Code_ := KEL.Intake.SingleValue(__recs,Timeshare_Code_);
    SELF.Zoning_ := KEL.Intake.SingleValue(__recs,Zoning_);
    SELF.Condo_Code_ := KEL.Intake.SingleValue(__recs,Condo_Code_);
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
    SELF.Topograpy_Code_ := KEL.Intake.SingleValue(__recs,Topograpy_Code_);
    SELF.Neighborhood_Code_ := KEL.Intake.SingleValue(__recs,Neighborhood_Code_);
    SELF.Condo_Project_Or_Building_Name_ := KEL.Intake.SingleValue(__recs,Condo_Project_Or_Building_Name_);
    SELF.Other_Rooms_Indicator_ := KEL.Intake.SingleValue(__recs,Other_Rooms_Indicator_);
    SELF.Comments_ := KEL.Intake.SingleValue(__recs,Comments_);
    SELF.Certification_Date_ := KEL.Intake.SingleValue(__recs,Certification_Date_);
    SELF.Hawaii_Transfer_Certificate_Of_Title_ := KEL.Intake.SingleValue(__recs,Hawaii_Transfer_Certificate_Of_Title_);
    SELF.Lot_Size_ := KEL.Intake.SingleValue(__recs,Lot_Size_);
    SELF.Lot_Size_Acres_ := KEL.Intake.SingleValue(__recs,Lot_Size_Acres_);
    SELF.Lot_Size_Frontage_Feet_ := KEL.Intake.SingleValue(__recs,Lot_Size_Frontage_Feet_);
    SELF.Lot_Size_Depth_Feet_ := KEL.Intake.SingleValue(__recs,Lot_Size_Depth_Feet_);
    SELF.Land_Acres_ := KEL.Intake.SingleValue(__recs,Land_Acres_);
    SELF.Land_Square_Footage_ := KEL.Intake.SingleValue(__recs,Land_Square_Footage_);
    SELF.Land_Dimensions_ := KEL.Intake.SingleValue(__recs,Land_Dimensions_);
    SELF.Legal_Lot_Code_ := KEL.Intake.SingleValue(__recs,Legal_Lot_Code_);
    SELF.Legal_Lot_Number_ := KEL.Intake.SingleValue(__recs,Legal_Lot_Number_);
    SELF.Legal_Block_ := KEL.Intake.SingleValue(__recs,Legal_Block_);
    SELF.Legal_Section_ := KEL.Intake.SingleValue(__recs,Legal_Section_);
    SELF.Legal_District_ := KEL.Intake.SingleValue(__recs,Legal_District_);
    SELF.Legal_Land_Lot_ := KEL.Intake.SingleValue(__recs,Legal_Land_Lot_);
    SELF.Legal_Unit_ := KEL.Intake.SingleValue(__recs,Legal_Unit_);
    SELF.Legal_City_Municipality_Township_ := KEL.Intake.SingleValue(__recs,Legal_City_Municipality_Township_);
    SELF.Legal_Subdivision_Name_ := KEL.Intake.SingleValue(__recs,Legal_Subdivision_Name_);
    SELF.Legal_Phase_Number_ := KEL.Intake.SingleValue(__recs,Legal_Phase_Number_);
    SELF.Legal_Tract_Number_ := KEL.Intake.SingleValue(__recs,Legal_Tract_Number_);
    SELF.Legal_Section_Township_Range_Meridian_ := KEL.Intake.SingleValue(__recs,Legal_Section_Township_Range_Meridian_);
    SELF.Legal_Brief_Description_ := KEL.Intake.SingleValue(__recs,Legal_Brief_Description_);
    SELF.Legal_Complete_Description_Code_ := KEL.Intake.SingleValue(__recs,Legal_Complete_Description_Code_);
    SELF.Census_Tract_ := KEL.Intake.SingleValue(__recs,Census_Tract_);
    SELF.Map_Reference_ := KEL.Intake.SingleValue(__recs,Map_Reference_);
    SELF.Recording_Date_ := KEL.Intake.SingleValue(__recs,Recording_Date_);
    SELF.Document_Number_ := KEL.Intake.SingleValue(__recs,Document_Number_);
    SELF.Document_Type_Code_ := KEL.Intake.SingleValue(__recs,Document_Type_Code_);
    SELF.Recorder_Book_Number_ := KEL.Intake.SingleValue(__recs,Recorder_Book_Number_);
    SELF.Recorder_Page_Number_ := KEL.Intake.SingleValue(__recs,Recorder_Page_Number_);
    SELF.Concurrent_Mortgage_Book_Page_Document_Number_ := KEL.Intake.SingleValue(__recs,Concurrent_Mortgage_Book_Page_Document_Number_);
    SELF.Transfer_Date_ := KEL.Intake.SingleValue(__recs,Transfer_Date_);
    SELF.Previous_Recording_Date_ := KEL.Intake.SingleValue(__recs,Previous_Recording_Date_);
    SELF.City_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,City_Transfer_Tax_);
    SELF.County_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,County_Transfer_Tax_);
    SELF.Total_Transfer_Tax_ := KEL.Intake.SingleValue(__recs,Total_Transfer_Tax_);
    SELF.Homestead_Home_Owner_Exemption_ := KEL.Intake.SingleValue(__recs,Homestead_Home_Owner_Exemption_);
    SELF.Tax_Rate_Code_Area_ := KEL.Intake.SingleValue(__recs,Tax_Rate_Code_Area_);
    SELF.Tax_Amount_ := KEL.Intake.SingleValue(__recs,Tax_Amount_);
    SELF.Tax_Year_ := KEL.Intake.SingleValue(__recs,Tax_Year_);
    SELF.Tax_Delinquent_Year_ := KEL.Intake.SingleValue(__recs,Tax_Delinquent_Year_);
    SELF.Tax_Exemption_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Tax_Exemption_Code_Counter_,Tax_Exemption_Code_},Tax_Exemption_Code_Counter_,Tax_Exemption_Code_),Tax_Exemption_Layout)(__NN(Tax_Exemption_Code_Counter_) OR __NN(Tax_Exemption_Code_)));
    SELF.School_Tax_Districts_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),School_Tax_District_Counter_,School_Tax_District_,School_Tax_District_Indicator_},School_Tax_District_Counter_,School_Tax_District_,School_Tax_District_Indicator_),School_Tax_Districts_Layout)(__NN(School_Tax_District_Counter_) OR __NN(School_Tax_District_) OR __NN(School_Tax_District_Indicator_)));
    SELF.Building_Areas_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Building_Area_Counter_,Building_Area_,Building_Area_Indicator_},Building_Area_Counter_,Building_Area_,Building_Area_Indicator_),Building_Areas_Layout)(__NN(Building_Area_Counter_) OR __NN(Building_Area_) OR __NN(Building_Area_Indicator_)));
    SELF.Site_Influences_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Site_Influence_Counter_,Site_Influence_Code_},Site_Influence_Counter_,Site_Influence_Code_),Site_Influences_Layout)(__NN(Site_Influence_Counter_) OR __NN(Site_Influence_Code_)));
    SELF.Amenity_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Amenity_Counter_,Amenity_Code_},Amenity_Counter_,Amenity_Code_),Amenity_Details_Layout)(__NN(Amenity_Counter_) OR __NN(Amenity_Code_)));
    SELF.Extra_Features_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Extra_Feature_Counter_,Extra_Feature_Area_,Extra_Feature_Indicator_},Extra_Feature_Counter_,Extra_Feature_Area_,Extra_Feature_Indicator_),Extra_Features_Layout)(__NN(Extra_Feature_Counter_) OR __NN(Extra_Feature_Area_) OR __NN(Extra_Feature_Indicator_)));
    SELF.Other_Buildings_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Other_Building_Counter_,Other_Building_Code_},Other_Building_Counter_,Other_Building_Code_),Other_Buildings_Layout)(__NN(Other_Building_Counter_) OR __NN(Other_Building_Code_)));
    SELF.Other_Important_Buildings_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Other_Important_Building_Counter_,Other_Important_Building_Indicator_,Other_Important_Building_Area_},Other_Important_Building_Counter_,Other_Important_Building_Indicator_,Other_Important_Building_Area_),Other_Important_Buildings_Layout)(__NN(Other_Important_Building_Counter_) OR __NN(Other_Important_Building_Indicator_) OR __NN(Other_Important_Building_Area_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Property__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Tax_Exemption_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Tax_Exemption_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Tax_Exemption_Code_Counter_) OR __NN(Tax_Exemption_Code_)));
    SELF.School_Tax_Districts_ := __CN(PROJECT(DATASET(__r),TRANSFORM(School_Tax_Districts_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(School_Tax_District_Counter_) OR __NN(School_Tax_District_) OR __NN(School_Tax_District_Indicator_)));
    SELF.Building_Areas_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Building_Areas_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Building_Area_Counter_) OR __NN(Building_Area_) OR __NN(Building_Area_Indicator_)));
    SELF.Site_Influences_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Site_Influences_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Site_Influence_Counter_) OR __NN(Site_Influence_Code_)));
    SELF.Amenity_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Amenity_Details_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Amenity_Counter_) OR __NN(Amenity_Code_)));
    SELF.Extra_Features_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Extra_Features_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Extra_Feature_Counter_) OR __NN(Extra_Feature_Area_) OR __NN(Extra_Feature_Indicator_)));
    SELF.Other_Buildings_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Other_Buildings_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Other_Building_Counter_) OR __NN(Other_Building_Code_)));
    SELF.Other_Important_Buildings_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Other_Important_Buildings_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Other_Important_Building_Counter_) OR __NN(Other_Important_Building_Indicator_) OR __NN(Other_Important_Building_Area_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))=1),GROUP,Property__Single_Rollup(LEFT)) + ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))>1),GROUP,Property__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ln_Fares_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ln_Fares_Id_);
  EXPORT Has_L_N_Owner__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Has_L_N_Owner_);
  EXPORT Has_Owner__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Has_Owner_);
  EXPORT Has_No_Fares_Owner__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Has_No_Fares_Owner_);
  EXPORT Old_A_P_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Old_A_P_N_);
  EXPORT Apn_Or_Pin_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Apn_Or_Pin_Number_);
  EXPORT Tax_I_D_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_I_D_Number_);
  EXPORT Excise_Tax_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Excise_Tax_Number_);
  EXPORT Applicant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Applicant_Owned_);
  EXPORT Occupant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupant_Owned_);
  EXPORT Applicant_Sold__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Applicant_Sold_);
  EXPORT Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Duplicate_Apn_With_Different_Address_Counter_);
  EXPORT Is_Assessment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Assessment_);
  EXPORT Is_Deed__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Deed_);
  EXPORT Purchase_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Purchase_Date_);
  EXPORT Purchase_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Purchase_Amount_);
  EXPORT Previous_Purchase_Price1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Purchase_Price1_);
  EXPORT Previous_Purchase_Price2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Purchase_Price2_);
  EXPORT Previous_Purchase_Date1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Purchase_Date1_);
  EXPORT Previous_Purchase_Date2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Purchase_Date2_);
  EXPORT Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price_);
  EXPORT Sale_Price_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price_Code_);
  EXPORT Previous_Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Sale_Price_);
  EXPORT Previous_Sale_Price_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Sale_Price_Code_);
  EXPORT Sale_Price1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price1_);
  EXPORT Sale_Price2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Price2_);
  EXPORT Sale_Date1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Date1_);
  EXPORT Sale_Date2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sale_Date2_);
  EXPORT Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Year_Built_);
  EXPORT Effective_Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Effective_Year_Built_);
  EXPORT Current_Record__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Record_);
  EXPORT Mortgage_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Amount_);
  EXPORT Mortgage_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Date_);
  EXPORT Mortgage_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Mortgage_Type_);
  EXPORT Type_Financing__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Financing_);
  EXPORT Primary_Loan_Due_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Due_Date_);
  EXPORT Primary_Loan_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Amount_);
  EXPORT Secondary_Loan_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Loan_Amount_);
  EXPORT Primary_Loan_Lender_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Lender_Type_Code_);
  EXPORT Secondary_Loan_Lender_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Loan_Lender_Type_Code_);
  EXPORT Primary_Loan_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Type_Code_);
  EXPORT Primary_Loan_Interest_Rate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Loan_Interest_Rate_);
  EXPORT Ownership_Method_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ownership_Method_Code_);
  EXPORT Ownership_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ownership_Type_Code_);
  EXPORT Owners_Relationship_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Owners_Relationship_Code_);
  EXPORT Multi_Apn_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Multi_Apn_Flag_);
  EXPORT Contract_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Contract_Date_);
  EXPORT Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Mortgage_Reset_Date_);
  EXPORT Rate_Change_Frequency__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Rate_Change_Frequency_);
  EXPORT Change_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Change_Index_);
  EXPORT Adjustable_Rate_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Index_);
  EXPORT Adjustable_Rate_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Adjustable_Rate_Rider_);
  EXPORT Fixed_Step_Rate_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fixed_Step_Rate_Rider_);
  EXPORT Condominium_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condominium_Rider_);
  EXPORT Planned_Unit_Development_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Planned_Unit_Development_Rider_);
  EXPORT Assumability_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assumability_Rider_);
  EXPORT One_Four_Family_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,One_Four_Family_Rider_);
  EXPORT Second_Home_Rider__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Second_Home_Rider_);
  EXPORT Type_Of_Deed_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Of_Deed_Code_);
  EXPORT Loan_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Number_);
  EXPORT Partial_Interest_Transferred__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Partial_Interest_Transferred_);
  EXPORT Loan_Term_Months__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Term_Months_);
  EXPORT Loan_Term_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Loan_Term_Years_);
  EXPORT Lender_Id_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lender_Id_Code_);
  EXPORT Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Or_Borrower_Or_Assessee_);
  EXPORT Name1_Id_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name1_Id_Code_);
  EXPORT Name2_Id_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name2_Id_Code_);
  EXPORT Buyer_Borrower_Vesting_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Borrower_Vesting_Code_);
  EXPORT Buyer_Borrower_Addendum_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Buyer_Borrower_Addendum_Flag_);
  EXPORT Seller1_Id_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller1_Id_Code_);
  EXPORT Seller2_Id_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller2_Id_Code_);
  EXPORT Seller_Addendum_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seller_Addendum_Flag_);
  EXPORT Assessed_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Amount_);
  EXPORT Assessed_Land_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Land_Value_);
  EXPORT Assessed_Improvement_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Improvement_Value_);
  EXPORT Assessed_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Total_Value_);
  EXPORT Assessed_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Assessed_Value_Year_);
  EXPORT Market_Land_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Land_Value_);
  EXPORT Market_Improvement_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Improvement_Value_);
  EXPORT Market_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Total_Value_);
  EXPORT Market_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Market_Value_Year_);
  EXPORT Standardized_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Standardized_Land_Use_Code_);
  EXPORT Property_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Property_Use_Code_);
  EXPORT State_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Land_Use_Code_);
  EXPORT County_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Land_Use_Code_);
  EXPORT County_Land_Use_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Land_Use_Description_);
  EXPORT Timeshare_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Timeshare_Code_);
  EXPORT Zoning__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Zoning_);
  EXPORT Condo_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condo_Code_);
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
  EXPORT Topograpy_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Topograpy_Code_);
  EXPORT Neighborhood_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Code_);
  EXPORT Condo_Project_Or_Building_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Condo_Project_Or_Building_Name_);
  EXPORT Other_Rooms_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Other_Rooms_Indicator_);
  EXPORT Comments__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Comments_);
  EXPORT Certification_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Certification_Date_);
  EXPORT Hawaii_Transfer_Certificate_Of_Title__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Hawaii_Transfer_Certificate_Of_Title_);
  EXPORT Lot_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_);
  EXPORT Lot_Size_Acres__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Acres_);
  EXPORT Lot_Size_Frontage_Feet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Frontage_Feet_);
  EXPORT Lot_Size_Depth_Feet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lot_Size_Depth_Feet_);
  EXPORT Land_Acres__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Acres_);
  EXPORT Land_Square_Footage__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Square_Footage_);
  EXPORT Land_Dimensions__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Land_Dimensions_);
  EXPORT Legal_Lot_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Lot_Code_);
  EXPORT Legal_Lot_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Lot_Number_);
  EXPORT Legal_Block__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Block_);
  EXPORT Legal_Section__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Section_);
  EXPORT Legal_District__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_District_);
  EXPORT Legal_Land_Lot__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Land_Lot_);
  EXPORT Legal_Unit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Unit_);
  EXPORT Legal_City_Municipality_Township__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_City_Municipality_Township_);
  EXPORT Legal_Subdivision_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Subdivision_Name_);
  EXPORT Legal_Phase_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Phase_Number_);
  EXPORT Legal_Tract_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Tract_Number_);
  EXPORT Legal_Section_Township_Range_Meridian__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Section_Township_Range_Meridian_);
  EXPORT Legal_Brief_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Brief_Description_);
  EXPORT Legal_Complete_Description_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_Complete_Description_Code_);
  EXPORT Census_Tract__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Census_Tract_);
  EXPORT Map_Reference__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Map_Reference_);
  EXPORT Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recording_Date_);
  EXPORT Document_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Document_Number_);
  EXPORT Document_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Document_Type_Code_);
  EXPORT Recorder_Book_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recorder_Book_Number_);
  EXPORT Recorder_Page_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Recorder_Page_Number_);
  EXPORT Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Concurrent_Mortgage_Book_Page_Document_Number_);
  EXPORT Transfer_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Transfer_Date_);
  EXPORT Previous_Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Previous_Recording_Date_);
  EXPORT City_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,City_Transfer_Tax_);
  EXPORT County_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_Transfer_Tax_);
  EXPORT Total_Transfer_Tax__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Total_Transfer_Tax_);
  EXPORT Homestead_Home_Owner_Exemption__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Homestead_Home_Owner_Exemption_);
  EXPORT Tax_Rate_Code_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Rate_Code_Area_);
  EXPORT Tax_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Amount_);
  EXPORT Tax_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Year_);
  EXPORT Tax_Delinquent_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tax_Delinquent_Year_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Ln_Fares_Id__SingleValue_Invalid),COUNT(Has_L_N_Owner__SingleValue_Invalid),COUNT(Has_Owner__SingleValue_Invalid),COUNT(Has_No_Fares_Owner__SingleValue_Invalid),COUNT(Old_A_P_N__SingleValue_Invalid),COUNT(Apn_Or_Pin_Number__SingleValue_Invalid),COUNT(Tax_I_D_Number__SingleValue_Invalid),COUNT(Excise_Tax_Number__SingleValue_Invalid),COUNT(Applicant_Owned__SingleValue_Invalid),COUNT(Occupant_Owned__SingleValue_Invalid),COUNT(Applicant_Sold__SingleValue_Invalid),COUNT(Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid),COUNT(Is_Assessment__SingleValue_Invalid),COUNT(Is_Deed__SingleValue_Invalid),COUNT(Purchase_Date__SingleValue_Invalid),COUNT(Purchase_Amount__SingleValue_Invalid),COUNT(Previous_Purchase_Price1__SingleValue_Invalid),COUNT(Previous_Purchase_Price2__SingleValue_Invalid),COUNT(Previous_Purchase_Date1__SingleValue_Invalid),COUNT(Previous_Purchase_Date2__SingleValue_Invalid),COUNT(Sale_Price__SingleValue_Invalid),COUNT(Sale_Price_Code__SingleValue_Invalid),COUNT(Previous_Sale_Price__SingleValue_Invalid),COUNT(Previous_Sale_Price_Code__SingleValue_Invalid),COUNT(Sale_Price1__SingleValue_Invalid),COUNT(Sale_Price2__SingleValue_Invalid),COUNT(Sale_Date1__SingleValue_Invalid),COUNT(Sale_Date2__SingleValue_Invalid),COUNT(Year_Built__SingleValue_Invalid),COUNT(Effective_Year_Built__SingleValue_Invalid),COUNT(Current_Record__SingleValue_Invalid),COUNT(Mortgage_Amount__SingleValue_Invalid),COUNT(Mortgage_Date__SingleValue_Invalid),COUNT(Mortgage_Type__SingleValue_Invalid),COUNT(Type_Financing__SingleValue_Invalid),COUNT(Primary_Loan_Due_Date__SingleValue_Invalid),COUNT(Primary_Loan_Amount__SingleValue_Invalid),COUNT(Secondary_Loan_Amount__SingleValue_Invalid),COUNT(Primary_Loan_Lender_Type_Code__SingleValue_Invalid),COUNT(Secondary_Loan_Lender_Type_Code__SingleValue_Invalid),COUNT(Primary_Loan_Type_Code__SingleValue_Invalid),COUNT(Primary_Loan_Interest_Rate__SingleValue_Invalid),COUNT(Ownership_Method_Code__SingleValue_Invalid),COUNT(Ownership_Type_Code__SingleValue_Invalid),COUNT(Owners_Relationship_Code__SingleValue_Invalid),COUNT(Multi_Apn_Flag__SingleValue_Invalid),COUNT(Contract_Date__SingleValue_Invalid),COUNT(Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid),COUNT(Rate_Change_Frequency__SingleValue_Invalid),COUNT(Change_Index__SingleValue_Invalid),COUNT(Adjustable_Rate_Index__SingleValue_Invalid),COUNT(Adjustable_Rate_Rider__SingleValue_Invalid),COUNT(Fixed_Step_Rate_Rider__SingleValue_Invalid),COUNT(Condominium_Rider__SingleValue_Invalid),COUNT(Planned_Unit_Development_Rider__SingleValue_Invalid),COUNT(Assumability_Rider__SingleValue_Invalid),COUNT(One_Four_Family_Rider__SingleValue_Invalid),COUNT(Second_Home_Rider__SingleValue_Invalid),COUNT(Type_Of_Deed_Code__SingleValue_Invalid),COUNT(Loan_Number__SingleValue_Invalid),COUNT(Partial_Interest_Transferred__SingleValue_Invalid),COUNT(Loan_Term_Months__SingleValue_Invalid),COUNT(Loan_Term_Years__SingleValue_Invalid),COUNT(Lender_Id_Code__SingleValue_Invalid),COUNT(Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid),COUNT(Name1_Id_Code__SingleValue_Invalid),COUNT(Name2_Id_Code__SingleValue_Invalid),COUNT(Buyer_Borrower_Vesting_Code__SingleValue_Invalid),COUNT(Buyer_Borrower_Addendum_Flag__SingleValue_Invalid),COUNT(Seller1_Id_Code__SingleValue_Invalid),COUNT(Seller2_Id_Code__SingleValue_Invalid),COUNT(Seller_Addendum_Flag__SingleValue_Invalid),COUNT(Assessed_Amount__SingleValue_Invalid),COUNT(Assessed_Land_Value__SingleValue_Invalid),COUNT(Assessed_Improvement_Value__SingleValue_Invalid),COUNT(Assessed_Total_Value__SingleValue_Invalid),COUNT(Assessed_Value_Year__SingleValue_Invalid),COUNT(Market_Land_Value__SingleValue_Invalid),COUNT(Market_Improvement_Value__SingleValue_Invalid),COUNT(Market_Total_Value__SingleValue_Invalid),COUNT(Market_Value_Year__SingleValue_Invalid),COUNT(Standardized_Land_Use_Code__SingleValue_Invalid),COUNT(Property_Use_Code__SingleValue_Invalid),COUNT(State_Land_Use_Code__SingleValue_Invalid),COUNT(County_Land_Use_Code__SingleValue_Invalid),COUNT(County_Land_Use_Description__SingleValue_Invalid),COUNT(Timeshare_Code__SingleValue_Invalid),COUNT(Zoning__SingleValue_Invalid),COUNT(Condo_Code__SingleValue_Invalid),COUNT(Number_Of_Buildings__SingleValue_Invalid),COUNT(Number_Of_Stories__SingleValue_Invalid),COUNT(Number_Of_Units__SingleValue_Invalid),COUNT(Number_Of_Rooms__SingleValue_Invalid),COUNT(Number_Of_Bedrooms__SingleValue_Invalid),COUNT(Number_Of_Baths__SingleValue_Invalid),COUNT(Number_Of_Partial_Baths__SingleValue_Invalid),COUNT(Number_Of_Plumbing_Fixtures__SingleValue_Invalid),COUNT(Garage_Type_Code__SingleValue_Invalid),COUNT(Parking_Number_Of_Cars__SingleValue_Invalid),COUNT(Pool_Code__SingleValue_Invalid),COUNT(Style_Code__SingleValue_Invalid),COUNT(Type_Construction_Code__SingleValue_Invalid),COUNT(Foundation_Code__SingleValue_Invalid),COUNT(Building_Quality_Code__SingleValue_Invalid),COUNT(Building_Condition_Code__SingleValue_Invalid),COUNT(Exterior_Walls_Code__SingleValue_Invalid),COUNT(Interior_Walls_Code__SingleValue_Invalid),COUNT(Roof_Cover_Code__SingleValue_Invalid),COUNT(Roof_Type_Code__SingleValue_Invalid),COUNT(Floor_Cover_Code__SingleValue_Invalid),COUNT(Water_Code__SingleValue_Invalid),COUNT(Sewer_Code__SingleValue_Invalid),COUNT(Heating_Code__SingleValue_Invalid),COUNT(Heating_Fuel_Type_Code__SingleValue_Invalid),COUNT(Air_Conditioning_Code__SingleValue_Invalid),COUNT(Air_Conditioning_Type_Code__SingleValue_Invalid),COUNT(Elevator__SingleValue_Invalid),COUNT(Fireplace_Indicator__SingleValue_Invalid),COUNT(Fireplace_Number__SingleValue_Invalid),COUNT(Basement_Code__SingleValue_Invalid),COUNT(Building_Class_Code__SingleValue_Invalid),COUNT(Topograpy_Code__SingleValue_Invalid),COUNT(Neighborhood_Code__SingleValue_Invalid),COUNT(Condo_Project_Or_Building_Name__SingleValue_Invalid),COUNT(Other_Rooms_Indicator__SingleValue_Invalid),COUNT(Comments__SingleValue_Invalid),COUNT(Certification_Date__SingleValue_Invalid),COUNT(Hawaii_Transfer_Certificate_Of_Title__SingleValue_Invalid),COUNT(Lot_Size__SingleValue_Invalid),COUNT(Lot_Size_Acres__SingleValue_Invalid),COUNT(Lot_Size_Frontage_Feet__SingleValue_Invalid),COUNT(Lot_Size_Depth_Feet__SingleValue_Invalid),COUNT(Land_Acres__SingleValue_Invalid),COUNT(Land_Square_Footage__SingleValue_Invalid),COUNT(Land_Dimensions__SingleValue_Invalid),COUNT(Legal_Lot_Code__SingleValue_Invalid),COUNT(Legal_Lot_Number__SingleValue_Invalid),COUNT(Legal_Block__SingleValue_Invalid),COUNT(Legal_Section__SingleValue_Invalid),COUNT(Legal_District__SingleValue_Invalid),COUNT(Legal_Land_Lot__SingleValue_Invalid),COUNT(Legal_Unit__SingleValue_Invalid),COUNT(Legal_City_Municipality_Township__SingleValue_Invalid),COUNT(Legal_Subdivision_Name__SingleValue_Invalid),COUNT(Legal_Phase_Number__SingleValue_Invalid),COUNT(Legal_Tract_Number__SingleValue_Invalid),COUNT(Legal_Section_Township_Range_Meridian__SingleValue_Invalid),COUNT(Legal_Brief_Description__SingleValue_Invalid),COUNT(Legal_Complete_Description_Code__SingleValue_Invalid),COUNT(Census_Tract__SingleValue_Invalid),COUNT(Map_Reference__SingleValue_Invalid),COUNT(Recording_Date__SingleValue_Invalid),COUNT(Document_Number__SingleValue_Invalid),COUNT(Document_Type_Code__SingleValue_Invalid),COUNT(Recorder_Book_Number__SingleValue_Invalid),COUNT(Recorder_Page_Number__SingleValue_Invalid),COUNT(Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid),COUNT(Transfer_Date__SingleValue_Invalid),COUNT(Previous_Recording_Date__SingleValue_Invalid),COUNT(City_Transfer_Tax__SingleValue_Invalid),COUNT(County_Transfer_Tax__SingleValue_Invalid),COUNT(Total_Transfer_Tax__SingleValue_Invalid),COUNT(Homestead_Home_Owner_Exemption__SingleValue_Invalid),COUNT(Tax_Rate_Code_Area__SingleValue_Invalid),COUNT(Tax_Amount__SingleValue_Invalid),COUNT(Tax_Year__SingleValue_Invalid),COUNT(Tax_Delinquent_Year__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Ln_Fares_Id__SingleValue_Invalid,KEL.typ.int Has_L_N_Owner__SingleValue_Invalid,KEL.typ.int Has_Owner__SingleValue_Invalid,KEL.typ.int Has_No_Fares_Owner__SingleValue_Invalid,KEL.typ.int Old_A_P_N__SingleValue_Invalid,KEL.typ.int Apn_Or_Pin_Number__SingleValue_Invalid,KEL.typ.int Tax_I_D_Number__SingleValue_Invalid,KEL.typ.int Excise_Tax_Number__SingleValue_Invalid,KEL.typ.int Applicant_Owned__SingleValue_Invalid,KEL.typ.int Occupant_Owned__SingleValue_Invalid,KEL.typ.int Applicant_Sold__SingleValue_Invalid,KEL.typ.int Duplicate_Apn_With_Different_Address_Counter__SingleValue_Invalid,KEL.typ.int Is_Assessment__SingleValue_Invalid,KEL.typ.int Is_Deed__SingleValue_Invalid,KEL.typ.int Purchase_Date__SingleValue_Invalid,KEL.typ.int Purchase_Amount__SingleValue_Invalid,KEL.typ.int Previous_Purchase_Price1__SingleValue_Invalid,KEL.typ.int Previous_Purchase_Price2__SingleValue_Invalid,KEL.typ.int Previous_Purchase_Date1__SingleValue_Invalid,KEL.typ.int Previous_Purchase_Date2__SingleValue_Invalid,KEL.typ.int Sale_Price__SingleValue_Invalid,KEL.typ.int Sale_Price_Code__SingleValue_Invalid,KEL.typ.int Previous_Sale_Price__SingleValue_Invalid,KEL.typ.int Previous_Sale_Price_Code__SingleValue_Invalid,KEL.typ.int Sale_Price1__SingleValue_Invalid,KEL.typ.int Sale_Price2__SingleValue_Invalid,KEL.typ.int Sale_Date1__SingleValue_Invalid,KEL.typ.int Sale_Date2__SingleValue_Invalid,KEL.typ.int Year_Built__SingleValue_Invalid,KEL.typ.int Effective_Year_Built__SingleValue_Invalid,KEL.typ.int Current_Record__SingleValue_Invalid,KEL.typ.int Mortgage_Amount__SingleValue_Invalid,KEL.typ.int Mortgage_Date__SingleValue_Invalid,KEL.typ.int Mortgage_Type__SingleValue_Invalid,KEL.typ.int Type_Financing__SingleValue_Invalid,KEL.typ.int Primary_Loan_Due_Date__SingleValue_Invalid,KEL.typ.int Primary_Loan_Amount__SingleValue_Invalid,KEL.typ.int Secondary_Loan_Amount__SingleValue_Invalid,KEL.typ.int Primary_Loan_Lender_Type_Code__SingleValue_Invalid,KEL.typ.int Secondary_Loan_Lender_Type_Code__SingleValue_Invalid,KEL.typ.int Primary_Loan_Type_Code__SingleValue_Invalid,KEL.typ.int Primary_Loan_Interest_Rate__SingleValue_Invalid,KEL.typ.int Ownership_Method_Code__SingleValue_Invalid,KEL.typ.int Ownership_Type_Code__SingleValue_Invalid,KEL.typ.int Owners_Relationship_Code__SingleValue_Invalid,KEL.typ.int Multi_Apn_Flag__SingleValue_Invalid,KEL.typ.int Contract_Date__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Mortgage_Reset_Date__SingleValue_Invalid,KEL.typ.int Rate_Change_Frequency__SingleValue_Invalid,KEL.typ.int Change_Index__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Index__SingleValue_Invalid,KEL.typ.int Adjustable_Rate_Rider__SingleValue_Invalid,KEL.typ.int Fixed_Step_Rate_Rider__SingleValue_Invalid,KEL.typ.int Condominium_Rider__SingleValue_Invalid,KEL.typ.int Planned_Unit_Development_Rider__SingleValue_Invalid,KEL.typ.int Assumability_Rider__SingleValue_Invalid,KEL.typ.int One_Four_Family_Rider__SingleValue_Invalid,KEL.typ.int Second_Home_Rider__SingleValue_Invalid,KEL.typ.int Type_Of_Deed_Code__SingleValue_Invalid,KEL.typ.int Loan_Number__SingleValue_Invalid,KEL.typ.int Partial_Interest_Transferred__SingleValue_Invalid,KEL.typ.int Loan_Term_Months__SingleValue_Invalid,KEL.typ.int Loan_Term_Years__SingleValue_Invalid,KEL.typ.int Lender_Id_Code__SingleValue_Invalid,KEL.typ.int Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid,KEL.typ.int Name1_Id_Code__SingleValue_Invalid,KEL.typ.int Name2_Id_Code__SingleValue_Invalid,KEL.typ.int Buyer_Borrower_Vesting_Code__SingleValue_Invalid,KEL.typ.int Buyer_Borrower_Addendum_Flag__SingleValue_Invalid,KEL.typ.int Seller1_Id_Code__SingleValue_Invalid,KEL.typ.int Seller2_Id_Code__SingleValue_Invalid,KEL.typ.int Seller_Addendum_Flag__SingleValue_Invalid,KEL.typ.int Assessed_Amount__SingleValue_Invalid,KEL.typ.int Assessed_Land_Value__SingleValue_Invalid,KEL.typ.int Assessed_Improvement_Value__SingleValue_Invalid,KEL.typ.int Assessed_Total_Value__SingleValue_Invalid,KEL.typ.int Assessed_Value_Year__SingleValue_Invalid,KEL.typ.int Market_Land_Value__SingleValue_Invalid,KEL.typ.int Market_Improvement_Value__SingleValue_Invalid,KEL.typ.int Market_Total_Value__SingleValue_Invalid,KEL.typ.int Market_Value_Year__SingleValue_Invalid,KEL.typ.int Standardized_Land_Use_Code__SingleValue_Invalid,KEL.typ.int Property_Use_Code__SingleValue_Invalid,KEL.typ.int State_Land_Use_Code__SingleValue_Invalid,KEL.typ.int County_Land_Use_Code__SingleValue_Invalid,KEL.typ.int County_Land_Use_Description__SingleValue_Invalid,KEL.typ.int Timeshare_Code__SingleValue_Invalid,KEL.typ.int Zoning__SingleValue_Invalid,KEL.typ.int Condo_Code__SingleValue_Invalid,KEL.typ.int Number_Of_Buildings__SingleValue_Invalid,KEL.typ.int Number_Of_Stories__SingleValue_Invalid,KEL.typ.int Number_Of_Units__SingleValue_Invalid,KEL.typ.int Number_Of_Rooms__SingleValue_Invalid,KEL.typ.int Number_Of_Bedrooms__SingleValue_Invalid,KEL.typ.int Number_Of_Baths__SingleValue_Invalid,KEL.typ.int Number_Of_Partial_Baths__SingleValue_Invalid,KEL.typ.int Number_Of_Plumbing_Fixtures__SingleValue_Invalid,KEL.typ.int Garage_Type_Code__SingleValue_Invalid,KEL.typ.int Parking_Number_Of_Cars__SingleValue_Invalid,KEL.typ.int Pool_Code__SingleValue_Invalid,KEL.typ.int Style_Code__SingleValue_Invalid,KEL.typ.int Type_Construction_Code__SingleValue_Invalid,KEL.typ.int Foundation_Code__SingleValue_Invalid,KEL.typ.int Building_Quality_Code__SingleValue_Invalid,KEL.typ.int Building_Condition_Code__SingleValue_Invalid,KEL.typ.int Exterior_Walls_Code__SingleValue_Invalid,KEL.typ.int Interior_Walls_Code__SingleValue_Invalid,KEL.typ.int Roof_Cover_Code__SingleValue_Invalid,KEL.typ.int Roof_Type_Code__SingleValue_Invalid,KEL.typ.int Floor_Cover_Code__SingleValue_Invalid,KEL.typ.int Water_Code__SingleValue_Invalid,KEL.typ.int Sewer_Code__SingleValue_Invalid,KEL.typ.int Heating_Code__SingleValue_Invalid,KEL.typ.int Heating_Fuel_Type_Code__SingleValue_Invalid,KEL.typ.int Air_Conditioning_Code__SingleValue_Invalid,KEL.typ.int Air_Conditioning_Type_Code__SingleValue_Invalid,KEL.typ.int Elevator__SingleValue_Invalid,KEL.typ.int Fireplace_Indicator__SingleValue_Invalid,KEL.typ.int Fireplace_Number__SingleValue_Invalid,KEL.typ.int Basement_Code__SingleValue_Invalid,KEL.typ.int Building_Class_Code__SingleValue_Invalid,KEL.typ.int Topograpy_Code__SingleValue_Invalid,KEL.typ.int Neighborhood_Code__SingleValue_Invalid,KEL.typ.int Condo_Project_Or_Building_Name__SingleValue_Invalid,KEL.typ.int Other_Rooms_Indicator__SingleValue_Invalid,KEL.typ.int Comments__SingleValue_Invalid,KEL.typ.int Certification_Date__SingleValue_Invalid,KEL.typ.int Hawaii_Transfer_Certificate_Of_Title__SingleValue_Invalid,KEL.typ.int Lot_Size__SingleValue_Invalid,KEL.typ.int Lot_Size_Acres__SingleValue_Invalid,KEL.typ.int Lot_Size_Frontage_Feet__SingleValue_Invalid,KEL.typ.int Lot_Size_Depth_Feet__SingleValue_Invalid,KEL.typ.int Land_Acres__SingleValue_Invalid,KEL.typ.int Land_Square_Footage__SingleValue_Invalid,KEL.typ.int Land_Dimensions__SingleValue_Invalid,KEL.typ.int Legal_Lot_Code__SingleValue_Invalid,KEL.typ.int Legal_Lot_Number__SingleValue_Invalid,KEL.typ.int Legal_Block__SingleValue_Invalid,KEL.typ.int Legal_Section__SingleValue_Invalid,KEL.typ.int Legal_District__SingleValue_Invalid,KEL.typ.int Legal_Land_Lot__SingleValue_Invalid,KEL.typ.int Legal_Unit__SingleValue_Invalid,KEL.typ.int Legal_City_Municipality_Township__SingleValue_Invalid,KEL.typ.int Legal_Subdivision_Name__SingleValue_Invalid,KEL.typ.int Legal_Phase_Number__SingleValue_Invalid,KEL.typ.int Legal_Tract_Number__SingleValue_Invalid,KEL.typ.int Legal_Section_Township_Range_Meridian__SingleValue_Invalid,KEL.typ.int Legal_Brief_Description__SingleValue_Invalid,KEL.typ.int Legal_Complete_Description_Code__SingleValue_Invalid,KEL.typ.int Census_Tract__SingleValue_Invalid,KEL.typ.int Map_Reference__SingleValue_Invalid,KEL.typ.int Recording_Date__SingleValue_Invalid,KEL.typ.int Document_Number__SingleValue_Invalid,KEL.typ.int Document_Type_Code__SingleValue_Invalid,KEL.typ.int Recorder_Book_Number__SingleValue_Invalid,KEL.typ.int Recorder_Page_Number__SingleValue_Invalid,KEL.typ.int Concurrent_Mortgage_Book_Page_Document_Number__SingleValue_Invalid,KEL.typ.int Transfer_Date__SingleValue_Invalid,KEL.typ.int Previous_Recording_Date__SingleValue_Invalid,KEL.typ.int City_Transfer_Tax__SingleValue_Invalid,KEL.typ.int County_Transfer_Tax__SingleValue_Invalid,KEL.typ.int Total_Transfer_Tax__SingleValue_Invalid,KEL.typ.int Homestead_Home_Owner_Exemption__SingleValue_Invalid,KEL.typ.int Tax_Rate_Code_Area__SingleValue_Invalid,KEL.typ.int Tax_Amount__SingleValue_Invalid,KEL.typ.int Tax_Year__SingleValue_Invalid,KEL.typ.int Tax_Delinquent_Year__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LnFaresId',COUNT(__d0(__NL(Ln_Fares_Id_))),COUNT(__d0(__NN(Ln_Fares_Id_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HasLNOwner',COUNT(__d0(__NL(Has_L_N_Owner_))),COUNT(__d0(__NN(Has_L_N_Owner_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HasOwner',COUNT(__d0(__NL(Has_Owner_))),COUNT(__d0(__NN(Has_Owner_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HasNoFaresOwner',COUNT(__d0(__NL(Has_No_Fares_Owner_))),COUNT(__d0(__NN(Has_No_Fares_Owner_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OldAPN',COUNT(__d0(__NL(Old_A_P_N_))),COUNT(__d0(__NN(Old_A_P_N_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ApnOrPinNumber',COUNT(__d0(__NL(Apn_Or_Pin_Number_))),COUNT(__d0(__NN(Apn_Or_Pin_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxIDNumber',COUNT(__d0(__NL(Tax_I_D_Number_))),COUNT(__d0(__NN(Tax_I_D_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExciseTaxNumber',COUNT(__d0(__NL(Excise_Tax_Number_))),COUNT(__d0(__NN(Excise_Tax_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ApplicantOwned',COUNT(__d0(__NL(Applicant_Owned_))),COUNT(__d0(__NN(Applicant_Owned_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d0(__NL(Occupant_Owned_))),COUNT(__d0(__NN(Occupant_Owned_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ApplicantSold',COUNT(__d0(__NL(Applicant_Sold_))),COUNT(__d0(__NN(Applicant_Sold_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateApnWithDifferentAddressCounter',COUNT(__d0(__NL(Duplicate_Apn_With_Different_Address_Counter_))),COUNT(__d0(__NN(Duplicate_Apn_With_Different_Address_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d0(__NL(Is_Assessment_))),COUNT(__d0(__NN(Is_Assessment_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDeed',COUNT(__d0(__NL(Is_Deed_))),COUNT(__d0(__NN(Is_Deed_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchaseDate',COUNT(__d0(__NL(Purchase_Date_))),COUNT(__d0(__NN(Purchase_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchaseAmount',COUNT(__d0(__NL(Purchase_Amount_))),COUNT(__d0(__NN(Purchase_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousPurchasePrice1',COUNT(__d0(__NL(Previous_Purchase_Price1_))),COUNT(__d0(__NN(Previous_Purchase_Price1_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousPurchasePrice2',COUNT(__d0(__NL(Previous_Purchase_Price2_))),COUNT(__d0(__NN(Previous_Purchase_Price2_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousPurchaseDate1',COUNT(__d0(__NL(Previous_Purchase_Date1_))),COUNT(__d0(__NN(Previous_Purchase_Date1_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousPurchaseDate2',COUNT(__d0(__NL(Previous_Purchase_Date2_))),COUNT(__d0(__NN(Previous_Purchase_Date2_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice',COUNT(__d0(__NL(Sale_Price_))),COUNT(__d0(__NN(Sale_Price_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePriceCode',COUNT(__d0(__NL(Sale_Price_Code_))),COUNT(__d0(__NN(Sale_Price_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d0(__NL(Previous_Sale_Price_))),COUNT(__d0(__NN(Previous_Sale_Price_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePriceCode',COUNT(__d0(__NL(Previous_Sale_Price_Code_))),COUNT(__d0(__NN(Previous_Sale_Price_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice1',COUNT(__d0(__NL(Sale_Price1_))),COUNT(__d0(__NN(Sale_Price1_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice2',COUNT(__d0(__NL(Sale_Price2_))),COUNT(__d0(__NN(Sale_Price2_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate1',COUNT(__d0(__NL(Sale_Date1_))),COUNT(__d0(__NN(Sale_Date1_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate2',COUNT(__d0(__NL(Sale_Date2_))),COUNT(__d0(__NN(Sale_Date2_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d0(__NL(Year_Built_))),COUNT(__d0(__NN(Year_Built_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d0(__NL(Effective_Year_Built_))),COUNT(__d0(__NN(Effective_Year_Built_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRecord',COUNT(__d0(__NL(Current_Record_))),COUNT(__d0(__NN(Current_Record_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d0(__NL(Mortgage_Amount_))),COUNT(__d0(__NN(Mortgage_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageDate',COUNT(__d0(__NL(Mortgage_Date_))),COUNT(__d0(__NN(Mortgage_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d0(__NL(Mortgage_Type_))),COUNT(__d0(__NN(Mortgage_Type_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeFinancing',COUNT(__d0(__NL(Type_Financing_))),COUNT(__d0(__NN(Type_Financing_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanDueDate',COUNT(__d0(__NL(Primary_Loan_Due_Date_))),COUNT(__d0(__NN(Primary_Loan_Due_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanAmount',COUNT(__d0(__NL(Primary_Loan_Amount_))),COUNT(__d0(__NN(Primary_Loan_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanAmount',COUNT(__d0(__NL(Secondary_Loan_Amount_))),COUNT(__d0(__NN(Secondary_Loan_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanLenderTypeCode',COUNT(__d0(__NL(Primary_Loan_Lender_Type_Code_))),COUNT(__d0(__NN(Primary_Loan_Lender_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryLoanLenderTypeCode',COUNT(__d0(__NL(Secondary_Loan_Lender_Type_Code_))),COUNT(__d0(__NN(Secondary_Loan_Lender_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanTypeCode',COUNT(__d0(__NL(Primary_Loan_Type_Code_))),COUNT(__d0(__NN(Primary_Loan_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryLoanInterestRate',COUNT(__d0(__NL(Primary_Loan_Interest_Rate_))),COUNT(__d0(__NN(Primary_Loan_Interest_Rate_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipMethodCode',COUNT(__d0(__NL(Ownership_Method_Code_))),COUNT(__d0(__NN(Ownership_Method_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnershipTypeCode',COUNT(__d0(__NL(Ownership_Type_Code_))),COUNT(__d0(__NN(Ownership_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnersRelationshipCode',COUNT(__d0(__NL(Owners_Relationship_Code_))),COUNT(__d0(__NN(Owners_Relationship_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MultiApnFlag',COUNT(__d0(__NL(Multi_Apn_Flag_))),COUNT(__d0(__NN(Multi_Apn_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d0(__NL(Contract_Date_))),COUNT(__d0(__NN(Contract_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateMortgageResetDate',COUNT(__d0(__NL(Adjustable_Rate_Mortgage_Reset_Date_))),COUNT(__d0(__NN(Adjustable_Rate_Mortgage_Reset_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RateChangeFrequency',COUNT(__d0(__NL(Rate_Change_Frequency_))),COUNT(__d0(__NN(Rate_Change_Frequency_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ChangeIndex',COUNT(__d0(__NL(Change_Index_))),COUNT(__d0(__NN(Change_Index_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateIndex',COUNT(__d0(__NL(Adjustable_Rate_Index_))),COUNT(__d0(__NN(Adjustable_Rate_Index_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdjustableRateRider',COUNT(__d0(__NL(Adjustable_Rate_Rider_))),COUNT(__d0(__NN(Adjustable_Rate_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FixedStepRateRider',COUNT(__d0(__NL(Fixed_Step_Rate_Rider_))),COUNT(__d0(__NN(Fixed_Step_Rate_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondominiumRider',COUNT(__d0(__NL(Condominium_Rider_))),COUNT(__d0(__NN(Condominium_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PlannedUnitDevelopmentRider',COUNT(__d0(__NL(Planned_Unit_Development_Rider_))),COUNT(__d0(__NN(Planned_Unit_Development_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssumabilityRider',COUNT(__d0(__NL(Assumability_Rider_))),COUNT(__d0(__NN(Assumability_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OneFourFamilyRider',COUNT(__d0(__NL(One_Four_Family_Rider_))),COUNT(__d0(__NN(One_Four_Family_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondHomeRider',COUNT(__d0(__NL(Second_Home_Rider_))),COUNT(__d0(__NN(Second_Home_Rider_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeOfDeedCode',COUNT(__d0(__NL(Type_Of_Deed_Code_))),COUNT(__d0(__NN(Type_Of_Deed_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanNumber',COUNT(__d0(__NL(Loan_Number_))),COUNT(__d0(__NN(Loan_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PartialInterestTransferred',COUNT(__d0(__NL(Partial_Interest_Transferred_))),COUNT(__d0(__NN(Partial_Interest_Transferred_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermMonths',COUNT(__d0(__NL(Loan_Term_Months_))),COUNT(__d0(__NN(Loan_Term_Months_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LoanTermYears',COUNT(__d0(__NL(Loan_Term_Years_))),COUNT(__d0(__NN(Loan_Term_Years_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LenderIdCode',COUNT(__d0(__NL(Lender_Id_Code_))),COUNT(__d0(__NN(Lender_Id_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d0(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d0(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1IdCode',COUNT(__d0(__NL(Name1_Id_Code_))),COUNT(__d0(__NN(Name1_Id_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2IdCode',COUNT(__d0(__NL(Name2_Id_Code_))),COUNT(__d0(__NN(Name2_Id_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerVestingCode',COUNT(__d0(__NL(Buyer_Borrower_Vesting_Code_))),COUNT(__d0(__NN(Buyer_Borrower_Vesting_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerBorrowerAddendumFlag',COUNT(__d0(__NL(Buyer_Borrower_Addendum_Flag_))),COUNT(__d0(__NN(Buyer_Borrower_Addendum_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller1IdCode',COUNT(__d0(__NL(Seller1_Id_Code_))),COUNT(__d0(__NN(Seller1_Id_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Seller2IdCode',COUNT(__d0(__NL(Seller2_Id_Code_))),COUNT(__d0(__NN(Seller2_Id_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SellerAddendumFlag',COUNT(__d0(__NL(Seller_Addendum_Flag_))),COUNT(__d0(__NN(Seller_Addendum_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedAmount',COUNT(__d0(__NL(Assessed_Amount_))),COUNT(__d0(__NN(Assessed_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedLandValue',COUNT(__d0(__NL(Assessed_Land_Value_))),COUNT(__d0(__NN(Assessed_Land_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedImprovementValue',COUNT(__d0(__NL(Assessed_Improvement_Value_))),COUNT(__d0(__NN(Assessed_Improvement_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d0(__NL(Assessed_Total_Value_))),COUNT(__d0(__NN(Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d0(__NL(Assessed_Value_Year_))),COUNT(__d0(__NN(Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketLandValue',COUNT(__d0(__NL(Market_Land_Value_))),COUNT(__d0(__NN(Market_Land_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketImprovementValue',COUNT(__d0(__NL(Market_Improvement_Value_))),COUNT(__d0(__NN(Market_Improvement_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d0(__NL(Market_Total_Value_))),COUNT(__d0(__NN(Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d0(__NL(Market_Value_Year_))),COUNT(__d0(__NN(Market_Value_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardizedLandUseCode',COUNT(__d0(__NL(Standardized_Land_Use_Code_))),COUNT(__d0(__NN(Standardized_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyUseCode',COUNT(__d0(__NL(Property_Use_Code_))),COUNT(__d0(__NN(Property_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateLandUseCode',COUNT(__d0(__NL(State_Land_Use_Code_))),COUNT(__d0(__NN(State_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseCode',COUNT(__d0(__NL(County_Land_Use_Code_))),COUNT(__d0(__NN(County_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyLandUseDescription',COUNT(__d0(__NL(County_Land_Use_Description_))),COUNT(__d0(__NN(County_Land_Use_Description_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareCode',COUNT(__d0(__NL(Timeshare_Code_))),COUNT(__d0(__NN(Timeshare_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zoning',COUNT(__d0(__NL(Zoning_))),COUNT(__d0(__NN(Zoning_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoCode',COUNT(__d0(__NL(Condo_Code_))),COUNT(__d0(__NN(Condo_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaCounter',COUNT(__d0(__NL(Building_Area_Counter_))),COUNT(__d0(__NN(Building_Area_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d0(__NL(Building_Area_))),COUNT(__d0(__NN(Building_Area_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingAreaIndicator',COUNT(__d0(__NL(Building_Area_Indicator_))),COUNT(__d0(__NN(Building_Area_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d0(__NL(Number_Of_Buildings_))),COUNT(__d0(__NN(Number_Of_Buildings_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d0(__NL(Number_Of_Stories_))),COUNT(__d0(__NN(Number_Of_Stories_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d0(__NL(Number_Of_Units_))),COUNT(__d0(__NN(Number_Of_Units_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d0(__NL(Number_Of_Rooms_))),COUNT(__d0(__NN(Number_Of_Rooms_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d0(__NL(Number_Of_Bedrooms_))),COUNT(__d0(__NN(Number_Of_Bedrooms_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d0(__NL(Number_Of_Baths_))),COUNT(__d0(__NN(Number_Of_Baths_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d0(__NL(Number_Of_Partial_Baths_))),COUNT(__d0(__NN(Number_Of_Partial_Baths_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPlumbingFixtures',COUNT(__d0(__NL(Number_Of_Plumbing_Fixtures_))),COUNT(__d0(__NN(Number_Of_Plumbing_Fixtures_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d0(__NL(Garage_Type_Code_))),COUNT(__d0(__NN(Garage_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d0(__NL(Parking_Number_Of_Cars_))),COUNT(__d0(__NN(Parking_Number_Of_Cars_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PoolCode',COUNT(__d0(__NL(Pool_Code_))),COUNT(__d0(__NN(Pool_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d0(__NL(Style_Code_))),COUNT(__d0(__NN(Style_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeConstructionCode',COUNT(__d0(__NL(Type_Construction_Code_))),COUNT(__d0(__NN(Type_Construction_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FoundationCode',COUNT(__d0(__NL(Foundation_Code_))),COUNT(__d0(__NN(Foundation_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingQualityCode',COUNT(__d0(__NL(Building_Quality_Code_))),COUNT(__d0(__NN(Building_Quality_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingConditionCode',COUNT(__d0(__NL(Building_Condition_Code_))),COUNT(__d0(__NN(Building_Condition_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExteriorWallsCode',COUNT(__d0(__NL(Exterior_Walls_Code_))),COUNT(__d0(__NN(Exterior_Walls_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InteriorWallsCode',COUNT(__d0(__NL(Interior_Walls_Code_))),COUNT(__d0(__NN(Interior_Walls_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofCoverCode',COUNT(__d0(__NL(Roof_Cover_Code_))),COUNT(__d0(__NN(Roof_Cover_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RoofTypeCode',COUNT(__d0(__NL(Roof_Type_Code_))),COUNT(__d0(__NN(Roof_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FloorCoverCode',COUNT(__d0(__NL(Floor_Cover_Code_))),COUNT(__d0(__NN(Floor_Cover_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WaterCode',COUNT(__d0(__NL(Water_Code_))),COUNT(__d0(__NN(Water_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SewerCode',COUNT(__d0(__NL(Sewer_Code_))),COUNT(__d0(__NN(Sewer_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingCode',COUNT(__d0(__NL(Heating_Code_))),COUNT(__d0(__NN(Heating_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeatingFuelTypeCode',COUNT(__d0(__NL(Heating_Fuel_Type_Code_))),COUNT(__d0(__NN(Heating_Fuel_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningCode',COUNT(__d0(__NL(Air_Conditioning_Code_))),COUNT(__d0(__NN(Air_Conditioning_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirConditioningTypeCode',COUNT(__d0(__NL(Air_Conditioning_Type_Code_))),COUNT(__d0(__NN(Air_Conditioning_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Elevator',COUNT(__d0(__NL(Elevator_))),COUNT(__d0(__NN(Elevator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d0(__NL(Fireplace_Indicator_))),COUNT(__d0(__NN(Fireplace_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceNumber',COUNT(__d0(__NL(Fireplace_Number_))),COUNT(__d0(__NN(Fireplace_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BasementCode',COUNT(__d0(__NL(Basement_Code_))),COUNT(__d0(__NN(Basement_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingClassCode',COUNT(__d0(__NL(Building_Class_Code_))),COUNT(__d0(__NN(Building_Class_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCounter',COUNT(__d0(__NL(Site_Influence_Counter_))),COUNT(__d0(__NN(Site_Influence_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SiteInfluenceCode',COUNT(__d0(__NL(Site_Influence_Code_))),COUNT(__d0(__NN(Site_Influence_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCounter',COUNT(__d0(__NL(Amenity_Counter_))),COUNT(__d0(__NN(Amenity_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AmenityCode',COUNT(__d0(__NL(Amenity_Code_))),COUNT(__d0(__NN(Amenity_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureCounter',COUNT(__d0(__NL(Extra_Feature_Counter_))),COUNT(__d0(__NN(Extra_Feature_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureArea',COUNT(__d0(__NL(Extra_Feature_Area_))),COUNT(__d0(__NN(Extra_Feature_Area_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtraFeatureIndicator',COUNT(__d0(__NL(Extra_Feature_Indicator_))),COUNT(__d0(__NN(Extra_Feature_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCounter',COUNT(__d0(__NL(Other_Building_Counter_))),COUNT(__d0(__NN(Other_Building_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherBuildingCode',COUNT(__d0(__NL(Other_Building_Code_))),COUNT(__d0(__NN(Other_Building_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingCounter',COUNT(__d0(__NL(Other_Important_Building_Counter_))),COUNT(__d0(__NN(Other_Important_Building_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingIndicator',COUNT(__d0(__NL(Other_Important_Building_Indicator_))),COUNT(__d0(__NN(Other_Important_Building_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherImportantBuildingArea',COUNT(__d0(__NL(Other_Important_Building_Area_))),COUNT(__d0(__NN(Other_Important_Building_Area_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TopograpyCode',COUNT(__d0(__NL(Topograpy_Code_))),COUNT(__d0(__NN(Topograpy_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodCode',COUNT(__d0(__NL(Neighborhood_Code_))),COUNT(__d0(__NN(Neighborhood_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CondoProjectOrBuildingName',COUNT(__d0(__NL(Condo_Project_Or_Building_Name_))),COUNT(__d0(__NN(Condo_Project_Or_Building_Name_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OtherRoomsIndicator',COUNT(__d0(__NL(Other_Rooms_Indicator_))),COUNT(__d0(__NN(Other_Rooms_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Comments',COUNT(__d0(__NL(Comments_))),COUNT(__d0(__NN(Comments_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d0(__NL(Certification_Date_))),COUNT(__d0(__NN(Certification_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HawaiiTransferCertificateOfTitle',COUNT(__d0(__NL(Hawaii_Transfer_Certificate_Of_Title_))),COUNT(__d0(__NN(Hawaii_Transfer_Certificate_Of_Title_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d0(__NL(Lot_Size_))),COUNT(__d0(__NN(Lot_Size_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeAcres',COUNT(__d0(__NL(Lot_Size_Acres_))),COUNT(__d0(__NN(Lot_Size_Acres_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeFrontageFeet',COUNT(__d0(__NL(Lot_Size_Frontage_Feet_))),COUNT(__d0(__NN(Lot_Size_Frontage_Feet_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSizeDepthFeet',COUNT(__d0(__NL(Lot_Size_Depth_Feet_))),COUNT(__d0(__NN(Lot_Size_Depth_Feet_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandAcres',COUNT(__d0(__NL(Land_Acres_))),COUNT(__d0(__NN(Land_Acres_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d0(__NL(Land_Square_Footage_))),COUNT(__d0(__NN(Land_Square_Footage_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandDimensions',COUNT(__d0(__NL(Land_Dimensions_))),COUNT(__d0(__NN(Land_Dimensions_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotCode',COUNT(__d0(__NL(Legal_Lot_Code_))),COUNT(__d0(__NN(Legal_Lot_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLotNumber',COUNT(__d0(__NL(Legal_Lot_Number_))),COUNT(__d0(__NN(Legal_Lot_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBlock',COUNT(__d0(__NL(Legal_Block_))),COUNT(__d0(__NN(Legal_Block_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSection',COUNT(__d0(__NL(Legal_Section_))),COUNT(__d0(__NN(Legal_Section_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalDistrict',COUNT(__d0(__NL(Legal_District_))),COUNT(__d0(__NN(Legal_District_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalLandLot',COUNT(__d0(__NL(Legal_Land_Lot_))),COUNT(__d0(__NN(Legal_Land_Lot_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalUnit',COUNT(__d0(__NL(Legal_Unit_))),COUNT(__d0(__NN(Legal_Unit_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCityMunicipalityTownship',COUNT(__d0(__NL(Legal_City_Municipality_Township_))),COUNT(__d0(__NN(Legal_City_Municipality_Township_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSubdivisionName',COUNT(__d0(__NL(Legal_Subdivision_Name_))),COUNT(__d0(__NN(Legal_Subdivision_Name_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalPhaseNumber',COUNT(__d0(__NL(Legal_Phase_Number_))),COUNT(__d0(__NN(Legal_Phase_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalTractNumber',COUNT(__d0(__NL(Legal_Tract_Number_))),COUNT(__d0(__NN(Legal_Tract_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalSectionTownshipRangeMeridian',COUNT(__d0(__NL(Legal_Section_Township_Range_Meridian_))),COUNT(__d0(__NN(Legal_Section_Township_Range_Meridian_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalBriefDescription',COUNT(__d0(__NL(Legal_Brief_Description_))),COUNT(__d0(__NN(Legal_Brief_Description_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalCompleteDescriptionCode',COUNT(__d0(__NL(Legal_Complete_Description_Code_))),COUNT(__d0(__NN(Legal_Complete_Description_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CensusTract',COUNT(__d0(__NL(Census_Tract_))),COUNT(__d0(__NN(Census_Tract_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MapReference',COUNT(__d0(__NL(Map_Reference_))),COUNT(__d0(__NN(Map_Reference_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordingDate',COUNT(__d0(__NL(Recording_Date_))),COUNT(__d0(__NN(Recording_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentNumber',COUNT(__d0(__NL(Document_Number_))),COUNT(__d0(__NN(Document_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentTypeCode',COUNT(__d0(__NL(Document_Type_Code_))),COUNT(__d0(__NN(Document_Type_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderBookNumber',COUNT(__d0(__NL(Recorder_Book_Number_))),COUNT(__d0(__NN(Recorder_Book_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecorderPageNumber',COUNT(__d0(__NL(Recorder_Page_Number_))),COUNT(__d0(__NN(Recorder_Page_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConcurrentMortgageBookPageDocumentNumber',COUNT(__d0(__NL(Concurrent_Mortgage_Book_Page_Document_Number_))),COUNT(__d0(__NN(Concurrent_Mortgage_Book_Page_Document_Number_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransferDate',COUNT(__d0(__NL(Transfer_Date_))),COUNT(__d0(__NN(Transfer_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d0(__NL(Previous_Recording_Date_))),COUNT(__d0(__NN(Previous_Recording_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CityTransferTax',COUNT(__d0(__NL(City_Transfer_Tax_))),COUNT(__d0(__NN(City_Transfer_Tax_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyTransferTax',COUNT(__d0(__NL(County_Transfer_Tax_))),COUNT(__d0(__NN(County_Transfer_Tax_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalTransferTax',COUNT(__d0(__NL(Total_Transfer_Tax_))),COUNT(__d0(__NN(Total_Transfer_Tax_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomesteadHomeOwnerExemption',COUNT(__d0(__NL(Homestead_Home_Owner_Exemption_))),COUNT(__d0(__NN(Homestead_Home_Owner_Exemption_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxRateCodeArea',COUNT(__d0(__NL(Tax_Rate_Code_Area_))),COUNT(__d0(__NN(Tax_Rate_Code_Area_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCodeCounter',COUNT(__d0(__NL(Tax_Exemption_Code_Counter_))),COUNT(__d0(__NN(Tax_Exemption_Code_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxExemptionCode',COUNT(__d0(__NL(Tax_Exemption_Code_))),COUNT(__d0(__NN(Tax_Exemption_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxAmount',COUNT(__d0(__NL(Tax_Amount_))),COUNT(__d0(__NN(Tax_Amount_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d0(__NL(Tax_Year_))),COUNT(__d0(__NN(Tax_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxDelinquentYear',COUNT(__d0(__NL(Tax_Delinquent_Year_))),COUNT(__d0(__NN(Tax_Delinquent_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictCounter',COUNT(__d0(__NL(School_Tax_District_Counter_))),COUNT(__d0(__NN(School_Tax_District_Counter_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrict',COUNT(__d0(__NL(School_Tax_District_))),COUNT(__d0(__NN(School_Tax_District_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolTaxDistrictIndicator',COUNT(__d0(__NL(School_Tax_District_Indicator_))),COUNT(__d0(__NN(School_Tax_District_Indicator_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
