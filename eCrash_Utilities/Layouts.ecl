EXPORT Layouts := MODULE
 
  EXPORT lay_pre_delete_stats := RECORD
	  STRING Desc;
		UNSIGNED8 total_incidents;
		UNSIGNED8 total_delete_incidents;
		UNSIGNED8 total_persons;
		UNSIGNED8 total_delete_persons;
		UNSIGNED8 total_vehicles;
		UNSIGNED8 total_delete_vehicles;
		UNSIGNED8 total_citations;
		UNSIGNED8 total_delete_citations;
		UNSIGNED8 total_commercials;
		UNSIGNED8 total_delete_commercials;
		UNSIGNED8 total_propertydamages;
		UNSIGNED8 total_delete_propertydamages;		
		UNSIGNED8 total_documents;
		UNSIGNED8 total_delete_documents;
	END;
	
	EXPORT lay_post_delete_stats := RECORD
	  STRING Desc;
		UNSIGNED8 total_incidents;
		UNSIGNED8 total_persons;
		UNSIGNED8 total_vehicles;
		UNSIGNED8 total_citations;
		UNSIGNED8 total_commercials;
		UNSIGNED8 total_propertydamages;	
		UNSIGNED8 total_documents;
	END;
	
END;
;