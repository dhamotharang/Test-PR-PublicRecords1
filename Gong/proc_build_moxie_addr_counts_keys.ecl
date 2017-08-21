	//Build Moxie Keys
			// output(choosen(Gong_v2.proc_build_moxie_keybuildprep2,1)),
			// parallel(Gong_v2.proc_build_moxie_fpos_data_key,
				// Gong_v2.proc_build_moxie_cnKeys,
				// Gong_v2.proc_build_moxie_lfmnameKeys,
				// Gong_v2.proc_build_moxie_lnKeys,
	            // Gong_v2.proc_build_moxie_pcnKeys,
				// Gong_v2.proc_build_moxie_phoneKeys,
				// Gong_v2.proc_build_moxie_phoneticKeys
				    // )
					// ,
					// Gong_v2.proc_DKCMoxieKeys)
import gong_v2;

File_HHCnts_Building_Indexes := 
	dataset(gong_v2.thor_cluster+'base::gong_hhcnts',
			{Gong.Layout_Gong_hhcnts,unsigned8 __filepos{ virtual(fileposition)}},thor,unsorted);

key_layout := record
File_HHCnts_Building_Indexes.z5;
File_HHCnts_Building_Indexes.prange;
File_HHCnts_Building_Indexes.predir;
File_HHCnts_Building_Indexes.pname;
File_HHCnts_Building_Indexes.suffix;
File_HHCnts_Building_Indexes.postdir;
File_HHCnts_Building_Indexes.count_gov;
File_HHCnts_Building_Indexes.count_gov_unlisted;
File_HHCnts_Building_Indexes.count_gov_nonpub;
File_HHCnts_Building_Indexes.count_bus;
File_HHCnts_Building_Indexes.count_bus_unlisted;
File_HHCnts_Building_Indexes.count_bus_nonpub;
File_HHCnts_Building_Indexes.count_res;
File_HHCnts_Building_Indexes.count_res_unlisted;
File_HHCnts_Building_Indexes.count_res_nonpub;
unsigned integer8 __filepos { virtual(fileposition)};
end;

d := project(File_HHCnts_Building_Indexes, transform(key_layout, self := left));

base_key_Name := Gong_v2.thor_cluster+'key::moxie::gong.hhcnts.';

mk1 := buildindex(d,{z5, prange, predir, pname, postdir,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.prange.predir.pname.postdir.key',moxie,overwrite);
mk2 := buildindex(d,{z5, prange, predir, pname, postdir, suffix,
								(big_endian unsigned8)__filepos},
								base_key_Name + 'z5.prange.predir.pname.postdir.suffix.key',moxie,overwrite);


export proc_build_moxie_addr_counts_keys := parallel(mk1,mk2);