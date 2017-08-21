import PRTE_CSV;

export Proc_Build_Fips2County_Keys(string filedate) := function

// CSV file to read

Fips2county_ds := PRTE_CSV.Fips2county.dthor_data400__key__fips2county__;

// Project to a dataset so it can be used in index action

Fips2county_recs := record
PRTE_CSV.Fips2county.rthor_data400__key__fips2county__ // record set of the csv file
end;

proj_ds := project(Fips2county_ds,Fips2county_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {state_code,county_fips},{proj_ds}, '~prte::key::fips2county::'+filedate+'::fips2county');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('CountyKeys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'B',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;