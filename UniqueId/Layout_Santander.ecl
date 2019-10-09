EXPORT Layout_Santander := MODULE

	export rEntity := RECORD
			string Entity_Unique_ID;
			string WatchListName;
			string id;
			string WatchListDate;
			string type;
			unicode title;
			unicode first_name;
			unicode middle_name;
			unicode last_name;
			unicode generation;
			unicode full_name;
			string gender;
			string listed_date;
			string modified_date;
			string entity_added_by;
			string reason_listed;
			string reference_id;
			unicode comments;
	
	END;

	export rAliases := RECORD
			string Entity_Unique_ID;
			string type;
			string category;
			unicode title;
			unicode first_name;
			unicode middle_name;
			unicode last_name;
			unicode generation;
			unicode full_name;
			unicode comments;	
	END;
	
	export rAddresses := RECORD
			string Entity_Unique_ID;
			string type;
			unicode street_1;
			unicode street_2;
			unicode city;
			unicode state;
			unicode postal_code;
			unicode country;
			unicode comments;
   END;


		export rInfo := RECORD
			string Entity_Unique_ID;
			string type;
			unicode information;
			unicode parsed;
			unicode comments;
   END;

	export rIds := RECORD
			string Entity_Unique_ID;
			string type;
			unicode label;
			unicode number;
			unicode issued_by;
			string date_issued;
			string date_expires;
			unicode comments;
   END;

	export rPhones := RECORD
 			string Entity_Unique_ID;
			string type;
			string address_id;
			unicode number;
			unicode comments;
   END;

	export rCountry := RECORD
			string Entity_Unique_ID;
			string WatchListName;
			//string WatchListDate;
			//string type;
			unicode Country_Name;
			string listed_date;
			string reason_listed;
			//string reference_id;
			string id;
			unicode comments;	
	END;
	
	export rCountryAka := RECORD
			string Entity_Unique_ID;
			string type;
			unicode name;
	END;
	
	export rLocation := RECORD
		string Entity_Unique_ID;
    string type;
    unicode name;
   END;	
	
END;