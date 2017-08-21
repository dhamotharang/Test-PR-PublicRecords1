import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	SHARED LayoutMOKey := recordof(BairRx_Common.Keys.PayloadMOKey());
	SHARED LayoutVehicleKey := recordof(BairRx_Common.Keys.PayloadVehicleKey());
	SHARED LayoutPersonKey := recordof(BairRx_Common.Keys.PayloadPersonKey());
	SHARED LayoutMOUDFKey := recordof(BairRx_Common.Keys.PayloadMOUDFKey());
	SHARED LayoutPersonUDFKey := recordof(BairRx_Common.Keys.PayloadPersonUDFKey());

	EXPORT MOUDFFields := RECORD
		LayoutMOUDFKey.moudf1;
		LayoutMOUDFKey.moudf2;
		LayoutMOUDFKey.moudf3;
		LayoutMOUDFKey.moudf4;
		LayoutMOUDFKey.moudf5;
		LayoutMOUDFKey.moudf6;
		LayoutMOUDFKey.moudf7;
		LayoutMOUDFKey.moudf8;		
	END;
	
	EXPORT PersonUDFFields := RECORD
		LayoutPersonUDFKey.personudf1;
		LayoutPersonUDFKey.personudf2;
		LayoutPersonUDFKey.personudf3;
		LayoutPersonUDFKey.personudf4;
	END;
	
	EXPORT PayloadMO := RECORD
		BairRx_Common.Layouts.EID;
		LayoutMOKey.mostamp;
		LayoutMOKey.ir_number;
		LayoutMOKey.ucr_group;
		LayoutMOKey.crime;
		LayoutMOKey.location_type;
		LayoutMOKey.object_of_attack_1;
		LayoutMOKey.object_of_attack_2;
		LayoutMOKey.point_of_entry_1;
		LayoutMOKey.point_of_entry_2;
		LayoutMOKey.method_of_entry_1;
		LayoutMOKey.method_of_entry_2;
		LayoutMOKey.suspects_actions_against_person_1;
		LayoutMOKey.suspects_actions_against_person_2;
		LayoutMOKey.suspects_actions_against_person_3;
		LayoutMOKey.suspects_actions_against_person_4;
		LayoutMOKey.suspects_actions_against_person_5;
		LayoutMOKey.suspects_actions_against_property_1;
		LayoutMOKey.suspects_actions_against_property_2;
		LayoutMOKey.suspects_actions_against_property_3;
		LayoutMOKey.property_taken_1;
		LayoutMOKey.property_taken_2;
		LayoutMOKey.property_taken_3;
		LayoutMOKey.property_value;
		LayoutMOKey.weapon_type_1;
		LayoutMOKey.weapon_type_2;
		LayoutMOKey.method_of_departure;
		LayoutMOKey.first_time;
		LayoutMOKey.last_time;
		LayoutMOKey.first_date;
		LayoutMOKey.last_date;
		LayoutMOKey.first_date_time;
		LayoutMOKey.last_date_time;
		LayoutMOKey.report_date;
		LayoutMOKey.edit_date;		
		LayoutMOKey.address_of_crime;
		LayoutMOKey.public_address;
		LayoutMOKey.beat;
		LayoutMOKey.rd;
		LayoutMOKey.companions;
		LayoutMOKey.apt;
		LayoutMOKey.agency;
		LayoutMOKey.accuracy;
		LayoutMOKey.x_coordinate;
		LayoutMOKey.y_coordinate;
		LayoutMOKey.x_offset;
		LayoutMOKey.y_offset;
		LayoutMOKey.geocoded;
		LayoutMOKey.projected_x;
		LayoutMOKey.projected_y;
		LayoutMOKey.data_provider_id;
		LayoutMOKey.data_provider_ori;
		LayoutMOKey.data_provider_name;
		LayoutMOKey.ORI;
		LayoutMOKey.last_day;
		LayoutMOKey.t_coordinate;
		LayoutMOKey.duration;
		LayoutMOKey.first_day;
		LayoutMOKey.sequence;
		LayoutMOKey.address_name;
		LayoutMOKey.marked;
		LayoutMOKey.commonalities;
		LayoutMOKey.interval;
		LayoutMOKey.recordid_raids;
		LayoutMOKey.raids;
		LayoutMOKey.le_only;
		LayoutMOKey.citizen_observer_id;
		LayoutMOKey.public_synopsis;
		MOUDFFields;
		BairRx_Common.Layouts.CustomSortLayout;
		LayoutMOKey.City;
		LayoutMOKey.State;
		LayoutMOKey.Zip;
	END;
	
	EXPORT PayloadMOUDF := RECORD	
		BairRx_Common.Layouts.EID;	
		unsigned4 data_provider_id;
		unsigned4 stamp;
		MOUDFFields;
		BairRx_Common.Layouts.CustomSortLayout;
	END;
	
	EXPORT PayloadVehicle := RECORD
		BairRx_Common.Layouts.EID;
		LayoutVehicleKey.vehiclestamp;
		LayoutVehicleKey.make;
		LayoutVehicleKey.model;
		LayoutVehicleKey.style;
		LayoutVehicleKey.color;
		LayoutVehicleKey.year;
		LayoutVehicleKey.plate;
		LayoutVehicleKey.plate_state;
		LayoutVehicleKey.type;
		LayoutVehicleKey.vehicle_status;
		LayoutVehicleKey.vehicle_address;
		LayoutVehicleKey.vehicle_x_projected;
		LayoutVehicleKey.vehicle_y_projected;
		typeof(LayoutVehicleKey.edit_date) vehicle_edit_date;
		LayoutVehicleKey.ori;
		LayoutVehicleKey.vehicle_x_coordinate;
		LayoutVehicleKey.vehicle_y_coordinate;
		LayoutVehicleKey.vehicle_accuracy;
		LayoutVehicleKey.vehicle_geocoded;
		LayoutVehicleKey.City;
		LayoutVehicleKey.State;
		LayoutVehicleKey.Zip;
	END;
	
	EXPORT PayloadPerson := RECORD
		BairRx_Common.Layouts.EID;
		LayoutPersonKey.personstamp;
		LayoutPersonKey.name_type;
		LayoutPersonKey.first_name;
		LayoutPersonKey.middle_name;
		LayoutPersonKey.last_name;
		LayoutPersonKey.moniker;
		LayoutPersonKey.persons_address;
		LayoutPersonKey.dob;
		LayoutPersonKey.race;
		LayoutPersonKey.sex;
		LayoutPersonKey.hair;
		LayoutPersonKey.hair_length;
		LayoutPersonKey.eyes;
		LayoutPersonKey.hand_use;
		LayoutPersonKey.speech;
		LayoutPersonKey.teeth;
		LayoutPersonKey.physical_condition;
		LayoutPersonKey.build;
		LayoutPersonKey.complexion;
		LayoutPersonKey.facial_hair;
		LayoutPersonKey.hat;
		LayoutPersonKey.mask;
		LayoutPersonKey.glasses;
		LayoutPersonKey.appearance;
		LayoutPersonKey.shirt;
		LayoutPersonKey.pants;
		LayoutPersonKey.shoes;
		LayoutPersonKey.jacket;
		LayoutPersonKey.soundex;
		LayoutPersonKey.weight_1;
		LayoutPersonKey.weight_2;
		LayoutPersonKey.height_1;
		LayoutPersonKey.height_2;
		LayoutPersonKey.age_1;
		LayoutPersonKey.age_2;
		LayoutPersonKey.persons_sid;
		LayoutPersonKey.facial_recognition;
		LayoutPersonKey.ori;
		LayoutPersonKey.persons_x_coordinate;
		LayoutPersonKey.persons_y_coordinate;
		LayoutPersonKey.persons_x_projected;
		LayoutPersonKey.persons_y_projected;
		typeof(LayoutPersonKey.edit_date) persons_edit_date;
		LayoutPersonKey.recordid_raids;
		LayoutPersonKey.persons_accuracy;
		LayoutPersonKey.persons_geocoded;
		PersonUDFFields;
		BairRx_Common.Layouts.CustomSortLayout;
		LayoutPersonKey.lexid;
		LayoutPersonKey.City;
		LayoutPersonKey.State;
		LayoutPersonKey.Zip;
	END;
	
	EXPORT PayloadPersonUDF := RECORD	
		BairRx_Common.Layouts.EID;		
		unsigned4 data_provider_id;
		unsigned4 stamp;
		PersonUDFFields;	
		BairRx_Common.Layouts.CustomSortLayout;
	END;	
	
	EXPORT SearchPayload := RECORD
		PayloadMO - [sort_type, sort_num, sort_str];
		PayloadPerson - [sort_type, sort_num, sort_str, city, state, zip];
		PayloadVehicle - [city, state, zip];
		MOUDFFields;
		PersonUDFFields;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		integer distance;
		boolean delta;
	END;	

	EXPORT PayloadMOWithNotes := RECORD(PayloadMO)
		STRING Notes;
	END;
	
	EXPORT PayloadPersonWithNotes := RECORD(PayloadPerson)
		STRING Notes;
	END;
	
	EXPORT PayloadVehicleWithNotes := RECORD(PayloadVehicle)
		STRING Notes;
	END;

	EXPORT ReportPayload := RECORD
		BairRx_Common.Layouts.EID;
		PayloadMO.data_provider_ori;
		DATASET(PayloadMOWithNotes) mos;
		DATASET(PayloadPersonWithNotes) persons;
		DATASET(PayloadVehicleWithNotes) vehicles;
	END;	
	
	EXPORT SlimSearchPayload := RECORD
		PayloadMO.EID;
		PayloadMO.mostamp;
		PayloadMO.ir_number;
		PayloadMO.ucr_group;
		PayloadMO.crime;
		PayloadMO.public_address;
		PayloadMO.accuracy;
		PayloadMO.x_coordinate;
		PayloadMO.y_coordinate;
		PayloadMO.location_type;
		PayloadMO.first_date_time;
		PayloadMO.x_offset;
		PayloadMO.y_offset;
		PayloadMO.agency;
		PayloadMO.ORI;
		PayloadMO.data_provider_ori;
		PayloadMO.public_synopsis;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		integer distance;
		boolean delta;
		boolean raids_ok;
	END;
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_event.t_BAIREventSearchRecord) records;
	END;

	EXPORT SlimSearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_event_slim.t_BAIREventSlimSearchRecord) records;
	END;
				
END;