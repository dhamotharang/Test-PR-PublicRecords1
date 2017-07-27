export Layout_WorldCheck := module

	export layout_aliases := RECORD
		string type;
		string category;
		string first_name;
		string middle_name;
		string last_name;
		string generation;
		string full_name;
		string comments;
	END;

	export aka_rollup := RECORD
	   string id;
	   DATASET(Layout_Aliases) aka;
	END;

	export layout_addresses := RECORD
		string type;
		string street_1;
		string street_2;
		string city;
		string state;
		string postal_code;
		string country;
		string comments;
	END;

	export addr_rollup := RECORD
	   string id;
	   DATASET(layout_addresses) address;
	END;

	export layout_addlinfo := RECORD
		string type;
		string information;
		string parsed;
		string comments;
	END;

	export addlinfo_rollup := RECORD
	   string id;
	   DATASET(Layout_AddlInfo) additionalinfo;
	END;

	export layout_sp := RECORD
		string type;
		string label;
		string number;
		string issued_by;
		string date_issued;
		string date_expires;
		string comments;
	END;

	export id_rollup := RECORD
	   string id;
	   DATASET(Layout_SP) identification;
	END;

	export layout_common := RECORD
		,maxLength(589824)
		  string typerec;
		  string title;
		  string first_name;
		  string middle_name;
		  string last_name;
		  string generation;
		  string full_name;
		  string gender;
		  string listed_date;
		  string entity_added_by;
		  string reason_listed;
		  string reference_id;
		  string comments;
		  string search_criteria;
		  AKA_rollup aka_list;
		  Addr_rollup address_list;
		  AddlInfo_rollup additional_info_list;
		  ID_rollup identification_list;
	 END;
	
end;
