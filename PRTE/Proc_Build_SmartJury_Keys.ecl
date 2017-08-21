import PRTE_CSV;
export Proc_Build_SmartJury_Keys(string filedate) := function

// CSV file to read

sj_ds							:= PRTE_CSV.Smart_Jury.dthor_400__key__smart_jury__data;

// Projec to a dataset so it can be used in index action

sj_recs := record
PRTE_CSV.Smart_Jury.rthor_400__key__smart_jury__data // record set of the csv file
end;

proj_ds := project(sj_ds,sj_recs);

// index definition - determine the key fields from "view data file" of regular nonfcra
// key

	
bld_idx := index(proj_ds,
{stusab,county,tract,blkgrp},{proj_ds},
'~prte::key::smart_jury::'+filedate+'::smartjury');


return sequential(build(bld_idx			, update), // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('SmartJuryKeys',										//	Package name
																				 filedate,												//	Package version
																				 'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				));

end;