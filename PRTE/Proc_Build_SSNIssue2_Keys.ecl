import PRTE_CSV;

export Proc_Build_SSNIssue2_Keys(string filedate) := function

// CSV file to read

SSNIssue2_ds := PRTE_CSV.SSNIssue2.dthor_data400__key__ssnissue2__ssn5;

// Project to a dataset so it can be used in index action

SSNIssue2_recs := record
PRTE_CSV.SSNIssue2.rthor_data400__key__ssnissue2__ssn5; // record set of the csv file
end;

proj_ds := project(SSNIssue2_ds, SSNIssue2_recs);


// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx := index(proj_ds, {ssn5, start_serial, end_serial},{proj_ds}, '~prte::key::ssnissue2::'+filedate+'::ssn5');


return sequential(build(bld_idx, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('SSNIssue2Keys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;