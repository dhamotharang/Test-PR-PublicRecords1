masteraccountcontractsegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string50  master_account_or_contract_number_identifier;
end;


	addresssegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string100  address_line_1;
	string100  address_line_2;
	string50  city;
	string2  state;
	string6  zip_code_or_ca_postal_code;
	string4  postal_code;
	string2  country_code;
	string1  primary_address_indicator;
	string3  address_classification;
end;
  accountmodificationhistorysegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string30  previous_member_id;
	string50  previous_account_number;
	string3  previous_account_type;
	string3  type_of_conversion_maintenance;
	string8  date_account_converted;
end;
  phonenumbersegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string3  area_code;
	string7  phone_number;
	string10  phone_extension;
	string1  primary_phone_indicator;
	string3  published_unlisted_indicator;
	string3  phone_type;
end;
  taxid_ssnsegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string9  federal_taxid_ssn;
	string3  federal_taxid_ssn_identifier;
end;
  memberspecificsegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string20  name_of_value;
	string250  value_string;
	string1  privacy_indicator;
end;
  individualownerlayout :=  RECORD;
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

		 DATASET(addresssegment);
address{maxcount(100)};

		 DATASET(phonenumbersegment);
phone{maxcount(100)};

		 DATASET(taxid_ssnsegment);
taxid{maxcount(100)};

		 DATASET(memberspecificsegment);
memberspecific{maxcount(100)};
END;
  businessindustryidentifiersegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string3  classification_code_type;
	string25  classification_code;
	string1  primary_industry_code_indicator;
	string1  privacy_indicator;
end;
  businessownerlayout :=  RECORD;
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

		 DATASET(addresssegment);
address{maxcount(100)};

		 DATASET(phonenumbersegment);
phone{maxcount(100)};

		 DATASET(businessindustryidentifiersegment);
businessindustryclassification{maxcount(25)};

		 DATASET(taxid_ssnsegment);
taxid{maxcount(100)};

		 DATASET(memberspecificsegment);
memberspecific{maxcount(100)};
END;
  collateralsegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string12  parent_sequence_number;
	string12  account_base_number;
	string1  collateral_indicator;
	string3  type_of_collateral_secured_for_this_account;
	string250  collateral_description;
	string50  ucc_filing_number;
	string3  ucc_filing_type;
	string8  ucc_filing_date;
	string8  ucc_filing_expiration_date;
	string100  ucc_filing_jurisdiction;
	string250  ucc_filing_description;
end;
  headersegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string30  sbfe_contributor_number;
	string8  extracted_date;
	string8  cycle_end_date;
	string2  cycle_number;
	string3  cycle_length;
	string3  file_correction_indicator;
	string4  overall_file_format_version;
	string2  major_aa_segment_version;
	string2  minor_aa_segment_version;
	string2  major_ab_segment_version;
	string2  minor_ab_segment_version;
	string2  major_ma_segment_version;
	string2  minor_ma_segment_version;
	string2  major_ad_segment_version;
	string2  minor_ad_segment_version;
	string2  major_pn_segment_version;
	string2  minor_pn_segment_version;
	string2  major_ti_segment_version;
	string2  minor_ti_segment_version;
	string2  major_is_segment_version;
	string2  minor_is_segment_version;
	string2  major_bs_segment_version;
	string2  minor_bs_segment_version;
	string2  major_bi_segment_version;
	string2  minor_bi_segment_version;
	string2  major_cl_segment_version;
	string2  minor_cl_segment_version;
	string2  major_ms_segment_version;
	string2  minor_ms_segment_version;
	string2  major_ah_segment_version;
	string2  minor_ah_segment_version;
	string2  major_zz_segment_version;
	string2  minor_zz_segment_version;
end;
  fileheadersegment := record
	string2  segment_identifier;
	string12  file_sequence_number;
	string3  test_or_production_indicator;
	string3  file_type_indicator;
end;
RECORD;
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

		DATASET(masteraccountcontractsegment);
masteraccount{maxcount(1)};

		DATASET(addresssegment);
address{maxcount(100)};

		DATASET(accountmodificationhistorysegment);
history{maxcount(25)};

		DATASET(phonenumbersegment);
phone{maxcount(100)};

		DATASET(taxid_ssnsegment);
taxid{maxcount(100)};

		DATASET(individualownerlayout);
individualowner{maxcount(200)};

		DATASET(businessownerlayout);
businessowner{maxcount(100)};

		DATASET(businessindustryidentifiersegment);
businessindustryclassification{maxcount(25)};

		DATASET(collateralsegment);
collateral{maxcount(100)};

		DATASET(memberspecificsegment);
memberspecific{maxcount(100)};
headersegment portfolioheader;
fileheadersegment fileheader;
unsigned8 sbfe_id;
boolean active;
string __filename;
string1 correction_type;
string8 correction_date;
string original_process_date;
END;
