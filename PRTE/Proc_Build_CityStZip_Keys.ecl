import PRTE_CSV;

export Proc_Build_CityStZip_Keys(string filedate) := function

// CSV file to read

CityStZip_ds := PRTE_CSV.CityStZip.dthor_data400__key__citystzip__citystzip;

// Project to a dataset so it can be used in index action

CityStZip_recs := record
PRTE_CSV.CityStZip.rthor_data400__key__citystzip__citystzip // record set of the csv file
end;

proj_ds := project(CityStZip_ds,CityStZip_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {zip5},{proj_ds}, '~prte::key::citystzip::'+filedate+'::citystzip');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('CityStZipKeys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;