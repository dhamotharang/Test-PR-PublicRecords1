import PRTE_CSV;

export Proc_Build_ZipByCounty_Keys(string filedate) := function

// CSV file to read

ZipByCounty_ds := PRTE_CSV.ZipbyCounty.dthor_data400__key__zipbycounty__zip;

// Project to a dataset so it can be used in index action

ZipByCounty_recs := record
PRTE_CSV.ZipbyCounty.rthor_data400__key__zipbycounty__zip // record set of the csv file
end;

proj_ds := project(ZipByCounty_ds,ZipByCounty_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {county_name, state_code},{proj_ds}, '~prte::key::zipbycounty::'+filedate+'::zip');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('ZipByCounty2Keys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'B',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;