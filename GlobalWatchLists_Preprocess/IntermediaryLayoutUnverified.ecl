EXPORT IntermediaryLayoutUnverified := MODULE;

	EXPORT BaseLayout := RECORD
		string5 	ent_key;
		string60 	source;
		string8 	lst_vend_upd;
		string60 	lstd_entity;
		string60 	lstd_aka1;
		string60	lstd_aka2;
		string60	lstd_aka3;
		string60	lstd_aka4;
		string55 	country;
		string125 full_address1;
		string125 full_address2;
		string125 full_address3;
		string125 full_address4;
		string125 full_address5;
		string35 	Federal_Citation_1;
		string35 	Federal_Citation_2;
		string35 	Federal_Citation_3;
		string35 	Federal_Citation_4;
		string20	publication_date1; //Month Day, YYYY
		string20	publication_date2;
		string20	publication_date3;
		string20	publication_date4;
		string350	orig_raw_name;
	END;
	
	EXPORT Base_norm	:= RECORD
		string5 	ent_key;
		string60 	source;
		string8 	lst_vend_upd;
		string60 	lstd_entity;
		string60 	lstd_aka1;
		string60	lstd_aka2;
		string60	lstd_aka3;
		string60	lstd_aka4;
		string55 	country;
		string125 full_address;
		string35 	Federal_Citation_1;
		string35 	Federal_Citation_2;
		string35 	Federal_Citation_3;
		string35 	Federal_Citation_4;
		string20	publication_date1;
		string20	publication_date2;
		string20	publication_date3;
		string20	publication_date4;
		string350	orig_raw_name;
	END;

END;