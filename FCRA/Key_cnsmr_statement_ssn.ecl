import bankruptcyv2, address, ut, data_services;

layout_ssn:= record
		unsigned8 LexID;
		string9 SSN;
		string20 fname;
		string20 lname;
		varstring cs_text;
		string20 datecreated;
end;


  fname_prefix := '~thor_data400::base::override::fcra::qa::';
	daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::';


	// full file
  ds_ssn := dataset (fname_prefix + 'consumerstatement_ssn', layout_ssn, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	// updates
	dailyds_ssn := dataset (daily_prefix + 'consumerstatement_ssn', layout_ssn, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	// sort by ssn, desc datecreated within ssn, dedup records and keep the most recent.
  kf := dedup (sort (ds_ssn, ssn, -datecreated), record, keep(1));
	// for a given ssn in daily file, if there is corresponding record in full file, then
	// replace the record in full file with the one in daily file.
	FCRA.Mac_Replace_Records(kf,dailyds_ssn,ssn,replaceds);
  export key_cnsmr_statement_ssn := index (replaceds, {ssn}, {replaceds}, keyname_prefix + 'consumerstatement::qa::ssn');