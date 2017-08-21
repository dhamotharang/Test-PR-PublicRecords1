import PRTE_CSV;

export Proc_Build_PullSSN_Keys(string filedate) := function

// CSV file to read

Pullssn_ds := PRTE_CSV.Pullssn.dthor_data400__key__pullssn__ssn;

// Project to a dataset so it can be used in index action

Pullssn_recs := record
PRTE_CSV.Pullssn.rthor_data400__key__pullssn__ssn // record set of the csv file
end;

proj_ds := project(Pullssn_ds, Pullssn_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {ssn},{proj_ds}, '~prte::key::pullssn::'+filedate+'::ssn');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('PullSSNKeys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'B',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;