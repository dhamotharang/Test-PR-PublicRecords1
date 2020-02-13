import data_services;
royalty_owned_layout := RECORD
  string phone;
  string num_times_used;
end;



export File_WiredAssets_Owned :=  dataset(data_services.foreign_prod + 'thor_data400::base::wa_royalty_owned', royalty_owned_layout, csv (quote(''), terminator('\r\n'), separator(','), heading(1)))(length(phone) = 10 and (unsigned) num_times_used >= 3);
