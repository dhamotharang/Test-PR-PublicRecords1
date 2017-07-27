import risk_indicators;

export CDIP_Layouts := MODULE
	EXPORT batch_in := Risk_Indicators.Layout_Batch_In;

	EXPORT batch_out := RECORD
		string10 seq;
		string30 AcctNo;
		string12 did;
		
		/* Input */
		string10 unit_desig;
		string1  addr_type;
		
		
		/* InstantID */
		string2  NAS_Summary; // was integer1 
		string2  NAP_Summary; // was integer1 
		string1  nap_type;
		string1  nap_status;
		string2  CVI; // was integer1 
		string2  reason1;
		string2  reason2;
		string2  reason3;
		string2  reason4;
		string2  reason5;
		string2  reason6;
		// string1  hriskphoneflag;
		string1  hphonetypeflag;
		// string1  phonevalflag;
		string1  hphonevalflag;
		// string1  phonezipflag;
		string1  PWphonezipflag;
		string1  phonedissflag; // was boolean 
		string1  wphonedissflag; // was boolean 
		string1  hriskaddrflag;
		string1  decsflag;
		string1  socsdobflag;
		// string1  PWsocsdobflag;
		// string1  socsvalflag;
		// string1  PWsocsvalflag;
		string8  soclhighissue;
		string1  addrvalflag;
		// string1  dwelltype;
		string1  bansflag;
		string50 Sources;
		string5  firstcount; // was unsigned2 
		string5  lastcount; // was unsigned2 
		string5  socscount; // was unsigned2 
		string5  addrcount; // was unsigned2 
		string5  numelever; // was unsigned2 
		string5  phoneaddr_addrcount; // was unsigned2 
		string5  phoneaddr_phonecount; // was unsigned2 
		string5  utiliaddr_addrcount; // was unsigned2 
		string5  utiliaddr_phonecount; // was unsigned2 
		string1  hphonemiskeyflag; // was boolean 
		string1  addrmiskeyflag; // was boolean 
		string6  hrisksic;
		string6  hrisksicphone;
		// string1  zipclass;
		string1  cityzipflag;
		string3  combo_ssnscore; // was unsigned1 
		string3  combo_dobscore; // was unsigned1 
		// string3  combo_cmpyscore; // was unsigned1 
		string3  combo_firstcount; // was unsigned1 
		string3  combo_lastcount; // was unsigned1 
		string3  combo_addrcount; // was unsigned1 
		string1  watchlistHit; // was boolean 


		/* Source Verification Data */
		string5  EQ_count; // was unsigned2 
		string5  TU_count; // was unsigned2 
		string5  DL_count; // was unsigned2 
		string5  PR_count; // was unsigned2 
		string5  V_count; // was unsigned2 
		string5  EM_count; // was unsigned2 
		string5  W_count; // was unsigned2 

		/* Available Sources */
		string1  dl_available; // was boolean 
		string1  voter_available; // was boolean 


		/* Name Verification */
		string3  adl_score; // was unsigned1 
		string3  source_count; // was unsigned1 
		string1  fname_credit_sourced; // was boolean 
		string1  lname_credit_sourced; // was boolean 
		string1  fname_tu_sourced; // was boolean 
		string1  lname_tu_sourced; // was boolean 
		string1  fname_eda_sourced; // was boolean 
		string1  lname_eda_sourced; // was boolean 
		string1  fname_dl_sourced; // was boolean 
		string1  lname_dl_sourced; // was boolean 
		string1  fname_voter_sourced; // was boolean 
		string1  lname_voter_sourced; // was boolean 
		string1  fname_utility_sourced; // was boolean 
		string1  lname_utility_sourced; // was boolean 
		string3  Age; // was unsigned1 

		/* ADDRESS */
		/* Input Address */
		string1  addr1_House_Number_match; // was boolean 
		string1  addr1_isbestmatch; // was boolean 
		string3  addr1_source_count; // was unsigned1 
		string1  addr1_credit_sourced; // was boolean 
		string1  addr1_eda_sourced; // was boolean 
		string1  addr1_dl_sourced; // was boolean 
		string1  addr1_voter_sourced; // was boolean 
		string1  addr1_applicant_owned; // was boolean 
		string1  addr1_occupant_owned; // was boolean 
		string1  addr1_family_owned; // was boolean 
		string1  addr1_family_sold; // was boolean 
		string1  addr1_applicant_sold; // was boolean 
		string3  addr1_naprop; // was unsigned1 
		string8  addr1_purchase_date; // was unsigned4 
		string8  addr1_built_date; // was unsigned4 
		string13 addr1_purchase_amount; // was unsigned4 
		string13 addr1_mortgage_amount; // was unsigned4 
		string8  addr1_mortgage_date; // was unsigned4 
		string13 addr1_assessed_amount; // was unsigned4 
		string8  addr1_date_first_seen; // was unsigned4 
		string5  addr1_census_age;
		string9  addr1_census_income;
		string9  addr1_census_home_value;
		string5  addr1_census_education;
		string1  addr1_avm_land_use_code;
		string11 addr1_avm_assessed_total_value;
		string11 addr1_avm_market_total_value;
		string13 addr1_avm_tax_assessment_valuation; // was unsigned8
		string13 addr1_avm_price_index_valuation; // was unsigned8 
		string13 addr1_avm_hedonic_valuation; // was unsigned8 
		string13 addr1_avm_automated_valuation; // was unsigned8 
		string13 addr1_avm_confidence_score; // was unsigned8 
		string13 addr1_avm_median_fips_level; // was unsigned8 
		string13 addr1_avm_median_geo11_level; // was unsigned8 
		string13 addr1_avm_median_geo12_level; // was unsigned8 


		/* Address History 1 */
		string1  addr2_House_Number_match; // was boolean 
		string1  addr2_isbestmatch; // was boolean 
		string3  addr2_source_count; // was unsigned1 
		string1  addr2_credit_sourced; // was boolean 
		string1  addr2_eda_sourced; // was boolean 
		string1  addr2_dl_sourced; // was boolean 
		string1  addr2_voter_sourced; // was boolean 
		string1  addr2_applicant_owned; // was boolean 
		string1  addr2_occupant_owned; // was boolean 
		string1  addr2_family_owned; // was boolean 
		string1  addr2_family_sold; // was boolean 
		string1  addr2_applicant_sold; // was boolean 
		string3  addr2_naprop; // was unsigned1 
		string8  addr2_purchase_date; // was unsigned4 
		string8  addr2_built_date; // was unsigned4 
		string13 addr2_purchase_amount; // was unsigned4 
		string13 addr2_mortgage_amount; // was unsigned4 
		string8  addr2_mortgage_date; // was unsigned4 
		string13 addr2_assessed_amount; // was unsigned4 
		string8  addr2_date_first_seen; // was unsigned4 
		string1  addr2_HR_Address; // was boolean 
		string5  addr2_census_age;
		string9  addr2_census_income;
		string9  addr2_census_home_value;
		string11 addr2_avm_assessed_total_value;
		string11 addr2_avm_market_total_value;
		string13 addr2_avm_tax_assessment_valuation; // was unsigned8
		string13 addr2_avm_price_index_valuation; // was unsigned8 
		string13 addr2_avm_hedonic_valuation; // was unsigned8 
		string13 addr2_avm_automated_valuation; // was unsigned8 
		string13 addr2_avm_confidence_score; // was unsigned8 
		string13 addr2_avm_median_fips_level; // was unsigned8 
		string13 addr2_avm_median_geo11_level; // was unsigned8 
		string13 addr2_avm_median_geo12_level; // was unsigned8 

		/* Address History 2 */
		string1  addr3_House_Number_match; // was boolean 
		string1  addr3_isbestmatch; // was boolean 
		string3  addr3_source_count; // was unsigned1 
		string1  addr3_credit_sourced; // was boolean 
		string1  addr3_eda_sourced; // was boolean 
		string1  addr3_dl_sourced; // was boolean 
		string1  addr3_voter_sourced; // was boolean 
		string1  addr3_applicant_owned; // was boolean 
		string1  addr3_occupant_owned; // was boolean 
		string1  addr3_family_owned; // was boolean 
		string1  addr3_family_sold; // was boolean 
		string1  addr3_applicant_sold; // was boolean 
		string3  addr3_naprop; // was unsigned1 
		string8  addr3_purchase_date; // was unsigned4 
		string8  addr3_built_date; // was unsigned4 
		string13 addr3_purchase_amount; // was unsigned4 
		string13 addr3_mortgage_amount; // was unsigned4 
		string8  addr3_mortgage_date; // was unsigned4 
		string13 addr3_assessed_amount; // was unsigned4 
		string8  addr3_date_first_seen; // was unsigned4 
		string1  addr3_HR_Address; // was boolean 
		string5  addr3_census_age;
		string9  addr3_census_income;
		string9  addr3_census_home_value;
		string3  owned_property_total; // was unsigned1 
		string13 owned_property_owned_purchase_total; // was unsigned5 
		string5  owned_property_owned_purchase_count; // was unsigned2 
		string13 owned_property_owned_assessed_total; // was unsigned5 
		string5  owned_property_owned_assessed_count; // was unsigned2 
		string3  sold_property_total; // was unsigned1 
		string13 sold_property_owned_purchase_total; // was unsigned5 

		/* Other Address Fields */
		string3  avg_lres; // was unsigned1 
		string3  max_lres; // was unsigned1 
		string3  addrs_last_5years; // was unsigned1 
		string3  addrs_last_10years; // was unsigned1 
		string3  addrs_last_15years; // was unsigned1 

		/* Phone Verification */
		string10 telcordia_type;
		string3  recent_disconnects; // was unsigned1 

		/* SSN Verification & Validation */
		string5  namePerSSN_count; // was unsigned2 
		string1 credit_sourced; // was boolean
		string8 credit_first_seen; // was unsigned3
		string8 credit_last_seen; // was unsigned3
		string8 header_first_seen; // was unsigned3
		string8 header_last_seen; // was unsigned3
		string1 tu_sourced; // was boolean
		string1 voter_sourced; // was boolean
		string1 utility_sourced; // was boolean
		string1 bk_sourced; // was boolean
		string1 other_sourced; // was boolean
		string1  inputsocscharflag;
		
		
		/* Velocity Counters */
		string3  ssns_per_adl; // was unsigned1 
		string3  addrs_per_adl; // was unsigned1 
		string3  phones_per_adl; // was unsigned1 
		string5  adlPerSSN_count; // was unsigned2 
		string3  adls_per_addr; // was unsigned1 
		string3  ssns_per_addr; // was unsigned1 
		string3  phones_per_addr; // was unsigned1 
		string3  adls_per_phone; // was unsigned1 
		string3  ssns_per_adl_created_6months; // was unsigned1 
		
		
		/* Derogs/BJL */
		string1  Bankrupt; // was boolean 
		string8  date_last_seen; // was unsigned4 
		string3  filing_count; // was unsigned1 
		string3  bk_recent_count; // was unsigned1 
		string3  bk_disposed_recent_count; // was unsigned1 
		string3  bk_disposed_historical_count; // was unsigned1 
		string3  liens_recent_unreleased_count; // was unsigned1 
		string3  liens_historical_unreleased_count; // was unsigned1 
		string8  last_liens_unreleased_date; // was string8 
		string3  liens_recent_released_count; // was unsigned1 
		string3  liens_historical_released_count; // was unsigned1 
		string3  criminal_count; // was unsigned1 
		string8  last_criminal_date; // was unsigned4 
		string3  felony_count; // was unsigned1 
		string8  last_felony_date; // was unsigned4 
		string1  foreclosure_flag; // was boolean
		string8  last_foreclosure_date;
		
		/* Relatives */
		string3  relative_count; // was unsigned1 
		string3  relative_bankrupt_count; // was unsigned1 
		string3  relative_criminal_count; // was unsigned1 
		string3  relative_criminal_total; // was unsigned1 
		string3  criminal_relative_within25miles; // was unsigned1 
		string3  criminal_relative_within100miles; // was unsigned1 
		string3  criminal_relative_within500miles; // was unsigned1 
		string3  criminal_relative_withinOther; // was unsigned1 
		string3  relatives_property_count; // was unsigned1 
		string3  relatives_property_total; // was unsigned1 
		string3  relatives_property_purchase_count; // was unsigned1 
		string13 relatives_property_assessed_total; // was unsigned5 
		string3  relative_within25miles_count; // was unsigned1 
		string3  relative_within100miles_count; // was unsigned1 
		string3  relative_within500miles_count; // was unsigned1 
		string3  relative_withinOther_count; // was unsigned1 
		string3  relative_incomeUnder25_count; // was unsigned1 
		string3  relative_incomeUnder50_count; // was unsigned1 
		string3  relative_incomeUnder75_count; // was unsigned1 
		string3  relative_incomeUnder100_count; // was unsigned1 
		string3  relative_incomeOver100_count; // was unsigned1 
		string3  relative_homeUnder50_count; // was unsigned1 
		string3  relative_homeUnder100_count; // was unsigned1 
		string3  relative_homeUnder150_count; // was unsigned1 
		string3  relative_homeUnder200_count; // was unsigned1 
		string3  relative_homeUnder300_count; // was unsigned1 
		string3  relative_homeUnder500_count; // was unsigned1 
		string3  relative_educationUnder8_count; // was unsigned1 
		string3  relative_educationUnder12_count; // was unsigned1 
		string3  relative_educationOver12_count; // was unsigned1 
		string3  relative_vehicle_owned_count; // was unsigned1 
		string3  relatives_at_input_address; // was unsigned1 
		
		/* Vehicles */
		string3  vehicle_current_count; // was unsigned1 
		string3  vehicle_historical_count; // was unsigned1 

		/* Watercraft */
		string3  watercraft_count; // was unsigned1 

		/* American Student */
		string1  income_level_code;

		/* Professional License */
		string1  professional_license_flag; // was boolean 
		string60 professional_license_type;

		/* Scores, RC's & Pre-Calc's */
		string3 fd3_score;
		string3 fd6_score;
		string3 fp_score;
		string2 fp_reason1;
		string2 fp_reason2;
		string2 fp_reason3;
		string2 fp_reason4;
		string2 fp_reason5;
		string2 fp_reason6;
		string1 wealth_indicator;
		string8 inferred_dob; // was unsigned4 
		string1 mobility_indicator;
	END;


END;

