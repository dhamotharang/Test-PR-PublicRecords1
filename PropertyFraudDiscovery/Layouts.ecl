IMPORT BatchShare,LN_PropertyV2_Services;

EXPORT Layouts := MODULE

	EXPORT batch_in_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		STRING10 phone;
		BatchShare.Layouts.ShareAddress;
	END;

	EXPORT batch_in := RECORD
		batch_in_raw;
		STRING20 orig_acctno;
	END;

	EXPORT best_address := RECORD
		STRING100 best_addr1;
		STRING25  best_city;		
		STRING2   best_state;		
		STRING5   best_zip;
		STRING8   date_last_seen;		
	END;

	EXPORT relationship := RECORD
		UNSIGNED6 did;
		STRING20 title;
		STRING80 name;
		BOOLEAN is_business_affiliate;
	END;

	EXPORT batch_working := RECORD 
		batch_in;
		STRING9 best_ssn;
		STRING9 expanded_ssn;
		best_address;
		BOOLEAN has_foreclosure;
		DATASET(relationship) relationships;
	END;

	EXPORT batch_out := RECORD
		batch_in_raw;
		STRING99  best_addr1;
		STRING25  best_city;
		STRING2   best_state;
		STRING5   best_zip;
		STRING8   date_last_seen;
		UNSIGNED  score_code;
		STRING30  score_desc;
		BOOLEAN   subject_is_a_owner;
		BOOLEAN   subject_is_a_buyer;
		BOOLEAN   subject_is_a_seller;
		BOOLEAN   has_foreclosure;
		BOOLEAN   has_business_affiliate;
		BOOLEAN   has_HS_deed;
		BOOLEAN   has_MS_deed;
		BOOLEAN   has_same_trans;
		BOOLEAN   has_diff_trans;
		UNSIGNED6 did_diff_trans;
		UNSIGNED  num_owners_interval_1;
		UNSIGNED  num_buyers_interval_1;
		UNSIGNED  num_sellers_interval_1;
		UNSIGNED  max_entities_interval_1;
		UNSIGNED  num_owners_interval_2;
		UNSIGNED  num_buyers_interval_2;
		UNSIGNED  num_sellers_interval_2;
		UNSIGNED  max_entities_interval_2;
		UNSIGNED  duration_subject_ownership;
		INTEGER   interval_1_saleDiff_1;
		INTEGER   interval_1_saleDiff_2;
		INTEGER   interval_1_saleDiff_3;
		INTEGER   interval_1_saleDiff_4;
		INTEGER   interval_1_totalDiff;
		INTEGER   interval_2_saleDiff_1;
		INTEGER   interval_2_saleDiff_2;
		INTEGER   interval_2_saleDiff_3;
		INTEGER   interval_2_saleDiff_4;
		INTEGER   interval_2_totalDiff;
	END;

	// PROPERTIES

	EXPORT coreSlim := RECORD
		LN_PropertyV2_Services.layouts.fid.ln_fares_id;
		LN_PropertyV2_Services.layouts.core.fid_type;
		LN_PropertyV2_Services.layouts.core.fid_type_desc;
		LN_PropertyV2_Services.layouts.core.sortby_date;
		LN_PropertyV2_Services.layouts.core.vendor_source_flag;
		LN_PropertyV2_Services.layouts.core.vendor_source_desc;
		LN_PropertyV2_Services.layouts.core.current_record;
	END;

	EXPORT deedSlim := RECORD
		LN_PropertyV2_Services.layouts.deeds.legal_info.narrow;
		LN_PropertyV2_Services.layouts.deeds.sales_info.narrow;
		LN_PropertyV2_Services.layouts.deeds.mortgage_info.narrow;
		LN_PropertyV2_Services.layouts.deeds.addl_fares_info.widest.fares_mortgage_date;
		LN_PropertyV2_Services.layouts.deeds.addl_fares_info.wider.fares_mortgage_deed_type;
		LN_PropertyV2_Services.layouts.deeds.addl_fares_info.wider.fares_mortgage_deed_type_desc;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.buyer_or_borrower_ind;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.name1;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.name2;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.seller1;
		LN_PropertyV2_Services.layouts.baseParties.baseDeed.seller2;
	END;

	EXPORT assessmentSlim := RECORD
		LN_PropertyV2_Services.layouts.assess.filing_info.narrow;
		LN_PropertyV2_Services.layouts.assess.owner_info.wider;
		LN_PropertyV2_Services.layouts.assess.legal_info.widest.document_type;
		LN_PropertyV2_Services.layouts.assess.legal_info.widest.document_type_desc;
		LN_PropertyV2_Services.layouts.assess.tax_info.wider;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.assessee_name;
		LN_PropertyV2_Services.layouts.baseParties.baseAssess.second_assessee_name;
	END;

	EXPORT partySlim := RECORD
		LN_PropertyV2_Services.layouts.parties.pparty.party_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
		DATASET(LN_PropertyV2_Services.layouts.parties.entity) entity;
	END;

	EXPORT deedsPartiesRec := RECORD
		coreSlim;
		DATASET(deedSlim) deeds;
		DATASET(partySlim) parties;
	END;

	EXPORT assessmentsPartiesRec := RECORD
		coreSlim;
		DATASET(assessmentSlim) assessments;
		DATASET(partySlim) parties;
	END;

	// PARTY SUMMARY
	
	EXPORT didNameRec := RECORD
		UNSIGNED6 did;
		UNSIGNED6 seleid;
		STRING80 name;
	END;

	EXPORT didNameBoolRec := RECORD
		didNameRec;
		BOOLEAN is_subject;
		BOOLEAN is_relative;
	END;

	EXPORT dateDidNameRec := RECORD
		STRING8 date;
		didNameBoolRec;
	END;

	EXPORT entityRec := RECORD
		DATASET(dateDidNameRec) entities;
	END;

	// DEED SUMMARY

	EXPORT deedVndr := RECORD
		STRING1 vndrSrcFlg;
		DATASET(deedsPartiesRec) deedsParties;
	END;

	EXPORT sumSaleRec := RECORD
		UNSIGNED interval;
		STRING8 buy_date;
		INTEGER bought;
		STRING8 sell_date;
		INTEGER sold;
		INTEGER difference;
	END;

	EXPORT rollSaleRec := RECORD
		INTEGER seq;
		STRING8 date;
		INTEGER sales_price;
		STRING2 doc_type_cd;
		STRING50 doc_type_desc;
		STRING80 buyer;
		STRING80 seller;
		sumSaleRec;
	END;

	EXPORT sumDeedsRec := RECORD
		STRING12 ln_fares_id;
		STRING8 date;
		INTEGER sales_price;
		INTEGER loan_amt;
		BOOLEAN is_HS_deed;// Highly Suspicious Deed
	  BOOLEAN is_MS_deed;// Moderately Suspicious Deed
	  BOOLEAN is_noise_deed;// Don't use deed in summaries
		STRING2 doc_type_cd;
		STRING70 doc_type_desc;
		STRING2 mort_deed_type;
		STRING70 mort_deed_desc;
		STRING80 buyer;
		STRING80 seller;
		BOOLEAN is_same_trans;
		DATASET(didNameBoolRec) sellers;
		DATASET(didNameBoolRec) buyers;
	END;

	EXPORT sumDeedsVndrRec := RECORD
		STRING1 vndrSrcFlg;
		UNSIGNED num_prop_yrs;
		UNSIGNED interval_1_yrs;
		UNSIGNED interval_2_yrs;
		#IF(CONSTANTS.DEBUG_SALES_ROLLUP)
		DATASET(rollSaleRec) roll_Dedup;// DEBUG
		DATASET(rollSaleRec) roll_Recs1;// DEBUG
		DATASET(rollSaleRec) roll_Recs2;// DEBUG
		DATASET(rollSaleRec) roll_Sales_In;// DEBUG
		DATASET(rollSaleRec) roll_Sales_Out;// DEBUG
		#END
		UNSIGNED cnt_sales_summary;
		DATASET(sumSaleRec) sales_summary;
		BOOLEAN has_HS_deed;
	  BOOLEAN has_MS_deed;
		BOOLEAN has_same_trans;
		DATASET(sumDeedsRec) deed_summary;
		UNSIGNED num_buyers_interval_1;
		UNSIGNED num_buyers_interval_2;
		BOOLEAN subject_is_a_buyer;
		DATASET(dateDidNameRec) chronological_buyers;
		UNSIGNED num_sellers_interval_1;
		UNSIGNED num_sellers_interval_2;
		BOOLEAN subject_is_a_seller;
		DATASET(dateDidNameRec) chronological_sellers;
		BOOLEAN has_diff_trans;
		UNSIGNED6 did_diff_trans;
		STRING80 name_diff_trans;
		DATASET(dateDidNameRec) straw_sellers;
		DATASET(dateDidNameRec) straw_buyers;
		DATASET(dateDidNameRec) subject_seller;
		DATASET(dateDidNameRec) relative_buyer;
		DATASET(dateDidNameRec) relative_seller;
		DATASET(dateDidNameRec) subject_buyer;
	END;

	// ASSESSMENT SUMMARY

	EXPORT assessmentVndr := RECORD
		STRING1 vndrSrcFlg;
		DATASET(assessmentsPartiesRec) assessmentsParties;
	END;

	EXPORT sumAssessmentsRec := RECORD
		STRING12 ln_fares_id;
		STRING8 date;
		STRING4 tax_year;
		STRING13 tax_amount;
		STRING80 assessee;
		DATASET(didNameRec) assessees;
	END;

	EXPORT sumAssessmentsVndrRec := RECORD
		STRING1 vndrSrcFlg;
		UNSIGNED num_prop_yrs;
		UNSIGNED interval_1_yrs;
		UNSIGNED interval_2_yrs;
		UNSIGNED num_owners_interval_1;
		UNSIGNED num_owners_interval_2;
		UNSIGNED duration_subject_ownership;
		BOOLEAN  subject_is_a_owner;
		DATASET(dateDidNameRec) chronological_assessees;
		DATASET(sumAssessmentsRec) assessment_summary;
	END;

	EXPORT batch_working_prop := RECORD
		batch_working;
		DATASET(sumDeedsVndrRec) deed_summary_by_vendor;
		DATASET(sumAssessmentsVndrRec) assessment_summary_by_vendor;
		DATASET(deedVndr) deedVndrProperties;
		DATASET(assessmentVndr) assessorVndrProperties;
	END;

END;