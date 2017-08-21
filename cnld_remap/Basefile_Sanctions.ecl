import ut, ingenix_natlprof;
export Basefile_Sanctions :=dataset(ut.foreign_prod + 'thor_data400::base::ingenix_sanctions_did',
					    ingenix_natlprof.layout_sanctions_did_file, thor);