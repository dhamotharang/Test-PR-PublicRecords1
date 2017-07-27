import Autokey_batch,Address,CLIA;

export CLIA_Layouts  := MODULE

	EXPORT std_batch_in := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster;
		String15 CLIANumber;
	END;

	EXPORT batch_in := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Autokey_batch.Layouts.rec_inBatchMaster.comp_name;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		String15 CLIANumber;
		Autokey_batch.Layouts.rec_inBatchMaster.bdid;
	END;

	EXPORT batch_out := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Autokey_batch.Layouts.rec_inBatchMaster.seq;
		string10 clia_number;
		unsigned6 did;
		unsigned6 bdid;
		unsigned1 bdid_score;
		string2 term_code;
		string75 term_code_desc;
		string75 certificate_type;
		string8 expiration_date;
		string1 record_type;
		string50 lab_type;
		string75 facility_name;
		string75 facility_name2;
		string55 address1;
		string55 address2;
		string30 city;
		string2 state;
		string5 zip;
		string4 zip4;
		string10 facility_phone;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned8 raw_aid;
		unsigned8 ace_aid;
		string10   clean_company_address_prim_range		; // [1..10]
	  string2    clean_company_address_predir				;	// [11..12]
	  string28   clean_company_address_prim_name			;	// [13..40]
	  string4    clean_company_address_addr_suffix		; // [41..44]
	  string2    clean_company_address_postdir				;	// [45..46]
	  string10   clean_company_address_unit_desig		;	// [47..56]
	  string8    clean_company_address_sec_range			;	// [57..64]
	  string25   clean_company_address_p_city_name		;	// [65..89]
	  string25   clean_company_address_v_city_name		; // [90..114]
	  string2    clean_company_address_st						;	// [115..116]
	  string5    clean_company_address_zip						;	// [117..121]
	  string4    clean_company_address_zip4					;	// [122..125]
	  string4    clean_company_address_cart					;	// [126..129]
	  string1    clean_company_address_cr_sort_sz		;	// [130]
	  string4    clean_company_address_lot						;	// [131..134]
	  string1    clean_company_address_lot_order			;	// [135]
	  string2    clean_company_address_dbpc					;	// [136..137]
	  string1    clean_company_address_chk_digit			;	// [138]
	  string2    clean_company_address_rec_type			;	// [139..140]
	  string2    clean_company_address_fips_state		;	// [141..142]
	  string3    clean_company_address_fips_county		;	// [143..145]
	  string10   clean_company_address_geo_lat				;	// [146..155]
	  string11   clean_company_address_geo_long			;	// [156..166]
	  string4    clean_company_address_msa						;	// [167..170]
	  string7    clean_company_address_geo_blk				;	// [171..177]
	  string1    clean_company_address_geo_match			;	// [178]
	  string4    clean_company_address_err_stat			;	// [179..182]
    STRING10   clean_phones_phone;
	END;

	EXPORT batch_out_penalty := RECORD
		batch_out;
		unsigned record_penalty := 0;
		Autokey_batch.Layouts.rec_inBatchMaster.comp_name;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		String15 CLIANumber;
		UNSIGNED6 _bdid			:= 0;
	END;
end;