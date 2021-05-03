//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Property,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
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
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),lnfaresid(DEFAULT:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_:\'\'),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isassessment(DEFAULT:Is_Assessment_),processdate(DEFAULT:Process_Date_:DATE),vendorsourcecode(DEFAULT:Vendor_Source_Code_:\'\'),currentrecord(DEFAULT:Current_Record_),mailingcitystatezip(DEFAULT:Mailing_City_State_Zip_:\'\'),propertyfullstreetaddress(DEFAULT:Property_Full_Street_Address_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),recordingdate(DEFAULT:Recording_Date_:DATE),saledate(DEFAULT:Sale_Date_:DATE),documenttypecode(DEFAULT:Document_Type_Code_:\'\'),saleprice(DEFAULT:Sale_Price_:0),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxyear(DEFAULT:Tax_Year_:DATE),lotsize(DEFAULT:Lot_Size_:0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),buildingarea(DEFAULT:Building_Area_:0),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),stylecode(DEFAULT:Style_Code_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name2(DEFAULT:Name2_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_PropertyV2__Key_Assessor_Fid(ln_fares_id != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  SHARED __d1_KELfiltered := __in.Dataset_PropertyV2__Key_Deed_Fid_Fid(ln_fares_id != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  SHARED __d2_KELfiltered := __in.Dataset_PropertyV2__Key_Search_Fid(ln_fares_id != '' AND propertyaddress);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ln_fares_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
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
  SHARED Recording_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Previous_Recording_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Assessed_Value_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Market_Value_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Tax_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Year_Built_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Effective_Year_Built_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Tape_Cut_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_:\'\'),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),processdate(DEFAULT:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),current_record(OVERRIDE:Current_Record_),mailing_city_state_zip(OVERRIDE:Mailing_City_State_Zip_:\'\'),property_full_street_address(OVERRIDE:Property_Full_Street_Address_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),standardized_land_use_code(OVERRIDE:Standardized_Land_Use_Code_:\'\'),owner_occupied(OVERRIDE:Occupant_Owned_),recording_date(OVERRIDE:Recording_Date_:DATE:Recording_Date_0Rule),sale_date(OVERRIDE:Sale_Date_:DATE),document_type(OVERRIDE:Document_Type_Code_:\'\'),sales_price(OVERRIDE:Sale_Price_:0),mortgage_loan_amount(OVERRIDE:Mortgage_Amount_:0),mortgage_loan_type_code(OVERRIDE:Mortgage_Type_:\'\'),prior_recording_date(OVERRIDE:Previous_Recording_Date_:DATE:Previous_Recording_Date_0Rule),prior_sales_price(OVERRIDE:Previous_Sale_Price_:0),assessed_total_value(OVERRIDE:Assessed_Total_Value_:0),assessed_value_year(OVERRIDE:Assessed_Value_Year_:DATE:Assessed_Value_Year_0Rule),market_total_value(OVERRIDE:Market_Total_Value_:0),market_value_year(OVERRIDE:Market_Value_Year_:DATE:Market_Value_Year_0Rule),tax_year(OVERRIDE:Tax_Year_:DATE:Tax_Year_0Rule),lot_size(OVERRIDE:Lot_Size_:0),land_square_footage(OVERRIDE:Land_Square_Footage_:0.0),building_area(OVERRIDE:Building_Area_:0),year_built(OVERRIDE:Year_Built_:DATE:Year_Built_0Rule),effective_year_built(OVERRIDE:Effective_Year_Built_:DATE:Effective_Year_Built_0Rule),no_of_buildings(OVERRIDE:Number_Of_Buildings_:0),no_of_stories(OVERRIDE:Number_Of_Stories_:\'\'),no_of_units(OVERRIDE:Number_Of_Units_:0),no_of_rooms(OVERRIDE:Number_Of_Rooms_:0),no_of_bedrooms(OVERRIDE:Number_Of_Bedrooms_:\'\'),no_of_baths(OVERRIDE:Number_Of_Baths_:0.0),no_of_partial_baths(OVERRIDE:Number_Of_Partial_Baths_:\'\'),garage_type_code(OVERRIDE:Garage_Type_Code_:\'\'),parking_no_of_cars(OVERRIDE:Parking_Number_Of_Cars_:0),style_code(OVERRIDE:Style_Code_:\'\'),fireplace_indicator(OVERRIDE:Fireplace_Indicator_),tape_cut_date(OVERRIDE:Tape_Cut_Date_:DATE:Tape_Cut_Date_0Rule),certification_date(OVERRIDE:Certification_Date_:DATE),ln_mobile_home_indicator(OVERRIDE:L_N_Mobile_Home_Indicator_),ln_condo_indicator(OVERRIDE:L_N_Condo_Indicator_),ln_property_tax_exemption(OVERRIDE:L_N_Property_Tax_Exemption_Indicator_),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name2(DEFAULT:Name2_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Assessment_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Assessor_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Assessor_Fid),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Assessor_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d0_Prop__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d0_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_UID_Mapped,'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange','__in');
  SHARED __d0_Prop__Mapped := IF(__d0_Missing_Prop__UIDComponents = 'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange',PROJECT(__d0_UID_Mapped,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_UID_Mapped,__d0_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid := __d0_Prop__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Prop__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Recording_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Contract_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),zip5(DEFAULT:Z_I_P5_:0),secondaryrange(DEFAULT:Secondary_Range_:\'\'),Prop_(DEFAULT:Prop_:0),isassessment(DEFAULT:Is_Assessment_),process_date(OVERRIDE:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),current_record(OVERRIDE:Current_Record_),mailing_csz(OVERRIDE:Mailing_City_State_Zip_:\'\'),property_full_street_address(OVERRIDE:Property_Full_Street_Address_:\'\'),property_address_citystatezip(OVERRIDE:Property_Address_City_State_Zip_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),recording_date(OVERRIDE:Recording_Date_:DATE:Recording_Date_1Rule),saledate(DEFAULT:Sale_Date_:DATE),document_type_code(OVERRIDE:Document_Type_Code_:\'\'),sales_price(OVERRIDE:Sale_Price_:0),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxyear(DEFAULT:Tax_Year_:DATE),lotsize(DEFAULT:Lot_Size_:0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),buildingarea(DEFAULT:Building_Area_:0),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),stylecode(DEFAULT:Style_Code_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),buyer_or_borrower_ind(OVERRIDE:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(OVERRIDE:Name1_:\'\'),name2(OVERRIDE:Name2_:\'\'),contract_date(OVERRIDE:Contract_Date_:DATE:Contract_Date_1Rule),timeshare_flag(OVERRIDE:Timeshare_Flag_),land_lot_size(OVERRIDE:Land_Lot_Size_:\'\'),addl_name_flag(OVERRIDE:Additional_Name_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Deed_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Deed_Fid_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Deed_Fid_Fid),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Deed_Fid_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d1_Prop__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d1_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_UID_Mapped,'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange','__in');
  SHARED __d1_Prop__Mapped := IF(__d1_Missing_Prop__UIDComponents = 'PrimaryRange,Predirectional,PrimaryName,Suffix,Postdirectional,ZIP5,SecondaryRange',PROJECT(__d1_UID_Mapped,TRANSFORM(__d1_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_UID_Mapped,__d1_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d1_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid := __d1_Prop__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Prop__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),ln_fares_id(OVERRIDE:L_N_Fares_I_D_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),zip(OVERRIDE:Z_I_P5_:0),sec_range(OVERRIDE:Secondary_Range_:\'\'),Prop_(DEFAULT:Prop_:0),isdeed(DEFAULT:Is_Deed_),isassessment(DEFAULT:Is_Assessment_),processdate(DEFAULT:Process_Date_:DATE),vendor_source_flag(OVERRIDE:Vendor_Source_Code_:\'\'),currentrecord(DEFAULT:Current_Record_),mailingcitystatezip(DEFAULT:Mailing_City_State_Zip_:\'\'),propertyfullstreetaddress(DEFAULT:Property_Full_Street_Address_:\'\'),propertyaddresscitystatezip(DEFAULT:Property_Address_City_State_Zip_:\'\'),standardizedlandusecode(DEFAULT:Standardized_Land_Use_Code_:\'\'),occupantowned(DEFAULT:Occupant_Owned_),recordingdate(DEFAULT:Recording_Date_:DATE),saledate(DEFAULT:Sale_Date_:DATE),documenttypecode(DEFAULT:Document_Type_Code_:\'\'),saleprice(DEFAULT:Sale_Price_:0),mortgageamount(DEFAULT:Mortgage_Amount_:0),mortgagetype(DEFAULT:Mortgage_Type_:\'\'),previousrecordingdate(DEFAULT:Previous_Recording_Date_:DATE),previoussaleprice(DEFAULT:Previous_Sale_Price_:0),assessedtotalvalue(DEFAULT:Assessed_Total_Value_:0),assessedvalueyear(DEFAULT:Assessed_Value_Year_:DATE),markettotalvalue(DEFAULT:Market_Total_Value_:0),marketvalueyear(DEFAULT:Market_Value_Year_:DATE),taxyear(DEFAULT:Tax_Year_:DATE),lotsize(DEFAULT:Lot_Size_:0),landsquarefootage(DEFAULT:Land_Square_Footage_:0.0),buildingarea(DEFAULT:Building_Area_:0),yearbuilt(DEFAULT:Year_Built_:DATE),effectiveyearbuilt(DEFAULT:Effective_Year_Built_:DATE),numberofbuildings(DEFAULT:Number_Of_Buildings_:0),numberofstories(DEFAULT:Number_Of_Stories_:\'\'),numberofunits(DEFAULT:Number_Of_Units_:0),numberofrooms(DEFAULT:Number_Of_Rooms_:0),numberofbedrooms(DEFAULT:Number_Of_Bedrooms_:\'\'),numberofbaths(DEFAULT:Number_Of_Baths_:0.0),numberofpartialbaths(DEFAULT:Number_Of_Partial_Baths_:\'\'),garagetypecode(DEFAULT:Garage_Type_Code_:\'\'),parkingnumberofcars(DEFAULT:Parking_Number_Of_Cars_:0),stylecode(DEFAULT:Style_Code_:\'\'),fireplaceindicator(DEFAULT:Fireplace_Indicator_),tapecutdate(DEFAULT:Tape_Cut_Date_:DATE),certificationdate(DEFAULT:Certification_Date_:DATE),lnmobilehomeindicator(DEFAULT:L_N_Mobile_Home_Indicator_),lncondoindicator(DEFAULT:L_N_Condo_Indicator_),lnpropertytaxexemptionindicator(DEFAULT:L_N_Property_Tax_Exemption_Indicator_),buyerorborrowerorassessee(DEFAULT:Buyer_Or_Borrower_Or_Assessee_:\'\'),name1(DEFAULT:Name1_:\'\'),name2(DEFAULT:Name2_:\'\'),contractdate(DEFAULT:Contract_Date_:DATE),timeshareflag(DEFAULT:Timeshare_Flag_),landlotsize(DEFAULT:Land_Lot_Size_:\'\'),additionalnameflag(DEFAULT:Additional_Name_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Search_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Search_Fid),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Search_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.ln_fares_id) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d2_Prop__Layout := RECORD
    RECORDOF(__d2_UID_Mapped);
    KEL.typ.uid Prop_;
  END;
  SHARED __d2_Missing_Prop__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_UID_Mapped,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d2_Prop__Mapped := IF(__d2_Missing_Prop__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d2_UID_Mapped,TRANSFORM(__d2_Prop__Layout,SELF.Prop_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_UID_Mapped,__d2_Missing_Prop__UIDComponents),E_Property(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Prop__Layout,SELF.Prop_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid := __d2_Prop__Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_Prop__Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
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
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
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
    SELF.Process_Date_ := KEL.Intake.SingleValue(__recs,Process_Date_);
    SELF.Vendor_Source_Code_ := KEL.Intake.SingleValue(__recs,Vendor_Source_Code_);
    SELF.Current_Record_ := KEL.Intake.SingleValue(__recs,Current_Record_);
    SELF.Mailing_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Mailing_City_State_Zip_);
    SELF.Property_Full_Street_Address_ := KEL.Intake.SingleValue(__recs,Property_Full_Street_Address_);
    SELF.Property_Address_City_State_Zip_ := KEL.Intake.SingleValue(__recs,Property_Address_City_State_Zip_);
    SELF.Standardized_Land_Use_Code_ := KEL.Intake.SingleValue(__recs,Standardized_Land_Use_Code_);
    SELF.Occupant_Owned_ := KEL.Intake.SingleValue(__recs,Occupant_Owned_);
    SELF.Recording_Date_ := KEL.Intake.SingleValue(__recs,Recording_Date_);
    SELF.Sale_Date_ := KEL.Intake.SingleValue(__recs,Sale_Date_);
    SELF.Document_Type_Code_ := KEL.Intake.SingleValue(__recs,Document_Type_Code_);
    SELF.Sale_Price_ := KEL.Intake.SingleValue(__recs,Sale_Price_);
    SELF.Mortgage_Amount_ := KEL.Intake.SingleValue(__recs,Mortgage_Amount_);
    SELF.Mortgage_Type_ := KEL.Intake.SingleValue(__recs,Mortgage_Type_);
    SELF.Previous_Recording_Date_ := KEL.Intake.SingleValue(__recs,Previous_Recording_Date_);
    SELF.Previous_Sale_Price_ := KEL.Intake.SingleValue(__recs,Previous_Sale_Price_);
    SELF.Assessed_Total_Value_ := KEL.Intake.SingleValue(__recs,Assessed_Total_Value_);
    SELF.Assessed_Value_Year_ := KEL.Intake.SingleValue(__recs,Assessed_Value_Year_);
    SELF.Market_Total_Value_ := KEL.Intake.SingleValue(__recs,Market_Total_Value_);
    SELF.Market_Value_Year_ := KEL.Intake.SingleValue(__recs,Market_Value_Year_);
    SELF.Tax_Year_ := KEL.Intake.SingleValue(__recs,Tax_Year_);
    SELF.Lot_Size_ := KEL.Intake.SingleValue(__recs,Lot_Size_);
    SELF.Land_Square_Footage_ := KEL.Intake.SingleValue(__recs,Land_Square_Footage_);
    SELF.Building_Area_ := KEL.Intake.SingleValue(__recs,Building_Area_);
    SELF.Year_Built_ := KEL.Intake.SingleValue(__recs,Year_Built_);
    SELF.Effective_Year_Built_ := KEL.Intake.SingleValue(__recs,Effective_Year_Built_);
    SELF.Number_Of_Buildings_ := KEL.Intake.SingleValue(__recs,Number_Of_Buildings_);
    SELF.Number_Of_Stories_ := KEL.Intake.SingleValue(__recs,Number_Of_Stories_);
    SELF.Number_Of_Units_ := KEL.Intake.SingleValue(__recs,Number_Of_Units_);
    SELF.Number_Of_Rooms_ := KEL.Intake.SingleValue(__recs,Number_Of_Rooms_);
    SELF.Number_Of_Bedrooms_ := KEL.Intake.SingleValue(__recs,Number_Of_Bedrooms_);
    SELF.Number_Of_Baths_ := KEL.Intake.SingleValue(__recs,Number_Of_Baths_);
    SELF.Number_Of_Partial_Baths_ := KEL.Intake.SingleValue(__recs,Number_Of_Partial_Baths_);
    SELF.Garage_Type_Code_ := KEL.Intake.SingleValue(__recs,Garage_Type_Code_);
    SELF.Parking_Number_Of_Cars_ := KEL.Intake.SingleValue(__recs,Parking_Number_Of_Cars_);
    SELF.Style_Code_ := KEL.Intake.SingleValue(__recs,Style_Code_);
    SELF.Fireplace_Indicator_ := KEL.Intake.SingleValue(__recs,Fireplace_Indicator_);
    SELF.Tape_Cut_Date_ := KEL.Intake.SingleValue(__recs,Tape_Cut_Date_);
    SELF.Certification_Date_ := KEL.Intake.SingleValue(__recs,Certification_Date_);
    SELF.L_N_Mobile_Home_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Mobile_Home_Indicator_);
    SELF.L_N_Condo_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Condo_Indicator_);
    SELF.L_N_Property_Tax_Exemption_Indicator_ := KEL.Intake.SingleValue(__recs,L_N_Property_Tax_Exemption_Indicator_);
    SELF.Buyer_Or_Borrower_Or_Assessee_ := KEL.Intake.SingleValue(__recs,Buyer_Or_Borrower_Or_Assessee_);
    SELF.Name1_ := KEL.Intake.SingleValue(__recs,Name1_);
    SELF.Name2_ := KEL.Intake.SingleValue(__recs,Name2_);
    SELF.Contract_Date_ := KEL.Intake.SingleValue(__recs,Contract_Date_);
    SELF.Timeshare_Flag_ := KEL.Intake.SingleValue(__recs,Timeshare_Flag_);
    SELF.Land_Lot_Size_ := KEL.Intake.SingleValue(__recs,Land_Lot_Size_);
    SELF.Additional_Name_Flag_ := KEL.Intake.SingleValue(__recs,Additional_Name_Flag_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Property_Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Property_Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Property_Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Property_Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Property_Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT L_N_Fares_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,L_N_Fares_I_D_);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Postdirectional_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Z_I_P5_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Secondary_Range_);
  EXPORT Prop__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prop_);
  EXPORT Is_Deed__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Is_Deed_);
  EXPORT Is_Assessment__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Is_Assessment_);
  EXPORT Process_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Process_Date_);
  EXPORT Vendor_Source_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Vendor_Source_Code_);
  EXPORT Current_Record__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Record_);
  EXPORT Mailing_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Mailing_City_State_Zip_);
  EXPORT Property_Full_Street_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Property_Full_Street_Address_);
  EXPORT Property_Address_City_State_Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Property_Address_City_State_Zip_);
  EXPORT Standardized_Land_Use_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Standardized_Land_Use_Code_);
  EXPORT Occupant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Occupant_Owned_);
  EXPORT Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Recording_Date_);
  EXPORT Sale_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sale_Date_);
  EXPORT Document_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Document_Type_Code_);
  EXPORT Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sale_Price_);
  EXPORT Mortgage_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Mortgage_Amount_);
  EXPORT Mortgage_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Mortgage_Type_);
  EXPORT Previous_Recording_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Previous_Recording_Date_);
  EXPORT Previous_Sale_Price__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Previous_Sale_Price_);
  EXPORT Assessed_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Assessed_Total_Value_);
  EXPORT Assessed_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Assessed_Value_Year_);
  EXPORT Market_Total_Value__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Market_Total_Value_);
  EXPORT Market_Value_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Market_Value_Year_);
  EXPORT Tax_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Tax_Year_);
  EXPORT Lot_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Lot_Size_);
  EXPORT Land_Square_Footage__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Land_Square_Footage_);
  EXPORT Building_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Building_Area_);
  EXPORT Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Year_Built_);
  EXPORT Effective_Year_Built__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Effective_Year_Built_);
  EXPORT Number_Of_Buildings__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Buildings_);
  EXPORT Number_Of_Stories__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Stories_);
  EXPORT Number_Of_Units__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Units_);
  EXPORT Number_Of_Rooms__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Rooms_);
  EXPORT Number_Of_Bedrooms__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Bedrooms_);
  EXPORT Number_Of_Baths__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Baths_);
  EXPORT Number_Of_Partial_Baths__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Number_Of_Partial_Baths_);
  EXPORT Garage_Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Garage_Type_Code_);
  EXPORT Parking_Number_Of_Cars__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Parking_Number_Of_Cars_);
  EXPORT Style_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Style_Code_);
  EXPORT Fireplace_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Fireplace_Indicator_);
  EXPORT Tape_Cut_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Tape_Cut_Date_);
  EXPORT Certification_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Certification_Date_);
  EXPORT L_N_Mobile_Home_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,L_N_Mobile_Home_Indicator_);
  EXPORT L_N_Condo_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,L_N_Condo_Indicator_);
  EXPORT L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,L_N_Property_Tax_Exemption_Indicator_);
  EXPORT Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Buyer_Or_Borrower_Or_Assessee_);
  EXPORT Name1__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Name1_);
  EXPORT Name2__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Name2_);
  EXPORT Contract_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Contract_Date_);
  EXPORT Timeshare_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Timeshare_Flag_);
  EXPORT Land_Lot_Size__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Land_Lot_Size_);
  EXPORT Additional_Name_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Additional_Name_Flag_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Prop__Orphan := JOIN(InData(__NN(Prop_)),E_Property(__in,__cfg).__Result,__EEQP(LEFT.Prop_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(Prop__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(L_N_Fares_I_D__SingleValue_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Prop__SingleValue_Invalid),COUNT(Is_Deed__SingleValue_Invalid),COUNT(Is_Assessment__SingleValue_Invalid),COUNT(Process_Date__SingleValue_Invalid),COUNT(Vendor_Source_Code__SingleValue_Invalid),COUNT(Current_Record__SingleValue_Invalid),COUNT(Mailing_City_State_Zip__SingleValue_Invalid),COUNT(Property_Full_Street_Address__SingleValue_Invalid),COUNT(Property_Address_City_State_Zip__SingleValue_Invalid),COUNT(Standardized_Land_Use_Code__SingleValue_Invalid),COUNT(Occupant_Owned__SingleValue_Invalid),COUNT(Recording_Date__SingleValue_Invalid),COUNT(Sale_Date__SingleValue_Invalid),COUNT(Document_Type_Code__SingleValue_Invalid),COUNT(Sale_Price__SingleValue_Invalid),COUNT(Mortgage_Amount__SingleValue_Invalid),COUNT(Mortgage_Type__SingleValue_Invalid),COUNT(Previous_Recording_Date__SingleValue_Invalid),COUNT(Previous_Sale_Price__SingleValue_Invalid),COUNT(Assessed_Total_Value__SingleValue_Invalid),COUNT(Assessed_Value_Year__SingleValue_Invalid),COUNT(Market_Total_Value__SingleValue_Invalid),COUNT(Market_Value_Year__SingleValue_Invalid),COUNT(Tax_Year__SingleValue_Invalid),COUNT(Lot_Size__SingleValue_Invalid),COUNT(Land_Square_Footage__SingleValue_Invalid),COUNT(Building_Area__SingleValue_Invalid),COUNT(Year_Built__SingleValue_Invalid),COUNT(Effective_Year_Built__SingleValue_Invalid),COUNT(Number_Of_Buildings__SingleValue_Invalid),COUNT(Number_Of_Stories__SingleValue_Invalid),COUNT(Number_Of_Units__SingleValue_Invalid),COUNT(Number_Of_Rooms__SingleValue_Invalid),COUNT(Number_Of_Bedrooms__SingleValue_Invalid),COUNT(Number_Of_Baths__SingleValue_Invalid),COUNT(Number_Of_Partial_Baths__SingleValue_Invalid),COUNT(Garage_Type_Code__SingleValue_Invalid),COUNT(Parking_Number_Of_Cars__SingleValue_Invalid),COUNT(Style_Code__SingleValue_Invalid),COUNT(Fireplace_Indicator__SingleValue_Invalid),COUNT(Tape_Cut_Date__SingleValue_Invalid),COUNT(Certification_Date__SingleValue_Invalid),COUNT(L_N_Mobile_Home_Indicator__SingleValue_Invalid),COUNT(L_N_Condo_Indicator__SingleValue_Invalid),COUNT(L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid),COUNT(Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid),COUNT(Name1__SingleValue_Invalid),COUNT(Name2__SingleValue_Invalid),COUNT(Contract_Date__SingleValue_Invalid),COUNT(Timeshare_Flag__SingleValue_Invalid),COUNT(Land_Lot_Size__SingleValue_Invalid),COUNT(Additional_Name_Flag__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Prop__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid,KEL.typ.int L_N_Fares_I_D__SingleValue_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Prop__SingleValue_Invalid,KEL.typ.int Is_Deed__SingleValue_Invalid,KEL.typ.int Is_Assessment__SingleValue_Invalid,KEL.typ.int Process_Date__SingleValue_Invalid,KEL.typ.int Vendor_Source_Code__SingleValue_Invalid,KEL.typ.int Current_Record__SingleValue_Invalid,KEL.typ.int Mailing_City_State_Zip__SingleValue_Invalid,KEL.typ.int Property_Full_Street_Address__SingleValue_Invalid,KEL.typ.int Property_Address_City_State_Zip__SingleValue_Invalid,KEL.typ.int Standardized_Land_Use_Code__SingleValue_Invalid,KEL.typ.int Occupant_Owned__SingleValue_Invalid,KEL.typ.int Recording_Date__SingleValue_Invalid,KEL.typ.int Sale_Date__SingleValue_Invalid,KEL.typ.int Document_Type_Code__SingleValue_Invalid,KEL.typ.int Sale_Price__SingleValue_Invalid,KEL.typ.int Mortgage_Amount__SingleValue_Invalid,KEL.typ.int Mortgage_Type__SingleValue_Invalid,KEL.typ.int Previous_Recording_Date__SingleValue_Invalid,KEL.typ.int Previous_Sale_Price__SingleValue_Invalid,KEL.typ.int Assessed_Total_Value__SingleValue_Invalid,KEL.typ.int Assessed_Value_Year__SingleValue_Invalid,KEL.typ.int Market_Total_Value__SingleValue_Invalid,KEL.typ.int Market_Value_Year__SingleValue_Invalid,KEL.typ.int Tax_Year__SingleValue_Invalid,KEL.typ.int Lot_Size__SingleValue_Invalid,KEL.typ.int Land_Square_Footage__SingleValue_Invalid,KEL.typ.int Building_Area__SingleValue_Invalid,KEL.typ.int Year_Built__SingleValue_Invalid,KEL.typ.int Effective_Year_Built__SingleValue_Invalid,KEL.typ.int Number_Of_Buildings__SingleValue_Invalid,KEL.typ.int Number_Of_Stories__SingleValue_Invalid,KEL.typ.int Number_Of_Units__SingleValue_Invalid,KEL.typ.int Number_Of_Rooms__SingleValue_Invalid,KEL.typ.int Number_Of_Bedrooms__SingleValue_Invalid,KEL.typ.int Number_Of_Baths__SingleValue_Invalid,KEL.typ.int Number_Of_Partial_Baths__SingleValue_Invalid,KEL.typ.int Garage_Type_Code__SingleValue_Invalid,KEL.typ.int Parking_Number_Of_Cars__SingleValue_Invalid,KEL.typ.int Style_Code__SingleValue_Invalid,KEL.typ.int Fireplace_Indicator__SingleValue_Invalid,KEL.typ.int Tape_Cut_Date__SingleValue_Invalid,KEL.typ.int Certification_Date__SingleValue_Invalid,KEL.typ.int L_N_Mobile_Home_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Condo_Indicator__SingleValue_Invalid,KEL.typ.int L_N_Property_Tax_Exemption_Indicator__SingleValue_Invalid,KEL.typ.int Buyer_Or_Borrower_Or_Assessee__SingleValue_Invalid,KEL.typ.int Name1__SingleValue_Invalid,KEL.typ.int Name2__SingleValue_Invalid,KEL.typ.int Contract_Date__SingleValue_Invalid,KEL.typ.int Timeshare_Flag__SingleValue_Invalid,KEL.typ.int Land_Lot_Size__SingleValue_Invalid,KEL.typ.int Additional_Name_Flag__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Assessor_Fid_Invalid),COUNT(__d0)},
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
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d0(__NL(Vendor_Source_Code_))),COUNT(__d0(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record',COUNT(__d0(__NL(Current_Record_))),COUNT(__d0(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_city_state_zip',COUNT(__d0(__NL(Mailing_City_State_Zip_))),COUNT(__d0(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_full_street_address',COUNT(__d0(__NL(Property_Full_Street_Address_))),COUNT(__d0(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCityStateZip',COUNT(__d0(__NL(Property_Address_City_State_Zip_))),COUNT(__d0(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','standardized_land_use_code',COUNT(__d0(__NL(Standardized_Land_Use_Code_))),COUNT(__d0(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owner_occupied',COUNT(__d0(__NL(Occupant_Owned_))),COUNT(__d0(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d0(__NL(Recording_Date_))),COUNT(__d0(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sale_date',COUNT(__d0(__NL(Sale_Date_))),COUNT(__d0(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_type',COUNT(__d0(__NL(Document_Type_Code_))),COUNT(__d0(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price',COUNT(__d0(__NL(Sale_Price_))),COUNT(__d0(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_loan_amount',COUNT(__d0(__NL(Mortgage_Amount_))),COUNT(__d0(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mortgage_loan_type_code',COUNT(__d0(__NL(Mortgage_Type_))),COUNT(__d0(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_recording_date',COUNT(__d0(__NL(Previous_Recording_Date_))),COUNT(__d0(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_sales_price',COUNT(__d0(__NL(Previous_Sale_Price_))),COUNT(__d0(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_total_value',COUNT(__d0(__NL(Assessed_Total_Value_))),COUNT(__d0(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_value_year',COUNT(__d0(__NL(Assessed_Value_Year_))),COUNT(__d0(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_total_value',COUNT(__d0(__NL(Market_Total_Value_))),COUNT(__d0(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_value_year',COUNT(__d0(__NL(Market_Value_Year_))),COUNT(__d0(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_year',COUNT(__d0(__NL(Tax_Year_))),COUNT(__d0(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_size',COUNT(__d0(__NL(Lot_Size_))),COUNT(__d0(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_square_footage',COUNT(__d0(__NL(Land_Square_Footage_))),COUNT(__d0(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','building_area',COUNT(__d0(__NL(Building_Area_))),COUNT(__d0(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','year_built',COUNT(__d0(__NL(Year_Built_))),COUNT(__d0(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','effective_year_built',COUNT(__d0(__NL(Effective_Year_Built_))),COUNT(__d0(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_buildings',COUNT(__d0(__NL(Number_Of_Buildings_))),COUNT(__d0(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_stories',COUNT(__d0(__NL(Number_Of_Stories_))),COUNT(__d0(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_units',COUNT(__d0(__NL(Number_Of_Units_))),COUNT(__d0(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_rooms',COUNT(__d0(__NL(Number_Of_Rooms_))),COUNT(__d0(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_bedrooms',COUNT(__d0(__NL(Number_Of_Bedrooms_))),COUNT(__d0(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_baths',COUNT(__d0(__NL(Number_Of_Baths_))),COUNT(__d0(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','no_of_partial_baths',COUNT(__d0(__NL(Number_Of_Partial_Baths_))),COUNT(__d0(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','garage_type_code',COUNT(__d0(__NL(Garage_Type_Code_))),COUNT(__d0(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','parking_no_of_cars',COUNT(__d0(__NL(Parking_Number_Of_Cars_))),COUNT(__d0(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','style_code',COUNT(__d0(__NL(Style_Code_))),COUNT(__d0(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fireplace_indicator',COUNT(__d0(__NL(Fireplace_Indicator_))),COUNT(__d0(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tape_cut_date',COUNT(__d0(__NL(Tape_Cut_Date_))),COUNT(__d0(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','certification_date',COUNT(__d0(__NL(Certification_Date_))),COUNT(__d0(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_mobile_home_indicator',COUNT(__d0(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d0(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_condo_indicator',COUNT(__d0(__NL(L_N_Condo_Indicator_))),COUNT(__d0(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_property_tax_exemption',COUNT(__d0(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d0(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d0(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d0(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1',COUNT(__d0(__NL(Name1_))),COUNT(__d0(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2',COUNT(__d0(__NL(Name2_))),COUNT(__d0(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d0(__NL(Contract_Date_))),COUNT(__d0(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareFlag',COUNT(__d0(__NL(Timeshare_Flag_))),COUNT(__d0(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandLotSize',COUNT(__d0(__NL(Land_Lot_Size_))),COUNT(__d0(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalNameFlag',COUNT(__d0(__NL(Additional_Name_Flag_))),COUNT(__d0(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Deed_Fid_Fid_Invalid),COUNT(__d1)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d1(__NL(L_N_Fares_I_D_))),COUNT(__d1(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Predirectional',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Postdirectional',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP5',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryRange',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d1(__NL(Prop_))),COUNT(__d1(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d1(__NL(Is_Assessment_))),COUNT(__d1(__NN(Is_Assessment_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d1(__NL(Process_Date_))),COUNT(__d1(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d1(__NL(Vendor_Source_Code_))),COUNT(__d1(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record',COUNT(__d1(__NL(Current_Record_))),COUNT(__d1(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mailing_csz',COUNT(__d1(__NL(Mailing_City_State_Zip_))),COUNT(__d1(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_full_street_address',COUNT(__d1(__NL(Property_Full_Street_Address_))),COUNT(__d1(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','property_address_citystatezip',COUNT(__d1(__NL(Property_Address_City_State_Zip_))),COUNT(__d1(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardizedLandUseCode',COUNT(__d1(__NL(Standardized_Land_Use_Code_))),COUNT(__d1(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d1(__NL(Occupant_Owned_))),COUNT(__d1(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d1(__NL(Recording_Date_))),COUNT(__d1(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate',COUNT(__d1(__NL(Sale_Date_))),COUNT(__d1(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_type_code',COUNT(__d1(__NL(Document_Type_Code_))),COUNT(__d1(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price',COUNT(__d1(__NL(Sale_Price_))),COUNT(__d1(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d1(__NL(Mortgage_Amount_))),COUNT(__d1(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d1(__NL(Mortgage_Type_))),COUNT(__d1(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d1(__NL(Previous_Recording_Date_))),COUNT(__d1(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d1(__NL(Previous_Sale_Price_))),COUNT(__d1(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d1(__NL(Assessed_Total_Value_))),COUNT(__d1(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d1(__NL(Assessed_Value_Year_))),COUNT(__d1(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d1(__NL(Market_Total_Value_))),COUNT(__d1(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d1(__NL(Market_Value_Year_))),COUNT(__d1(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d1(__NL(Tax_Year_))),COUNT(__d1(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d1(__NL(Lot_Size_))),COUNT(__d1(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d1(__NL(Land_Square_Footage_))),COUNT(__d1(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d1(__NL(Building_Area_))),COUNT(__d1(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d1(__NL(Year_Built_))),COUNT(__d1(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d1(__NL(Effective_Year_Built_))),COUNT(__d1(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d1(__NL(Number_Of_Buildings_))),COUNT(__d1(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d1(__NL(Number_Of_Stories_))),COUNT(__d1(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d1(__NL(Number_Of_Units_))),COUNT(__d1(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d1(__NL(Number_Of_Rooms_))),COUNT(__d1(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d1(__NL(Number_Of_Bedrooms_))),COUNT(__d1(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d1(__NL(Number_Of_Baths_))),COUNT(__d1(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d1(__NL(Number_Of_Partial_Baths_))),COUNT(__d1(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d1(__NL(Garage_Type_Code_))),COUNT(__d1(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d1(__NL(Parking_Number_Of_Cars_))),COUNT(__d1(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d1(__NL(Style_Code_))),COUNT(__d1(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d1(__NL(Fireplace_Indicator_))),COUNT(__d1(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TapeCutDate',COUNT(__d1(__NL(Tape_Cut_Date_))),COUNT(__d1(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d1(__NL(Certification_Date_))),COUNT(__d1(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMobileHomeIndicator',COUNT(__d1(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d1(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCondoIndicator',COUNT(__d1(__NL(L_N_Condo_Indicator_))),COUNT(__d1(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyTaxExemptionIndicator',COUNT(__d1(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d1(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','buyer_or_borrower_ind',COUNT(__d1(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d1(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name1',COUNT(__d1(__NL(Name1_))),COUNT(__d1(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name2',COUNT(__d1(__NL(Name2_))),COUNT(__d1(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contract_date',COUNT(__d1(__NL(Contract_Date_))),COUNT(__d1(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','timeshare_flag',COUNT(__d1(__NL(Timeshare_Flag_))),COUNT(__d1(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_lot_size',COUNT(__d1(__NL(Land_Lot_Size_))),COUNT(__d1(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addl_name_flag',COUNT(__d1(__NL(Additional_Name_Flag_))),COUNT(__d1(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(__d2)},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_fares_id',COUNT(__d2(__NL(L_N_Fares_I_D_))),COUNT(__d2(__NN(L_N_Fares_I_D_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prop',COUNT(__d2(__NL(Prop_))),COUNT(__d2(__NN(Prop_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDeed',COUNT(__d2(__NL(Is_Deed_))),COUNT(__d2(__NN(Is_Deed_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAssessment',COUNT(__d2(__NL(Is_Assessment_))),COUNT(__d2(__NN(Is_Assessment_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d2(__NL(Process_Date_))),COUNT(__d2(__NN(Process_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_source_flag',COUNT(__d2(__NL(Vendor_Source_Code_))),COUNT(__d2(__NN(Vendor_Source_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRecord',COUNT(__d2(__NL(Current_Record_))),COUNT(__d2(__NN(Current_Record_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MailingCityStateZip',COUNT(__d2(__NL(Mailing_City_State_Zip_))),COUNT(__d2(__NN(Mailing_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyFullStreetAddress',COUNT(__d2(__NL(Property_Full_Street_Address_))),COUNT(__d2(__NN(Property_Full_Street_Address_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PropertyAddressCityStateZip',COUNT(__d2(__NL(Property_Address_City_State_Zip_))),COUNT(__d2(__NN(Property_Address_City_State_Zip_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StandardizedLandUseCode',COUNT(__d2(__NL(Standardized_Land_Use_Code_))),COUNT(__d2(__NN(Standardized_Land_Use_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OccupantOwned',COUNT(__d2(__NL(Occupant_Owned_))),COUNT(__d2(__NN(Occupant_Owned_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordingDate',COUNT(__d2(__NL(Recording_Date_))),COUNT(__d2(__NN(Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SaleDate',COUNT(__d2(__NL(Sale_Date_))),COUNT(__d2(__NN(Sale_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DocumentTypeCode',COUNT(__d2(__NL(Document_Type_Code_))),COUNT(__d2(__NN(Document_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SalePrice',COUNT(__d2(__NL(Sale_Price_))),COUNT(__d2(__NN(Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageAmount',COUNT(__d2(__NL(Mortgage_Amount_))),COUNT(__d2(__NN(Mortgage_Amount_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MortgageType',COUNT(__d2(__NL(Mortgage_Type_))),COUNT(__d2(__NN(Mortgage_Type_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousRecordingDate',COUNT(__d2(__NL(Previous_Recording_Date_))),COUNT(__d2(__NN(Previous_Recording_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousSalePrice',COUNT(__d2(__NL(Previous_Sale_Price_))),COUNT(__d2(__NN(Previous_Sale_Price_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedTotalValue',COUNT(__d2(__NL(Assessed_Total_Value_))),COUNT(__d2(__NN(Assessed_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssessedValueYear',COUNT(__d2(__NL(Assessed_Value_Year_))),COUNT(__d2(__NN(Assessed_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketTotalValue',COUNT(__d2(__NL(Market_Total_Value_))),COUNT(__d2(__NN(Market_Total_Value_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MarketValueYear',COUNT(__d2(__NL(Market_Value_Year_))),COUNT(__d2(__NN(Market_Value_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TaxYear',COUNT(__d2(__NL(Tax_Year_))),COUNT(__d2(__NN(Tax_Year_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LotSize',COUNT(__d2(__NL(Lot_Size_))),COUNT(__d2(__NN(Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandSquareFootage',COUNT(__d2(__NL(Land_Square_Footage_))),COUNT(__d2(__NN(Land_Square_Footage_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuildingArea',COUNT(__d2(__NL(Building_Area_))),COUNT(__d2(__NN(Building_Area_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearBuilt',COUNT(__d2(__NL(Year_Built_))),COUNT(__d2(__NN(Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveYearBuilt',COUNT(__d2(__NL(Effective_Year_Built_))),COUNT(__d2(__NN(Effective_Year_Built_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBuildings',COUNT(__d2(__NL(Number_Of_Buildings_))),COUNT(__d2(__NN(Number_Of_Buildings_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfStories',COUNT(__d2(__NL(Number_Of_Stories_))),COUNT(__d2(__NN(Number_Of_Stories_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfUnits',COUNT(__d2(__NL(Number_Of_Units_))),COUNT(__d2(__NN(Number_Of_Units_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfRooms',COUNT(__d2(__NL(Number_Of_Rooms_))),COUNT(__d2(__NN(Number_Of_Rooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBedrooms',COUNT(__d2(__NL(Number_Of_Bedrooms_))),COUNT(__d2(__NN(Number_Of_Bedrooms_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfBaths',COUNT(__d2(__NL(Number_Of_Baths_))),COUNT(__d2(__NN(Number_Of_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfPartialBaths',COUNT(__d2(__NL(Number_Of_Partial_Baths_))),COUNT(__d2(__NN(Number_Of_Partial_Baths_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GarageTypeCode',COUNT(__d2(__NL(Garage_Type_Code_))),COUNT(__d2(__NN(Garage_Type_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParkingNumberOfCars',COUNT(__d2(__NL(Parking_Number_Of_Cars_))),COUNT(__d2(__NN(Parking_Number_Of_Cars_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d2(__NL(Style_Code_))),COUNT(__d2(__NN(Style_Code_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FireplaceIndicator',COUNT(__d2(__NL(Fireplace_Indicator_))),COUNT(__d2(__NN(Fireplace_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TapeCutDate',COUNT(__d2(__NL(Tape_Cut_Date_))),COUNT(__d2(__NN(Tape_Cut_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificationDate',COUNT(__d2(__NL(Certification_Date_))),COUNT(__d2(__NN(Certification_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNMobileHomeIndicator',COUNT(__d2(__NL(L_N_Mobile_Home_Indicator_))),COUNT(__d2(__NN(L_N_Mobile_Home_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCondoIndicator',COUNT(__d2(__NL(L_N_Condo_Indicator_))),COUNT(__d2(__NN(L_N_Condo_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNPropertyTaxExemptionIndicator',COUNT(__d2(__NL(L_N_Property_Tax_Exemption_Indicator_))),COUNT(__d2(__NN(L_N_Property_Tax_Exemption_Indicator_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BuyerOrBorrowerOrAssessee',COUNT(__d2(__NL(Buyer_Or_Borrower_Or_Assessee_))),COUNT(__d2(__NN(Buyer_Or_Borrower_Or_Assessee_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name1',COUNT(__d2(__NL(Name1_))),COUNT(__d2(__NN(Name1_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Name2',COUNT(__d2(__NL(Name2_))),COUNT(__d2(__NN(Name2_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContractDate',COUNT(__d2(__NL(Contract_Date_))),COUNT(__d2(__NN(Contract_Date_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeshareFlag',COUNT(__d2(__NL(Timeshare_Flag_))),COUNT(__d2(__NN(Timeshare_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandLotSize',COUNT(__d2(__NL(Land_Lot_Size_))),COUNT(__d2(__NN(Land_Lot_Size_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalNameFlag',COUNT(__d2(__NL(Additional_Name_Flag_))),COUNT(__d2(__NN(Additional_Name_Flag_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PropertyEvent','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
