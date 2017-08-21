import PRTE_CSV,codes,Roxiekeybuild;
export Proc_Build_CodesV3_Keys(string filedate) := function

// CSV file to read

codesv3_ds							:= PRTE_CSV.Key_Codes.dthor_data400__key__codes__codes_v3;

// Projec to a dataset so it can be used in index action

codesv3_recs := record
PRTE_CSV.Key_Codes.rthor_data400__key__codes__codes_v3 // record set of the csv file
end;

proj_ds := project(codesv3_ds,codesv3_recs);

// index definition - determine the key fields from "view data file" of regular nonfcra
// key
// bld_idx := index(proj_ds,
// {file_name,field_name,field_name2,code,long_desc},{proj_ds},
// '~prte::key::codes::'+filedate+'::codes_v3');

RoxieKeybuild.MAC_SK_BuildProcess_Local(codes.key_codes_v3,'~prte::key::codes::'+filedate+'::codes_v3','~prte::key::codes_v3',b,3,true);


return sequential(b, // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('CodesV3Keys',										//	Package name
																				 filedate,												//	Package version
																				 'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				),
				PRTE.UpdateVersion('CodesV3Keys',										//	Package name
																				 filedate,												//	Package version
																				 'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
																			 );

end;