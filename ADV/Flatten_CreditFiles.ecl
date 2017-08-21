IMPORT ADV;

EXPORT Flatten_CreditFiles(sampleFile) := FUNCTIONMACRO

masteraccountcontractsegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string50 master_account_or_contract_number_identifier;
END;



addresssegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string100 address_line_1;
   string100 address_line_2;
   string50 city;
   string2 state;
   string6 zip_code_or_ca_postal_code;
   string4 postal_code;
   string2 country_code;
   string1 primary_address_indicator;
   string3 address_classification;
  END;


accountmodificationhistorysegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string30 previous_member_id;
   string50 previous_account_number;
   string3 previous_account_type;
   string3 type_of_conversion_maintenance;
   string8 date_account_converted;
  END;


phonenumbersegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string3 area_code;
   string7 phone_number;
   string10 phone_extension;
   string1 primary_phone_indicator;
   string3 published_unlisted_indicator;
   string3 phone_type;
  END;


taxid_ssnsegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string9 federal_taxid_ssn;
   string3 federal_taxid_ssn_identifier;
  END;


memberspecificsegment := RECORD
    string2 segment_identifier;
    string12 file_sequence_number;
    string12 parent_sequence_number;
    string12 account_base_number;
    string20 name_of_value;
    string250 value_string;
    string1 privacy_indicator;
   END;


individualownerlayout := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string50 original_fname;
   string50 original_mname;
   string50 original_lname;
   string5 original_suffix;
   string100 e_mail_address;
   string3 guarantor_owner_indicator;
   string3 relationship_to_business_indicator;
   string150 business_title;
   string3 percent_of_liability;
   string3 percent_of_ownership;
   DATASET(addresssegment) address{maxcount(100)};
   DATASET(phonenumbersegment) phone{maxcount(100)};
   DATASET(taxid_ssnsegment) taxid{maxcount(100)};
   DATASET(memberspecificsegment) memberspecific{maxcount(100)};
  END;


businessindustryidentifiersegment := RECORD
    string2 segment_identifier;
    string12 file_sequence_number;
    string12 parent_sequence_number;
    string12 account_base_number;
    string3 classification_code_type;
    string25 classification_code;
    string1 primary_industry_code_indicator;
    string1 privacy_indicator;
   END;


businessownerlayout := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string250 business_name;
   string250 web_address;
   string3 guarantor_owner_indicator;
   string3 relationship_to_business_indicator;
   string3 percent_of_liability;
   string3 percent_of_ownership_if_owner_principal;
   DATASET(addresssegment) address{maxcount(100)};
   DATASET(phonenumbersegment) phone{maxcount(100)};
   DATASET(businessindustryidentifiersegment) businessindustryclassification{maxcount(25)};
   DATASET(taxid_ssnsegment) taxid{maxcount(100)};
   DATASET(memberspecificsegment) memberspecific{maxcount(100)};
  END;


collateralsegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string12 parent_sequence_number;
   string12 account_base_number;
   string1 collateral_indicator;
   string3 type_of_collateral_secured_for_this_account;
   string250 collateral_description;
   string50 ucc_filing_number;
   string3 ucc_filing_type;
   string8 ucc_filing_date;
   string8 ucc_filing_expiration_date;
   string100 ucc_filing_jurisdiction;
   string250 ucc_filing_description;
  END;


headersegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string30 sbfe_contributor_number;
   string8 extracted_date;
   string8 cycle_end_date;
   string2 cycle_number;
   string3 cycle_length;
   string3 file_correction_indicator;
   string4 overall_file_format_version;
   string2 major_aa_segment_version;
   string2 minor_aa_segment_version;
   string2 major_ab_segment_version;
   string2 minor_ab_segment_version;
   string2 major_ma_segment_version;
   string2 minor_ma_segment_version;
   string2 major_ad_segment_version;
   string2 minor_ad_segment_version;
   string2 major_pn_segment_version;
   string2 minor_pn_segment_version;
   string2 major_ti_segment_version;
   string2 minor_ti_segment_version;
   string2 major_is_segment_version;
   string2 minor_is_segment_version;
   string2 major_bs_segment_version;
   string2 minor_bs_segment_version;
   string2 major_bi_segment_version;
   string2 minor_bi_segment_version;
   string2 major_cl_segment_version;
   string2 minor_cl_segment_version;
   string2 major_ms_segment_version;
   string2 minor_ms_segment_version;
   string2 major_ah_segment_version;
   string2 minor_ah_segment_version;
   string2 major_zz_segment_version;
   string2 minor_zz_segment_version;
  END;


fileheadersegment := RECORD
   string2 segment_identifier;
   string12 file_sequence_number;
   string3 test_or_production_indicator;
   string3 file_type_indicator;
  END;

credit_file_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  DATASET(masteraccountcontractsegment) masteraccount{maxcount(1)};
  DATASET(addresssegment) address{maxcount(100)};
  DATASET(accountmodificationhistorysegment) history{maxcount(25)};
  DATASET(phonenumbersegment) phone{maxcount(100)};
  DATASET(taxid_ssnsegment) taxid{maxcount(100)};
  DATASET(individualownerlayout) individualowner{maxcount(105)};
  DATASET(businessownerlayout) businessowner{maxcount(100)};
  DATASET(businessindustryidentifiersegment) businessindustryclassification{maxcount(25)};
  DATASET(collateralsegment) collateral{maxcount(100)};
  DATASET(memberspecificsegment) memberspecific{maxcount(100)};
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;
 








masteraccountcontractsegmentdata := ADV.Generate_Normalized_Data(sampleFile, masteraccountcontractsegment,masteraccount);
addresssegmentdata := ADV.Generate_Normalized_Data(sampleFile, addresssegment,address);
accountmodificationhistorysegmentdata := ADV.Generate_Normalized_Data(sampleFile, accountmodificationhistorysegment,history);
phonenumbersegmentdata := ADV.Generate_Normalized_Data(sampleFile, phonenumbersegment,phone);
taxid_ssnsegmentdata := ADV.Generate_Normalized_Data(sampleFile, taxid_ssnsegment,taxid);
individualownerlayoutdata := ADV.Generate_Normalized_Data(sampleFile, individualownerlayout,individualowner);
businessownerlayoutdata := ADV.Generate_Normalized_Data(sampleFile, businessownerlayout,businessowner);
businessindustryidentifiersegmentdata := ADV.Generate_Normalized_Data(sampleFile, businessindustryidentifiersegment,businessindustryclassification);
collateralsegmentdata := ADV.Generate_Normalized_Data(sampleFile, collateralsegment,collateral);
memberspecificsegmentdata := ADV.Generate_Normalized_Data(sampleFile, memberspecificsegment,memberspecific);

individualowneraddressdata := ADV.Generate_Normalized_Data(individualownerlayoutdata, addresssegment,address);
individualownerphonedata := ADV.Generate_Normalized_Data(individualownerlayoutdata, phonenumbersegment,phone);
individualownertaxiddata := ADV.Generate_Normalized_Data(individualownerlayoutdata, taxid_ssnsegment,taxid);
individualownermemberspecificdata := ADV.Generate_Normalized_Data(individualownerlayoutdata, memberspecificsegment,memberspecific);

businessowneraddressdata := ADV.Generate_Normalized_Data(businessownerlayoutdata, addresssegment,address);
businessownerphonedata := ADV.Generate_Normalized_Data(businessownerlayoutdata, phonenumbersegment,phone);
businessownerbusinessindustryclassificationdata := ADV.Generate_Normalized_Data(businessownerlayoutdata, businessindustryidentifiersegment,businessindustryclassification);
businessownertaxiddata := ADV.Generate_Normalized_Data(businessownerlayoutdata, taxid_ssnsegment,taxid);
businessownermemberspecificdata := ADV.Generate_Normalized_Data(businessownerlayoutdata, memberspecificsegment,memberspecific);

owner_address := RECORD

   string2 individualowner__segment_identifier;
   string12 individualowner__file_sequence_number;
   string12 individualowner__parent_sequence_number;
   string12 individualowner__account_base_number;
   string50 individualowner__original_fname;
   string50 individualowner__original_mname;
   string50 individualowner__original_lname;
   string5 individualowner__original_suffix;
   string100 individualowner__e_mail_address;
   string3 individualowner__guarantor_owner_indicator;
   string3 individualowner__relationship_to_business_indicator;
   string150 individualowner__business_title;
   string3 individualowner__percent_of_liability;
   string3 individualowner__percent_of_ownership;
  
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;

END;




owner_address jointrans(individualownerlayout L,addresssegment R ):= TRANSFORM
 
SELF.individualowner__address__segment_identifier := R.segment_identifier;
SELF.individualowner__address__file_sequence_number := R.file_sequence_number;
SELF.individualowner__address__parent_sequence_number := R.parent_sequence_number;
SELF.individualowner__address__address_line_1 := R.address_line_1;
SELF.individualowner__address__address_line_2 :=  R.address_line_2;
SELF.individualowner__address__city :=  R.city;
SELF.individualowner__address__state :=  R.state;
SELF.individualowner__address__zip_code_or_ca_postal_code :=  R.zip_code_or_ca_postal_code;
SELF.individualowner__address__postal_code := R.postal_code;
SELF.individualowner__address__country_code := R.country_code;
SELF.individualowner__address__primary_address_indicator :=  R.primary_address_indicator;
SELF.individualowner__address__address_classification :=  R.address_classification;

   SELF.individualowner__segment_identifier := L.segment_identifier;
   SELF.individualowner__file_sequence_number := L.file_sequence_number;
   SELF.individualowner__parent_sequence_number := L.parent_sequence_number;
   SELF.individualowner__account_base_number := L.account_base_number;
   SELF.individualowner__original_fname := L.original_fname;
   SELF.individualowner__original_mname  := L.original_mname;
   SELF.individualowner__original_lname  := L.original_lname;
   SELF.individualowner__original_suffix  := L.original_suffix;
   SELF.individualowner__e_mail_address  := L.e_mail_address;
   SELF.individualowner__guarantor_owner_indicator   := L.guarantor_owner_indicator;
   SELF.individualowner__relationship_to_business_indicator  := L.relationship_to_business_indicator;
   SELF.individualowner__business_title  := L.business_title;
   SELF.individualowner__percent_of_liability  := L.percent_of_liability;
   SELF.individualowner__percent_of_ownership := L.percent_of_ownership;
   
END;

individualowner_address := JOIN(individualownerlayoutdata,individualowneraddressdata,trim(LEFT.account_base_number,left,right) = trim(RIGHT.account_base_number,left,right) ,jointrans(LEFT,RIGHT), LEFT OUTER, LOCAL);

 owner_address_phone := RECORD

   string2 individualowner__segment_identifier;
   string12 individualowner__file_sequence_number;
   string12 individualowner__parent_sequence_number;
   string12 individualowner__account_base_number;
   string50 individualowner__original_fname;
   string50 individualowner__original_mname;
   string50 individualowner__original_lname;
   string5 individualowner__original_suffix;
   string100 individualowner__e_mail_address;
   string3 individualowner__guarantor_owner_indicator;
   string3 individualowner__relationship_to_business_indicator;
   string150 individualowner__business_title;
   string3 individualowner__percent_of_liability;
   string3 individualowner__percent_of_ownership;
  
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;

    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
    
END;


owner_address_phone jointrans1(owner_address L,phonenumbersegment R ):= TRANSFORM
 
 SELF.individualowner__phone__segment_identifier :=   R.segment_identifier;
 SELF.individualowner__phone__file_sequence_number := R.file_sequence_number;
 SELF.individualowner__phone__parent_sequence_number := R.parent_sequence_number;
 SELF.individualowner__phone__area_code := R.area_code;
 SELF.individualowner__phone__phone_number := R.phone_number;
 SELF.individualowner__phone__phone_extension := R.phone_extension;
 SELF.individualowner__phone__primary_phone_indicator := R.primary_phone_indicator;
 SELF.individualowner__phone__published_unlisted_indicator := R.published_unlisted_indicator;
 SELF.individualowner__phone__phone_type := R.phone_type;
 SELF := L;
   
END;

individualowner_address_phone := JOIN(individualowner_address,individualownerphonedata,LEFT.individualowner__account_base_number = RIGHT.account_base_number ,jointrans1(LEFT,RIGHT), LEFT OUTER, LOCAL);

owner_address_phone_tax := RECORD
   string2 individualowner__segment_identifier;
   string12 individualowner__file_sequence_number;
   string12 individualowner__parent_sequence_number;
   string12 individualowner__account_base_number;
   string50 individualowner__original_fname;
   string50 individualowner__original_mname;
   string50 individualowner__original_lname;
   string5 individualowner__original_suffix;
   string100 individualowner__e_mail_address;
   string3 individualowner__guarantor_owner_indicator;
   string3 individualowner__relationship_to_business_indicator;
   string150 individualowner__business_title;
   string3 individualowner__percent_of_liability;
   string3 individualowner__percent_of_ownership;
  
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;

    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;

  string2 individualowner__taxid__segment_identifier;
  string12 individualowner__taxid__file_sequence_number;
  string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;   
    
    END;
 
 
 owner_address_phone_tax jointrans2(individualowner_address_phone L,taxid_ssnsegment R ):= TRANSFORM
 

  SELF.individualowner__taxid__segment_identifier := R.segment_identifier;
  SELF.individualowner__taxid__file_sequence_number := R.file_sequence_number;
  SELF.individualowner__taxid__parent_sequence_number := R.parent_sequence_number;
  SELF.individualowner__taxid__federal_taxid_ssn := R.federal_taxid_ssn;
  SELF.individualowner__taxid__federal_taxid_ssn_identifier := R.federal_taxid_ssn_identifier;
  SELF := L;
 
END;

individualowner_address_phone_tax := JOIN(individualowner_address_phone,individualownertaxiddata,LEFT.individualowner__account_base_number = RIGHT.account_base_number ,jointrans2(LEFT,RIGHT), LEFT OUTER, LOCAL);


owner_all := RECORD
   string2 individualowner__segment_identifier;
   string12 individualowner__file_sequence_number;
   string12 individualowner__parent_sequence_number;
   string12 individualowner__account_base_number;
   string50 individualowner__original_fname;
   string50 individualowner__original_mname;
   string50 individualowner__original_lname;
   string5 individualowner__original_suffix;
   string100 individualowner__e_mail_address;
   string3 individualowner__guarantor_owner_indicator;
   string3 individualowner__relationship_to_business_indicator;
   string150 individualowner__business_title;
   string3 individualowner__percent_of_liability;
   string3 individualowner__percent_of_ownership;
  
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;

    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;

  string2 individualowner__taxid__segment_identifier;
  string12 individualowner__taxid__file_sequence_number;
  string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;   

   string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
    string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;   
    
    END;
 
  owner_all jointrans3(individualowner_address_phone_tax L,memberspecificsegment R ):= TRANSFORM
 

  SELF.individualowner__memberspecific__segment_identifier := R.segment_identifier;
  SELF.individualowner__memberspecific__file_sequence_number := R.file_sequence_number;
  SELF.individualowner__memberspecific__parent_sequence_number := R.parent_sequence_number;
  SELF.individualowner__memberspecific__name_of_value := R.name_of_value;
  SELF.individualowner__memberspecific__value_string := R.value_string;
  SELF.individualowner__memberspecific__privacy_indicator := R.privacy_indicator;
  SELF := L;
 
END;

individualowner_all := JOIN(individualowner_address_phone_tax,individualownermemberspecificdata,LEFT.individualowner__account_base_number = RIGHT.account_base_number ,jointrans3(LEFT,RIGHT), LEFT OUTER, LOCAL);



businessowner_address_layout := RECORD

    string2 businessowner__segment_identifier;
   string12 businessowner__file_sequence_number;
   string12 businessowner__parent_sequence_number;
   string12 businessowner__account_base_number;
   string250 businessowner__business_name;
   string250 businessowner__web_address;
   string3 businessowner__guarantor_owner_indicator;
   string3 businessowner__relationship_to_business_indicator;
   string3 businessowner__percent_of_liability;
   string3 businessowner__percent_of_ownership_if_owner_principal;
   
   string2 businessowner__address__segment_identifier;
  string12 businessowner__address__file_sequence_number;
  string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;

END;

businessowner_address_layout jointrans5(businessownerlayout L,addresssegment R ):= TRANSFORM
 
SELF.businessowner__address__segment_identifier := R.segment_identifier;
SELF.businessowner__address__file_sequence_number := R.file_sequence_number;
SELF.businessowner__address__parent_sequence_number := R.parent_sequence_number;
SELF.businessowner__address__address_line_1 := R.address_line_1;
SELF.businessowner__address__address_line_2 :=  R.address_line_2;
SELF.businessowner__address__city :=  R.city;
SELF.businessowner__address__state :=  R.state;
SELF.businessowner__address__zip_code_or_ca_postal_code :=  R.zip_code_or_ca_postal_code;
SELF.businessowner__address__postal_code := R.postal_code;
SELF.businessowner__address__country_code := R.country_code;
SELF.businessowner__address__primary_address_indicator :=  R.primary_address_indicator;
SELF.businessowner__address__address_classification :=  R.address_classification;

   SELF.businessowner__segment_identifier := L.segment_identifier;
   SELF.businessowner__file_sequence_number := L.file_sequence_number;
   SELF.businessowner__parent_sequence_number := L.parent_sequence_number;
   SELF.businessowner__account_base_number := L.account_base_number;
   SELF.businessowner__business_name := L.business_name;
   SELF.businessowner__web_address  := L.web_address;
   SELF.businessowner__guarantor_owner_indicator  := L.guarantor_owner_indicator;
   SELF.businessowner__relationship_to_business_indicator  := L.relationship_to_business_indicator;
   SELF.businessowner__percent_of_liability  := L.percent_of_liability;
   SELF.businessowner__percent_of_ownership_if_owner_principal  := L.percent_of_ownership_if_owner_principal;

END;

businessowner_address := JOIN(businessownerlayoutdata,businessowneraddressdata,LEFT.account_base_number = RIGHT.account_base_number ,jointrans5(LEFT,RIGHT), LEFT OUTER, LOCAL);


businessowner_address_phone_layout := RECORD

    string2 businessowner__segment_identifier;
   string12 businessowner__file_sequence_number;
   string12 businessowner__parent_sequence_number;
   string12 businessowner__account_base_number;
   string250 businessowner__business_name;
   string250 businessowner__web_address;
   string3 businessowner__guarantor_owner_indicator;
   string3 businessowner__relationship_to_business_indicator;
   string3 businessowner__percent_of_liability;
   string3 businessowner__percent_of_ownership_if_owner_principal;
   
   string2 businessowner__address__segment_identifier;
  string12 businessowner__address__file_sequence_number;
  string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;


     string2 businessowner__phone__segment_identifier;
  string12 businessowner__phone__file_sequence_number;
  string12 businessowner__phone__parent_sequence_number;
     string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
END;

businessowner_address_phone_layout jointrans6(businessowner_address_layout L,phonenumbersegment R ):= TRANSFORM
 
 SELF.businessowner__phone__segment_identifier :=   R.segment_identifier;
 SELF.businessowner__phone__file_sequence_number := R.file_sequence_number;
 SELF.businessowner__phone__parent_sequence_number := R.parent_sequence_number;
 SELF.businessowner__phone__area_code := R.area_code;
 SELF.businessowner__phone__phone_number := R.phone_number;
 SELF.businessowner__phone__phone_extension := R.phone_extension;
 SELF.businessowner__phone__primary_phone_indicator := R.primary_phone_indicator;
 SELF.businessowner__phone__published_unlisted_indicator := R.published_unlisted_indicator;
 SELF.businessowner__phone__phone_type := R.phone_type;
 SELF := L;
   
END;

businessowner_address_phone := JOIN(businessowner_address,businessownerphonedata,LEFT.businessowner__account_base_number = RIGHT.account_base_number ,jointrans6(LEFT,RIGHT), LEFT OUTER, LOCAL);


businessowner_address_phone_bic_layout := RECORD

    string2 businessowner__segment_identifier;
   string12 businessowner__file_sequence_number;
   string12 businessowner__parent_sequence_number;
   string12 businessowner__account_base_number;
   string250 businessowner__business_name;
   string250 businessowner__web_address;
   string3 businessowner__guarantor_owner_indicator;
   string3 businessowner__relationship_to_business_indicator;
   string3 businessowner__percent_of_liability;
   string3 businessowner__percent_of_ownership_if_owner_principal;
   
   string2 businessowner__address__segment_identifier;
  string12 businessowner__address__file_sequence_number;
  string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;


     string2 businessowner__phone__segment_identifier;
  string12 businessowner__phone__file_sequence_number;
  string12 businessowner__phone__parent_sequence_number;
     string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
       string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
END;

businessowner_address_phone_bic_layout jointrans7(businessowner_address_phone_layout L,businessindustryidentifiersegment R ):= TRANSFORM
 
 SELF.businessowner__businessindustryclassification__segment_identifier :=   R.segment_identifier;
 SELF.businessowner__businessindustryclassification__file_sequence_number := R.file_sequence_number;
 SELF.businessowner__businessindustryclassification__parent_sequence_number := R.parent_sequence_number;
 SELF.businessowner__businessindustryclassification__classification_code_type := R.classification_code_type;
 SELF.businessowner__businessindustryclassification__classification_code := R.classification_code;
 SELF.businessowner__businessindustryclassification__primary_industry_code_indicator := R.primary_industry_code_indicator;
 SELF.businessowner__businessindustryclassification__privacy_indicator := R.privacy_indicator;
 SELF := L;
   
END;


businessowner_address_phone_bic := JOIN(businessowner_address_phone,businessownerbusinessindustryclassificationdata,LEFT.businessowner__account_base_number = RIGHT.account_base_number ,jointrans7(LEFT,RIGHT), LEFT OUTER, LOCAL);



businessowner_address_phone_bic_tax_layout := RECORD

    string2 businessowner__segment_identifier;
   string12 businessowner__file_sequence_number;
   string12 businessowner__parent_sequence_number;
   string12 businessowner__account_base_number;
   string250 businessowner__business_name;
   string250 businessowner__web_address;
   string3 businessowner__guarantor_owner_indicator;
   string3 businessowner__relationship_to_business_indicator;
   string3 businessowner__percent_of_liability;
   string3 businessowner__percent_of_ownership_if_owner_principal;
   
   string2 businessowner__address__segment_identifier;
  string12 businessowner__address__file_sequence_number;
  string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;


     string2 businessowner__phone__segment_identifier;
  string12 businessowner__phone__file_sequence_number;
  string12 businessowner__phone__parent_sequence_number;
     string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
       string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
    
       string2 businessowner__taxid__segment_identifier;
  string12 businessowner__taxid__file_sequence_number;
  string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
END;

businessowner_address_phone_bic_tax_layout jointrans8(businessowner_address_phone_bic_layout L,taxid_ssnsegment R ):= TRANSFORM
 
 SELF.businessowner__taxid__segment_identifier :=   R.segment_identifier;
 SELF.businessowner__taxid__file_sequence_number := R.file_sequence_number;
 SELF.businessowner__taxid__parent_sequence_number := R.parent_sequence_number;
 SELF.businessowner__taxid__federal_taxid_ssn := R.federal_taxid_ssn;
 SELF.businessowner__taxid__federal_taxid_ssn_identifier := R.federal_taxid_ssn_identifier;
 SELF := L;
   
END;


businessowner_address_phone_bic_tax := JOIN(businessowner_address_phone_bic,businessownertaxiddata,LEFT.businessowner__account_base_number = RIGHT.account_base_number ,jointrans8(LEFT,RIGHT), LEFT OUTER, LOCAL);

businessowner_all_layout := RECORD

    string2 businessowner__segment_identifier;
   string12 businessowner__file_sequence_number;
   string12 businessowner__parent_sequence_number;
   string12 businessowner__account_base_number;
   string250 businessowner__business_name;
   string250 businessowner__web_address;
   string3 businessowner__guarantor_owner_indicator;
   string3 businessowner__relationship_to_business_indicator;
   string3 businessowner__percent_of_liability;
   string3 businessowner__percent_of_ownership_if_owner_principal;
   
   string2 businessowner__address__segment_identifier;
  string12 businessowner__address__file_sequence_number;
  string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;


     string2 businessowner__phone__segment_identifier;
  string12 businessowner__phone__file_sequence_number;
  string12 businessowner__phone__parent_sequence_number;
     string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
       string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
    
       string2 businessowner__taxid__segment_identifier;
  string12 businessowner__taxid__file_sequence_number;
  string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
    
       string2 businessowner__memberspecific__segment_identifier;
    string12 businessowner__memberspecific__file_sequence_number;
  string12 businessowner__memberspecific__parent_sequence_number;
    string20 businessowner__memberspecific__name_of_value;
     string250 businessowner__memberspecific__value_string;
    string1 businessowner__memberspecific__privacy_indicator; 
END;

businessowner_all_layout jointrans9(businessowner_address_phone_bic_tax_layout L,memberspecificsegment R ):= TRANSFORM
 
 SELF.businessowner__memberspecific__segment_identifier :=   R.segment_identifier;
 SELF.businessowner__memberspecific__file_sequence_number := R.file_sequence_number;
 SELF.businessowner__memberspecific__parent_sequence_number := R.parent_sequence_number;
 SELF.businessowner__memberspecific__name_of_value := R.name_of_value;
 SELF.businessowner__memberspecific__value_string := R.value_string;
 SELF.businessowner__memberspecific__privacy_indicator := R.privacy_indicator;
 SELF := L;
   
END;


businessowner_all := JOIN(businessowner_address_phone_bic_tax,businessownermemberspecificdata,LEFT.businessowner__account_base_number = RIGHT.account_base_number ,jointrans9(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_file_masteraccount_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;



credit_file_masteraccount_layout jointrans10(sampleFile L,masteraccountcontractsegment R ):= TRANSFORM
 
 SELF.masteraccount__segment_identifier :=   R.segment_identifier;
 SELF.masteraccount__file_sequence_number := R.file_sequence_number;
 SELF.masteraccount__parent_sequence_number := R.parent_sequence_number;
 SELF.masteraccount__master_account_or_contract_number_identifier := R.master_account_or_contract_number_identifier;
 SELF := L;
   
END;


credit_masteraccount := JOIN(sampleFile,masteraccountcontractsegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans10(LEFT,RIGHT), LEFT OUTER, LOCAL);


credit_file_ma_adr_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;

credit_file_ma_adr_layout jointrans11(credit_file_masteraccount_layout L,addresssegment R ):= TRANSFORM
 
 SELF.address__segment_identifier :=   R.segment_identifier;
 SELF.address__file_sequence_number := R.file_sequence_number;
 SELF.address__parent_sequence_number := R.parent_sequence_number;
 SELF.address__address_line_1 := R.address_line_1;
  SELF.address__address_line_2 :=   R.address_line_2;
 SELF.address__city := R.city;
 SELF.address__state := R.state;
 SELF.address__zip_code_or_ca_postal_code := R.zip_code_or_ca_postal_code;
  SELF.address__postal_code :=   R.postal_code;
 SELF.address__country_code := R.country_code;
 SELF.address__primary_address_indicator := R.primary_address_indicator;
 SELF.address__address_classification := R.address_classification;
 SELF := L;
   
END;


credit_ma_adr := JOIN(credit_masteraccount,addresssegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans11(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_file_ma_adr_history_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;


credit_file_ma_adr_history_layout jointrans12(credit_file_ma_adr_layout L,accountmodificationhistorysegment R ):= TRANSFORM
 
 SELF.history__segment_identifier :=   R.segment_identifier;
 SELF.history__file_sequence_number := R.file_sequence_number;
 SELF.history__parent_sequence_number := R.parent_sequence_number;
 SELF.history__previous_member_id := R.previous_member_id;
 SELF.history__previous_account_number :=   R.previous_account_number;
 SELF.history__previous_account_type := R.previous_account_type;
 SELF.history__type_of_conversion_maintenance := R.type_of_conversion_maintenance;
 SELF.history__date_account_converted := R.date_account_converted;
 SELF := L;
   
END;


credit_ma_adr_history := JOIN(credit_ma_adr,accountmodificationhistorysegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans12(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_file_ma_adr_history_phone_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
      string2 phone__segment_identifier;
  string12 phone__file_sequence_number;
  string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;
    
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;

credit_file_ma_adr_history_phone_layout jointrans13(credit_file_ma_adr_history_layout L,phonenumbersegment R ):= TRANSFORM
 
 SELF.phone__segment_identifier :=   R.segment_identifier;
 SELF.phone__file_sequence_number := R.file_sequence_number;
 SELF.phone__parent_sequence_number := R.parent_sequence_number;
 SELF.phone__area_code := R.area_code;
 SELF.phone__phone_number :=   R.phone_number;
 SELF.phone__phone_extension := R.phone_extension;
 SELF.phone__primary_phone_indicator := R.primary_phone_indicator;
 SELF.phone__published_unlisted_indicator := R.published_unlisted_indicator;
 SELF.phone__phone_type := R.phone_type;
 SELF := L;
   
END;


credit_ma_adr_history_phone := JOIN(credit_ma_adr_history,phonenumbersegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans13(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_file_ma_adr_history_phone_tax_layout := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
      string2 phone__segment_identifier;
  string12 phone__file_sequence_number;
  string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
  string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
  string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;

credit_file_ma_adr_history_phone_tax_layout jointrans14(credit_file_ma_adr_history_phone_layout L,taxid_ssnsegment R ):= TRANSFORM
 
 SELF.taxid__segment_identifier :=   R.segment_identifier;
 SELF.taxid__file_sequence_number := R.file_sequence_number;
 SELF.taxid__parent_sequence_number := R.parent_sequence_number;
 SELF.taxid__federal_taxid_ssn :=   R.federal_taxid_ssn;
 SELF.taxid__federal_taxid_ssn_identifier := R.federal_taxid_ssn_identifier;
 SELF := L;
   
END;


credit_ma_adr_history_phone_tax := JOIN(credit_ma_adr_history_phone,taxid_ssnsegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans14(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_individual := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
      string2 phone__segment_identifier;
  string12 phone__file_sequence_number;
  string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
  string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
  string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
    
   string2 individualowner__segment_identifier;
   string12 individualowner__file_sequence_number;
   string12 individualowner__parent_sequence_number;
   string12 individualowner__account_base_number;
   string50 individualowner__original_fname;
   string50 individualowner__original_mname;
   string50 individualowner__original_lname;
   string5 individualowner__original_suffix;
   string100 individualowner__e_mail_address;
   string3 individualowner__guarantor_owner_indicator;
   string3 individualowner__relationship_to_business_indicator;
   string150 individualowner__business_title;
   string3 individualowner__percent_of_liability;
   string3 individualowner__percent_of_ownership;
  
    string2 individualowner__address__segment_identifier;
  string12 individualowner__address__file_sequence_number;
  string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;
  
  string2 individualowner__phone__segment_identifier;
  string12 individualowner__phone__file_sequence_number;
  string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
  
  string2 individualowner__taxid__segment_identifier;
  string12 individualowner__taxid__file_sequence_number;
  string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;
  
   string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
  string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;

    
    
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;


credit_individual jointrans15(credit_file_ma_adr_history_phone_tax_layout L,owner_all R ):= TRANSFORM
 
 SELF.individualowner__segment_identifier :=   R.individualowner__segment_identifier;
 SELF.individualowner__file_sequence_number := R.individualowner__file_sequence_number;
 SELF.individualowner__parent_sequence_number := R.individualowner__parent_sequence_number;
 SELF.individualowner__account_base_number :=   R.individualowner__account_base_number;
 SELF.individualowner__original_fname := R.individualowner__original_fname;
 SELF.individualowner__original_mname :=   R.individualowner__original_mname;
 SELF.individualowner__original_suffix := R.individualowner__original_suffix;
 SELF.individualowner__original_lname := R.individualowner__original_lname;
 SELF.individualowner__e_mail_address := R.individualowner__e_mail_address;
 SELF.individualowner__guarantor_owner_indicator :=   R.individualowner__guarantor_owner_indicator;
 SELF.individualowner__relationship_to_business_indicator := R.individualowner__relationship_to_business_indicator;
 SELF.individualowner__business_title :=   R.individualowner__business_title;
 SELF.individualowner__percent_of_liability := R.individualowner__percent_of_liability;
 SELF.individualowner__percent_of_ownership := R.individualowner__percent_of_ownership;
 SELF.individualowner__address__segment_identifier :=   R.individualowner__address__segment_identifier;
 SELF.individualowner__address__file_sequence_number := R.individualowner__address__file_sequence_number;
 SELF.individualowner__address__parent_sequence_number :=   R.individualowner__address__parent_sequence_number;
 SELF.individualowner__address__address_line_1 := R.individualowner__address__address_line_1;
 SELF.individualowner__address__address_line_2 := R.individualowner__address__address_line_2;
 SELF.individualowner__address__city :=   R.individualowner__address__city;
 SELF.individualowner__address__state := R.individualowner__address__state;
 SELF.individualowner__address__zip_code_or_ca_postal_code :=   R.individualowner__address__zip_code_or_ca_postal_code;
 SELF.individualowner__address__postal_code := R.individualowner__address__postal_code;
 SELF.individualowner__address__country_code :=   R.individualowner__address__country_code;
 SELF.individualowner__address__primary_address_indicator := R.individualowner__address__primary_address_indicator;
 SELF.individualowner__address__address_classification := R.individualowner__address__address_classification;
 SELF.individualowner__phone__segment_identifier := R.individualowner__phone__segment_identifier;
 SELF.individualowner__phone__file_sequence_number := R.individualowner__phone__file_sequence_number;
 SELF.individualowner__phone__parent_sequence_number :=   R.individualowner__phone__parent_sequence_number;
 SELF.individualowner__phone__area_code := R.individualowner__phone__area_code;
 SELF.individualowner__phone__phone_number :=   R.individualowner__phone__phone_number;
 SELF.individualowner__phone__phone_extension := R.individualowner__phone__phone_extension;
 SELF.individualowner__phone__primary_phone_indicator :=   R.individualowner__phone__primary_phone_indicator;
 SELF.individualowner__phone__published_unlisted_indicator := R.individualowner__phone__published_unlisted_indicator;
 SELF.individualowner__phone__phone_type := R.individualowner__phone__phone_type;
 SELF.individualowner__taxid__segment_identifier := R.individualowner__taxid__segment_identifier;
 SELF.individualowner__taxid__file_sequence_number :=   R.individualowner__taxid__file_sequence_number;
 SELF.individualowner__taxid__parent_sequence_number := R.individualowner__taxid__parent_sequence_number;
 SELF.individualowner__taxid__federal_taxid_ssn := R.individualowner__taxid__federal_taxid_ssn;
 SELF.individualowner__taxid__federal_taxid_ssn_identifier := R.individualowner__taxid__federal_taxid_ssn_identifier;
 SELF.individualowner__memberspecific__segment_identifier := R.individualowner__memberspecific__segment_identifier;
 SELF.individualowner__memberspecific__file_sequence_number := R.individualowner__memberspecific__file_sequence_number;
 SELF.individualowner__memberspecific__parent_sequence_number :=   R.individualowner__memberspecific__parent_sequence_number;
 SELF.individualowner__memberspecific__name_of_value := R.individualowner__memberspecific__name_of_value;
 SELF.individualowner__memberspecific__value_string := R.individualowner__memberspecific__value_string;
 SELF.individualowner__memberspecific__privacy_indicator := R.individualowner__memberspecific__privacy_indicator;
 SELF := L; 
   
END;


credit_individualdata := JOIN(credit_ma_adr_history_phone_tax,individualowner_all,LEFT.file_sequence_number = RIGHT.individualowner__account_base_number ,jointrans15(LEFT,RIGHT), LEFT OUTER, LOCAL);


credit_owner_master := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
    string2 phone__segment_identifier;
    string12 phone__file_sequence_number;
    string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
    string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
    string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
    
    string2 individualowner__segment_identifier;
    string12 individualowner__file_sequence_number;
    string12 individualowner__parent_sequence_number;
    string12 individualowner__account_base_number;
    string50 individualowner__original_fname;
    string50 individualowner__original_mname;
    string50 individualowner__original_lname;
    string5 individualowner__original_suffix;
    string100 individualowner__e_mail_address;
    string3 individualowner__guarantor_owner_indicator;
    string3 individualowner__relationship_to_business_indicator;
    string150 individualowner__business_title;
    string3 individualowner__percent_of_liability;
    string3 individualowner__percent_of_ownership;
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;
    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
    string2 individualowner__taxid__segment_identifier;
    string12 individualowner__taxid__file_sequence_number;
    string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;
    string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
    string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;

    string2 businessowner__segment_identifier;
    string12 businessowner__file_sequence_number;
    string12 businessowner__parent_sequence_number;
    string12 businessowner__account_base_number;
    string250 businessowner__business_name;
    string250 businessowner__web_address;
    string3 businessowner__guarantor_owner_indicator;
    string3 businessowner__relationship_to_business_indicator;
    string3 businessowner__percent_of_liability;
    string3 businessowner__percent_of_ownership_if_owner_principal;
    string2 businessowner__address__segment_identifier;
    string12 businessowner__address__file_sequence_number;
    string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;
  
    string2 businessowner__phone__segment_identifier;
    string12 businessowner__phone__file_sequence_number;
    string12 businessowner__phone__parent_sequence_number;
    string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
    string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
  
    string2 businessowner__taxid__segment_identifier;
    string12 businessowner__taxid__file_sequence_number;
    string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
  
    string2 businessowner__memberspecific__segment_identifier;
    string12 businessowner__memberspecific__file_sequence_number;
    string12 businessowner__memberspecific__parent_sequence_number;
    string20 businessowner__memberspecific__name_of_value;
    string250 businessowner__memberspecific__value_string;
    string1 businessowner__memberspecific__privacy_indicator; 
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;



credit_owner_master jointrans16(credit_individual L,businessowner_all_layout R ):= TRANSFORM
 
 SELF.businessowner__segment_identifier :=   R.businessowner__segment_identifier;
 SELF.businessowner__file_sequence_number := R.businessowner__file_sequence_number;
 SELF.businessowner__parent_sequence_number := R.businessowner__parent_sequence_number;
 SELF.businessowner__account_base_number :=   R.businessowner__account_base_number;
 SELF.businessowner__business_name := R.businessowner__business_name;
 SELF.businessowner__web_address :=   R.businessowner__web_address;
 SELF.businessowner__guarantor_owner_indicator := R.businessowner__guarantor_owner_indicator;
 SELF.businessowner__relationship_to_business_indicator := R.businessowner__relationship_to_business_indicator;
 SELF.businessowner__percent_of_liability :=   R.businessowner__percent_of_liability;
 SELF.businessowner__percent_of_ownership_if_owner_principal := R.businessowner__percent_of_ownership_if_owner_principal;
 SELF.businessowner__address__segment_identifier :=   R.businessowner__address__segment_identifier;
 SELF.businessowner__address__file_sequence_number := R.businessowner__address__file_sequence_number;
 SELF.businessowner__address__parent_sequence_number :=   R.businessowner__address__parent_sequence_number;
 SELF.businessowner__address__address_line_1 := R.businessowner__address__address_line_1;
 SELF.businessowner__address__address_line_2 := R.businessowner__address__address_line_2;
 SELF.businessowner__address__city :=   R.businessowner__address__city;
 SELF.businessowner__address__state := R.businessowner__address__state;
 SELF.businessowner__address__zip_code_or_ca_postal_code :=   R.businessowner__address__zip_code_or_ca_postal_code;
 SELF.businessowner__address__postal_code := R.businessowner__address__postal_code;
 SELF.businessowner__address__country_code :=   R.businessowner__address__country_code;
 SELF.businessowner__address__primary_address_indicator := R.businessowner__address__primary_address_indicator;
 SELF.businessowner__address__address_classification := R.businessowner__address__address_classification;
 SELF.businessowner__phone__segment_identifier := R.businessowner__phone__segment_identifier;
 SELF.businessowner__phone__file_sequence_number :=   R.businessowner__phone__file_sequence_number;
 SELF.businessowner__phone__parent_sequence_number := R.businessowner__phone__parent_sequence_number;
 SELF.businessowner__phone__area_code :=   R.businessowner__phone__area_code;
 SELF.businessowner__phone__phone_number := R.businessowner__phone__phone_number;
 SELF.businessowner__phone__phone_extension :=   R.businessowner__phone__phone_extension;
 SELF.businessowner__phone__published_unlisted_indicator := R.businessowner__phone__published_unlisted_indicator;
 SELF.businessowner__phone__primary_phone_indicator := R.businessowner__phone__primary_phone_indicator;
 SELF.businessowner__phone__phone_type := R.businessowner__phone__phone_type;
 SELF.businessowner__businessindustryclassification__segment_identifier :=   R.businessowner__businessindustryclassification__segment_identifier;
 SELF.businessowner__businessindustryclassification__file_sequence_number := R.businessowner__businessindustryclassification__file_sequence_number;
 SELF.businessowner__businessindustryclassification__parent_sequence_number := R.businessowner__businessindustryclassification__parent_sequence_number;
 SELF.businessowner__businessindustryclassification__classification_code_type := R.businessowner__businessindustryclassification__classification_code_type;
 SELF.businessowner__businessindustryclassification__classification_code := R.businessowner__businessindustryclassification__classification_code;
 SELF.businessowner__businessindustryclassification__primary_industry_code_indicator := R.businessowner__businessindustryclassification__primary_industry_code_indicator;
 SELF.businessowner__businessindustryclassification__privacy_indicator :=   R.businessowner__businessindustryclassification__privacy_indicator;
 SELF.businessowner__taxid__segment_identifier := R.businessowner__taxid__segment_identifier;
 SELF.businessowner__taxid__file_sequence_number := R.businessowner__taxid__file_sequence_number;
 SELF.businessowner__taxid__parent_sequence_number := R.businessowner__taxid__parent_sequence_number;
 SELF.businessowner__taxid__federal_taxid_ssn := R.businessowner__taxid__federal_taxid_ssn;
 SELF.businessowner__taxid__federal_taxid_ssn_identifier := R.businessowner__taxid__federal_taxid_ssn_identifier;
 SELF.businessowner__memberspecific__segment_identifier := R.businessowner__memberspecific__segment_identifier;
 SELF.businessowner__memberspecific__file_sequence_number := R.businessowner__memberspecific__file_sequence_number;
 SELF.businessowner__memberspecific__parent_sequence_number := R.businessowner__memberspecific__parent_sequence_number;
 SELF.businessowner__memberspecific__name_of_value := R.businessowner__memberspecific__name_of_value;
 SELF.businessowner__memberspecific__value_string := R.businessowner__memberspecific__value_string; 
 SELF.businessowner__memberspecific__privacy_indicator := R.businessowner__memberspecific__privacy_indicator;
 SELF := L; 
   
END;


creditownermasterdata := JOIN(credit_individualdata,businessowner_all,LEFT.file_sequence_number = RIGHT.businessowner__account_base_number ,jointrans16(LEFT,RIGHT), LEFT OUTER, LOCAL);


credit_owner_master_bic := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
    string2 phone__segment_identifier;
    string12 phone__file_sequence_number;
    string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
    string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
    string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
    
    string2 individualowner__segment_identifier;
    string12 individualowner__file_sequence_number;
    string12 individualowner__parent_sequence_number;
    string12 individualowner__account_base_number;
    string50 individualowner__original_fname;
    string50 individualowner__original_mname;
    string50 individualowner__original_lname;
    string5 individualowner__original_suffix;
    string100 individualowner__e_mail_address;
    string3 individualowner__guarantor_owner_indicator;
    string3 individualowner__relationship_to_business_indicator;
    string150 individualowner__business_title;
    string3 individualowner__percent_of_liability;
    string3 individualowner__percent_of_ownership;
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;
    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
    string2 individualowner__taxid__segment_identifier;
    string12 individualowner__taxid__file_sequence_number;
    string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;
    string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
    string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;

    string2 businessowner__segment_identifier;
    string12 businessowner__file_sequence_number;
    string12 businessowner__parent_sequence_number;
    string12 businessowner__account_base_number;
    string250 businessowner__business_name;
    string250 businessowner__web_address;
    string3 businessowner__guarantor_owner_indicator;
    string3 businessowner__relationship_to_business_indicator;
    string3 businessowner__percent_of_liability;
    string3 businessowner__percent_of_ownership_if_owner_principal;
    string2 businessowner__address__segment_identifier;
    string12 businessowner__address__file_sequence_number;
    string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;
  
    string2 businessowner__phone__segment_identifier;
    string12 businessowner__phone__file_sequence_number;
    string12 businessowner__phone__parent_sequence_number;
    string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
  
    string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
  
    string2 businessowner__taxid__segment_identifier;
    string12 businessowner__taxid__file_sequence_number;
    string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
  
    string2 businessowner__memberspecific__segment_identifier;
    string12 businessowner__memberspecific__file_sequence_number;
    string12 businessowner__memberspecific__parent_sequence_number;
    string20 businessowner__memberspecific__name_of_value;
    string250 businessowner__memberspecific__value_string;
    string1 businessowner__memberspecific__privacy_indicator; 

    string2 businessindustryclassification__segment_identifier;
    string12 businessindustryclassification__file_sequence_number;
    string12 businessindustryclassification__parent_sequence_number;
    string3 businessindustryclassification__classification_code_type;
    string25 businessindustryclassification__classification_code;
    string1 businessindustryclassification__primary_industry_code_indicator;
    string1 businessindustryclassification__privacy_indicator;    
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;



credit_owner_master_bic jointrans17(credit_owner_master L,businessindustryidentifiersegment R ):= TRANSFORM
 
 SELF.businessindustryclassification__segment_identifier :=   R.segment_identifier;
 SELF.businessindustryclassification__file_sequence_number := R.file_sequence_number;
 SELF.businessindustryclassification__parent_sequence_number := R.parent_sequence_number;
 SELF.businessindustryclassification__classification_code_type :=   R.classification_code_type;
 SELF.businessindustryclassification__classification_code := R.classification_code;
 SELF.businessindustryclassification__primary_industry_code_indicator :=   R.primary_industry_code_indicator;
 SELF.businessindustryclassification__privacy_indicator := R.privacy_indicator;
 SELF := L; 
   
END;


creditownermasterbicdata := JOIN(creditownermasterdata,businessindustryidentifiersegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans17(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_owner_master_bic_col := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
    string2 phone__segment_identifier;
    string12 phone__file_sequence_number;
    string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
    string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
    string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
    
    string2 individualowner__segment_identifier;
    string12 individualowner__file_sequence_number;
    string12 individualowner__parent_sequence_number;
    string12 individualowner__account_base_number;
    string50 individualowner__original_fname;
    string50 individualowner__original_mname;
    string50 individualowner__original_lname;
    string5 individualowner__original_suffix;
    string100 individualowner__e_mail_address;
    string3 individualowner__guarantor_owner_indicator;
    string3 individualowner__relationship_to_business_indicator;
    string150 individualowner__business_title;
    string3 individualowner__percent_of_liability;
    string3 individualowner__percent_of_ownership;
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;
    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
    string2 individualowner__taxid__segment_identifier;
    string12 individualowner__taxid__file_sequence_number;
    string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;
    string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
    string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;

    string2 businessowner__segment_identifier;
    string12 businessowner__file_sequence_number;
    string12 businessowner__parent_sequence_number;
    string12 businessowner__account_base_number;
    string250 businessowner__business_name;
    string250 businessowner__web_address;
    string3 businessowner__guarantor_owner_indicator;
    string3 businessowner__relationship_to_business_indicator;
    string3 businessowner__percent_of_liability;
    string3 businessowner__percent_of_ownership_if_owner_principal;
    string2 businessowner__address__segment_identifier;
    string12 businessowner__address__file_sequence_number;
    string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;
    string2 businessowner__phone__segment_identifier;
    string12 businessowner__phone__file_sequence_number;
    string12 businessowner__phone__parent_sequence_number;
    string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
    string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
    string2 businessowner__taxid__segment_identifier;
    string12 businessowner__taxid__file_sequence_number;
    string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
    string2 businessowner__memberspecific__segment_identifier;
    string12 businessowner__memberspecific__file_sequence_number;
    string12 businessowner__memberspecific__parent_sequence_number;
    string20 businessowner__memberspecific__name_of_value;
    string250 businessowner__memberspecific__value_string;
    string1 businessowner__memberspecific__privacy_indicator; 

    string2 businessindustryclassification__segment_identifier;
    string12 businessindustryclassification__file_sequence_number;
    string12 businessindustryclassification__parent_sequence_number;
    string3 businessindustryclassification__classification_code_type;
    string25 businessindustryclassification__classification_code;
    string1 businessindustryclassification__primary_industry_code_indicator;
    string1 businessindustryclassification__privacy_indicator;    

   string2 collateral__segment_identifier;
   string12 collateral__file_sequence_number;
   string12 collateral__parent_sequence_number;
   string1 collateral__collateral_indicator;
   string3 collateral__type_of_collateral_secured_for_this_account;
   string250 collateral__collateral_description;
   string50 collateral__ucc_filing_number;
   string3 collateral__ucc_filing_type;
   string8 collateral__ucc_filing_date;
   string8 collateral__ucc_filing_expiration_date;
   string100 collateral__ucc_filing_jurisdiction;
   string250 collateral__ucc_filing_description;
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;



credit_owner_master_bic_col jointrans18(credit_owner_master_bic L,collateralsegment R ):= TRANSFORM

 SELF.collateral__segment_identifier :=   R.segment_identifier;
 SELF.collateral__file_sequence_number := R.file_sequence_number;
 SELF.collateral__parent_sequence_number := R.parent_sequence_number;
 SELF.collateral__collateral_indicator :=   R.collateral_indicator;
 SELF.collateral__type_of_collateral_secured_for_this_account := R.type_of_collateral_secured_for_this_account;
 SELF.collateral__collateral_description :=   R.collateral_description;
 SELF.collateral__ucc_filing_number := R.ucc_filing_number;
 SELF.collateral__ucc_filing_type :=   R.ucc_filing_type;
 SELF.collateral__ucc_filing_date := R.ucc_filing_date;
 SELF.collateral__ucc_filing_expiration_date :=   R.ucc_filing_expiration_date;
 SELF.collateral__ucc_filing_jurisdiction := R.ucc_filing_jurisdiction;
 SELF.collateral__ucc_filing_description := R.ucc_filing_description;
 SELF := L; 
   
END;


creditownermasterbiccoldata := JOIN(creditownermasterbicdata,collateralsegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans18(LEFT,RIGHT), LEFT OUTER, LOCAL);

credit_files_normalized := RECORD
  string process_date;
  string2 segment_identifier;
  string12 file_sequence_number;
  string12 parent_sequence_number;
  string250 account_holder_business_name;
  string250 dba;
  string250 company_website;
  string3 legal_business_structure;
  string8 business_established_date;
  string50 contract_account_number;
  string3 account_type_reported;
  string3 account_status_1;
  string3 account_status_2;
  string8 date_account_opened;
  string8 date_account_closed;
  string2 account_closure_basis;
  string8 account_expiration_date;
  string8 last_activity_date;
  string3 last_activity_type;
  string1 recent_activity_indicator;
  string12 original_credit_limit;
  string12 highest_credit_used;
  string12 current_credit_limit;
  string3 reporting_indicator_length;
  string2 payment_interval;
  string3 payment_status_category;
  string3 term_of_account_in_months;
  string8 first_payment_due_date;
  string8 final_payment_due_date;
  string10 original_rate;
  string10 floating_rate;
  string4 grace_period;
  string3 payment_category;
  string12 payment_history_profile_12_months;
  string12 payment_history_profile_13_24_months;
  string12 payment_history_profile_25_36_months;
  string12 payment_history_profile_37_48_months;
  string4 payment_history_length;
  string12 year_to_date_purchases_count;
  string12 lifetime_to_date_purchases_count;
  string20 year_to_date_purchases_sum_amount;
  string20 lifetime_to_date_purchases_sum_amount;
  string12 payment_amount_scheduled;
  string12 recent_payment_amount;
  string8 recent_payment_date;
  string12 remaining_balance;
  string12 carried_over_amount;
  string12 new_applied_charges;
  string12 balloon_payment_due;
  string8 balloon_payment_due_date;
  string8 delinquency_date;
  string8 days_delinquent;
  string12 past_due_amount;
  string3 maximum_number_of_past_due_aging_amounts_buckets_provided;
  string3 past_due_aging_bucket_type;
  string12 past_due_aging_amount_bucket_1;
  string12 past_due_aging_amount_bucket_2;
  string12 past_due_aging_amount_bucket_3;
  string12 past_due_aging_amount_bucket_4;
  string12 past_due_aging_amount_bucket_5;
  string12 past_due_aging_amount_bucket_6;
  string12 past_due_aging_amount_bucket_7;
  string3 maximum_number_of_payment_tracking_cycle_periods_provided;
  string3 payment_tracking_cycle_type;
  string4 payment_tracking_cycle_0_current;
  string4 payment_tracking_cycle_1_1_to_30_days;
  string4 payment_tracking_cycle_2_31_to_60_days;
  string4 payment_tracking_cycle_3_61_to_90_days;
  string4 payment_tracking_cycle_4_91_to_120_days;
  string4 payment_tracking_cycle_5_121_to_150days;
  string4 payment_tracking_number_of_times_cycle_6_151_to_180_days;
  string4 payment_tracking_number_of_times_cycle_7_181_or_greater_days;
  string8 date_account_was_charged_off;
  string12 amount_charged_off_by_creditor;
  string3 charge_off_type_indicator;
  string12 total_charge_off_recoveries_to_date;
  string1 government_guarantee_flag;
  string3 government_guarantee_category;
  string3 portion_of_account_guaranteed_by_government;
  string1 guarantors_indicator;
  string2 number_of_guarantors;
  string1 owners_indicator;
  string2 number_of_principals;
  string3 account_update_deletion_indicator;
  
    string2 masteraccount__segment_identifier;
    string12 masteraccount__file_sequence_number;
    string12 masteraccount__parent_sequence_number;
    string50 masteraccount__master_account_or_contract_number_identifier;
    
    string2 address__segment_identifier;
    string12 address__file_sequence_number;
    string12 address__parent_sequence_number;
    string100 address__address_line_1;
    string100 address__address_line_2;
    string50 address__city;
    string2 address__state;
    string6 address__zip_code_or_ca_postal_code;
    string4 address__postal_code;
    string2 address__country_code;
    string1 address__primary_address_indicator;
    string3 address__address_classification;
        
    string2 history__segment_identifier;
    string12 history__file_sequence_number;
    string12 history__parent_sequence_number;
    string30 history__previous_member_id;
    string50 history__previous_account_number;
    string3 history__previous_account_type;
    string3 history__type_of_conversion_maintenance;
    string8 history__date_account_converted;
    
    string2 phone__segment_identifier;
    string12 phone__file_sequence_number;
    string12 phone__parent_sequence_number;
    string3 phone__area_code;
    string7 phone__phone_number;
    string10 phone__phone_extension;
    string1 phone__primary_phone_indicator;
    string3 phone__published_unlisted_indicator;
    string3 phone__phone_type;

   
    string2 taxid__segment_identifier;
    string12 taxid__file_sequence_number;
    string12 taxid__parent_sequence_number;
    string9 taxid__federal_taxid_ssn;
    string3 taxid__federal_taxid_ssn_identifier;
    
    
    string2 individualowner__segment_identifier;
    string12 individualowner__file_sequence_number;
    string12 individualowner__parent_sequence_number;
    string12 individualowner__account_base_number;
    string50 individualowner__original_fname;
    string50 individualowner__original_mname;
    string50 individualowner__original_lname;
    string5 individualowner__original_suffix;
    string100 individualowner__e_mail_address;
    string3 individualowner__guarantor_owner_indicator;
    string3 individualowner__relationship_to_business_indicator;
    string150 individualowner__business_title;
    string3 individualowner__percent_of_liability;
    string3 individualowner__percent_of_ownership;
    string2 individualowner__address__segment_identifier;
    string12 individualowner__address__file_sequence_number;
    string12 individualowner__address__parent_sequence_number;
    string100 individualowner__address__address_line_1;
    string100 individualowner__address__address_line_2;
    string50 individualowner__address__city;
    string2 individualowner__address__state;
    string6 individualowner__address__zip_code_or_ca_postal_code;
    string4 individualowner__address__postal_code;
    string2 individualowner__address__country_code;
    string1 individualowner__address__primary_address_indicator;
    string3 individualowner__address__address_classification;
    string2 individualowner__phone__segment_identifier;
    string12 individualowner__phone__file_sequence_number;
    string12 individualowner__phone__parent_sequence_number;
    string3 individualowner__phone__area_code;
    string7 individualowner__phone__phone_number;
    string10 individualowner__phone__phone_extension;
    string1 individualowner__phone__primary_phone_indicator;
    string3 individualowner__phone__published_unlisted_indicator;
    string3 individualowner__phone__phone_type;
    string2 individualowner__taxid__segment_identifier;
    string12 individualowner__taxid__file_sequence_number;
    string12 individualowner__taxid__parent_sequence_number;
    string9 individualowner__taxid__federal_taxid_ssn;
    string3 individualowner__taxid__federal_taxid_ssn_identifier;
    string2 individualowner__memberspecific__segment_identifier;
    string12 individualowner__memberspecific__file_sequence_number;
    string12 individualowner__memberspecific__parent_sequence_number;
    string20 individualowner__memberspecific__name_of_value;
    string250 individualowner__memberspecific__value_string;
    string1 individualowner__memberspecific__privacy_indicator;

    string2 businessowner__segment_identifier;
    string12 businessowner__file_sequence_number;
    string12 businessowner__parent_sequence_number;
    string12 businessowner__account_base_number;
    string250 businessowner__business_name;
    string250 businessowner__web_address;
    string3 businessowner__guarantor_owner_indicator;
    string3 businessowner__relationship_to_business_indicator;
    string3 businessowner__percent_of_liability;
    string3 businessowner__percent_of_ownership_if_owner_principal;
    string2 businessowner__address__segment_identifier;
    string12 businessowner__address__file_sequence_number;
    string12 businessowner__address__parent_sequence_number;
    string100 businessowner__address__address_line_1;
    string100 businessowner__address__address_line_2;
    string50 businessowner__address__city;
    string2 businessowner__address__state;
    string6 businessowner__address__zip_code_or_ca_postal_code;
    string4 businessowner__address__postal_code;
    string2 businessowner__address__country_code;
    string1 businessowner__address__primary_address_indicator;
    string3 businessowner__address__address_classification;
    string2 businessowner__phone__segment_identifier;
    string12 businessowner__phone__file_sequence_number;
    string12 businessowner__phone__parent_sequence_number;
    string3 businessowner__phone__area_code;
    string7 businessowner__phone__phone_number;
    string10 businessowner__phone__phone_extension;
    string1 businessowner__phone__primary_phone_indicator;
    string3 businessowner__phone__published_unlisted_indicator;
    string3 businessowner__phone__phone_type;
    string2 businessowner__businessindustryclassification__segment_identifier;
    string12 businessowner__businessindustryclassification__file_sequence_number;
    string12 businessowner__businessindustryclassification__parent_sequence_number;
    string3 businessowner__businessindustryclassification__classification_code_type;
    string25 businessowner__businessindustryclassification__classification_code;
    string1 businessowner__businessindustryclassification__primary_industry_code_indicator;
    string1 businessowner__businessindustryclassification__privacy_indicator; 
    string2 businessowner__taxid__segment_identifier;
    string12 businessowner__taxid__file_sequence_number;
    string12 businessowner__taxid__parent_sequence_number;
    string9 businessowner__taxid__federal_taxid_ssn;
    string3 businessowner__taxid__federal_taxid_ssn_identifier; 
    string2 businessowner__memberspecific__segment_identifier;
    string12 businessowner__memberspecific__file_sequence_number;
    string12 businessowner__memberspecific__parent_sequence_number;
    string20 businessowner__memberspecific__name_of_value;
    string250 businessowner__memberspecific__value_string;
    string1 businessowner__memberspecific__privacy_indicator; 

    string2 businessindustryclassification__segment_identifier;
    string12 businessindustryclassification__file_sequence_number;
    string12 businessindustryclassification__parent_sequence_number;
    string3 businessindustryclassification__classification_code_type;
    string25 businessindustryclassification__classification_code;
    string1 businessindustryclassification__primary_industry_code_indicator;
    string1 businessindustryclassification__privacy_indicator;    

   string2 collateral__segment_identifier;
   string12 collateral__file_sequence_number;
   string12 collateral__parent_sequence_number;
   string1 collateral__collateral_indicator;
   string3 collateral__type_of_collateral_secured_for_this_account;
   string250 collateral__collateral_description;
   string50 collateral__ucc_filing_number;
   string3 collateral__ucc_filing_type;
   string8 collateral__ucc_filing_date;
   string8 collateral__ucc_filing_expiration_date;
   string100 collateral__ucc_filing_jurisdiction;
   string250 collateral__ucc_filing_description;

   string2 memberspecific__segment_identifier;
   string12 memberspecific__file_sequence_number;
   string12 memberspecific__parent_sequence_number;
   string20 memberspecific__name_of_value;
   string250 memberspecific__value_string;
   string1 memberspecific__privacy_indicator; 
  
  headersegment portfolioheader;
  fileheadersegment fileheader;
  unsigned8 sbfe_id;
  boolean active;
 END;
 
 
 credit_files_normalized jointrans19(credit_owner_master_bic_col L,memberspecificsegment R ):= TRANSFORM

 SELF.memberspecific__segment_identifier :=   R.segment_identifier;
 SELF.memberspecific__file_sequence_number := R.file_sequence_number;
 SELF.memberspecific__parent_sequence_number := R.parent_sequence_number;
 SELF.memberspecific__name_of_value :=   R.name_of_value;
 SELF.memberspecific__value_string := R.value_string;
 SELF.memberspecific__privacy_indicator :=   R.privacy_indicator;
 SELF := L; 
   
END;


credit_files_normalized_data := JOIN(creditownermasterbiccoldata,memberspecificsegmentdata,LEFT.file_sequence_number = RIGHT.account_base_number ,jointrans19(LEFT,RIGHT), LEFT OUTER, LOCAL);

ADV.Flatten(credit_files_normalized_data, flattenedfile);

sortedfile := SORT(flattenedfile, RECORD);
dedupfile := DEDUP(sortedfile, RECORD);

RETURN dedupfile;

ENDMACRO;