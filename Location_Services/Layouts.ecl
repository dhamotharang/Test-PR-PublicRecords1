IMPORT doxie, LN_PropertyV2, Risk_Indicators, Relationship;

EXPORT Layouts :=
MODULE

  EXPORT In :=
  RECORD
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING APNNumber;
  END;

  EXPORT AkResultsWithPenalty :=
  RECORD
    RECORDOF(LN_Propertyv2.file_search_autokey);
    UNSIGNED2 penalt;
  END;

  EXPORT FaresId :=
  RECORD
    LN_Propertyv2.layout_property_common_model_base.ln_fares_id;
  END;

  EXPORT FakeId :=
  RECORD
    UNSIGNED6 Id     := 0;
    BOOLEAN   isDID  := FALSE;
    BOOLEAN   isBDID := FALSE;
    BOOLEAN   IsFake;
  END;

  // Clean name and address with HRI
  EXPORT PropCleanNameAddr :=
  RECORD
    LN_PropertyV2.layout_search_building;
    DATASET(Risk_Indicators.Layout_Desc) hri_address;
  END;

  // Clean name with HRI
  SHARED Name :=
  RECORD
    STRING20  fname;
    STRING20  mname;
    STRING20  lname;
    STRING5   name_suffix;
    STRING60  full_name;
    STRING9   ssn;
    UNSIGNED6 did;
    UNSIGNED6 bdid;
    DATASET(Risk_Indicators.Layout_Desc) hri_individual;
  END;

  // Cluster collusion attributes
  SHARED ClusterCollusionAttrs :=
  RECORD
    UNSIGNED4 cluster_foreclosure_default_count_0_degree;
    UNSIGNED4 cluster_in_network_high_profit_0_degree;
    UNSIGNED4 cluster_in_network_flip_count_0_degree;
    UNSIGNED4 cluster_flip_0_degree;
    UNSIGNED4 cluster_high_profit_count_0_degree;
    UNSIGNED4 cluster_foreclosure_default_count;
    UNSIGNED4 cluster_in_network_flip_count;
    UNSIGNED4 cluster_in_network_flop;
    UNSIGNED4 cluster_in_network_high_profit_flip_count;
    UNSIGNED4 cluster_in_network_high_profit;
    UNSIGNED4 cluster_flop_count;
    UNSIGNED4 cluster_flip_count;
    UNSIGNED4 cluster_flip_business_count;
    UNSIGNED4 prop_people_count;
    REAL4     prop_network_cohesivity;
    UNSIGNED4 cluster_foreclosure_count;
    UNSIGNED4 distinct_property_count;
    INTEGER1  RiskIndex;
    INTEGER1  ClusterRiskIndex;
  END;

  EXPORT NameWithCollusionAttrs := {UNSIGNED2 seq} or Name or ClusterCollusionAttrs;

  EXPORT NameWithFaresId := FaresId or {BOOLEAN isBuyer} or NameWithCollusionAttrs;

  // DID with seq
  EXPORT DIDWithSeq := {NameWithFaresId.seq,NameWithFaresId.did};

  // Buyer, seller relationship
  EXPORT BuyerSellerRelationship :=
  RECORD
    UNSIGNED2 seq;
    UNSIGNED6 buyer_did;
    UNSIGNED6 seller_did;
    STRING50  relationship;
  END;

  // Assessments
  EXPORT Assessments :=
  RECORD(FaresId)
    STRING5  vendor_source_flag;
    LN_Propertyv2.layout_property_common_model_base.fares_unformatted_apn;
    LN_Propertyv2.layout_property_common_model_base.apna_or_pin_number;
    LN_Propertyv2.layout_addl_fares_tax.fares_iris_apn;
    LN_Propertyv2.layout_property_common_model_base.legal_brief_description;
    LN_Propertyv2.layout_property_common_model_base.legal_subdivision_name;
    LN_Propertyv2.layout_property_common_model_base.standardized_land_use_code;
    LN_Propertyv2.layout_property_common_model_base.assessed_land_value;
    LN_Propertyv2.layout_property_common_model_base.assessed_improvement_value;
    LN_Propertyv2.layout_addl_fares_tax.fares_calculated_total_value;
    LN_Propertyv2.layout_property_common_model_base.assessed_total_value;
    LN_Propertyv2.layout_property_common_model_base.market_land_value;
    LN_Propertyv2.layout_property_common_model_base.market_improvement_value;
    LN_Propertyv2.layout_property_common_model_base.market_total_value;
    LN_Propertyv2.layout_property_common_model_base.tax_amount;
    LN_Propertyv2.layout_property_common_model_base.tax_year;
    LN_Propertyv2.layout_property_common_model_base.no_of_stories;
    LN_Propertyv2.layout_property_common_model_base.no_of_bedrooms;
    LN_Propertyv2.layout_property_common_model_base.no_of_baths;
    LN_Propertyv2.layout_property_common_model_base.style_code;
    LN_Propertyv2.layout_property_common_model_base.year_built;
    LN_Propertyv2.layout_property_common_model_base.lot_size;
    LN_Propertyv2.layout_property_common_model_base.land_square_footage;
    LN_Propertyv2.layout_addl_fares_tax.fares_condition;
    LN_Propertyv2.layout_property_common_model_base.fireplace_indicator;
    LN_Propertyv2.layout_property_common_model_base.air_conditioning_code;
    LN_Propertyv2.layout_property_common_model_base.heating_code;
    LN_Propertyv2.layout_property_common_model_base.heating_fuel_type_code;
    LN_Propertyv2.layout_property_common_model_base.sewer_code;
    LN_Propertyv2.layout_property_common_model_base.water_code;
    LN_Propertyv2.layout_addl_fares_tax.fares_electric_energy;
    LN_Propertyv2.layout_addl_fares_tax.fares_frame;
    LN_Propertyv2.layout_property_common_model_base.roof_cover_code;
    LN_Propertyv2.layout_property_common_model_base.roof_type_code;
    STRING25 land_use_desc;
    STRING25 style_desc;
    STRING8  living_square_footage;
    STRING1  pool_indicator;
    STRING25 condition_desc;
    STRING25 air_conditioning_desc;
    STRING25 heating_desc;
    STRING25 fuel_type_desc;
    STRING25 sewer_desc;
    STRING25 water_desc;
    STRING25 electric_energy_desc;
    STRING25 frame_desc;
    STRING25 roof_cover_desc;
    STRING25 roof_type_desc;
  END;

  // Deeds
  EXPORT Deeds :=
  RECORD(FaresId)
    UNSIGNED2 seq;
    UNSIGNED2 group_id;
    STRING1   vendor;
    STRING5   vendor_source_flag;
    STRING20  book_page_num;
    UNSIGNED1 cnt_key_fields;
    INTEGER1  rec_type;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.sales_price;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.first_td_loan_amount;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.second_td_loan_amount;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.lender_name;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.title_company_name;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.contract_date;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.recording_date;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.document_type_code;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.document_number;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.recorder_book_number;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.recorder_page_number;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.name1;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.name2;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.seller1;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.seller2;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.first_td_due_date;
    LN_Propertyv2.layout_deed_mortgage_common_model_base.record_type;
    DATASET(NameWithCollusionAttrs)      buyers;
    DATASET(NameWithCollusionAttrs)      sellers;
    DATASET(Risk_Indicators.Layout_Desc) hri_transactions;
    DATASET(BuyerSellerRelationship)     buyer_seller_relationship;
    STRING50  document_type_desc;
    STRING50  relationship;
    INTEGER4  price_change_percent;
    INTEGER4  days;
    BOOLEAN   flip;
    BOOLEAN   flop;
    BOOLEAN   in_network;
    BOOLEAN   high_profit;
    BOOLEAN   high_profit_flip;
    BOOLEAN   high_profit_flop;
    BOOLEAN   in_network_flip;
    BOOLEAN   in_network_flop;
    BOOLEAN   in_network_high_profit;
    BOOLEAN   in_network_high_profit_flip;
    BOOLEAN   in_network_high_profit_flop;
    UNSIGNED4 in_network_high_profit_flip_count;
    UNSIGNED4 flip_count;
    UNSIGNED4 flop_count;
    UNSIGNED4 in_network_flip_business_count;
    UNSIGNED4 high_profit_flip_count;
    UNSIGNED4 in_network_flip_count;
    UNSIGNED4 in_network_high_profit_count;
    UNSIGNED4 suspicious_deed_count;
    UNSIGNED4 in_network_count;
    BOOLEAN   mortgage_foreclosure;
    BOOLEAN   mortgage_default;
    BOOLEAN   has_mortgage_foreclosure_preceeding_suspicious;
    BOOLEAN   has_mortgage_default_preceeding_suspicious;
    BOOLEAN   has_mortgage_foreclosure;
    BOOLEAN   has_mortgage_default;
    INTEGER1  property_status_risk_index;
    INTEGER1  property_history_risk_index;
  END;

  EXPORT RelDetailsIn :=
  RECORD(doxie.layout_references)
    UNSIGNED6 seq;
  END;

  EXPORT DIDsOfIntWSubj :=
  RECORD
    UNSIGNED6 seq;
    UNSIGNED6 src_did;
    doxie.layout_references;
  END;

  EXPORT RelDetailsTemp :=
  RECORD
    UNSIGNED6  seq;
    UNSIGNED6 src_did;
    UNSIGNED6 did_of_interest       := 0;
    BOOLEAN   found_did_of_interest := FALSE;
    UNSIGNED1 depth                 := 0;
    STRING1   mode                  := '';
    UNSIGNED2 p2_sort               := 0;
    UNSIGNED2 p3_sort               := 0;
    UNSIGNED2 p4_sort               := 0;
    UNSIGNED5 person1;
    UNSIGNED5 person2;
    INTEGER3   recent_cohabit;
    UNSIGNED2 number_cohabits;
    INTEGER2  prim_range;
    Relationship.layout_GetRelationship.InterfaceOutput_new.isRelative;
    Relationship.layout_GetRelationship.InterfaceOutput_new.title;
  END;

  EXPORT RelDetailsOut := {RelDetailsTemp - [did_of_interest,found_did_of_interest,title],STRING20 title};

END;
