IMPORT text_search,ut,SALT27,MDR;
 
EXPORT Property_DMBooleanSearch(DATASET(layout_Property_DM_Extract) ih)  := MODULE
SHARED h := ih; // More - use propogated data
// Now recreate the file in 'segname' form for eventual data load
  rf := RECORD
  SALT27.UIDType rid := h.rid;
  SALT27.UIDType sid := h.sid;
  SALT27.UIDType lid := (SALT27.UIDType)h.did;
    h.state;
    COUNTY := h.county_name;
    APN := h.apnt_or_pin_number;
    h.buyer1;
    h.buyer_1_id_desc;
    h.buyer2;
    h.buyer_2_id_desc;
    h.borrower1;
    h.borrower_1_id_desc;
    h.borrower2;
    h.borrower_2_id_desc;
    h.borrower_vesting_desc;
    h.seller1;
    h.seller_1_id_desc;
    h.seller2;
    h.seller_2_id_desc;
    h.lender_name;
    h.lender_dba_aka_name;
    h.phone_number;
    h.buyer_mailing_full_street_address;
    h.buyer_mailing_address_unit_number;
    h.buyer_mailing_address_citystatezip;
    h.borrower_mailing_full_street_address;
    h.borrower_mailing_unit_number;
    h.borrower_mailing_citystatezip;
    h.seller_mailing_full_street_address;
    h.seller_mailing_address_unit_number;
    h.seller_mailing_address_citystatezip;
    h.property_full_street_address;
    h.property_address_unit_number;
    h.property_address_citystatezip;
    h.lender_full_street_address;
    h.lender_address_unit_number;
    h.lender_address_citystatezip;
    LOT_DESC := h.legal_lot_desc;
    LOT_NUMBER := h.legal_lot_number;
    BLOCK := h.legal_block;
    SECTION := h.legal_section;
    DISTRICT := h.legal_district;
    LAND_LOT := h.legal_land_lot;
    UNIT := h.legal_unit;
    muni_twp := h.legal_city_municipality_township;
    SUBDIVISION := h.legal_subdivision_name;
    PHASE := h.legal_phase_number;
    h.legal_tract_number;
    sec_twn_mer := h.legal_sec_twn_rng_mer;
    BRIEF_LEGAL := h.legal_brief_description;
    h.recorder_map_reference;
    h.contract_date;
    RECORDED_DATE := h.recording_date;
    NUMBER := h.document_number;
    h.record_type_desc;
    DEED_TYPE := h.document_type_desc;
    h.loan_number;
    h.recorder_book_number;
    h.recorder_page_number;
    h.separator;
    h.hawaii_tct;
    h.hawaii_condo_cpr_desc;
    CONDO_NAME := h.hawaii_condo_name;
    SALE_PRICE := h.sales_price;
    SALE_PRICE_DESC := h.sales_price_desc;
    CITY_TRANS_TAX := h.city_transfer_tax;
    h.county_transfer_tax;
    TOTAL_TRANS_TAX := h.total_transfer_tax;
    h.excise_tax_number;
    LAND_USE := h.assessment_match_land_use_desc;
    PROPERTY_USE := h.property_use_desc;
    h.condo_desc_in;
    TIMESHARE := h.timeshare_flag;
    RATE_CHANGE := h.rate_change_frequency;
    h.change_index;
    ADJ_INDEX := h.adjustable_rate_index;
    h.adjustable_rate_rider;
    h.graduated_payment_rider;
    h.balloon_rider;
    h.fixed_step_rate_rider;
    h.condominium_rider;
    h.planned_unit_development_rider;
    h.rate_improvement_rider;
    h.assumability_rider;
    h.prepayment_rider;
    h.one_four_family_rider;
    h.biweekly_payment_rider;
    h.second_home_rider;
    LOAN_AMOUNT := h.first_td_loan_amount;
    SECOND_LOAN_AMT := h.second_td_loan_amount;
    h.first_td_lender_type_desc;
    h.second_td_lender_type_desc;
    LOAN_TYPE := h.first_td_loan_type_desc;
    h.type_financing;
    RATE := h.first_td_interest_rate;
    DUE_DATE := h.first_td_due_date;
    TITLE_COMPANY := h.title_company_name;
    INTEREST_TRANS := h.partial_interest_transferred;
    h.loan_term_months;
    h.loan_term_years;
    MORTGAGE_DATE := h.fares_mortgage_date;
    h.mortgage_deed_type_desc;
    TERMS := h.fares_mortgage_term;
    excise_trans_number := h.excise_tax_number;
    TYPE_FINANCE := h.type_financing_desc;
    TRANSACTION_TYPE := h.fares_transaction_type_desc;
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
    h.date_from_assesor;
    h.field_from_assesor;
    h.transfer_date;
    h.sale_date;
  END;
EXPORT TranslatedFile := TABLE(h,rf);
// Compute the null for each field value
  Def(INTEGER2 c) := CHOOSE(c,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','0','0','','','','','0','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
 
Text_Search.Layout_Posting Into(h le,UNSIGNED2 c) := TRANSFORM
  SELF.word := CHOOSE(c,(SALT27.StrType)le.state,(SALT27.StrType)le.county_name,(SALT27.StrType)le.apnt_or_pin_number,(SALT27.StrType)le.buyer1,(SALT27.StrType)le.buyer_1_id_desc,(SALT27.StrType)le.buyer2,(SALT27.StrType)le.buyer_2_id_desc,(SALT27.StrType)le.borrower1,(SALT27.StrType)le.borrower_1_id_desc,(SALT27.StrType)le.borrower2,(SALT27.StrType)le.borrower_2_id_desc,(SALT27.StrType)le.borrower_vesting_desc,(SALT27.StrType)le.seller1,(SALT27.StrType)le.seller_1_id_desc,(SALT27.StrType)le.seller2,(SALT27.StrType)le.seller_2_id_desc,(SALT27.StrType)le.lender_name,(SALT27.StrType)le.lender_dba_aka_name,(SALT27.StrType)le.phone_number,(SALT27.StrType)le.buyer_mailing_full_street_address,(SALT27.StrType)le.buyer_mailing_address_unit_number,(SALT27.StrType)le.buyer_mailing_address_citystatezip,(SALT27.StrType)le.borrower_mailing_full_street_address,(SALT27.StrType)le.borrower_mailing_unit_number,(SALT27.StrType)le.borrower_mailing_citystatezip,(SALT27.StrType)le.seller_mailing_full_street_address,(SALT27.StrType)le.seller_mailing_address_unit_number,(SALT27.StrType)le.seller_mailing_address_citystatezip,(SALT27.StrType)le.property_full_street_address,(SALT27.StrType)le.property_address_unit_number,(SALT27.StrType)le.property_address_citystatezip,(SALT27.StrType)le.lender_full_street_address,(SALT27.StrType)le.lender_address_unit_number,(SALT27.StrType)le.lender_address_citystatezip,(SALT27.StrType)le.legal_lot_desc,(SALT27.StrType)le.legal_lot_number,(SALT27.StrType)le.legal_block,(SALT27.StrType)le.legal_section,(SALT27.StrType)le.legal_district,(SALT27.StrType)le.legal_land_lot,(SALT27.StrType)le.legal_unit,(SALT27.StrType)le.legal_city_municipality_township,(SALT27.StrType)le.legal_subdivision_name,(SALT27.StrType)le.legal_phase_number,(SALT27.StrType)le.legal_tract_number,(SALT27.StrType)le.legal_sec_twn_rng_mer,(SALT27.StrType)le.legal_brief_description,(SALT27.StrType)le.recorder_map_reference,(SALT27.StrType)le.contract_date,(SALT27.StrType)le.recording_date,(SALT27.StrType)le.document_number,(SALT27.StrType)le.record_type_desc,(SALT27.StrType)le.document_type_desc,(SALT27.StrType)le.loan_number,(SALT27.StrType)le.recorder_book_number,(SALT27.StrType)le.recorder_page_number,(SALT27.StrType)le.separator,(SALT27.StrType)le.hawaii_tct,(SALT27.StrType)le.hawaii_condo_cpr_desc,(SALT27.StrType)le.hawaii_condo_name,(SALT27.StrType)le.sales_price,(SALT27.StrType)le.sales_price_desc,(SALT27.StrType)le.city_transfer_tax,(SALT27.StrType)le.county_transfer_tax,(SALT27.StrType)le.total_transfer_tax,(SALT27.StrType)le.excise_tax_number,(SALT27.StrType)le.assessment_match_land_use_desc,(SALT27.StrType)le.property_use_desc,(SALT27.StrType)le.condo_desc_in,(SALT27.StrType)le.timeshare_flag,(SALT27.StrType)le.rate_change_frequency,(SALT27.StrType)le.change_index,(SALT27.StrType)le.adjustable_rate_index,(SALT27.StrType)le.adjustable_rate_rider,(SALT27.StrType)le.graduated_payment_rider,(SALT27.StrType)le.balloon_rider,(SALT27.StrType)le.fixed_step_rate_rider,(SALT27.StrType)le.condominium_rider,(SALT27.StrType)le.planned_unit_development_rider,(SALT27.StrType)le.rate_improvement_rider,(SALT27.StrType)le.assumability_rider,(SALT27.StrType)le.prepayment_rider,(SALT27.StrType)le.one_four_family_rider,(SALT27.StrType)le.biweekly_payment_rider,(SALT27.StrType)le.second_home_rider,(SALT27.StrType)le.first_td_loan_amount,(SALT27.StrType)le.second_td_loan_amount,(SALT27.StrType)le.first_td_lender_type_desc,(SALT27.StrType)le.second_td_lender_type_desc,(SALT27.StrType)le.first_td_loan_type_desc,(SALT27.StrType)le.type_financing,(SALT27.StrType)le.first_td_interest_rate,(SALT27.StrType)le.first_td_due_date,(SALT27.StrType)le.title_company_name,(SALT27.StrType)le.partial_interest_transferred,(SALT27.StrType)le.loan_term_months,(SALT27.StrType)le.loan_term_years,(SALT27.StrType)le.fares_mortgage_date,(SALT27.StrType)le.mortgage_deed_type_desc,(SALT27.StrType)le.fares_mortgage_term,(SALT27.StrType)le.excise_tax_number,(SALT27.StrType)le.type_financing_desc,(SALT27.StrType)le.fares_transaction_type_desc,(SALT27.StrType)le.title,(SALT27.StrType)le.fname,(SALT27.StrType)le.mname,(SALT27.StrType)le.lname,(SALT27.StrType)le.name_suffix,(SALT27.StrType)le.cname,(SALT27.StrType)le.nameasis,(SALT27.StrType)le.prim_range,(SALT27.StrType)le.predir,(SALT27.StrType)le.prim_name,(SALT27.StrType)le.suffix,(SALT27.StrType)le.postdir,(SALT27.StrType)le.unit_desig,(SALT27.StrType)le.sec_range,(SALT27.StrType)le.v_city_name,(SALT27.StrType)le.st,(SALT27.StrType)le.zip,(SALT27.StrType)le.zip4,(SALT27.StrType)le.date_from_assesor,(SALT27.StrType)le.field_from_assesor,(SALT27.StrType)le.transfer_date,(SALT27.StrType)le.sale_date,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP,SKIP);
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
  SELF.segName := Text_Search.MakeShortSeg(choose(c,'STATE','COUNTY','APN','buyer1','buyer_1_id_desc','buyer2','buyer_2_id_desc','borrower1','borrower_1_id_desc','borrower2','borrower_2_id_desc','borrower_vesting_desc','seller1','seller_1_id_desc','seller2','seller_2_id_desc','lender_name','lender_dba_aka_name','PHONE-NUMBER','buyer_mailing_full_street_address','buyer_mailing_address_unit_number','buyer_mailing_address_citystatezip','borrower_mailing_full_street_address','borrower_mailing_unit_number','borrower_mailing_citystatezip','seller_mailing_full_street_address','seller_mailing_address_unit_number','seller_mailing_address_citystatezip','property_full_street_address','property_address_unit_number','property_address_citystatezip','lender_full_street_address','lender_address_unit_number','lender_address_citystatezip','LOT-DESC','LOT-NUMBER','BLOCK','SECTION','DISTRICT','LAND-LOT','UNIT','muni-twp','SUBDIVISION','PHASE','legal_tract_number','sec-twn-mer','BRIEF-LEGAL','recorder_map_reference','CONTRACT-DATE','RECORDED-DATE','NUMBER','record_type_desc','DEED-TYPE','LOAN-NUMBER','recorder_book_number','recorder_page_number','separator','hawaii_tct','hawaii_condo_cpr_desc','CONDO-NAME','SALE-PRICE','SALE-PRICE-DESC','CITY-TRANS-TAX','county_transfer_tax','TOTAL-TRANS-TAX','EXCISE-TAX-NUMBER','LAND-USE','PROPERTY-USE','condo_desc_in','TIMESHARE','RATE-CHANGE','CHANGE-INDEX','ADJ-INDEX','adjustable_rate_rider','graduated_payment_rider','balloon_rider','fixed_step_rate_rider','condominium_rider','planned_unit_development_rider','rate_improvement_rider','assumability_rider','prepayment_rider','one_four_family_rider','biweekly_payment_rider','second_home_rider','LOAN-AMOUNT','SECOND-LOAN-AMT','first_td_lender_type_desc','second_td_lender_type_desc','LOAN-TYPE','type_financing','RATE','DUE-DATE','TITLE-COMPANY','INTEREST-TRANS','loan_term_months','loan_term_years','MORTGAGE-DATE','mortgage_deed_type_desc','TERMS','excise-trans-number','TYPE-FINANCE','TRANSACTION-TYPE','title','fname','mname','lname','name_suffix','cname','nameasis','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','v_city_name','st','zip','zip4','date_from_assesor','field_from_assesor','TRANSFER-DATE','SALE-DATE','BUYER','BORROWER','SELLER','LENDER','BOOK_PAGE','BUYER_ADDRESS','BORROWER_ADDRESS','SELLER_ADDRESS','PROPERTY_ADDRESS','LENDER_ADDRESS','TRACT','CONDO_DESC','COUNTY_TRANS_TAX','LENDER_TYPE','RIDER','MORTGAGE_TYPE','TERM','CASS_ADDRESS','CASS_CSZ','CLEAN_NAME','NAME','ADDRESS','LEGAL_DESC','MORTGAGE','DATE','PHONE','DOCUMENT_TYPE','COMPANY','cert_date','process_date','asses_imp_value','building_name','census_tract','characteristics','condo_proj_name','effect_year_built','exemption','homeowner_exempt','land_value','mailing_address','mar_land_value','mar_year_assess','neighbor_desc','owner_occupied','owners','ownership_type','PRIOR_SALE_PRICE','tax_amount','tax_rate','tax_year','tax_account_number','tot_imp_value','tot_mar_value','total_value','year_assess','year_built','zoning'));
  SELF.typ := text_search.types.WordType.TextStr; // May get changed later
  SELF.sect := 0; // Not needed
  SELF.pos := 0; // Not needed
  self.rid := le.rid;
  self.sid := le.sid;
  self.lid := (SALT27.UIDType)le.did;
END;
SHARED FieldsAsPostings := NORMALIZE(h,182,into(left,counter));
EXPORT SegmentDefinitions := DATASET([  {text_search.MakeShortSeg('STATE'),'STATE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('STATE')]}
  ,{text_search.MakeShortSeg('COUNTY'),'COUNTY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('COUNTY')]}
  ,{text_search.MakeShortSeg('APN'),'APN',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('APN')]}
  ,{text_search.MakeShortSeg('buyer1'),'buyer1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer1')]}
  ,{text_search.MakeShortSeg('buyer_1_id_desc'),'buyer_1_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer_1_id_desc')]}
  ,{text_search.MakeShortSeg('buyer2'),'buyer2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer2')]}
  ,{text_search.MakeShortSeg('buyer_2_id_desc'),'buyer_2_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer_2_id_desc')]}
  ,{text_search.MakeShortSeg('borrower1'),'borrower1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower1')]}
  ,{text_search.MakeShortSeg('borrower_1_id_desc'),'borrower_1_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_1_id_desc')]}
  ,{text_search.MakeShortSeg('borrower2'),'borrower2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower2')]}
  ,{text_search.MakeShortSeg('borrower_2_id_desc'),'borrower_2_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_2_id_desc')]}
  ,{text_search.MakeShortSeg('borrower_vesting_desc'),'borrower_vesting_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_vesting_desc')]}
  ,{text_search.MakeShortSeg('seller1'),'seller1',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller1')]}
  ,{text_search.MakeShortSeg('seller_1_id_desc'),'seller_1_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_1_id_desc')]}
  ,{text_search.MakeShortSeg('seller2'),'seller2',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller2')]}
  ,{text_search.MakeShortSeg('seller_2_id_desc'),'seller_2_id_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_2_id_desc')]}
  ,{text_search.MakeShortSeg('lender_name'),'lender_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lender_name')]}
  ,{text_search.MakeShortSeg('lender_dba_aka_name'),'lender_dba_aka_name',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lender_dba_aka_name')]}
  ,{text_search.MakeShortSeg('PHONE-NUMBER'),'PHONE-NUMBER',text_search.types.SegmentType.Phone,[text_search.MakeShortSeg('PHONE-NUMBER')]}
  ,{text_search.MakeShortSeg('buyer_mailing_full_street_address'),'buyer_mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer_mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('buyer_mailing_address_unit_number'),'buyer_mailing_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer_mailing_address_unit_number')]}
  ,{text_search.MakeShortSeg('buyer_mailing_address_citystatezip'),'buyer_mailing_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('buyer_mailing_address_citystatezip')]}
  ,{text_search.MakeShortSeg('borrower_mailing_full_street_address'),'borrower_mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('borrower_mailing_unit_number'),'borrower_mailing_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_mailing_unit_number')]}
  ,{text_search.MakeShortSeg('borrower_mailing_citystatezip'),'borrower_mailing_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('borrower_mailing_citystatezip')]}
  ,{text_search.MakeShortSeg('seller_mailing_full_street_address'),'seller_mailing_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_full_street_address')]}
  ,{text_search.MakeShortSeg('seller_mailing_address_unit_number'),'seller_mailing_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_address_unit_number')]}
  ,{text_search.MakeShortSeg('seller_mailing_address_citystatezip'),'seller_mailing_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('seller_mailing_address_citystatezip')]}
  ,{text_search.MakeShortSeg('property_full_street_address'),'property_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_full_street_address')]}
  ,{text_search.MakeShortSeg('property_address_unit_number'),'property_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_address_unit_number')]}
  ,{text_search.MakeShortSeg('property_address_citystatezip'),'property_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('property_address_citystatezip')]}
  ,{text_search.MakeShortSeg('lender_full_street_address'),'lender_full_street_address',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lender_full_street_address')]}
  ,{text_search.MakeShortSeg('lender_address_unit_number'),'lender_address_unit_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lender_address_unit_number')]}
  ,{text_search.MakeShortSeg('lender_address_citystatezip'),'lender_address_citystatezip',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('lender_address_citystatezip')]}
  ,{text_search.MakeShortSeg('LOT-DESC'),'LOT-DESC',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOT-DESC')]}
  ,{text_search.MakeShortSeg('LOT-NUMBER'),'LOT-NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOT-NUMBER')]}
  ,{text_search.MakeShortSeg('BLOCK'),'BLOCK',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BLOCK')]}
  ,{text_search.MakeShortSeg('SECTION'),'SECTION',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('SECTION')]}
  ,{text_search.MakeShortSeg('DISTRICT'),'DISTRICT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('DISTRICT')]}
  ,{text_search.MakeShortSeg('LAND-LOT'),'LAND-LOT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LAND-LOT')]}
  ,{text_search.MakeShortSeg('UNIT'),'UNIT',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('UNIT')]}
  ,{text_search.MakeShortSeg('muni-twp'),'muni-twp',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('muni-twp')]}
  ,{text_search.MakeShortSeg('SUBDIVISION'),'SUBDIVISION',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('SUBDIVISION')]}
  ,{text_search.MakeShortSeg('PHASE'),'PHASE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('PHASE')]}
  ,{text_search.MakeShortSeg('legal_tract_number'),'legal_tract_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('legal_tract_number')]}
  ,{text_search.MakeShortSeg('sec-twn-mer'),'sec-twn-mer',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('sec-twn-mer')]}
  ,{text_search.MakeShortSeg('BRIEF-LEGAL'),'BRIEF-LEGAL',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('BRIEF-LEGAL')]}
  ,{text_search.MakeShortSeg('recorder_map_reference'),'recorder_map_reference',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recorder_map_reference')]}
  ,{text_search.MakeShortSeg('CONTRACT-DATE'),'CONTRACT-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('CONTRACT-DATE')]}
  ,{text_search.MakeShortSeg('RECORDED-DATE'),'RECORDED-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('RECORDED-DATE')]}
  ,{text_search.MakeShortSeg('NUMBER'),'NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('NUMBER')]}
  ,{text_search.MakeShortSeg('record_type_desc'),'record_type_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('record_type_desc')]}
  ,{text_search.MakeShortSeg('DEED-TYPE'),'DEED-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('DEED-TYPE')]}
  ,{text_search.MakeShortSeg('LOAN-NUMBER'),'LOAN-NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOAN-NUMBER')]}
  ,{text_search.MakeShortSeg('recorder_book_number'),'recorder_book_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recorder_book_number')]}
  ,{text_search.MakeShortSeg('recorder_page_number'),'recorder_page_number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('recorder_page_number')]}
  ,{text_search.MakeShortSeg('separator'),'separator',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('separator')]}
  ,{text_search.MakeShortSeg('hawaii_tct'),'hawaii_tct',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hawaii_tct')]}
  ,{text_search.MakeShortSeg('hawaii_condo_cpr_desc'),'hawaii_condo_cpr_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('hawaii_condo_cpr_desc')]}
  ,{text_search.MakeShortSeg('CONDO-NAME'),'CONDO-NAME',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CONDO-NAME')]}
  ,{text_search.MakeShortSeg('SALE-PRICE'),'SALE-PRICE',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('SALE-PRICE')]}
  ,{text_search.MakeShortSeg('SALE-PRICE-DESC'),'SALE-PRICE-DESC',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('SALE-PRICE-DESC')]}
  ,{text_search.MakeShortSeg('CITY-TRANS-TAX'),'CITY-TRANS-TAX',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CITY-TRANS-TAX')]}
  ,{text_search.MakeShortSeg('county_transfer_tax'),'county_transfer_tax',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('county_transfer_tax')]}
  ,{text_search.MakeShortSeg('TOTAL-TRANS-TAX'),'TOTAL-TRANS-TAX',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TOTAL-TRANS-TAX')]}
  ,{text_search.MakeShortSeg('EXCISE-TAX-NUMBER'),'EXCISE-TAX-NUMBER',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('EXCISE-TAX-NUMBER')]}
  ,{text_search.MakeShortSeg('LAND-USE'),'LAND-USE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LAND-USE')]}
  ,{text_search.MakeShortSeg('PROPERTY-USE'),'PROPERTY-USE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('PROPERTY-USE')]}
  ,{text_search.MakeShortSeg('condo_desc_in'),'condo_desc_in',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('condo_desc_in')]}
  ,{text_search.MakeShortSeg('TIMESHARE'),'TIMESHARE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TIMESHARE')]}
  ,{text_search.MakeShortSeg('RATE-CHANGE'),'RATE-CHANGE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('RATE-CHANGE')]}
  ,{text_search.MakeShortSeg('CHANGE-INDEX'),'CHANGE-INDEX',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('CHANGE-INDEX')]}
  ,{text_search.MakeShortSeg('ADJ-INDEX'),'ADJ-INDEX',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('ADJ-INDEX')]}
  ,{text_search.MakeShortSeg('adjustable_rate_rider'),'adjustable_rate_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('adjustable_rate_rider')]}
  ,{text_search.MakeShortSeg('graduated_payment_rider'),'graduated_payment_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('graduated_payment_rider')]}
  ,{text_search.MakeShortSeg('balloon_rider'),'balloon_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('balloon_rider')]}
  ,{text_search.MakeShortSeg('fixed_step_rate_rider'),'fixed_step_rate_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('fixed_step_rate_rider')]}
  ,{text_search.MakeShortSeg('condominium_rider'),'condominium_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('condominium_rider')]}
  ,{text_search.MakeShortSeg('planned_unit_development_rider'),'planned_unit_development_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('planned_unit_development_rider')]}
  ,{text_search.MakeShortSeg('rate_improvement_rider'),'rate_improvement_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('rate_improvement_rider')]}
  ,{text_search.MakeShortSeg('assumability_rider'),'assumability_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('assumability_rider')]}
  ,{text_search.MakeShortSeg('prepayment_rider'),'prepayment_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('prepayment_rider')]}
  ,{text_search.MakeShortSeg('one_four_family_rider'),'one_four_family_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('one_four_family_rider')]}
  ,{text_search.MakeShortSeg('biweekly_payment_rider'),'biweekly_payment_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('biweekly_payment_rider')]}
  ,{text_search.MakeShortSeg('second_home_rider'),'second_home_rider',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('second_home_rider')]}
  ,{text_search.MakeShortSeg('LOAN-AMOUNT'),'LOAN-AMOUNT',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('LOAN-AMOUNT')]}
  ,{text_search.MakeShortSeg('SECOND-LOAN-AMT'),'SECOND-LOAN-AMT',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('SECOND-LOAN-AMT')]}
  ,{text_search.MakeShortSeg('first_td_lender_type_desc'),'first_td_lender_type_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('first_td_lender_type_desc')]}
  ,{text_search.MakeShortSeg('second_td_lender_type_desc'),'second_td_lender_type_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('second_td_lender_type_desc')]}
  ,{text_search.MakeShortSeg('LOAN-TYPE'),'LOAN-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('LOAN-TYPE')]}
  ,{text_search.MakeShortSeg('type_financing'),'type_financing',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('type_financing')]}
  ,{text_search.MakeShortSeg('RATE'),'RATE',text_search.types.SegmentType.NumericType,[text_search.MakeShortSeg('RATE')]}
  ,{text_search.MakeShortSeg('DUE-DATE'),'DUE-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('DUE-DATE')]}
  ,{text_search.MakeShortSeg('TITLE-COMPANY'),'TITLE-COMPANY',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TITLE-COMPANY')]}
  ,{text_search.MakeShortSeg('INTEREST-TRANS'),'INTEREST-TRANS',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('INTEREST-TRANS')]}
  ,{text_search.MakeShortSeg('loan_term_months'),'loan_term_months',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('loan_term_months')]}
  ,{text_search.MakeShortSeg('loan_term_years'),'loan_term_years',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('loan_term_years')]}
  ,{text_search.MakeShortSeg('MORTGAGE-DATE'),'MORTGAGE-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('MORTGAGE-DATE')]}
  ,{text_search.MakeShortSeg('mortgage_deed_type_desc'),'mortgage_deed_type_desc',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('mortgage_deed_type_desc')]}
  ,{text_search.MakeShortSeg('TERMS'),'TERMS',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TERMS')]}
  ,{text_search.MakeShortSeg('excise-trans-number'),'excise-trans-number',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('excise-trans-number')]}
  ,{text_search.MakeShortSeg('TYPE-FINANCE'),'TYPE-FINANCE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TYPE-FINANCE')]}
  ,{text_search.MakeShortSeg('TRANSACTION-TYPE'),'TRANSACTION-TYPE',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('TRANSACTION-TYPE')]}
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
  ,{text_search.MakeShortSeg('date_from_assesor'),'date_from_assesor',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('date_from_assesor')]}
  ,{text_search.MakeShortSeg('field_from_assesor'),'field_from_assesor',text_search.types.SegmentType.TextType,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('TRANSFER-DATE'),'TRANSFER-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('TRANSFER-DATE')]}
  ,{text_search.MakeShortSeg('SALE-DATE'),'SALE-DATE',text_search.types.SegmentType.DateType,[text_search.MakeShortSeg('SALE-DATE')]}
  ,{text_search.MakeShortSeg('BUYER'),'BUYER',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('buyer1'),text_search.MakeShortSeg('buyer_1_id_desc'),text_search.MakeShortSeg('buyer2'),text_search.MakeShortSeg('buyer_2_id_desc')]}
  ,{text_search.MakeShortSeg('BORROWER'),'BORROWER',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('borrower1'),text_search.MakeShortSeg('borrower_1_id_desc'),text_search.MakeShortSeg('borrower2'),text_search.MakeShortSeg('borrower_2_id_desc'),text_search.MakeShortSeg('borrower_vesting_desc')]}
  ,{text_search.MakeShortSeg('SELLER'),'SELLER',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('seller1'),text_search.MakeShortSeg('seller_1_id_desc'),text_search.MakeShortSeg('seller2'),text_search.MakeShortSeg('seller_2_id_desc')]}
  ,{text_search.MakeShortSeg('LENDER'),'LENDER',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('lender_name'),text_search.MakeShortSeg('lender_dba_aka_name')]}
  ,{text_search.MakeShortSeg('BOOK_PAGE'),'BOOK_PAGE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('recorder_book_number'),text_search.MakeShortSeg('separator'),text_search.MakeShortSeg('recorder_page_number')]}
  ,{text_search.MakeShortSeg('BUYER_ADDRESS'),'BUYER_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('buyer_mailing_full_street_address'),text_search.MakeShortSeg('buyer_mailing_address_unit_number'),text_search.MakeShortSeg('buyer_mailing_address_citystatezip')]}
  ,{text_search.MakeShortSeg('BORROWER_ADDRESS'),'BORROWER_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('borrower_mailing_full_street_address'),text_search.MakeShortSeg('borrower_mailing_unit_number'),text_search.MakeShortSeg('borrower_mailing_citystatezip')]}
  ,{text_search.MakeShortSeg('SELLER_ADDRESS'),'SELLER_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('seller_mailing_full_street_address'),text_search.MakeShortSeg('seller_mailing_address_unit_number'),text_search.MakeShortSeg('seller_mailing_address_citystatezip')]}
  ,{text_search.MakeShortSeg('PROPERTY_ADDRESS'),'PROPERTY_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_address_unit_number'),text_search.MakeShortSeg('property_address_citystatezip')]}
  ,{text_search.MakeShortSeg('LENDER_ADDRESS'),'LENDER_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('lender_full_street_address'),text_search.MakeShortSeg('lender_address_unit_number'),text_search.MakeShortSeg('lender_address_citystatezip')]}
  ,{text_search.MakeShortSeg('TRACT'),'TRACT',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('legal_tract_number'),text_search.MakeShortSeg('hawaii_tct')]}
  ,{text_search.MakeShortSeg('CONDO_DESC'),'CONDO_DESC',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('condo_desc_in'),text_search.MakeShortSeg('hawaii_condo_cpr_desc')]}
  ,{text_search.MakeShortSeg('COUNTY_TRANS_TAX'),'COUNTY_TRANS_TAX',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('COUNTY'),text_search.MakeShortSeg('county_transfer_tax')]}
  ,{text_search.MakeShortSeg('LENDER_TYPE'),'LENDER_TYPE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('first_td_lender_type_desc'),text_search.MakeShortSeg('second_td_lender_type_desc')]}
  ,{text_search.MakeShortSeg('RIDER'),'RIDER',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('adjustable_rate_rider'),text_search.MakeShortSeg('graduated_payment_rider'),text_search.MakeShortSeg('balloon_rider'),text_search.MakeShortSeg('fixed_step_rate_rider'),text_search.MakeShortSeg('condominium_rider'),text_search.MakeShortSeg('planned_unit_development_rider'),text_search.MakeShortSeg('rate_improvement_rider'),text_search.MakeShortSeg('assumability_rider'),text_search.MakeShortSeg('prepayment_rider'),text_search.MakeShortSeg('one_four_family_rider'),text_search.MakeShortSeg('biweekly_payment_rider'),text_search.MakeShortSeg('second_home_rider')]}
  ,{text_search.MakeShortSeg('MORTGAGE_TYPE'),'MORTGAGE_TYPE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('record_type_desc'),text_search.MakeShortSeg('mortgage_deed_type_desc')]}
  ,{text_search.MakeShortSeg('TERM'),'TERM',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('loan_term_months'),text_search.MakeShortSeg('loan_term_years')]}
  ,{text_search.MakeShortSeg('CASS_ADDRESS'),'CASS_ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range')]}
  ,{text_search.MakeShortSeg('CASS_CSZ'),'CASS_CSZ',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4')]}
  ,{text_search.MakeShortSeg('CLEAN_NAME'),'CLEAN_NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix')]}
  ,{text_search.MakeShortSeg('NAME'),'NAME',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('title'),text_search.MakeShortSeg('fname'),text_search.MakeShortSeg('mname'),text_search.MakeShortSeg('lname'),text_search.MakeShortSeg('name_suffix'),text_search.MakeShortSeg('cname'),text_search.MakeShortSeg('nameasis'),text_search.MakeShortSeg('buyer1'),text_search.MakeShortSeg('buyer2'),text_search.MakeShortSeg('borrower1'),text_search.MakeShortSeg('borrower2'),text_search.MakeShortSeg('seller1'),text_search.MakeShortSeg('seller2'),text_search.MakeShortSeg('lender_name'),text_search.MakeShortSeg('lender_dba_aka_name')]}
  ,{text_search.MakeShortSeg('ADDRESS'),'ADDRESS',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('prim_range'),text_search.MakeShortSeg('predir'),text_search.MakeShortSeg('prim_name'),text_search.MakeShortSeg('suffix'),text_search.MakeShortSeg('postdir'),text_search.MakeShortSeg('unit_desig'),text_search.MakeShortSeg('sec_range'),text_search.MakeShortSeg('v_city_name'),text_search.MakeShortSeg('st'),text_search.MakeShortSeg('zip'),text_search.MakeShortSeg('zip4'),text_search.MakeShortSeg('buyer_mailing_full_street_address'),text_search.MakeShortSeg('buyer_mailing_address_unit_number'),text_search.MakeShortSeg('buyer_mailing_address_citystatezip'),text_search.MakeShortSeg('borrower_mailing_full_street_address'),text_search.MakeShortSeg('borrower_mailing_unit_number'),text_search.MakeShortSeg('borrower_mailing_citystatezip'),text_search.MakeShortSeg('seller_mailing_full_street_address'),text_search.MakeShortSeg('seller_mailing_address_unit_number'),text_search.MakeShortSeg('seller_mailing_address_citystatezip'),text_search.MakeShortSeg('property_full_street_address'),text_search.MakeShortSeg('property_address_unit_number'),text_search.MakeShortSeg('property_address_citystatezip'),text_search.MakeShortSeg('lender_full_street_address'),text_search.MakeShortSeg('lender_address_unit_number'),text_search.MakeShortSeg('lender_address_citystatezip')]}
  ,{text_search.MakeShortSeg('LEGAL_DESC'),'LEGAL_DESC',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('LOT-DESC'),text_search.MakeShortSeg('LOT-NUMBER'),text_search.MakeShortSeg('BLOCK'),text_search.MakeShortSeg('SECTION'),text_search.MakeShortSeg('DISTRICT'),text_search.MakeShortSeg('LAND-LOT'),text_search.MakeShortSeg('UNIT'),text_search.MakeShortSeg('SUBDIVISION'),text_search.MakeShortSeg('PHASE'),text_search.MakeShortSeg('legal_tract_number'),text_search.MakeShortSeg('muni-twp'),text_search.MakeShortSeg('sec-twn-mer'),text_search.MakeShortSeg('recorder_map_reference'),text_search.MakeShortSeg('hawaii_tct')]}
  ,{text_search.MakeShortSeg('MORTGAGE'),'MORTGAGE',text_search.types.SegmentType.ConcatSeg,[text_search.MakeShortSeg('record_type_desc'),text_search.MakeShortSeg('LOAN-TYPE'),text_search.MakeShortSeg('TYPE-FINANCE'),text_search.MakeShortSeg('DEED-TYPE'),text_search.MakeShortSeg('mortgage_deed_type_desc'),text_search.MakeShortSeg('type_financing'),text_search.MakeShortSeg('TRANSACTION-TYPE')]}
  ,{text_search.MakeShortSeg('DATE'),'DATE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('CONTRACT-DATE'),text_search.MakeShortSeg('RECORDED-DATE'),text_search.MakeShortSeg('MORTGAGE-DATE'),text_search.MakeShortSeg('DUE-DATE'),text_search.MakeShortSeg('TRANSFER-DATE'),text_search.MakeShortSeg('SALE-DATE')]}
  ,{text_search.MakeShortSeg('PHONE'),'PHONE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('PHONE-NUMBER')]}
  ,{text_search.MakeShortSeg('DOCUMENT_TYPE'),'DOCUMENT_TYPE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('DEED-TYPE')]}
  ,{text_search.MakeShortSeg('COMPANY'),'COMPANY',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('cname')]}
  ,{text_search.MakeShortSeg('cert_date'),'cert_date',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('date_from_assesor')]}
  ,{text_search.MakeShortSeg('process_date'),'process_date',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('date_from_assesor')]}
  ,{text_search.MakeShortSeg('asses_imp_value'),'asses_imp_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('building_name'),'building_name',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('census_tract'),'census_tract',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('characteristics'),'characteristics',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('condo_proj_name'),'condo_proj_name',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('effect_year_built'),'effect_year_built',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('exemption'),'exemption',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('homeowner_exempt'),'homeowner_exempt',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('land_value'),'land_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('mailing_address'),'mailing_address',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('mar_land_value'),'mar_land_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('mar_year_assess'),'mar_year_assess',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('neighbor_desc'),'neighbor_desc',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('owner_occupied'),'owner_occupied',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('owners'),'owners',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('ownership_type'),'ownership_type',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('PRIOR_SALE_PRICE'),'PRIOR_SALE_PRICE',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tax_amount'),'tax_amount',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tax_rate'),'tax_rate',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tax_year'),'tax_year',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tax_account_number'),'tax_account_number',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tot_imp_value'),'tot_imp_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('tot_mar_value'),'tot_mar_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('total_value'),'total_value',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('year_assess'),'year_assess',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('year_built'),'year_built',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
  ,{text_search.MakeShortSeg('zoning'),'zoning',text_search.types.SegmentType.GroupSeg,[text_search.MakeShortSeg('field_from_assesor')]}
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

