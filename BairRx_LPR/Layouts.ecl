import BairRx_Common, iesp;

EXPORT Layouts := MODULE

	EXPORT Payload := RECORD
		BairRx_Common.Layouts.EID;
		BairRx_Common.Keys.PayloadLprKey().licenseplaterecordguid;
		BairRx_Common.Keys.PayloadLprKey().eventnumber;
		BairRx_Common.Keys.PayloadLprKey().capturedatetime;
		BairRx_Common.Keys.PayloadLprKey().plate;
		BairRx_Common.Keys.PayloadLprKey().platealternate;
		BairRx_Common.Keys.PayloadLprKey().confidence;
		BairRx_Common.Keys.PayloadLprKey().x_coordinate;
		BairRx_Common.Keys.PayloadLprKey().y_coordinate;
		BairRx_Common.Keys.PayloadLprKey().data_provider_id;
		BairRx_Common.Keys.PayloadLprKey().data_provider_ori;
		BairRx_Common.Keys.PayloadLprKey().data_provider_name;		
		BairRx_Common.Keys.PayloadLprKey().has_image;		
	END;

	EXPORT SearchPayload := RECORD
		Payload;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		unsigned4 distance;
	END;
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_lpr.t_BAIRLprSearchRecord) records;
	END;
END;
