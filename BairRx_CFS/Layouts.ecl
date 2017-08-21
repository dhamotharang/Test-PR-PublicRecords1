import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	export PayloadCFS := record
		BairRx_Common.Keys.PayloadCFSKey().eid;
		BairRx_Common.Keys.PayloadCFSKey().event_number;
		BairRx_Common.Keys.PayloadCFSKey().report_number;
		BairRx_Common.Keys.PayloadCFSKey().initial_ucr_group;
		BairRx_Common.Keys.PayloadCFSKey().final_ucr_group;
		BairRx_Common.Keys.PayloadCFSKey().address;
		BairRx_Common.Keys.PayloadCFSKey().apartment_number;
		BairRx_Common.Keys.PayloadCFSKey().city;
		BairRx_Common.Keys.PayloadCFSKey().x_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().y_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().geocoded;
		BairRx_Common.Keys.PayloadCFSKey().accuracy_code;
		BairRx_Common.Keys.PayloadCFSKey().accuracy;
		BairRx_Common.Keys.PayloadCFSKey().place_name;
		BairRx_Common.Keys.PayloadCFSKey().location_type;
		BairRx_Common.Keys.PayloadCFSKey().district;
		BairRx_Common.Keys.PayloadCFSKey().beat;
		BairRx_Common.Keys.PayloadCFSKey().rd;
		BairRx_Common.Keys.PayloadCFSKey().how_received;
		BairRx_Common.Keys.PayloadCFSKey().initial_type;
		BairRx_Common.Keys.PayloadCFSKey().final_type;
		BairRx_Common.Keys.PayloadCFSKey().disposition;
		BairRx_Common.Keys.PayloadCFSKey().priority1;
		BairRx_Common.Keys.PayloadCFSKey().date_occurred;
		BairRx_Common.Keys.PayloadCFSKey().date_time_received;
		BairRx_Common.Keys.PayloadCFSKey().edit_date;
		BairRx_Common.Keys.PayloadCFSKey().date_time_archived;
		BairRx_Common.Keys.PayloadCFSKey().incident_code;
		BairRx_Common.Keys.PayloadCFSKey().incident_progress;
		BairRx_Common.Keys.PayloadCFSKey().report_flag;
		BairRx_Common.Keys.PayloadCFSKey().event_relationship;
		BairRx_Common.Keys.PayloadCFSKey().call_taker;
		BairRx_Common.Keys.PayloadCFSKey().contacting_officer;
		BairRx_Common.Keys.PayloadCFSKey().total_minutes_on_call;
		BairRx_Common.Keys.PayloadCFSKey().status;
		BairRx_Common.Keys.PayloadCFSKey().data_provider_id;
		BairRx_Common.Keys.PayloadCFSKey().data_provider_ori;
		BairRx_Common.Keys.PayloadCFSKey().data_provider_name;
		BairRx_Common.Keys.PayloadCFSKey().lexid;
		BairRx_Common.Keys.PayloadCFSKey().complainant;
		BairRx_Common.Keys.PayloadCFSKey().complainant_address;
		BairRx_Common.Keys.PayloadCFSKey().caller_address;
		BairRx_Common.Keys.PayloadCFSKey().current_phone;
		BairRx_Common.Keys.PayloadCFSKey().complainant_x_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().complainant_y_coordinate;
		BairRx_Common.Keys.PayloadCFSKey().complainant_geocoded;
		BairRx_Common.Keys.PayloadCFSKey().complainant_accuracy;
		integer distance := 0;
	end;

	export PayloadOfficer := record
		BairRx_Common.Keys.PayloadCFSKey_Officer().eid;
		BairRx_Common.Keys.PayloadCFSKey_Officer().primary_officer_indicator;
		BairRx_Common.Keys.PayloadCFSKey_Officer().primary_officer;
		BairRx_Common.Keys.PayloadCFSKey_Officer().cfs_officers_id;
		BairRx_Common.Keys.PayloadCFSKey_Officer().officer_name;
		BairRx_Common.Keys.PayloadCFSKey_Officer().date_time_dispatched;
		BairRx_Common.Keys.PayloadCFSKey_Officer().date_time_enroute;
		BairRx_Common.Keys.PayloadCFSKey_Officer().date_time_arrived;
		BairRx_Common.Keys.PayloadCFSKey_Officer().date_time_cleared;
		BairRx_Common.Keys.PayloadCFSKey_Officer().minutes_on_call;
		BairRx_Common.Keys.PayloadCFSKey_Officer().minutes_response;
		BairRx_Common.Keys.PayloadCFSKey_Officer().unit;
		BairRx_Common.Keys.PayloadCFSKey_Officer().data_provider_id;
	end;

	EXPORT PayloadOfficerWithNotes := RECORD(PayloadOfficer)
		DATASET(BairRx_Common.Layouts.PayloadNotes) notes
	END;	
	
	EXPORT Payload := RECORD
		PayloadCFS;
		PayloadOfficer - eid;
	END;
	
	EXPORT PayloadReport := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadCFSKey().data_provider_ori;
		DATASET(PayloadCFS) calls;
		DATASET(PayloadOfficerWithNotes) officers;
		DATASET(BairRx_Common.Layouts.PayloadNotes) notes;
	END;
	
	EXPORT SearchPayload := RECORD
		Payload;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
	END;
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_cfs.t_BAIRCFSSearchRecord) records;
	END;	

	export MapPayloadCFS := record(BairRx_Common.Layouts.MapPayloadBase)
		BairRx_Common.Layouts.LayoutCFSCall cfs_call;
	end;
	
	
END;