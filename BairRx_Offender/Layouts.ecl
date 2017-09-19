import BairRx_Common,iesp;

EXPORT Layouts := MODULE
	
	EXPORT Payload := RECORD(BairRx_Common.Layouts.LayoutOffender)
		BairRx_Common.Keys.PayloadOffenderKey().user_text_1;
		BairRx_Common.Keys.PayloadOffenderKey().user_text_2;
		BairRx_Common.Keys.PayloadOffenderKey().user_integer;
		BairRx_Common.Keys.PayloadOffenderKey().user_float;
		BairRx_Common.Keys.PayloadOffenderKey().user_datetime;
	END;
	
	EXPORT SearchPayload := RECORD
		Payload;
		BairRx_Common.Layouts.SortingFields;
		BairRx_Common.Layouts.CustomSortLayout;
		unsigned4 distance;
		unsigned1 accuracy;
		boolean raids_ok;
	END;	
	
	EXPORT SearchResults := RECORD
		unsigned match_count;
		DATASET(iesp.bair_offender.t_BAIROffenderSearchRecord) records;
	END;
	
	
END;
