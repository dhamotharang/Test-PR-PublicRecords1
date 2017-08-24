import Bair, BairRx_Common;

EXPORT Layouts := MODULE
	
	EXPORT EID := RECORD
		string23 eid;	
	END;
	
	EXPORT SortingFields := RECORD
		unsigned1 slim_sort := 0;
		unsigned7 date      := 0;
	END;
	
	EXPORT CustomSortLayout	:= RECORD
		unsigned1	sort_type := 0; // 0 - int, 1 - string
		integer  	sort_num := 0;
		string20	sort_str := '';	// 20 first characters enough to guarantee sort order?	
	END;
	
	EXPORT SearchRec := record		
		string11 	longitude;
		string10 	latitude;
		EID;
		unsigned1 etype;
		string10	ori;					
		string10	class;	
		unsigned4	stamp;
		SortingFields;
		unsigned4 distance := 0;
		string12 gh12 := '';
		boolean delta := false;
		unsigned1 depth;
		// uncomment for debugging
		// Bair.layouts.GeoHashLayout - [gh12,longitude,latitude,date,class,ori,etype,stamp,eid]; 
	END;	
		
	EXPORT LayoutEventMO := RECORD
		Bair.Key_Payload_MO().eid;
		Bair.Key_Payload_MO().mostamp;
		Bair.Key_Payload_MO().ir_number;
		Bair.Key_Payload_MO().ucr_group;
		Bair.Key_Payload_MO().crime;
		Bair.Key_Payload_MO().location_type;
		Bair.Key_Payload_MO().object_of_attack_1;
		Bair.Key_Payload_MO().object_of_attack_2;
		Bair.Key_Payload_MO().point_of_entry_1;
		Bair.Key_Payload_MO().point_of_entry_2;
		Bair.Key_Payload_MO().method_of_entry_1;
		Bair.Key_Payload_MO().method_of_entry_2;
		Bair.Key_Payload_MO().suspects_actions_against_person_1;
		Bair.Key_Payload_MO().suspects_actions_against_person_2;
		Bair.Key_Payload_MO().suspects_actions_against_person_3;
		Bair.Key_Payload_MO().suspects_actions_against_person_4;
		Bair.Key_Payload_MO().suspects_actions_against_person_5;
		Bair.Key_Payload_MO().suspects_actions_against_property_1;
		Bair.Key_Payload_MO().suspects_actions_against_property_2;
		Bair.Key_Payload_MO().suspects_actions_against_property_3;
		Bair.Key_Payload_MO().property_taken_1;
		Bair.Key_Payload_MO().property_taken_2;
		Bair.Key_Payload_MO().property_taken_3;
		Bair.Key_Payload_MO().property_value;
		Bair.Key_Payload_MO().weapon_type_1;
		Bair.Key_Payload_MO().weapon_type_2;
		Bair.Key_Payload_MO().method_of_departure;
		Bair.Key_Payload_MO().first_time;
		Bair.Key_Payload_MO().last_time;
		Bair.Key_Payload_MO().first_date;
		Bair.Key_Payload_MO().last_date;
		Bair.Key_Payload_MO().first_date_time;
		Bair.Key_Payload_MO().last_date_time;
		Bair.Key_Payload_MO().report_date;
		Bair.Key_Payload_MO().edit_date;		
		Bair.Key_Payload_MO().address_of_crime;
		Bair.Key_Payload_MO().public_address;
		Bair.Key_Payload_MO().beat;
		Bair.Key_Payload_MO().rd;
		Bair.Key_Payload_MO().companions;
		Bair.Key_Payload_MO().apt;
		Bair.Key_Payload_MO().agency;
		Bair.Key_Payload_MO().accuracy;
		Bair.Key_Payload_MO().x_coordinate;
		Bair.Key_Payload_MO().y_coordinate;
		Bair.Key_Payload_MO().x_offset;
		Bair.Key_Payload_MO().y_offset;
		Bair.Key_Payload_MO().geocoded;
		Bair.Key_Payload_MO().projected_x;
		Bair.Key_Payload_MO().projected_y;
		Bair.Key_Payload_MO().data_provider_id;
		Bair.Key_Payload_MO().data_provider_ori;
		Bair.Key_Payload_MO().data_provider_name;
		Bair.Key_Payload_MO().ORI;
		Bair.Key_Payload_MO().last_day;
		Bair.Key_Payload_MO().t_coordinate;
		Bair.Key_Payload_MO().duration;
		Bair.Key_Payload_MO().first_day;
		Bair.Key_Payload_MO().sequence;
		Bair.Key_Payload_MO().address_name;
		Bair.Key_Payload_MO().marked;
		Bair.Key_Payload_MO().commonalities;
		Bair.Key_Payload_MO().interval;
		Bair.Key_Payload_MO().recordid_raids;
		Bair.Key_Payload_MO().raids;
		Bair.Key_Payload_MO().citizen_observer_id;
		Bair.Key_Payload_MO().City;
		Bair.Key_Payload_MO().State;
		Bair.Key_Payload_MO().Zip;
	END;	
	
	
	EXPORT LayoutCFSCall := RECORD
		Bair.Key_Payload_CFS_v2().EID;
		Bair.Key_Payload_CFS_v2().initial_ucr_group;
		Bair.Key_Payload_CFS_v2().final_ucr_group;
		Bair.Key_Payload_CFS_v2().event_number;
		Bair.Key_Payload_CFS_v2().initial_type;
		Bair.Key_Payload_CFS_v2().final_type; 
		Bair.Key_Payload_CFS_v2().location_type;
		Bair.Key_Payload_CFS_v2().place_name;
		Bair.Key_Payload_CFS_v2().how_received;
		Bair.Key_Payload_CFS_v2().date_time_received;
		Bair.Key_Payload_CFS_v2().total_minutes_on_call;
		Bair.Key_Payload_CFS_v2().report_number;
		Bair.Key_Payload_CFS_v2().caller_address;
		Bair.Key_Payload_CFS_v2().accuracy;
		Bair.Key_Payload_CFS_v2().district;
		Bair.Key_Payload_CFS_v2().rd;
		Bair.Key_Payload_CFS_v2().beat;
		Bair.Key_Payload_CFS_v2().date_time_archived;
		Bair.Key_Payload_CFS_v2().incident_code;
		Bair.Key_Payload_CFS_v2().incident_progress;
		Bair.Key_Payload_CFS_v2().address;
		Bair.Key_Payload_CFS_v2().city;
		Bair.Key_Payload_CFS_v2().call_taker;
		Bair.Key_Payload_CFS_v2().contacting_officer;
		Bair.Key_Payload_CFS_v2().complainant;
		Bair.Key_Payload_CFS_v2().current_phone;
		Bair.Key_Payload_CFS_v2().complainant_address;
		Bair.Key_Payload_CFS_v2().status;
		Bair.Key_Payload_CFS_v2().apartment_number;
		Bair.Key_Payload_CFS_v2().complainant_x_coordinate;
		Bair.Key_Payload_CFS_v2().complainant_y_coordinate;
		Bair.Key_Payload_CFS_v2().x_coordinate;
		Bair.Key_Payload_CFS_v2().y_coordinate;
		Bair.Key_Payload_CFS_v2().geocoded; 
		Bair.Key_Payload_CFS_v2().data_provider_id; 
		Bair.Key_Payload_CFS_v2().data_provider_ori; 
		Bair.Key_Payload_CFS_v2().data_provider_name; 
		Bair.Key_Payload_CFS_v2().disposition; 
		Bair.Key_Payload_CFS_v2().priority1; 	
	END;
	
	
	EXPORT LayoutCrashIncident := RECORD
		Bair.Key_Payload_Crash_v2().EID;
		Bair.Key_Payload_Crash_v2().case_number;
		Bair.Key_Payload_Crash_v2().reportnumber;
		Bair.Key_Payload_Crash_v2().report_date;
		Bair.Key_Payload_Crash_v2().address;
		Bair.Key_Payload_Crash_v2().county;
		Bair.Key_Payload_Crash_v2().crash_city;
		Bair.Key_Payload_Crash_v2().crash_state;
		Bair.Key_Payload_Crash_v2().x;
		Bair.Key_Payload_Crash_v2().y;		
		Bair.Key_Payload_Crash_v2().hitandrun;
		Bair.Key_Payload_Crash_v2().intersectionrelated;
		Bair.Key_Payload_Crash_v2().officername;
		Bair.Key_Payload_Crash_v2().crashtype;
		Bair.Key_Payload_Crash_v2().locationtype;
		Bair.Key_Payload_Crash_v2().accidentclass;
		Bair.Key_Payload_Crash_v2().specialcircumstance1;
		Bair.Key_Payload_Crash_v2().specialcircumstance2;
		Bair.Key_Payload_Crash_v2().specialcircumstance3;
		Bair.Key_Payload_Crash_v2().lightcondition;
		Bair.Key_Payload_Crash_v2().weathercondition;
		Bair.Key_Payload_Crash_v2().surfacetype;
		Bair.Key_Payload_Crash_v2().roadspecialfeature1;
		Bair.Key_Payload_Crash_v2().roadspecialfeature2;
		Bair.Key_Payload_Crash_v2().roadspecialfeature3;
		Bair.Key_Payload_Crash_v2().surfacecondition;
		Bair.Key_Payload_Crash_v2().trafficcontrolpresent;
		Bair.Key_Payload_Crash_v2().data_provider_id;
		Bair.Key_Payload_Crash_v2().data_provider_ori;
		Bair.Key_Payload_Crash_v2().data_provider_name;
	END;
	
	EXPORT LayoutLPR := RECORD
		Bair.Key_Payload_LPR().EID;
		Bair.Key_Payload_LPR().licenseplaterecordguid;
		Bair.Key_Payload_LPR().eventnumber;
		Bair.Key_Payload_LPR().capturedatetime;
		Bair.Key_Payload_LPR().plate;
		Bair.Key_Payload_LPR().platealternate;
		Bair.Key_Payload_LPR().confidence;
		Bair.Key_Payload_LPR().x_coordinate;
		Bair.Key_Payload_LPR().y_coordinate;
		Bair.Key_Payload_LPR().data_provider_id;
		Bair.Key_Payload_LPR().data_provider_ori;
		Bair.Key_Payload_LPR().data_provider_name;		
		Bair.Key_Payload_LPR().has_image;	       	       
	END;
	
	EXPORT LayoutOffender := RECORD
		Bair.Key_Payload_Offender().eid;
		Bair.Key_Payload_Offender().id;
		Bair.Key_Payload_Offender().agency_offender_id;
		Bair.Key_Payload_Offender().bair_score;
		Bair.Key_Payload_Offender().name_type;
		Bair.Key_Payload_Offender().first_name;
		Bair.Key_Payload_Offender().middle_name;
		Bair.Key_Payload_Offender().last_name;
		Bair.Key_Payload_Offender().moniker;
		Bair.Key_Payload_Offender().address;
		Bair.Key_Payload_Offender().x_coordinate;
		Bair.Key_Payload_Offender().y_coordinate;
		Bair.Key_Payload_Offender().dob;
		Bair.Key_Payload_Offender().race;
		Bair.Key_Payload_Offender().sex;
		Bair.Key_Payload_Offender().hair;
		Bair.Key_Payload_Offender().hair_length;
		Bair.Key_Payload_Offender().eyes;
		Bair.Key_Payload_Offender().hand_use;
		Bair.Key_Payload_Offender().speech;
		Bair.Key_Payload_Offender().teeth;
		Bair.Key_Payload_Offender().physical_condition;
		Bair.Key_Payload_Offender().build;
		Bair.Key_Payload_Offender().complexion;
		Bair.Key_Payload_Offender().facial_hair;
		Bair.Key_Payload_Offender().hat;
		Bair.Key_Payload_Offender().mask;
		Bair.Key_Payload_Offender().glasses;
		Bair.Key_Payload_Offender().appearance;
		Bair.Key_Payload_Offender().shirt;
		Bair.Key_Payload_Offender().pants;
		Bair.Key_Payload_Offender().shoes;
		Bair.Key_Payload_Offender().jacket;
		Bair.Key_Payload_Offender().soundex;
		Bair.Key_Payload_Offender().weight_1;
		Bair.Key_Payload_Offender().weight_2;
		Bair.Key_Payload_Offender().height_1;
		Bair.Key_Payload_Offender().height_2;
		Bair.Key_Payload_Offender().age_1;
		Bair.Key_Payload_Offender().age_2;
		Bair.Key_Payload_Offender().offenders_sid;
		Bair.Key_Payload_Offender().dl_number;
		Bair.Key_Payload_Offender().dl_state;
		Bair.Key_Payload_Offender().fbi_number;
		Bair.Key_Payload_Offender().edit_date;
		Bair.Key_Payload_Offender().quarantined;
		Bair.Key_Payload_Offender().group_id;
		Bair.Key_Payload_Offender().admin_state;
		Bair.Key_Payload_Offender().agency_name;
		Bair.Key_Payload_Offender().classification_code;
		Bair.Key_Payload_Offender().classification_description;
		Bair.Key_Payload_Offender().classification;
		Bair.Key_Payload_Offender().agency_category;
		Bair.Key_Payload_Offender().agency_level;
		Bair.Key_Payload_Offender().agency_score;
		Bair.Key_Payload_Offender().case_reference_number;
		Bair.Key_Payload_Offender().charge_offense;
		Bair.Key_Payload_Offender().probation_type;
		Bair.Key_Payload_Offender().probation_officer;
		Bair.Key_Payload_Offender().warrant_type;
		Bair.Key_Payload_Offender().warrant_number;
		Bair.Key_Payload_Offender().gang_name;
		Bair.Key_Payload_Offender().gang_role;
		Bair.Key_Payload_Offender().classification_date;
		Bair.Key_Payload_Offender().expiration_date;
		Bair.Key_Payload_Offender().data_provider_id;
		Bair.Key_Payload_Offender().data_provider_ori;
		Bair.Key_Payload_Offender().data_provider_name;	
		Bair.Key_Payload_Offender().picture;			
		unsigned2 class_code := 0;
		Bair.Key_Payload_Offender().lexid;
		Bair.Key_Payload_Offender().has_image;
	END;
	
	EXPORT LayoutShotSpotter := RECORD	
		Bair.Key_Payload_Shotspotter().EID;
		Bair.Key_Payload_ShotSpotter().raids_record_id;
		Bair.Key_Payload_ShotSpotter().shot_id;
		Bair.Key_Payload_ShotSpotter().x_coordinate;
		Bair.Key_Payload_ShotSpotter().y_coordinate;
		Bair.Key_Payload_ShotSpotter().address;
		Bair.Key_Payload_ShotSpotter().coordinate;
		Bair.Key_Payload_ShotSpotter().shots;
		Bair.Key_Payload_ShotSpotter().beat;
		Bair.Key_Payload_ShotSpotter().district;
		Bair.Key_Payload_ShotSpotter().shot_source;
		Bair.Key_Payload_ShotSpotter().shot_datetime;
		Bair.Key_Payload_ShotSpotter().shot_incident_type;
		Bair.Key_Payload_ShotSpotter().shot_incident_status;
		Bair.Key_Payload_ShotSpotter().data_provider_id;
		Bair.Key_Payload_ShotSpotter().data_provider_ori;
		Bair.Key_Payload_ShotSpotter().data_provider_name;	
	END;	
	
	EXPORT MapPayloadBase := RECORD
		EID;		
		string12	gh12;				
		string10	ori;				
		string100 referenceID;
		unsigned2 class_code;
		string10 	class;
		string11	latitude;
		string10 	longitude;
		string100 address;
		string50	agency;
		unsigned3	seq := 0;
		unsigned1 etype;
		unsigned7	date;		
		unsigned1 stamp;
		unsigned4 distance := 0;
		unsigned1 accuracy;
		CustomSortLayout;
	END;			
	
	EXPORT MapPayload := RECORD(MapPayloadBase)
		LayoutEventMO event_MO;
		LayoutCFSCall cfs_call;
		LayoutCrashIncident crash_incident;
		LayoutLPR lpr;
		LayoutOffender offender;
		LayoutShotSpotter shot_spotter;		
	END;
	
	EXPORT EIDDownload := RECORD
		string23 eid;	
		unsigned3	seq := 0;
	END;
	
	EXPORT FID := RECORD
		STRING fn;
		UNSIGNED fid;
	END;
	
	EXPORT PayloadNotes := RECORD
		EID;	
		unsigned4 ReferId;
		unsigned1 note_type;
		unsigned1 seq;
		string notes;
	END;
	
	EXPORT ClassCodes := RECORD
		unsigned1 etype;
		set of string codes;
	END;
	
	EXPORT FilterExpression := RECORD
		string expression;
		boolean ori_filter := false;
	END;
	
	EXPORT ModeContext := RECORD
		string3 mID;
		DATASET(ClassCodes) codes;
		DATASET(ClassCodes) clean_codes;
		unsigned1 data_relation;
		string sorting_clause;
		boolean filter_search;
		DATASET(FilterExpression) filters;
	END;
	
	EXPORT ActiveModes := RECORD
		boolean EVE := false;
		boolean CFS := false;
		boolean CRA := false;
		boolean OFF := false;
		boolean LPR := false;
		boolean SHO := false;
		boolean INT := false;
	END;
	
	EXPORT LayoutGeoSearchGrid := RECORD
		STRING Box; 
		INTEGER1 Overlap := 0;
		REAL tl_latitude;
		REAL tl_longitude;
		REAL br_latitude;
		REAL br_longitude;		
	END;

END;