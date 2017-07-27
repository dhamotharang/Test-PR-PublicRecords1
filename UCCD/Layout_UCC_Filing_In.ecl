export Layout_UCC_Filing_In := record
string50  ucc_key;
string2   ucc_vendor;
string2   ucc_state_origin;
string8   ucc_process_date;
//
string1   processing_rule;
//
string32  ucc_filing_num;
string8   ucc_filing_date;
string4   ucc_filing_time;
string8   ucc_filing_type_cd;
string60  ucc_filing_type_desc;
//
string1   ucc_trans_type;
string8   ucc_trans_date;
//
string8   ucc_last_changed_date;
//
string8   ucc_eff_date;
string4   ucc_eff_time;
string8   ucc_exp_date;
string4   ucc_exp_time;
string8   ucc_term_date;
string4   ucc_term_time;
string8   ucc_life;
string8   ucc_life_units_cd;
string30  ucc_life_units_desc;
//
string8   ucc_filing_count;
string8   ucc_document_count;
string8   ucc_secured_count;
string8   ucc_debtor_count;
string8   ucc_collateral_count;
string20  ucc_collateral_amt;
//
string8   ucc_status_cd;
string60  ucc_status_desc;
string8   ucc_status_date;
string8   ucc_status_sub_cd;
string60  ucc_status_sub_desc;
string8   ucc_status_sub_date;
//
string1   ucc_continued_flag;
string1   ucc_amended_flag;
string1   ucc_corrected_flag;
string1   ucc_assigned_flag;
//
string512 ucc_desc;
end;

/*
ucc_key	UCC key to link records (ucc_vendor + ucc_filing_num)
ucc_vendor	Filing state FIPS code
ucc_state_origin	Filing state code
ucc_process_date	Vendor extract date
	PROCESSING RULE
processing_rule	Identifier to determine if relationship exists between events & party and events & collateral. ('V' if yes, <blank> if no.)
	FILING INFORMATION
ucc_filing_num	Uniform Commercial Code (UCC) state Identifier for the filing
ucc_filing_date	Original filing date
ucc_filing_time	Original filing time
ucc_filing_type_cd	Base filing type (code) (e.g. Lien, UCC)
ucc_filing_type_desc	Base filing type (description)
ucc_trans_type	Type of transaction: 'C'reate, 'R'eplace, 'U'pdate, 'D'elete or <blank>
ucc_trans_date	Transaction date
ucc_last_changed_date	Last change date
ucc_eff_date	Filing effective date
ucc_eff_time	Filing effective time
ucc_exp_date	Expiration date
ucc_exp_time	Expiration time
ucc_term_date	Termination date
ucc_term_time	Termination time
ucc_life	Life expectancy
ucc_life_units_cd	Life expectancy units (code)
ucc_life_units_desc	Life expectancy units (description)
	FILING COUNTS
ucc_filing_count	Number of filings
ucc_document_count	Number of documents
ucc_secured_count	Number of secured parties
ucc_debtor_count	Number of debtors
ucc_collateral_count	Number of collaterals
	COLLATERAL AMOUNT
ucc_collateral_amt	Amount of collateral
	FILING STATUS
ucc_status_cd	Filing status (code)
ucc_status_desc	Filing status (description)
ucc_status_date	Filing status change date
ucc_status_sub_cd	Filing sub status (code)
ucc_status_sub_desc	Filing sub status (description)
ucc_status_sub_date	Filing sub status change date
	UCC FLAGS
ucc_continued_flag	Flag indicating continuation: 'Y'es or <blank>
ucc_amended_flag	Flag indicating amendment: 'Y'es or <blank>
ucc_corrected_flag	Flag indicating correction: 'Y'es or <blank>
ucc_assigned_flag	Flag indicating assignment: 'Y'es or <blank>
	UCC DESCRIPTION
ucc_desc	Description of UCC
*/