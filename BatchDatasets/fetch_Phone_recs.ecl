
IMPORT addrbest, progressive_phone, AutoStandardI;

EXPORT fetch_Phone_recs( DATASET(Layouts.batch_in) ds_batch_in, 
           progressive_phone.iParam.Batch in_mod = progressive_phone.waterfall_phones_options) := 
	FUNCTION
		
		// 1. Transform input to progressive_phone.layout_progressive_batch_in.
		data_in := PROJECT( ds_batch_in, Transforms.xfm_to_phones_batchIn(LEFT) );
		
		// 3. Get Phone records.
		Progressive_Phone.layout_progressive_phone_common
				ds_phone_recs := addrbest.Progressive_phone_common(data_in, in_mod);
		
		RETURN ds_phone_recs;
	END;