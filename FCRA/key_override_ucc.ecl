import UCCV2, ut, Data_Services;

export key_override_ucc := MODULE

  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
	shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix('fcra_overrides')+'thor_data400::key::override::fcra::';

  // UCC main data
  main_rec := record
	  string20 flag_file_id;
    recordof (UCCV2.key_rmsid_main (true));
  end;

	addkeyfield_mainrec := record
		main_rec;
		string tmsidrmsid := '';
	end;

	addkeyfield_mainrec addkey_main(main_rec l) := transform
		self.tmsidrmsid := trim(l.tmsid,left,right)+trim(l.rmsid,left,right);
		self := l;
	end;

  ds_main := dataset (fname_prefix + 'ucc_main', main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	projds_main := project(ds_main,addkey_main(left));
	dailyds_main := dataset (daily_prefix + 'ucc_main', main_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	projdailyds_main := project(dailyds_main,addkey_main(left));
  kf := dedup (sort (projds_main, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,projdailyds_main,tmsidrmsid,replaceds);
  
	main_rec proj_to_main(replaceds l) := transform
		self := l;
	end;	
	
	proj_main := project(replaceds,proj_to_main(left));
	
  export main := index (proj_main, {flag_file_id}, {proj_main}, keyname_prefix + 'ucc_main::qa::ffid', OPT);


  // UCC party
  export party_rec := record
	  string20 flag_file_id;
    recordof (UCCV2.key_rmsid_party (true));
  end;

	addkeyfield_partyrec := record
		party_rec;
		string tmsidrmsid := '';
	end;

	addkeyfield_partyrec addkey_party(party_rec l) := transform
		self.tmsidrmsid := trim(l.tmsid,left,right)+trim(l.rmsid,left,right);
		self := l;
	end;
	


  ds_party := dataset (fname_prefix + 'ucc_party', party_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	projds_party := project(ds_party,addkey_party(left));
	dailyds_party := dataset (daily_prefix + 'ucc_party', party_rec, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	projdailyds_party := project(dailyds_party,addkey_party(left));
  kf := dedup (sort (projds_party, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,projdailyds_party,tmsidrmsid,replaceds);
	
	party_rec proj_to_party(replaceds l) := transform
		self := l;
	end;	
	
	proj_party := project(replaceds,proj_to_party(left));
	
  export party := index (proj_party, {flag_file_id}, {proj_party}, keyname_prefix + 'ucc_party::qa::ffid', OPT);

END;