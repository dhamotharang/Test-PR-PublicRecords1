IMPORT BatchShare, DriversV2_Services, LN_PropertyV2_Services, Property, Relationship, VehicleV2, VehicleV2_Services, VotersV2_Services;

EXPORT Layouts := MODULE

	EXPORT inputRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 clientid;
		STRING100 name_full;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		BatchShare.Layouts.ShareAddress;
		STRING4 tax_year;
		STRING2 tax_state;
	END;

	EXPORT workRecSlim:=RECORD
		BatchShare.Layouts.ShareAcct;
		STRING20 clientid;
		STRING20 link_clientid;
		BatchShare.Layouts.ShareDid;
		UNSIGNED2 score;
		inputRec AND NOT [acctno,clientid];
		STRING20 orig_acctno;
		STRING20 orig_clientid;
		Batchshare.Layouts.ShareErrors;
		STRING12 exception_code;
	END;

	EXPORT bestRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		BatchShare.Layouts.SharePhone;
		BatchShare.Layouts.ShareAddress;
		UNSIGNED1 age;
		STRING1 conf_flag;
		STRING9 ssn_masked;
		STRING8 dob_masked;
	END;

	EXPORT deceasedRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		STRING8 DOD;
		STRING2 state;
		STRING3 source;
		STRING8 filedate;
		STRING1 vorp_code;
		STRING30 matchcode;
		STRING9 ssn_masked;
		STRING8 dob_masked;
	END;

	// PROPERTIES

	EXPORT coreSlim:=RECORD
		LN_PropertyV2_Services.layouts.fid.ln_fares_id;
		LN_PropertyV2_Services.layouts.core.fid_type;
		LN_PropertyV2_Services.layouts.core.fid_type_desc;
		LN_PropertyV2_Services.layouts.core.sortby_date;
		LN_PropertyV2_Services.layouts.core.vendor_source_flag;
		LN_PropertyV2_Services.layouts.core.vendor_source_desc;
	END;

	EXPORT deedSlim:=RECORD
		coreSlim;
		LN_PropertyV2_Services.layouts.deeds.filing_info.narrow;
		LN_PropertyV2_Services.keys.deed().fips_code;
		LN_PropertyV2_Services.keys.deed().fares_unformatted_apn;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.property_full_street_address;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.property_address_unit_number;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.property_address_citystatezip;
		LN_PropertyV2_Services.layouts.deeds.legal_info.narrow.contract_date;
		LN_PropertyV2_Services.layouts.deeds.legal_info.narrow.recording_date;
		LN_PropertyV2_Services.layouts.deeds.addl_fares_info.widest.fares_mortgage_date;
		BOOLEAN isBuyerBorrower;
	END;

	EXPORT assessmentSlim:=RECORD
		coreSlim;
		LN_PropertyV2_Services.layouts.assess.filing_info.narrow;
		LN_PropertyV2_Services.keys.assessor().fips_code;
		LN_PropertyV2_Services.keys.assessor().fares_unformatted_apn;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.mailing_full_street_address;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.mailing_unit_number;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.mailing_city_state_zip;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.property_full_street_address;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.property_unit_number;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.property_city_state_zip;
		LN_PropertyV2_Services.layouts.assess.sales_info.narrow.sale_date;
		LN_PropertyV2_Services.layouts.assess.legal_info.narrow.recording_date;
		LN_PropertyV2_Services.layouts.assess.legal_info.narrow.owner_occupied;
		LN_PropertyV2_Services.layouts.assess.legal_info.narrow.standardized_land_use_code;
		LN_PropertyV2_Services.layouts.assess.legal_info.narrow.standardized_land_use_desc;
		LN_PropertyV2_Services.layouts.assess.assessment_info.narrow.assessed_value_year;
		LN_PropertyV2_Services.layouts.assess.assessment_info.narrow.homestead_homeowner_exemption;
		LN_PropertyV2_Services.layouts.assess.tax_info.narrow.tax_year;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption1_code;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption1_desc;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption2_code;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption2_desc;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption3_code;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption3_desc;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption4_code;
		LN_PropertyV2_Services.layouts.assess.tax_info.widest.tax_exemption4_desc;
		BOOLEAN isAssessee;
	END;

	EXPORT entitySlim:=RECORD
		STRING12 did;
		LN_PropertyV2_Services.keys.search().fname;
		LN_PropertyV2_Services.keys.search().mname;
		LN_PropertyV2_Services.keys.search().lname;
		LN_PropertyV2_Services.keys.search().name_suffix;
		STRING12 bdid;
		LN_PropertyV2_Services.keys.search().cname;
	END;

	EXPORT partySlim:=RECORD
		LN_PropertyV2_Services.layouts.fid.ln_fares_id;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
		DATASET(entitySlim) entity;
	END;

	EXPORT deedsPartiesRec:=RECORD
		DATASET(deedSlim) deeds;
		DATASET(partySlim) parties;
	END;

	EXPORT assessmentsPartiesRec:=RECORD
		DATASET(assessmentSlim) assessments;
		DATASET(partySlim) parties;
	END;

	EXPORT addrSlim:=RECORD
		BatchShare.Layouts.ShareAddress AND NOT [addr,county_name];
	END;

	EXPORT addrMin:=RECORD
		addrSlim.prim_range;
		addrSlim.prim_name;
		addrSlim.sec_range;
		addrSlim.p_city_name;
		addrSlim.st;
		addrSlim.z5;
	END;

	EXPORT didRec:=RECORD
		UNSIGNED6 did;
		BOOLEAN isbdid:=FALSE;
	END;

	EXPORT propIdRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		STRING80 property_id;
		UNSIGNED2 property_rank;
		STRING8 sortby_date;
		workRecSlim.link_clientid;
		DATASET(didRec) dids;
		BatchShare.Layouts.ShareName;
		addrSlim;
		STRING2 inputTaxState;
		STRING4 inputTaxYear;
	END;

	EXPORT fidSrchRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		workRecSlim.link_clientid;
		LN_PropertyV2_Services.layouts.search_fid;
		propIdRec.inputTaxYear;
		propIdRec.inputTaxState;
		BatchShare.Layouts.ShareName;
		addrMin bestAddr;
		addrMin inputAddr;
	END;

	EXPORT hmstdYearRec:=RECORD
		STRING4 tax_year;
		STRING1  hmstdExmptn;
		STRING25 exmptn1;
		STRING25 exmptn2;
		STRING25 exmptn3;
		STRING25 exmptn4;
	END;

	EXPORT taxYearRec:=RECORD
		STRING4 tax_year;
	END;

	EXPORT propParentRec:=RECORD
		propIdRec;
		DATASET(hmstdYearRec) hmstdExmptns;
		BOOLEAN hasHmstdExmptn;
		INTEGER1 cntHmstdExmptns;
		STRING4 firstHmstdExmptn;
		STRING4 lastHmstdExmptn;
		DATASET(taxYearRec) seenDates;
		STRING4 firstSeen;
		STRING4 lastSeen;
		BOOLEAN isCurrentOwner;
		BOOLEAN isTaxYearOwner;
		BOOLEAN isBusinessOwned;
		BOOLEAN isBestAddress;
		BOOLEAN isInputAddress;
		BOOLEAN hasDeedRecords;
		BOOLEAN hasAssessments;
	END;

	EXPORT propDeedRec:=RECORD
		propParentRec;
		DATASET(deedsPartiesRec) deed_records;
	END;

	EXPORT propAssessmentRec:=RECORD
		propParentRec;
		DATASET(assessmentsPartiesRec) assessment_records;
	END;

	// FORECLOSURE

	EXPORT foreclosureRec:=RECORD
		Property.Layout_Foreclosure_In.foreclosure_id;
		Property.Layout_Foreclosure_In.deed_category;
		Property.Layout_Foreclosure_In.deed_desc;
		Property.Layout_Foreclosure_In.document_type;
		Property.Layout_Foreclosure_In.document_desc;
		Property.Layout_Foreclosure_In.recording_date;
		Property.Layout_Foreclosure_In.name1_first;
		Property.Layout_Foreclosure_In.name1_middle;
		Property.Layout_Foreclosure_In.name1_last;
		Property.Layout_Foreclosure_In.name1_suffix;
		Property.Layout_Foreclosure_In.name1_company;
		Property.Layout_Foreclosure_In.name2_first;
		Property.Layout_Foreclosure_In.name2_middle;
		Property.Layout_Foreclosure_In.name2_last;
		Property.Layout_Foreclosure_In.name2_suffix;
		Property.Layout_Foreclosure_In.name2_company;
	END;

	EXPORT propForeclosureRec:=RECORD
		propIdRec;
		DATASET(foreclosureRec) foreclosures;
	END;

	// ADDITIONAL PERSONS

	EXPORT addlPerRec:=RECORD
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		UNSIGNED3 dt_first_seen;
		UNSIGNED3 dt_last_seen;
	END;

	EXPORT propAddlPerRec:=RECORD
		propIdRec;
		DATASET(addlPerRec) additional_persons;
	END;

	// RELATIVES

	EXPORT relativeRec:=RECORD
		BOOLEAN hasAddrMatch:=FALSE;
		BatchShare.Layouts.ShareDid;
		Relationship.layout_output.titled.type;
		Relationship.layout_output.titled.confidence;
		Relationship.layout_output.titled.total_score;
		STRING20 title;
		BatchShare.Layouts.ShareName;
		addrSlim;
	END;

	EXPORT propRelativeRec:=RECORD
		propIdRec;
		DATASET(relativeRec) relatives;
	END;

	// VEHICLES

	EXPORT vehRoyaltyRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		VehicleV2_Services.Layout_Report.DataSource;
		VehicleV2.Layout_Base_Main.Source_Code;
		VehicleV2_Services.Layout_Report_Vehicle.VIN;
	END;

	EXPORT registrantRec:=RECORD
		BOOLEAN isExpired:=FALSE;
		BOOLEAN hasNameMatch:=FALSE;
		BOOLEAN hasCurrAddrMatch:=FALSE;
		BOOLEAN hasPrevAddrMatch:=FALSE;
		BatchShare.Layouts.ShareDid;
		VehicleV2_Services.Layout_vehicle_party_out.layout_standard_name;
		VehicleV2_Services.Layout_vehicle_party_out.layout_standard_address;
		VehicleV2.Layout_Base_Party.Reg_Latest_Effective_Date;
		VehicleV2.Layout_Base_Party.Reg_Latest_Expiration_Date;
	END;

	EXPORT vehicleRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BOOLEAN isCurrent:=FALSE;
		BOOLEAN hasCurrAddrMatch:=FALSE;
		BOOLEAN hasPrevAddrMatch:=FALSE;
		VehicleV2_Services.Layout_Report.DataSource;
		VehicleV2_Services.Layout_Report.NonDMVSource;
		VehicleV2.Layout_Base_Main.Source_Code;
		VehicleV2.Layout_Base_Main.State_Origin;
		VehicleV2_Services.Layout_Report_Vehicle.VIN;
		VehicleV2_Services.Layout_Report_Vehicle.model_year;
		VehicleV2_Services.Layout_Report_Vehicle.make_desc;
		VehicleV2_Services.Layout_Report_Vehicle.model_desc;
		VehicleV2_Services.Layout_Report_Vehicle.major_color_desc;
		DATASET(registrantRec) registrants;
	END;

	EXPORT propVehicleRec:=RECORD
		propIdRec;
		DATASET(vehicleRec) vehicles;
	END;

	// DRIVERS

	EXPORT driverRec:=RECORD
		BOOLEAN isCurrent:=FALSE;
		BOOLEAN isExpired:=FALSE;
		BOOLEAN hasCurrAddrMatch:=FALSE;
		BOOLEAN hasPrevAddrMatch:=FALSE;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress AND NOT [addr,county_name];
		DriversV2_Services.layouts.result_narrow.dl_number;
		DriversV2_Services.layouts.result_narrow.orig_state;
		DriversV2_Services.layouts.result_narrow.lic_issue_date;
		DriversV2_Services.layouts.result_narrow.expiration_date;
		DriversV2_Services.layouts.result_narrow.source_code;
		DriversV2_Services.layouts.result_narrow.nonDMVsource;
		DriversV2_Services.layouts.result_narrow.dt_first_seen;
		DriversV2_Services.layouts.result_narrow.dt_last_seen;
	END;

	EXPORT propDriverRec:=RECORD
		propIdRec;
		DATASET(driverRec) drivers;
	END;

	// VOTERS

	EXPORT voterRec:=RECORD
		BOOLEAN hasAddrMatch:=FALSE;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress AND NOT [addr,county_name];
		VotersV2_Services.layouts.Voter.vtid;
		VotersV2_Services.layouts.Voter.source_state;
		VotersV2_Services.layouts.Voter.active_status;
		VotersV2_Services.layouts.Voter.RegDate;
		VotersV2_Services.layouts.Voter.LastDateVote;
		VotersV2_Services.layouts.Voter.politicalparty_exp;
	END;

	EXPORT propVoterRec:=RECORD
		propIdRec;
		DATASET(voterRec) voters;
	END;

	// PROPERTY

	EXPORT propertyRec:=RECORD
		propParentRec;
		DATASET(deedsPartiesRec) deed_records;
		DATASET(assessmentsPartiesRec) assessment_records;
		DATASET(foreclosureRec) foreclosure_records;
		DATASET(addlPerRec) additional_person_records;
		DATASET(relativeRec) relative_records;
		DATASET(vehicleRec) vehicle_records;
		DATASET(driverRec) driver_records;
		DATASET(voterRec) voter_records;
	END;

	// END PROPERTIES

	EXPORT inputNotOwnerRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		addrSlim;
	END;

	EXPORT ownershipRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		LN_PropertyV2_Services.layouts.fid.ln_fares_id;
		UNSIGNED6 owner_did;
		UNSIGNED6 owner_bdid;
		BatchShare.Layouts.ShareName;
		STRING120 company_name;
		LN_PropertyV2_Services.layouts.assess.sales_info.narrow.sale_date;
		LN_PropertyV2_Services.layouts.deeds.legal_info.narrow.contract_date;
		BOOLEAN isCurrentOwner;
	END;

	EXPORT workRec:=RECORD
		workRecSlim;
		DATASET(bestRec) Best_Records;
		DATASET(deceasedRec) Deceased_Records;
		ownershipRec Ownership_Record;
		DATASET(propertyRec) Property_Records;
	END;

	// BATCH OUT

	EXPORT ownerOutRec:=RECORD
		STRING20  acctno;
		STRING20  clientid;
		UNSIGNED6 lexid;
		UNSIGNED2 lexid_score;
		STRING1   exception; // blank WHEN error code = 0 ELSE 'Y'
		STRING12  exception_code; // 'NL', 'LS', 'ID', 'MI'
		// Populate WHEN not exact match for full input name
		STRING20  best_first_name;
		STRING20  best_middle_name;
		STRING20  best_last_name;
		STRING5   best_suffix;
		STRING9   best_ssn; // Populate WHEN not match input OR blank input
		STRING8   best_dob; // Populate WHEN not match input YYYYMM OR blank input
		STRING10  best_phone;
		UNSIGNED1 calculated_age; // Use best DOB else input DOB
		STRING80  best_address;
		STRING25  best_city;
		STRING2   best_state;
		STRING5   best_zip;
		STRING1   best_address_confidence; // conf_flag
		// Populate WHEN match code includes 'N' (name match) AND DOB YYYY matches best DOB or input DOB
		STRING8   deceased_date_of_death;
		STRING8   deceased_dob;
		STRING20  deceased_first_name;
		STRING20  deceased_middle_name;
		STRING20  deceased_last_name;
		STRING20  deceased_suffix;
		STRING9   deceased_ssn;
		STRING2   deceased_state;
		STRING3   deceased_source;
		STRING8   death_confirmed;	// vorp_code 'V' = 'Verified', 'P' = 'Proof'
		// Populate WHEN input property is not currently owned
		UNSIGNED6 input_addr_owner_1_lexid;
		UNSIGNED6 input_addr_owner_1_bdid;
		STRING20  input_addr_owner_1_first_name;
		STRING20  input_addr_owner_1_middle_name;
		STRING20  input_addr_owner_1_last_name;
		STRING5   input_addr_owner_1_suffix;
		STRING120 input_addr_owner_1_company_name;
		STRING8   input_addr_sale_date;
		STRING8   input_addr_contract_date;
		STRING1   input_subject_still_owner;
		STRING2   driver_state;
		STRING2   voter_reg_state;
		STRING4   voter_reg_last_vote_year;
	END;

	EXPORT propertyOutRec:=RECORD
		UNSIGNED2 property_rank; // property_rank DIV 10
		// COMMON FIELDS IN DEEDS AND ASSESSMENTS
		// Populate with most recent Deed record information
		// ELSE most recent Assessment record information
		// WHERE tax year is less than or equal to input TaxYear
		STRING20  batch_owner_1_first_name;
		STRING20  batch_owner_1_middle_name;
		STRING20  batch_owner_1_last_name;
		STRING5   batch_owner_1_suffix;
		STRING120 batch_owner_1_company_name;
		STRING20  batch_owner_2_first_name;
		STRING20  batch_owner_2_middle_name;
		STRING20  batch_owner_2_last_name;
		STRING5   batch_owner_2_suffix;
		STRING120 batch_owner_2_company_name;
		STRING20  batch_owner_3_first_name;
		STRING20  batch_owner_3_middle_name;
		STRING20  batch_owner_3_last_name;
		STRING5   batch_owner_3_suffix;
		STRING120 batch_owner_3_company_name;
		STRING20  batch_owner_4_first_name;
		STRING20  batch_owner_4_middle_name;
		STRING20  batch_owner_4_last_name;
		STRING5   batch_owner_4_suffix;
		STRING120 batch_owner_4_company_name;
		STRING110 batch_full_property_address;
		STRING80  batch_address;
		STRING25  batch_city;
		STRING2   batch_state;
		STRING10  batch_zip;
		STRING18  batch_county;
		STRING5   batch_fips_code;
		STRING45  batch_parcel_number;
		// Populate with most recent Deed record information
		// WHEN multiple recent records are found, prefer vendor 'B'
		// WHERE tax year is less than or equal to input TaxYear
		// AND names WHERE party types are ['Buyer', 'Borrower']
		STRING20  deed_owner_1_first_name;
		STRING20  deed_owner_1_middle_name;
		STRING20  deed_owner_1_last_name;
		STRING5   deed_owner_1_suffix;
		STRING120 deed_owner_1_company_name;
		STRING20  deed_owner_2_first_name;
		STRING20  deed_owner_2_middle_name;
		STRING20  deed_owner_2_last_name;
		STRING5   deed_owner_2_suffix;
		STRING120 deed_owner_2_company_name;
		STRING20  deed_owner_3_first_name;
		STRING20  deed_owner_3_middle_name;
		STRING20  deed_owner_3_last_name;
		STRING5   deed_owner_3_suffix;
		STRING120 deed_owner_3_company_name;
		STRING20  deed_owner_4_first_name;
		STRING20  deed_owner_4_middle_name;
		STRING20  deed_owner_4_last_name;
		STRING5   deed_owner_4_suffix;
		STRING120 deed_owner_4_company_name;
		STRING110 deed_full_property_address;
		STRING80  deed_address;
		STRING25  deed_city;
		STRING2   deed_state;
		STRING10  deed_zip;
		STRING18  deed_county;
		STRING5   deed_fips_code;
		STRING45  deed_parcel_number;
		STRING8   deed_contract_date;
		STRING8   deed_recording_date;
		STRING8   deed_mortgage_date;
		// Populate with most recent Assessment record information
		// WHEN multiple recent records are found, prefer vendor 'B'
		// WHERE tax year is less than or equal to input TaxYear
		// AND names WHERE party type is 'Assessee'
		STRING20  assessment_owner_1_first_name;
		STRING20  assessment_owner_1_middle_name;
		STRING20  assessment_owner_1_last_name;
		STRING5   assessment_owner_1_suffix;
		STRING120 assessment_owner_1_company_name;
		STRING20  assessment_owner_2_first_name;
		STRING20  assessment_owner_2_middle_name;
		STRING20  assessment_owner_2_last_name;
		STRING5   assessment_owner_2_suffix;
		STRING120 assessment_owner_2_company_name;
		STRING20  assessment_owner_3_first_name;
		STRING20  assessment_owner_3_middle_name;
		STRING20  assessment_owner_3_last_name;
		STRING5   assessment_owner_3_suffix;
		STRING120 assessment_owner_3_company_name;
		STRING20  assessment_owner_4_first_name;
		STRING20  assessment_owner_4_middle_name;
		STRING20  assessment_owner_4_last_name;
		STRING5   assessment_owner_4_suffix;
		STRING120 assessment_owner_4_company_name;
		STRING110 assessment_full_mailing_address;
		STRING110 assessment_full_property_address;
		STRING80  assessment_address;
		STRING25  assessment_city;
		STRING2   assessment_state;
		STRING10  assessment_zip;
		STRING18  assessment_county;
		STRING5   assessment_fips_code;
		STRING45  assessment_parcel_number;
		STRING8   assessment_recording_date;
		STRING8   assessment_sale_date;
		STRING1   assessment_owner_occupied;
		STRING3   assessment_land_usage;
		STRING4   assessment_tax_year;
		STRING1   assess_homestead_exemption_flag;
		STRING25  assess_tax_exemption1_desc;
		STRING25  assess_tax_exemption2_desc;
		STRING25  assess_tax_exemption3_desc;
		STRING25  assess_tax_exemption4_desc;
		STRING1   homestead_exemption_claimed;
		// 'A' if has Assessment records plus 'D' if has Deed records
		STRING2   record_type;
		STRING1   possible_business_owned;
		STRING1   best_address_addr_match; // Best address matches property address
		INTEGER   count_hmstd_exmptn_years; // Less than or equal to input TaxYear
		STRING4   most_recent_hmstd_exmptn_year; // Less than or equal to input TaxYear
		// Populate WHEN Foreclosure records are found
		STRING20  foreclosure_buyer_1_first_name;
		STRING20  foreclosure_buyer_1_middle_name;
		STRING20  foreclosure_buyer_1_last_name;
		STRING5   foreclosure_buyer_1_suffix;
		STRING120 foreclosure_buyer_1_company_name;
		STRING20  foreclosure_buyer_2_first_name;
		STRING20  foreclosure_buyer_2_middle_name;
		STRING20  foreclosure_buyer_2_last_name;
		STRING5   foreclosure_buyer_2_suffix;
		STRING120 foreclosure_buyer_2_company_name;
		STRING8   foreclosure_recording_date;
		// Populate with top two Additional Person information by last seen date
		UNSIGNED6 addlperson_1_lexid;
		STRING20  addlperson_1_first_name;
		STRING20  addlperson_1_middle_name;
		STRING20  addlperson_1_last_name;
		STRING5   addlperson_1_suffix;
		STRING8   addlperson_1_firstseen;
		STRING8   addlperson_1_lastseen;
		UNSIGNED6 addlperson_2_lexid;
		STRING20  addlperson_2_first_name;
		STRING20  addlperson_2_middle_name;
		STRING20  addlperson_2_last_name;
		STRING20  addlperson_2_suffix;
		STRING8   addlperson_2_firstseen;
		STRING8   addlperson_2_lastseen;
		// Populate WHEN record(s) hasAddrMatch
		STRING1   relative_addr_match;
		// Populate WHEN record(s) isCurrent AND NOT isExpired AND hasNameMatch AND hasAddrMatch
		STRING7   vehicle_reg_addr_match;
		INTEGER   vehicle_reg_count;
		// Populate WHEN record isCurrent AND NOT isExpired AND hasAddrMatch
		STRING7   driver_addr_match;
		// Populate WHEN most recent Voter record by latest vote date hasAddrMatch
		STRING7   voter_reg_addr_match;
	END;

	EXPORT batchWorkPropRec:=RECORD
		BatchShare.Layouts.ShareAcct;
		propertyOutRec;
	END;

	EXPORT batchWorkRec:=RECORD
		ownerOutRec;
		DATASET(batchWorkPropRec) property_records;
	END;

	EXPORT batchOutRec:=RECORD
		ownerOutRec;
		BatchShare.MAC_ExpandLayout.Generate(propertyOutRec,'',HomesteadExemptionV2_Services.Constants.MAX_PROPERTIES,FALSE,'_');
	END;

END;
