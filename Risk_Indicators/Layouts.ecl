import /* models, */ header, didville, Risk_Indicators, iesp;

export Layouts := module

export AddressSicCode := record
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  addr_suffix;
	string2  postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2  state;
	string5  zip;
	string4  zip4;
	string8  sic_code;
	string2 source;
end;

export SicLookup := record

	string8		sic_code				;
	string80	sic_description	;
	string1		lf							;

end;

export layout_watchlists := record
	STRING60 Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10 Watchlist_Record_Number;
	STRING20 Watchlist_fname;
	STRING20 Watchlist_lname;
	STRING65 Watchlist_address;
	// parsed watchlist address
	STRING10 WatchlistPrimRange;
	STRING2  WatchlistPreDir;
	STRING28 WatchlistPrimName;
	STRING4  WatchlistAddrSuffix;
	STRING2  WatchlistPostDir;
	STRING10 WatchlistUnitDesignation;
	STRING8  WatchlistSecRange;
	STRING25 Watchlist_city;
	STRING2 Watchlist_state;
	STRING5 Watchlist_zip;
	STRING30 Watchlist_contry;
	STRING200 Watchlist_Entity_Name;
end;

export layout_watchlists_plus_seq := record
	unsigned1 seq := 0;
	layout_watchlists;
end;

// some places they're called High risk indicators, others they are called reason codes.  need to add a sequence number to both ways
export layout_desc_plus_seq := record
	unsigned1 seq := 0;
	risk_indicators.Layout_Desc;
end;	

export layout_reason_codes_plus_seq := record
	unsigned1 seq := 0;
	// models.Layout_Reason_Codes;
	STRING3 Reason_Code;
	STRING Reason_Description;
end;	

shared Layout_Accident := RECORD
	unsigned1 num_accidents;
	unsigned dmgamtaccidents;
	unsigned datelastaccident;
	unsigned dmgamtlastaccident;
	unsigned1 numaccidents30;
	unsigned1 numaccidents90;
	unsigned1 numaccidents180;
	unsigned1 numaccidents12;
	unsigned1 numaccidents24;
	unsigned1 numaccidents36;
	unsigned1 numaccidents60;
end;

export Layout_Accident_Data := RECORD
	Layout_accident acc;
	Layout_accident atfault;
	Layout_accident atfaultda;
END;


shared Layout_Liens_Info := RECORD
	unsigned1 count;
	unsigned4 earliest_filing_date;
	unsigned4 most_recent_filing_date;
	unsigned total_amount;
END;

export Layout_Liens := RECORD
	Layout_Liens_Info liens_unreleased_civil_judgment;
	Layout_Liens_Info liens_released_civil_judgment;
	Layout_Liens_Info liens_unreleased_federal_tax;
	Layout_Liens_Info liens_released_federal_tax;
	Layout_Liens_Info liens_unreleased_foreclosure;
	Layout_Liens_Info liens_released_foreclosure;
	Layout_Liens_Info liens_unreleased_landlord_tenant;
	Layout_Liens_Info liens_released_landlord_tenant;
	Layout_Liens_Info liens_unreleased_lispendens;
	Layout_Liens_Info liens_released_lispendens;
	Layout_Liens_Info liens_unreleased_other_lj;
	Layout_Liens_Info liens_released_other_lj;
	Layout_Liens_Info liens_unreleased_other_tax;
	Layout_Liens_Info liens_released_other_tax;
	Layout_Liens_Info liens_unreleased_small_claims;
	Layout_Liens_Info liens_released_small_claims;
	Layout_Liens_Info liens_unreleased_suits;  // new for shell 5.0
	Layout_Liens_Info liens_released_suits; // new for shell 5.0
	unsigned  liens_unrel_total_amount84;
	unsigned  liens_unrel_total_amount;
	unsigned  liens_rel_total_amount84;
	unsigned  liens_rel_total_amount;
end;


export Layout_Recent_Property_Sales := RECORD
	unsigned sale_price1;
	unsigned sale_date1;	
	unsigned prev_purch_price1;
	unsigned prev_purch_date1;
	unsigned sale_price2;
	unsigned sale_date2;
	unsigned prev_purch_price2;
	unsigned prev_purch_date2;
END;


export Layout_Gong_DID := RECORD
	string8 gong_adl_dt_first_seen_full;
	string8 gong_adl_dt_last_seen_full;
	unsigned2 gong_did_phone_ct;
	unsigned2 gong_did_addr_ct;
	unsigned2 gong_did_first_ct;
	unsigned2 gong_did_last_ct;	
END;


Export layout_address_informationv2 := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	UNSIGNED4 unit_count;
	decimal5_2 geo12_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 fips_fc_index;
	UNSIGNED1 source_count;
	string50 sources;
	BOOLEAN credit_sourced;
	BOOLEAN eda_sourced;
	BOOLEAN dl_sourced;
	BOOLEAN voter_sourced;
	BOOLEAN utility_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	BOOLEAN family_sale_found;
	BOOLEAN family_buy_found;
	BOOLEAN applicant_sale_found;
	BOOLEAN applicant_buy_found;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5   mortgage_type;	
	string4   type_financing;	
	string8   first_td_due_date;	
	UNSIGNED4 assessed_amount;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string standardized_land_use_code;
	unsigned building_area ;
	unsigned no_of_buildings ;
	unsigned no_of_stories ;
	unsigned no_of_rooms ;
	unsigned no_of_bedrooms ;
	unsigned no_of_baths;
	unsigned no_of_partial_baths ;
	string garage_type_code;
	unsigned parking_no_of_cars;
	string style_code;
	string4	assessed_value_year;
	BOOLEAN HR_Address;
	STRING100 HR_Company;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 city_name ;
	string2  st ;
	string5  zip5 ;
	string3 county;
	string7 geo_blk;
	Layout_Census;
END;

Export layout_address_informationv3 := RECORD
	// same as v2 but with standardized_land_use_code, garage_type_code and style_code set to fixed lengths
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	UNSIGNED4 unit_count;
	decimal5_2 geo12_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 fips_fc_index;
	UNSIGNED1 source_count;
	string50 sources;
	BOOLEAN credit_sourced;
	BOOLEAN eda_sourced;
	BOOLEAN dl_sourced;
	BOOLEAN voter_sourced;
	BOOLEAN utility_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	BOOLEAN family_sold;
	BOOLEAN applicant_sold;
	BOOLEAN family_sale_found;
	BOOLEAN family_buy_found;
	BOOLEAN applicant_sale_found;
	BOOLEAN applicant_buy_found;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5   mortgage_type;	
	string4   type_financing;	
	string8   first_td_due_date;	
	UNSIGNED4 assessed_amount;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	unsigned building_area ;
	unsigned no_of_buildings ;
	unsigned no_of_stories ;
	unsigned no_of_rooms ;
	unsigned no_of_bedrooms ;
	unsigned no_of_baths;
	unsigned no_of_partial_baths ;
	string3 garage_type_code;
	unsigned parking_no_of_cars;
	string5 style_code;
	string4	assessed_value_year;
	BOOLEAN HR_Address;
	STRING100 HR_Company;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string4  addr_suffix ;
	string2  postdir ;
	string10 unit_desig ;
	string8  sec_range ;
	string25 city_name ;
	string2  st ;
	string5  zip5 ;
	string3 county;
	string7 geo_blk;
	STRING10 lat := '';
	STRING11 long := '';
	Layout_Census;
END;


EXPORT layout_PropertyRecordv2 := RECORD
	Layout_Boca_Shell_ids;
	Layout_Address_Informationv3;
	string12 own_fares_id;
	STRING1 AD;
	string1	datasrce;
END;

export Layout_Relat_Propv2 := RECORD
	STRING1 AD;
	boolean isrelat;
	Layout_Boca_Shell_ids.seq;
	Layout_Boca_Shell_ids.did;
	STRING1   property_status_applicant;			// Clealy owned='O', clearly sold='S', ambiguous='A', None=' '
	STRING1   property_status_family;					// same as for applicant
	UNSIGNED1 property_count;
	UNSIGNED1 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
	Layout_Address_Informationv2;
	boolean census_loose;
	STRING1 dataSrce;
END;

export Layout_Relat_Prop_Plusv2 := RECORD
	Layout_Relat_Propv2;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	Layout_Recent_Property_Sales;
END;

export Layout_Relat_Prop_Plusv4 := RECORD
	STRING1 AD;
	boolean isrelat;
	Layout_Boca_Shell_ids.seq;
	Layout_Boca_Shell_ids.did;
	STRING1   property_status_applicant;			// Clealy owned='O', clearly sold='S', ambiguous='A', None=' '
	STRING1   property_status_family;					// same as for applicant
	UNSIGNED1 property_count;
	UNSIGNED1 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
	Layout_Address_Informationv3;
	boolean census_loose;
	STRING1 dataSrce;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	Layout_Recent_Property_Sales;
END;

//MS-158: new property record layout that includes the business address indicator from ADVO
export Layout_Relat_Prop_Plus_BusInd := RECORD	
	Layout_Relat_Prop_Plusv4;
	string1 Residential_or_Business_Ind;			
	unsigned3 historydate;
END;

export Layout_Infutor := RECORD
	unsigned4 infutor_date_first_seen;
	unsigned4 infutor_date_last_seen;
	unsigned1 infutor_nap;
END;


export Layout_Impulse := RECORD
	unsigned2 count;
	unsigned4 first_seen_date;
	unsigned4 last_seen_date;
	string50 siteid;
	unsigned2 count30;
	unsigned2 count90;
	unsigned2 count180;
	unsigned2 count12;
	unsigned2 count24;
	unsigned2 count36;
	unsigned2 count60;
	unsigned5 annual_income;
	integer   count12_6mos;
	integer   count12_12mos;
	integer   count12_24mos;
END;

export Layout_Utility := RECORD
	qstring50  utili_adl_type; 
	qstring150 utili_adl_dt_first_seen;
	unsigned1 utili_adl_count;
	string8   utili_adl_earliest_dt_first_seen;
	unsigned1 utili_adl_nap;
	qstring50  utili_addr1_type; 
	qstring150 utili_addr1_dt_first_seen;
	unsigned1 utili_addr1_nap;
	qstring50  utili_addr2_type; 
	qstring150 utili_addr2_dt_first_seen;
	unsigned1 utili_addr2_nap;
END;


export Layout_Estimated_Income := RECORD
	unsigned min_income_20;
	unsigned min_income_40;
	unsigned min_income_60;
	unsigned min_income_80;
END;

export Layout_DOB_Match_Options := RECORD	
	string15 DOBMatch ;
	unsigned1 DOBMatchYearRadius ;
END;

export layout_pii_on_file := record
	qstring100 ssns_on_file := ''; 
	qstring100 dobs_on_file := '';
	qstring1200 streets_on_file := ''; 
	qstring120 phones_on_file := ''; 
	
	qstring100 ssns_on_file_created12months := ''; 
	qstring100 dobs_on_file_created12months := '';
	qstring1200 streets_on_file_created12months := ''; 
	qstring120 phones_on_file_created12months := ''; 
	
	unsigned2 ssn_name_source_count := 0;
	unsigned2 ssn_addr_source_count := 0;
	unsigned2 addr_name_source_count := 0;
	unsigned2 phone_addr_source_count := 0;
	unsigned2 phone_lname_source_count := 0;
	qstring1200 lnames_on_file := ''; 	
	
	//these fields added in BS 5.3 and are based off of converted source code versus the raw source code
	string50   corrssnname_sources := '';
	qstring200 corrssnname_firstseen := '';
	qstring200 corrssnname_lastseen := '';
	string100	 corrssnname_source_cnt := '';
	string50   corrssnaddr_sources := '';
	qstring200 corrssnaddr_firstseen := '';
	qstring200 corrssnaddr_lastseen := '';
	string100	 corrssnaddr_source_cnt := '';
	string50   corraddrname_sources := '';
	qstring200 corraddrname_firstseen := '';
	qstring200 corraddrname_lastseen := '';
	string100	 corraddrname_source_cnt := '';
	string50   corraddrphone_sources := '';
	qstring200 corraddrphone_firstseen := '';
	qstring200 corraddrphone_lastseen := '';
	string100	 corraddrphone_source_cnt := '';
	string50   corrphonelastname_sources := '';
	qstring200 corrphonelastname_firstseen := '';
	qstring200 corrphonelastname_lastseen := '';
	string100	 corrphonelastname_source_cnt := '';
	string50   corrnamedob_sources := '';
	qstring200 corrnamedob_firstseen := '';
	qstring200 corrnamedob_lastseen := '';
	string100	 corrnamedob_source_cnt := '';
	string50   corraddrdob_sources := '';
	qstring200 corraddrdob_firstseen := '';
	qstring200 corraddrdob_lastseen := '';
	string100	 corraddrdob_source_cnt := '';
	string50   corrssndob_sources := '';
	qstring200 corrssndob_firstseen := '';
	qstring200 corrssndob_lastseen := '';
	string100	 corrssndob_source_cnt := '';
	string50   corrssnphone_sources := '';
	qstring200 corrssnphone_firstseen := '';
	qstring200 corrssnphone_lastseen := '';
	string100	 corrssnphone_source_cnt := '';
	string50   corrdobphone_sources := '';
	qstring200 corrdobphone_firstseen := '';
	qstring200 corrdobphone_lastseen := '';
	string100	 corrdobphone_source_cnt := '';
end;

export header_verification_summary := record
	qstring100 ver_sources := '';
	qstring100 ver_sources_NAS := '';  
	qstring200 ver_sources_first_seen_date := '';
	qstring200 ver_sources_max_first_seen_date := '';
	qstring200 ver_sources_last_seen_date := '';
	qstring100 ver_sources_recordcount := '';
	
	qstring100 ver_fname_sources := '';
	qstring200 ver_fname_sources_first_seen_date := '';
	qstring100 ver_fname_sources_recordcount := '';
	
	qstring100 ver_lname_sources := '';
	qstring200 ver_lname_sources_first_seen_date := '';
	qstring100 ver_lname_sources_recordcount := '';
	
	qstring100 ver_addr_sources := '';
	qstring200 ver_addr_sources_first_seen_date := '';
	qstring100 ver_addr_sources_recordcount := '';
	
	qstring100 ver_ssn_sources := '';
	qstring200 ver_ssn_sources_first_seen_date := '';
	qstring100 ver_ssn_sources_recordcount := '';
		
	qstring100 ver_dob_sources := '';
	qstring200 ver_dob_sources_first_seen_date := '';
	qstring100 ver_dob_sources_recordcount := '';
	
	// storing this internally for fraud velocity counters in shell version 5
	layout_pii_on_file;
	
	// no longer reported by Bureau flags
	boolean EQ_did_nlr := false;
	boolean EN_did_nlr := false;
	boolean TN_did_nlr := false;
	
	boolean EQ_ssn_nlr := false;
	boolean EN_ssn_nlr := false;
	boolean TN_ssn_nlr := false;
	unsigned3 header_build_date;
end;

export advo_fields := record
	string1		Address_Vacancy_Indicator		;
	string1		Throw_Back_Indicator			;
	string1		Seasonal_Delivery_Indicator		;
	string1		DND_Indicator					;
	string1		College_Indicator				;
	string1		Drop_Indicator					;
	string1		Residential_or_Business_Ind		;
	string1		Mixed_Address_Usage				;
end;

export layout_counts := record
	unsigned2 CountTotal;
	unsigned2 CountDay;
	unsigned2 CountWeek;
	unsigned2 Count01;
	unsigned2 Count03;
	unsigned2 Count06;
	unsigned2 Count12;
	unsigned2 Count24;

	unsigned2 CBDCountTotal;
	unsigned2 CBDCount01;
end;

export layout_counts53 := record
	layout_counts;
	//these three new fields need to be integer as they want -1 returned in them if they are not computable
	integer Count12_6mos; 	
	integer Count12_12mos; 
	integer Count12_24mos; 
end;

export layout_inquiries := record
	string8 first_log_date;
	string8 last_log_date;
	integer2	Inquiry_addr_ver_ct;
	integer2 Inquiry_fname_ver_ct;
	integer2 Inquiry_lname_ver_ct;
	integer2 Inquiry_ssn_ver_ct;
	integer2 Inquiry_dob_ver_ct; 
	integer2 Inquiry_phone_ver_ct;
	integer2 Inquiry_email_ver_ct;
	layout_counts Inquiries;
	layout_counts53 Collection;
	layout_counts Auto;
	layout_counts Banking;
	layout_counts Mortgage;
	layout_counts53 HighRiskCredit;
	layout_counts Retail;
	layout_counts Communications;
	layout_counts - CBDCountTotal - CBDCount01 FraudSearches;
	layout_counts Other;
	layout_counts prepaidCards;  	// new for shell 5.0
	layout_counts QuizProvider;  	// new for shell 5.0
	layout_counts retailPayments;	// new for shell 5.0
	layout_counts StudentLoans;		// new for shell 5.0
	layout_counts Utilities;			// new for shell 5.0
	unsigned2 Inq_BillGroup_count;// new for shell 5.0
	unsigned2 Inq_BillGroup_count01;// new for shell 5.0
	unsigned2 Inq_BillGroup_count03;// new for shell 5.0
	unsigned2 Inq_BillGroup_count06;// new for shell 5.0
	unsigned2 Inq_BillGroup_count12;// new for shell 5.0
	unsigned2 Inq_BillGroup_count24;// new for shell 5.0
	
	// velocity counters per ADL
	unsigned2 inquiryPerADL := 0;
	unsigned2 inquirySSNsPerADL := 0;  
	unsigned2 inquiryAddrsPerADL := 0;
	unsigned2 inquiryLnamesPerADL := 0;
	unsigned2 inquiryFnamesPerADL := 0;
	unsigned2 inquiryPhonesPerADL := 0;
	unsigned2 inquiryDOBsPerADL := 0;
	
	unsigned2 unverifiedSSNsPerADL := 0;  
	unsigned2 unverifiedAddrsPerADL := 0;
	unsigned2 unverifiedPhonesPerADL := 0;
	unsigned2 unverifiedDOBsPerADL := 0;
	
	unsigned2 inquiryemailsperADL := 0;  // new for shell 5.0
	
	// velocity counters per SSN
	unsigned2 inquiryPerSSN := 0;
	unsigned2 inquiryADLsPerSSN := 0;
	unsigned2 inquiryLNamesPerSSN := 0;
	unsigned2 inquiryAddrsPerSSN := 0;
	unsigned2 inquiryDOBsPerSSN := 0;
	
	unsigned2 fraudSearchInquiryPerSSN := 0;
	unsigned2 fraudSearchInquiryPerSSNYear := 0;
	unsigned2 fraudSearchInquiryPerSSNMonth := 0;
	unsigned2 fraudSearchInquiryPerSSNWeek := 0;
	unsigned2 fraudSearchInquiryPerSSNDay := 0;
	
	// velocity counters per Addr
	unsigned2 inquiryPerAddr := 0;
	unsigned2 inquiryADLsPerAddr := 0;
	unsigned2 inquiryLNamesPerAddr := 0;
	unsigned2 inquirySSNsPerAddr := 0;

	unsigned2 fraudSearchInquiryPerAddr := 0;
	unsigned2 fraudSearchInquiryPerAddrYear := 0;
	unsigned2 fraudSearchInquiryPerAddrMonth := 0;
	unsigned2 fraudSearchInquiryPerAddrWeek := 0;
	unsigned2 fraudSearchInquiryPerAddrDay := 0;
	unsigned2 inquirySuspciousADLsperAddr := 0;
	
	// velocity counter per Phone
	unsigned2 inquiryPerPhone := 0;
	unsigned2 inquiryADLsPerPhone := 0;	
	
	unsigned2 fraudSearchInquiryPerPhone := 0;
	unsigned2 fraudSearchInquiryPerPhoneYear := 0;
	unsigned2 fraudSearchInquiryPerPhoneMonth := 0;
	unsigned2 fraudSearchInquiryPerPhoneWeek := 0;
	unsigned2 fraudSearchInquiryPerPhoneDay := 0;
	
	unsigned2 inquiryADLsPerEmail := 0;	// new for shell 5.0
	
	// banko fields
	string8 am_first_seen_date := '';
	string8 am_last_seen_date := '';
	
	string8 cm_first_seen_date := '';
	string8 cm_last_seen_date := '';
		
	string8 om_first_seen_date := '';
	string8 om_last_seen_date := '';
	
	// chargeback defender-specific fields
	string8 noncbd_first_log_date;
	string8 noncbd_last_log_date;
	string8 cbd_first_log_date;
	string8 cbd_last_log_date;
	
	unsigned2 cbd_inquiryAddrsPerADL  := 0;
	unsigned2 cbd_inquiryADLsPerAddr  := 0;
	unsigned2 cbd_inquiryPhonesPerADL := 0;
end;

export layout_employment := record
	qstring100 company_title;  // most recent company title
	unsigned4 First_seen_date := 0;  //(non-dead businesses)
	unsigned2 Business_ct := 0;  // number of different BDIDs worked for
	unsigned2 Dead_business_ct := 0;  // number of different BDIDs worked for that are dead
	unsigned2 Business_active_phone_ct := 0; // number of active business phones
	unsigned2 Source_ct	:= 0;  // number of different PAW sources appeared on
end;

export layout_business_header_summary := record
	integer bus_addr_match_cnt := 0;
	qstring100 bus_sources := '';
	qstring100 bus_sources_record_cnt :='';
	qstring200 bus_sources_first_seen_dates := '';
	integer bus_name_match := 0;
	integer bus_ssn_match := 0;
	integer bus_phone_match := 0;
end;

export layout_email := record
	integer email_ct := 0;
	integer email_domain_Free_ct := 0;
	integer email_domain_ISP_ct := 0;
	integer email_domain_EDU_ct := 0;
	integer email_domain_Corp_ct := 0;
	qstring50 email_source_list := '';
	qstring50 email_source_ct := '';
	qstring100 email_source_first_seen := '';
end;

export layout_address_risk := record
	unsigned2 occupants_1yr;
	unsigned2 turnover_1yr_in;
	unsigned2 turnover_1yr_out;
	
	unsigned2 N_Vacant_Properties;
	unsigned2	N_Business_Count;
	unsigned2 N_SFD_Count;
	unsigned2 N_MFD_Count;
	unsigned4 N_ave_building_age;
	unsigned4 N_ave_purchase_amount;
	unsigned4 N_ave_mortgage_amount;
	unsigned4 N_ave_assessed_amount;
	unsigned8 N_ave_building_area;
	unsigned8	N_ave_price_per_sf;
	unsigned8 N_ave_no_of_stories_count;
	unsigned8 N_ave_no_of_rooms_count;
	unsigned8 N_ave_no_of_bedrooms_count;
	unsigned8 N_ave_no_of_baths_count;
end;

export layout_address_history_summary := record
	boolean address_history_advo_college_hit := false;
	integer2 unique_addr_cnt := 1;
	integer2 avg_mo_per_addr := 0;
	integer2 addr_count2 := 0;
	integer2 addr_count3 := 0;
	integer2 addr_count6 := 0;
	integer2 addr_count10 := 0;
	integer2 lres_2mo_count := 0;
	integer2 lres_6mo_count := 0;
	integer2 lres_12mo_count := 0;
	integer2 hist_addr_match := 0;
	unsigned3 input_addr_first_seen := 0;
	unsigned3 input_addr_last_seen := 0;
	boolean address_history_college_evidence := false;
end;

// to be used for filtering bankruptcy data for the state of AZ
export layout_derogs_input := record
	boolean insurance_bk_filter := false;
	layout_boca_shell_ids;
	string8	archive_date_6mo;		//history date + 6 months
	string8	archive_date_12mo;	//history date + 1 year
	string8	archive_date_24mo;	//history date + 2 years
end;

export layout_HRI_Businesses := record
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	integer3  zip;
	integer2  zip4;
  string4   sic_code;
	unsigned3 dt_first_seen;
	string120	company_name;
	integer	phone;
	unsigned6	bdid;
	string2	source;
end;

export layout_header_plus_hist_date := record
	header.layout_header;
	unsigned3 historydate;
end;

export layout_input_plus_overrides := record
		risk_indicators.Layout_Input;
		risk_indicators.Layout_Overrides;
end;


export Layout_Addr_Flags := record	
	string1 dwelltype := '';
	string1 valid := '';
	string1 prisonAddr := '';
	string1 highRisk := '';
	string1 corpMil := '';
	string1 doNotDeliver := '';
	string1 deliveryStatus := '';
	string1 addressType := '';
	string1 dropIndicator := '';
end;

// creating new layout_addr_flags to help with transition of queries/libraries to this new layout
export Layout_Addr_Flags2 := record	
	string1 dwelltype := '';
	string1 valid := '';
	string1 prisonAddr := '';
	string1 highRisk := '';
	string1 corpMil := '';
	string1 doNotDeliver := '';
	string1 deliveryStatus := '';
	string1 addressType := '';
	string1 dropIndicator := '';
	unsigned4 unit_count := 0;  		// New for June 30th 2015 release
	string1 mail_usage := '';			// New for June 30th 2015 release
end;


export Layout_Neutral_DID_Service := record
		didville.Layout_Did_OutBatch;
		integer8 did_ct;
		BOOLEAN swappedNames := FALSE;
		string120 errmsg := '';  // hang onto error message if soapcall fails
end;

export Layout_iBehavior := record
	string8		Cnsmr_date_first_seen;
	string8		Cnsmr_date_last_seen;
	string8		First_Order_Date;
	string8		Last_Order_Date;
	string3		number_of_sources;
	string4		Average_Days_Between_Orders;
	string9		Average_Amount_Per_Order;
	string9		Total_Dollars;
	string4		Total_Number_of_Orders;
	string9		Offline_Average_Amount_Per_Order;
	string9		Offline_Dollars;
	string4		Offline_Orders;
	string9		Online_Average_Amount_Per_Order;
	string9		Online_Dollars;
	string4		Online_Orders;
	string9		Retail_Average_Amount_Per_Order;
	string9		Retail_Dollars;
	string4		Retail_Orders;
end;

shared Layout_HC_Sanc := record
	boolean Sanctions_Hit;

  unsigned2 sanc_OIG_LEIE;
  boolean sanc_GSA_EPLS;
  boolean Sanction_Black_Flag;
  boolean out_of_state_flag;

	unsigned2 sanc_os_current;
	unsigned2 sanc_os_NoDate;
	unsigned2 sanc_os_24;
	unsigned2 sanc_os_60;
	unsigned2 sanc_os_61;
	unsigned2 sanc_current;
	unsigned2 sanc_NoDate;
	unsigned2 sanc_24;
	unsigned2 sanc_60;
	unsigned2 sanc_61;

	unsigned2 sanc_f01_current;
	unsigned2 sanc_f02_current;
	unsigned2 sanc_f03_current;
	unsigned2 sanc_f04_current;
	unsigned2 sanc_f05_current;
	unsigned2 sanc_f06_current;
	unsigned2 sanc_f07_current;
	unsigned2 sanc_f08_current;
	unsigned2 sanc_f09_current;
	unsigned2 sanc_f10_current;
	unsigned2 sanc_f11_current;
	unsigned2 sanc_f12_current;
	unsigned2 sanc_f13_current;
	unsigned2 sanc_f14_current;
	unsigned2 sanc_f15_current;
	unsigned2 sanc_f16_current;
	unsigned2 sanc_f17_current;
	unsigned2 sanc_f18_current;
	unsigned2 sanc_f19_current;
	unsigned2 sanc_f20_current;
	unsigned2 sanc_f21_current;
	unsigned2 sanc_f22_current;
	unsigned2 sanc_f23_current;
	unsigned2 sanc_f24_current;
	unsigned2 sanc_f25_current;
	unsigned2 sanc_f26_current;
	unsigned2 sanc_blank_current;
	unsigned2 sanc_unknown_current;


	unsigned2 sanc_f01_24;
	unsigned2 sanc_f02_24;
	unsigned2 sanc_f03_24;
	unsigned2 sanc_f04_24;
	unsigned2 sanc_f05_24;
	unsigned2 sanc_f06_24;
	unsigned2 sanc_f07_24;
	unsigned2 sanc_f08_24;
	unsigned2 sanc_f09_24;
	unsigned2 sanc_f10_24;
	unsigned2 sanc_f11_24;
	unsigned2 sanc_f12_24;
	unsigned2 sanc_f13_24;
	unsigned2 sanc_f14_24;
	unsigned2 sanc_f15_24;
	unsigned2 sanc_f16_24;
	unsigned2 sanc_f17_24;
	unsigned2 sanc_f18_24;
	unsigned2 sanc_f19_24;
	unsigned2 sanc_f20_24;
	unsigned2 sanc_f21_24;
	unsigned2 sanc_f22_24;
	unsigned2 sanc_f23_24;
	unsigned2 sanc_f24_24;
	unsigned2 sanc_f25_24;
	unsigned2 sanc_f26_24;
	unsigned2 sanc_blank_24;
	unsigned2 sanc_unknown_24;


	unsigned2 sanc_f01_60;
	unsigned2 sanc_f02_60;
	unsigned2 sanc_f03_60;
	unsigned2 sanc_f04_60;
	unsigned2 sanc_f05_60;
	unsigned2 sanc_f06_60;
	unsigned2 sanc_f07_60;
	unsigned2 sanc_f08_60;
	unsigned2 sanc_f09_60;
	unsigned2 sanc_f10_60;
	unsigned2 sanc_f11_60;
	unsigned2 sanc_f12_60;
	unsigned2 sanc_f13_60;
	unsigned2 sanc_f14_60;
	unsigned2 sanc_f15_60;
	unsigned2 sanc_f16_60;
	unsigned2 sanc_f17_60;
	unsigned2 sanc_f18_60;
	unsigned2 sanc_f19_60;
	unsigned2 sanc_f20_60;
	unsigned2 sanc_f21_60;
	unsigned2 sanc_f22_60;
	unsigned2 sanc_f23_60;
	unsigned2 sanc_f24_60;
	unsigned2 sanc_f25_60;
	unsigned2 sanc_f26_60;
	unsigned2 sanc_blank_60;
	unsigned2 sanc_unknown_60;


	unsigned2 sanc_f01_61;
	unsigned2 sanc_f02_61;
	unsigned2 sanc_f03_61;
	unsigned2 sanc_f04_61;
	unsigned2 sanc_f05_61;
	unsigned2 sanc_f06_61;
	unsigned2 sanc_f07_61;
	unsigned2 sanc_f08_61;
	unsigned2 sanc_f09_61;
	unsigned2 sanc_f10_61;
	unsigned2 sanc_f11_61;
	unsigned2 sanc_f12_61;
	unsigned2 sanc_f13_61;
	unsigned2 sanc_f14_61;
	unsigned2 sanc_f15_61;
	unsigned2 sanc_f16_61;
	unsigned2 sanc_f17_61;
	unsigned2 sanc_f18_61;
	unsigned2 sanc_f19_61;
	unsigned2 sanc_f20_61;
	unsigned2 sanc_f21_61;
	unsigned2 sanc_f22_61;
	unsigned2 sanc_f23_61;
	unsigned2 sanc_f24_61;
	unsigned2 sanc_f25_61;
	unsigned2 sanc_f26_61;
	unsigned2 sanc_blank_61;
	unsigned2 sanc_unknown_61;
end;


shared Layout_HC_Prov := record
	boolean Provider_Hit;
	unsigned2 GSA_Provider_Old_Flag;
	unsigned2 GSA_Provider_Current_Flag;
	unsigned2 GSA_Prov_Recip_24_Curr;
	unsigned2 GSA_Prov_Recip_60_Curr;
	unsigned2 GSA_Prov_Recip_61_Curr;
	unsigned2 GSA_Prov_Proc_24_Curr;
	unsigned2 GSA_Prov_Proc_60_Curr;
	unsigned2 GSA_Prov_Proc_61_Curr;
	unsigned2 GSA_Prov_NonProc_24_Curr;
	unsigned2 GSA_Prov_NonProc_60_Curr;
	unsigned2 GSA_Prov_NonProc_61_Curr;
	unsigned2 GSA_Prov_Recip_24_Old;
	unsigned2 GSA_Prov_Recip_60_Old;
	unsigned2 GSA_Prov_Recip_61_Old;
	unsigned2 GSA_Prov_Proc_24_Old;
	unsigned2 GSA_Prov_Proc_60_Old;
	unsigned2 GSA_Prov_Proc_61_Old;
	unsigned2 GSA_Prov_NonProc_24_Old;
	unsigned2 GSA_Prov_NonProc_60_Old;
	unsigned2 GSA_Prov_NonProc_61_Old;
end;
shared Layout_HC_Lien := record
	boolean Liens_Hit;
	unsigned2 JGMT_Child_Support_Count_24;
	unsigned2 JGMT_Civil_Judgment_Count_24;
	unsigned2 JGMT_Forcible_Entry_Count_24;
	unsigned2 JGMT_Foreclosure_Count_24;
	unsigned2 JGMT_Judgment_Other_Count_24;
	unsigned2 JGMT_Landlord_Tenant_Count_24;
	unsigned2 JGMT_Lawsuit_Pending_Count_24;
	unsigned2 JGMT_Lien_Other_Count_24;
	unsigned2 JGMT_Small_Claims_Count_24;
	unsigned2 JGMT_Tax_Lien_Count_24;
	unsigned2 JGMT_Other_Count_24;

	unsigned2 JGMT_Child_Support_Count_60;
	unsigned2 JGMT_Civil_Judgment_Count_60;
	unsigned2 JGMT_Forcible_Entry_Count_60;
	unsigned2 JGMT_Foreclosure_Count_60;
	unsigned2 JGMT_Judgment_Other_Count_60;
	unsigned2 JGMT_Landlord_Tenant_Count_60;
	unsigned2 JGMT_Lawsuit_Pending_Count_60;
	unsigned2 JGMT_Lien_Other_Count_60;
	unsigned2 JGMT_Small_Claims_Count_60;
	unsigned2 JGMT_Tax_Lien_Count_60;
	unsigned2 JGMT_Other_Count_60;

	unsigned2 JGMT_Child_Support_Count_61;
	unsigned2 JGMT_Civil_Judgment_Count_61;
	unsigned2 JGMT_Forcible_Entry_Count_61;
	unsigned2 JGMT_Foreclosure_Count_61;
	unsigned2 JGMT_Judgment_Other_Count_61;
	unsigned2 JGMT_Landlord_Tenant_Count_61;
	unsigned2 JGMT_Lawsuit_Pending_Count_61;
	unsigned2 JGMT_Lien_Other_Count_61;
	unsigned2 JGMT_Small_Claims_Count_61;
	unsigned2 JGMT_Tax_Lien_Count_61;
	unsigned2 JGMT_Other_Count_61;

	unsigned2 JGMT_Child_Support_Count_ND;
	unsigned2 JGMT_Civil_Judgment_Count_ND;
	unsigned2 JGMT_Forcible_Entry_Count_ND;
	unsigned2 JGMT_Foreclosure_Count_ND;
	unsigned2 JGMT_Judgment_Other_Count_ND;
	unsigned2 JGMT_Landlord_Tenant_Count_ND;
	unsigned2 JGMT_Lawsuit_Pending_Count_ND;
	unsigned2 JGMT_Lien_Other_Count_ND;
	unsigned2 JGMT_Small_Claims_Count_ND;
	unsigned2 JGMT_Tax_Lien_Count_ND;
	unsigned2 JGMT_Other_Count_ND;

	unsigned2 JGMT_Flag_Count;
	unsigned2 JGMT_Eviction_Flag_Count;

	unsigned2 JGMT_Sum;
end;

shared Layout_HC_Crim := record
	boolean Crim_Flag;
  unsigned2 Crim_Flag_Cnt;
	unsigned2 WC_Count;
	unsigned2 WC_Misdemeanor_Count;
	unsigned2 WC_Felony_Count;
	unsigned2 WC_SexCrime_Count;

	// unsigned2 Felony_count;
	// unsigned2 Murder_count;
	// unsigned2 Assault_count;
	// unsigned2 Robbery_count;
	// unsigned2 Burg_count;
	// unsigned2 Theft_count;
	// unsigned2 Fraud_count;
	// unsigned2 Forgery_count;
	// unsigned2 Arrest_count;
	// unsigned2 Child_Abuse_count;
	// unsigned2 Sex_Crime_count;
	// unsigned2 Misdemeanor_count;
	// unsigned2 DWLS_count;
	// unsigned2 DUI_count;
	// unsigned2 Cont_Subst_count;
	// unsigned2 Weapon_count;
	// unsigned2 Harassment_count;
	// unsigned2 Prop_Dmg_count;
	// unsigned2 Traffic_count;
	// unsigned2 Disorderly_count;
	// unsigned2 Parking_count;
	// unsigned2 Bad_Check_count;
	// unsigned2 Trespassing_count;
	// unsigned2 Break_Enter_count;
	// unsigned2 Alcohol_count;
	// unsigned2 Res_Arrest_count;
	// unsigned2 Other_count;
	// unsigned2 Red_Misc_count;
	unsigned2 Felony_Count_24;
	unsigned2 Murder_Count_24;
	unsigned2 Assault_Count_24;
	unsigned2 Robbery_Count_24;
	unsigned2 Burg_Count_24;
	unsigned2 Theft_Count_24;
	unsigned2 Fraud_Count_24;
	unsigned2 Forgery_Count_24;
	unsigned2 Arrest_Count_24;
	unsigned2 Child_Abuse_Count_24;
	unsigned2 Sex_Crime_Count_24;
	unsigned2 Misdemeanor_Count_24;
	unsigned2 DWLS_Count_24;
	unsigned2 DUI_Count_24;
	unsigned2 Cont_Subst_Count_24;
	unsigned2 Weapon_Count_24;
	unsigned2 Harassment_Count_24;
	unsigned2 Prop_Dmg_Count_24;
	unsigned2 Traffic_Count_24;
	unsigned2 Disorderly_Count_24;
	unsigned2 Parking_Count_24;
	unsigned2 Bad_Check_Count_24;
	unsigned2 Trespassing_Count_24;
	unsigned2 Break_Enter_Count_24;
	unsigned2 Alcohol_Count_24;
	unsigned2 Res_Arrest_Count_24;
	unsigned2 Other_Count_24;
	unsigned2 Red_Misc_Count_24;

	unsigned2 Felony_Count_60;
	unsigned2 Murder_Count_60;
	unsigned2 Assault_Count_60;
	unsigned2 Robbery_Count_60;
	unsigned2 Burg_Count_60;
	unsigned2 Theft_Count_60;
	unsigned2 Fraud_Count_60;
	unsigned2 Forgery_Count_60;
	unsigned2 Arrest_Count_60;
	unsigned2 Child_Abuse_Count_60;
	unsigned2 Sex_Crime_Count_60;
	unsigned2 Misdemeanor_Count_60;
	unsigned2 DWLS_Count_60;
	unsigned2 DUI_Count_60;
	unsigned2 Cont_Subst_Count_60;
	unsigned2 Weapon_Count_60;
	unsigned2 Harassment_Count_60;
	unsigned2 Prop_Dmg_Count_60;
	unsigned2 Traffic_Count_60;
	unsigned2 Disorderly_Count_60;
	unsigned2 Parking_Count_60;
	unsigned2 Bad_Check_Count_60;
	unsigned2 Trespassing_Count_60;
	unsigned2 Break_Enter_Count_60;
	unsigned2 Alcohol_Count_60;
	unsigned2 Res_Arrest_Count_60;
	unsigned2 Other_Count_60;
	unsigned2 Red_Misc_Count_60;

	unsigned2 Felony_Count_61;
	unsigned2 Murder_Count_61;
	unsigned2 Assault_Count_61;
	unsigned2 Robbery_Count_61;
	unsigned2 Burg_Count_61;
	unsigned2 Theft_Count_61;
	unsigned2 Fraud_Count_61;
	unsigned2 Forgery_Count_61;
	unsigned2 Arrest_Count_61;
	unsigned2 Child_Abuse_Count_61;
	unsigned2 Sex_Crime_Count_61;
	unsigned2 Misdemeanor_Count_61;
	unsigned2 DWLS_Count_61;
	unsigned2 DUI_Count_61;
	unsigned2 Cont_Subst_Count_61;
	unsigned2 Weapon_Count_61;
	unsigned2 Harassment_Count_61;
	unsigned2 Prop_Dmg_Count_61;
	unsigned2 Traffic_Count_61;
	unsigned2 Disorderly_Count_61;
	unsigned2 Parking_Count_61;
	unsigned2 Bad_Check_Count_61;
	unsigned2 Trespassing_Count_61;
	unsigned2 Break_Enter_Count_61;
	unsigned2 Alcohol_Count_61;
	unsigned2 Res_Arrest_Count_61;
	unsigned2 Other_Count_61;
	unsigned2 Red_Misc_Count_61;

	unsigned2 Felony_Count_121;
	unsigned2 Murder_Count_121;
	unsigned2 Assault_Count_121;
	unsigned2 Robbery_Count_121;
	unsigned2 Burg_Count_121;
	unsigned2 Theft_Count_121;
	unsigned2 Fraud_Count_121;
	unsigned2 Forgery_Count_121;
	unsigned2 Arrest_Count_121;
	unsigned2 Child_Abuse_Count_121;
	unsigned2 Sex_Crime_Count_121;
	unsigned2 Misdemeanor_Count_121;
	unsigned2 DWLS_Count_121;
	unsigned2 DUI_Count_121;
	unsigned2 Cont_Subst_Count_121;
	unsigned2 Weapon_Count_121;
	unsigned2 Harassment_Count_121;
	unsigned2 Prop_Dmg_Count_121;
	unsigned2 Traffic_Count_121;
	unsigned2 Disorderly_Count_121;
	unsigned2 Parking_Count_121;
	unsigned2 Bad_Check_Count_121;
	unsigned2 Trespassing_Count_121;
	unsigned2 Break_Enter_Count_121;
	unsigned2 Alcohol_Count_121;
	unsigned2 Res_Arrest_Count_121;
	unsigned2 Other_Count_121;
	unsigned2 Red_Misc_Count_121;
END;
export Layout_HealthCare_Shell := record
	unsigned seq;

	boolean MedLicProfLic_hit;
  boolean MedLicProfLic_None := FALSE;
  boolean MedLicProfLic_Exp;
  boolean MedLicProfLic_Time;
  boolean MedLicProfLic_Same_State;
  boolean MedLicProfLic_Same_State_Exp;

	integer4 Overall_Year_Min := 9999;
	integer4 Time_On_PS;
  
	Layout_HC_Sanc Sanctions;
	Layout_HC_Sanc Bus_Sanctions;
	Layout_HC_Sanc RAN_Sanctions;

	Layout_HC_Prov Provider;
	Layout_HC_Prov Bus_Provider;
	Layout_HC_Prov CorpAffil_Provider;
	Layout_HC_Prov RAN_Provider;
	Layout_HC_Prov RAN_CorpAffil_Provider;

	Layout_HC_Lien Liens;

	Layout_HC_Crim Criminal;
	Layout_HC_Crim RAN_Criminal;
	
	boolean SexOffender_Hit;
	unsigned2 Sex_Offense_Count_Unk;  /* Offense and Date Must Be Present */
	unsigned2 Sex_Offense_Count_24;   /* 0-2 Years                        */
	unsigned2 Sex_Offense_Count_60;   /* 3-5 Years                        */
	unsigned2 Sex_Offense_Count_61;   /* 5+  Years                        */

	boolean PossibleIncarceration;
end;

export layout_fd_attributesv2 := record
	string2	IdentityRiskLevel	;
	string2	IDVerRiskLevel	;
	string2	IDVerAddressNotCurrent	;
	string2	SourceRiskLevel	;
	string2	VariationRiskLevel	;
	string3	VariationMSourcesSSNCount	;
	string3	VariationMSourcesSSNUnrelCount	;
	string3	VariationDOBCount	;
	string3	VariationDOBCountNew	;
	string2	SearchVelocityRiskLevel	;
	string3	SearchCountWeek	;
	string3	SearchCountDay	;
	string3	SearchUnverifiedSSNCountYear	;
	string3	SearchUnverifiedAddrCountYear	;
	string3	SearchUnverifiedDOBCountYear	;
	string3	SearchUnverifiedPhoneCountYear	;
	string3	SearchFraudSearchCount	;
	string3	SearchFraudSearchCountYear	;
	string3	SearchFraudSearchCountMonth	;
	string3	SearchFraudSearchCountWeek	;
	string3	SearchFraudSearchCountDay	;
	string3	SearchLocateSearchCountWeek	;
	string3	SearchLocateSearchCountDay	;
	string2	AssocRiskLevel	;
	string3	AssocSuspicousIdentitiesCount	;
	string3	AssocCreditBureauOnlyCount	;
	string3	AssocCreditBureauOnlyCountNew	;
	string3	AssocCreditBureauOnlyCountMonth	;
	string2	ValidationRiskLevel	;
	string2	CorrelationRiskLevel	;
	string3	CorrelationSSNNameCount	;
	string3	CorrelationSSNAddrCount	;
	string3	CorrelationAddrNameCount	;
	string3	CorrelationAddrPhoneCount	;
	string3	CorrelationPhoneLastNameCount	;
	string2	DivRiskLevel	;
	string3	DivSSNIdentityMSourceUrelCount	;
	string3	DivAddrSuspIdentityCountNew	;
	string3	DivSearchAddrSuspIdentityCount	;
	string2	SearchComponentRiskLevel	;
	string3	SearchSSNSearchCount	;
	string3	SearchSSNSearchCountMonth	;
	string3	SearchSSNSearchCountWeek	;
	string3	SearchSSNSearchCountDay	;
	string3	SearchAddrSearchCount	;
	string3	SearchAddrSearchCountMonth	;
	string3	SearchAddrSearchCountWeek	;
	string3	SearchAddrSearchCountDay	;
	string3	SearchPhoneSearchCount	;
	string3	SearchPhoneSearchCountMonth	;
	string3	SearchPhoneSearchCountWeek	;
	string3	SearchPhoneSearchCountDay	;
	string2	ComponentCharRiskLevel	;
	string2	InputAddrActivePhoneList	;
	string11	AddrChangeIncomeDiff	;
	string11	AddrChangeValueDiff	;
	string4	AddrChangeCrimeDiff	;
	string2	AddrChangeEconTrajectory	;
	string2	AddrChangeEconTrajectoryIndex	;
	string2	CurrAddrActivePhoneList	;
	string10	CurrAddrMedianIncome	;
	string10	CurrAddrMedianValue	;
	string3	CurrAddrMurderIndex	;
	string3	CurrAddrCarTheftIndex	;
	string3	CurrAddrBurglaryIndex	;
	string3	CurrAddrCrimeIndex	;
	string3	PrevAddrAgeOldest	;
	string3	PrevAddrLenOfRes	;
	string2	PrevAddrDwellType	;
	string2	PrevAddrStatus	;
	string2	PrevAddrOccupantOwned	;
	string10	PrevAddrMedianIncome	;
	string10	PrevAddrMedianValue	;
	string3	PrevAddrMurderIndex	;
	string3	PrevAddrCarTheftIndex	;
	string3	PrevAddrBurglaryIndex	;
	string3	PrevAddrCrimeIndex	;
end;

EXPORT inquiryVerification := RECORD
	UNSIGNED1 inquiryNAPfirstcount := 0; 
	UNSIGNED1 inquiryNAPlastcount := 0; 
	UNSIGNED1 inquiryNAPaddrcount := 0;  
	UNSIGNED1 inquiryNAPphonecount := 0; 
	UNSIGNED1 inquiryNAPssncount := 0;
	UNSIGNED1 inquiryNAPdobcount := 0;
	STRING10 InquiryNAPprim_range := '';
	STRING2  InquiryNAPpredir := '';
	STRING28 InquiryNAPprim_name := '';
	STRING4  InquiryNAPsuffix := '';
	STRING2  InquiryNAPpostdir := '';
	STRING10 InquiryNAPunit_desig := '';
	STRING8  InquiryNAPsec_range := '';
	STRING25 InquiryNAPcity := '';
	STRING2  InquiryNAPst := '';
	STRING5  InquiryNAPz5 := '';
	STRING30 InquiryNAPfname := '';
	STRING30 InquiryNAPlname := '';
	STRING9 InquiryNAPssn := '';
	STRING8 InquiryNAPdob := '';
	STRING10 InquiryNAPphone := '';
	UNSIGNED1 InquiryNAPaddrScore := 255;
	UNSIGNED1 InquiryNAPfnameScore := 255;
	UNSIGNED1 InquiryNAPlnameScore := 255;
	UNSIGNED1 InquiryNAPssnScore := 255;
	UNSIGNED1 InquiryNAPdobScore := 255;
	UNSIGNED1 InquiryNAPphoneScore := 255;
END;

export layout_reverse_email := record
	string2 verification_level := ''; // -1 through 8
	integer adls_per_email := 0;  // number of unique ADLs per email address
	qstring100 ver_sources := '';
	qstring200 ver_sources_first_seen_date := '';
	qstring200 ver_sources_last_seen_date := '';
	qstring100 ver_sources_recordcount := '';
	// qstring100 ver_sources_verification_level := '';  // they didn't want this anymore
end;

export layout_email_50 := record
	layout_email;
	string2 Identity_Email_Verification_Level := '';  // new field for 5.0
	layout_reverse_email reverse_email;  							// new section for 5.0
end;

export layout_hhid_summary := record
	unsigned6 hhid;
	unsigned1 hh_members_ct := 0;  //Total number of household members
	unsigned1 hh_property_owners_ct := 0;  //Total number of household members shown to own property
	unsigned1 hh_age_65_plus := 0;  //Total number of household members aged 65 and up
	unsigned1 hh_age_31_to_65 := 0;  //Total number of household members aged 30 to 65
	unsigned1 hh_age_18_to_30 := 0;  //Total number of household members aged 18 to 30
	unsigned1 hh_age_lt18 := 0;  //Total number of household members less than 18
	unsigned1 hh_collections_ct := 0;  //Total number of household members with collection inquiry activity
	unsigned1 hh_workers_paw := 0;  //Total number of household members with a People at Work record
	unsigned1 hh_payday_loan_users := 0;  //Total number of household members with payday loan activity on file (Impulse)
	unsigned1 hh_members_w_derog := 0;  //Total number of household members with derogatory public records
	unsigned1 hh_tot_derog := 0;  //Total number of derogatory public records for the entire household
	unsigned1 hh_bankruptcies := 0;  //Total number of household members with a bankruptcy on file
	unsigned1 hh_lienholders := 0;  //Total number of household members with any lien record
	unsigned1 hh_prof_license_holders := 0;  //Total number of household members with a professional license
	unsigned1 hh_criminals := 0;  //Total number of criminals in the household
	unsigned1 hh_college_attendees := 0;  //Total number of household members with evidence of college attendance
	// taken out June 5th after talking with Heather.  would need to run a full bocashell on each individual to get this, and she's not confident in the estimated income model anyway to make it worth the overhead
	// unsigned hh_estimated_inc := 0;  //Total estimated household income (calculated using household members aged 18-65)  
end;

export layout_insurance_phones_verification := record
	string2 Insurance_Phone_Verification;
	boolean insurance_phones_phone_hit;
	boolean insurance_phones_phonesearch_didmatch;
	boolean insurance_phones_did_hit;
	boolean insurance_phones_didsearch_phonematch;
end;


export layout_ingenix_summary := record
	unsigned provider_date_first_reported := 0;
	unsigned provider_date_last_reported := 0;
	unsigned provider_license_count := 0;
	unsigned provider_effective_date := 0;
	unsigned provider_termination_date := 0;
	
	boolean most_recent_license_revoked := false;
	string100 most_recent_speciality_type := '';
	string100 most_recent_speciality_name := '';
	unsigned unique_specialties_count := 0;
	boolean Medical_school_record_found := false;

	unsigned2 sanctions_count := 0;
	unsigned4 sanctions_date_first_seen := 0;
	unsigned4 sanctions_date_last_seen := 0;
	string50 most_recent_sanction_type := '';
end;

export layout_mari_summary := record
	unsigned4 date_first_seen;				
	unsigned4 date_last_seen;					
	unsigned1 number_of_licenses;  		
	string most_recent_license_type;	
	unsigned4 issue_date;
	unsigned4 expiration_date;
end;

export layout_address_sources_summary := record
	string100 input_addr_sources := '';
	string200 input_addr_sources_first_seen_date := '';
	string100 input_addr_sources_recordcount := '';
	
	string100 current_addr_sources := '';
	string200 current_addr_sources_first_seen_date := '';




	string100 current_addr_sources_recordcount := '';

	
	string100 previous_addr_sources := '';
	string200 previous_addr_sources_first_seen_date := '';
	string100 previous_addr_sources_recordcount := '';
end;

export layout_virtual_fraud := record
	integer1  hi_risk_ct := 0;
	integer1  lo_risk_ct := 0;
	integer1  LexID_phone_hi_risk_ct := 0;
	integer1  LexID_phone_lo_risk_ct := 0;
	integer1  AltLexID_Phone_hi_risk_ct := 0;
	integer1  AltLexID_Phone_lo_risk_ct := 0;
	integer1  LexID_addr_hi_risk_ct := 0;
	integer1  LexID_addr_lo_risk_ct := 0;
	integer1  AltLexID_addr_hi_risk_ct := 0;
	integer1  AltLexID_addr_lo_risk_ct := 0;
	integer1  LexID_ssn_hi_risk_ct := 0;
	integer1  LexID_ssn_lo_risk_ct := 0;
	integer1  AltLexID_ssn_hi_risk_ct := 0;


	integer1  AltLexID_ssn_lo_risk_ct := 0;


end;

export layout_contributory_fraud := RECORD
	unsigned3 cf_Lexid_count           := 0; 
	unsigned3 cf_ssn_count             := 0; 
	unsigned3 cf_phone_count           := 0; 
	unsigned3 cf_addr_count            := 0; 
	unsigned3 cf_Lexid_billgroup_count := 0; 
	unsigned3 cf_ssn_billgroup_count   := 0; 
	unsigned3 cf_phone_billgroup_count := 0; 
	unsigned3 cf_addr_billgroup_count  := 0; 
end;

export layout_test_fraud := RECORD
	unsigned3 tf_Lexid_count           := 0;
	unsigned3 tf_ssn_count             := 0;
	unsigned3 tf_phone_count           := 0;
	unsigned3 tf_addr_count            := 0;
	unsigned3 tf_Lexid_billgroup_count := 0;
	unsigned3 tf_ssn_billgroup_count   := 0;
	unsigned3 tf_phone_billgroup_count := 0;
	unsigned3 tf_addr_billgroup_count  := 0;
end;



export layout_trustdefender_in := RECORD
	unsigned seq;
	string255 sessionID;
	string255 OrgId;
	string255 ApiKey; 
	string50 Policy;
	string20 ApiType;
	string40 serviceType;
 end;
 
export layout_fp201_attributes := RECORD
	string2 IDVerAddressMatchesCurrent;
	string2 IDVerAddressVoter; 
	string2 IDVerAddressVehicleRegistration;
	string2 IDVerAddressDriversLicense;
	string2 IDVerDriversLicenseType;
	string2 IDVerSSNDriversLicense;
	string2 SourceVehicleRegistration;
	string2 SourceDriversLicense;
END;

export layout_pii_stability := record
	unsigned1	link_candidate_cnt	;
	unsigned1	link_wgt_dob_npos_cnt	;
	unsigned1	link_wgt_fname_npos_cnt	;
	unsigned1	link_wgt_lname_npos_cnt	;
	unsigned1	link_wgt_phone_npos_cnt	;
	unsigned1	link_wgt_prim_name_npos_cnt	;
	unsigned1	link_wgt_prim_range_npos_cnt	;
	unsigned1	link_wgt_ssn4_npos_cnt	;
	unsigned1	link_wgt_ssn5_npos_cnt	;
	unsigned1	link_wgt_total_npos_cnt	;
	unsigned1	link_wgt_dob_nneg_cnt	;
	unsigned1	link_wgt_fname_nneg_cnt	;
	unsigned1	link_wgt_lname_nneg_cnt	;
	unsigned1	link_wgt_phone_nneg_cnt	;
	unsigned1	link_wgt_prim_name_nneg_cnt	;
	unsigned1	link_wgt_prim_range_nneg_cnt	;
	unsigned1	link_wgt_ssn4_nneg_cnt	;
	unsigned1	link_wgt_ssn5_nneg_cnt	;
	unsigned1	link_wgt_total_nneg_cnt	;
	unsigned1	link_wgt_dob_nzero_cnt	;
	unsigned1	link_wgt_fname_nzero_cnt	;
	unsigned1	link_wgt_lname_nzero_cnt	;
	unsigned1	link_wgt_phone_nzero_cnt	;
	unsigned1	link_wgt_prim_name_nzero_cnt	;
	unsigned1	link_wgt_prim_range_nzero_cnt	;
	unsigned1	link_wgt_ssn4_nzero_cnt	;
	unsigned1	link_wgt_ssn5_nzero_cnt	;
	unsigned1	link_wgt_total_nzero_cnt	;
	string15	link_max_weight_element	;
	string15	link_min_weight_element	;
end;

export shell52_inquiries_additions := record
	unsigned2	inq_peradl_count_day	;
	unsigned2	inq_peradl_count_week	;
	unsigned2	inq_peradl_count01	;
	unsigned2	inq_peradl_count03	;
	unsigned2	inq_peradl_count06	;
	unsigned2	inq_ssnsperadl_count_day	;
	unsigned2	inq_ssnsperadl_count_week	;
	unsigned2	inq_ssnsperadl_count01	;
	unsigned2	inq_ssnsperadl_count03	;
	unsigned2	inq_ssnsperadl_count06	;
	unsigned2	inq_addrsperadl_count_day	;
	unsigned2	inq_addrsperadl_count_week	;
	unsigned2	inq_addrsperadl_count01	;
	unsigned2	inq_addrsperadl_count03	;
	unsigned2	inq_addrsperadl_count06	;
	unsigned2	inq_lnamesperadl_count_day	;
	unsigned2	inq_lnamesperadl_count_week	;
	unsigned2	inq_lnamesperadl_count01	;
	unsigned2	inq_lnamesperadl_count03	;
	unsigned2	inq_lnamesperadl_count06	;
	unsigned2	inq_fnamesperadl_count_day	;
	unsigned2	inq_fnamesperadl_count_week	;
	unsigned2	inq_fnamesperadl_count01	;
	unsigned2	inq_fnamesperadl_count03	;
	unsigned2	inq_fnamesperadl_count06	;
	unsigned2	inq_phonesperadl_count_day	;
	unsigned2	inq_phonesperadl_count_week	;
	unsigned2	inq_phonesperadl_count01	;
	unsigned2	inq_phonesperadl_count03	;
	unsigned2	inq_phonesperadl_count06	;
	unsigned2	inq_dobsperadl_count_day	;
	unsigned2	inq_dobsperadl_count_week	;
	unsigned2	inq_dobsperadl_count01	;
	unsigned2	inq_dobsperadl_count03	;
	unsigned2	inq_dobsperadl_count06	;
	unsigned2	inq_perssn_count_day	;
	unsigned2	inq_perssn_count_week	;
	unsigned2	inq_perssn_count01	;
	unsigned2	inq_perssn_count03	;
	unsigned2	inq_perssn_count06	;
	unsigned2	inq_adlsperssn_count_day	;
	unsigned2	inq_adlsperssn_count_week	;
	unsigned2	inq_adlsperssn_count01	;
	unsigned2	inq_adlsperssn_count03	;
	unsigned2	inq_adlsperssn_count06	;
	unsigned2	inq_lnamesperssn_count_day	;
	unsigned2	inq_lnamesperssn_count_week	;
	unsigned2	inq_lnamesperssn_count01	;
	unsigned2	inq_lnamesperssn_count03	;
	unsigned2	inq_lnamesperssn_count06	;
	unsigned2	inq_addrsperssn_count_day	;
	unsigned2	inq_addrsperssn_count_week	;
	unsigned2	inq_addrsperssn_count01	;
	unsigned2	inq_addrsperssn_count03	;
	unsigned2	inq_addrsperssn_count06	;
	unsigned2	inq_dobsperssn_count_day	;
	unsigned2	inq_dobsperssn_count_week	;
	unsigned2	inq_dobsperssn_count01	;
	unsigned2	inq_dobsperssn_count03	;
	unsigned2	inq_dobsperssn_count06	;
	unsigned2	inq_peraddr_count_day	;
	unsigned2	inq_peraddr_count_week	;
	unsigned2	inq_peraddr_count01	;
	unsigned2	inq_peraddr_count03	;
	unsigned2	inq_peraddr_count06	;
	unsigned2	inq_adlsperaddr_count_day	;
	unsigned2	inq_adlsperaddr_count_week	;
	unsigned2	inq_adlsperaddr_count01	;
	unsigned2	inq_adlsperaddr_count03	;
	unsigned2	inq_adlsperaddr_count06	;
	unsigned2	inq_lnamesperaddr_count_day	;
	unsigned2	inq_lnamesperaddr_count_week	;
	unsigned2	inq_lnamesperaddr_count01	;
	unsigned2	inq_lnamesperaddr_count03	;
	unsigned2	inq_lnamesperaddr_count06	;
	unsigned2	inq_ssnsperaddr_count_day	;
	unsigned2	inq_ssnsperaddr_count_week	;
	unsigned2	inq_ssnsperaddr_count01	;
	unsigned2	inq_ssnsperaddr_count03	;
	unsigned2	inq_ssnsperaddr_count06	;
	unsigned2	inq_perphone_count_day	;
	unsigned2	inq_perphone_count_week	;
	unsigned2	inq_perphone_count01	;
	unsigned2	inq_perphone_count03	;
	unsigned2	inq_perphone_count06	;
	unsigned2	inq_adlsperphone_count_day	;
	unsigned2	inq_adlsperphone_count_week	;
	unsigned2	inq_adlsperphone_count01	;
	unsigned2	inq_adlsperphone_count03	;
	unsigned2	inq_adlsperphone_count06	;
	unsigned2	inq_emailsperadl_count_day	;
	unsigned2	inq_emailsperadl_count_week	;
	unsigned2	inq_emailsperadl_count01	;
	unsigned2	inq_emailsperadl_count03	;
	unsigned2	inq_emailsperadl_count06	;
	unsigned2	inq_adlsperemail_count_day	;
	unsigned2	inq_adlsperemail_count_week	;
	unsigned2	inq_adlsperemail_count01	;
	unsigned2	inq_adlsperemail_count03	;
	unsigned2	inq_adlsperemail_count06	;
end;

export layout_inquiries_52 := record
	layout_inquiries;
	shell52_inquiries_additions;
end;
export shell53_inquiries_additions := record
	//risk corroboration fields (MS-87)
	integer	inq_corrnameaddr	;
	integer	inq_corrnameaddr_adl	;
	integer	inq_corrnamessn	;
	integer	inq_corrnamessn_adl	;
	integer	inq_corrnamephone	;
	integer	inq_corrnamephone_adl	;
	integer	inq_corraddrssn	;
	integer	inq_corraddrssn_adl	;
	integer	inq_corrdobaddr	;
	integer	inq_corrdobaddr_adl	;
	integer	inq_corraddrphone	;
	integer	inq_corraddrphone_adl	;
	integer	inq_corrdobssn	;
	integer	inq_corrdobssn_adl	;
	integer	inq_corrphonessn	;
	integer	inq_corrphonessn_adl	;
	integer	inq_corrdobphone	;
	integer	inq_corrdobphone_adl	;
	integer	inq_corrnameaddrssn	;
	integer	inq_corrnameaddrssn_adl	;
	integer	inq_corrnamephonessn	;
	integer	inq_corrnamephonessn_adl	;
	integer	inq_corrnameaddrphnssn	;
	integer	inq_corrnameaddrphnssn_adl	;
	//PII tumblings - substitutions (MS-104)
	integer inq_ssnsperadl_1subs;
	integer inq_phnsperadl_1subs;
	integer inq_primrangesperadl_1subs;
	integer inq_dobsperadl_1subs;
	integer inq_fnamesperadl_1subs;
	integer inq_lnamesperadl_1subs;
	integer inq_dobsperadl_daysubs;
	integer inq_dobsperadl_mosubs;
	integer inq_dobsperadl_yrsubs;
	//PII tumblings - sequential manipulations (MS-105)
	integer inq_ssnsperadl_1dig;
	integer inq_phnsperadl_1dig;
	integer inq_primrangesperadl_1dig;
	integer inq_dobsperadl_1dig;
	integer inq_primrangesperssn_1dig;
	integer inq_dobsperssn_1dig;
	integer inq_ssnsperaddr_1dig;
end;

export layout_inquiries_53 := record
	layout_inquiries_52;
	shell53_inquiries_additions;
end;

export layout_riskview_alerts := record
	string4 Alert1;
	string4 Alert2;
	string4 Alert3;
	string4 Alert4;
	string4 Alert5;
	string4 Alert6;
	string4 Alert7;
	string4 Alert8;
	string4 Alert9;
	string4 Alert10;
end;

export layout_best_pii := record
	string20 fname;
	string20 lname;
	string10 phone;
	string9 ssn;
end;

export layout_best_pii_flags := record
	string2 input_fname_isbestmatch := '';
	string2 input_lname_isbestmatch := '';
	string2 input_phone_isbestmatch := '';
	string2 input_ssn_isbestmatch := '';
	string1 best_phone_phonetype := '';
	string1 best_phone_phoneval := '';
	string1 best_phone_phonezip := '';
	string1 curraddr_hriskaddrflag := '';
	string8 best_ssn_dod := '';
	string1 best_ssn_decsflag := '';
	string1 best_ssn_ssndobflag := '';
	string1 best_ssn_valid := '';
end;

export layout_best_pii_velocity := record
	unsigned2 adls_per_bestssn := 0;
	unsigned2 addrs_per_bestssn := 0;
	unsigned2 adls_per_curraddr_curr := 0;
	unsigned2 ssns_per_curraddr_curr := 0;
	unsigned2 phones_per_curraddr_curr := 0;
	unsigned2 adls_per_bestphone_curr := 0;
	unsigned2 adls_per_bestssn_c6 := 0;
	unsigned2 addrs_per_bestssn_c6 := 0;
	unsigned2 adls_per_curraddr_c6 := 0;
	unsigned2 ssns_per_curraddr_c6 := 0;
	unsigned2 phones_per_curraddr_c6 := 0;
	unsigned2 adls_per_bestphone_c6 := 0;
end;

export layout_best_pii_inquiries := record
	unsigned2 inq_perbestssn := 0;
	unsigned2 inq_adlsperbestssn := 0;
	unsigned2 inq_lnamesperbestssn := 0;
	unsigned2 inq_addrsperbestssn := 0;
	unsigned2 inq_dobsperbestssn := 0;
	unsigned2 inq_percurraddr := 0;
	unsigned2 inq_adlspercurraddr := 0;
	unsigned2 inq_lnamespercurraddr := 0;
	unsigned2 inq_ssnspercurraddr := 0;
	unsigned2 inq_perbestphone := 0;
	unsigned2 inq_adlsperbestphone := 0;
	unsigned2 inq_curraddr_ver_count := 0;
	unsigned2 inq_bestfname_ver_count := 0;
	unsigned2 inq_bestlname_ver_count := 0;
	unsigned2 inq_bestssn_ver_count := 0;
	unsigned2 inq_bestdob_ver_count := 0;
	unsigned2 inq_bestphone_ver_count	:= 0;
end;
	
export layout_best_info := record
	layout_best_pii;
	layout_best_pii_flags;
	layout_best_pii_velocity;
	layout_best_pii_inquiries;
end;

export common_layout := record
	string2 src;
	unsigned dt_first_seen;
	unsigned dt_last_seen;
	unsigned record_count;
end;

export tmp_Consumer_Statements := Record
	iesp.share_fcra.t_ConsumerStatement;
  string RecIdForStId := '';
end;

export tmp_ConsumerStatements := Record
	dataset(tmp_Consumer_Statements) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
end;

//MS-71: new BIP header fields
export layout_BIP_Header_info := record
	integer 	bus_seleids_peradl := 0;
	integer 	bus_gold_seleids_peradl := 0;
	integer 	bus_active_seleids_peradl := 0;
	integer 	bus_inactive_seleids_peradl := 0;
	integer 	bus_defunct_seleids_peradl := 0;
	integer 	bus_gold_seleid_first_seen := 0;
	integer 	bus_header_first_seen := 0;
	integer 	bus_header_last_seen := 0;
	integer 	bus_header_build_date := 0;
	integer 	bus_SOS_filings_peradl := 0;
	integer 	bus_active_SOS_filings_peradl := 0;
end;

//MS-167: new Equifax Fraud Flags fields
// export layout_Equifax_FraudFlags := record
	// integer 	factact_curr_active_duty := 0;
	// integer 	factact_curr_active_duty_fseen := 0;
	// integer 	factact_curr_fraud_alert := 0;
	// integer 	factact_curr_fraud_alert_fseen := 0;
	// integer 	factact_curr_alert_code := 0;
	// integer 	factact_hist_fraud_alert_ct := 0;
	// integer 	factact_hist_fraud_alert_lseen := 0;
// end;

END;