import lssi;

rmvs_plus_rec := record
	lssi.layout_in,
	unsigned8 __fpos { virtual (fileposition)},
end;

rmvs_plus := dataset('~thor_data400::base::lssi_remove',
                     rmvs_plus_rec, flat, opt);

rmvs_slim_rec := record
	rmvs_plus.recid,
	rmvs_plus.__fpos, 
end;

rmvs_slim := table(rmvs_plus, rmvs_slim_rec);

export key_lssi_remove := index(rmvs_slim,
                          {string16 l_recid := recid,__fpos},
					 '~thor_data400::key::lssi_remove_' + doxie.Version_SuperKey, OPT);