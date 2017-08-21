import PRTE_CSV;

export Proc_Build_PullZip_Keys(string filedate) := function

// CSV file to read

Pullzip_ds := PRTE_CSV.Pullzip.dthor_data400__key__pullzip__zip;

// Project to a dataset so it can be used in index action

Pullzip_recs := record
PRTE_CSV.Pullzip.rthor_data400__key__pullzip__zip // record set of the csv file
end;

proj_ds := project(Pullzip_ds, Pullzip_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {zip},{proj_ds}, '~prte::key::pullzip::'+filedate+'::zip');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('PullZipKeys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'B',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;