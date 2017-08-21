EXPORT Layout_MBS_Finance := module

export update_ := record

string			HHID;
string			HouseholdName;
string			VCID;
string			subaccount_id;
string			gc_id;
string			acct_name;
string			platform;
string			Banko_MN;
string			vertical;
string			market;
string			sub_market;
string			industry;
string			use;
string			primary_market_code;
string			secondary_market_code;
string			industry_code_1;
string			industry_code_2;
string			create_date;
string			NB_status;
string			Region;
string			Team2;
string			mgr_name;
string			Team;
string			pri_rep_name;
string			pri_territory;
string			sec_rep_name;
string			cust_id;
string			cust_name;
string			city_name;
string			state_cd;
string			postal_cd;

end;


export old_ := record

string			HHID;
string			HouseholdName;
string			sub_acct_id;
string			gc_id;
string			acct_name;
string			attention_line;
string			platform;
string			Banko_MN;
string			vertical;
string			market;
string			sub_market;
string			industry;
string			use;
string			primary_market_code;
string			secondary_market_code;
string			industry_code_1;
string			industry_code_2;
string			create_date;
string			NB_status;
string			Region;
string			Team2;
string			mgr_name;
string			Team;
string			pri_rep_name;
string			pri_territory;
string			sec_rep_name;
string			cust_id;
string			cust_name;
string			city_name;
string			state_cd;
string			postal_cd;

end;

export common := record

old_;
string company_id_finance;
string co_cd;
string hash_company_id_finance;
string product_id;
string billing_id_finance;

end;

end;