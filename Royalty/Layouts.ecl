EXPORT Layouts := module

 // the standard royalty dataset layout
 export Royalty := record
		unsigned	royalty_type_code; 	// A royalty type unique code.
		string 		royalty_type; 			// A royalty type label.
   	unsigned 	royalty_count; 			// # of records from a royalty source included in the query results. 
   	unsigned 	non_royalty_count;  // the mistery continues for this one...
		string 		count_entity := ''; // used to flag a specific royalty entity (e.g. phones in Last Resort).	
 end;
 
  // the standard royalty dataset layout for batch
 export RoyaltyForBatch := record
		string20 	acctno;
		unsigned2 royalty_type_code;
		string20 	royalty_type; 
   	unsigned2	royalty_count;
		unsigned2	non_royalty_count;
		string50	count_entity := ''; //20200922 RR-19924, change length to store values longer than 20. i.e. ip_address for the GeoTriangulation_Services.BatchService
		string1		source_type := ''; // 'I' - inhouse; 'G' - gateway
 end;
 
 // (TO BE REMOVED) used in a few batch queries.
 export RoyaltySrc := record
	string2 royalty_src;
 end;

end;