IMPORT text_search,ut,SALT27,MDR;
 
EXPORT Property_ABooleanSearch(DATASET(layout_Property_A_Extract) ih)  := MODULE
SHARED h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := RECORD
  SALT27.UIDType rid := h.rid;
  SALT27.UIDType sid := h.sid;
  SALT27.UIDType lid := (SALT27.UIDType)h.did;
    STATE := h.state_code;
    COUNTY := h.county_name;
    APN := h.apna_or_pin_number;
    CERT_DATE := h.certification_date;
    h.assessee_name;
    h.second_assessee_name;
    h.contract_owner;
    PHONE_NUMBER := h.assessee_phone_number;
    h.mailing_full_street_address;
    h.mailing_unit_number;
    h.mailing_city_state_zip;
    h.property_full_street_address;
    h.property_unit_number;
    h.property_city_state_zip;
    LOT_DESC := h.legal_lot_desc;
    LOT_NUMBER := h.legal_lot_number;
    LAND_LOT := h.legal_land_lot;
    BLOCK := h.legal_block;
    SECTION := h.legal_section;
    DISTRICT := h.legal_district;
    UNIT := h.legal_unit;
    muni_twp := h.legal_city_municipality_township;
    SUBDIVISION := h.legal_subdivision_name;
    PHASE := h.legal_phase_number;
    TRACT := h.legal_tract_number;
    sec_twn_mer := h.legal_sec_twn_rng_mer;
    h.legal_brief_description;
    h.legal_assessor_map_ref;
    h.census_tract;
    OWNERSHIP_TYPE := h.ownership_type_desc;
    h.standardized_land_use_desc;
    h.zoning;
    h.owner_occupied;
    NUMBER := h.recorder_document_number;
    h.recorder_book_number;
    h.recorder_page_number;
    h.separator;
    h.transfer_date;
    RECORDED_DATE := h.recording_date;
    DEED_TYPE := h.document_type;
    h.sale_date;
    h.sales_price;
    prior_sale_price := h.prior_sales_price;
    sale_price_desc := h.sales_price_desc;
    LOAN_AMOUNT := h.mortgage_loan_amount;
    LOAN_TYPE := h.mortgage_loan_type_desc;
    LENDER := h.mortgage_lender_name;
    LENDER_TYPE := h.mortgage_lender_type_desc;
    h.assessed_land_value;
    ASSES_IMP_VALUE := h.assessed_improvement_value;
    h.assessed_total_value;
    YEAR_ASSESS := h.assessed_value_year;
    MAR_LAND_VALUE := h.market_land_value;
    h.market_improvement_value;
    TOT_MAR_VALUE := h.market_total_value;
    MAR_YEAR_ASSESS := h.market_value_year;
    HOMEOWNER_EXEMPT := h.homestead_homeowner_exemption;
    h.tax_exemption1_desc;
    h.tax_exemption2_desc;
    h.tax_exemption3_desc;
    h.tax_exemption4_desc;
    TAX_RATE := h.tax_rate_code_area;
    h.tax_amount;
    h.tax_year;
    h.year_built;
    EFFECT_YEAR_BUILT := h.effective_year_built;
    NEIGHBOR_DESC := h.neighborhood_desc;
    CONDO_PROJ_NAME := h.condo_project_name;
    h.building_name;
    h.tax_account_number;
    h.mailing_care_of_name;
    h.fares_non_parsed_assessee_name;
    h.fares_non_parsed_second_assessee_name;
    h.fares_land_use;
    h.fares_calculated_land_value;
    h.fares_calculated_improvement_value;
    h.fares_calculated_total_value;
    h.addl_legal;
    h.process_date;
    h.title;
    h.fname;
    h.mname;
    h.lname;
    h.name_suffix;
    h.cname;
    h.nameasis;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.suffix;
    h.postdir;
    h.unit_desig;
    h.sec_range;
    h.v_city_name;
    h.st;
    h.zip;
    h.zip4;
    h.phone_num;
    h.date_from_deed;
    h.field_from_deeds;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','0','0','','','','','','0','','0','0','0','0','0','','','','','','','','0','','','','','','','','','','','','0','0','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT27.StrType)le.state_code,(SALT27.StrType)le.county_name,(SALT27.StrType)le.apna_or_pin_number,(SALT27.StrType)le.certification_date,(SALT27.StrType)le.assessee_name,(SALT27.StrType)le.second_assessee_name,(SALT27.StrType)le.contract_owner,(SALT27.StrType)le.assessee_phone_number,(SALT27.StrType)le.mailing_full_street_address,(SALT27.StrType)le.mailing_unit_number,(SALT27.StrType)le.mailing_city_state_zip,(SALT27.StrType)le.property_full_street_address,(SALT27.StrType)le.property_unit_number,(SALT27.StrType)le.property_city_state_zip,(SALT27.StrType)le.legal_lot_desc,(SALT27.StrType)le.legal_lot_number,(SALT27.StrType)le.legal_land_lot,(SALT27.StrType)le.legal_block,(SALT27.StrType)le.legal_section,(SALT27.StrType)le.legal_district,(SALT27.StrType)le.legal_unit,(SALT27.StrType)le.legal_city_municipality_township,(SALT27.StrType)le.legal_subdivision_name,(SALT27.StrType)le.legal_phase_number,(SALT27.StrType)le.legal_tract_number,(SALT27.StrType)le.legal_sec_twn_rng_mer,(SALT27.StrType)le.legal_brief_description,(SALT27.StrType)le.legal_assessor_map_ref,(SALT27.StrType)le.census_tract,(SALT27.StrType)le.ownership_type_desc,(SALT27.StrType)le.standardized_land_use_desc,(SALT27.StrType)le.zoning,(SALT27.StrType)le.owner_occupied,(SALT27.StrType)le.recorder_document_number,(SALT27.StrType)le.recorder_book_number,(SALT27.StrType)le.recorder_page_number,(SALT27.StrType)le.separator,(SALT27.StrType)le.transfer_date,(SALT27.StrType)le.recording_date,(SALT27.StrType)le.document_type,(SALT27.StrType)le.sale_date,(SALT27.StrType)le.sales_price,(SALT27.StrType)le.prior_sales_price,(SALT27.StrType)le.sales_price_desc,(SALT27.StrType)le.mortgage_loan_amount,(SALT27.StrType)le.mortgage_loan_type_desc,(SALT27.StrType)le.mortgage_lender_name,(SALT27.StrType)le.mortgage_lender_type_desc,(SALT27.StrType)le.assessed_land_value,(SALT27.StrType)le.assessed_improvement_value,(SALT27.StrType)le.assessed_total_value,(SALT27.StrType)le.assessed_value_year,(SALT27.StrType)le.market_land_value,(SALT27.StrType)le.market_improvement_value,(SALT27.StrType)le.market_total_value,(SALT27.StrType)le.market_value_year,(SALT27.StrType)le.homestead_homeowner_exemption,(SALT27.StrType)le.tax_exemption1_desc,(SALT27.StrType)le.tax_exemption2_desc,(SALT27.StrType)le.tax_exemption3_desc,(SALT27.StrType)le.tax_exemption4_desc,(SALT27.StrType)le.tax_rate_code_area,(SALT27.StrType)le.tax_amount,(SALT27.StrType)le.tax_year,(SALT27.StrType)le.year_built,(SALT27.StrType)le.effective_year_built,(SALT27.StrType)le.neighborhood_desc,(SALT27.StrType)le.condo_project_name,(SALT27.StrType)le.building_name,(SALT27.StrType)le.tax_account_number,(SALT27.StrType)le.mailing_care_of_name,(SALT27.StrType)le.fares_non_parsed_assessee_name,(SALT27.StrType)le.fares_non_parsed_second_assessee_name,(SALT27.StrType)le.fares_land_use,(SALT27.StrType)le.fares_calculated_land_value,(SALT27.StrType)le.fares_calculated_improvement_value,(SALT27.StrType)le.fares_calculated_total_value,(SALT27.StrType)le.addl_legal,(SALT27.StrType)le.process_date,(SALT27.StrType)le.title,(SALT27.StrType)le.fname,(SALT27.StrType)le.mname,(SALT27.StrType)le.lname,(SALT27.StrType)le.name_suffix,(SALT27.StrType)le.cname,(SALT27.StrType)le.nameasis,(SALT27.StrType)le.prim_range,(SALT27.StrType)le.predir,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.suffix,(SALT27.StrType)le.postdir,(SALT27.StrType)le.unit_desig,(SALT27.StrType)le.sec_range,(SALT27.StrType)le.v_city_name,(SALT27.StrType)le.st,(SALT27.StrType)le.zip,(SALT27.StrType)le.zip4,(SALT27.StrType)le.phone_num,(SALT27.StrType)le.date_from_deed,(SALT27.StrType)le.field_from_deeds,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
  SELF.len := LENGTH(TRIM(SELF.word));
  SELF.wip := IF(SELF.Word=Def(c-0),SKIP,1); // Adjusted later - also filters blank words
  SELF.nominal := 0; //Filled in later
  self.suffix := 0; // Filled in later
  self.part := thorlib.node();
  SELF.kwp := 0; // Adjusted later
  SELF.docref.doc := 0; // Filled in later
  SELF.docref.src := 0; // Filled in later
  SELF.src := TRANSFER(le.source,UNSIGNED2); // Namespace for ID provided
  SELF.seg := c; // Field number is seg; values filled in in segment definition
  SELF.segName := Text_Search.MakeShortSeg(choose(c,'STATE','COUNTY','APN','CERT-DATE','assessee_name','second_assessee_name','contract_owner','PHONE_NUMBER','mailing_full_street_address','mailing_unit_number','mailing_city_state_zip','property_full_street_address','property_unit_number','property_city_state_zip','LOT-DESC','LOT-NUMBER','LAND-LOT','BLOCK','SECTION','DISTRICT','UNIT','muni-twp','SUBDIVISION','PHASE','TRACT','sec-twn-mer','legal_brief_description','legal_assessor_map_ref','census-tract','OWNERSHIP-TYPE','standardized_land_use_desc','ZONING','OWNER-OCCUPIED','NUMBER','recorder_book_number','recorder_page_number','separator','TRANSFER-DATE','RECORDED-DATE','DEED-TYPE','SALE-DATE','sales_price','prior-sale-price','sale-price-desc','LOAN-AMOUNT','LOAN-TYPE','LENDER','LENDER-TYPE','assessed_land_value','ASSES-IMP-VALUE','assessed_total_value','YEAR-ASSESS','MAR-LAND-VALUE','market_improvement_value','TOT-MAR-VALUE','MAR-YEAR-ASSESS','HOMEOWNER-EXEMPT','tax_exemption1_desc','tax_exemption2_desc','tax_exemption3_desc','tax_exemption4_desc','TAX-RATE','TAX-AMOUNT','TAX-YEAR','YEAR-BUILT','EFFECT-YEAR-BUILT','NEIGHBOR-DESC','CONDO-PROJ-NAME','BUILDING-NAME','tax-account-number','mailing_care_of_name','fares_non_parsed_assessee_name','fares_non_parsed_second_assessee_name','fares_land_use','fares_calculated_land_value','fares_calculated_improvement_value','fares_calculated_total_value','addl_legal','PROCESS-DATE','title','fname','mname','lname','name_suffix','cname','nameasis','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','v_city_name','st','zip','zip4','phone_num','date_from_deed','field_from_deeds','LAND_USE','LAND_VALUE','TOTAL_VALUE','TOT_IMP_VALUE','BRIEF_LEGAL','OWNERS','MAILING_ADDRESS','PROPERTY_ADDRESS','CASS_ADDRESS','CASS_CSZ','BOOK_PAGE','SALE_PRICE','EXEMPTION','CLEAN_NAME','LEGAL_DESC','NAME','ADDRESS','CHARACTERISTICS','DATE','COMPANY','PHONE','CONTRACT_DATE','DUE_DATE','MORTGAGE_DATE','ADJ_INDEX','borrower','borrower_address','buyer','buyer_address','CHANGE_INDEX','CITY_TRANS_TAX','CONDO_NAME','condo_desc','contract_date','county_trans_tax','excise_trans_number','INTEREST_TRANS','lender_address','LOAN_NUMBER','mortgage','mortgage_type','PROPERTY_USE','RATE','RATE_CHANGE','rider','SECOND_LOAN_AMT','seller','seller_address','term','TERMS','TIMESHARE','TITLE_COMPANY','TOTAL_TRANS_TAX','TYPE_FINANCE'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (SALT27.UIDType)le.did;
END;
SHARED FieldsAsPostings := NORMALIZE(h,154,into(left,counter));
EXPORT SegmentDefinitions := DATASET([  {text_search.MakeShortSeg('STATE'),'STATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('STATE')]}
  ,{text_search.MakeShortSeg('COUNTY'),'COUNTY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('COUNTY')]}
  ,{text_search.MakeShortSeg('APN'),'APN',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('APN')]}
  ,{text_search.MakeShortSeg('CERT-DATE'),'CERT-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('CERT-DATE')]}
  ,{text_search.MakeShortSeg('assessee_name'),'assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('assessee_name')]}
  ,{text_search.MakeShortSeg('second_assessee_name'),'second_assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('second_assessee_name')]}
  ,{text_search.MakeShortSeg('contract_owner'),'contract_owner',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('contract_owner')]}
  ,{text_search.MakeShortSeg('PHONE_NUMBER'),'PHONE_NUMBER',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('PHONE_NUMBER')]}
  ,{text_search.MakeShortSeg('mailing_full_street_address'),'mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('mailing_unit_number'),'mailing_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_unit_number')]}
  ,{text_search.MakeShortSeg('mailing_city_state_zip'),'mailing_city_state_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_city_state_zip')]}
  ,{text_search.MakeShortSeg('property_full_street_address'),'property_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_full_street_address')]}
  ,{text_search.MakeShortSeg('property_unit_number'),'property_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_unit_number')]}
  ,{text_search.MakeShortSeg('property_city_state_zip'),'property_city_state_zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_city_state_zip')]}
  ,{text_search.MakeShortSeg('LOT-DESC'),'LOT-DESC',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOT-DESC')]}
  ,{text_search.MakeShortSeg('LOT-NUMBER'),'LOT-NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOT-NUMBER')]}
  ,{text_search.MakeShortSeg('LAND-LOT'),'LAND-LOT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LAND-LOT')]}
  ,{text_search.MakeShortSeg('BLOCK'),'BLOCK',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BLOCK')]}
  ,{text_search.MakeShortSeg('SECTION'),'SECTION',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('SECTION')]}
  ,{text_search.MakeShortSeg('DISTRICT'),'DISTRICT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('DISTRICT')]}
  ,{text_search.MakeShortSeg('UNIT'),'UNIT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('UNIT')]}
  ,{text_search.MakeShortSeg('muni-twp'),'muni-twp',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('muni-twp')]}
  ,{text_search.MakeShortSeg('SUBDIVISION'),'SUBDIVISION',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('SUBDIVISION')]}
  ,{text_search.MakeShortSeg('PHASE'),'PHASE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('PHASE')]}
  ,{text_search.MakeShortSeg('TRACT'),'TRACT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TRACT')]}
  ,{text_search.MakeShortSeg('sec-twn-mer'),'sec-twn-mer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec-twn-mer')]}
  ,{text_search.MakeShortSeg('legal_brief_description'),'legal_brief_description',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('legal_brief_description')]}
  ,{text_search.MakeShortSeg('legal_assessor_map_ref'),'legal_assessor_map_ref',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('legal_assessor_map_ref')]}
  ,{text_search.MakeShortSeg('census-tract'),'census-tract',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('census-tract')]}
  ,{text_search.MakeShortSeg('OWNERSHIP-TYPE'),'OWNERSHIP-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('OWNERSHIP-TYPE')]}
  ,{text_search.MakeShortSeg('standardized_land_use_desc'),'standardized_land_use_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('standardized_land_use_desc')]}
  ,{text_search.MakeShortSeg('ZONING'),'ZONING',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ZONING')]}
  ,{text_search.MakeShortSeg('OWNER-OCCUPIED'),'OWNER-OCCUPIED',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('OWNER-OCCUPIED')]}
  ,{text_search.MakeShortSeg('NUMBER'),'NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('NUMBER')]}
  ,{text_search.MakeShortSeg('recorder_book_number'),'recorder_book_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recorder_book_number')]}
  ,{text_search.MakeShortSeg('recorder_page_number'),'recorder_page_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recorder_page_number')]}
  ,{text_search.MakeShortSeg('separator'),'separator',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('separator')]}
  ,{text_search.MakeShortSeg('TRANSFER-DATE'),'TRANSFER-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('TRANSFER-DATE')]}
  ,{text_search.MakeShortSeg('RECORDED-DATE'),'RECORDED-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('RECORDED-DATE')]}
  ,{text_search.MakeShortSeg('DEED-TYPE'),'DEED-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('DEED-TYPE')]}
  ,{text_search.MakeShortSeg('SALE-DATE'),'SALE-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('SALE-DATE')]}
  ,{text_search.MakeShortSeg('sales_price'),'sales_price',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('sales_price')]}
  ,{text_search.MakeShortSeg('prior-sale-price'),'prior-sale-price',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('prior-sale-price')]}
  ,{text_search.MakeShortSeg('sale-price-desc'),'sale-price-desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sale-price-desc')]}
  ,{text_search.MakeShortSeg('LOAN-AMOUNT'),'LOAN-AMOUNT',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('LOAN-AMOUNT')]}
  ,{text_search.MakeShortSeg('LOAN-TYPE'),'LOAN-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOAN-TYPE')]}
  ,{text_search.MakeShortSeg('LENDER'),'LENDER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LENDER')]}
  ,{text_search.MakeShortSeg('LENDER-TYPE'),'LENDER-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LENDER-TYPE')]}
  ,{text_search.MakeShortSeg('assessed_land_value'),'assessed_land_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('assessed_land_value')]}
  ,{text_search.MakeShortSeg('ASSES-IMP-VALUE'),'ASSES-IMP-VALUE',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('ASSES-IMP-VALUE')]}
  ,{text_search.MakeShortSeg('assessed_total_value'),'assessed_total_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('assessed_total_value')]}
  ,{text_search.MakeShortSeg('YEAR-ASSESS'),'YEAR-ASSESS',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('YEAR-ASSESS')]}
  ,{text_search.MakeShortSeg('MAR-LAND-VALUE'),'MAR-LAND-VALUE',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('MAR-LAND-VALUE')]}
  ,{text_search.MakeShortSeg('market_improvement_value'),'market_improvement_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('market_improvement_value')]}
  ,{text_search.MakeShortSeg('TOT-MAR-VALUE'),'TOT-MAR-VALUE',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('TOT-MAR-VALUE')]}
  ,{text_search.MakeShortSeg('MAR-YEAR-ASSESS'),'MAR-YEAR-ASSESS',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('MAR-YEAR-ASSESS')]}
  ,{text_search.MakeShortSeg('HOMEOWNER-EXEMPT'),'HOMEOWNER-EXEMPT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('HOMEOWNER-EXEMPT')]}
  ,{text_search.MakeShortSeg('tax_exemption1_desc'),'tax_exemption1_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tax_exemption1_desc')]}
  ,{text_search.MakeShortSeg('tax_exemption2_desc'),'tax_exemption2_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tax_exemption2_desc')]}
  ,{text_search.MakeShortSeg('tax_exemption3_desc'),'tax_exemption3_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tax_exemption3_desc')]}
  ,{text_search.MakeShortSeg('tax_exemption4_desc'),'tax_exemption4_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tax_exemption4_desc')]}
  ,{text_search.MakeShortSeg('TAX-RATE'),'TAX-RATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TAX-RATE')]}
  ,{text_search.MakeShortSeg('TAX-AMOUNT'),'TAX-AMOUNT',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('TAX-AMOUNT')]}
  ,{text_search.MakeShortSeg('TAX-YEAR'),'TAX-YEAR',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TAX-YEAR')]}
  ,{text_search.MakeShortSeg('YEAR-BUILT'),'YEAR-BUILT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('YEAR-BUILT')]}
  ,{text_search.MakeShortSeg('EFFECT-YEAR-BUILT'),'EFFECT-YEAR-BUILT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('EFFECT-YEAR-BUILT')]}
  ,{text_search.MakeShortSeg('NEIGHBOR-DESC'),'NEIGHBOR-DESC',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('NEIGHBOR-DESC')]}
  ,{text_search.MakeShortSeg('CONDO-PROJ-NAME'),'CONDO-PROJ-NAME',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONDO-PROJ-NAME')]}
  ,{text_search.MakeShortSeg('BUILDING-NAME'),'BUILDING-NAME',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BUILDING-NAME')]}
  ,{text_search.MakeShortSeg('tax-account-number'),'tax-account-number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('tax-account-number')]}
  ,{text_search.MakeShortSeg('mailing_care_of_name'),'mailing_care_of_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mailing_care_of_name')]}
  ,{text_search.MakeShortSeg('fares_non_parsed_assessee_name'),'fares_non_parsed_assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fares_non_parsed_assessee_name')]}
  ,{text_search.MakeShortSeg('fares_non_parsed_second_assessee_name'),'fares_non_parsed_second_assessee_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fares_non_parsed_second_assessee_name')]}
  ,{text_search.MakeShortSeg('fares_land_use'),'fares_land_use',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fares_land_use')]}
  ,{text_search.MakeShortSeg('fares_calculated_land_value'),'fares_calculated_land_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('fares_calculated_land_value')]}
  ,{text_search.MakeShortSeg('fares_calculated_improvement_value'),'fares_calculated_improvement_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('fares_calculated_improvement_value')]}
  ,{text_search.MakeShortSeg('fares_calculated_total_value'),'fares_calculated_total_value',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('fares_calculated_total_value')]}
  ,{text_search.MakeShortSeg('addl_legal'),'addl_legal',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('addl_legal')]}
  ,{text_search.MakeShortSeg('PROCESS-DATE'),'PROCESS-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('PROCESS-DATE')]}
  ,{text_search.MakeShortSeg('title'),'title',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('title')]}
  ,{text_search.MakeShortSeg('fname'),'fname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fname')]}
  ,{text_search.MakeShortSeg('mname'),'mname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mname')]}
  ,{text_search.MakeShortSeg('lname'),'lname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lname')]}
  ,{text_search.MakeShortSeg('name_suffix'),'name_suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('cname'),'cname',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('cname')]}
  ,{text_search.MakeShortSeg('nameasis'),'nameasis',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('nameasis')]}
  ,{text_search.MakeShortSeg('prim_range'),'prim_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_range')]}
  ,{text_search.MakeShortSeg('predir'),'predir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('predir')]}
  ,{text_search.MakeShortSeg('prim_name'),'prim_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prim_name')]}
  ,{text_search.MakeShortSeg('suffix'),'suffix',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('suffix')]}
  ,{text_search.MakeShortSeg('postdir'),'postdir',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('postdir')]}
  ,{text_search.MakeShortSeg('unit_desig'),'unit_desig',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('unit_desig')]}
  ,{text_search.MakeShortSeg('sec_range'),'sec_range',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('v_city_name'),'v_city_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('v_city_name')]}
  ,{text_search.MakeShortSeg('st'),'st',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('st')]}
  ,{text_search.MakeShortSeg('zip'),'zip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip')]}
  ,{text_search.MakeShortSeg('zip4'),'zip4',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('phone_num'),'phone_num',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('phone_num')]}
  ,{text_search.MakeShortSeg('date_from_deed'),'date_from_deed',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('date_from_deed')]}
  ,{text_search.MakeShortSeg('field_from_deeds'),'field_from_deeds',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('LAND_USE'),'LAND_USE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('standardized_land_use_desc'),text_search.MakeShortSeg('fares_land_use')]}
  ,{text_search.MakeShortSeg('LAND_VALUE'),'LAND_VALUE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('assessed_land_value'),text_search.MakeShortSeg('fares_calculated_land_value')]}
  ,{text_search.MakeShortSeg('TOTAL_VALUE'),'TOTAL_VALUE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('assessed_total_value'),text_search.MakeShortSeg('fares_calculated_total_value')]}
  ,{text_search.MakeShortSeg('TOT_IMP_VALUE'),'TOT_IMP_VALUE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('market_improvement_value'),text_search.MakeShortSeg('fares_calculated_improvement_value')]}
  ,{text_search.MakeShortSeg('BRIEF_LEGAL'),'BRIEF_LEGAL',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('legal_brief_description'),text_search.MakeShortSeg('addl_legal')]}
  ,{text_search.MakeShortSeg('OWNERS'),'OWNERS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('assessee_name'),text_search.MakeShortSeg('second_assessee_name'),text_search.MakeShortSeg('contract_owner'),text_search.MakeShortSeg('fares_non_parsed_assessee_name'),text_search.MakeShortSeg('fares_non_parsed_second_assessee_name')]}
  ,{text_search.MakeShortSeg('MAILING_ADDRESS'),'MAILING_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('mailing_unit_number'),text_search.MakeShortSeg('mailing_full_street_address'),text_search.MakeShortSeg('mailing_city_state_zip')]}
  ,{text_search.MakeShortSeg('PROPERTY_ADDRESS'),'PROPERTY_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_unit_number'),text_search.MakeShortSeg('property_city_state_zip')]}
  ,{text_search.MakeShortSeg('CASS_ADDRESS'),'CASS_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('BOOK_PAGE'),'BOOK_PAGE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('recorder_book_number'),text_search.MakeShortSeg('separator'),text_search.MakeShortSeg('recorder_page_number')]}
  ,{text_search.MakeShortSeg('SALE_PRICE'),'SALE_PRICE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('sales_price'),text_search.MakeShortSeg('prior-sale-price')]}
  ,{text_search.MakeShortSeg('EXEMPTION'),'EXEMPTION',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('tax_exemption1_desc'),text_search.MakeShortSeg('tax_exemption2_desc'),text_search.MakeShortSeg('tax_exemption3_desc'),text_search.MakeShortSeg('tax_exemption4_desc')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('LEGAL_DESC'),'LEGAL_DESC',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('LOT-DESC'),text_search.MakeShortSeg('LOT-NUMBER'),text_search.MakeShortSeg('LAND-LOT'),text_search.MakeShortSeg('BLOCK'),text_search.MakeShortSeg('SECTION'),text_search.MakeShortSeg('DISTRICT'),text_search.MakeShortSeg('UNIT'),text_search.MakeShortSeg('SUBDIVISION'),text_search.MakeShortSeg('PHASE'),text_search.MakeShortSeg('TRACT'),text_search.MakeShortSeg('legal_brief_description'),text_search.MakeShortSeg('muni-twp'),text_search.MakeShortSeg('sec-twn-mer'),text_search.MakeShortSeg('legal_assessor_map_ref'),text_search.MakeShortSeg('census-tract')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('assessee_name'),text_search.MakeShortSeg('second_assessee_name'),text_search.MakeShortSeg('contract_owner'),text_search.MakeShortSeg('fares_non_parsed_assessee_name'),text_search.MakeShortSeg('fares_non_parsed_second_assessee_name'),text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix'),text_search.MakeShortSeg('cname'),text_search.MakeShortSeg('nameasis'),text_search.MakeShortSeg('mailing_care_of_name')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('mailing_unit_number'),text_search.MakeShortSeg('mailing_full_street_address'),text_search.MakeShortSeg('mailing_city_state_zip'),text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_unit_number'),text_search.MakeShortSeg('property_city_state_zip'),text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CHARACTERISTICS'),'CHARACTERISTICS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('HOMEOWNER-EXEMPT'),text_search.MakeShortSeg('YEAR-BUILT'),text_search.MakeShortSeg('EFFECT-YEAR-BUILT'),text_search.MakeShortSeg('NEIGHBOR-DESC'),text_search.MakeShortSeg('CONDO-PROJ-NAME'),text_search.MakeShortSeg('BUILDING-NAME')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('TRANSFER-DATE'),text_search.MakeShortSeg('RECORDED-DATE'),text_search.MakeShortSeg('SALE-DATE')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('cname')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('PHONE_NUMBER'),text_search.MakeShortSeg('phone_num')]}
  ,{text_search.MakeShortSeg('CONTRACT_DATE'),'CONTRACT_DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('date_from_deed')]}
  ,{text_search.MakeShortSeg('DUE_DATE'),'DUE_DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('date_from_deed')]}
  ,{text_search.MakeShortSeg('MORTGAGE_DATE'),'MORTGAGE_DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('date_from_deed')]}
  ,{text_search.MakeShortSeg('ADJ_INDEX'),'ADJ_INDEX',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('borrower'),'borrower',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('borrower_address'),'borrower_address',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('buyer'),'buyer',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('buyer_address'),'buyer_address',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('CHANGE_INDEX'),'CHANGE_INDEX',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('CITY_TRANS_TAX'),'CITY_TRANS_TAX',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('CONDO_NAME'),'CONDO_NAME',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('condo_desc'),'condo_desc',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('contract_date'),'contract_date',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('county_trans_tax'),'county_trans_tax',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('excise_trans_number'),'excise_trans_number',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('INTEREST_TRANS'),'INTEREST_TRANS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('lender_address'),'lender_address',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('LOAN_NUMBER'),'LOAN_NUMBER',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('mortgage'),'mortgage',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('mortgage_type'),'mortgage_type',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('PROPERTY_USE'),'PROPERTY_USE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('RATE'),'RATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('RATE_CHANGE'),'RATE_CHANGE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('rider'),'rider',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('SECOND_LOAN_AMT'),'SECOND_LOAN_AMT',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('seller'),'seller',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('seller_address'),'seller_address',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('term'),'term',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('TERMS'),'TERMS',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('TIMESHARE'),'TIMESHARE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('TITLE_COMPANY'),'TITLE_COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('TOTAL_TRANS_TAX'),'TOTAL_TRANS_TAX',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
  ,{text_search.MakeShortSeg('TYPE_FINANCE'),'TYPE_FINANCE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_deeds')]}
],Text_Search.Layout_Segment_ComposeDef );
 
SHARED Text_Search.Layout_Posting setRef(Text_Search.Layout_Posting le, INTEGER2 sw) := TRANSFORM
    SELF.docRef.src := CHOOSE(sw, IF(le.lid=0, le.src, 0),  le.src);
    SELF.docRef.doc := CHOOSE(sw, IF(le.lid=0, le.rid, le.lid), le.rid, le.sid);
    SELF := le;
END;
 
EXPORT Postings_LID := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,1)), SegmentDefinitions);
EXPORT Postings_RID := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,2)), SegmentDefinitions);
EXPORT Postings_Doc := Text_Search.ApplyKWP2Postings(PROJECT(FieldsAsPostings, setRef(LEFT,3)), SegmentDefinitions);
END;

