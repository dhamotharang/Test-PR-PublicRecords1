import BairRx_Common,iesp;

EXPORT Layouts := MODULE

	EXPORT IDSearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_incident.t_BAIRIncidentIDSearchRecord) records;	
	END;

	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_mapincident.t_BAIRMapIncidentSearchRecord) records;
		DATASET(iesp.bair_mapincident.t_BAIRMetadata) metadata;
		DATASET(iesp.bair_mapincident.t_BAIRClusterMetadata) clustermetadata;
	END;

	EXPORT MetadataInView := RECORD		
		integer8 Records_Address;
		integer8 Records_Intersection;
		integer8 Records_Street;
		integer8 Records_InView;
		string25 Start_date;
		string25 End_date;
	END;

	EXPORT Metadata := RECORD
		BairRx_Common.Keys.DataProviderKey.data_provider_ori;
		BairRx_Common.Keys.DataProviderKey.data_provider_id;
		BairRx_Common.Keys.DataProviderKey.data_provider_name;
		BairRx_Common.Keys.DataProviderKey.records_uploaded;
		BairRx_Common.Keys.DataProviderKey.records_approved;
		BairRx_Common.Keys.DataProviderKey.flagged_records;
		BairRx_Common.Keys.DataProviderKey.geocode_google;
		BairRx_Common.Keys.DataProviderKey.geocode_provider;
		BairRx_Common.Keys.DataProviderKey.last_upload;
		BairRx_Common.Keys.DataProviderKey.uploadwarning;
		BairRx_Common.Keys.DataProviderKey.first_date;
		BairRx_Common.Keys.DataProviderKey.last_date;
		BairRx_Common.Keys.DataProviderKey.daysprovided;
		// boolean geocoded := false;
		unsigned nrecs := 1;
		MetadataInView;
	END;

	
END;