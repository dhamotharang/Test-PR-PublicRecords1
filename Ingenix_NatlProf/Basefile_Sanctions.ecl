export Basefile_Sanctions :=project(Ingenix_NatlProf.Basefile_Sanctions_DID_RecID ,
																	  transform(ingenix_natlprof.layout_sanctions_did_file, self:=left;));
					  