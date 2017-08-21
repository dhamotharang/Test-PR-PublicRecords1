import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	EXPORT PayloadIncident := RECORD
		BairRx_Common.Layouts.EID;
		// BairRx_Common.Keys.PayloadIntelKey().id;
		BairRx_Common.Keys.PayloadIntelKey().incident_id;
		BairRx_Common.Keys.PayloadIntelKey().priority;
		BairRx_Common.Keys.PayloadIntelKey().case_number;
		BairRx_Common.Keys.PayloadIntelKey().call_case_number;
		BairRx_Common.Keys.PayloadIntelKey().incident_date;
		BairRx_Common.Keys.PayloadIntelKey().incident_time;
		BairRx_Common.Keys.PayloadIntelKey().reporting_officer_id;
		BairRx_Common.Keys.PayloadIntelKey().incident_type;
		BairRx_Common.Keys.PayloadIntelKey().incident_address;
		BairRx_Common.Keys.PayloadIntelKey().incident_city;
		BairRx_Common.Keys.PayloadIntelKey().incident_state;
		BairRx_Common.Keys.PayloadIntelKey().incident_zip;
		BairRx_Common.Keys.PayloadIntelKey().x;
		BairRx_Common.Keys.PayloadIntelKey().y;
		BairRx_Common.Keys.PayloadIntelKey().address_name;
		BairRx_Common.Keys.PayloadIntelKey().location_type;
		BairRx_Common.Keys.PayloadIntelKey().source_relaiability;
		BairRx_Common.Keys.PayloadIntelKey().incident_content_validity;
		BairRx_Common.Keys.PayloadIntelKey().source_type;
		BairRx_Common.Keys.PayloadIntelKey().incident_source_score;
		BairRx_Common.Keys.PayloadIntelKey().incident_entry_date;
		BairRx_Common.Keys.PayloadIntelKey().incident_purge_date;
		BairRx_Common.Keys.PayloadIntelKey().coordinate;
		BairRx_Common.Keys.PayloadIntelKey().first_name;
		BairRx_Common.Keys.PayloadIntelKey().reporting_officer_first_name; 
		BairRx_Common.Keys.PayloadIntelKey().reporting_officer_last_name;
		// BairRx_Common.Keys.PayloadIntelKey().src;
		// BairRx_Common.Keys.PayloadIntelKey().dt_vendor_first_reported;
		// BairRx_Common.Keys.PayloadIntelKey().dt_vendor_last_reported;
		// BairRx_Common.Keys.PayloadIntelKey().dt_first_seen;
		// BairRx_Common.Keys.PayloadIntelKey().dt_last_seen;
		// BairRx_Common.Keys.PayloadIntelKey().record_type;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_id;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_ori;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_name;		
		BairRx_Common.Keys.PayloadIntelKey().update_date;		
		BairRx_Common.Keys.PayloadIntelKey().purgedate_computed;		
		BairRx_Common.Keys.PayloadIntelKey().duration_since;		
	END;
	
	EXPORT PayloadEntity := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadIntelKey().id; // or should it be entity_id;
		BairRx_Common.Keys.PayloadIntelKey().name_type;
		BairRx_Common.Keys.PayloadIntelKey().first_name;
		BairRx_Common.Keys.PayloadIntelKey().middle_name;
		BairRx_Common.Keys.PayloadIntelKey().last_name;
		BairRx_Common.Keys.PayloadIntelKey().moniker;
		BairRx_Common.Keys.PayloadIntelKey().ssn;
		BairRx_Common.Keys.PayloadIntelKey().dob;
		BairRx_Common.Keys.PayloadIntelKey().sex;
		BairRx_Common.Keys.PayloadIntelKey().race;
		BairRx_Common.Keys.PayloadIntelKey().ethnicity;
		BairRx_Common.Keys.PayloadIntelKey().country_of_origin;
		BairRx_Common.Keys.PayloadIntelKey().height;
		BairRx_Common.Keys.PayloadIntelKey().weight;
		BairRx_Common.Keys.PayloadIntelKey().eye_color;
		BairRx_Common.Keys.PayloadIntelKey().hair_color;
		BairRx_Common.Keys.PayloadIntelKey().hair_style;
		BairRx_Common.Keys.PayloadIntelKey().facial_hair;
		BairRx_Common.Keys.PayloadIntelKey().tattoo_text_1;
		BairRx_Common.Keys.PayloadIntelKey().tattoo_location_1;
		BairRx_Common.Keys.PayloadIntelKey().tattoo_text_2;
		BairRx_Common.Keys.PayloadIntelKey().tattoo_location_2;
		BairRx_Common.Keys.PayloadIntelKey().occupation;
		BairRx_Common.Keys.PayloadIntelKey().place_of_employment;
		BairRx_Common.Keys.PayloadIntelKey().entity_address;
		BairRx_Common.Keys.PayloadIntelKey().entity_city;
		BairRx_Common.Keys.PayloadIntelKey().entity_state;
		BairRx_Common.Keys.PayloadIntelKey().entity_zip;
		BairRx_Common.Keys.PayloadIntelKey().person_x;
		BairRx_Common.Keys.PayloadIntelKey().person_y;
		BairRx_Common.Keys.PayloadIntelKey().phone_number;
		BairRx_Common.Keys.PayloadIntelKey().phone_type;
		BairRx_Common.Keys.PayloadIntelKey().email_address;
		BairRx_Common.Keys.PayloadIntelKey().social_media_type_1;
		BairRx_Common.Keys.PayloadIntelKey().user_name_site_1;
		BairRx_Common.Keys.PayloadIntelKey().social_media_type_2;
		BairRx_Common.Keys.PayloadIntelKey().user_name_site_2;
		BairRx_Common.Keys.PayloadIntelKey().social_media_type_3;
		BairRx_Common.Keys.PayloadIntelKey().user_name_site_3;
		BairRx_Common.Keys.PayloadIntelKey().social_media_type_4;
		BairRx_Common.Keys.PayloadIntelKey().user_name_site_4;
		BairRx_Common.Keys.PayloadIntelKey().organization_type;
		BairRx_Common.Keys.PayloadIntelKey().organization_sub_type;
		BairRx_Common.Keys.PayloadIntelKey().organization_name;
		BairRx_Common.Keys.PayloadIntelKey().number_of_members;
		BairRx_Common.Keys.PayloadIntelKey().organization_rank_role;
		BairRx_Common.Keys.PayloadIntelKey().entity_source_type;
		BairRx_Common.Keys.PayloadIntelKey().source_reliability;
		BairRx_Common.Keys.PayloadIntelKey().entity_content_validity;
		BairRx_Common.Keys.PayloadIntelKey().entity_source_score;
		BairRx_Common.Keys.PayloadIntelKey().entity_entry_date;
		BairRx_Common.Keys.PayloadIntelKey().entity_purge_date;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_id;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_type;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_make;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_model;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_color;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_year;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_plate;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_plate_state;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_color_secondary;
		BairRx_Common.Keys.PayloadIntelKey().vehicle_vin;
		// BairRx_Common.Keys.PayloadIntelKey().photo;
	END;


	EXPORT SearchPayload := RECORD
		BairRx_Common.Layouts.EID;
		PayloadIncident - [eid];
		PayloadEntity - [eid, data_provider_id];
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		unsigned4 distance;
	END;
	
	EXPORT ReportPayload := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_id;
		BairRx_Common.Keys.PayloadIntelKey().data_provider_ori;
		DATASET(PayloadIncident) incidents;
		DATASET(PayloadEntity) entities;
		DATASET(BairRx_Common.Layouts.PayloadNotes) notes;
	END;
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_intel.t_BAIRIntelSearchRecord) records;
	END;
	
END;