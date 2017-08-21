Generated by SALT V2.6 Gold SR1
File being processed :-
MODULE:CDKelly
FILENAME:Epsilon_base
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 1.255990e+266tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:state_code:TYPE(STRING2):0,0
FIELD:zip_code:TYPE(STRING5):0,0
FIELD:zipplus_4:TYPE(STRING4):0,0
FIELD:delivery_point_code:TYPE(STRING3):0,0
FIELD:carrier_route:TYPE(STRING4):0,0
FIELD:blank_space1:TYPE(STRING5):0,0
FIELD:dsf_season_code:TYPE(STRING1):0,0
FIELD:dsf_delivery_type_code:TYPE(STRING1):0,0
FIELD:blank_space2:TYPE(STRING3):0,0
FIELD:surname:TYPE(STRING20):0,0
FIELD:primary_given_name:TYPE(STRING14):0,0
FIELD:primary_middle_initial:TYPE(STRING1):0,0
FIELD:primary_name_suffix:TYPE(STRING2):0,0
FIELD:primary_title_code:TYPE(STRING1):0,0
FIELD:primary_gender:TYPE(STRING1):0,0
FIELD:secondary_given_name:TYPE(STRING14):0,0
FIELD:secondary_title_code:TYPE(STRING1):0,0
FIELD:house_number:TYPE(STRING11):0,0
FIELD:fraction:TYPE(STRING3):0,0
FIELD:street_prefix_direction:TYPE(STRING2):0,0
FIELD:contracted_street_address:TYPE(STRING40):0,0
FIELD:route_designator_and_number:TYPE(STRING6):0,0
FIELD:box_designator_and_number:TYPE(STRING15):0,0
FIELD:secondary_unit_designation:TYPE(STRING15):0,0
FIELD:post_office_name:TYPE(STRING15):0,0
FIELD:state_abbreviation:TYPE(STRING2):0,0
FIELD:county_code:TYPE(STRING3):0,0
FIELD:phone_suppression_source:TYPE(STRING1):0,0
FIELD:msas:TYPE(STRING4):0,0
FIELD:blank_space3:TYPE(STRING4):0,0
FIELD:dma:TYPE(STRING4):0,0
FIELD:nielson_county_size_code:TYPE(STRING1):0,0
FIELD:area_codeall_available:TYPE(STRING3):0,0
FIELD:telephoneall_available:TYPE(STRING7):0,0
FIELD:status_code_of_records:TYPE(STRING1):0,0
FIELD:addressname_censor_code:TYPE(STRING1):0,0
FIELD:address_quality_code:TYPE(STRING1):0,0
FIELD:address_type:TYPE(STRING1):0,0
FIELD:file_code:TYPE(STRING1):0,0
FIELD:blank_space4:TYPE(STRING1):0,0
FIELD:home_ownerrenter_code:TYPE(STRING1):0,0
FIELD:advhome_owner:TYPE(STRING1):0,0
FIELD:advhome_owner_indicator:TYPE(STRING1):0,0
FIELD:household_type_code:TYPE(STRING2):0,0
FIELD:marital_status:TYPE(STRING1):0,0
FIELD:advhousehold_marital_status_indicator:TYPE(STRING1):0,0
FIELD:blank_space5:TYPE(STRING3):0,0
FIELD:dwelling_type:TYPE(STRING1):0,0
FIELD:advdwelling_type_indicator:TYPE(STRING1):0,0
FIELD:length_of_residence:TYPE(STRING1):0,0
FIELD:advlength_of_residence_indicator:TYPE(STRING1):0,0
FIELD:blank_space6:TYPE(STRING1):0,0
FIELD:structure_age_year:TYPE(STRING4):0,0
FIELD:verification_date_of_household:TYPE(STRING6):0,0
FIELD:blank_space43:TYPE(STRING2):0,0
FIELD:number_of_sources_verifying_household:TYPE(STRING2):0,0
FIELD:blank_space7:TYPE(STRING2):0,0
FIELD:narrow_band_income_predictor:TYPE(STRING1):0,0
FIELD:estimated_home_income_predictor:TYPE(STRING1):0,0
FIELD:income_model_indicator:TYPE(STRING1):0,0
FIELD:niches:TYPE(STRING3):0,0
FIELD:blank_space8:TYPE(STRING1):0,0
FIELD:mail_public_responder_indicator:TYPE(STRING1):0,0
FIELD:mail_responsive_buyer_indicator:TYPE(STRING1):0,0
FIELD:mail_responsive_donor_indicator:TYPE(STRING1):0,0
FIELD:blank_space9:TYPE(STRING6):0,0
FIELD:outdoors_dimension_household:TYPE(STRING1):0,0
FIELD:athletic_dimension_household:TYPE(STRING1):0,0
FIELD:fitness_dimension_household:TYPE(STRING1):0,0
FIELD:domestic_dimension_household:TYPE(STRING1):0,0
FIELD:good_life_dimension_household:TYPE(STRING1):0,0
FIELD:cultural_dimension_household:TYPE(STRING1):0,0
FIELD:blue_chip_dimension_household:TYPE(STRING1):0,0
FIELD:do_it_yourself_dimension_household:TYPE(STRING1):0,0
FIELD:technology_dimension_household:TYPE(STRING1):0,0
FIELD:household_occupation:TYPE(STRING2):0,0
FIELD:blank_space10:TYPE(STRING1):0,0
FIELD:combined_market_value_of_all_vehicles:TYPE(STRING4):0,0
FIELD:number_of_cars_currently_registered_owned:TYPE(STRING1):0,0
FIELD:body_size_class_of_newest_car_owned:TYPE(STRING2):0,0
FIELD:truck_owner_code:TYPE(STRING1):0,0
FIELD:new_vehicle_purchase_code:TYPE(STRING1):0,0
FIELD:motorcycle_ownership_code:TYPE(STRING1):0,0
FIELD:recreational_vehicle_ownership_code:TYPE(STRING1):0,0
FIELD:advhousehold_age:TYPE(STRING1):0,0
FIELD:age_indicator:TYPE(STRING1):0,0
FIELD:household_age_code:TYPE(STRING1):0,0
FIELD:advhousehold_size:TYPE(STRING1):0,0
FIELD:advhousehold_size_indicator:TYPE(STRING1):0,0
FIELD:number_of_persons_in_household:TYPE(STRING1):0,0
FIELD:number_of_adults_in_household:TYPE(STRING1):0,0
FIELD:advnumber_of_adults_indicator:TYPE(STRING1):0,0
FIELD:number_of_children_in_household:TYPE(STRING1):0,0
FIELD:age_unknown_of_adults:TYPE(STRING1):0,0
FIELD:age_75_years_old_specific:TYPE(STRING1):0,0
FIELD:age_65to74_year_old_specific:TYPE(STRING1):0,0
FIELD:age_55to64_year_old_specific:TYPE(STRING1):0,0
FIELD:age_45to54_year_old_specific:TYPE(STRING1):0,0
FIELD:age_35to44_year_old_specific:TYPE(STRING1):0,0
FIELD:age_25to34_year_old_specific:TYPE(STRING1):0,0
FIELD:age_18to24_year_old_specific:TYPE(STRING1):0,0
FIELD:presence_of_adults_age_65_inferred:TYPE(STRING1):0,0
FIELD:age_45to64_year_old_inferred:TYPE(STRING1):0,0
FIELD:age_35to44_year_old_inferred:TYPE(STRING1):0,0
FIELD:presence_of_adults_age_under_35_inferred:TYPE(STRING1):0,0
FIELD:children_age_0_to_2:TYPE(STRING1):0,0
FIELD:children_age_3_to_5:TYPE(STRING1):0,0
FIELD:children_age_6_to_10:TYPE(STRING1):0,0
FIELD:children_age_11_to_15:TYPE(STRING1):0,0
FIELD:children_age_16_to_17:TYPE(STRING1):0,0
FIELD:children_age_0_to_17_unknown_gender:TYPE(STRING1):0,0
FIELD:blank_space11:TYPE(STRING1):0,0
FIELD:title_code_1:TYPE(STRING1):0,0
FIELD:gender_1:TYPE(STRING1):0,0
FIELD:age_1:TYPE(STRING3):0,0
FIELD:birth_year_1:TYPE(STRING4):0,0
FIELD:birth_month_1:TYPE(STRING2):0,0
FIELD:given_name_1:TYPE(STRING14):0,0
FIELD:middle_initial_1:TYPE(STRING1):0,0
FIELD:member_code_of_person_1:TYPE(STRING1):0,0
FIELD:title_code_2:TYPE(STRING1):0,0
FIELD:gender_2:TYPE(STRING1):0,0
FIELD:age_2:TYPE(STRING3):0,0
FIELD:birth_year_2:TYPE(STRING4):0,0
FIELD:birth_month_2:TYPE(STRING2):0,0
FIELD:given_name_2:TYPE(STRING14):0,0
FIELD:middle_initial_2:TYPE(STRING1):0,0
FIELD:member_code_of_person_2:TYPE(STRING1):0,0
FIELD:title_code_3:TYPE(STRING1):0,0
FIELD:gender_3:TYPE(STRING1):0,0
FIELD:age_3:TYPE(STRING3):0,0
FIELD:birth_year_3:TYPE(STRING4):0,0
FIELD:birth_month_3:TYPE(STRING2):0,0
FIELD:given_name_3:TYPE(STRING14):0,0
FIELD:middle_initial_3:TYPE(STRING1):0,0
FIELD:member_code_of_person_3:TYPE(STRING1):0,0
FIELD:title_code_4:TYPE(STRING1):0,0
FIELD:gender_4:TYPE(STRING1):0,0
FIELD:age_4:TYPE(STRING3):0,0
FIELD:birth_year_4:TYPE(STRING4):0,0
FIELD:birth_month_4:TYPE(STRING2):0,0
FIELD:given_name_4:TYPE(STRING14):0,0
FIELD:middle_initial_4:TYPE(STRING1):0,0
FIELD:member_code_of_person_4:TYPE(STRING1):0,0
FIELD:title_code_5:TYPE(STRING1):0,0
FIELD:gender_5:TYPE(STRING1):0,0
FIELD:age_5:TYPE(STRING3):0,0
FIELD:birth_year_5:TYPE(STRING4):0,0
FIELD:birth_month_5:TYPE(STRING2):0,0
FIELD:given_name_5:TYPE(STRING14):0,0
FIELD:middle_initial_5:TYPE(STRING1):0,0
FIELD:member_code_of_person_5:TYPE(STRING1):0,0
FIELD:us_census_tract_identifier_2000:TYPE(STRING4):0,0
FIELD:census_tract_suffix:TYPE(STRING2):0,0
FIELD:block_group_number:TYPE(STRING1):0,0
FIELD:blank_space12:TYPE(STRING10):0,0
FIELD:us_census_state_code_2000:TYPE(STRING2):0,0
FIELD:us_census_county_code_2000:TYPE(STRING3):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:smacs_2000_level:TYPE(STRING1):0,0
FIELD:median_household_income_3_bytes:TYPE(STRING3):0,0
FIELD:households_with_related_children:TYPE(STRING2):0,0
FIELD:median_age_of_adults_18_or_older_3_bytes:TYPE(STRING3):0,0
FIELD:median_school_years_completed_by_adults_25_3_bytes:TYPE(STRING3):0,0
FIELD:percent_employed_managerial_and_professional:TYPE(STRING2):0,0
FIELD:managementbusinessfinancial_operations:TYPE(STRING2):0,0
FIELD:owner_occupied_housing_units:TYPE(STRING2):0,0
FIELD:percent_in_single_unit_structures:TYPE(STRING2):0,0
FIELD:median_home_value_4_bytes:TYPE(STRING4):0,0
FIELD:percent_owner_occupied_structures_built_since_1990:TYPE(STRING2):0,0
FIELD:percent_persons_move_in_since_1995:TYPE(STRING2):0,0
FIELD:percent_of_motor_vehicle_ownership:TYPE(STRING2):0,0
FIELD:percent_white:TYPE(STRING2):0,0
FIELD:blank_space13:TYPE(STRING1):0,0
FIELD:cbsa_code:TYPE(STRING5):0,0
FIELD:blank_space14:TYPE(STRING6):0,0
FIELD:credit_card_usage_miscellaneous:TYPE(STRING1):0,0
FIELD:credit_card_usage_standard_retail:TYPE(STRING1):0,0
FIELD:credit_card_usage_standard_specialty_card:TYPE(STRING1):0,0
FIELD:credit_card_usage_upscale_retail:TYPE(STRING1):0,0
FIELD:credit_card_usage_upscale_spec_retail:TYPE(STRING1):0,0
FIELD:credit_card_usage_bank_card:TYPE(STRING1):0,0
FIELD:credit_card_usage_oil__gas_card:TYPE(STRING1):0,0
FIELD:credit_card_usage_finance_co_card:TYPE(STRING1):0,0
FIELD:credit_card_usage_travel__entertainment:TYPE(STRING1):0,0
FIELD:tcc_american_express:TYPE(STRING1):0,0
FIELD:tcc_any_credit_card:TYPE(STRING1):0,0
FIELD:tcc_catalog_showroom:TYPE(STRING1):0,0
FIELD:tcc_computerelectronic:TYPE(STRING1):0,0
FIELD:tcc_debit_card:TYPE(STRING1):0,0
FIELD:tcc_furniture:TYPE(STRING1):0,0
FIELD:tcc_grocery:TYPE(STRING1):0,0
FIELD:tcc_home_improvement:TYPE(STRING1):0,0
FIELD:tcc_homeoffice_supply:TYPE(STRING1):0,0
FIELD:tcc_low_end_department_store:TYPE(STRING1):0,0
FIELD:tcc_main_street_retail:TYPE(STRING1):0,0
FIELD:tcc_mastercard:TYPE(STRING1):0,0
FIELD:tcc_membership_warehouse:TYPE(STRING1):0,0
FIELD:tcc_specialty_apparel:TYPE(STRING1):0,0
FIELD:tcc_sporting_goods:TYPE(STRING1):0,0
FIELD:tcc_tv_mail_order:TYPE(STRING1):0,0
FIELD:tcc_visa:TYPE(STRING1):0,0
FIELD:responder_education_code_1:TYPE(STRING1):0,0
FIELD:responder_education_code_2:TYPE(STRING1):0,0
FIELD:responder_education_code_3:TYPE(STRING1):0,0
FIELD:responder_education_code_4:TYPE(STRING1):0,0
FIELD:spouse_education_code_1:TYPE(STRING1):0,0
FIELD:spouse_education_code_2:TYPE(STRING1):0,0
FIELD:spouse_education_code_3:TYPE(STRING1):0,0
FIELD:spouse_education_code_4:TYPE(STRING1):0,0
FIELD:advhousehold_education:TYPE(STRING1):0,0
FIELD:advhousehold_education_indicator:TYPE(STRING1):0,0
FIELD:household_income_identifier:TYPE(STRING1):0,0
FIELD:narrow_band_household_income_identifier:TYPE(STRING1):0,0
FIELD:income_model_indicator2:TYPE(STRING1):0,0
FIELD:lf:TYPE(STRING2):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:zip:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dpbc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:ace_fips_st:TYPE(STRING2):0,0
FIELD:fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:telephone:TYPE(STRING10):0,0
FIELD:gender:TYPE(STRING1):0,0
FIELD:age:TYPE(STRING3):0,0
FIELD:birth_year:TYPE(STRING4):0,0
FIELD:birth_month:TYPE(STRING2):0,0
FIELD:member_code_of_person:TYPE(STRING1):0,0
FIELD:household_member_cnt:TYPE(STRING1):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
Total available specificity:0
Search Threshold set at -4
+++Line:273:Need threshold and blockthreshold to continue
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
