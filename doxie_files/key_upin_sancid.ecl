Import Data_Services, Ingenix_NatlProf, doxie, Data_Services;

base_file := Ingenix_NatlProf.file_sanctions_cleaned_dided_dates(SANC_UPIN<>'');

slim_rec := record
	unsigned6 SANC_ID;
	string6 SANC_UPIN;
end;

slim_rec slim_it(base_file l) := transform
	self.SANC_ID := (unsigned6)l.SANC_ID;
	self := l;
end;

base_slim := project(base_file, slim_it(left));
base_srt := sort(base_slim, record);
base_dep := dedup(base_srt, record);

export key_upin_sancid := index(base_dep,
                                {l_upin := sanc_upin},
						  {sanc_id},
						  Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_upin_' + doxie.Version_SuperKey);