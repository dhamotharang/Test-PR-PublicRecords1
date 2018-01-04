import dnb_feinv2, Doxie, data_services;

get_recs := DNB_FEINv2.File_DNB_Fein_base_main;

slim_rec := record
	dnb_feinv2.layout_DNB_fein_base_main - case_duns_number;
    end;

slim_main := project(get_recs, slim_rec);
dist_id := distribute(slim_main, hash(TMSID));
sort_id := sort(dist_id, TMSID,local);

export 	key_dnb_fein_tmsid := index(sort_id,
                                    {TMSID},
                                    {sort_id},
                                    data_services.data_location.prefix() + 'thor_data400::key::dnbfein::TMSID_' + doxie.Version_SuperKey);