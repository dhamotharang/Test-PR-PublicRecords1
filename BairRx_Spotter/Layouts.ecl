import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	EXPORT Payload := RECORD
		// iesp.bair_spotter.t_BAIRShotSpotterSearchRecord;
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadSSKey().raids_record_id;
		BairRx_Common.Keys.PayloadSSKey().shot_id;
		BairRx_Common.Keys.PayloadSSKey().x_coordinate;
		BairRx_Common.Keys.PayloadSSKey().y_coordinate;
		BairRx_Common.Keys.PayloadSSKey().address;
		BairRx_Common.Keys.PayloadSSKey().coordinate;
		//BairRx_Common.Keys.PayloadSSKey().coordinate;
		BairRx_Common.Keys.PayloadSSKey().shots;
		BairRx_Common.Keys.PayloadSSKey().beat;
		BairRx_Common.Keys.PayloadSSKey().district;
		BairRx_Common.Keys.PayloadSSKey().shot_source;
		BairRx_Common.Keys.PayloadSSKey().shot_datetime;
		BairRx_Common.Keys.PayloadSSKey().shot_incident_type;
		BairRx_Common.Keys.PayloadSSKey().shot_incident_status;
		BairRx_Common.Keys.PayloadSSKey().data_provider_id;
		BairRx_Common.Keys.PayloadSSKey().data_provider_ori;
		BairRx_Common.Keys.PayloadSSKey().data_provider_name;	
	END;
	
	EXPORT SearchPayload := RECORD
		Payload;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		integer distance;
	END;	
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_shotspotter.t_BAIRShotSpotterSearchRecord) records;
	END;

	
END;
