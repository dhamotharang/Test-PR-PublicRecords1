Import Data_Services, Ingenix_NatlProf, doxie, ut;

base_file := Ingenix_NatlProf.Basefile_Sanctions_Bdid(SANC_SANCST<>'' and SANC_LICNBR<>'');

slim_rec := record
	unsigned6 SANC_ID;
	string2 SANC_SANCST;	
	string12 SANC_LICNBR;	
end;

slim_rec slim_it(base_file l) := transform
	self.SANC_ID := (unsigned6)l.SANC_ID;
	self := l;
end;

base_slim := project(base_file, slim_it(left));
base_srt := sort(base_slim, record);
base_dep := dedup(base_srt, record);

export key_license_sancid := index(base_dep,
                                {SANC_SANCST, SANC_LICNBR},
						  {SANC_ID},
						  Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ingenix_sanctions_license_' + doxie.Version_SuperKey);