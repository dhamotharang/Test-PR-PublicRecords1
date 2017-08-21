import data_services, ibehavior, ut;

EXPORT key_override_ibehavior := MODULE

// Any record definitions can be exported, if needed
	
	shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
	shared keyname_prefix_consumer := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::ibehavior_consumer::qa::';
	shared keyname_prefix_purchase := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::ibehavior_purchase::qa::';
	
	
// consumer record
	export consumer_rec := RECORD
	ibehavior.layout_consumer_search;
	STRING20 flag_file_id;
end;

  ds_consumer := dataset (fname_prefix + 'ibehavior_consumer', consumer_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_consumer := dataset (daily_prefix + 'ibehavior_consumer', consumer_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_consumer, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_consumer,persistent_record_id,replaceds);
  export consumer := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix_consumer + 'ffid', OPT);


//purchase record
	export purchase_rec := record
	ibehavior.layout_behavior_search;
	STRING20 flag_file_id;
end;

	ds_purchase := dataset (fname_prefix + 'ibehavior_purchase', purchase_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_purchase := dataset (daily_prefix + 'ibehavior_purchase', purchase_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_purchase, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_purchase,persistent_record_id,replaceds);
  export purchase := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix_purchase + 'ffid', OPT);

END;