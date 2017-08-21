EXPORT layouts := module

	export rLogs := RECORD
		string product_id;
		string sub_product_id;
		string gc_id;
		string company_id;
		string sub_acct_id;
		string vertical;
		string market;
		string sub_market;
		string industry;
		string use;
		string primary_market_code;
		string secondary_market_code;
		string industry_code_1;
		string industry_code_2;
		string disable_observation;
		string opt_out;
		string content;
		unsigned8 allowflags;
		string translation;
		string internal_flag;
		string mbs_company_name;
		string4 ranked_sic_code;
		integer1 exclude_from_access;
		string mask;
		integer1 priority_flag;
	END;
	
End;