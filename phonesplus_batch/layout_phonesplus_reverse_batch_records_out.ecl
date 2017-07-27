IMPORT phonesplus_batch, Royalty;

	EXPORT layout_phonesplus_reverse_batch_records_out := RECORD
		DATASET(phonesplus_batch.layout_phonesplus_reverse_string_out) Results;
		DATASET(Royalty.Layouts.RoyaltyForBatch) RoyaltySet;
	END;