import Doxie, data_services;

EXPORT key_override_death_master := module
  shared fname_prefix := '~thor_data400::base::override::fcra::qa::';
  shared daily_prefix := '~thor_data400::base::override::fcra::daily::qa::';
  shared keyname_prefix := data_services.data_location.prefix() + 'thor_data400::key::override::fcra::';

//Death Master DID
  Death_rec := RECORD
    recordof (doxie.key_death_masterv2_ssa_did_fcra) - [global_sid, record_sid];
      // Header.Layout_Did_Death_MasterV2 - [global_sid, record_sid];
      // string2 src;
      // string1 GLB_flag;
      // string18 county_name := '';
    string20 flag_file_id;
  END;

  ds_did_death := dataset(fname_prefix + 'did_death',Death_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  dailyds_did_death := dataset(daily_prefix + 'did_death',Death_rec,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup(sort(ds_did_death,-flag_file_id),except flag_file_id,keep(1));
  FCRA.Mac_Replace_Records(kf,dailyds_did_death,state_death_id,replaceds);

  export did_death := index(replaceds,{flag_file_id}, {replaceds},
            keyname_prefix + 'did_death::qa::ffid',OPT);

end;
