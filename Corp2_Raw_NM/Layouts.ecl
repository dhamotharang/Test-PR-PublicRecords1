EXPORT Layouts := module

	export ImportMasterLayoutIn := Record
			string  id;
			string  corp_nmscc;
			string  corp_type;
			string  corp_stat;
			string  corp_name;
			string  corp_doi_date;
			string  corp_agent_name;
			string  corp_street1;
			string  corp_city;
			string  corp_state;
			string  corp_country;
			string  corp_zip;
	end;

	export ImportMasterLayoutBase := Record
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;
			string  	id;
			string  	corp_nmscc;
			string  	corp_type;
			string  	corp_stat;
			string  	corp_name;
			string  	corp_doi_date;
			string  	corp_agent_name;
			string 	 	corp_street1;
			string  	corp_city;
			string  	corp_state;
			string  	corp_country;
			string  	corp_zip;
	end;

end;