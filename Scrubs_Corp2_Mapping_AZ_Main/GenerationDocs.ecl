﻿Generated by SALT V3.11.8
Command line options: -MScrubs_Corp2_Mapping_AZ_Main -eC:\Users\mireleaa\AppData\Local\Temp\TFRE632.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Corp2_Mapping_AZ_Main
FILENAME:In_AZ
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking 
 
//FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_optional_date:ALLOW(0123456789):LENGTHS(0,1,8):CUSTOM(Scrubs.fn_valid_GeneralDate>0)
FIELDTYPE:invalid_corp_key:ALLOW(0123456789-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(4..12)
FIELDTYPE:invalid_corp_vendor:ENUM(04|04)
FIELDTYPE:invalid_state_origin:ENUM(AZ|AZ)
FIELDTYPE:invalid_charter:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..9)
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_name_type_desc:CUSTOM(Scrubs_Corp2_Mapping_AZ_Main.Functions.invalid_name_type_desc>0,recordOrigin)
FIELDTYPE:invalid_forgn_dom_code:ENUM(D|F| )
FIELDTYPE:invalid_for_profit_ind:ENUM(Y|N| )
FIELDTYPE:invalid_alphablankperiod:ALLOW( .ABCDEFGHIJKLMNOPQRSTUVWXYZ-())
FIELDTYPE:invalid_agent_status:ENUM(ACTIVE|RESIGNED| )
 
//FIELD DEFINITIONS
DATEFIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_optional_date):0,0
DATEFIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_optional_date):0,0
DATEFIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_date):0,0
DATEFIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_date):0,0
DATEFIELD:corp_ra_dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_optional_date):0,0
DATEFIELD:corp_ra_dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_optional_date):0,0
FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0
FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0
FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0
DATEFIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:corp_orig_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter):0,0
FIELD:corp_legal_name:TYPE(STRING350):LIKE(invalid_mandatory):0,0
FIELD:corp_ln_name_type_desc:TYPE(STRING30):LIKE(invalid_name_type_desc):0,0
DATEFIELD:corp_filing_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
DATEFIELD:corp_inc_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
DATEFIELD:corp_forgn_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
DATEFIELD:corp_ra_effective_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
DATEFIELD:corp_ra_resign_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
FIELD:corp_inc_state:TYPE(STRING2):LIKE(invalid_state_origin):0,0
FIELD:corp_status_desc:TYPE(STRING60):LIKE(invalid_alphablankperiod):0,0
FIELD:corp_foreign_domestic_ind:TYPE(STRING1):LIKE(invalid_forgn_dom_code):0,0
FIELD:corp_orig_org_structure_desc:TYPE(STRING60):LIKE(invalid_alphablankperiod):0,0
FIELD:corp_for_profit_ind:TYPE(STRING1):LIKE(invalid_for_profit_ind):0,0
FIELD:corp_forgn_state_desc:TYPE(STRING60):LIKE(invalid_alphablankperiod):0,0
FIELD:corp_agent_status_desc:TYPE(STRING50):LIKE(invalid_agent_status):0,0
FIELD:recordOrigin:TYPE(STRING1):0,0
 
//Fields not being Scrubbed
// FIELD:corp_ln_name_type_cd:TYPE(STRING2):LIKE(invalid_name_type_code):0,0
// FIELD:corp_orig_org_structure_cd:TYPE(STRING8):LIKE(invalid_orig_org_structure_cd):0,0
// DATEFIELD:corp_status_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
// DATEFIELD:corp_merger_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
// DATEFIELD:corp_renewal_date:TYPE(STRING8):LIKE(invalid_optional_date):0,0
// FIELD:corp_forgn_state_cd:TYPE(STRING3):0,0
// FIELD:corp_ra_full_name:TYPE(STRING100):0,0
// FIELD:corp_standing:TYPE(STRING1):0,0
// FIELD:corp_status_comment:TYPE(STRING350):0,0
// FIELD:corp_ticker_symbol:TYPE(STRING8):0,0
// FIELD:corp_stock_exchange:TYPE(STRING8):0,0
// FIELD:corp_inc_county:TYPE(STRING30):0,0
// FIELD:corp_anniversary_month:TYPE(STRING15):0,0
// FIELD:corp_fed_tax_id:TYPE(STRING32):0,0
// FIELD:corp_state_tax_id:TYPE(STRING32):0,0
// FIELD:corp_term_exist_cd:TYPE(STRING8):0,0
// FIELD:corp_term_exist_exp:TYPE(STRING8):0,0
// FIELD:corp_term_exist_desc:TYPE(STRING60):0,0
// FIELD:corp_forgn_sos_charter_nbr:TYPE(STRING32):0,0
// FIELD:corp_forgn_fed_tax_id:TYPE(STRING32):0,0
// FIELD:corp_forgn_state_tax_id:TYPE(STRING32):0,0
// FIELD:corp_forgn_term_exist_cd:TYPE(STRING8):0,0
// FIELD:corp_forgn_term_exist_exp:TYPE(STRING8):0,0
// FIELD:corp_forgn_term_exist_desc:TYPE(STRING60):0,0
// FIELD:corp_filing_cd:TYPE(STRING8):0,0
// FIELD:corp_filing_desc:TYPE(STRING60):0,0
// FIELD:corp_supp_key:TYPE(STRING30):0,0
// FIELD:corp_supp_nbr:TYPE(STRING32):0,0
// FIELD:corp_name_comment:TYPE(STRING250):0,0
// FIELD:corp_address1_type_cd:TYPE(STRING8):0,0
// FIELD:corp_address1_type_desc:TYPE(STRING60):0,0
// FIELD:corp_address1_line1:TYPE(STRING70):0,0
// FIELD:corp_address1_line2:TYPE(STRING70):0,0
// FIELD:corp_address1_line3:TYPE(STRING70):0,0
// FIELD:corp_address1_effective_date:TYPE(STRING8):0,0
// FIELD:corp_address2_type_cd:TYPE(STRING8):0,0
// FIELD:corp_address2_type_desc:TYPE(STRING60):0,0
// FIELD:corp_address2_line1:TYPE(STRING70):0,0
// FIELD:corp_address2_line2:TYPE(STRING70):0,0
// FIELD:corp_address2_line3:TYPE(STRING70):0,0
// FIELD:corp_address2_effective_date:TYPE(STRING8):0,0
// FIELD:corp_phone_number:TYPE(STRING30):0,0
// FIELD:corp_phone_number_type_cd:TYPE(STRING8):0,0
// FIELD:corp_phone_number_type_desc:TYPE(STRING60):0,0
// FIELD:corp_fax_nbr:TYPE(STRING15):0,0
// FIELD:corp_email_address:TYPE(STRING30):0,0
// FIELD:corp_web_address:TYPE(STRING30):0,0
// FIELD:corp_filing_reference_nbr:TYPE(STRING30):0,0
// FIELD:corp_vendor_county:TYPE(STRING3):0,0
// FIELD:corp_vendor_subcode:TYPE(STRING5):0,0
// FIELD:corp_ra_no_comp:TYPE(STRING5):0,0
// FIELD:corp_ra_no_comp_igs:TYPE(STRING5):0,0
// FIELD:corp_ra_addl_info:TYPE(STRING250):0,0
// FIELD:corp_ra_address_type_cd:TYPE(STRING8):0,0
// FIELD:corp_ra_address_type_desc:TYPE(STRING60):0,0
// FIELD:corp_ra_address_line1:TYPE(STRING70):0,0
// FIELD:corp_ra_address_line2:TYPE(STRING70):0,0
// FIELD:corp_ra_address_line3:TYPE(STRING70):0,0
// FIELD:corp_ra_phone_number:TYPE(STRING30):0,0
// FIELD:corp_ra_phone_number_type_cd:TYPE(STRING8):0,0
// FIELD:corp_ra_phone_number_type_desc:TYPE(STRING60):0,0
// FIELD:corp_ra_fax_nbr:TYPE(STRING15):0,0
// FIELD:corp_ra_email_address:TYPE(STRING30):0,0
// FIELD:corp_ra_web_address:TYPE(STRING30):0,0
// FIELD:corp_prep_addr1_line1:TYPE(STRING100):0,0
// FIELD:corp_prep_addr1_last_line:TYPE(STRING50):0,0
// FIELD:corp_prep_addr2_line1:TYPE(STRING100):0,0
// FIELD:corp_prep_addr2_last_line:TYPE(STRING50):0,0
// FIELD:ra_prep_addr_line1:TYPE(STRING100):0,0
// FIELD:ra_prep_addr_last_line:TYPE(STRING50):0,0
// FIELD:cont_filing_reference_nbr:TYPE(STRING30):0,0
// FIELD:cont_filing_date:TYPE(STRING8):0,0
// FIELD:cont_filing_cd:TYPE(STRING8):0,0
// FIELD:cont_filing_desc:TYPE(STRING60):0,0
// FIELD:cont_type_cd:TYPE(STRING8):0,0
// FIELD:cont_type_desc:TYPE(STRING60):0,0
// FIELD:cont_full_name:TYPE(STRING100):0,0
// FIELD:cont_fname:TYPE(STRING20):0,0
// FIELD:cont_mname:TYPE(STRING20):0,0
// FIELD:cont_lname:TYPE(STRING20):0,0
// FIELD:cont_title1_desc:TYPE(STRING60):0,0
// FIELD:cont_title2_desc:TYPE(STRING60):0,0
// FIELD:cont_title3_desc:TYPE(STRING60):0,0
// FIELD:cont_title4_desc:TYPE(STRING60):0,0
// FIELD:cont_title5_desc:TYPE(STRING60):0,0
// FIELD:cont_fein:TYPE(STRING10):0,0
// FIELD:cont_ssn:TYPE(STRING9):0,0
// FIELD:cont_dob:TYPE(STRING8):0,0
// FIELD:cont_status_cd:TYPE(STRING8):0,0
// FIELD:cont_status_desc:TYPE(STRING60):0,0
// FIELD:cont_effective_date:TYPE(STRING8):0,0
// FIELD:cont_effective_cd:TYPE(STRING1):0,0
// FIELD:cont_effective_desc:TYPE(STRING60):0,0
// FIELD:cont_addl_info:TYPE(STRING350):0,0
// FIELD:cont_address_type_cd:TYPE(STRING8):0,0
// FIELD:cont_address_type_desc:TYPE(STRING60):0,0
// FIELD:cont_address_line1:TYPE(STRING70):0,0
// FIELD:cont_address_line2:TYPE(STRING70):0,0
// FIELD:cont_address_line3:TYPE(STRING70):0,0
// FIELD:cont_address_effective_date:TYPE(STRING8):0,0
// FIELD:cont_address_county:TYPE(STRING30):0,0
// FIELD:cont_phone_number:TYPE(STRING30):0,0
// FIELD:cont_phone_number_type_cd:TYPE(STRING8):0,0
// FIELD:cont_phone_number_type_desc:TYPE(STRING60):0,0
// FIELD:cont_fax_nbr:TYPE(STRING15):0,0
// FIELD:cont_email_address:TYPE(STRING30):0,0
// FIELD:cont_web_address:TYPE(STRING30):0,0
// FIELD:corp_acres:TYPE(STRING50):0,0
// FIELD:corp_action:TYPE(STRING10):0,0
// FIELD:corp_action_date:TYPE(STRING10):0,0
// FIELD:corp_action_employment_security_approval_date:TYPE(STRING8):0,0
// FIELD:corp_action_pending_code:TYPE(STRING1):0,0
// FIELD:corp_action_pending_description:TYPE(STRING50):0,0
// FIELD:corp_action_statement_of_intent_date:TYPE(STRING8):0,0
// FIELD:corp_action_tax_dept_approval_date:TYPE(STRING8):0,0
// FIELD:corp_acts2:TYPE(STRING50):0,0
// FIELD:corp_acts3:TYPE(STRING50):0,0
// FIELD:corp_additional_principals:TYPE(STRING1):0,0
// FIELD:corp_address_office_type:TYPE(STRING50):0,0
// FIELD:corp_agent_commercial:TYPE(STRING1):0,0
// FIELD:corp_agent_country:TYPE(STRING50):0,0
// FIELD:corp_agent_county:TYPE(STRING20):0,0
// FIELD:corp_agent_status_cd:TYPE(STRING5):0,0
// FIELD:corp_agent_id:TYPE(STRING8):0,0
// FIELD:corp_agent_assign_date:TYPE(STRING8):0,0
// FIELD:corp_agriculture_flag:TYPE(STRING1):0,0
// FIELD:corp_authorized_partners:TYPE(STRING):0,0
// FIELD:corp_cmt:TYPE(STRING2):0,0
// FIELD:corp_consent_flag_for_protected_name:TYPE(STRING1):0,0
// FIELD:corp_converted:TYPE(STRING1):0,0
// FIELD:corp_converted_from:TYPE(STRING50):0,0
// FIELD:corp_country_of_formation:TYPE(STRING50):0,0
// FIELD:corp_date_of_organization_meeting:TYPE(STRING8):0,0
// FIELD:corp_delayed_effective_date:TYPE(STRING8):0,0
// FIELD:corp_directors_from_to:TYPE(STRING10):0,0
// FIELD:corp_dissolved_date:TYPE(STRING8):0,0
// FIELD:corp_farm_exemptions:TYPE(STRING30):0,0
// FIELD:corp_farm_qual_date:TYPE(STRING10):0,0
// FIELD:corp_farm_status_cd:TYPE(STRING1):0,0
// FIELD:corp_farm_status_desc:TYPE(STRING100):0,0
// FIELD:corp_farm_status_date:TYPE(STRING10):0,0
// FIELD:corp_fiscal_year_month:TYPE(STRING8):0,0
// FIELD:corp_foreign_fiduciary_capacity_in_state:TYPE(STRING1):0,0
// FIELD:corp_governing_statute:TYPE(STRING20):0,0
// FIELD:corp_hasmembers:TYPE(STRING1):0,0
// FIELD:corp_hasvestedmanagers:TYPE(STRING1):0,0
// FIELD:corp_home_incorporated_county:TYPE(STRING60):0,0
// FIELD:corp_home_state_name:TYPE(STRING30):0,0
// FIELD:corp_is_professional:TYPE(STRING1):0,0
// FIELD:corp_isnonprofitirsapproved:TYPE(STRING1):0,0
// FIELD:corp_last_renewal_date:TYPE(STRING8):0,0
// FIELD:corp_last_renewal_year:TYPE(STRING4):0,0
// FIELD:corp_license_type:TYPE(STRING1):0,0
// FIELD:corp_llc_managed_cd:TYPE(STRING1):0,0
// FIELD:corp_llc_managed_desc:TYPE(STRING100):0,0
// FIELD:corp_management_description:TYPE(STRING50):0,0
// FIELD:corp_management_type:TYPE(STRING1):0,0
// FIELD:corp_manager_managed:TYPE(STRING1):0,0
// FIELD:corp_merged_corporation_id:TYPE(STRING32):0,0
// FIELD:corp_merged_fein:TYPE(STRING9):0,0
// FIELD:corp_merger_allowed_flag:TYPE(STRING1):0,0
// FIELD:corp_merger_description:TYPE(STRING250):0,0
// FIELD:corp_merger_effective_date:TYPE(STRING8):0,0
// FIELD:corp_merger_id:TYPE(STRING32):0,0
// FIELD:corp_merger_indicator:TYPE(STRING1):0,0
// FIELD:corp_merger_name:TYPE(STRING100):0,0
// FIELD:corp_merger_type_converted_to_code:TYPE(STRING4):0,0
// FIELD:corp_merger_type_converted_to_description:TYPE(STRING100):0,0
// FIELD:corp_naics_description:TYPE(STRING60):0,0
// FIELD:corp_name_effective_date:TYPE(STRING8):0,0
// FIELD:corp_name_reservation_date:TYPE(STRING8):0,0
// FIELD:corp_name_reservation_expiration_date:TYPE(STRING8):0,0
// FIELD:corp_name_reservation_number:TYPE(STRING32):0,0
// FIELD:corp_name_reservation_type:TYPE(STRING100):0,0
// FIELD:corp_name_status_cd:TYPE(STRING5):0,0
// FIELD:corp_name_status_date:TYPE(STRING8):0,0
// FIELD:corp_name_status_description:TYPE(STRING50):0,0
// FIELD:corp_nonprofitirsapprovedpurpose:TYPE(STRING):0,0
// FIELD:corp_nonprofitsolicitdonations:TYPE(STRING1):0,0
// FIELD:corp_number_of_amendments:TYPE(UNSIGNED6):0,0
// FIELD:corp_number_of_initial_llc_members:TYPE(STRING):0,0
// FIELD:corp_number_of_partners:TYPE(UNSIGNED6):0,0
// FIELD:corp_operatingagreement:TYPE(STRING1):0,0
// FIELD:corp_opt_in_llc_act_description:TYPE(STRING50):0,0
// FIELD:corp_opt_in_llc_act_ind:TYPE(STRING1):0,0
// FIELD:corp_organizational_comments:TYPE(STRING250):0,0
// FIELD:corp_original_business_type:TYPE(STRING2):0,0
// FIELD:corp_partner_contributions_total:TYPE(INTEGER8):0,0
// FIELD:corp_partner_terms:TYPE(STRING):0,0
// FIELD:corp_percentage_voters_required_to_approve_amendments:TYPE(STRING):0,0
// FIELD:corp_profession:TYPE(STRING250):0,0
// FIELD:corp_province:TYPE(STRING20):0,0
// FIELD:corp_public_mutual_corporation:TYPE(STRING10):0,0
// FIELD:corp_purpose:TYPE(STRING250):0,0
// FIELD:corp_ra_required_flag:TYPE(STRING1):0,0
// FIELD:corp_registered_counties:TYPE(STRING):0,0
// FIELD:corp_regulated_ind:TYPE(STRING1):0,0
// FIELD:corp_standing_other:TYPE(STRING50):0,0
// FIELD:corp_survivor_corporation_id:TYPE(STRING32):0,0
// FIELD:corp_tax_base:TYPE(STRING1):0,0
// FIELD:corp_tax_standing:TYPE(STRING50):0,0
// FIELD:corp_termination_code:TYPE(STRING2):0,0
// FIELD:corp_termination_description:TYPE(STRING100):0,0
// FIELD:corp_termination_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_classification_number:TYPE(STRING10):0,0
// FIELD:corp_trademark_first_use_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_first_use_date_in_state:TYPE(STRING8):0,0
// FIELD:corp_trademark_business_mark_type:TYPE(STRING20):0,0
// FIELD:corp_trademark_cancelled_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_class_description1:TYPE(STRING250):0,0
// FIELD:corp_trademark_class_description2:TYPE(STRING250):0,0
// FIELD:corp_trademark_class_description3:TYPE(STRING250):0,0
// FIELD:corp_trademark_class_description4:TYPE(STRING250):0,0
// FIELD:corp_trademark_class_description5:TYPE(STRING250):0,0
// FIELD:corp_trademark_class_description6:TYPE(STRING250):0,0
// FIELD:corp_trademark_disclaimer1:TYPE(STRING50):0,0
// FIELD:corp_trademark_disclaimer2:TYPE(STRING50):0,0
// FIELD:corp_trademark_expiration_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_filing_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_keywords:TYPE(STRING250):0,0
// FIELD:corp_trademark_logo:TYPE(STRING250):0,0
// FIELD:corp_trademark_name_expiration_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_number:TYPE(STRING12):0,0
// FIELD:corp_trademark_renewal_date:TYPE(STRING8):0,0
// FIELD:corp_trademark_status:TYPE(STRING1):0,0
// FIELD:corp_trademark_used_1:TYPE(STRING50):0,0
// FIELD:corp_trademark_used_2:TYPE(STRING50):0,0
// FIELD:corp_trademark_used_3:TYPE(STRING50):0,0
// FIELD:cont_owner_percentage:TYPE(UNSIGNED2):0,0
// FIELD:cont_country:TYPE(STRING50):0,0
// FIELD:cont_country_mailing:TYPE(STRING50):0,0
// FIELD:cont_nondislosure:TYPE(STRING1):0,0
// FIELD:cont_prep_addr_line1:TYPE(STRING100):0,0
// FIELD:cont_prep_addr_last_line:TYPE(STRING50):0,0
// FIELD:corp_ra_fname:TYPE(STRING20):0,0
// FIELD:corp_ra_mname:TYPE(STRING20):0,0
// FIELD:corp_ra_lname:TYPE(STRING20):0,0
// FIELD:corp_ra_title_cd:TYPE(STRING8):0,0
// FIELD:corp_ra_title_desc:TYPE(STRING60):0,0
// FIELD:corp_ra_fein:TYPE(STRING10):0,0
// FIELD:corp_ra_ssn:TYPE(STRING9):0,0
// FIELD:corp_ra_dob:TYPE(STRING8):0,0
// FIELD:corp_public_or_private_ind:TYPE(STRING1):0,0
// FIELD:corp_sic_code:TYPE(STRING8):0,0
// FIELD:corp_naic_code:TYPE(STRING8):0,0
// FIELD:corp_orig_bus_type_cd:TYPE(STRING8):0,0
// FIELD:corp_orig_bus_type_desc:TYPE(STRING350):0,0
// FIELD:corp_entity_desc:TYPE(STRING350):0,0
// FIELD:corp_certificate_nbr:TYPE(STRING32):0,0
// FIELD:corp_internal_nbr:TYPE(STRING32):0,0
// FIELD:corp_previous_nbr:TYPE(STRING32):0,0
// FIELD:corp_microfilm_nbr:TYPE(STRING32):0,0
// FIELD:corp_amendments_filed:TYPE(STRING5):0,0
// FIELD:corp_acts:TYPE(STRING50):0,0
// FIELD:corp_partnership_ind:TYPE(STRING1):0,0
// FIELD:corp_mfg_ind:TYPE(STRING1):0,0
// FIELD:corp_addl_info:TYPE(STRING250):0,0
// FIELD:corp_taxes:TYPE(STRING10):0,0
// FIELD:corp_franchise_taxes:TYPE(STRING8):0,0
// FIELD:corp_tax_program_cd:TYPE(STRING8):0,0
// FIELD:corp_tax_program_desc:TYPE(STRING30):0,0
 
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
 
Total available specificity:0
Search Threshold set at -4
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
 
